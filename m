Return-Path: <netdev+bounces-162642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A57A27748
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4BC18850AD
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83BE2153FD;
	Tue,  4 Feb 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="SxASgriZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C2B2153CE
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687085; cv=none; b=Mje/sTMBFmytABQKwAxb7GpS6VbfWzu78GUFG4zB4kAn2uEKj2QBROAReSx6hpvf6qOGBn46GJHVJKqc23nqXKRmlKoqt8oA04zMJQ/wJj6qbCSHNwSFn3EQawmu2fYQQw2iyhngNJcBW65LILMel4xmSBNVsUbvaI74QxKcI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687085; c=relaxed/simple;
	bh=/cn+67KTTnyLtvpejyW2DoDeN56wb5fUyXmlQO2RmJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvCMTrn/aI/i7CBjY0bUYkF2aMgzxP/5ARdpy6+H/pI0wIIE0dPPTnUXUUtOJAktpdSRVFamRh9IAP3yXEiI/XJs28zN/SaQ9ICi7lj8qTw+YvG5MwjkYVUMsSDuFBEXAku4IOrZ0ZPHDYLqh/u09JZA1IdZwWacbwWzfoSJkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=SxASgriZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaeec07b705so978532966b.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738687082; x=1739291882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SyIy2fHYnB4MtGniFSMTBeyvaALSzE7VWV+dGmwFQnQ=;
        b=SxASgriZS3uKIhLlpEVJSVqGkenQlvtyZof2sJHa0Vtg9chvWL60NQuWWtdSjNp9o9
         E4e60GJNluJKna0X6h21/vx/MGDrnBqGtsuqsh8cW7CwT4uaI941ckITACyX1qTaO33k
         szU6JfVI3ssElcHhg9Su+5Qoosk05oBdHdNPxfxIsYJAZ/UQLUUQ69edtn7GEUdBnNMn
         7hFYsiht2eAkzTXKf1WMItFCk80qCTKu3bPWP9KdN2UPf9K6StN54t1H3GK+e0z684yQ
         xpBT7vdB8daHh6FqcBdch7xwhYWgenL0ypzLVU9yLAK5fsqmm39YgEpX7spYVUdgdi8G
         Go3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687082; x=1739291882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyIy2fHYnB4MtGniFSMTBeyvaALSzE7VWV+dGmwFQnQ=;
        b=brbP8xG1kyQw5ZkezajIy7nGl2jOG0wQy03SjKyiVH5f00MrThz0bYwXGbctDIXsiT
         fArTPRmUbIHm9EQzUv4y97Ngmlsl21TCnmi4EnIBbQaNxjAJbLB06uie+KN3V9uNpviQ
         phsFdgfUQ2jMxpnf+44Rl0ZoQa9Cuojo9YRVYzAXLKTL0/mGgdAtGHl54EU4bbr5ozsR
         nridZWtHqdOUX01CM8L1fm9mn24QcePaNftT2wBDbNCcuqTv1ci5vS8Jz/snm0gQhSyc
         8j5bX9tEp12TIM/qxyyAs8H9nNGd6ODuxv+ane42OU1iu6LREvVDP2FuWOowUgavXEzN
         QuMg==
X-Forwarded-Encrypted: i=1; AJvYcCU9LjjMiiL5PE642zwPUK3y5pVjLHbqJSZ5pe9VNMokPhZmqRljm7oz9mBRW7ZnrbhTvlMdfnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJXMvQHtkOlk59vi9URNmLCDazUcHJxIGu3mMrgQCYPGQqrAWR
	WfQeSjyx1nKJbc8AC5+flB4EaECkYiQHfVM68Yjm7FR4NudQ0dLr7Idhuo/GkzI=
X-Gm-Gg: ASbGncvqCyMWpQ8u19S+oJv3k37sxKgBK/UpYC/dixtvL/btMEvXWmRAVV66l/8vIdd
	7dzzWriyhKITug+dakdvekbYA4/se7yJJQQTkJR7kZtU498fV8tLkjQjzXXazb0c+EpveelyTje
	ejllAXVsVlxPCqSrDoqb6NM/F0vleK+OmQ0k+ecEh3ctuFv/K/jHUpwr6ZV2VcU59oz8LfFcOlK
	T21H1ia4l2Fe0hahPMjFtZEqiGqmtkOl6QXBXAvyHJSSmqTeFCIj489keQkC5L9oVYK8wk9l5PQ
	Ow6vN1H3xsjdf0RGPUcw/Og9d1GN0VNSx81seDV/wwk8zFI=
X-Google-Smtp-Source: AGHT+IGsajS5jxLDvHv/YrQq925FY0te3tXdUS1UD6zdx4z7FAAQwchFI2mXqJAPfd6FPdpRDKWYmw==
X-Received: by 2002:a17:907:9445:b0:aa6:a9fe:46e5 with SMTP id a640c23a62f3a-ab6cfe12e13mr3460607666b.53.1738687082110;
        Tue, 04 Feb 2025 08:38:02 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a7ea7sm938207766b.5.2025.02.04.08.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 08:38:01 -0800 (PST)
Message-ID: <ceafd63f-ea77-4f35-9f21-78e6df6c1d23@blackwall.org>
Date: Tue, 4 Feb 2025 18:38:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/8] vxlan: Age out FDB entries based on
 'updated' time
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
References: <20250204145549.1216254-1-idosch@nvidia.com>
 <20250204145549.1216254-7-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204145549.1216254-7-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 16:55, Ido Schimmel wrote:
> Currently, the VXLAN driver ages out FDB entries based on their 'used'
> time which is refreshed by both the Tx and Rx paths. This means that an
> FDB entry will not age out if traffic is only forwarded to the target
> host:
> 
>  # ip link add name vx1 up type vxlan id 10010 local 192.0.2.1 dstport 4789 learning ageing 10
>  # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
>  # bridge fdb get 00:11:22:33:44:55 br vx1 self
>  00:11:22:33:44:55 dev vx1 dst 198.51.100.1 self
>  # mausezahn vx1 -a own -b 00:11:22:33:44:55 -c 0 -p 100 -q &
>  # sleep 20
>  # bridge fdb get 00:11:22:33:44:55 br vx1 self
>  00:11:22:33:44:55 dev vx1 dst 198.51.100.1 self
> 
> This is wrong as an FDB entry will remain present when we no longer have
> an indication that the host is still behind the current remote. It is
> also inconsistent with the bridge driver:
> 
>  # ip link add name br1 up type bridge ageing_time $((10 * 100))
>  # ip link add name swp1 up master br1 type dummy
>  # bridge fdb add 00:11:22:33:44:55 dev swp1 master dynamic
>  # bridge fdb get 00:11:22:33:44:55 br br1
>  00:11:22:33:44:55 dev swp1 master br1
>  # mausezahn br1 -a own -b 00:11:22:33:44:55 -c 0 -p 100 -q &
>  # sleep 20
>  # bridge fdb get 00:11:22:33:44:55 br br1
>  Error: Fdb entry not found.
> 
> Solve this by aging out entries based on their 'updated' time, which is
> not refreshed by the Tx path:
> 
>  # ip link add name vx1 up type vxlan id 10010 local 192.0.2.1 dstport 4789 learning ageing 10
>  # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
>  # bridge fdb get 00:11:22:33:44:55 br vx1 self
>  00:11:22:33:44:55 dev vx1 dst 198.51.100.1 self
>  # mausezahn vx1 -a own -b 00:11:22:33:44:55 -c 0 -p 100 -q &
>  # sleep 20
>  # bridge fdb get 00:11:22:33:44:55 br vx1 self
>  Error: Fdb entry not found.
> 
> But is refreshed by the Rx path:
> 
>  # ip address add 192.0.2.1/32 dev lo
>  # ip link add name vx1 up type vxlan id 10010 local 192.0.2.1 dstport 4789 localbypass
>  # ip link add name vx2 up type vxlan id 20010 local 192.0.2.1 dstport 4789 learning ageing 10
>  # bridge fdb add 00:11:22:33:44:55 dev vx1 self static dst 127.0.0.1 vni 20010
>  # mausezahn vx1 -a 00:aa:bb:cc:dd:ee -b 00:11:22:33:44:55 -c 0 -p 100 -q &
>  # sleep 20
>  # bridge fdb get 00:aa:bb:cc:dd:ee br vx2 self
>  00:aa:bb:cc:dd:ee dev vx2 dst 127.0.0.1 self
>  # pkill mausezahn
>  # sleep 20
>  # bridge fdb get 00:aa:bb:cc:dd:ee br vx2 self
>  Error: Fdb entry not found.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


