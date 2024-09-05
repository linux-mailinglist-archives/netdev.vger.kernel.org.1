Return-Path: <netdev+bounces-125549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F996DA85
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC00287EF4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0F019D06A;
	Thu,  5 Sep 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B25Swccq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NfgLiQgF"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981919CCEC
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543613; cv=none; b=ovBxMwJuc7enVhptxd/cmiswx+TDU3qnzUv4U8n68Pw6TZ4YJDehZkFBo7dlDqdbTo2P+Y+/4z+iHlJ7RLVH6dXLixrlLsbn6glnGEvSf4VowbrBdSa2jdjIVIbPEmP/OT+nNgZqiaKlWjQO9JdQ4epugK2Db6BSGsz/WuEnQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543613; c=relaxed/simple;
	bh=OmmJ9JFZiqta7WLJpB+r53jvf5wwJAknuwo9ggHK0ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X31Nwi7hO94JanMd3wGqAzAeSc/LGYUmQfkW5N5i1t3PJ8VKs4yG3MMMol5FEy0r5FeRZX/sjWiccFhDrjpqewrprLSOIpGH8S3UVu+eNGdZ9X47koBIwyekmwQqhMUMd2wq6NSpyaIIPE6/Fmr5OdSQgiV/LbXFT9iUSTn0XVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B25Swccq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NfgLiQgF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Sep 2024 15:40:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725543610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNGQeWIGBmbvRbhDVFGOBUUnKfrBupC2AvgQtk4aaLo=;
	b=B25SwccqwcpboeyvZPCVwxMP8XbKavk5MeVCiVNkdP8JlwDbFBEg6fojY466z3bRGJAeum
	FooZ7W4XSGtYXJXYh+DSEaip0qDejRQC9gtK3eDfnmcX7JTk9VMn38eyDZwM+HAknc0f8e
	8YMz4bH5UkDdm8ZWr85c/bC4eJXx9eFkoGvP850h2aOzOR5El1UxqItfwdQrawmvCOyyfG
	FjGqDSlY2JWFROIdL7Fg4qMOQ18TXaPVC9rX3bN3jIxtKpIfvfnKzOlkl/9k1jKYgK4Nub
	KHzSxZYvTDbuIiwsZYTp5tYmi8u9Nso/wJTej7MwBWZFZXdx2rv+XGtKhRyPUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725543610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNGQeWIGBmbvRbhDVFGOBUUnKfrBupC2AvgQtk4aaLo=;
	b=NfgLiQgF1tLY0CLcuLGvhG2rn5rd73LI6scwBsgYjE782mKTgwtO3YfWW6/vP+nN4BYIXg
	5BVWrf9FFc0JS6DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] net: hsr: remove seqnr_lock
Message-ID: <20240905134008._e6BGgni@linutronix.de>
References: <20240904133725.1073963-1-edumazet@google.com>
 <20240905121701.mSxilT-9@linutronix.de>
 <CANn89i+K8SSmsnzVQB8D_cKNk1p_WLwxipUjGT0C6YU+G+5mbw@mail.gmail.com>
 <20240905131831.LI9rTYTd@linutronix.de>
 <CANn89iLQxH0H_cPcZnxO9ni73ncmbbhx3knzRB2swTsx=J-Fmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANn89iLQxH0H_cPcZnxO9ni73ncmbbhx3knzRB2swTsx=J-Fmg@mail.gmail.com>

On 2024-09-05 15:26:27 [+0200], Eric Dumazet wrote:
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index af6cf64a00e081c777db5f7786e8a27ea6f62e14..3971dbc0644ab8d32c04c262dbba7b1c950ebea9
> 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -67,7 +67,9 @@ static rx_handler_result_t hsr_handle_frame(struct
> sk_buff **pskb)
>                 skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
>         skb_reset_mac_len(skb);
> 
> +       spin_lock_bh(&hsr->seqnr_lock);
>         hsr_forward_skb(skb, port);
> +       spin_unlock_bh(&hsr->seqnr_lock);
> 
>  finish_consume:
>         return RX_HANDLER_CONSUMED;
> 
> 
> I am surprised we even have a discussion considering HSR has Orphan
> status in MAINTAINERS...
> 
> I do not know how to test HSR, I am not sure the alternative patch is correct.

I did submit something to tests somewhere. I will try to test this and
let you know.

> Removing the seqnr_lock seems the safest to me.
Consider this as ack if you don't hear back from me.

Sebastian

