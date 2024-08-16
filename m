Return-Path: <netdev+bounces-119127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C63954399
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B074B23747
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2528454645;
	Fri, 16 Aug 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="0v8d7mbU"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8528F82863
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795333; cv=none; b=I2CNTY9yXn4r1q8MRJ2F8EuFBAFJY6u1uIm1Vpvar3SpmQp6QxoWei4DSQNLvovQB/K1PhFhyAEH9rR65OwB/2OilWwix4o8F4IU25bxAPBEIAqQKaxGZFc8UP9L/nNA12jWTsQqbqnMx40IVf2RI92OtXeh9jUgJoy22djL+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795333; c=relaxed/simple;
	bh=kFnbw+sCZmQBGBhaYY14lscRNj4u/DKGJfN+0MmCq0g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uarZ36C7vK1Ar+NbL86ApznFEQEYmjTo9d4j0PIqttEhF3bjUFgj++/DETlEbc2939m9JrVpWgXkL0wfa8FnMNda0wGtxqUdLIqA7cqzQFJ98y1dxbhbTTiLnWVvq8WRRhzzBKxLk7zlbXa3/62L4AvfC1r27iYFjICjhERfnkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=0v8d7mbU; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:e533:7058:72ab:8493] (unknown [IPv6:2a02:8010:6359:1:e533:7058:72ab:8493])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id C84387DA1E;
	Fri, 16 Aug 2024 09:02:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723795324; bh=kFnbw+sCZmQBGBhaYY14lscRNj4u/DKGJfN+0MmCq0g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:From;
	z=Message-ID:=20<8362db69-ba48-56fc-5995-4195b00a2b9f@katalix.com>|
	 Date:=20Fri,=2016=20Aug=202024=2009:02:03=20+0100|MIME-Version:=20
	 1.0|Subject:=20Re:=20[PATCH=20net-next=20v2]=20l2tp:=20use=20skb_q
	 ueue_purge=20in=0D=0A=20l2tp_ip_destroy_sock|From:=20James=20Chapm
	 an=20<jchapman@katalix.com>|To:=20netdev@vger.kernel.org|Cc:=20dav
	 em@davemloft.net,=20edumazet@google.com,=20kuba@kernel.org,=0D=0A=
	 20pabeni@redhat.com,=20dsahern@kernel.org,=20tparkin@katalix.com,=
	 0D=0A=20xiyou.wangcong@gmail.com|References:=20<20240815074311.123
	 8511-1-jchapman@katalix.com>|In-Reply-To:=20<20240815074311.123851
	 1-1-jchapman@katalix.com>;
	b=0v8d7mbUWWOwp589CllDSr4h/cYbAKWjwWmfVQKLd1JLKqs+U8A4FkbiMRp4HIPZb
	 anaxgUzbaLUxtp966aKhrerncXsx8DBfyan4ktTTcjq2Y3IZymGsfVLMD/fistrfjd
	 7AR1LyjZ3h785Qbvcm0AgmhDvnKH/ulYN4O8+vqmDXh1m/TBMtQ1N3uAKdbtVgaFiK
	 J/ynoX/GtKgwez7wbdAZJFek+AK2FSSJe9SMjWAGQcqhfjV3GZ5cLRU9u+qHTuI9Sw
	 nZlzY303e73lXiex1zp8sV4e4ZhOizS4o1TpUmtbtGBUXy5QiBQIVt9ABwGYprZ7+V
	 4uqvMRDE43y2Q==
Message-ID: <8362db69-ba48-56fc-5995-4195b00a2b9f@katalix.com>
Date: Fri, 16 Aug 2024 09:02:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v2] l2tp: use skb_queue_purge in
 l2tp_ip_destroy_sock
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com,
 xiyou.wangcong@gmail.com
References: <20240815074311.1238511-1-jchapman@katalix.com>
Organization: Katalix Systems Ltd
In-Reply-To: <20240815074311.1238511-1-jchapman@katalix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2024 08:43, James Chapman wrote:
> Recent commit ed8ebee6def7 ("l2tp: have l2tp_ip_destroy_sock use
> ip_flush_pending_frames") was incorrect in that l2tp_ip does not use
> socket cork and ip_flush_pending_frames is for sockets that do. Use
> skb_queue_purge instead and remove the unnecessary lock.
> 
> Also unexport ip_flush_pending_frames since it was originally exported
> in commit 4ff8863419cd ("ipv4: export ip_flush_pending_frames") for
> l2tp and is not used by other modules.
> 
> ---
>    v2:
>      - also unexport ip_flush_pending_frames (cong)
>    v1: https://lore.kernel.org/all/20240813093914.501183-1-jchapman@katalix.com/
> 
> Suggested-by: xiyou.wangcong@gmail.com
> Signed-off-by: James Chapman <jchapman@katalix.com>
> ---
>   net/ipv4/ip_output.c | 1 -
>   net/l2tp/l2tp_ip.c   | 4 +---
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 8a10a7c67834..b90d0f78ac80 100644


Gah, I notice tags are in the wrong place in the commit log. I'll send a v3.

--
pw-bot: cr


