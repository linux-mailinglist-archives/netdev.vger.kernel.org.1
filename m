Return-Path: <netdev+bounces-306963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RHt/GMDbU2qAfgMAu9opvQ
	(envelope-from <netdev+bounces-306963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:24:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFB8745A00
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:23:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=YZSuFshK;
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306963-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306963-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D526300D69E
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E506036921E;
	Sun, 12 Jul 2026 18:23:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEBF369219
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 18:23:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783880636; cv=none; b=swSIKprewn45mPElenZXNjQdpTllhvn9lJgN8X/E8a85cIqqzj02g/cyZYFElhWcI2H+OaNChf14trmpLkeFm0eXVAiHXvwi2wziJsYz8zkRezdrwDsJVqGtcv0YYw9iaW/4gdf7TRnm/QSL8QTLeSq2BgAzr793LJ4/yP70SFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783880636; c=relaxed/simple;
	bh=1ht5Xi7NqZEOsCXukCa4rXgRnRL+wPnYzotnuGAEM0o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TtcxmF9O6cbx6bXQVJd7xMQaZVOv///lsatWw+HVg80WDlyzF8/73xPm2X7vmMJPUGsIuvZjfyxRewSfKpTKFVpBXcaDshF5olx2WMpNx7kGUO34UVG3SDOO/eeJHTqfLzpMxi8TRBxTzKvkANkOE17I9R4e6mqTYCQqr4LYZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=YZSuFshK; arc=none smtp.client-ip=195.121.94.186
X-KPN-MessageId: d60dc0e8-7e1e-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d60dc0e8-7e1e-11f1-bfba-00505699b430;
	Sun, 12 Jul 2026 20:23:53 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id d60ce0f0-7e1e-11f1-9b0c-00505699693e;
	Sun, 12 Jul 2026 20:23:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=8wgP3O8n0kcAv/voUODxDUkCGHcLdFCenE1jmdQGu8U=;
	b=YZSuFshKfCwzGZGu9t/GxZgfWal6HyJgj55otMW9io2N8xdGphyrybcN+n6DnlxjifbPLr2XHoqHw
	 VIdSGpJ1VXCjluFqSVF4w7Ll63/T4+JMb71xIIJxv64HgGSk8hun6v0xmpRc3auS1zXlD3Jy/vV+oo
	 eJfbbBFNIl2HPCqbwtZk/UFvkZFpMZXrKOGHjyEnBBVpMmEwMJ91ZUoOsE8jqobX6sWaCPIkAoqPGS
	 XDUQV/CN1QgU8aGKMAjWOo8v7mVGENz0pAnxnSDH/Z493WBnya6iUA3ERMRF2lAct1DcrEmixPp+XC
	 AfuCkBOlwieIOnkFfn1Qyybx3o4zVlQ==
X-KPN-MID: 33|K86OQZ7RwL1vhn6psIUSJp8fwJLrkbpI0VqPVDlEW4sGmlDTDlh7NG6LfwSYTS8
 gvihfIhSqoUtKSSfiPNma04lpDTrP1M7xPr23fqpWWhk=
X-CMASSUN: 33|hg/ushXay+X2g+I7BHPmY4Na1O5jvEFukCTq6eRb7EHWHp4VyeZPljSyf2KseJ8
 7IeM7Bxsqvm5kKrOGEQ1q1g==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id d5f3b3bc-7e1e-11f1-8edb-00505699eff2;
	Sun, 12 Jul 2026 20:23:53 +0200 (CEST)
Date: Sun, 12 Jul 2026 20:23:52 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <30383245.772147.1783880632879@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260707-sinnieren-versichern-heuballen-e86897d216c3@brauner>
References: <20260705123826.3818443-1-jkoolstra@xs4all.nl>
 <20260705123826.3818443-4-jkoolstra@xs4all.nl>
 <20260707-sinnieren-versichern-heuballen-e86897d216c3@brauner>
Subject: Re: [PATCH net-next v4 3/3] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306963-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kpc.webmail.kpnmail.nl:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AFB8745A00


> Op 07-07-2026 13:02 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
> > +
> > +TEST_F(scm_rights_denial_bpf, all_allowed)
> > +{
> > +	int slots[NR_FILES], nr_slots, flags, i;
> > +
> > +	ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
> > +	ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
> > +	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> > +
> > +	ASSERT_EQ(NR_FILES, nr_slots);
> > +	EXPECT_EQ(0, flags & MSG_CTRUNC);
> > +
> > +	for (i = 0; i < NR_FILES; i++) {
> > +		ASSERT_LE(0, slots[i]);
> 
> Why do you assert less-or-equal? You want a valid fd so you should
> expect >= 0?
> 

This says 0 <= slots[i], or equivalently slots[i] >= 0.

> > +
> > +TEST_F(scm_rights_denial_bpf, denied_without_notrunc)
> > +{
> > +	int slots[NR_FILES], nr_slots, flags;
> > +
> > +	/*
> > +	 * Baseline behaviour without SO_RIGHTS_NOTRUNC: the fd array is
> > +	 * truncated at the first denied fd and MSG_CTRUNC is set.
> > +	 */
> > +	ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[1]));
> > +
> > +	ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
> > +	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> > +
> > +	ASSERT_EQ(1, nr_slots);
> > +	EXPECT_NE(0, flags & MSG_CTRUNC);
> > +
> > +	ASSERT_LE(0, slots[0]);
> 
> Why do you expect less-equal than zero? Don't you need ASSERT_GE()
> because you want slots[0] to be a valid file desscriptor?
> 

Idem.

But I do think ASSERT_GE() read a bit better here, so I have changed it.

> And even the other way around... Zero is a valid file descriptor so on
> failure you must expect ASSERT_LT()?
> 

> -- 
> Christian Brauner <brauner@kernel.org>

Thanks,
Jori.

