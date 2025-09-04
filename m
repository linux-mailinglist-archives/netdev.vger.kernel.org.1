Return-Path: <netdev+bounces-219858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5395B4381B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BD27C6A92
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347072FB627;
	Thu,  4 Sep 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="LOqV4gh2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IJHauAGD"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1082F90EB;
	Thu,  4 Sep 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980655; cv=none; b=NKU2gSsldCui/MHbxoyt6ViqVJRx7GTTLsoFy9LBeqMbu+fWaWFkCGWIF6+HFMPqfbgk5wNSnxaz24nZAJGFh4JW+QpDL8KMGgZT0dsi/qrEEcy5kOGL5Vzfm99PRCKKuRuZSPOZtoz3F6L9uT4ULiGlW0ygx3ysOz1QibxyoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980655; c=relaxed/simple;
	bh=he2ixPyhfBnTa8BUkz9b38l/3pz2UvhSj7kJJJELOm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQQazZPKOZBiEEsriyGtnUOLxuNuNg0023jKugl2z/7yLBJLwd6I99v3TwdCCzitq2UGkAOmUoAnYQXgqmWO6RVfW3Rxz7P7BxfXcq7Nb3NywELHR3W/zBLuB5vsqLxf7TuJoiQ6fMvJxmOXCeeWRLTfLq8NfI4RUYDURW4HgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=LOqV4gh2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IJHauAGD; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 912EBEC0B50;
	Thu,  4 Sep 2025 06:10:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 04 Sep 2025 06:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756980651; x=
	1757067051; bh=v9XjdV8yn8LYgvGmcZ/ouM7oLjvV6mmr+bN6sF+7NlQ=; b=L
	OqV4gh2IgPa0r/DLzqIc0H7V0s2Nq2XOmlBVyelvu8Gqgzb5GfJW1SpseFtX4O1g
	0P/wqx7LHqJk37sylZ9cFFUyQ84n0Qb+3XldStInCiJinIag6lQUAxav8WaSE7ST
	3eH5ABh+BojFh85OmEJjmf6WyX8Ku+5Y8xdbXCh+49+NbQBiu4QCLVPtg9zfpOq7
	vwhCcNrCbRcfietPlbriNeaZCs9KNvz+JSL4A3FiyPsFeBdx34gJR0nM9fTY0cBu
	y8vh0SPgkL7SaVnr/eaFl/FTlX4vddDNOzhhLqYdxoTn5jQavVKLhHtWtBbTq6bW
	RZoQHVb8nc/lK9T+RlhNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756980651; x=1757067051; bh=v9XjdV8yn8LYgvGmcZ/ouM7oLjvV6mmr+bN
	6sF+7NlQ=; b=IJHauAGDxF/tGeJ23CKqU93MuqEarbdzN3OCiYoq65f5Woj10FK
	6OVJcE9pRb/zWsfFqywXq6aK0nm4fp45uFUAep4FtuKGuUJoQaS99aaIOHGcgpxE
	EK3snZynx7Sn3YsB2YrsdRwWyp7negDBJ9vbMXa493hnPmAM908Sj/V3ahg9lrly
	bGOMKxssHZopW6G1vQKw7fGzFxSKo3bCyCxE8NPP+xazhflu4qm17bi4MvFO4CSB
	718LM059ACk5H2AHJ9ftqhJ0p0w6iYgVIvopsJeflGgYKdGuaWoXPSv3Fv6QbIfp
	ffrpwS7TDl7B1T04jy5rDg0nX8JshdkMquA==
X-ME-Sender: <xms:q2W5aCNTVPfiNRXU2qcdJZv9rO4G1w3913TQbxChE97dpe4vsEl3Ww>
    <xme:q2W5aFhrWPK1L_dT3-hwvo_ailUrxeXYycHgLjxafliqAfNEofYCCppUkyxAqtsBl
    2BNzL80bzQcwZKH_aM>
X-ME-Received: <xmr:q2W5aGZEFyZB0karGxGCq55ilDD1AdBahj1PZG4dT2ipzeBox4BdDWpyfQ6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvuefffefg
    udffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrohhpvghnshhouhhrtggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuh
    hmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgr
    sggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q2W5aJhUH-TKzEfWYnbGYP_kB5x8E6BgtDRM5aXp_Y8sf5fLDd6Wdg>
    <xmx:q2W5aIaprJpk2QGxz4H9NvLfyzW_SOz2Fi6vd0Q6GIKHMJw0Bx2rmg>
    <xmx:q2W5aPMxISSJm3jRrUktdHn7a3_wd7IHpnSbc_0rdRdknG9EGpDS4A>
    <xmx:q2W5aJa6bRamWO2VGUIhAlu5xBzfgQMRfi-xOOz8NBzxliLQ5KRfHA>
    <xmx:q2W5aDgodx7333VaW7f552fg2qE2fzV1xcZLYOXzly5SCUmOglCknDn2>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 06:10:50 -0400 (EDT)
Date: Thu, 4 Sep 2025 12:10:48 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, john.fastabend@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, alistair.francis@wdc.com,
	dlemoal@kernel.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3] net/tls: support maximum record size limit
Message-ID: <aLllqGpa2gLVNRbw@krikkit>
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

2025-09-03, 11:47:57 +1000, Wilfred Mallawa wrote:
> +static int do_tls_setsockopt_tx_record_size(struct sock *sk, sockptr_t optval,
> +					    unsigned int optlen)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	u16 value;
> +
> +	if (sockptr_is_null(optval) || optlen != sizeof(value))
> +		return -EINVAL;
> +
> +	if (copy_from_sockptr(&value, optval, sizeof(value)))
> +		return -EFAULT;
> +
> +	if (ctx->prot_info.version == TLS_1_2_VERSION &&
> +	    value > TLS_MAX_PAYLOAD_SIZE)
> +		return -EINVAL;
> +
> +	if (ctx->prot_info.version == TLS_1_3_VERSION &&
> +	    value > TLS_MAX_PAYLOAD_SIZE + 1)
> +		return -EINVAL;

The RFC is not very explicit about this, but I think this +1 for
TLS1.3 is to allow an actual payload of TLS_MAX_PAYLOAD_SIZE and save
1B of room for the content_type that gets appended.

   This value is the length of the plaintext of a protected record.  The
   value includes the content type and padding added in TLS 1.3 (that
   is, the complete length of TLSInnerPlaintext).

AFAIU we don't actually want to stuff TLS_MAX_PAYLOAD_SIZE+1 bytes of
payload into a record.

If we set tx_record_size_limit to TLS_MAX_PAYLOAD_SIZE+1, we'll end up
sending a record with a plaintext of TLS_MAX_PAYLOAD_SIZE+2 bytes
(TLS_MAX_PAYLOAD_SIZE+1 of payload, then 1B of content_type), and a
"normal" implementation will reject the record since it's too big
(ktls does that in net/tls/tls_sw.c:tls_rx_msg_size).

So we should subtract 1 from the userspace-provided value for 1.3, and
then add it back in getsockopt/tls_get_info.

Or maybe userspace should provide the desired payload limit, instead
of the raw record_size_limit it got from the extension (ie, do -1 when
needed before calling the setsockopt). Then we should rename this
"tx_payload_size_limit" (and adjust the docs) to make it clear it's
not the raw record_size_limit.

The "tx_payload_size_limit" approach is maybe a little bit simpler
(not having to add/subtract 1 in a few places - I think userspace
would only have to do it in one place).


Wilfred, Jakub, what do you think?


> +	ctx->tx_record_size_limit = value;
> +
> +	return 0;
> +}

-- 
Sabrina

