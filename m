Return-Path: <netdev+bounces-106195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E09152CF
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C7E1C20ED7
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E130219CCE0;
	Mon, 24 Jun 2024 15:46:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D89319B59E
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243994; cv=none; b=ndOwaZ6O1v4V2GiFTYt3Oiyq618mNF1rGSGj9shftoy6KZ7bAQrilwTUQNTOYCRinscsc/UF1HLZVp9N2x/BXAJaqa/6wb2y5Ws+sLfXHyWzTBArjJyda5jpSfSChFXhMDQwdFX5e7YRCryDPGk3C1MdOvcO+d8xnsN6Lza+pGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243994; c=relaxed/simple;
	bh=10QMSY7zmCowpV9tDHUMKuWVGXfOXLfUQNwKd4JEltU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PgfV2hmEScmI9sXPdyr/hB/pN4z1tL7lgPgXWrnK1oLB2evgN6fgNLk+mxVZyAbdRNi0hnHOi3MSXYcLuoP4/fcAj4nlsdB0wFIJMKgEhSHzfR5rezSBX4MCGdoos1dNtRsPb/ZEdi3n7frykKSjAv07j2vAvSiSLlPLtDtne0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from smtpclient.apple (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id BF3F67D065;
	Mon, 24 Jun 2024 15:46:25 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [devel-ipsec] [PATCH ipsec-next v4 17/18] xfrm: iptfs: only send
 the NL attrs that corr. to the SA dir
From: Christian Hopps <chopps@chopps.org>
In-Reply-To: <ZnmQeZVYDC8rKLEe@Antony2201.local>
Date: Mon, 24 Jun 2024 11:46:14 -0400
Cc: Christian Hopps <chopps@chopps.org>,
 devel@linux-ipsec.org,
 Steffen Klassert <steffen.klassert@secunet.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <58857781-E0AF-40D2-9808-CA02D4217C5B@chopps.org>
References: <20240617205316.939774-1-chopps@chopps.org>
 <20240617205316.939774-18-chopps@chopps.org>
 <ZnmQeZVYDC8rKLEe@Antony2201.local>
To: Antony Antony <antony@phenome.org>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jun 24, 2024, at 11:27, Antony Antony <antony@phenome.org> wrote:
>=20
> On Mon, Jun 17, 2024 at 04:53:15PM -0400, Christian Hopps via Devel =
wrote:
>> From: Christian Hopps <chopps@labn.net>
>>=20
>> When sending the netlink attributes to the user for a given SA, only
>> send those NL attributes which correspond to the SA's direction.
>>=20
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>> net/xfrm/xfrm_iptfs.c | 64 =
++++++++++++++++++++++++-------------------
>> 1 file changed, 36 insertions(+), 28 deletions(-)
>>=20
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>> index 59fd8ee49cd4..049a94a5531b 100644
>> --- a/net/xfrm/xfrm_iptfs.c
>> +++ b/net/xfrm/xfrm_iptfs.c
>> @@ -2498,13 +2498,16 @@ static unsigned int iptfs_sa_len(const struct =
xfrm_state *x)
>> struct xfrm_iptfs_config *xc =3D &xtfs->cfg;
>> unsigned int l =3D 0;
>>=20
>> - if (xc->dont_frag)
>> - l +=3D nla_total_size(0);
>> - l +=3D nla_total_size(sizeof(xc->reorder_win_size));
>> - l +=3D nla_total_size(sizeof(xc->pkt_size));
>> - l +=3D nla_total_size(sizeof(xc->max_queue_size));
>> - l +=3D nla_total_size(sizeof(u32)); /* drop time usec */
>> - l +=3D nla_total_size(sizeof(u32)); /* init delay usec */
>> + if (x->dir =3D=3D XFRM_SA_DIR_IN) {
>> + l +=3D nla_total_size(sizeof(u32)); /* drop time usec */
>> + l +=3D nla_total_size(sizeof(xc->reorder_win_size));
>> + } else {
>> + if (xc->dont_frag)
>> + l +=3D nla_total_size(0);   /* dont-frag flag */
>> + l +=3D nla_total_size(sizeof(u32)); /* init delay usec */
>> + l +=3D nla_total_size(sizeof(xc->max_queue_size));
>> + l +=3D nla_total_size(sizeof(xc->pkt_size));
>> + }
>>=20
>> return l;
>> }
>> @@ -2516,30 +2519,35 @@ static int iptfs_copy_to_user(struct =
xfrm_state *x, struct sk_buff *skb)
>> int ret;
>> u64 q;
>>=20
>> - if (xc->dont_frag) {
>> - ret =3D nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
>> + if (x->dir =3D=3D XFRM_SA_DIR_IN) {
>> + q =3D xtfs->drop_time_ns;
>> + (void)do_div(q, NSECS_IN_USEC);
>> + ret =3D nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, q);
>> + if (ret)
>> + return ret;
>> +
>> + ret =3D nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW,
>> +   xc->reorder_win_size);
>> + } else {
>> + if (xc->dont_frag) {
>> + ret =3D nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
>> + if (ret)
>> + return ret;
>> + }
>> +
>> + q =3D xtfs->init_delay_ns;
>> + (void)do_div(q, NSECS_IN_USEC);
>> + ret =3D nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
>> + if (ret)
>> + return ret;
>> +
>> + ret =3D nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE,
>> +   xc->max_queue_size);
>> if (ret)
>> return ret;
>> +
>> + ret =3D nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
>> }
>> - ret =3D nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW, =
xc->reorder_win_size);
>> - if (ret)
>> - return ret;
>> - ret =3D nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
>> - if (ret)
>> - return ret;
>> - ret =3D nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE, =
xc->max_queue_size);
>> - if (ret)
>> - return ret;
>> -
>> - q =3D xtfs->drop_time_ns;
>> - (void)do_div(q, NSECS_IN_USEC);
>> - ret =3D nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, q);
>> - if (ret)
>> - return ret;
>> -
>> - q =3D xtfs->init_delay_ns;
>> - (void)do_div(q, NSECS_IN_USEC);
>> - ret =3D nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
>>=20
>> return ret;
>> }
>=20
> looking at this patch, why this should be seperate patch? why not =
squash=20
> into [PATCH ipsec-next v4 08/18] xfrm: iptfs: add new iptfs xfrm mode =
impl

The various attributes get modified by the layered functionality =
commits, so it ends up needing to be worked into a bunch of commits. So =
given it was a simple patch addressing a review comment I thought it =
would be OK to just leave it a single simple patch. If it's important I =
will do the work to incorporate the change into the N different commits =
:)

Thanks,
Chris.

>=20
> I also think in the v3 it was squashed into some other patch.
>=20
> -antony



