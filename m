Return-Path: <netdev+bounces-164689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F0DA2EB65
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D626188BE23
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796DA1E379B;
	Mon, 10 Feb 2025 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hlDxjjqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ws/48LSs"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1232A1E376E
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187324; cv=none; b=G3tG8iCumgHIicaHcTPU/ts47iaxCmze75IeJpfuL6XkB+IOC2KVVW2a5CmmcW92uGJ8MSrmJAHA7N0J23DbNAXAzif+BVnS/ECeydVz7Qq8FkiXwLMmpTH0dh2RlVSUETwDJcJdv3/rr0YS17z/va9kU5Mkhur88AsVTiL9dU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187324; c=relaxed/simple;
	bh=ET8c21wsugS8RJLoqvNZMgr824GQP5hkRBI+xZ+9KYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvzt3/gvHmFoGL4ldbWnOIX45zYOn7sGlFp6fbKq90EkOJBme4HaX7Roy1GjHiBAiXW7SJTWvq5Ylsk8aY6ReflIv8WWh5T5vROLXhmRMscK8HI7quGFpYr4O3glSsBJu0MDM58qpcXkBa8kpTWrtrTNPZU7+nIdSzUmwV6+Hlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hlDxjjqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ws/48LSs; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E40D01380860;
	Mon, 10 Feb 2025 06:35:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 10 Feb 2025 06:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739187319; x=1739273719; bh=USLWubmwh3hB8L521uEOyNL1paWzsnZt
	qsP+3BkSb58=; b=hlDxjjqYhyznnVxd/AfXrwMMHeVTecOcwVNNZ/3rq75CAPnL
	NPt2aFEouC/mvzP5HTWRVTJTLpvx3l4R44KtMuzHbpFxfhLZ4gPSSzAnF9CKNQIh
	WahtyS/chcnPanaknILYBQAD7KOlK86gqwVwz6Wi7+0C16K/j3D/UwLUxSRBzNhr
	GErW9uHrfLu/F8/Aa0KUVrUtk18u0tGx4QrKMmjeoRZblSyhZvxi0JUdeGsvctEH
	629W1TbKNOClrFrJ+tzuY3Iz27uePwYYKszjvwVK2/r9ojCZ9V6ZImVOXJgzjrbV
	1vpM4JVMIPHgkF9GanFB1emrZRyweXLXXOxlXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739187319; x=
	1739273719; bh=USLWubmwh3hB8L521uEOyNL1paWzsnZtqsP+3BkSb58=; b=W
	s/48LSspDCpDlllhpTsgNgao5K3HpcO2aDp8qHWanGv02rgcgv0CW4qzMlyPfgOG
	Ka6w+rm6/raaEjuWPsqkcBVcYcMn3lDOTReFVRE+4dPz5aTKQ15rM0uXUpQJuuqt
	rn0GNJH25I8dV7b2+NU6gPWpzU02Sbt3bh/LMIWdJ2Vt8t36dkXlkiqAUcFMOmtN
	jXt2MlBxi9Vd6NCv3At7buvu/p/yqzOj1k1vFxAtYOFX73LZ/yT/MTq7xT1dYc0p
	T9rCjdapzwqse4dWARZkejaVXgAoHH6wMDMtJErJGOqMX3JnRJY6Y9ve0jB4GklZ
	qxy/bbo1rCrKISWxc3ISw==
X-ME-Sender: <xms:d-SpZ7XdIUYnP4w0p14prnFw0DB7-25C-bCdkMptjLrSyP96tqmWrA>
    <xme:d-SpZzkgbup_8km061DFyDFfSL9uD-LB4ewyA-2wlN1QzsvHFy-1jLVKUsScD92qa
    jJTTTYU8p-T_xA5rfc>
X-ME-Received: <xmr:d-SpZ3ZGw9trPV5OsMVBXnRyNjeVojGFMt21YXlq9mrV7bAQoDEUc3NOajW_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvgeeitefffedvgfdutdelgeei
    hfegueehteevveegveejudelfeffieehledvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhgvmhgssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegvrhhitgdrughumhgriigvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:d-SpZ2VwHpHNIDRXt4aE0rpO-ArhY73V9rx6U77rui3Yna5TSwPVqA>
    <xmx:d-SpZ1ldUJIYQBhBbuVwnrYaGYim8KD5euMepKHILpRpp9-KD-NbzQ>
    <xmx:d-SpZzdRCD1HgQVQSNxUoM70nH0Ds63LNwv_WxDobmBEO2-WHzHCpw>
    <xmx:d-SpZ_GP03g1bft3tx3O0XVgZ7W0dCd4EtEVS7uNvAbPt6MFf0lW8Q>
    <xmx:d-SpZ364SLh7oZ0Kx6EP8jdWsBB7ycus5AEu9aZL2RElUZU92oIDGen6>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 06:35:19 -0500 (EST)
Date: Mon, 10 Feb 2025 12:35:17 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
Message-ID: <Z6nkddoL7RAHw-y5@hog>
References: <20250210082805.465241-1-edumazet@google.com>
 <20250210082805.465241-4-edumazet@google.com>
 <Z6nHRDtxEG393A38@hog>
 <CANn89iLCrohtJrfdRKvB3-XNtVjKDucNeTcxrmn4vAutgFyXAA@mail.gmail.com>
 <CANn89iJFcibv9J+fe+OzNVw4t5tS-47GZpmHKacSQ9mS+g1TUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJFcibv9J+fe+OzNVw4t5tS-47GZpmHKacSQ9mS+g1TUA@mail.gmail.com>

2025-02-10, 10:56:22 +0100, Eric Dumazet wrote:
> On Mon, Feb 10, 2025 at 10:44 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Feb 10, 2025 at 10:30 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
> > >
> > > 2025-02-10, 08:28:04 +0000, Eric Dumazet wrote:
> > > > @@ -613,7 +613,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
> > > >
> > > >       return mask;
> > > >  }
> > > > -EXPORT_SYMBOL(tcp_poll);
> > > > +EXPORT_IPV6_MOD(tcp_poll);
> > >
> > > ktls uses it directly (net/tls/tls_main.c):
> >
> >
> > Oh, right.
> >
> > >
> > > static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
> > >                             struct poll_table_struct *wait)
> > > {
> > >         struct tls_sw_context_rx *ctx;
> > >         struct tls_context *tls_ctx;
> > >         struct sock *sk = sock->sk;
> > >         struct sk_psock *psock;
> > >         __poll_t mask = 0;
> > >         u8 shutdown;
> > >         int state;
> > >
> > >         mask = tcp_poll(file, sock, wait);
> > > [...]
> > > }
> > >
> > > If you want to un-export tcp_poll, I guess we'll need to add the same
> > > thing as for ->sk_data_ready (save the old ->poll to tls_context).
> >
> > No need, I simply missed tls was using tcp_poll() can could be a
> > module, I will fix in V2
> >
> 
> TLS also calls tcp_under_memory_pressure() via tcp_epollin_ready(),
> so tcp_memory_pressure needs to be exported as well.

Ah, yes, didn't think about inline helpers.

I ran a quick build since I was concerned about what the Chelsio TOE
driver might be using, but spotted this instead:

ERROR: modpost: "secure_tcpv6_seq" [drivers/infiniband/hw/irdma/irdma.ko] undefined!

-- 
Sabrina

