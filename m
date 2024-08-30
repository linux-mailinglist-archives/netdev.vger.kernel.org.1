Return-Path: <netdev+bounces-123743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55689665E7
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1317B1C237F1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6272D1A4B6C;
	Fri, 30 Aug 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YG0tGCU9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D161C687
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032597; cv=none; b=sD9sGH5dmNFDjxtfXSr9bdUMOxhw0lhwfK3ELDo7MNQMoXhGM1+MhkvdBqUiu/LUQIVejB5WpsnaBf5GmoYtlTTWHa10E9Dwlc33Rrvgsrxt/VMvHuomzudAv1/jU2L9PskacPcZKnivPNyq2AaOE2cFfIRyBdzj7leH5RVhVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032597; c=relaxed/simple;
	bh=4cv6dmkkLOXC+axOO1db5NuiNg+lf6tn3agOKtB+Jdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABnisphHx1rd4RSKfIGHS+OVXg6u4j0bcHOq7Lzc15mEf6D6JbtXl9yeCj2cPNU9dPXRk0RbqLCTkj0goeAAyOuQL3sMTjaXYW+yMx0Sg0rDxqS4K6thg2mFo8se3hs/WPgrdutqleb94gBdQKA5/G8E/Bejq6SR78B5ZAUuYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YG0tGCU9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725032594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+c2Mcv6lNyf39r9YFvIvhdBG3KouOjQubtsFSPnlX9I=;
	b=YG0tGCU9w+QuoW78yufO7mXVozcYC/zKl8H5v23ogjBq2nCg0WY92YQmPbOWDks+tLSi7b
	e3eMigsrdjgfj9/xsqSGuYd60Eedy0W+yeaY4iRTrPbFS4mUjCXlAOYYQMh4YvQ3JHRbg1
	jdp3xk6xd9I/bNaUEsGZHE7Cb5eQ0Dg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-7u8jHWefN9W6tz8e0yI0Mg-1; Fri, 30 Aug 2024 11:43:13 -0400
X-MC-Unique: 7u8jHWefN9W6tz8e0yI0Mg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb7178d05so17547475e9.1
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 08:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032592; x=1725637392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+c2Mcv6lNyf39r9YFvIvhdBG3KouOjQubtsFSPnlX9I=;
        b=KS++0ydJiwmCVNfYHiS14Jwe54BVWTWeTLBwV5u1ORYO6P1LUIRKVbrHuO6QMg0lDx
         cSa4+PCeYMmpVSxJqYZXMj4l0op+ZMxUM/RLN60BEBhB3FYl3qhyayjk5i2yz2m5SfaY
         BKSHdVh9ZwagGbg9SlMf0Dw2OGOjW7KvCntEsSa3agTD5NtDnvY1VfEUmUxtc+JFYRx8
         ghT9jKR4QjXIdgZbuK1A5JrBJo9toeyl5fCCBOpe0+BPVcu1ba2PWIh33eKssClhhVfC
         KBiBHPIIGOYkLWUl4HMQXZrJUbO35PAGDYbpwYa8GF/zqod3Xt2t2BnbyeJ2L/VhDhs+
         6C7w==
X-Gm-Message-State: AOJu0Yydv3VEgM3lryDUuw+h5BVjMXlWr6cldYWA+Q5fnUaPzkhxcMM5
	4G5x0yONZ/mmNmgyOkMmYbbHhx5sErNHnspfhNx527TK7ssKjBAh8wSG6S70SbtUr/q6M0zgn4C
	ZyZnfxOg7lqSg8UFJfkoMUTW569zRHLSYzfyiR6f+Jy8oyn9wCFH28w==
X-Received: by 2002:a05:600c:3b19:b0:426:6667:5c42 with SMTP id 5b1f17b1804b1-42bd731edeamr589295e9.4.1725032591777;
        Fri, 30 Aug 2024 08:43:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+5b3yeLAvMuXMTi/7WNTy+1AtXMKxxPKQ5h/HYeL0n+nIYvZSBg8CKZsoUSTOx3PZMD4tlQ==
X-Received: by 2002:a05:600c:3b19:b0:426:6667:5c42 with SMTP id 5b1f17b1804b1-42bd731edeamr589165e9.4.1725032591257;
        Fri, 30 Aug 2024 08:43:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b53:e610::f71? ([2a0d:3344:1b53:e610::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef812b2sm4387973f8f.75.2024.08.30.08.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 08:43:10 -0700 (PDT)
Message-ID: <58730142-2064-46cb-bc84-0060ea73c4a0@redhat.com>
Date: Fri, 30 Aug 2024 17:43:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 02/12] net-shapers: implement NL get operation
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter
 <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com
References: <cover.1724944116.git.pabeni@redhat.com>
 <53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
 <20240829182019.105962f6@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240829182019.105962f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Please allow me to put a few high level questions together, to both 
underline them as most critical, and keep the thread focused.

On 8/30/24 03:20, Jakub Kicinski wrote:
 > This 'binding' has the same meaning as 'binding' in TCP ZC? :(

I hope we can agree that good naming is difficult. I thought we agreed 
on such naming in the past week’s discussion. The term 'binding' is 
already used in the networking stack in many places to identify 
different things (i.e. device tree, socket, netfilter.. ). The name 
prefix avoids any ambiguity and I think this a good name, but if you 
have any better suggestions, this change should be trivial.

[about per device shaper lock]
 > I've been wondering if we shouldn't move this lock
 > directly into net_device and combine it with the RSS lock.
 > Create a "per-netdev" lock, instead of having multiple disparate
 > mutexes which are hard to allocate?

The above looks like a quite unrelated refactor and one I think it will 
not be worthy. The complexity of locking code in this series is very 
limited, and self-encapsulated. Different locks for different things 
increases scalability. Possibly we will not see much contention on the 
same device, but some years ago we did not think there would be much 
contention on RTNL...

Additionally, if we use a per _network device_ lock, future expansion of 
the core to support devlink objects will be more difficult.

[about separate handle from shaper_info arguments]
 > Wouldn't it be convenient to store the handle in the "info"
 > object? AFAIU the handle is forever for an info, so no risk of it
 > being out of sync…

Was that way a couple of iterations ago. Jiri explicitly asked for the 
separation, I asked for confirmation and nobody objected.

Which if the 2 options is acceptable from both of you?

[about queue limit and channel reconf]
 > we probably want to trim the queue shapers on channel reconfig,
 > then, too? :(

what about exposing to the drivers an helper alike:

	net_shaper_notify_delete(binding, handle);

that tells the core the shaper at the given handle just went away in the 
H/W? The driver will call it in the queue deletion helper, and such 
helper could be later on used more generically, i.e. for vf/devlink port 
deletion.

[about capabilities support]
 > It's not just for introspection, it's also for the core to do
 > error checking.

Actually, in the previous discussions it was never mentioned to use 
capabilities to fully centralize the error checking.

This really looks like another feature, and can easily be added in a 
second time (say, a follow-up series), with no functionality loss.

I (or anybody else) can’t keep adding new features at every iteration. 
At some point we need to draw a line, and we should agree that the scope 
of this activity has already expanded a lot in the past year. I would 
like to draw such a line here.

Thanks,

Paolo


