Return-Path: <netdev+bounces-219528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0EB41B76
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919DA7A14B2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0B2E8B86;
	Wed,  3 Sep 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="QbG6lPvz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZu2ISvU"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD29B2D6607;
	Wed,  3 Sep 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894478; cv=none; b=oc/aqZzcMFR/WSoQsAGhMH9iMwXz2CU1RPNCAgkYw6mSmUiZQ9L0B8GPj5KJbeIRYWv1c21J5KlR2JwKuFFq/4Vm+Gk1GVi95zdz0YneLZPbmE4NqgEknRcL2in80twND8Tl/lhBGUotoP52EoUsx+RA5B5LfSrp6QrDcD6Dl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894478; c=relaxed/simple;
	bh=hlNJJ1G1+WNeeg0idSskM8WMibWqKJQhvR2nOpoOetc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxwN+2PqT0UIszlBDhfkF59iPZsSuiIZxdLXjGJuNpDanyDjegDDhAWqFq8qJJc3wjg02kzwl2G5NVhdOQtPyaW86duCaYUb+EOboHRVlBOhFHSHN1CG86xX5kOPjOZDuShqnVeFidZEafCS54H97n44tZ5wOkAELOi+a7FZxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=QbG6lPvz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZu2ISvU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACD29140040F;
	Wed,  3 Sep 2025 06:14:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 03 Sep 2025 06:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756894474; x=
	1756980874; bh=oJuMg/CtAgpONPrIwJ9LStLAGu5PdybtBuhkGLCzAmk=; b=Q
	bG6lPvzJYcwQG418ETq2b97m+hlxfdAoUP5JPMAupm172i/UsXJnHWktoOs8a/pv
	8zIrgLzvQfZ4xONUBNXEs7R+HMSwy9OOsI0enwjJHmn4HxzXjt5ksjE6uN7nHx1o
	vvEZZ726NSSMzhkT1bH9F6pkGuq/qKVNVMTs1cz19LcWgvXE+mSQ9diPHocfAiFe
	eBHGX6FvXcGzLBTpxwGaxEI58HDuFDv2A7+Hs9IFbuaa41lfDtSWAYN9pT94mUBd
	CsymewpHEW0Do+qikSbIJgoR46yNzS27sAG/hXGqcodlb5YhAyFujWDiJ+oxLuRy
	MCFNuXFBxc9TuKONhtOjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756894474; x=1756980874; bh=oJuMg/CtAgpONPrIwJ9LStLAGu5PdybtBuh
	kGLCzAmk=; b=VZu2ISvUdQorLiXIJIICz5mEaQaZsIciadVzXt5gZeyFqZ6qn+p
	oFZtxXJ+4FdpOgw9DUkkydjb1BBYaEIyX2KAxn38FqJ/y9C++iQsjf6pXLXHyw7o
	HZGMrajbEuRfLUQVnoGSKsN/Rhyy0YljC+oZK5CC1y3hmpVniy++grfA8Y5R4ByI
	/mnNZR+RSiwMKtoPDmmE8uDYUTbDVlQSw2qkHY9oO97ZVo2QcHGNrmWDOwfC6Icr
	ybMjIWUZVXyUKZUpftwTaeN18E3LeFFiCqK82z768R26Jxc6nYgj5xNoclxoN0n6
	r1etLObVf24BhmyaZYJd10VcfdID2jKMoJQ==
X-ME-Sender: <xms:ChW4aCEiu6KFgYPU5JPyISDJW_s-IohWvZcf9W7MZFMVxvwVfLJgFg>
    <xme:ChW4aH7BPmHjesKbc63hGI1xKsMalV39FWM5rjqg2nKr1VSUgGfk2-FIJpXZ2mLGn
    6SRRkCrmfD1AFnDWe4>
X-ME-Received: <xmr:ChW4aJQWmK7GdEFst2QgsKCQ3vD2oE6kIW2lKxG6kexUh2vaTocfG9BLyHb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvuefffefg
    udffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrohhpvghnshhouhhrtggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgr
    sggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ChW4aC4mNmbndpE4ETOzphb3H3ZkvoOYV-XpP8JEFvzufYGTfqWAQA>
    <xmx:ChW4aGSq-MiMaQmAIfnPZSFqEr5J5Bg_cdesPtimy9rg0IgUUJyqvA>
    <xmx:ChW4aHkE7XONpN1fnbvpPX6Rp9FKh9L_tM9viiel-1m4lmNkU4QxMw>
    <xmx:ChW4aKTB4nZ9rLLc5ZpZc3AAlEozTWEA7gVkmrR-H_kCKGHfUI099Q>
    <xmx:ChW4aMaK6iJx6oeBXD-1B8tpoT0r_JBLKvbMltlUepdlXJ7lSszJrL1J>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 06:14:33 -0400 (EDT)
Date: Wed, 3 Sep 2025 12:14:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	john.fastabend@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	alistair.francis@wdc.com, dlemoal@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3] net/tls: support maximum record size limit
Message-ID: <aLgVCGbq0b6PJXbY@krikkit>
References: <20250903014756.247106-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903014756.247106-2-wilfred.opensource@gmail.com>

note: since this is a new feature, the subject prefix should be
"[PATCH net-next vN]" (ie add "net-next", the target tree for "new
feature" changes)

2025-09-03, 11:47:57 +1000, Wilfred Mallawa wrote:
> diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
> index 36cc7afc2527..0232df902320 100644
> --- a/Documentation/networking/tls.rst
> +++ b/Documentation/networking/tls.rst
> @@ -280,6 +280,13 @@ If the record decrypted turns out to had been padded or is not a data
>  record it will be decrypted again into a kernel buffer without zero copy.
>  Such events are counted in the ``TlsDecryptRetry`` statistic.
>  
> +TLS_TX_RECORD_SIZE_LIM
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +During a TLS handshake, an endpoint may use the record size limit extension
> +to specify a maximum record size. This allows enforcing the specified record
> +size limit, such that outgoing records do not exceed the limit specified.

Maybe worth adding a reference to the RFC that defines this extension?
I'm not sure if that would be helpful to readers of this doc or not.


> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index a3ccb3135e51..94237c97f062 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
[...]
> @@ -1022,6 +1075,7 @@ static int tls_init(struct sock *sk)
>  
>  	ctx->tx_conf = TLS_BASE;
>  	ctx->rx_conf = TLS_BASE;
> +	ctx->tx_record_size_limit = TLS_MAX_PAYLOAD_SIZE;
>  	update_sk_prot(sk, ctx);
>  out:
>  	write_unlock_bh(&sk->sk_callback_lock);
> @@ -1065,7 +1119,7 @@ static u16 tls_user_config(struct tls_context *ctx, bool tx)
>  
>  static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
>  {
> -	u16 version, cipher_type;
> +	u16 version, cipher_type, tx_record_size_limit;
>  	struct tls_context *ctx;
>  	struct nlattr *start;
>  	int err;
> @@ -1110,7 +1164,13 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
>  		if (err)
>  			goto nla_failure;
>  	}
> -
> +	tx_record_size_limit = ctx->tx_record_size_limit;
> +	if (tx_record_size_limit) {

You probably meant to update that to:

    tx_record_size_limit != TLS_MAX_PAYLOAD_SIZE

Otherwise, now that the default is TLS_MAX_PAYLOAD_SIZE, it will
always be exported - which is not wrong either. So I'd either update
the conditional so that the attribute is only exported for non-default
sizes (like in v2), or drop the if() and always export it.

> +		err = nla_put_u16(skb, TLS_INFO_TX_RECORD_SIZE_LIM,
> +				  tx_record_size_limit);
> +		if (err)
> +			goto nla_failure;
> +	}

[...]
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index bac65d0d4e3e..28fb796573d1 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1079,7 +1079,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  		orig_size = msg_pl->sg.size;
>  		full_record = false;
>  		try_to_copy = msg_data_left(msg);
> -		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
> +		record_room = tls_ctx->tx_record_size_limit - msg_pl->sg.size;

If we entered tls_sw_sendmsg_locked with an existing open record, this
could end up being negative and confuse the rest of the code.

    send(MSG_MORE) returns with an open record of length len1
    setsockopt(TLS_INFO_TX_RECORD_SIZE_LIM, limit < len1)
    send() -> record_room < 0


Possibly not a problem with a "well-behaved" userspace, but we can't
rely on that.


Pushing out the pending "too big" record at the time we set
tx_record_size_limit would likely make the peer close the connection
(because it's already told us to limit our TX size), so I guess we'd
have to split the pending record into tx_record_size_limit chunks
before we start processing the new message (either directly at
setsockopt(TLS_INFO_TX_RECORD_SIZE_LIM) time, or the next send/etc
call). The final push during socket closing, and maybe some more
codepaths that deal with ctx->open_rec, would also have to do that.

I think additional selftests for
    send(MSG_MORE), TLS_INFO_TX_RECORD_SIZE_LIM, send
and
    send(MSG_MORE), TLS_INFO_TX_RECORD_SIZE_LIM, close
verifying the received record sizes would make sense, since it's a bit
tricky to get that right.

-- 
Sabrina

