Return-Path: <netdev+bounces-112006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D1D9347C6
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 08:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C2F2820A0
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 06:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69C20DE8;
	Thu, 18 Jul 2024 06:02:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6882C1B86FD
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282557; cv=none; b=S7eMT9pD2fLOzzFRLCMinpyXK+uK5bxAzi1FLmkdArTwTqIukgKW7Z2wyX6Ms89pshF5VrcYVTm+3R6OCnDXKvJ7PRs0Br2LJmsCXwFfB4FVADRAFhjh4Iwkqz7qEQ1ZZtWucBdPGzLIz8qvqgnnhiCKjZtiZQ2z3ZZ7VGkjsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282557; c=relaxed/simple;
	bh=nrtG10AVs5hzW+opbW4fE5aVGqmJkrbBgiOniqI+MIk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ZZ9cxz2eG/6KXjeLz+wEBNccCMK2iugaIpKL3clULbCCNPV6XI4JJOPDQ3E8pv/NEI3dytUr85Cq1secXxaT886Wwto00MaxYg0gI2FVBfOPOtpNHOT3zt6ln4L9KLbhv9ma8wh8u84gRCzdUNjoo2OHxbAPFsUcg8fI9jAIG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [50.229.122.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 18BCF7D06B;
	Thu, 18 Jul 2024 06:02:35 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-12-chopps@chopps.org>
 <20240715131239.GD45692@kernel.org>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Simon Horman <horms@kernel.org>
Cc: Christian Hopps <chopps@chopps.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian Hopps
 <chopps@labn.net>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5 11/17] xfrm: iptfs: add
 fragmenting of larger than MTU user packets
Date: Wed, 17 Jul 2024 22:57:52 -0700
In-reply-to: <20240715131239.GD45692@kernel.org>
Message-ID: <m24j8ndypy.fsf@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Simon Horman via Devel <devel@linux-ipsec.org> writes:

> On Sun, Jul 14, 2024 at 04:22:39PM -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add support for tunneling user (inner) packets that are larger than the
>> tunnel's path MTU (outer) using IP-TFS fragmentation.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  net/xfrm/xfrm_iptfs.c | 401 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 375 insertions(+), 26 deletions(-)
>>
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>
> ...
>
>> +static int iptfs_copy_create_frags(struct sk_buff **skbp,
>> +				   struct xfrm_iptfs_data *xtfs, u32 mtu)
>> +{
>> +	struct skb_seq_state skbseq;
>> +	struct list_head sublist;
>> +	struct sk_buff *skb = *skbp;
>> +	struct sk_buff *nskb = *skbp;
>> +	u32 copy_len, offset;
>> +	u32 to_copy = skb->len - mtu;
>> +	u32 blkoff = 0;
>> +	int err = 0;
>> +
>> +	INIT_LIST_HEAD(&sublist);
>> +
>> +	BUG_ON(skb->len <= mtu);
>> +	skb_prepare_seq_read(skb, 0, skb->len, &skbseq);
>> +
>> +	/* A trimmed `skb` will be sent as the first fragment, later. */
>> +	offset = mtu;
>> +	to_copy = skb->len - offset;
>> +	while (to_copy) {
>> +		/* Send all but last fragment to allow agg. append */
>> +		list_add_tail(&nskb->list, &sublist);
>> +
>> +		/* FUTURE: if the packet has an odd/non-aligning length we could
>> +		 * send less data in the penultimate fragment so that the last
>> +		 * fragment then ends on an aligned boundary.
>> +		 */
>> +		copy_len = to_copy <= mtu ? to_copy : mtu;
>
> nit: this looks like it could be expressed using min()
>
>      Flagged by Coccinelle

Changed.

>
>> +		nskb = iptfs_copy_create_frag(&skbseq, offset, copy_len);
>> +		if (IS_ERR(nskb)) {
>> +			XFRM_INC_STATS(dev_net(skb->dev),
>> +				       LINUX_MIB_XFRMOUTERROR);
>> +			skb_abort_seq_read(&skbseq);
>> +			err = PTR_ERR(nskb);
>> +			nskb = NULL;
>> +			break;
>> +		}
>> +		iptfs_output_prepare_skb(nskb, to_copy);
>> +		offset += copy_len;
>> +		to_copy -= copy_len;
>> +		blkoff = to_copy;
>
> blkoff is set but otherwise unused in this function.
>
> Flagged by W=1 x86_64 allmodconfig builds with gcc-14 and clang 18.

This value is used in a trace point call in this function.

>
>> +	}
>> +	skb_abort_seq_read(&skbseq);
>> +
>> +	/* return last fragment that will be unsent (or NULL) */
>> +	*skbp = nskb;
>> +
>> +	/* trim the original skb to MTU */
>> +	if (!err)
>> +		err = pskb_trim(skb, mtu);
>> +
>> +	if (err) {
>> +		/* Free all frags. Don't bother sending a partial packet we will
>> +		 * never complete.
>> +		 */
>> +		kfree_skb(nskb);
>> +		list_for_each_entry_safe(skb, nskb, &sublist, list) {
>> +			skb_list_del_init(skb);
>> +			kfree_skb(skb);
>> +		}
>> +		return err;
>> +	}
>> +
>> +	/* prepare the initial fragment with an iptfs header */
>> +	iptfs_output_prepare_skb(skb, 0);
>> +
>> +	/* Send all but last fragment, if we fail to send a fragment then free
>> +	 * the rest -- no point in sending a packet that can't be reassembled.
>> +	 */
>> +	list_for_each_entry_safe(skb, nskb, &sublist, list) {
>> +		skb_list_del_init(skb);
>> +		if (!err)
>> +			err = xfrm_output(NULL, skb);
>> +		else
>> +			kfree_skb(skb);
>> +	}
>> +	if (err)
>> +		kfree_skb(*skbp);
>> +	return err;
>> +}
>> +
>> +/**
>> + * iptfs_first_should_copy() - determine if we should copy packet data.
>> + * @first_skb: the first skb in the packet
>> + * @mtu: the MTU.
>> + *
>> + * Determine if we should create subsequent skbs to hold the remaining data from
>> + * a large inner packet by copying the packet data, or cloning the original skb
>> + * and adjusting the offsets.
>> + */
>> +static bool iptfs_first_should_copy(struct sk_buff *first_skb, u32 mtu)
>> +{
>> +	u32 frag_copy_max;
>> +
>> +	/* If we have less than frag_copy_max for remaining packet we copy
>> +	 * those tail bytes as it is more efficient.
>> +	 */
>> +	frag_copy_max = mtu <= IPTFS_FRAG_COPY_MAX ? mtu : IPTFS_FRAG_COPY_MAX;
>
> Likewise, it looks like min could be used here too.

Changed.

Thanks!
Chris.
>
>> +	if ((int)first_skb->len - (int)mtu < (int)frag_copy_max)
>> +		return true;
>> +
>> +	/* If we have non-linear skb just use copy */
>> +	if (skb_is_nonlinear(first_skb))
>> +		return true;
>> +
>> +	/* So we have a simple linear skb, easy to clone and share */
>> +	return false;
>> +}
>
> ...


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmaYr/kSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAl+7gP/RYvIFJGNBbdG7gvZgDeTjBtWPnRhyAB
HTGtSKCniTiLvnFq7+8+3dDKOLvIcEWFqXUK82IwSkBKzhJ1x456AMGqPQ7SiKWv
MdaE94z3XNN3BnastwN6ahFp8PRi2lCapOjzM3rAWRjP1kJkhdCiiOb0/46VBvqO
0MZFW0O8/pU1XSuPWfAQR2YKgJp0tj3IK1sTt9xSzXDsJlwtKVGwwj+5sblmWrmo
oHK2mng7TyYfvcAP6PkZjQwgvu1YI2amiP75WhAmkMQpimW4FXc1p/QizNKQ0LrX
Gj7NfaDPg5WOjPEUJep0lNswZEAyq82LEqbvpRbCqGEg3HnOAHJeYxgAzknFhPnl
NMQ3E9nVnODojm7WxtRAK8fJQS2pdAShLTMBJOdbqsMOA93k5OaE2GjLW6aDrMSY
jqD6YI/bnJUJyzmk7XUV88TZnZS0SxMYEDQ1mP0Bc/4QUmWRL7uStpv7DqZn3+Nf
jTx2mFzXKGCgvYQD0VnayLqlkhkbCsT8m/NCGHuFvEZnGCosglJmhrHeCHzZR9vH
mGik26rpsNOgq+O0gBQDhwaC2HGWfikzaxWpaZpRi4GCAaZFCvztKIhsup7fUKFz
pXBq72MjkMcVgsjxoF1cKpPSM3trQF+vyKF3b4v+vRa7L+qK5EKOZ63AooJM5gOk
Ng8fnpLeYiHV
=/w1q
-----END PGP SIGNATURE-----
--=-=-=--

