Return-Path: <netdev+bounces-113688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EE393F930
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A06283446
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3915665D;
	Mon, 29 Jul 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1oCJpmvJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2D15624C
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266045; cv=none; b=L62193IBjH9wFwWXPguV4ESaqzi0wgk7aTOFL/Aolz1fnJnVKzmQQqCVd0+44Fae40JkeJPPAP5RUPohiwzdaUheIWB6A0ntSYc1mN4/7tOkNhlJHds5Ou9vDaCz2ZMbZaXpDaHz/aQaD5HUIcsD9Ech1TQ3csWQHOKWs1KZPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266045; c=relaxed/simple;
	bh=Wj/HBk38AI1LI1rGEwQuASszNUxSeVY8ITI7IVOhwHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh+DXSUsVB33rtVIZUZ+v+Hy+B0jrzS8wZxtkfR18NYKOphQLc2mITwef0SsQKxbBOGd+vD5C+Ltcx5txgC1rW0TIQnCXN5cS2th1BlkDWCLOSWqcXDMCqiizTw8hy5p7QRrPxUZnVULRqB+hnP7YXmrN9DOIQ1UGxGuljhQrBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1oCJpmvJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36887ca3da2so1436030f8f.2
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722266041; x=1722870841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YMlF1kGzKRmjVmDumuqn5IuuMyWVgoeKitUlWaS2CU=;
        b=1oCJpmvJItWRl/v6CofM1BxFXxVTrYCfpr2EHklc1OdbB4Rnk8HoFUIFCMUWFKq8LL
         SO8gAHi+7SueWJVgkI2Hf9hc9EPVlu+AB2/fXJKCnDvNxEKRMcVJH0p82n2tbIf8UeVh
         9F7BNlD+jdoBSHmDBUZ7K99qB7mY7S7ny3fdzJQi/0cKMixUs1+Ti4uO2gpBQl3OHZ+/
         2xHBvgPZJwdcm7qYC/LB5P2ukjcO/ft60I/BNRWjbS955WuQYPz1/frcFE5Hv/OpheJh
         ekBKda4IP6939o7B2DrzlQBZ0sikc577hcC9pWK+WLQEC2Q1rmS0/459nTyE/sGRh9jC
         kJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266041; x=1722870841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YMlF1kGzKRmjVmDumuqn5IuuMyWVgoeKitUlWaS2CU=;
        b=JxxT9E14zYrA4AbZ7G4sQRxgNBmKM3havWfpLOqiwwB/3ATo+ovnCHKC6j6Wdy/ifI
         nuAQkFqZ57NISWlUrdB1NXsPvPfvJ0LnlkBmSWsMggbpfVCdzgfWVPO4/4sp8KkdMR6f
         kLWzz5fDVHo0qg/d/LChO4dnyW0G7MU+DZo1kMTcYBXD0ZeTGXpEhkzo+wSg/CGU3HIl
         OlgScZNIW5hCUR2Vq9Ul7itMq0zF+bZ9mq94q7YpTjP4PKXiMKQ+cBugxbyBqZxw5f28
         DM4J95FeAOS4RX25I4bpiY4nG2+th26mtGzu1LG5V3JNLTjWZbVX9XdPBGPv1BTspVAR
         7WBQ==
X-Gm-Message-State: AOJu0Ywnq4Hfii99qeRE2AjIpOnrFJjJhDjp7HOy0e9iNwQrk+IPd1Pu
	1cY+cn9gOa3/GiF3MN5Zp5MesVEYBYqn8P1/blHDImgBZxoVHqeQUyeT3ra6hsA=
X-Google-Smtp-Source: AGHT+IF94D0EVml4fAPxGE/YfMsc85ByOSaMAylLuqJ/dlgtieWfyFwb/rCZ3u/G3oOOhG4vQvL23g==
X-Received: by 2002:a5d:590d:0:b0:367:96a8:d94b with SMTP id ffacd0b85a97d-36b5d0b7d91mr4603294f8f.57.1722266040717;
        Mon, 29 Jul 2024 08:14:00 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b2c2sm179523415e9.28.2024.07.29.08.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:14:00 -0700 (PDT)
Date: Mon, 29 Jul 2024 17:13:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH RFC v2 00/11] net: introduce TX shaping H/W offload API
Message-ID: <ZqextLo-OUq_XLzw@nanopsycho.orion>
References: <cover.1721851988.git.pabeni@redhat.com>
 <Zqc3Gx8f1pwBOBKp@nanopsycho.orion>
 <5fb64fb5-df6d-409f-b6c6-7930678df9d2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fb64fb5-df6d-409f-b6c6-7930678df9d2@redhat.com>

Mon, Jul 29, 2024 at 04:42:19PM CEST, pabeni@redhat.com wrote:
>On 7/29/24 08:30, Jiri Pirko wrote:
>>  From what I understand, and please correct me if I'm wrong, this
>> patchset is about HW shaper configuration. Basically it provides new UAPI
>> to configure the HW shaper. So Why you say "offload"? I don't see
>> anything being offloaded here.
>
>The offload part comes from the initial, very old tentative solution. I guess
>we can change the title to "net: introduce TX H/W shaping API"
>
>> Also, from the previous discussions, I gained impression that the goal
>> of this work is to replace multiple driver apis for the shaper and
>> consolidate it under new one. I don't see anything like this in this
>> patchset. Do you plan it as a follow-up? Do you have RFC for that step
>> as well?
>
>The general idea is, with time, to leverage this API to replace others H/W
>shaping related in-kernel interfaces.
>
>At least ndo_set_tx_maxrate() should be quite straight-forward, after that
>the relevant device drivers have implemented (very limited) support for this
>API.

Could you try to draft at least one example per each user? I mean, this
is likely to be the tricky part of this work, would be great to make
that click from very beginning.


>
>The latter will need some effort from the drivers' owners.


Let me know what you need exactly. Will try to do my best to help.

Thanks!

>
>Thanks,
>
>Paolo
>

