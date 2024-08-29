Return-Path: <netdev+bounces-123237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D75964371
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C7D1F22016
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD841922E3;
	Thu, 29 Aug 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zcU2MDif"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3418DF99
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931944; cv=none; b=nWrFQAXdvTmZzny0N71rqOkFw+EDJvmO1APeSolsAAMFPpNAiT/KlbYYR7UVyJieE5XUvAW/XVwdzPNVxvY402J5wCMIVy/Ze5iHNSv6BMg8xceHV34EThD6d7hgLdV3QMk/JPCFqnEgfzw0xR+6psPs0xnNRNbDxYky2EKDvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931944; c=relaxed/simple;
	bh=Dvco0p2/DL2jgHtxgBcbNU4c2BE3nqeODfEsLpaZNl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcEyviU3dmEefaAPeBnhdvvzdXx4eQim+JlNQE8yHJUTvx6GdQM+EZepkKGsW/LVtwkrrO4DhlyQPBMHjIhqItQ4ZTTFcT+8/BVfa4XoHiWJkhxuue5S04v8Mbc5hWBhTQTHC01vcqkHB8MtST6CivO1N8CBsFRkVIuq7mWhw1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zcU2MDif; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-371b2e95c34so333828f8f.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724931934; x=1725536734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wjub60h1p6YDEMvQyIhlVd8yjpdAUfIly1o8ghalFR8=;
        b=zcU2MDifJvwt7pkLhjPrD9MkOQP2rgOvCQJBFHPLSzHyF3BdHHuzhZ1Nq7jdKdTjxG
         thwauQ0B1DqGf+yMgN+uBNhRclESbWpUHCpkaa8L3yELC1cKRwqXyNqhMy+qjr9x7Gz7
         7lWHrkbRvpcJdpUT0VjoanyovSAfvkmig7mn6rlGfD3AUEC/GsYUUpzV7M8+qlwRAkpg
         eQRBCNC9nzxj8rjrKQiEWJ4P9mNoB9OHsZ7UaqC8yvF2K3cvm0iAf12/83dXANqndeOd
         MrP25GfQURMOPjDI2ednGmok06YvXAJxOykbUqfpMk4D9JHHXZ0tfG0paWOH2NVDl6b3
         vDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931934; x=1725536734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjub60h1p6YDEMvQyIhlVd8yjpdAUfIly1o8ghalFR8=;
        b=DSrm3kl36jRBm4mlY9rAZnxSTlD0BVLJDzkOcy53K5EjavBUmSczaE64EZA9tBXRD/
         IOCjArgueHM8IHy6wi9zFVOW0WiZhXZutQB8BNGXQNQ3ygc8OChZ9dVXidPHKRASZffn
         wPjus6wDYdIWRMFKrsFw59dE9OvkmthbPM3YgFNpcdZ06RcNGEe9QhP4Jv71zB1YxQti
         b5Raz0TWQaFGFA15nd7VcU2xO6eizduHEFlC9nxzl9hZRVSY9EKdYYSRlIstG71br4UG
         XJRY/08kQvXtNEXwMv25I6OQwH99jJAcoOvjz5BgClHuAPRBXlX6o1MqKOVoplQGndSX
         kVBQ==
X-Forwarded-Encrypted: i=1; AJvYcCULRsAxdTIh87Nibre7Lp/RwF58W1INe66Kha2p+2gX3IrrHE6JMVhmb6VJMDGbxHLXS3zL7ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpBhC1HRTvHrrE713A12AGE1cOAk/7zL5oPn202Z1+BpHULjP
	GotJ9evNdGsRXLlIMRHk2ALvEuZ5v15gHAeucQBH6/HlTvewQZldAYIKTLVLLya+8dnbwRq7eLH
	N
X-Google-Smtp-Source: AGHT+IE586+a1z+FRQsrn+NGGvprz1YisJFAKL+4iwEGOTLqjq6lZAy1L25JG0COUhf7fXt6JIOknA==
X-Received: by 2002:adf:b647:0:b0:371:8cc1:2028 with SMTP id ffacd0b85a97d-3749b54901fmr1736730f8f.14.1724931934196;
        Thu, 29 Aug 2024 04:45:34 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef7ea62sm1190871f8f.76.2024.08.29.04.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:45:33 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:45:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <ZtBfW5KIJIZ4ZjcW@nanopsycho.orion>
References: <ZsxLa0Ut7bWc0OmQ@nanopsycho.orion>
 <432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
 <20240827075406.34050de2@kernel.org>
 <CAF6piCL1CyLLVSG_jM2_EWH2ESGbNX4hHv35PjQvQh5cB19BnA@mail.gmail.com>
 <20240827140351.4e0c5445@kernel.org>
 <CAF6piC+O==5JgenRHSAGGAN0BQ-PsQyRtsObyk2xcfvhi9qEGA@mail.gmail.com>
 <Zs7GTlTWDPYWts64@nanopsycho.orion>
 <061cba21-ad88-4a1e-ab37-14d42ea1adc3@redhat.com>
 <20240828133048.35768be6@kernel.org>
 <4dbb3aba-1bc8-4c16-b1fb-e379c6f4ac85@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dbb3aba-1bc8-4c16-b1fb-e379c6f4ac85@redhat.com>

Wed, Aug 28, 2024 at 11:13:04PM CEST, pabeni@redhat.com wrote:
>
>
>On 8/28/24 22:30, Jakub Kicinski wrote:
>> On Wed, 28 Aug 2024 12:55:31 +0200 Paolo Abeni wrote:
>> > - Update the NL definition to nest the ‘ifindex’ attribute under the
>> > ‘binding’ one. No mention/reference to devlink yet, so most of the
>> > documentation will be unchanged.
>> 
>> Sorry but I think that's a bad idea. Nesting attributes in netlink
>> with no semantic implications, just to "organize" attributes which
>> are somehow related just complicates the code and wastes space.
>> Netlink is not JSON.
>> 
>> Especially in this case, where we would do it for future uAPI extension
>> which I really hope we won't need, since (1) devlink already has one,
>> (2) the point of this API is to reduce the uAPI surface, not extend it,
>> (3) user requirements for devlink and netdev config are different.
>
>FTR I was no more than 60" from posting the new revision including that when
>I read that. I hope Jiri would agree...

Sure.

>
>Well, I guess I have to roll-back a lot of changes... Not sure if I'll be
>able to post tomorrow evening my time...
>
>/P
>
>

