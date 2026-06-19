Return-Path: <netdev+bounces-300686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9JShAFEpNWoOnwYAu9opvQ
	(envelope-from <netdev+bounces-300686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:34:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7EF6A56FD
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:34:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DIag6T5u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300686-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300686-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFC043003EC9
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B6379C2E;
	Fri, 19 Jun 2026 11:34:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA8233927
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 11:34:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868877; cv=none; b=GhDd0MFFE+jyvKvEWrTJ0WnDb3vVKjtyiGRh/w3vXtpWsXgL4sPCs8ikm5S/rLB7wCvWuOuXrN0A2Oq+GlLSTWmHymCPN3NGnCZLuEB5w5h11NNiXA7e4RDs/P3m96aNvEuqh24gWFoM9Ht6x/TFyKR01CgeunJJSi8AkwkMXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868877; c=relaxed/simple;
	bh=cIDNH5ivvh3ja3J8zjw7G+avSXMS1yM/Kjkdu5huJHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAYv0Ui1G9ovsiU0WNcJbKFRa8FLUe9fk1RhEoaZXGRvymlpiF3FKn+jj36W4brUBXlY16whbqJpi3+I6hVtHyqMt4dCCjuIv00wVfGXo33kK2R0JLSgxUEsfVHpv6cQdSvEvkU/3DjFZVdpw8UJCmpOo0B/55Y9x4t05HABhVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIag6T5u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA781F000E9;
	Fri, 19 Jun 2026 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781868875;
	bh=nOSR1Ik3D6P2bkhobWobgeY4+bPAjmYFtOx6isRqK/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DIag6T5uaRuCnwdZTmpKL3RpiC/CG9l+2NXknzghO5+SJ9FvUsDcWXLZptY/nBN5S
	 KJP6nsn8HWpsE+PmK5pMSWmMj68+TRf19oSVCsIIVItaRc7zrdA/lp+ivp6X02N5zn
	 o92jR3h8DzbZmhW+PD/P7hbKOz8grvlg+KURW8HmqeU8WMsXs7c99mLo8goObXf/Iv
	 ebtnKRJRJR9EhZNGI7pCzHbAvqiGBF1tcjPaLkIn0w6vCKsBq/2OlJCFPKB5smf/Pe
	 rIyA5Dfhi1hSY271rG+X6A4DI/a+qYp49myPD0m7UCSpHeYBFjzdlzzNxJt8CDoxtn
	 ryF8Zp5ezf6dg==
Date: Fri, 19 Jun 2026 13:34:32 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: airoha: fix netif_set_real_num_tx_queues
 for sparse QoS channels
Message-ID: <ajUpSLFJm8UN3o_k@lore-desk>
References: <20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org>
 <20260618-airoha-qos-fixes-v1-2-37192652157f@kernel.org>
 <20260619093529.GV827683@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zML9pTpDuCjiRldO"
Content-Disposition: inline
In-Reply-To: <20260619093529.GV827683@horms.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300686-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A7EF6A56FD


--zML9pTpDuCjiRldO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jun 18, 2026 at 08:00:30AM +0200, Lorenzo Bianconi wrote:
> > airoha_tc_htb_alloc_leaf_queue() assigns queue IDs based on the channel
> > index (opt->qid =3D AIROHA_NUM_TX_RING + channel), but updates
> > real_num_tx_queues with a simple increment (num_tx_queues + 1). When QoS
> > channels are allocated sparsely (e.g., channels 0 and 3 without 1 and
> > 2), the returned qid can exceed real_num_tx_queues, causing out-of-boun=
ds
> > accesses in the networking stack.
> > For example, allocating channel 0 then channel 3 results in
> > real_num_tx_queues =3D 34 but qid =3D 35, which is out of range [0, 34).
> > Fix this by computing real_num_tx_queues based on the highest active
> > channel index rather than using a simple counter, in both the allocation
> > and deletion paths.
> >=20
> > Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
>=20
> ...
>=20
> > @@ -2806,7 +2806,10 @@ static int airoha_tc_htb_alloc_leaf_queue(struct=
 net_device *netdev,
> >  	if (err)
> >  		goto error;
> > =20
> > -	err =3D netif_set_real_num_tx_queues(netdev, num_tx_queues + 1);
> > +	if (num_tx_queues <=3D netdev->real_num_tx_queues)
> > +		goto set_qos_sq_bmap;
> > +
> > +	err =3D netif_set_real_num_tx_queues(netdev, num_tx_queues);
> >  	if (err) {
> >  		airoha_qdma_set_tx_rate_limit(netdev, channel, 0,
> >  					      opt->quantum);
> > @@ -2815,6 +2818,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct =
net_device *netdev,
> >  		goto error;
> >  	}
> > =20
> > +set_qos_sq_bmap:
>=20
> I would prefer if this could be achieved without a goto.

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> >  	set_bit(channel, dev->qos_sq_bmap);
> >  	opt->qid =3D AIROHA_NUM_TX_RING + channel;
> > =20
>=20
> ...

--zML9pTpDuCjiRldO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajUpSAAKCRA6cBh0uS2t
rJSyAQDrWl90MDX0+6B/dDR9iyapEy258QJbEC7SVmt+23YzxgD/SkPzjvIbpGbs
eWvMbW/KPt95ofPcqRWP0KQyzkhQVgg=
=KMNX
-----END PGP SIGNATURE-----

--zML9pTpDuCjiRldO--

