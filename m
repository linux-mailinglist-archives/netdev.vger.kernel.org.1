Return-Path: <netdev+bounces-231627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1CBBFBA29
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D3BF4FEBF0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F62D336EE2;
	Wed, 22 Oct 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="AdXFcp0b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E64531B13C
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132311; cv=none; b=tikslhaNYN0ZjsQoB52rOBnRqJDggDyKSyxk4YsGNOM/VcWvx1FpAKCd/OnJFfi9E3BJCvOVQfgOwpSsqeGE10jPHQoy1ryH21vzbRqbcRaP9QsFBGXc1uwFa+WTcWbzyPb2MuDPZKPu65kEa1V3XD3jAvr/GTsPPbqDm0T0wkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132311; c=relaxed/simple;
	bh=1hZeMj0UWQeHgoCLfE+UEl3jPzN6ojQ+GDfqG96KVpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYQF5mCycpDVRkPtAxLiVkriOmnvdLU4PsxJlqpexYxEOYjiotHS+tTTdGcv+1iaO3r2UzGBGfFHu56LfMXwrxsPHWd032s+6LL8FtXQ9b3RVrLD4jRWHEcax9DVv+0OB0c7TYTqryMCjahU365LQ0auOLFBBcQMzGxGb8ZamHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=AdXFcp0b; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso205632166b.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761132308; x=1761737108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONq7np9g9MrEqjFwbGijwelPGFlfBJwFO8dPJaIhZSU=;
        b=AdXFcp0bmC/jfvYbJvLic2wEMCzmIBKo55PEipmfgsPNtfi+04LaH9A3Cq4zyXzGKA
         xv0LVb0i1B9Km6DugXOpg0niYGG2ZhFJ3jeL5X1gZzhBvqTMAoinIvur82NXLTFOfCmf
         HVlo47otF/9anzfFB9UInUce+1Rq92pO35xN0/nAKnBEWYn1DwXETfKHE4j5E/JZ6nPj
         n5zVBlt0g/orJXHUgB7VDB4kxp/2rLvjopH4TlrRDvggiUCKPTPF4Pm9t3vgm9FjEfEv
         vIIMy1VLrMDPjydW5AkMxUSRJTeJLlurUuzjstyi+oW1Bico9XUUbXlrXvGmVimyPiY+
         bYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132308; x=1761737108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONq7np9g9MrEqjFwbGijwelPGFlfBJwFO8dPJaIhZSU=;
        b=wOVJOup4cc7hi6J2GPu6o40/BdKcNMSSc77YnCpyYJhmfGRDLP4twXciMHXaktyDko
         IrZY7Yh6wjI/Z8iSoePJ14IgIIk1obVNmMlMAmfozxSeWpBsUSVFw59fYk54Gh2CKRQe
         8Zcn8Ub+9zA9CS+g8MQf/ldf9Nmq/ZNVjhwYJ6OBJZZYdpqSm5Avhky1U4L0rzEEakgn
         zIdQ0TjvjJy+qkMiwIyxZ4nyNAyzlqxR2c2jqWr6xO9EsHAOvPli71zkz0qMSvbzh9Nd
         rtMoAIvY0/PXhwg46oVDKfourxuh1DBE5CX1Gjz8NeRg/i3AQg5DoESPF2jqgkymwl2S
         vg5A==
X-Forwarded-Encrypted: i=1; AJvYcCWmCnNb09A841O3EBq4Xft+1AZfkFTqSgeqbN39YazjXUsqSL8gEVkK6cSY/pKkeaZ9a/S8mX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0T52QWwNPe1mjw7zMH9ADwJl8ZOCGJ3Fj/Gv4UMIgsEarrRH7
	nXMtt73zrEp0Dpp9wkz3DMrQl7IPFkDd4oQqsiZdh0ZR2E741/vQAFfdL3gxbWvC+bo=
X-Gm-Gg: ASbGnctfo3tRUilrstkmK200frvprW88R9gQVdK5H3e6gvEoVGWYjvcpFE8m6iPfNOH
	y0K7H9pSCaxbGKv06nrFvm+Sf4oAdg5wKD231u964sMBMSey0jC8+lUWJQgyAgV6ZWW/RIH+e/d
	z5x+qLTSPSQlQqARES16xzskggySVm3PrsvBFIbHLrYyRSowFBM2dT3MIitDOcP/MTBa5KZBUHF
	ow4qrLco1WZYsRi3QLumD4fs66kzQltwC4TCXTKH3pjCzHZ0yb8gvwwWynTPjz+77VltlI6n7zc
	eHjP3J9jwxwvKB8PYgWTr0sqZjBgm3qWXrU+sD4Obpg9g2lr/9plOMeXlB2Xi8YdRs7/fqVyf26
	b+ViJIUo5rALD/JkkB0KdNP9o0hjPzoZgBp5+Ma8lM/z7K4advEc6Hi95XduzbCj06QVdQNhc3G
	LzxWpPwZmX9MN/fIek1/xOMZs7xuj6t75O29+33t1RbVk=
X-Google-Smtp-Source: AGHT+IEwfchOwO7QAOkGnebZSJknlHDr5gYvUmxRoRxGN1hZq727CipU0K75R8kJYGQI9qDDsgmIUQ==
X-Received: by 2002:a17:907:6d25:b0:b41:abc9:6135 with SMTP id a640c23a62f3a-b647493fa65mr2475676966b.41.1761132307639;
        Wed, 22 Oct 2025 04:25:07 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c494301aasm11939759a12.24.2025.10.22.04.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:25:07 -0700 (PDT)
Message-ID: <9e707899-9d51-4eeb-95c0-3b7f02cb2fa2@blackwall.org>
Date: Wed, 22 Oct 2025 14:25:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/15] net, ethtool: Disallow peered real rxqs
 to be resized
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-5-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Similar to AF_XDP, do not allow queues in a physical netdev to be
> resized by ethtool -L when they are peered.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  include/linux/ethtool.h |  1 +
>  net/ethtool/channels.c  | 12 ++++++------
>  net/ethtool/common.c    | 10 +++++++++-
>  net/ethtool/ioctl.c     |  4 ++--
>  4 files changed, 18 insertions(+), 9 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


