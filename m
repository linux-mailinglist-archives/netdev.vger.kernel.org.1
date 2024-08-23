Return-Path: <netdev+bounces-121268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A942795C652
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 09:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB661F2732F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 07:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8913A41F;
	Fri, 23 Aug 2024 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="nJvwtp71"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943DF139CEC
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397234; cv=none; b=mtMlE3wwJKk/HfjqxbuyRpU6LXQz0dlmMWJgsMRHWYBcsxzNZFBVPPY2+tc/OZFoK0ivYlSqO+PrWbOR/4u18SNlQ+EK/hbdaDuP5js9QPzYktKYaMwOKaMgEe5xrmj711l0k5ahZOzzYo6JATxCBIEl2bsnac+eKtAaB1DVgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397234; c=relaxed/simple;
	bh=G3lxvLZl8b43CR1zWiWYIkbWLV0HEUmD60p/8f73z9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WK/ATI0r5SBpNCSOQGK7kAbxsy8q37cT8jDfNKWpiiV6JI5vyMFz31b/PIHY3c5k/gb5YlAchwOD0RaLRFr/S1rGAI2RrH1GtrNHKhyJ2LMQ1gxySUiwGHkg1Ytvj8HSzvo8Hq6UBsS+ptQxu3+47nTgFA0u8ULEjO34Cwcpwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=nJvwtp71; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:3c32:7100:fa85:d49] (unknown [IPv6:2a02:8010:6359:1:3c32:7100:fa85:d49])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 30BA47D8D2;
	Fri, 23 Aug 2024 08:13:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1724397231; bh=G3lxvLZl8b43CR1zWiWYIkbWLV0HEUmD60p/8f73z9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:From;
	z=Message-ID:=20<667b7932-9d8b-c793-38ba-78554b56cebd@katalix.com>|
	 Date:=20Fri,=2023=20Aug=202024=2008:13:50=20+0100|MIME-Version:=20
	 1.0|Subject:=20Re:=20[Patch=20net-next]=20l2tp:=20avoid=20overridi
	 ng=20sk->sk_user_data|To:=20Cong=20Wang=20<xiyou.wangcong@gmail.co
	 m>,=20netdev@vger.kernel.org|Cc:=20Cong=20Wang=20<cong.wang@byteda
	 nce.com>,=0D=0A=20syzbot+8dbe3133b840c470da0e@syzkaller.appspotmai
	 l.com,=0D=0A=20Tom=20Parkin=20<tparkin@katalix.com>|References:=20
	 <20240822182544.378169-1-xiyou.wangcong@gmail.com>|From:=20James=2
	 0Chapman=20<jchapman@katalix.com>|In-Reply-To:=20<20240822182544.3
	 78169-1-xiyou.wangcong@gmail.com>;
	b=nJvwtp71rnYcSR6NvMhyaJUSYvs7cLOr2Ang2vbHoojY2eZk0OpfPBMxiz3JJoyaX
	 LCFKxqI0FUIfRU2RgIBfbKEjWqu4buPImxovcfzHsdzgrSGFChxMms1lekKaPFuAdc
	 rn82VVqysVIl6eWUhfA8AvjUtlvHK84lW01tvdY0YHtwe/m3L5B2EFvWVhBCMctZwA
	 ao0yBvtO0yhkcdIcBNyf+aM3V9W4R/K6pT8z6EpziFuzx3d60ky1ZPjXlyjyJZD6Ka
	 Y8vwAgyBjngyXIexi57lDyVLtyI5p+g5vND3gQD8yHmTohCOKiOoCzcKRWuzLGB5aj
	 XN7cB/tzUY0Ug==
Message-ID: <667b7932-9d8b-c793-38ba-78554b56cebd@katalix.com>
Date: Fri, 23 Aug 2024 08:13:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch net-next] l2tp: avoid overriding sk->sk_user_data
Content-Language: en-US
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: Cong Wang <cong.wang@bytedance.com>,
 syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com,
 Tom Parkin <tparkin@katalix.com>
References: <20240822182544.378169-1-xiyou.wangcong@gmail.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
In-Reply-To: <20240822182544.378169-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/08/2024 19:25, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Although commit 4a4cd70369f1 ("l2tp: don't set sk_user_data in tunnel socket")
> removed sk->sk_user_data usage, setup_udp_tunnel_sock() still touches
> sk->sk_user_data, this conflicts with sockmap which also leverages
> sk->sk_user_data to save psock.
> 
> Restore this sk->sk_user_data check to avoid such conflicts.
> 
> Fixes: 4a4cd70369f1 ("l2tp: don't set sk_user_data in tunnel socket")
> Reported-by: syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com
> Cc: James Chapman <jchapman@katalix.com>
> Cc: Tom Parkin <tparkin@katalix.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>   net/l2tp/l2tp_core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index af87c781d6a6..df73c35363cb 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1620,6 +1620,9 @@ static int l2tp_validate_socket(const struct sock *sk, const struct net *net,
>   	    (encap == L2TP_ENCAPTYPE_IP && sk->sk_protocol != IPPROTO_L2TP))
>   		return -EPROTONOSUPPORT;
>   
> +	if (encap == L2TP_ENCAPTYPE_UDP && sk->sk_user_data)
> +		return -EBUSY;
> +
>   	tunnel = l2tp_sk_to_tunnel(sk);
>   	if (tunnel) {
>   		l2tp_tunnel_put(tunnel);

Thanks Cong

Tested-by: James Chapman <jchapman@katalix.com>
Reviewed-by: James Chapman <jchapman@katalix.com>



