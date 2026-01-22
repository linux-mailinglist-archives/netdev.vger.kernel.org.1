Return-Path: <netdev+bounces-252463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P3KFjNfcmnbjAAAu9opvQ
	(envelope-from <netdev+bounces-252463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:32:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4356B5B0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8516C3094815
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F1F38B99E;
	Thu, 22 Jan 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd2ULZbJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B83EBF09
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101096; cv=none; b=AryNUMnuaxUWxZBkSdd9a60Vva7STgpeA8vG6hRYICi0Dg0HRV3zL4YT0w7EQzTza/eFWdZCtukOl8kk4YB0k2IR3IowGsalSfJQSCyy/PLXEdTnAJUfVzgloERbfs6sEAKVIJGM+jQA6KVcCgCcIYc9DnI3tfrXEvO2J5y5BpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101096; c=relaxed/simple;
	bh=KRGfXamzFe5L3RFxicP2/zxU6zmuLVOaui2u/TK8azs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3DPD/NGqPmHt7uh4UeWo2cNXwVFIW9OhKt/EF9MEXywNykQ/R86YknmQLzAWbX+iOadtZ4pPZ48bKO0pSuQEJJmCe3AuciwBhPu3YYiffw4EaZvMkzqmwBLX753VdPKgDiYOwJkslmPQ6zQU0TRXxAiZw/JfyExL4Zkeg5RBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd2ULZbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5C3C19422;
	Thu, 22 Jan 2026 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101094;
	bh=KRGfXamzFe5L3RFxicP2/zxU6zmuLVOaui2u/TK8azs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xd2ULZbJa9Ylps2ZQX/r2Omh1lRgD/PlKfRLCvyGtQd4AE1/ml0mrO1WmkU0fKDkq
	 XyXwMYyK2umIXIzZoSNf4MqtlSum1dgLKg2nTOYxXxKCK8VcGuPtjaZB+ZA7vDm8J2
	 YnWz/S3o4J6FmQUNRfeQkv7RRUbYfwxDnuSITuHrjzySjabdqaJTOSx9ZUjjqpJhFe
	 +dT98UWpnj6S0y1Ww7BJ7ilZCz8G0OoVfX2TFTEUTuqecGyRFzMgXHkMJGsZ1QJ6o9
	 yjQV1TBX5+CT3V/tEN4U7rwZ2ALMLsXPueR1VoIL/OP3cGk838cSUQKGwDN59/+QqQ
	 N4URucgNKW38w==
Date: Thu, 22 Jan 2026 08:58:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, syzkaller@googlegroups.com, andy@greyhouse.net,
 eric.dumazet@gmail.com, pabeni@redhat.com, j.vosburgh@gmail.com,
 davem@davemloft.net, clm@meta.com
Subject: Re: [net] bonding: annotate data-races around slave->last_rx
Message-ID: <20260122085813.47f7c195@kernel.org>
In-Reply-To: <CANn89i+7H32ODq3=nEfoORTR+6FiO2mOWRcLFf-K=+4UQcOmig@mail.gmail.com>
References: <20260120152856.1694824-1-edumazet@google.com>
	<20260122022237.2529455-1-kuba@kernel.org>
	<CANn89iLK1saW=7jxhtew_skR-rPPonFi71brvTApeKM5VVadiA@mail.gmail.com>
	<20260122072858.2b652eb7@kernel.org>
	<CANn89i+0kJ5M1_6NPxbe4k5eY4sPwNeKN0yKyaHzFhZDT9-=kQ@mail.gmail.com>
	<CANn89i+7H32ODq3=nEfoORTR+6FiO2mOWRcLFf-K=+4UQcOmig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,greyhouse.net,gmail.com,redhat.com,davemloft.net,meta.com];
	TAGGED_FROM(0.00)[bounces-252463-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B4356B5B0
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 16:56:33 +0100 Eric Dumazet wrote:
> On Thu, Jan 22, 2026 at 4:50=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> > On Thu, Jan 22, 2026 at 4:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote: =20
> > > I guess if nothing else we should do it for consistency? =20
> >
> > To be clear, I will cook a V2 with this part.
> > =20
>=20
> _bond_options_ns_ip6_target_set() probably needs a fix as well.
>=20
> Is AI review stopping at the first error ?

I don't think it explicitly stops after the first occurrence but it
seems to have limited ability to dig around. Simplifying, it only digs
around for 5-10min, and it spends a lot of time proving that the
issue is real. So once it's spend time proving one issue it's often out
of time, and may not search for another one :(

Ccing Chris, hopefully he'll chime in later if I'm wrong.

