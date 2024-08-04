Return-Path: <netdev+bounces-115593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8F494717C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 00:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9282C280DEF
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 22:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3447F7A;
	Sun,  4 Aug 2024 22:27:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2511CF8B
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722810441; cv=none; b=QMXH3eYEOC5L5xMzT2Md7g7CcDlZoXSXA+HvTWaLUG5l9LCAsEsUZ1YWGxyswufDgoxDMaEbgznJUx8lqGYQF3CgHVysQlo6govn1xGO1/iTa+NOOZdH64//wa+eIjCw9wn6MqqVXgaBO78bwBkCw7SkjF2L9oggJmUX/P0O04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722810441; c=relaxed/simple;
	bh=kL8wesmKRM8nuhd9ArNC6TDWEAxxovCnbVohk04Ldg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uKoO+ErjrpMnYSb/Yq7hMkCnMcz8xhsFC0wZYS4jx1HK4E/ikiDGvFmXfcK5Qe89TiGP/ugZmpIpLqI8hVc1nhkZ0bY0y5kr/azGU13qMTfTytZo8fYbtHMlFotwT4hSXNSeDySMjklcNn9EQaXk0Rf3KOOuIJZt8rZqJvPqsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-taDmr-1zMIeL9puXD4FmqA-1; Sun,
 04 Aug 2024 18:26:04 -0400
X-MC-Unique: taDmr-1zMIeL9puXD4FmqA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0886419560A1;
	Sun,  4 Aug 2024 22:26:03 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26C7E1955F40;
	Sun,  4 Aug 2024 22:25:59 +0000 (UTC)
Date: Mon, 5 Aug 2024 00:25:57 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <Zq__9Z4ckXNdR-Ec@hog>
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240804203346.3654426-11-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please CC the reviewers from previous versions of the patchset. It's
really hard to keep track of discussions and reposts otherwise.


2024-08-04, 16:33:39 -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
>=20
> Add support for tunneling user (inner) packets that are larger than the
> tunnel's path MTU (outer) using IP-TFS fragmentation.
>=20
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/xfrm_iptfs.c | 407 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 381 insertions(+), 26 deletions(-)
>=20
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 20c19894720e..38735e2d64c3 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -46,12 +46,23 @@
>   */
>  #define IPTFS_DEFAULT_MAX_QUEUE_SIZE=09(1024 * 10240)
> =20
> +/* 1) skb->head should be cache aligned.
> + * 2) when resv is for L2 headers (i.e., ethernet) we want the cacheline=
 to
> + * start -16 from data.
> + * 3) when resv is for L3+L2 headers IOW skb->data points at the IPTFS p=
ayload
> + * we want data to be cache line aligned so all the pushed headers will =
be in
> + * another cacheline.
> + */
> +#define XFRM_IPTFS_MIN_L3HEADROOM 128
> +#define XFRM_IPTFS_MIN_L2HEADROOM (64 + 16)

How did you pick those values?



> +static struct sk_buff *iptfs_alloc_skb(struct sk_buff *tpl, u32 len,
> +=09=09=09=09       bool l3resv)
> +{
> +=09struct sk_buff *skb;
> +=09u32 resv;
> +
> +=09if (!l3resv) {
> +=09=09resv =3D XFRM_IPTFS_MIN_L2HEADROOM;
> +=09} else {
> +=09=09resv =3D skb_headroom(tpl);
> +=09=09if (resv < XFRM_IPTFS_MIN_L3HEADROOM)
> +=09=09=09resv =3D XFRM_IPTFS_MIN_L3HEADROOM;
> +=09}
> +
> +=09skb =3D alloc_skb(len + resv, GFP_ATOMIC);
> +=09if (!skb) {
> +=09=09XFRM_INC_STATS(dev_net(tpl->dev), LINUX_MIB_XFRMNOSKBERROR);

Hmpf, so we've gone from incrementing the wrong counter to
incrementing a new counter that doesn't have a precise meaning.

> +=09=09return NULL;
> +=09}
> +
> +=09skb_reserve(skb, resv);
> +
> +=09/* We do not want any of the tpl->headers copied over, so we do
> +=09 * not use `skb_copy_header()`.
> +=09 */

This is a bit of a bad sign for the implementation. It also worries
me, as this may not be updated when changes are made to
__copy_skb_header().
(c/p'd from v1 review since this was still not answered)


> +/**
> + * skb_copy_bits_seq - copy bits from a skb_seq_state to kernel buffer
> + * @st: source skb_seq_state
> + * @offset: offset in source
> + * @to: destination buffer
> + * @len: number of bytes to copy
> + *
> + * Copy @len bytes from @offset bytes into the source @st to the destina=
tion
> + * buffer @to. `offset` should increase (or be unchanged) with each subs=
equent
> + * call to this function. If offset needs to decrease from the previous =
use `st`
> + * should be reset first.
> + *
> + * Return: 0 on success or a negative error code on failure
> + */
> +static int skb_copy_bits_seq(struct skb_seq_state *st, int offset, void =
*to,
> +=09=09=09     int len)

Probably belongs in net/core/skbuff.c, although I'm really not
convinced copying data around is the right way to implement the type
of packet splitting IPTFS does (which sounds a bit like a kind of
GSO). And there are helpers in net/core/skbuff.c (such as
pskb_carve/pskb_extract) that seem to do similar things to what you
need here, without as much data copying.


> +static int iptfs_first_skb(struct sk_buff **skbp, struct xfrm_iptfs_data=
 *xtfs,
> +=09=09=09   u32 mtu)
> +{
> +=09struct sk_buff *skb =3D *skbp;
> +=09int err;
> +
> +=09/* Classic ESP skips the don't fragment ICMP error if DF is clear on
> +=09 * the inner packet or ignore_df is set. Otherwise it will send an IC=
MP
> +=09 * or local error if the inner packet won't fit it's MTU.
> +=09 *
> +=09 * With IPTFS we do not care about the inner packet DF bit. If the
> +=09 * tunnel is configured to "don't fragment" we error back if things
> +=09 * don't fit in our max packet size. Otherwise we iptfs-fragment as
> +=09 * normal.
> +=09 */
> +
> +=09/* The opportunity for HW offload has ended */
> +=09if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +=09=09err =3D skb_checksum_help(skb);
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +
> +=09/* We've split these up before queuing */
> +=09BUG_ON(skb_is_gso(skb));

As I've said previously, I don't think that's a valid reason to
crash. BUG_ON should be used very rarely:

https://elixir.bootlin.com/linux/v6.10/source/Documentation/process/coding-=
style.rst#L1230

Dropping a bogus packet is an easy way to recover from this situation,
so we should not crash here (and probably in all of IPTFS).

--=20
Sabrina


