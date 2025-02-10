Return-Path: <netdev+bounces-164610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A697A2E7A9
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DB27A1AE2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B0819AD8D;
	Mon, 10 Feb 2025 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="e2q1tHS4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="njLUJ0lK"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73B15B543
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179852; cv=none; b=QriUGpzXGYjdSwR6vKmegjaneDwC7es/nfX2arF0uQWrJzglKDAo4lFy+1Wf2Q4bdQxmBVm/TcCLlmeOVeszVNkHasfCCwyy7KGfvhFpwSaK6R3P5E3TroWSFHWuDGn/phwxmnaHRy4+Hfnxq8MPdT++wW+JZG1WpyQMHV1AB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179852; c=relaxed/simple;
	bh=2RiwvmXqPodb1hIjYVsIONE5h4qCfCDv515lo9VPnhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxurGnDSNntG1IsMIiK4uLkCLLekpJ8+aYDZmyRQWxf70Ahser+ZrAlFyILFucboABLrc463NlisESPahLWWarCARbE7lyynG24PhSsFWFItLq0fegidqhdc8c0BimSkicyJIsLie4uSbRIShzTPggRp6Tt1JsrcgW3BdMau5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=e2q1tHS4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=njLUJ0lK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1466F1140163;
	Mon, 10 Feb 2025 04:30:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 04:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739179848; x=
	1739266248; bh=EsZYfSY3R0QhwnNOEbw8l9l84zdb7hNQRJd5VNVTgzc=; b=e
	2q1tHS4jrmUhWAylWfPKiMoBBXI+YANtB1SYDe2mZkVgP59hwWNduJveWpulksDr
	m/A2pv/eb8A7hL8eA+hQ5t6q/y+mFFRsJDtN9pY5SPK+2cFKtRRvhANAgqQR4s69
	/qFeDgPtKil+DhVmEveLyaxHBkRnm5YrAPJNXWKglL1Kpd0X3MoPlnbVjr868XJZ
	el33L7rWVH0eNYLMboJTRiLcqjjk/7d5Kfx/ABXNID5M7exxyCvrfgyTYuF0dQaP
	N6ZQZBlTeJGGsdA7be2wOfdeq9FCBoGj5cGgyHdDUZkaEmFoD5mH/qpLOstohRZ4
	aX/YX3ydoEK4+qztwN5ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739179848; x=1739266248; bh=EsZYfSY3R0QhwnNOEbw8l9l84zdb7hNQRJd
	5VNVTgzc=; b=njLUJ0lK0Q40RI9K6APS/i5NhzNM5uXGu5hl+aeungXiLMR59gW
	671EJhhCzem5d93jy0aErQh9fASxsafB0h/FLMHKk0kv5rnJZG5ljZi8V6JtTDXP
	1VNbcnWTJGQDS4wd/m6+rrU8JXHf/f8lGEhm5179aCRnRPkWIX38VxfL9NLCUg+R
	0azOd3rc2ezgwef1ojHxW1XyINAsW4UBANbYj3Ms8afFjIzFrk3XpH6hggqG0vLo
	JEJ5DnrfNxD1wim5jD3/+AtywMDsrGITGku3woVE/GmECY4f+IjXp3qqweU3TRpu
	gKmVHuDrZ+ZHCwrV5ioRroHhRLP2iz4kuSw==
X-ME-Sender: <xms:R8epZ4kTnk-DbB8sXqvzjS3384RmQE20JtNgVgGeHTKgWPmVr-MZ3Q>
    <xme:R8epZ32DHQRy6oOalxdIV2cLtvLEDnVZACazn3Zi0RvPCOFUX5FBEx4NqRKtdMfO1
    oi1nqJ4C42fAjrXr0M>
X-ME-Received: <xmr:R8epZ2qiT9lYN96UVt8xtQOJcxixzDrNMkMr3ADuo-QulIWa7wRRt5rmuyFW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvgguuhhmrg
    iivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhho
    fhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlvghmsgesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghrihgtrdguuhhmrgiivghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:R8epZ0nPbv3wqlh_rvuYCMrM-k_TEOICyIyS0hEhFt6HM7yd-ozHZQ>
    <xmx:R8epZ22c-RfDn1jxHbbfd2Rg9wDQtBfm1coC5yuU0pZo8_Z1tka17g>
    <xmx:R8epZ7skNLMXKazpuTNjkOaHKZEHfMjeoKdLIs8t59kv0B8SLzsTqA>
    <xmx:R8epZyU3NZ-Ggu8mEKhk7xgMKkbFFDXQrayDZ-9fJx0CqQr1XXgJ7g>
    <xmx:SMepZ3L5M1xdq4wErsRdDVZ3t3--I-ZKtWBtge2djh2yG4wSHlFcyvLC>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 04:30:46 -0500 (EST)
Date: Mon, 10 Feb 2025 10:30:44 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
Message-ID: <Z6nHRDtxEG393A38@hog>
References: <20250210082805.465241-1-edumazet@google.com>
 <20250210082805.465241-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210082805.465241-4-edumazet@google.com>

2025-02-10, 08:28:04 +0000, Eric Dumazet wrote:
> @@ -613,7 +613,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
>  
>  	return mask;
>  }
> -EXPORT_SYMBOL(tcp_poll);
> +EXPORT_IPV6_MOD(tcp_poll);

ktls uses it directly (net/tls/tls_main.c):

static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
			    struct poll_table_struct *wait)
{
	struct tls_sw_context_rx *ctx;
	struct tls_context *tls_ctx;
	struct sock *sk = sock->sk;
	struct sk_psock *psock;
	__poll_t mask = 0;
	u8 shutdown;
	int state;

	mask = tcp_poll(file, sock, wait);
[...]
}

If you want to un-export tcp_poll, I guess we'll need to add the same
thing as for ->sk_data_ready (save the old ->poll to tls_context).

-- 
Sabrina

