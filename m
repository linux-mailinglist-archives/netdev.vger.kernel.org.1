Return-Path: <netdev+bounces-114624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F799433CD
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10DC5B20FD5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20511CAA9;
	Wed, 31 Jul 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Z6969GYG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8D12E7E
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441840; cv=none; b=RIZEYUfstjNJ4lv8yQalk7FYiLQMRq3a8Ll5aldy1xTbW25g3Z10cZiuR86SofFlZVzoMKoCQRHovhcQHeWtQv33jgzZVkoZ/t2fjB7h52GvwKHdDW8MMvR0bBpla0Xo8pe9U46vGRJU6rpnM2ofAGbBieWFRZT8gI+ndvINGUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441840; c=relaxed/simple;
	bh=mnnFeJSJYUHSF7Cr5l+DeP57qS4iMeG1IrLkidXDnlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llNePihCced4yedq4gLthHtLaAdI6q/zoL7LjB+hsNS/PBj+C8Q0uUg3guV1hB8W/JUURuOYKNaejkjkLJv8jawREJXgEe0/SdG6dSIAb85bGpH5BonfbA4zTiPTcQYOACBjUo9ogzqPa3qoQiV9tP+GSicUbFvoSbB5/SHOLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Z6969GYG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so2903323f8f.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722441836; x=1723046636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu5VKzyY1XYJFX5CxjBVK24Af9caOLdJGXUfX/N+bvI=;
        b=Z6969GYGBGXf7WoANmq4zH2T9ETA/1zCjbqksG7zU26AELcxGH1EIsmFGF6ed7QrDo
         zuS4FA4Rb02Q3yQn7+Tx34BHUPYFSLDCMfTpvk5v67xw99U6BUHjNJlCwa+wSI/nASMB
         BVGOyPLcLzXjoS3lik71OQ3P9wKzHI7a8QHoYR/jpEEGmkh+raZzHjmbo6am2maH8mx6
         B7QlsdqElTvpEmgKnEOA7PhU2DPSZJPZEeNr51OVNCkiIHXv/sW79TuyDzac6PLb6EPZ
         P/dbQTnI3mRBsbkq2Y0lyAWiVoFTiO+Zx9dgvkNGIbzCJop7NQ0PucZ5ZIB0G1ZH3Doa
         vX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722441836; x=1723046636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu5VKzyY1XYJFX5CxjBVK24Af9caOLdJGXUfX/N+bvI=;
        b=ulVi0hDBtTUjpHxP8wwt0LGYlBSFpn/4SThLQvjPlLI/LbT5aFKFXI5ZffOXSh1hMI
         ai6Fyo/KU1xH3OhB/9JYxlDgUZk9QcBq96hZmGZ4rod3OzapdePsz4vvWnWURlANudE1
         NEfFE67fNWzwtAHMDq05tIW6H3A9t6XC5gVZlAhxRa5NhOxnKQqtyFNxTCikHj21WNx4
         44vKuc4Vx78vjgiqqci/UIoknZb8IE9CbXdM/nCXwml6ERN1E6O49SOUfqLl/AsylcU/
         Y8DP91uPunScOwZCF2UF9dLfgkz47nxVv2pJYJhsezg13+KP5pax2NL3jYjCxO0uyDwk
         L63g==
X-Gm-Message-State: AOJu0Ywbl1ZoVGg0uaOEkodYaayDFyjuBxaZ9XnISRAQWfn9CZM3kWpz
	WCd5pLg7tCkZGe57Xbm/hah4AmFiri045oI/g9TRNdXy+Pi0q/vBhL0uMdCZV+E=
X-Google-Smtp-Source: AGHT+IF/abVk2uqhvsMqo1QzhwGdIT+W+jZnyD3LBXNapS+Jqr9LpZLnr5QNS0XpZvR69nCR8LFC6g==
X-Received: by 2002:adf:ce89:0:b0:367:9625:bd06 with SMTP id ffacd0b85a97d-36b5d073fbcmr9123928f8f.42.1722441836180;
        Wed, 31 Jul 2024 09:03:56 -0700 (PDT)
Received: from localhost ([213.235.133.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857f6bsm17327869f8f.76.2024.07.31.09.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:03:55 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:03:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <ZqpgaUlM5MQKTOwR@nanopsycho.orion>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
 <ZqjaEyV-YeAH-87D@nanopsycho.orion>
 <b6512bf1-5343-4130-a962-db2617a85fda@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6512bf1-5343-4130-a962-db2617a85fda@redhat.com>

Tue, Jul 30, 2024 at 03:34:24PM CEST, pabeni@redhat.com wrote:
>Hi,
>
>On 7/30/24 14:18, Jiri Pirko wrote:
>> Wed, May 08, 2024 at 10:20:51PM CEST, pabeni@redhat.com wrote:
>> 
>> > + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
>> 
>> This is interesting. Do you mean you can put a shaper on a specific VF
>> queue from hypervisor? I was thinking about it recently, I have some
>> concerns.
>> 
>> In general a nic user expects all queues to behave in the same way,
>> unless he does some sort of configuration (dcb for example).
>> VF (the VM side) is not different, it's also a nic.
>> 
>> If you allow the hypervisor to configure shapers on specifig VF queues,
>> you are breaking VM's user expectation. He did not configure any
>> different queue treating, yet they are treated differently.
>> 
>> Is that okay? What do you think?
>
>I'm unsure why you are looking to this old version...
>
>The idea to allow configuring the VF's queues from the hypervisor has been
>removed from the most recent version, for roughly the same reasons you
>mention above.

Okay. Thanks!

>
>Cheers,
>
>Paolo
>
>

