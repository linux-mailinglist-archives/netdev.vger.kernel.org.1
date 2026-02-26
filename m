Return-Path: <netdev+bounces-261506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHAGIE+PoGkokwQAu9opvQ
	(envelope-from <netdev+bounces-261506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:22:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D986E1AD80E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF89C339ECB0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3630A2D94A7;
	Thu, 26 Feb 2026 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ri5pOTPE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="czHdkoBw"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103C36894C;
	Thu, 26 Feb 2026 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125666; cv=none; b=cjadzEjqJtHJXeq0NXcPQnpqtbm79xhGq9kmBQVr6BkkDwnP4RyESUpa9H2bP6AAP+5+sET2hAXQfh5w1JOe+fFyKWhzcXH8oMEVMJa30zBb/pm/KIwsc3gYqPXc/DOu2Ns8tnNuB2wYlQIB81nqXMPzJqLWaDcFHax/HOQ4y1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125666; c=relaxed/simple;
	bh=qL8yf5Fb87ia4qvQLlKVREwYwWeCvz/AnaAnqTHivGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvTny3+B7MIDvGJrv38FqoskFQjYGbnaIN+uBQJtldPqU6Hx77OcRsjdgIDObzEs8dgYoFAfpa/ReWoPrinBnMV2nhktwoza/cyFcZzT7pMXMszE5wCVwp0psTgcjudNV98jMBTYVQbPddD6pcf0m9/tFNWGZ/ZD2Pb36gxEE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ri5pOTPE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=czHdkoBw; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F88E140019C;
	Thu, 26 Feb 2026 12:07:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 26 Feb 2026 12:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1772125664; x=
	1772212064; bh=qrEhLGBKPCPgeCjcD69oIlStutQ/XLF1nkt6RmWDL/Y=; b=r
	i5pOTPEIMFKaJlJi+91tzEbHpPLYTF8uL6kCT+HSMYOh2Pddbhn8xkdeR2Jpe/L2
	AZPTcwHZgtxiiqOCelmDaogEEg0aGVhhEQy+ob+ANwATfblK7My7T9zVfCJlPYoX
	rXsxzo1URjryyMbwgSAuxmjvYnvwykJmJzZLj/qgyNOhuzTV7xhbvf1XfJ/Jb/CP
	sIBv2c7iBmcPHjLj+HVk/c3f6H7I0IAkOul97XPz1czqZ7yQFITA7Jefsf5zQUhZ
	k0UXP/PipdSEzB9xzVc8I3FSmJ5Za6Dqql+FPQ0IzcTgBhRKxQXuOjoGf3O5DXl9
	rZf+Ph3mLpxfStg6avhJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772125664; x=1772212064; bh=qrEhLGBKPCPgeCjcD69oIlStutQ/XLF1nkt
	6RmWDL/Y=; b=czHdkoBwcirLGCOhLAz/01K7S4sCmgSL252boBdIjwRzQyi5pEp
	v+ERtsk5Z2TB5Fy3z1J6quzR41Uv/KJyUceiy00e97zlPMuevlY96iIBhFeFUgaE
	REwQviJROPfdkqHpyiDpbGb3mwpWLosDngawW7YvvlbpXQMTCCNVVh11YJbSS5vf
	XpjJW3aEN0WXyCTYTZUCl/mRAgDYetMBFvVkrh+c4/qlzLPqDwuQYErZew5hSTLn
	bCArxOILK+SMAbAGd004322sJW0xpfmwLD53bmX2HE5/c2j3Dcb48KYL+x99uIdh
	0ZK2jd/pJwtON3x1U6un0KrpLgQUpU9+cRw==
X-ME-Sender: <xms:332gaRE6GkhT4UbadenGwcIAQ37_C4hQ4rAF-OU71IIk3lOOi4Ab6A>
    <xme:332gadlMeVBYiwjEePAmxBf4Z63789FQImAYZb90kYl2Pjf7jA-sXXLI2SEnHmxzj
    PX5GKh6oC3pcHmOOOwHq7ECYViJPBYwGBWwA7oP9mOMYmEbepSAvKM>
X-ME-Received: <xmr:332gaeD1PHXjvNTHg32YRNOof1wg264uyDQ7-R5I0TXyDtgcuWQTEIe8aCgT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgvtg
    hunhgvthdrtghomhdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgv
    tghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheptghhihgrtghhrghnghifrghnghesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:332gaXB4xrk_31T18EIvSWoc3xDEXKnJF1esW0VtUouZHpJVPlxZaw>
    <xmx:332gadEmFC-lUJyQBUa4SDaNbs6GRil0p1ca1lmhxT-aNW_wsBwpfA>
    <xmx:332gaW7gmw_FjJJJza6KRE5OHAG7PSH8L3NvFYAe3qYJkl1x063GjA>
    <xmx:332gacTiSTu_A-wcKlCZuqxgbHVLfYn0LdVPKmW7Tf_QPsd6HBuM3A>
    <xmx:4H2gaSNUmL9Bme7xWLl8dN2mSHm5h28QraYMtxLOq3sGfvx5l0LgAneV>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 12:07:43 -0500 (EST)
Date: Thu, 26 Feb 2026 18:07:41 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ipsec-next v5 1/8] xfrm: add missing __rcu annotation to
 nlsk
Message-ID: <aaB93d-GoW2eREHa@krikkit>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <9e8623132cb8001bce5bdf97e0c4591101b6dff9.1769509131.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e8623132cb8001bce5bdf97e0c4591101b6dff9.1769509131.git.antony.antony@secunet.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261506-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: D986E1AD80E
X-Rspamd-Action: no action

2026-01-27, 11:42:01 +0100, Antony Antony wrote:
> The nlsk field in struct netns_xfrm is RCU-protected, as seen by
> the use of rcu_assign_pointer() and RCU_INIT_POINTER() when updating
> it.
> However, the field lacks the __rcu annotation, and most read-side
> accesses don't use rcu_dereference().
> 
> Add the missing __rcu annotation and convert all read-side accesses to
> use rcu_dereference() for correctness and to silence sparse warnings.
> 
> Sparse warning reported by NIPA allmodconfig test when modifying
> net/xfrm/xfrm_user.c. The warning is a pre-existing issue in
> xfrm_nlmsg_multicast(). This series added a new call to this function
> and NIPA testing reported a new warning was added by this series.
> 
> To reproduce (requires sparse):
> make C=2 net/xfrm/
> net/xfrm/xfrm_user.c:1574:29: error: incompatible types in comparison
> expression (different address spaces):
> net/xfrm/xfrm_user.c:1574:29:    struct sock [noderef] __rcu *
> net/xfrm/xfrm_user.c:1574:29:    struct sock *

BTW, after this, sparse will complain about the other accesses to nlsk
in net/xfrm/xfrm_user.c (in the nlmsg_unicast(net->xfrm.nlsk, ...)
calls).

I have a patch adding this __rcu annotation, and fixing the warnings
that it causes. It's part of the series I'm planning to submit very
soon, which fixes a lot of rcu-related warnings in net/xfrm/*.

-- 
Sabrina

