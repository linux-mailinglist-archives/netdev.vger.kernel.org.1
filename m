Return-Path: <netdev+bounces-138171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE29AC7DA
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C893D2881D4
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C511AA7AB;
	Wed, 23 Oct 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHaqXIz8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6A1A706A
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679100; cv=none; b=TiA2cwvsOIFwm9/m5D24br0gt5cUDJMrfn8hOq5CecAR30fwaezKbMAEur64G2HaA5x33nLYKjPJnGPyZaM+WYNLfMAgqr3pGc5iD4vMBaCPBWxxkbXjUA868V114z7v33zKIqQpTPY3zrYMLsbO/gXhqyj5Uxy68+8tPpw2j/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679100; c=relaxed/simple;
	bh=k49ZGlyiA0j3Fu5pMwMRotHhPcUNZDxTPm3L52UTwQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g97h+yDg3IJebQ0oSAeGC7a42cAewcXeBlCpTyg7Xd3/XurO4OkYvRxgU3cG5jo6BHIN/naps6tNJePfwYTSbvA3fIROllXSdtik/nr0csGIMYWYEVXasCZl8vUSuaZ651+j6MBlDuCxQeupLJUfWd8VMBrWWRFqufDCUfqPzXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHaqXIz8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729679098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ0c2dEzDIk5QuFvom+oRBbExNqzHs5278qNaQBQGog=;
	b=CHaqXIz8JaymhdvzABScJMuzw2d5VJ0s8L87D/yL9YT8BnUyLJdeNiLBTG3q9v93Oyt3X5
	WILSHwJHenOQzjAldEtDhVTxQaTiNt9wBn2bCZ3IJwSEeuWMRTTfNCKGOmGvqaXHgr5b7w
	dfy/Qj1X8P93tJFqr1hqORZeqAZlKu4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116--1qZKjx_MaqyZ086TnqZ7A-1; Wed, 23 Oct 2024 06:24:57 -0400
X-MC-Unique: -1qZKjx_MaqyZ086TnqZ7A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso53467135e9.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 03:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679096; x=1730283896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ0c2dEzDIk5QuFvom+oRBbExNqzHs5278qNaQBQGog=;
        b=uj/YoUno8HP3akDy+cfiYFFy/EtIb0DJQwziJUamve3DsLLLUgmrUx6/POdBa25MPC
         lIjzsrsPB4kJ2B0HAAj1C3WhGIDZYKQw5DL8uXeSmb1vQI+MoH+AAESMDm5eS5l8GvtW
         TXgW+WZiT/qgn1gfSp9wBkxw01qklAgMjfpoc6SVVLbPE12MsPoOF4gevQxQHEJZLcmf
         OvD70IXR49/ObMsAvgR62tlID/kdzk9rLTYsp5uWp0NFI8zEykDIm8HVdQGUa+TN8SKq
         QUGrfi2oMyOe6a+O2r4XZOtCAhOUL9wwVd3Ho4vAf+/xZITs8N2QXt6XxmPJVieeAPH3
         nF5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRtpeUjjSid94YjDnDVu2Oyp9awiCSVDZ9mJWHJV8Jx0j/H8SMOIoUk8rAULkDUQ4GX4avLOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1/63G/UJxaJx8OH4YM2hRX3IWaiNuEt43vFSymjv771Pp4/p
	dd+LLqMuEjZX4H0mdOtlKlWOmnWmsg072OWKTHesiq1FeUkQlsTKulsb8fycTUSpXgDEk7fRtCs
	ySsOXloL506IIAozLojlc2ry+cCDYYswSFTBNY7XNY9b9kXwnl6Qm+w==
X-Received: by 2002:a05:600c:45c3:b0:431:7ca6:57b1 with SMTP id 5b1f17b1804b1-431841a3bdamr20749905e9.32.1729679095877;
        Wed, 23 Oct 2024 03:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgaddpV20+zq9AAgbOKbUJHO+Em/0bOu4SO+Vf7d2/Qgfstx4yc1QX/iLABUzFVmH2vFnk5w==
X-Received: by 2002:a05:600c:45c3:b0:431:7ca6:57b1 with SMTP id 5b1f17b1804b1-431841a3bdamr20749725e9.32.1729679095527;
        Wed, 23 Oct 2024 03:24:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bdeb4asm12256925e9.15.2024.10.23.03.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 03:24:55 -0700 (PDT)
Message-ID: <fc2fe2b6-34a6-42b2-a6de-a5db26edb44a@redhat.com>
Date: Wed, 23 Oct 2024 12:24:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6 07/10] ip6mr: Lock RCU before ip6mr_get_table()
 call in ip6_mroute_setsockopt()
To: Florian Westphal <fw@strlen.de>, Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
 <20241017174109.85717-8-stefan.wiehler@nokia.com>
 <20241017182843.GD25857@breakpoint.cc>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241017182843.GD25857@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 20:28, Florian Westphal wrote:
> Stefan Wiehler <stefan.wiehler@nokia.com> wrote:
>>  	case MRT6_ADD_MIF:
>> -		if (optlen < sizeof(vif))
>> -			return -EINVAL;
>> -		if (copy_from_sockptr(&vif, optval, sizeof(vif)))
>> -			return -EFAULT;
>> -		if (vif.mif6c_mifi >= MAXMIFS)
>> -			return -ENFILE;
>> +		if (vif.mif6c_mifi >= MAXMIFS) {
>> +			ret = -ENFILE;
>> +			goto out;
>> +		}
>>  		rtnl_lock();
> 
> Same, sleeping function called in rcu read side section.
> 
> Maybe its time to add refcount_t to struct mr_table?

FTR, I agree using a refcount could be a better approach (and would
avoid keeping the RCU lock held across seq start/stop which sounds
dangerous, too.

@Stefan: in any case before your next submission, please have test run
with a debug build, so that the run-time checker could catch similar issue.

Side minor nit: your  'Fixes' tag should come before your Sob in the tag
area.

Cheers,

Paolo


