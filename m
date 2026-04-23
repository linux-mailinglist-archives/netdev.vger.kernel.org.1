Return-Path: <netdev+bounces-280885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHBDAcyc6mnF1QIAu9opvQ
	(envelope-from <netdev+bounces-280885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:27:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76145820B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D70A6300821F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992EC3603C9;
	Thu, 23 Apr 2026 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TVTbuRAV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6wmyyVt"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD433436A
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776983237; cv=none; b=kK62OMykw7Gm7A+T7kVkfhFNRqHIeiADgSGhjmyHs8D1Be/+TpqCwJGAIFUE/xlTCMLZd3DZV38PwxLczPwSvs85alxH/kP1d71zYwfBEUz40MF3igFURS+5DmglLH5vb+bW/KsBw6UZL1qiwYZsw1/aLFoC+ReOJ40khVzxsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776983237; c=relaxed/simple;
	bh=K/rv7vg9o1YKpDguK+R50Qfy17vzgHgNh9qMLvluVBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERlT4ao+gHZszZuzb7yheLpGksiztIUoMNOYa6KGzCbybdxC+tOrIhhEo68oaqIugGygQImzG1n3B93n4CzfqVmGQQhKy28ys2BR7hOQ9yX8xLxbtFOGg6W5RTD2/2aaO+S8mg6xyDdYpN+8MLcl5jzAt54zwf82mLyrYhLZbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TVTbuRAV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6wmyyVt; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 52AB17A0140;
	Thu, 23 Apr 2026 18:27:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Apr 2026 18:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1776983233; x=
	1777069633; bh=VN2AmLlnP64m1QZ3DL+eF3J0eOsS0udkViE9JKY2i6c=; b=T
	VTbuRAVLWFhgECrY8GBvfgeB8OKwpRkH0OuUBU+XAlu+0z5GB0Tr+7LoE+Rpd3yn
	jnOXgNE0bGYzDYO+C5oQHV+rShp5Wfn+cbjsrVN5KyOlrJGSmURF+A17gb03dLkJ
	g/JfzVCSNAVa5CAPA5mDsXaBdYOtFOkT+AHpTm3CVNNE19u851k2ci35+Vh/3cro
	5maGI6mVSY6fiCl6Lsik8UDMVIxpQnvQoTzkjhTxnAiTQKSSRA/QiTyYfqyu+c4W
	4wKLzTtfZe7beS5Sic/TRSd0U8vxKmxSM1WHNlhAi9gJOzNn8LZxglZeblEs5HfX
	NU8R/Wv20uCf2FZVoCSDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776983233; x=1777069633; bh=VN2AmLlnP64m1QZ3DL+eF3J0eOsS0udkViE
	9JKY2i6c=; b=M6wmyyVtPXjj5VD2VJTV4AJwcPuh8sGI2j4pw9SSZCNFz+AWa0A
	GQiCxmJ1uXYQ4uSRYobcpqv9+SQYbPtJBkHxaREhu3HBWf8y4JOYZCY3tF8ePBY7
	Yot1Bo+yr4exZElXnPWWhCPhAwHMd9dkQzAQJXNN/Jt9VKOqdkC/XRIKcozpZDIo
	ZJ4iNROoOKYTyy8c+CRTorz6sCHw3o33tggpoBo+ZwRaZWJknU5cFyCiFtT6pkQa
	po48LmK07+Ccq7qiiS9QAzyvrj1khKCdGiaR5EiApVtYYBdJAieX3DpbQvYwgk56
	T8fUKbWutulTUwJ4/P+o36KncUA1iaiQNBw==
X-ME-Sender: <xms:wJzqaa3cl6za5C1-haRoaysM7dBXtd08BYtxxH-xfdd97EvkztBYDA>
    <xme:wJzqafpDHJU0RkDos6MJlXNIbWRCHgy-MIA8h7XqigI8hBTfFXsqE8NJals4ak0fI
    0_p85WuZhcAAhstj68cIgyJp6AuGV45cDn692JsKcE9aUv9EjawXkY>
X-ME-Received: <xmr:wJzqaWhisd9-COnzj7b8yM9IlbtXZK6ZMlML_rRpys9YDXCew_HzhCqvZkut>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrlhhfsehmrghnug
    gvlhgsihhtrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhmpdhrtghpthhtohepihhmvhegsggvlhesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:wJzqab8LXZKMAdjG9f8x1tAIVxnnEKOQIujyrZH0tUgN5sWbc7Ya0Q>
    <xmx:wJzqaSXKv-F7LakomHPS_xkW2t0x4Tr7ZsNG07ROEH82TjtIJLHfxQ>
    <xmx:wJzqafAFBPCrEK4p89Si0HYZMn1ANF4REN80UMhs56u75Mk4-fg2cw>
    <xmx:wJzqaXEjUzEioN6MmdbzFt-_X81a9CFGUhVcidKUkDgnmmLg3hiBtw>
    <xmx:wZzqaXdEspw62baSWFUnExk9hLhbw7ajwX5bHaAeUXFBMK3uPAGwmpir>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 18:27:12 -0400 (EDT)
Date: Fri, 24 Apr 2026 00:27:10 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Ralf Lici <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <aeqcvgufY0F50rkU@krikkit>
References: <20260422123242.530882-1-antonio@openvpn.net>
 <20260422123242.530882-2-antonio@openvpn.net>
 <20260422192050.7c4ca760@kernel.org>
 <7481bc31-44f6-43ae-b3aa-07002644d9e6@openvpn.net>
 <9221605c-ad31-44f9-b3b7-db2237f75eb7@openvpn.net>
 <aepK3XXc8IFemb1Z@krikkit>
 <20260423103628.4ce6fc05@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423103628.4ce6fc05@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280885-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[openvpn.net,vger.kernel.org,mandelbit.com,redhat.com,lunn.ch,davemloft.net,google.com,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E76145820B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-23, 10:36:28 -0700, Jakub Kicinski wrote:
> On Thu, 23 Apr 2026 18:37:49 +0200 Sabrina Dubroca wrote:
> > We could also wrap all of ovpn_peer_add (including the new reg_state
> > check) in netdev_lock, since we can't move to NETREG_UNREGISTERING
> > until netdev_lock is released (then I think we wouldn't need the
> > READ_ONCE(reg_state)). But I don't know if that's an acceptable use of
> > netdev_lock.
> 
> Yup, fwiw it's a perfectly legitimate use case.

Ok. There's still a worrying bit in nesting lock_sock under
netdev_lock (ovpn_peer_add -> netdev_lock -> ovpn_peer_add_p2p ->
unlock_ovpn -> ovpn_socket_release -> lock_sock).

-- 
Sabrina

