Return-Path: <netdev+bounces-273154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFspCLhsymnG8gUAu9opvQ
	(envelope-from <netdev+bounces-273154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:29:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7988835B0CB
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09FB30315F9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA943CB2CF;
	Mon, 30 Mar 2026 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Cn1Cx6iy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sDfwG2rm"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9321ADB7
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873282; cv=none; b=d6e3314C6i81rrhkpGZBRRRiBLYZRwLMnIfWcX10ryLFvIV09QAuK5ovsQUwvG9Fex28w5aAWBTx2gLdK7pry6py7pq9bnNm+OPU81+q9PQ8K0RFSH5BrrbRrivjFDXF7yAzMY9or0GRdUsMydB4KEZYBQmSzC49hgSxhC/l5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873282; c=relaxed/simple;
	bh=H58ZOxAA8Prrsxvn0rvvpv6/79jQvckRmc43jSqh4eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxRFkG6V9vQ0i4rOpv9kDs8FEIqf9XKaVw4KJKc2SEkAWgQdfelKBrUjJByn4T7WA9U3drxqNTUqze4zxRBRLfyyRI2v5pVlEqITze46TKUtyfI451mdsp8uTDe/H3hA0eeIJr8KDGdO2uPRKezKc/h/DY6m0LPRyiLQ+aUHVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Cn1Cx6iy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sDfwG2rm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBE587A0350;
	Mon, 30 Mar 2026 08:21:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 30 Mar 2026 08:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774873278; x=
	1774959678; bh=iDGXxnYuZkuyWCiJ5MY8Rgi9ZzEn0kbLlYEcYgsUFbw=; b=C
	n1Cx6iyDD3aBb+Rwh9Non/vhKtzYUzkRTqUsXwmN7KiFDP47uD7h3Y0etnfI88YV
	mkteGC6mKfHKWthIA7p3LdeiKjZ6pBCpG2MGbQyHiLUss9bDZDnVYAevObegVgbg
	CTyxe5sVQHFm2/m74sE9mIoOGgz76awAtXu2pDSLN/mVCsdq/16YBThMeCKH6u84
	AUlJhAbc/aVWX2dfjiYCWxGRdYPCEtrsZ118E0llxZbtQhVBsoHiPtqqtamSlENe
	6yvjl/wtRvnSNMlAsw1fI0aMQpig2qVpxqfEhgaIRJ+PYOQYlYjAASORBYQT/eRt
	hLseejNIa7sz+Du38NG9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774873278; x=1774959678; bh=iDGXxnYuZkuyWCiJ5MY8Rgi9ZzEn0kbLlYE
	cYgsUFbw=; b=sDfwG2rmzgg9vAlMsEDxyNyIWyV6fudYRv5mexnBb/SWlPqhRYc
	enYzFDKYXtpaen3SlxMWt50Lc6OVj5da6jUY5XkIxWyP2miJUriDoXIIeld1i4DN
	0kqDdi94sD0m+A4ipuRBIErIWm0croGOPYSSgZ/LkGLXeeJA6uuwHEvc0j2lgz32
	T/6a7Lp7AJx+p3wew+rsaM5G7vYtASeRJFD+X8h2IDALPcLhck2NiX0mXa5eu0AU
	HKystryGDLk/AMXufA2DAZ+sQlf5Qe2TJ/BEFrE2k3etpme5sQHVL837WrWoRzcf
	eGYNagGwubwB+gvkzOc3OV4rK9gIfbcawcg==
X-ME-Sender: <xms:vmrKaXNS8AptPSEaDlYSEZx6219rZMgeGLMrty-3ZNmb9paOEfwzmw>
    <xme:vmrKab-KU8Mp2lVEQB_xweRnJ_KxifdGC9TRU_dTdCXqFJ9-cvlO_0gzmDnZ3z0qA
    gCFYCfhBXy829yzZMYB7rd5kbUdP_4xYwMF68xi1xV1Rj8CqA0F8s8>
X-ME-Received: <xmr:vmrKac47jOtWCIsAZkeiVRCQHiHmJt9AVxCEerXs9g_4FBvWY4D0ctkKJfXn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
    pdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhm
X-ME-Proxy: <xmx:vmrKaZ6IEO9Qu3b4mLx8ayvHXODrxt0ZH2ARXtqg0UlTBFQlY2pDKQ>
    <xmx:vmrKadpvMx3ox6nh4VlQl8XsFp8zv_2A87XCFVAtN6oaEl9XyfLL4A>
    <xmx:vmrKaSNcEAEbqAriRawZrNhlwNnoG40W3gda2SNOodFTg3fdt1qpoQ>
    <xmx:vmrKad2BIPhS3liHhy0kfAOEYpOuPg3UAwT-XY4TkD4QKIFqvWv2fQ>
    <xmx:vmrKac-uWF5mMCea_8QcPyFdtUuo0oDD07HldPs1COC2jDqgCmhUMY8k>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 08:21:17 -0400 (EDT)
Date: Mon, 30 Mar 2026 14:21:16 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v7 3/5] tls: Factor tls_strp_msg_release() from
 tls_strp_msg_done()
Message-ID: <acpqvDQEaQ0nE0u6@krikkit>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
 <20260328-tls-read-sock-v7-3-15678415dfc1@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260328-tls-read-sock-v7-3-15678415dfc1@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273154-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,queasysnail.net:dkim,queasysnail.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 7988835B0CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-28, 11:17:10 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> tls_strp_msg_done() conflates releasing the current record with
> checking for the next one via tls_strp_check_rcv(). Batch
> processing requires releasing a record without immediately
> triggering that check, so the release step is separated into
> tls_strp_msg_release(). tls_strp_msg_done() is preserved as a
> wrapper for existing callers.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls.h      |  1 +
>  net/tls/tls_strp.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

