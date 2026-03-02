Return-Path: <netdev+bounces-262681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDmFBVijpWngCwAAu9opvQ
	(envelope-from <netdev+bounces-262681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:48:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B071DB24D
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388A93071A5D
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360733F075A;
	Mon,  2 Mar 2026 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dlPF4pya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xcANsfwI"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6EE3FD13E
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462632; cv=none; b=VTcnk2zFLaWbFE5AeH+cFkyyf505vVLCdyC/AcaGQK1yOiqVg13dw2D16wwolWLaH/CEVqtF2t5hFWeZgT6mCfEVWYU7nRXy5hBjTVkAyFajRyb9FAnibQosoeBn533J4jZ1z4FqkDkuEyk7gv3zR0AnsZ7k5EiyrdC4krg4cvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462632; c=relaxed/simple;
	bh=RQGmZZ8CEhR1S209GcP/TlrZH674Q1jePi2YgB5Jt2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBmVqT7mhSP3qdD02liWZNIfnPA2X6bHxzZCQLhc1AZATeFLqJWbshYlnfI3+/VQrgtP9t349EXDdU1lY99+2TEafGLcIL2TiTUXRCs4qeicl7P/sbv8gas+PHMarheFZ3lpzGq8KM2Mq+r9vqHHKuJnZda8DIm8vZFBF75texo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dlPF4pya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xcANsfwI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F9C91D001AD;
	Mon,  2 Mar 2026 09:43:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 09:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772462627; x=
	1772549027; bh=MARMD3Ck8MulvZzKCwCpHskTpJ6yye/yw1QtgDrg/18=; b=d
	lPF4pyapd3EDMVErw2Tgn0x8CsF4xk88rZKfvFo3xMwQPmNV+ESECJCH588KYGF5
	l2FYorsLXFFliX+zGucUlBvAvs0W/DDKM2UwfVV6JXSf00kgFkjGkjLMnw4PuI1u
	cSSqpq0Sulkv2jGkc3bwvNI/mkmhIJ/mjqvYBegwTaEg8b2ht7tp+bPTp1W93uUp
	HX5Ribe0lW0gj4AevCBKhjoWR8WjGTBlgRU+g5QXU9LFD9uzUAje0MZTG9LKLvBR
	H58NL84ZTkLJZQ6mVpKaC3Y9fM4EWvPTDfsEG2e3NVRtDVew2+sIOs8spgj4LQtK
	osou8EXUl5eLRbe66theQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772462627; x=1772549027; bh=MARMD3Ck8MulvZzKCwCpHskTpJ6yye/yw1Q
	tgDrg/18=; b=xcANsfwIttP5RZzLLoCMyW0i4hCiizPspwj0CkCJFevoh6zVf4e
	aGADnmhqqzl7a1r9u3wXGcLsJVtJ/qtjyGRPcH4ev1Nvr7yue5yWhY+7fv+kjnkE
	EdQAEw1WcFOKEryngGSUgDoJZOuQBlRmXDKRy11u0J2tA6qbKueoZrswdPOtM21E
	lqV6kbSi091DR3FMWLBAH0fA+jaj7RmBCtR17sBd0yiUs9zkVUYuB2r6+5ou1vLY
	dBR9ZGdsnoQljbzaeFo0JlrrJxnupCuaYqSDYm0DDzDDN5lcsxFomSTFvr3G6DmY
	M4JqmrLx9tVTZAfcxBzkwYXyxZ4D7X7wO0w==
X-ME-Sender: <xms:IqKlaWfVtWVB6rOHJZmjwr6UgaFqL9kKxst15ehBvJmy2_GWrc_4ZQ>
    <xme:IqKlaevuhNhHLBei-r9rfC2-BtDKJ-jFAzcj-xP8tMi_R01FkGKM5Kjhn82NrUFyS
    p0MGGvGX7TdDOTA2q4UPekkO4QsXQ8rFKdg9_4Vj4vqQSILD5nqR-E>
X-ME-Received: <xmr:IqKlaTAbA0gKQHeEzPxDjM1fFIsxjICPuBisYuqF7nmsTSSb3sXnomYxuahj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhmrghntggvrhgrsehsuhhsvgdruggvpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepsghrihgughgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhhooh
    hprgestghumhhulhhushhnvghtfihorhhkshdrtghomhdprhgtphhtthhopehsughfsehf
    ohhmihgthhgvvhdrmhgvpdhrtghpthhtohepphgvthhrmhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihguohhs
    tghhsehnvhhiughirgdrtghomhdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlh
    hlrdhorhhg
X-ME-Proxy: <xmx:IqKlaeFGewbUEyu1s6_Zrf2FsddK5ftcwDTk_XKCatBIoaDzkrO-Rg>
    <xmx:IqKlabvTdzoGfXDJ4VzcbTUt3m8NT-kKF3iUdpAbds0YumEoczQQhQ>
    <xmx:IqKlacm5XirjKiuFF3qDWpmZgNnSCRokEtF5jD2masfUErU4fW7yKg>
    <xmx:IqKlaWPFwD_EX_v8NSs-oYmr2zteG9rMNqUOgmvT_SULDuN7Rit8UA>
    <xmx:I6KlaWGE2v_-VX5oe3GRkNCSnsbCG1L2i-LBmDflGZr5VDZhWMWGVbGz>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 09:43:45 -0500 (EST)
Date: Mon, 2 Mar 2026 15:43:43 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
	roopa@cumulusnetworks.com, sdf@fomichev.me, petrm@nvidia.com,
	horms@kernel.org, idosch@nvidia.com, razor@blackwall.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch
Subject: Re: [PATCH 2/2 net v2] net: vxlan: fix nd_tbl NULL dereference when
 IPv6 is disabled
Message-ID: <aaWiH5KBf-n1NxAR@krikkit>
References: <20260302140847.5941-1-fmancera@suse.de>
 <20260302140847.5941-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302140847.5941-2-fmancera@suse.de>
X-Rspamd-Queue-Id: 30B071DB24D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262681-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-03-02, 15:08:47 +0100, Fernando Fernandez Mancera wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> initialized because inet6_init() exits before ndisc_init() is called
> which initializes it. If an IPv6 packet is injected into the interface,
> route_shortcircuit() is called and a NULL pointer dereference happens on
> neigh_lookup().

VXLAN can be built-in even when IPv6 is built as a module, and then
ipv6_mod_enabled can't be used in VXLAN:

ld: drivers/net/vxlan/vxlan_core.o: in function `route_shortcircuit':
drivers/net/vxlan/vxlan_core.c:2133:(.text+0x116e0): undefined reference to `ipv6_mod_enabled'


GENEVE has a Kconfig tweak to prevent this since 094be0927ff3
("geneve: fix build with modular IPV6"):

    depends on IPV6 || !IPV6

but VXLAN doesn't.

But then I think we don't need to use ipv6_stub at all.

-- 
Sabrina

