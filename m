Return-Path: <netdev+bounces-159657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013EA16486
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 00:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D659B188427D
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 23:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4EE1A3029;
	Sun, 19 Jan 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="h6O3srhq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vRcwt4ki"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C49257D
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737328801; cv=none; b=K178dC+eNO0YuvAbuIvO7sxMNalpz7nGv78d8QukYzYe/Eqf4aUATOTFuoayaWqSryrPfwAIwPtxPDG/p0G36nfCwdzF6a0BWmzP/SWozUR96em1ULUedEq3YBPx32WbZlREq8RpRJaNIoAYdE6y7PCOrs0HBXedixu4P0v+n6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737328801; c=relaxed/simple;
	bh=+dLljEIl98EzClRj2I6gW12NVULRXT+g0D0v8urMjj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkG8NlnYj6rBcP3HASu9DKjU5HjaPB4CLgc/FdIae3sB/Dw5I9mqiyxdl60FBwOpf7MeL2+0odosIpJkIcaH/DD04ngz8nYEYx5DXauYwwgf/n2cf4sl/DpP4f71hFU1ml3SUIQxyA1OGnfKahiUPZg0PeSr4FWiv11SesVdYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=h6O3srhq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vRcwt4ki; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 905C51380E3E;
	Sun, 19 Jan 2025 18:19:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 19 Jan 2025 18:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1737328796; x=
	1737415196; bh=WKRybKKNFvzN+i+Mgxi17WxjMlxFqG/5He9JH4oUCJQ=; b=h
	6O3srhqKXxOnDZ5uaX+Tey6U/74MKvvmu9I8ovXilxhjEPjmlPIL6y8dO/ijKlBR
	/L8vzGL6kyM83aZzoIc2Xns0f9Fut/Xtr2XP+uNZgA08TFkhn0ZeFXiqxe9cTOHx
	nAA1RQZtKyWtlmqTQ09xeyq9z1LHsPMX/E3s+xm4elkCTDIw5VoihbDfII5jAhyq
	UjduCWPqTGdALY8XJiy9oGiXYSGVynAg4OpJc+/agh/yp/OVfO38oasHX00W9Fet
	1ngAZ6yNOHbsniIPVndSE+zJqcK5oGc7Sl63osPIaRuNmvZPsH5gvDaHKmyiX/R0
	VsklSp/l30xzuOCWghhXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737328796; x=1737415196; bh=WKRybKKNFvzN+i+Mgxi17WxjMlxFqG/5He9
	JH4oUCJQ=; b=vRcwt4kiQvHZuHbrAj46/n7Z+u/I4E9DzO19lfhOdARCxpD1nSO
	emKTeSvoyti3raXqZCu7fl2t5BYAtHnp8FJOia9EAQ+/L2q/4iUGDuzMk/X/on+t
	FZ9i/qWue5eSTce/mNbTFyeeymPpDnI/JiLm2iRUFLxqN6WpndW+4eIqdghzGgqJ
	vIueuAGdDH1YOEJFI3PwZyW28m5xtyoZW9q5vN5LFYO44xq6ve8ccvGUkXxr8nOc
	l4EwHK3GMqzYLsnKP0UGPJCY7n/lzsFtpmWofyDx7icrIwPTItvxW9W4TsPF+Sbc
	xWQR9jlVCjdSdLJOzLH25paUXrVYqUhCYqQ==
X-ME-Sender: <xms:nIiNZ3gMnIPCxRDk5uHavod-LZN7eUP3QCXDJ1UTKL57OnthyvH45g>
    <xme:nIiNZ0A7OxOWaH_pbyFHB8j6sULZb3Aj8liHKDIEFKRR3HCi6gYj9MXbekA5YCdYb
    yaZcIGC89-KpwPKku4>
X-ME-Received: <xmr:nIiNZ3ES1H3nVPSgR1lkQCQgevfJ05xdKVaxDm1yD8Kdte0zD9AASwJK8WYH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeikedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgviigsvg
    gurgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepmhgrhihflhhofigvrhgvrhgrsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:nIiNZ0TM7F6jSOJUF8AIeb4Qj1ezLpUbtzvg7ltF4pE_dqjiWdGLbw>
    <xmx:nIiNZ0zVS639P-yTVvB4poy5OwLS143fy8w7q8E2h-04Wf5Fwpj0Pw>
    <xmx:nIiNZ6614vVgMShvsBWBU2M2mcdv2VBDYMivSG1bW99Yb6i09A5nqQ>
    <xmx:nIiNZ5xAxzNcakLBywcp7Q3g4jMz8MIvxiiexTB67znAQ1O5zYF3Lw>
    <xmx:nIiNZw_j3roDI_A5xJhdEliJWYYD8hFAFmtY9-gnY8l4ZkUIGTjWn1iI>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jan 2025 18:19:55 -0500 (EST)
Date: Mon, 20 Jan 2025 00:19:53 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ales Nezbeda <anezbeda@redhat.com>
Cc: netdev@vger.kernel.org, mayflowerera@gmail.com
Subject: Re: [PATCH net-next] net: macsec: Add endianness annotations in salt
 struct
Message-ID: <Z42Imd8YTQbZL8va@hog>
References: <20250117112228.90948-1-anezbeda@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117112228.90948-1-anezbeda@redhat.com>

2025-01-17, 12:22:28 +0100, Ales Nezbeda wrote:
> This change resolves warning produced by sparse tool as currently
> there is a mismatch between normal generic type in salt and endian
> annotated type in macsec driver code. Endian annotated types should
> be used here.
> 
> Sparse output:
> warning: restricted ssci_t degrades to integer
> warning: incorrect type in assignment (different base types)
>     expected restricted ssci_t [usertype] ssci
>     got unsigned int
> warning: restricted __be64 degrades to integer
> warning: incorrect type in assignment (different base types)
>     expected restricted __be64 [usertype] pn
>     got unsigned long long
> 
> Signed-off-by: Ales Nezbeda <anezbeda@redhat.com>
> ---
>  include/net/macsec.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

