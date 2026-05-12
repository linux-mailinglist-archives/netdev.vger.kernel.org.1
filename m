Return-Path: <netdev+bounces-286889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pa1Mud4AmpotQEAu9opvQ
	(envelope-from <netdev+bounces-286889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:48:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 607AF517FC6
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB5E30179FD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711F23EAA6;
	Tue, 12 May 2026 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLYeIVuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12B23D290
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546916; cv=none; b=szFftP1lkleFFs3EUQoAybfvGKnQdlAU3kQq6Fgyvlmt/vgNHizOswtIPHndSgTDmxTNgTNlj4caA7IpqZgItnsL7MiZ1i0S6LuC8ggEePtoheBz2gEhg9+Nym5NKib0ySpjWTa82/tV+Qo0K4nGiADnesAXh/Ka68+6xPopsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546916; c=relaxed/simple;
	bh=W2YY39EaqUhH0GTJwveJlv6CeRq7oCl9PhTfP2ESoVM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ktk4qaM2VS/m3vqwJ53IxxnR3LG6SEzJDMshkBvMxczIATDnLefb9G8anGmrZgrFI6HTadBGa3eTyQifn/yyzmTdczN39dnttCtxEQyRMJ7uU0G2DRSR5VA3b1Dn6NKY1Aw9BSX1DOhyjulFs5d+j1JtEb8fYAcIPLXvLsG2gSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLYeIVuZ; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64eb84d1e37so3986577d50.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778546912; x=1779151712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DBz5h7J+LXtYIrr46WWAf29zsx5M2W8nq+U3w1ZSbc=;
        b=JLYeIVuZgQZNEkDZSq9SMYil6SQQq5cyZAh9W06jk7b/YQo2ukysiK1p1Qk0atUPvd
         dKLiI7Zem3SATTlsXvEMZjbKIGzempuPWsrJ0sHMKmNTHKmZzKfYfjEcLYxLjQ8M8lcJ
         f0Z8IZEZ9ecOzwJKBPGRwKtnbmgQDAREXkQjn9mPeXThiD07cx6FC18eChohE0KT9Ixv
         W50RMaTIBKZ/pffz0b/RjOYsd0Na9Fl8Dgvn6be+OeEr5y4o4ci5MhxZT31/H2fiTGJC
         enW2zXwSDtFCL833PrJtAeYUmDKFiDd7NOfqwbYUNjGsQxSBnI8yKekdwrdKdEVeagkI
         ZumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546912; x=1779151712;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DBz5h7J+LXtYIrr46WWAf29zsx5M2W8nq+U3w1ZSbc=;
        b=sWL8uNuqTk4mkID7t4vrujkrZMG6Cixruq7689Wzm6Z98GEXr+ZbO3dm9RcixSrbln
         +hA/yXmfzxBRxp7M/twr734mIAxEuKvZ6IKGZy9PSPmJdPJzMh1B2C9b73DqKY/i9zqk
         +8B0IJ9NpZWLOEKllDv38Sl0GJR96OgXFkxQ4FjeK1kjAuea9QmrglEaMuTePlQE54gu
         7bNdbz+UgDrvVgeacP+L2fDMc4Yk1qsl7XhhURxTiVbztL6M9nVabP4i1eu0Ko+60/ba
         9tU/3FtMmbJEoQlj/vukgsHhLoM0QZiLabrd0jIcUurIRa7QX6JwZR0l1nx8KBx6NSOd
         ZFLQ==
X-Gm-Message-State: AOJu0YwbiApsfeDn9+CRXfXcRWzNjyK485jo3tmF/+pYDDokNI2dFltL
	eBOUq42+yqzbL1gCS1f/VI69zLaLZr6qOm2m4OVeFtsaTK7DKA3rpQqw
X-Gm-Gg: Acq92OG4SzCw/nv3oYlE5+cNRy1Fl8EGH2hla3Dsm1844emxGIQ+OnnhFxqpR2LtX38
	g5NiAm2tNsBZtCRs3UA916viFvbCIPphtuzcMwqZD2VmdBJ1YsKDefFxKgRt8dd070zQ7RocTBa
	HpNmrMlcjaz3acKxkIpoSpspU0fK3e6aet7OWTxiluOlqGlH7Fjm+PQsfQFKq8W6GayqcIyvjyo
	PXyH1ptlmOMf83WbHjjNHf2cPP+eEEBhRAj4QiNDnSlInY/uk67VbFHbwZDKwmxfdhu8pAMWQMy
	5PMQh0QSe6GQ1kELvJksh7UYWWJArZ4f8nK65LbNa7NDVgThBFNe19dqfvvMVRK+Rwv5o9/EcbG
	h8O+HaoAyR3XoloCYxNloVcO2C6q048IQTlE93hhCHiTtUMmPZi0Y1nOUgkHTZa6cc5mYwiaGiq
	aTGRWgZT5J2MHs5NYPFjL0JT6IcJKbOHFdBT/Ag4wz0aMIQF+s4yqcY3jRBagdpDd82HYcB74aK
	T7g
X-Received: by 2002:a05:690c:6d83:b0:7bd:73f3:7a67 with SMTP id 00721157ae682-7c104dab235mr113904737b3.28.1778546912531;
        Mon, 11 May 2026 17:48:32 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c58670515csm1038237b3.20.2026.05.11.17.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:48:32 -0700 (PDT)
Date: Mon, 11 May 2026 20:48:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.192b86f974356@gmail.com>
In-Reply-To: <08750de2-77d4-44c1-b16a-33603c3100dc@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-4-4b50ed09b794@gmail.com>
 <willemdebruijn.kernel.36d2fcc3d2e74@gmail.com>
 <08750de2-77d4-44c1-b16a-33603c3100dc@gmail.com>
Subject: Re: [PATCH net-next 4/6] netdevsim: psp: implement kdf from psp spec
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 607AF517FC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-286889-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Daniel Zahka wrote:
> =

> On 5/11/26 3:49 PM, Willem de Bruijn wrote:
> > Daniel Zahka wrote:
> >> Implement the PSP key derivation function (KDF) per the PSP
> >> Architecture Spec.
> >>
> >> The kdf is used to generate spi + session key pairs, and will also b=
e
> > Text is a bit ambiguous here: the kdf does not generate the spi. It
> > derives a session key from the master key and spi.
> >
> >> used in the rx path to re-derive the tx key used by the peer.
> >>
> >> Also, remove support for psd->generation, as it is not needed for
> >> netdevsim after removing the fake authentication hack.
> > Is psd->generation only used inside driver code, not by the core PSP
> > stack? Else it should be set to !!(ns->psp.spi & PSP_SPI_KEY_PHASE) o=
n
> > key rotation. If only used by the driver, no need to reset it on each=

> > rotation.
> =

> =

> Core tries to 'suggest' a generation to the driver,=C2=A0which is the l=
ast =

> generation + 1,=C2=A0before calling into key_rotate(),


Oh right, I recall the feature now. It is more than just the MSB bit flip=
.

> but this won't work for netdevsim.

Why not, if it otherwise dead code to the driver?

That seems most in line with intent. I'd say keep it and allow this drive=
r
to ignore it, if it has purpose to the stack. Or remove it otherwise. Doe=
s
not have to be in this series. But I don't see a need to explicitly touch=

the field.

I think the intent was previousy to avoid on double rotate to deliver
data from gen N+2 to sockets associated with an SPI from gen N. But I
don't know the details and whether that is obsolete (probably).

> I could set the generation to !!(ns->psp.spi & =

> PSP_SPI_KEY_PHASE) so that it aliases the device key selection bit, but=
 =

> I think this is basically the same as just setting it to 0. This series=
 =

> makes the generation field dead code in core. The old netdevsim =

> implementation relied on it to do its fake authentication hack, but tha=
t =

> is removed with this series. The only real hw implementation we have, =

> mlx5, does not support device key generations. Maybe we need to just =

> remove that until a real driver comes along as a user.
> =

> =

> >> Assisted-by: Claude:claude-opus-4.6
> >> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> >>   enum skb_drop_reason
> >>   nsim_psp_handle_tx(struct sk_buff *skb, struct netdevsim *ns)
> >>   {
> >> @@ -155,7 +189,7 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 versi=
on,
> >>   		  struct netlink_ext_ack *extack)
> >>   {
> >>   	struct netdevsim *ns =3D psd->drv_priv;
> >> -	int i;
> >> +	unsigned int phase;
> >>   =

> >>   	if ((ns->psp.spi ^ (ns->psp.spi + 1)) & PSP_SPI_KEY_PHASE) {
> >>   		NL_SET_ERR_MSG(extack, "SPI space exhausted");
> >> @@ -163,9 +197,11 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 vers=
ion,
> >>   	}
> >>   =

> >>   	assoc->spi =3D cpu_to_be32(++ns->psp.spi);
> >> -	assoc->key[0] =3D psd->generation;
> >> -	for (i =3D 1; i < PSP_MAX_KEY; i++)
> >> -		assoc->key[i] =3D ns->psp.spi + i;
> >> +	phase =3D !!(ns->psp.spi & PSP_SPI_KEY_PHASE);
> >> +
> >> +	/* dev_keys_lock not needed because of psd->lock */
> > Can you elaborate a bit?
> >
> > Is dev_keys_lock only used to synchronize the writers, then? Which af=
ter
> > device init would only be concurrent invocations of nsim_key_rotate. =
But
> > that operation correctly also holds the device lock using
> > psp_device_get_locked.
> =

> =

> This is an error in splitting changes in the series on my part. The =

> spinlock is used to synchronize the writer with the reader running the =

> kdf in the napi_poll() path in the later aes-gcm commit. I should have =

> added the spinlock stuff when that reader was introduced. The comment i=
s =

> just pointing out that all of the psp_dev_ops on a psd are serialized =

> with the psd->lock. I'll fix that in the respin.
> =




