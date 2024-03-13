Return-Path: <netdev+bounces-79696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B687A9DA
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 15:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70F8B220EE
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD65541A80;
	Wed, 13 Mar 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2Kc9LZRU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CE44C89
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341905; cv=none; b=AMI13YWt9OBnapE8+Mde8yM/0a9GBkx8jXXyoCjOhXdNeTM9Gy4pPnVt8BuwvTzi77SXDnu2zMsugz75ZctDRkm/KaETawIHHUAGBWDL5apV4C71LQPP6NJiEMPyr5lVdQF2xjbFXBd59ziRbX95/eKqucHX95ZYOtIdNRqvQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341905; c=relaxed/simple;
	bh=GgJY2f36QFpA/bGnR2P9wi272BBKOQ9hBOj1eUA3rO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbRN86L8igLZIVy3Wj/XIA0IkeG/NkOEGlLEwTk6iS4hFIcXRVJPek8HfiZ9xgAPK3/4suwxu6flgPUc8fSrsoRWo3YfXT39SW3T2fZiSJByUwFF/+rp4uNWddF7Dv1ndvX/fCfP1Rs6bctJVRMSHA856M6hdNqz7OHUQqoMnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2Kc9LZRU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4649c6f040so220284466b.0
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710341901; x=1710946701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xAZef3xoKTa9T2CrWW8d5sgAioeZvbVQOhdTSusp9vs=;
        b=2Kc9LZRUQgmGNZUim7rkPJO4SLyX4PB64gXVZXoWMjvq2eskHXQutLfJJgTDTJ36ma
         3efGnMhNVMMrK0JZBsWZrtO9q9DCDSdvTNwcdONZozGG3Vyp240AuHmCNx0DF32/o9LU
         pIw47JKAgJbibS7SQlK+hcht395KGsKeSIDSDHJ3tYTeslIy/uovJffNJP4CwZbtjdHH
         H+u8w7At4F0GjZbPcQTMBNhUNxHRtAGb8DVlcdSp7pMem9+7/zXYOaRn7qN5qgYpw79q
         0E422GD6yr8wF6i1Ysae8h7Ip+StCfJUw9ZtSP7Iia59ooYzOUn5C++wwvRQdDAVFtxJ
         Q13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710341901; x=1710946701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAZef3xoKTa9T2CrWW8d5sgAioeZvbVQOhdTSusp9vs=;
        b=SxoapSs/3ZkpnRS8M00o7O8RMu6v2gWF7t0zKf2LTn/MaTYSDmkcYwSjLHX93BbBU2
         TwjeEjOwj7LG2RDYuTDV2Z9jChGio6YfUB09iJLrZIktQYvYKPyEp8cA0t2C2jcyMPpN
         L4dm/qY+cZHW3TQ6dr9M08hDWvyNewJMsG7Dkhq/iOm1NcIojVEawB4k8p9waj3FVLvD
         E4Ic0YcyPjnYIwmBXsVPvlHNBd9JBEnGGPp6pNaRk5Mrbgz2O9IIQQVVUKl0xetg0zxY
         JhvUY0PwMyiWursQPEU/HMd/zwl6cyn8Yvdx/ZGIfsvCzV5mWt6aXmmKwEgEd5EeMG0Y
         RYAA==
X-Gm-Message-State: AOJu0YyedmxA2LkX02wIX/hmyVnZu6+tdeeC4LaloEipyBvVpijKrilt
	f15cU+f9ouAprjfe1bs6psI4IlJjmU40CsKlpMos5eqjshyXrIZfTzDHm1oAfjA=
X-Google-Smtp-Source: AGHT+IGfo66ZjTVCec9L0ghnJS8EiAbFOifIo+sSYalO5lJNRRZY3Hg1mAEO24Im8oXdI9qV+JuFig==
X-Received: by 2002:a17:907:c30e:b0:a46:4ff9:f845 with SMTP id tl14-20020a170907c30e00b00a464ff9f845mr2201519ejc.14.1710341900916;
        Wed, 13 Mar 2024 07:58:20 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906468600b00a465277df7bsm856261ejr.181.2024.03.13.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:58:19 -0700 (PDT)
Date: Wed, 13 Mar 2024 15:58:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev
Subject: Re: [patch net-next] dpll: spec: use proper enum for pin
 capabilities attribute
Message-ID: <ZfG_C6wi4EeBj9l3@nanopsycho>
References: <20240306120739.1447621-1-jiri@resnulli.us>
 <ZeiK7gDRUZYA8378@nanopsycho>
 <20240306073419.4557bd37@kernel.org>
 <20240313072608.1dc45382@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313072608.1dc45382@kernel.org>

Wed, Mar 13, 2024 at 03:26:08PM CET, kuba@kernel.org wrote:
>On Wed, 6 Mar 2024 07:34:19 -0800 Jakub Kicinski wrote:
>> > Note that netdev/cc_maintainers fails as I didn't cc michal.michalik@intel.com
>> > on purpose, as the address bounces.
>> > 
>> > Btw, do we have a way to ignore such ccs? .get_maintainer.ignore looks
>> > like a good candidate, but is it okay to put closed emails there?  
>> 
>> Oh, great, I wasn't aware of this.
>> 
>> I think I have his private email, let me follow up off list and either
>> put his @intel.com address in the mailmap or the ignore list.
>
>Hi Jiri! Do you still want to add him to the ignore list?

If we are going to start to use .get_maintainer.ignore for this purpose,
yes please. Should I send the patch? net-next is closed anyway...


