Return-Path: <netdev+bounces-286660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COuWAvzeAWptlgEAu9opvQ
	(envelope-from <netdev+bounces-286660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:51:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA350F593
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3D133014367
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EFE3BFE33;
	Mon, 11 May 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="QY8/lkSa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbY+Iw9B"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE633F59B;
	Mon, 11 May 2026 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507451; cv=none; b=MJxU6Uq5ZX3v/EwD9NLX9YSCaW8oKGSwK9DfmO2EZlZtENlXD1f1q558BkgRmjhKE/ctKPkQErVMMFYuylLMlTWksIytQ345XFrxKHQZxwDu6G1rSaIX8zBpsCPuffihoEUdR7YlJdeFAiDiUub6yVBcpdvosoWvVEyMn3vQ1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507451; c=relaxed/simple;
	bh=yAXhKQdTAuajKq+KiH4HBZ9PTBZlzMdMt7oEXvNI53w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em5nBf9PORJPp9z/HUfTG87zXvILH4gmwiBgMuUGzZVKSAwrcKGawk5OVznm8thbuOJofsUwGE0L7TobfnZw94TdOj6NBek8dL2c8WzwwiUPCLEownbWDhW+tZDeCuRcZf/EFXntB97T5VlCCUAhWd9mtnu2BZsLGVzD8JqLZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=QY8/lkSa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YbY+Iw9B; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30C271400088;
	Mon, 11 May 2026 09:50:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 11 May 2026 09:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778507448; x=
	1778593848; bh=ZXI24ZCigjX2i8ed3wSzDEVGe20y9EDO24W3iWUxVc4=; b=Q
	Y8/lkSaXf9oa1u+90HWmA5fD3ZHnMbGIF6oovGJfOLO8WvXVPbd6qJ/PSUiDW5DR
	DaH3nkilSZAcICx31JoQYH42WivAhlaB8mEUeJpiezxUNXrJ4nBRYKBXXwN1eIGh
	w8q7Ac/5336cPJCOTy1i4U35pfo2/uuDs15WMsIMq35d/1j4Yl8zYK12c14UdZXw
	RAtDhzE9YFQFhRDCH4x7+R0xfQCDh7wrScsiRTCOZ2XeAhEp08FiX5FD7q+Cou+N
	i4gIIsJKM4sEZaFJlpB7f+oLft4D5vrisqEhMnk9O/BawkzW0KI5NIBoigszzeHy
	Oc0AkaoJt09XVBWzXwt8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778507448; x=1778593848; bh=ZXI24ZCigjX2i8ed3wSzDEVGe20y9EDO24W
	3iWUxVc4=; b=YbY+Iw9BPWxT/7cZtvt0phYJ82je+TxB8q9w5xDpRwo/wvZYy8u
	Kt+nsj/C9jhxv2Kvk/Zz6O6h47PABwaP5u3qUK5kXiBTy4CznsR1XXtXkmsjytv/
	HXVE9RMGRayQrrps/ePD8sNuYq8oGSYpXF4MGcXVYC4MJ7CaNNgNTBQc0ecKnscI
	ukbuc87DrnGTBrXW/rBpVPT5W6Jnf6oqOFJCp9M96ZffjzPRuS+1hOgxGqGAFPko
	2RDHbrUFVc2JDudguzgOvm4mkm4ax8SBgTS3p6DvZMWUG5058/1ibmYwJ0oQd9qj
	xfY8Iu5iCWdXVmNMsNxIYEvOCuEulJmwcHw==
X-ME-Sender: <xms:t94BatfndB0EkSSxbSO1VeaCh8asGvEGJCVc7DZCQVvEopLCjJlqdQ>
    <xme:t94BagYoxu9zrZ36AeKBIHJXtLhnuIbMDchY2Jgux8RFxz63HxDBREStnPcrgY7P1
    zqbqc6tw7cgbUZlQ7NG1puNXkMIIIFyRkvNVR-hdPHdmP04nWQiezM>
X-ME-Received: <xmr:t94Bap72RlhwWF1NUr_FSJskxIi5HEFJPc0e1SCmh2TbgzzxxOY4FtVv_vIwCiKDheueHGtP-OqK5JxaZTMMfYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeltdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigjhhliihhvghnghesghhmrghilh
    drtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhr
    tghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvug
    humhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpth
    htohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssehs
    thhrvghsshhinhguuhhkthhiohhnrdhorhhgpdhrtghpthhtoheprghlsghinhifhigrnh
    hgsehtvghntggvnhhtrdgtohhm
X-ME-Proxy: <xmx:t94Bamc0j1NaKszkV5a5JTjWQK1RX10YkzCBCLJcwPiLoRConlkdyA>
    <xmx:t94BakxtfcD59_wybBRL2reu9qg7c_XQhEh38Ir3kzXo2tzaHg7E_A>
    <xmx:t94BakpRipA_epvDiBMh3mNGyOaMmhoD8krKy-Rdd8wQpV3Sl3H6Kg>
    <xmx:t94Baqyp4C4_iXyWZ7Ev6f3smNIHZ7QdeNwXQ0wVy2zV1_WQOWo3ow>
    <xmx:uN4BanpVg8S4obeusXLO5_LGTuMnkSnUX3FAWjRLMXSuzWZ3qb0prQoL>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 09:50:47 -0400 (EDT)
Date: Mon, 11 May 2026 15:50:46 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: alexjlzheng@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	hannes@stressinduktion.org, albinwyang@tencent.com,
	shenyangyang4@huawei.com, kuniyu@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH net v3 v3 3/3] macsec: use rcu_work to defer TX SA crypto
 cleanup out of softirq
Message-ID: <agHetsT5pty7ohpU@krikkit>
References: <20260509033353.1814289-1-alexjlzheng@tencent.com>
 <20260509033353.1814289-4-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260509033353.1814289-4-alexjlzheng@tencent.com>
X-Rspamd-Queue-Id: 97DA350F593
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-286660-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,queasysnail.net:email,queasysnail.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

2026-05-09, 11:33:47 +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> free_txsa() is an RCU callback running in softirq context, but calls
> crypto_free_aead() which can invoke vunmap() internally on hardware
> crypto drivers (e.g. hisi_sec2), triggering a kernel crash.
> 
> Use rcu_work to defer the cleanup to a workqueue, for the same reasons
> as the analogous fix to free_rxsa() in the previous patch.
> 
> Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  drivers/net/macsec.c | 8 +++++---
>  include/net/macsec.h | 3 ++-
>  2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

