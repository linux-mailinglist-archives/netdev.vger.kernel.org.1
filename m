Return-Path: <netdev+bounces-270803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJN0HDPJwWlUWgQAu9opvQ
	(envelope-from <netdev+bounces-270803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:13:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5BA2FECCD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D38230063BF
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8206D384252;
	Mon, 23 Mar 2026 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="vSYGVvmo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yi0gZHbz"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EB346AF1
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307309; cv=none; b=W5m6UwTW0cwhTZAWOATlQ4NQb6DnE6O1IAp/lJKZKZ0T4dBCXyzjIxRCJAo8XXCoK/K9CGzxYvR4qgkt733DR24PpA8n5Ooe3OsymUIEtulpc/uvK7yNM6zGgRC6PrQKuWqZIwJ7tpbM7XDffyNayxWZLFWQyp2caeVv+83oxb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307309; c=relaxed/simple;
	bh=RnfdW/9pBIpKQVUicB6bsMgC6DCsPPoPFYdYVOYBrPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6FfP8gpQpJLDMpk8zXu6TQmPXhUK/iE20ofEALDDUDXXUvStjxxbyzYSgXaYYHHMCeORR9+sDJhGZJMQuSisNLjnmtcLw9iuh/tm1MPs5umSndxIcuNkj0pVQZj6DpaNOJbCs6RLClLYoXmNAavdv6OyjppsPqbz6jASF85uG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=vSYGVvmo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yi0gZHbz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88304140023C;
	Mon, 23 Mar 2026 19:08:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Mar 2026 19:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774307306; x=
	1774393706; bh=kNO80lxUmDbPxGe1NY815tnXyLm4pm/WkvKISCnpC6M=; b=v
	SYGVvmokV8lJJRtCDXzYuM1s/FmgkNZOs1fiL8zCfnw62GMEaVYGEs2ypzr+lEb+
	4o4rOf4ohFRQlyBRMR/4Ge/lKRv48It7zSJKTupx6/Frzqef3DD4lb8Zjs48GNYO
	9Bk+wsZkoAW887O3Gy8gM1EtDtFUU1f1csEE8I6QJwXbSTYaEHi0O9dnnkr4kw1n
	uiK87tW1a5+iM6Xve8uSjgN71m/7OWzweX/4fQMf+jXpPdwFUrxudnht4DzZAH+c
	pPusl3QaczXlkXS3zSL+n0Q8IDURTFxZKPZHt96dZYKJ7qXX6w+zPqYIYZ1lWnT1
	HxUbkuE45Oqet+HZU0KJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774307306; x=1774393706; bh=kNO80lxUmDbPxGe1NY815tnXyLm4pm/WkvK
	ISCnpC6M=; b=Yi0gZHbzXd2+y3It+vT6cVyZcF+X6eou4vm1faYEJGmRtJxdPfJ
	rzwKfnYlHf/QXfnNhJyN0fq6vqX4TT6CkP5wAR2WVrKk7Y+9xpz3WhphOWDVs+7i
	yXgJujls/AKAYxfSsSUMmSDhNnTaU6x+dexxeJ04jr+7H9ka/wmqs6nmUZ3FIaab
	Gi6R1KRSjJQm5jQfinQMuJe7KBiDwsooEG0Rz2qA+LV5pDAa+Tp1MR91B9idZ1W+
	ZqGoXQMvtsPQU+RhWHznlv6HSfsgnhlZ4/YpaL5s+fvEESmfs/KIXilt5ZFa6L6W
	++N0vYOmbYv8T746LdzJQJL1b1X3uqH15pQ==
X-ME-Sender: <xms:6sfBafmKvCLEo8Ooe_vsRKwPHDVBVZG9Vh_3nUWeT4_-z4XfjeksPg>
    <xme:6sfBaThQXskTEtmOYHgW1qaNcVmEMLNrpf-TH3oAHolMLeQRITH36hd8TfYwvrBDS
    dDt0tbCXnz_BKkGVVrrc9PHHSLg4Yy-iI9e5BcPMFzaf5fs0Z6JGg>
X-ME-Received: <xmr:6sfBaT1Mj0Q-mQoPm305zyHKARvfWFEDdMicyz6ScBeCKJC1Noikz6_bfwsF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
X-ME-Proxy: <xmx:6sfBacKjC3AsYFQeGvekSbgvWV_tQ8QGvd-klvoAXvIxfY4IPk1-xw>
    <xmx:6sfBaTxhx9Bnk_SqWkTj3BaEXcu_-GmkOAGXt0dTzryLoFhZ8jm8qw>
    <xmx:6sfBaaVJ-T-QqsmD2ERgccU5OAeIRcRyFbiIT_TrYnWGbjF7A5tkIw>
    <xmx:6sfBaThX98IInSEl2FIsKQLlxAqtz8EuoxiP2qLFqXU-IOEV1aBlaw>
    <xmx:6sfBaStk14P6JPJ2fJh0YWfabs2px5uvTvscguOL65loGPnvEUspqp5d>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 19:08:25 -0400 (EDT)
Date: Tue, 24 Mar 2026 00:08:24 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH PATCH net-next v4 8/8] tls: Enable batch async decryption
 in read_sock
Message-ID: <acHH6NVykWZo5Q3Q@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
 <acFK4DWAD5h_Oc0f@krikkit>
 <5190a4bf-cc66-424e-9c67-ffb3ddb58030@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5190a4bf-cc66-424e-9c67-ffb3ddb58030@app.fastmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270803-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA5BA2FECCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-23, 11:04:16 -0400, Chuck Lever wrote:
> 
> On Mon, Mar 23, 2026, at 10:14 AM, Sabrina Dubroca wrote:
> > 2026-03-17, 11:04:21 -0400, Chuck Lever wrote:
> >> +/* Bound on concurrent async AEAD submissions per read_sock
> >> + * call.  Chosen to fill typical hardware crypto pipelines
> >> + * without excessive memory consumption (each in-flight record
> >> + * holds one cleartext skb plus its AEAD request context).
> >> + */
> >> +#define TLS_READ_SOCK_BATCH	16
> >
> > I suspect that at some point, we'll have a request to make this
> > configurable (maybe system-wide, maybe by socket?).
> 
> I appreciate your careful and close review. The series has
> improved significantly.
> 
> I will admit that the current value (16) is arbitrary. I agree
> that someone might want to modify this value. At this point,
> however, the constant is straightforward and it is still quite
> easy to promote to a tunable later if that proves to be needed.

Agreed.

> The right interface for this depends on kTLS consumer needs
> that aren't clear (to me) yet.

In this case (read_sock), the kTLS consumer is NVMe/TCP etc, and
specifically users of those features with crypto acceleration
cards. I'm not familiar with either.

> But let me know if you have a
> preferred API mechanism or a specific use case in mind, or if
> there is a netdev policy that should guide the introduction
> of a suitable API for this purpose.

Nothing specific, I just thought I'd mention it since I was replying
to the patch anyway. I think at this stage "it seems easy to promote
to a tunable later" is enough consideration (just to avoid getting
trapped in some API (or lack thereof) and unable to change it, but I
agree that it shouldn't be a problem here).

-- 
Sabrina

