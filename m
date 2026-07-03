Return-Path: <netdev+bounces-304361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fJtwEGlUR2otWQAAu9opvQ
	(envelope-from <netdev+bounces-304361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:19:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E0A6FF063
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=efGWudIF;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304361-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304361-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9389C302837D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5C836495F;
	Fri,  3 Jul 2026 06:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAAE359A81
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 06:19:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059557; cv=none; b=rihHFDAAozFE2zUUxr+tdUlPRQgvvzTMwvnqtQfU5LVm69pRSQXHUuv4uvIe9b5RZSL5lIlE6M1PKjYPQN3RAaTD81aM6t4SJwnobb87y8cfdu5aGU7p9B19gxIeQU3p2j5gjSUCt8DcfpomvaKt3u2WY4WS/F1hNFtiZF+e8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059557; c=relaxed/simple;
	bh=PCllz5nHJ2tib46eIPG3MxrpirCyDKKbKNazLzWwuCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f536bYljbF158HdhjH8JxFVvALXy+88Vdr9b/1XOdqqYMYbK16E4/EsX2Qkgx6B9LSy/TDoi9jS5Lra4QiO86dMsFrN/zo4kTNjruTdNac9b9uoOfrj/Fv2M+AvVKBuZqVHhlsHLp414BWzoQBp91dfnvMCilKJheNbMjy45I1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=efGWudIF; arc=none smtp.client-ip=80.241.56.172
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gs3Vd3jv4z9tfx;
	Fri,  3 Jul 2026 08:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783059545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1zRePlccUePUxm+KZeJ7YE1zD4I6nNtO+kgWLOfu8Q=;
	b=efGWudIFqLA7zpIZoBE7KGxd9t7Zp4gbVCOizImnY/t2whl1VmKbcjWuRoyNQvWJ9yBU8b
	yZEkbkAPANSQX5Rdt/B9pdSni/9aA/2KpgO+nafqD4QKmAws9b/aQrP6lmXwnoSpWRP06/
	+/YbyujQb1g3VyP69tfKKlYDyPOkAtV5HzYftvlotyHajvrPInrg4a5Fyy2X093/ry+J3L
	2NvR7EhmJlZfxvXJ5nuwb1EYK6/7bpLrS9KFhcD76rjvfQZofu3n8bQx1mPeHz3YoAhJuq
	/MbrywV1Fzata8jFv7Qq3q9J8EMJ6mODHLr9wf9Y4fOR09vqE7+9nB/196hcOw==
Message-ID: <d6cfd7bd90001af215ba456ab81404a60fbea1c4.camel@mailbox.org>
Subject: Re: [PATCH ipsec v2] xfrm: policy: preallocate inexact bins before
 xfrm_hash_rebuild reinsert
From: Manuel Ebner <manuelebner@mailbox.org>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>, fw@strlen.de, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, 	netdev@vger.kernel.org
Cc: horms@kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, 	AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, 	kys@microsoft.com
Date: Fri, 03 Jul 2026 08:18:58 +0200
In-Reply-To: <20260703051932.966884-1-xmei5@asu.edu>
References: <20260703051932.966884-1-xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 9a84f4646fb108d8bf4
X-MBO-RS-META: grrz9945e56khhr5uuybxy9gb8d6w3eb
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:fw@strlen.de,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-304361-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:from_mime,mailbox.org:dkim,mailbox.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1E0A6FF063

Hi Xiang Mei

On Fri, 2026-07-03 at 05:19 +0000, Xiang Mei (Microsoft) wrote:
> xfrm_hash_rebuild()'s first loop preallocates the bins/chains the reinser=
t
> loop needs, so the reinsert (after hlist_del_rcu()) cannot allocate or
> fail.=C2=A0

This sentence is difficult to understand for me. Can it be simplified or ch=
anged?=20
This would help a little:

xfrm_hash_rebuild()'s first loop preallocates the bins/chains which the rei=
nsert
loop needs. In this case the reinsert ...


> But its guard is inverted: it skips policies with prefixlen <
> threshold and preallocates for the rest.
>=20
> prefixlen < threshold is exactly when policy_hash_bysel() returns NULL an=
d
> the reinsert takes the allocating xfrm_policy_inexact_insert() path. So t=
he
> loop preallocates for the exact policies (which never allocate) and skips
> the inexact ones, whose bin/node is then allocated GFP_ATOMIC during
> reinsert. On failure the error path only WARN_ONCE()s and continues,
> leaving a poisoned bydst node;=C2=A0

what's 'bydst'?

> the next rebuild's hlist_del_rcu()
> dereferences LIST_POISON2 and takes a GPF.=C2=A0

/GPF/GFP/

Thanks
 Manuel

> Reachable under memory pressure,
> deterministic via failslab.
>=20
> Invert the guard so preallocation covers exactly the reinserted policies;
> the reinsert then allocates nothing and cannot fail.
>=20
> Crash:
> =C2=A0 Oops: general protection fault, probably for non-canonical address
> =C2=A0 0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
> =C2=A0 KASAN: maybe wild-memory-access in range [0xdead...]
> =C2=A0 ...
> =C2=A0 Workqueue: events xfrm_hash_rebuild
> =C2=A0 RIP: 0010:xfrm_hash_rebuild+0x5b3/0x1190
> =C2=A0 RAX: dead000000000122=C2=A0=C2=A0 (LIST_POISON2 + offset)
> =C2=A0 ...
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 hlist_del_rcu (include/linux/rculist.h:599)
> =C2=A0=C2=A0 xfrm_hash_rebuild (net/xfrm/xfrm_policy.c:1365)
> =C2=A0=C2=A0 process_one_work (kernel/workqueue.c:3322)
> =C2=A0=C2=A0 worker_thread (kernel/workqueue.c:3486)
> =C2=A0=C2=A0 kthread (kernel/kthread.c:436)
> =C2=A0=C2=A0 ret_from_fork (arch/x86/kernel/process.c:158)
> =C2=A0=C2=A0 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> =C2=A0=C2=A0 ...
> =C2=A0 Kernel panic - not syncing: Fatal exception in interrupt
>=20
> Fixes: 24969facd704 ("xfrm: policy: store inexact policies in an rhashtab=
le")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
> v2: fix the inverted preallocation guard (root cause)
> =C2=A0=C2=A0=C2=A0 instead of avoiding crash
>=20
> =C2=A0net/xfrm/xfrm_policy.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 7ef861a0e823..932a313b9460 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -1329,8 +1329,8 @@ static void xfrm_hash_rebuild(struct work_struct *w=
ork)
> =C2=A0			}
> =C2=A0		}
> =C2=A0
> -		if (policy->selector.prefixlen_d < dbits ||
> -		=C2=A0=C2=A0=C2=A0 policy->selector.prefixlen_s < sbits)
> +		if (policy->selector.prefixlen_d >=3D dbits &&
> +		=C2=A0=C2=A0=C2=A0 policy->selector.prefixlen_s >=3D sbits)
> =C2=A0			continue;
> =C2=A0
> =C2=A0		bin =3D xfrm_policy_inexact_alloc_bin(policy, dir);

