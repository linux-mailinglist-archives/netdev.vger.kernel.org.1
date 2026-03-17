Return-Path: <netdev+bounces-268756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALKJAA7TuWnMOAIAu9opvQ
	(envelope-from <netdev+bounces-268756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:17:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 711DE2B3064
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C69C305ACBD
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714435AC0B;
	Tue, 17 Mar 2026 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOUQQQL1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223F25A655;
	Tue, 17 Mar 2026 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785867; cv=none; b=HXwEgI4UX6lN4ZtiPjcEN7c5lob/MyM7pA9FWzt/Ao0HZXaF8XH5/aieMz6RDsG6CrZyYsBnzJQV6nnoDqv0I4g4TGJ/HO6hbBJEPS7NDADmUHqD/Zp8gah5UnL8gsabB0KiGNBPeS9nqhfI20P6PQCzshJoAXsrNCgW7GVrXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785867; c=relaxed/simple;
	bh=u2/P/aVbOEZlOc4dCycyVMdJGN+fnfdQtRIi9dIwUUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnOge0USd4cFM+bEXM8G6qfKbSFYv4qlqYWa0ecBdVGrxHyLW5rIuiO+jsy9ACdq4/wwN+ZAWWPJJ3KrdkfBFTzvplWIe2JqpcW93hpIkGMTmjCH8iOiJzCMMsv4NmDoirfvwHYXx3n6LbmFFvXQZhAjXhllWWjEV/+89t6+zbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOUQQQL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F5AC4CEF7;
	Tue, 17 Mar 2026 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773785866;
	bh=u2/P/aVbOEZlOc4dCycyVMdJGN+fnfdQtRIi9dIwUUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XOUQQQL1WDNdGYuRKw7bJHCCFwDEemkCXWbzmSz43sj+8m9F46mkKnc6gbjHp8Xk9
	 tIAG+R9roWZeQuhsf/DDNA8a7fWuD2MrTqeqpJwEJy2nV0iQ1wNCUFjrvO2Le8eN6H
	 SNp0KxS/kp2eMt4kgYC54LNIagn5pGeH/snOSFqTkQidL1n5HEtwYTq8pNfPo/Aa+a
	 vIWs+93zRKgfPoHtiP/wcCQAIuKyU5rpMKwNLX9Zxpz8biTab6gph4n8oa6G4VA2BF
	 B/NuKv9bnavJqTc/N25pgG1sfdQZ1gMbCMNN0/Ln3xtco7FLSgbUvzF39CmtHlW4WA
	 d6qSCHBwYJ6pA==
Date: Tue, 17 Mar 2026 15:17:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?=
 <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alok Tiwari
 <alok.a.tiwari@oracle.com>, Kees Cook <kees@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] genetlink: add multi-version family support for
 protocol negotiation
Message-ID: <20260317151745.4562eefc@kernel.org>
In-Reply-To: <085c9532-5440-4879-bcde-4d70c980c839@linbit.com>
References: <20260316151507.3958299-2-christoph.boehmwalder@linbit.com>
	<20260316113736.1085a124@kernel.org>
	<085c9532-5440-4879-bcde-4d70c980c839@linbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-268756-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 711DE2B3064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 16:47:44 +0100 Christoph B=C3=B6hmwalder wrote:
> Am 16.03.26 um 19:37 schrieb Jakub Kicinski:
> > What's the delta between the families? Do you have any examples of=20
> > the the version ends up being used? =20
>=20
> The main difference between DRBD 8 and 9 in general is that 8 only
> replicates to a single peer, while 9 has support for multiple peers.
> This also introduces major changes in the genl family. For example, the
> "connect" command works completely differently between the v1 and v2
> families.
> In v1, it takes all the net_conf parameters and immediately sets up the
> connection.
> In v2, you need a new_peer / new_path command first; the net_conf is
> passed to new_peer in this case. The connect command then only
> "activates" the connection.
> So the semantics are completely different.
>=20
> Other commands (like "state_info") were removed entirely and split up
> into different commands.
>=20
> The specific exact diff is available as part of our prototype DRBD 9
> branch (included in linux-next):
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/diff/=
include/linux/drbd_genl.h?id=3D11b8887a3efae2868037f2bd8dbbc68a8591f66c

This uAPI header wrapped in DRDB magic tells me nothing.

The macro wrapping that DRBD does never gained broader adoption and
should be considered deprecated. Please take a look at YNL and the YAML
specs. (I mean this as a nack).

> As for the usage: the plan is for drbd to register its family with
> min_version=3D1, max_version=3D2. Then we would dispatch the v2 commands
> normally, and the v1 commands through a thin compat layer.
> In the in-tree DRBD, the version is currently unused. In the (still
> out-of-tree) DRBD 9 though, we do check that the version is what we expec=
t:
> https://github.com/LINBIT/drbd/blob/master/drbd/drbd_nl.c#L426
>=20
> This would be replaced by the mentioned compat dispatch logic once we
> have in-kernel infrastructure for supporting multiple versions.

I still feel a little bit in the dark as to what you're doing but the
normal path for Netlink is to add new attributes and commands in a
backward-compat manner. In case of DRBD given how "special" the
existing code is we could probably start a new family using modern
constructs.

