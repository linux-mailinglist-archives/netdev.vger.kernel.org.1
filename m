Return-Path: <netdev+bounces-289657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NjlOHuvyDGpwqQUAu9opvQ
	(envelope-from <netdev+bounces-289657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:31:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C90586090
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4E30304ACA0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143582C029D;
	Tue, 19 May 2026 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LszsMYpj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE73438A4;
	Tue, 19 May 2026 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233510; cv=none; b=cD8Tm6aQEewgUZ5oz3lHDw1p1SWJP/8RFjgIGK7JL8dWSGV38pFDEKTZWpWNNWQK+MdYvrW2DkeQNVPA9Cm1x2UNU2PZ8WY2iKKlrSKEUPbwqNvRihw7tQz0XbaZPS3uprtFmgQCNHP12TjDRwqN1/gepEEN0mcPfOTapNkMbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233510; c=relaxed/simple;
	bh=LhESYyCf4SKwU/Rt5HvOd13GpugT2AE5j4ss89yzKG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUct/fd+jexHe64tZU53LXzApqqhEroXDk36pkki+KMhomTA7jyfGUxLAUJx2Jt1CFywTG8pwGY7rUq1rHvH1+hWUZRyH0SDG6kjPnjm/KeZklCm92UqK2rnBScjXpjwnYaP/hmNW25hEmc1qAoE90X7YSUeE7A3MV5ML6YbTjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LszsMYpj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0B21F000E9;
	Tue, 19 May 2026 23:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779233508;
	bh=LhESYyCf4SKwU/Rt5HvOd13GpugT2AE5j4ss89yzKG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LszsMYpjmxGSK5I+ylRpFGg3SqP5XIty7N7HC3y90ZJJSlDzHLoPddzctyNkC9bgK
	 b5Lanrej3I9ERqskOHM6ncwvEtXf/D00gu4H53vtLpkcm00skBd1WpfKx7QXo6iVXU
	 aIIn1dBz0RDgGLUTJYecMwokMqwQnY0yvfUHOC95jpli6j1XpzxVL8pSnbJ8tDEXEu
	 gAjaUkEbi5LQ2VmioUwM0w24f8c1B1mpibIZ2QKXGkMITvbXHL5caCPq3ayk6aZuPB
	 RPSc6aqOTR0j5NsGCA4S99ylVF0nDXBEQHn/92Cxt+3jm1dOHDu/aHbiRpqASgZrno
	 OBfZcR+RL9RVg==
Date: Tue, 19 May 2026 16:31:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ipv6: route: Unregister netdevice notifier on BPF
 init failure
Message-ID: <20260519163147.300e0520@kernel.org>
In-Reply-To: <CACrCO_WK+gRhfCr8e8GvXJGqdHA9dO7xQ4fCynrufFmcLrYJ6g@mail.gmail.com>
References: <20260515130517.779406-1-dbgh9129@gmail.com>
	<20260518171423.2ad15470@kernel.org>
	<CACrCO_WK+gRhfCr8e8GvXJGqdHA9dO7xQ4fCynrufFmcLrYJ6g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289657-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 17C90586090
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 09:49:04 -0400 =EC=B5=9C=EC=9C=A0=ED=98=B8 wrote:
> Thanks for pointing out the outdated tree. I will definitely rebase
> and resubmit v3 against netdev/net.git.
>=20
> Regarding the goto: The reason I moved away from the goto approach in
> v2 is that if CONFIG_BPF_SYSCALL and CONFIG_PROC_FS are disabled, the
> goto statement is compiled out. This leaves the target label unused,
> triggering an "unused-label" compiler warning.
>=20
> Since guarding labels with #ifdefs can get messy, I opted for the
> direct unregistration in the failure path for v2 to keep it clean.
>=20
> Would you still prefer I use the goto and guard the label
> appropriately in v3, or is direct unregistration acceptable given the
> warning?

Yes, guard the label, please.

Reminder: please don't top post.

