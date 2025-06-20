Return-Path: <netdev+bounces-199668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF750AE159E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750FD188BBE0
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4923183F;
	Fri, 20 Jun 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="fcOqedkg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902C229B07
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407271; cv=none; b=SEU6njhbZyf4imGBl3hgBCrmttpkAI5X0THVV84y12UL+B/5AWonFKtkA7oJOLH+pgFB1eUPHiI7eTFwOczI6gGxaNsXzXJ4rvV0cvRJ1G0jRIj8BTAeZRNyo8Nfr0EoUgC9RtD7H5Cv2W+EtTVCv4PetyBjGqdYpqGbJTjWPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407271; c=relaxed/simple;
	bh=273c0nvyKmYMBOk2rmjnSRb8UQjDJrKbbOPTus90J60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfMF7gwNmoVxrYF2wbWAtkRlGcVQcqLIs0FWtoSW2O8Si5sLMwBUCwCQaIKnPOTwfRDLKxduHl/sfqpXTBz+MmnNyx0bOzgaZj6KgU7u/BQgFeP2bBusSh43T9UcyDqO3Zw2q1zzVxg8hvsoikmSv2EYTIljDrXdZUv+DweNWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=fcOqedkg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4e749d7b2so316572f8f.0
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1750407267; x=1751012067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4rvdjsAVQZXv/T6sfLTI6KAH2htjv4Mc2dhR9BtJmkI=;
        b=fcOqedkgzfvaMfQPVw/sDGoVgQ+BUhpcpokfZZJQNpFNz51xBtiTRE2OIIvqfFhYWa
         Y4JL75AKZLCBW/y1mjGLPLWmmmGbczSjX4ugb+aSPXsfmKWqKNgyVygxOUbwox9U0SHb
         ED5SErmtg1lJbyfbONmMAnLTTJjELAwYUCCZMKo6uGN1JNl7lzzcm7Z3HDqGWixa524v
         dXVdbHo2gBzy3l8VACZ0VAPovMruAnRyMfC0gpiIUYrH8jncKM2mKGgxPfsbLBbJSaiJ
         iam67VKYu8+8qGv7Vr0xiytXHnaBjShv8Yn1ELq8zHMKh6uslf2N4DJNkPk3XjBrhJDa
         2Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750407267; x=1751012067;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rvdjsAVQZXv/T6sfLTI6KAH2htjv4Mc2dhR9BtJmkI=;
        b=ptoDAhTwdvWh/J+B66IvzcDjAMPdkB+oCVXzI2/KLHk/UHZ5sf606pPh4NdfP2rGbK
         64emwDzh1Dvw+SIAtUn3PNfd/RqmeL1UPdpKZpDlM3r0HzVmWf78MHRqP06tEZl8iEHY
         rSYFfVncIzkQO85LAVDAM1PthTTnRZGl8VfPvqJE8OSqP/3M9cVGvCN7OKJmarA4iu6J
         U+KQLwSJhBsMer/2FJptylunl/t/xJ2E/CwZhvjSMyXdxBznfzQIgJqIEOEcbhTkpf2E
         8pYXUScRFQiFCbzL+hzAMh1Vsw6Vy/SvqXhzmybypso66ob0VIt+MmJpMtEjsBMlYmXw
         cFsA==
X-Forwarded-Encrypted: i=1; AJvYcCWFhMPDmxE6GYjEp6TNfZ6Yvt43amPGJ6mHkWxxgrnrYHpg3wsOXvysJ5Au2fI7u25kE/64/8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4TSa4SjrKhClTo0wrHUKggp3imy3qDYlE2+kDB+5JglG7Lna8
	8Tb+mGz1kKGxUVLi+o7lWlwUJeZU0SFRM0GW44GZ1EQYfP8558/A6/ZDx4Vmmdk34+Q=
X-Gm-Gg: ASbGncv2hLma1dFJBJQtvNd0L14NpuJ71MeNeZkuv/hbCbm82yafA0DsX5cBbrdvsiP
	XD/ydynPtEQHa0fAyoZXwwzsMpK8sYiCPALuIQ+8zGnKIS+UJXVQmBzdNAwRVdep6L8odCHofvD
	pTO3bQbD3lgVwNlvQvqtPToJ67O6tFvs+/bIVLEniJOoCUJlywZqTKSaA7VBStD4hL2mkbWF+fi
	V7RQb8npwtpOZVC6PqsJhrEX5d6/PfA9B41qJ7njANeiJszRlqwWAogpaPPKwVP+C89TUaB2nQx
	gOJtA9LrETmxFeILcUCV27oVYZQxbW5CH3pRhbk+fEkTUUFrGNTmORJ04OvaRQBHOdFB0ReABjs
	1QMNtFbJe2ZZ3XrM3RPwUrDVUg+bAIORJmUXD
X-Google-Smtp-Source: AGHT+IEz0Krt2uB6txrNi5/u0X+8EF39gM9Gs1bl3Ai9HLWh/WpSNtQMT6T+Kzs8o1BDH/bQMAA2+w==
X-Received: by 2002:a05:6000:230d:b0:3a4:dc42:a0c2 with SMTP id ffacd0b85a97d-3a6d128bbfdmr553239f8f.1.1750407267265;
        Fri, 20 Jun 2025 01:14:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:607e:36cd:ae85:b10? ([2a01:e0a:b41:c160:607e:36cd:ae85:b10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f10a8csm1410476f8f.13.2025.06.20.01.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 01:14:26 -0700 (PDT)
Message-ID: <27a87dd2-7ffe-4b4e-8001-ca0abe412b3e@6wind.com>
Date: Fri, 20 Jun 2025 10:14:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ip6_tunnel: enable to change proto of fb tunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250617160126.1093435-1-nicolas.dichtel@6wind.com>
 <20250619155220.3577a32a@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250619155220.3577a32a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 20/06/2025 à 00:52, Jakub Kicinski a écrit :
> On Tue, 17 Jun 2025 18:01:25 +0200 Nicolas Dichtel wrote:
>> +	if (dev == ip6n->fb_tnl_dev) {
>> +		if (!data[IFLA_IPTUN_PROTO]) {
>> +			NL_SET_ERR_MSG(extack,
>> +				       "Only protocol can be changed for fallback tunnel");
>> +			return -EINVAL;
>> +		}
>> +
>> +		ip6_tnl_netlink_parms(data, &p);
>> +		ip6_tnl0_update(netdev_priv(ip6n->fb_tnl_dev), &p);
>> +		return 0;
> 
> Hm, I guess its in line with old school netlink behavior where we'd
> just toss unsupported attributes on the floor. But I wonder whether
> it'd be better to explicitly reject other attrs?

I tried to find a (simple) way to be strict but, by default 'ip link' dumps all
attributes and put them back in the message it sends.
Ie, with the command 'ip link set ip6tnl0 type ip6tnl mode any' all IFLA_IPTUN_*
attributes are set (to their current value) and only IFLA_IPTUN_PROTO has
another value.

> 
> Shouldn't be too painful with just one allowed:
> 
> 	if (!data[IFLA_IPTUN_PROTO])
> 		goto ..
> 
> 	ip6_tnl_netlink_parms(data, &p);
> 
> 	data[IFLA_IPTUN_PROTO] = NULL;
> 	if (memchr_inv(data, 0, sizeof() * ARRAY_SIZE(ip6_tnl_policy)))
> 		goto ...
> > 	ip6_tnl0_update(netdev_priv(ip6n->fb_tnl_dev), &p);
> 
> WDYT?
I already tried something similar, but it broke the 'ip link' command for the
reason explained above.
I was wondering if it's worth putting a lot of code to cover this case.
Any thoughts?


Regards,
Nicolas

