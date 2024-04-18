Return-Path: <netdev+bounces-89169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A58A996E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2591C21CB5
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3915F330;
	Thu, 18 Apr 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LvFeZucW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7C15FA96
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441723; cv=none; b=aLKKXjgAFnxEX+wi/FsVXQAj5Iy4jFySI9fBfKkA0DM1XtAyaFqvBY/1af79Hdeff3P12IZVOz2FDgkFxQyHV3W7hrrzQCah4AZM9Ua2yLRqArJiYANorEZERZ/2VNZgqMo5Hl7i/aXTBRc9r+cEhlOekGoU+6DPqZxAhcqed2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441723; c=relaxed/simple;
	bh=WDTS0GooOj5OV5uzWzScXA+6NBbMaCXQC76UKuCef2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIGALHqk3Cse0XPmltj9NKK1AvyvFd3jsLPf1KvvP4FUYxw7Ct5vBtvhrXXAN7Rls/H16r/n6FjdD/0AbboIwYX9jx424vBpBuViVM0F0sF7LAKAKLjrzra7I91OGXLbaYSQNHfoNFyS+7ZdulTSbjPTESZd2KB7WCAeyz03YHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LvFeZucW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4702457ccbso76400766b.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713441720; x=1714046520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDTS0GooOj5OV5uzWzScXA+6NBbMaCXQC76UKuCef2c=;
        b=LvFeZucW8hkmXc8DeS6pGuLE5ASeBHlCRgmuV8ne4hsfOCueKdmh84T9bqVYFliZKX
         PVi4RXOtvVesTM5es3he7Qvq72NjSca69zgCXbo19/mB+kDf90OKi9T4yLJwx3jfYJIA
         q8qoLekMNUh0KMNxqn11M+UbSbwudrQcOeH/jzy/XwU+12XiSfbY7+MV2kEp2hJAGAC3
         fWBy4/hLO37VeTmr9AkZnHh0mfQjINb8GPgozWERQSu1g41kQ4QncfdK3cYAsgk/qOQh
         JTtyRYvZxE0FGcfPfKvJTi47O3B/ZnuFhONs2pL47iO7OpCLRwtc89oqzRTjZS9jpvUE
         b0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441720; x=1714046520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDTS0GooOj5OV5uzWzScXA+6NBbMaCXQC76UKuCef2c=;
        b=CcEhcaInOHPYA6tVZAACdrshV0khocQSLW7gSZRNK3pEm4i+ouSvmFTeVdrOB7QPZA
         myZ1ChsE/t1yVaR90rDfQzqMxONxl+lC4elgsBX4/EcZe5573gnawTHVvYMQyCdJl4wS
         YmHu0z8TNm1+980+IUN6ujno4X+5HkZIeDNUPPOQ1p3TONolU/dKnBDxJBMOf43VSj3Y
         FirFLneLmZxhYPKRjbiSWWBpTOs82oVoMjoj1ec4KwhZLTfmHcpqUDXpYWZlgyDCdMtI
         ylPZlusPNl7Vgw3ZRjxKrXib3WewPa0SSxyhZkovZiMo8SCs2ZNU0cpqYXx/u8pzdDjl
         gwJA==
X-Gm-Message-State: AOJu0YyoX4V2NU7ABmkAV18OwyOH/v2endUuEETkANBdfO8PxS2FznIk
	oW2UR2UKj4qhb1tQ3XAtYZlDS7+eUnrV3AHYGC4GvT6yvswPFiGLqUQ6F9QejAg=
X-Google-Smtp-Source: AGHT+IFlNDz44BkHg1rOH/EgiI1G+yXTSCX8l4K31Xu5gDP2OpWVLm1QB8kJOtGgdAyvQ6WRH+fr4g==
X-Received: by 2002:a17:906:f0c8:b0:a4e:3fad:b973 with SMTP id dk8-20020a170906f0c800b00a4e3fadb973mr1493115ejb.65.1713441720189;
        Thu, 18 Apr 2024 05:02:00 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906a29500b00a526a992d82sm795799ejz.4.2024.04.18.05.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:01:59 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:01:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <ZiELtgonxSFIfX5H@nanopsycho>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-4-jiri@resnulli.us>
 <87bk67cbuc.fsf@nvidia.com>
 <87y19bawl2.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y19bawl2.fsf@nvidia.com>

Thu, Apr 18, 2024 at 10:43:44AM CEST, petrm@nvidia.com wrote:
>
>Petr Machata <petrm@nvidia.com> writes:
>
>> Jiri Pirko <jiri@resnulli.us> writes:
>>
>>> +# Whether to find netdevice according to the specified driver.
>>> +: "${NETIF_FIND_DRIVER:=}"
>>
>> This would be better placed up there in the Topology description
>> section. Together with NETIFS and NETIF_NO_CABLE, as it concerns
>> specification of which interfaces to use.
>
>Oh never mind, it's not something a user should configure, but rather a
>test API.

Yep.


