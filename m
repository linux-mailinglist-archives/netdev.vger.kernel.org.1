Return-Path: <netdev+bounces-141231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362C59BA184
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 17:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3910281E30
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BEF19DF4B;
	Sat,  2 Nov 2024 16:50:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD80175D47
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730566236; cv=none; b=AfkukhC7x7TJzR5eJ1g+yKUK0UiviVnJz8cMr/stSXl9KfbNqSE2mLT1LyZ+h5kB1YXdGbHcjHI46mOX/aCh2a/R03tB7HFsdss5a3H1AWBeGyX5UurUpJt0qYYfiD8i11/quihYMVOG8rH3cSYj05zvbLEU3pBwdFbm2RY7YIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730566236; c=relaxed/simple;
	bh=b6EoWRD1xYMwlXkPz2mb59JUHG6v0kHjdtPcfrXvgLg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=J1sruVh36KUk6dgULAJIxCGt03wsRfe6ZYBvD+fQ9YLPU0l2ot9xM+Pd9/ZACWTpjNCRo3Z27PQxtj5L28Gsxo9oIHFEXHuD/Dg1eVdIE9v1hXG0kbUjE9rw9bc5kSSsu+m04XqU0kW6CuyY8YPJ1nL8ueTUOqtJ3pl/usE3Rcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [185.122.134.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id E4C127D08A;
	Sat,  2 Nov 2024 16:50:31 +0000 (UTC)
References: <20241007135928.1218955-1-chopps@chopps.org>
 <20241007135928.1218955-16-chopps@chopps.org>
 <ZxYO+BuvEyROVORj@gauss3.secunet.de>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, Sabrina Dubroca
 <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, Antony Antony
 <antony@phenome.org>, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v12 15/16] xfrm: iptfs: handle reordering of
 received packets
Date: Sat, 02 Nov 2024 16:30:16 +0000
In-reply-to: <ZxYO+BuvEyROVORj@gauss3.secunet.de>
Message-ID: <m2ikt5inqh.fsf@chopps.org>
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


Steffen Klassert <steffen.klassert@secunet.com> writes:

> On Mon, Oct 07, 2024 at 09:59:27AM -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> +static u32 __reorder_drop(struct xfrm_iptfs_data *xtfs, struct list_head *list)
>> +
>> +{
>> +	struct skb_wseq *s, *se;
>> +	const u32 savedlen = xtfs->w_savedlen;
>> +	time64_t now = ktime_get_raw_fast_ns();
>> +	u32 count = 0;
>> +	u32 scount = 0;
>> +
>> +	WARN_ON_ONCE(!savedlen);
>> +	if (xtfs->w_saved[0].drop_time > now)
>> +		goto set_timer;
>> +
>> +	++xtfs->w_wantseq;
>> +
>> +	/* Keep flushing packets until we reach a drop time greater than now. */
>> +	s = xtfs->w_saved;
>> +	se = s + savedlen;
>> +	do {
>> +		/* Walking past empty slots until we reach a packet */
>> +		for (; s < se && !s->skb; s++)
>> +			if (s->drop_time > now)
>> +				goto outerdone;
>
> Please use braces if there is more that one line in the loop.

Done.

>> +
>> +static void __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
>> +				    struct sk_buff *inskb,
>> +				    struct list_head *list,
>> +				    struct list_head *freelist)
>
> freelist is unused in this function.

Removed.

>> +{
>> +	const u32 nslots = xtfs->cfg.reorder_win_size + 1;
>> +	const u64 inseq = __esp_seq(inskb);
>> +	u32 savedlen = xtfs->w_savedlen;
>> +	u64 wantseq = xtfs->w_wantseq;
>> +	struct sk_buff *slot0 = NULL;
>> +	struct skb_wseq *wnext;
>> +	u32 beyond, shifting, slot;
>> +	u64 distance;
>> +
>> +	WARN_ON_ONCE(inseq <= wantseq);
>
> Do we really need this warning? You checked exactly this before calling
> __reorder_future_shifts.
>
>> +	distance = inseq - wantseq;
>> +	WARN_ON_ONCE(distance <= nslots - 1);
>
> Same here. There are a lot of these WARN_ON_ONCE all over the
> place. I don't think we need it at places where it is clear
> that the warn condition will never be true.

Removed.

>> +	beyond = distance - (nslots - 1);
>> +
>> +	/* Handle future sequence number received.
>> +	 *
>> +	 * IMPORTANT: we are at least advancing w_wantseq (i.e., wantseq) by 1
>> +	 * b/c we are beyond the window boundary.
>> +	 *
>> +	 * We know we don't have the wantseq so that counts as a drop.
>> +	 */
>> +
>> +	/* ex: slot count is 4, array size is 3 savedlen is 2, slot 0 is the
>
> What means 'ex:'?

"Example" - expanded.

>> +	 * missing sequence number.
>> +	 *
>> +	 * the final slot at savedlen (index savedlen - 1) is always occupied.
>> +	 *
>> +	 * beyond is "beyond array size" not savedlen.
>> +	 *
>> +	 *          +--------- array length (savedlen == 2)
>> +	 *          |   +----- array size (nslots - 1 == 3)
>> +	 *          |   |   +- window boundary (nslots == 4)
>> +	 *          V   V | V
>
> window boundary points to seq number 6 here. In all other
> examples, it points between 5 and 6. Is that intentional?

Fixed to match others.

>> +	 *                |
>> +	 *  0   1   2   3 |   slot number
>> +	 * ---  0   1   2 |   array index
>
> This looks odd. I guess this is because slot0 does
> not belong to the array. Why is that?

the slots are the logical window, the array implements the physical data structure requirements for holding received future packets. This never includes the missing "next in line" required packet by definition (slot 0 in the window).

> Can we have slot0 integrated in the array? This would make
> the counting much simpler IMO.

We don't want to do this b/c then simple shifting logic doesn't work as slot0 is, by definition, always missing, the code will actually get more complex with an always missing initial array item to be special cased.

>> +	 *     [b] [c] : :|   array
>> +	 *                |
>> +	 * "2" "3" "4" "5"|*6*  seq numbers
>
> Is it so that in the example above packet [a] with seq number 2
> is missing and we have packet [b] with seq number 3 in slot 1
> and packet [c] with seq number 4 in slot 2?

Yes.

>> +	 *
>> +	 * We receive seq number 6
>> +	 * distance == 4 [inseq(6) - w_wantseq(2)]
>> +	 * newslot == distance
>> +	 * index == 3 [distance(4) - 1]
>> +	 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
>> +	 * shifting == 1 [min(savedlen(2), beyond(1)]
>> +	 * slot0_skb == [b], and should match w_wantseq
>
> We don't have slot0_skb, I guess this is slot0.
>
> How will the example above look like after shifting?
> Is it this:
>
> 	 *  0   1   2   3 |   slot number
> 	 * ---  0   1   2 |   array index
> 	 * [b] [c] : : [e]|   array
> 	 *                |
> 	 * "3" "4" "5" "6"|  seq numbers
>
> Whereby [e] is the packet with seq number 6.

Yes.

>> +	 *
>> +	 *                +--- window boundary (nslots == 4)
>> +	 *  0   1   2   3 | 4   slot number
>> +	 * ---  0   1   2 | 3   array index
>> +	 *     [b] : : : :|     array
>> +	 * "2" "3" "4" "5" *6*  seq numbers
>
> What's the difference to the first example? Is it
> the same but packet [c] is missing?

Yes.

>> +	 *
>> +	 * We receive seq number 6
>> +	 * distance == 4 [inseq(6) - w_wantseq(2)]
>> +	 * newslot == distance
>> +	 * index == 3 [distance(4) - 1]
>> +	 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
>> +	 * shifting == 1 [min(savedlen(1), beyond(1)]
>> +	 * slot0_skb == [b] and should match w_wantseq
>> +	 *
>> +	 *                +-- window boundary (nslots == 4)
>> +	 *  0   1   2   3 | 4   5   6   slot number
>> +	 * ---  0   1   2 | 3   4   5   array index
>> +	 *     [-] [c] : :|             array
>
> What does [-] mean? Is it the [b] is missing?

Yes. empty (NULL) array item.

>> +	 * "2" "3" "4" "5" "6" "7" *8*  seq numbers
>> +	 *
>> +	 * savedlen = 2, beyond = 3
>> +	 * iter 1: slot0 == NULL, missed++, lastdrop = 2 (2+1-1), slot0 = [-]
>> +	 * iter 2: slot0 == NULL, missed++, lastdrop = 3 (2+2-1), slot0 = [c]
>> +	 * 2 < 3, extra = 1 (3-2), missed += extra, lastdrop = 4 (2+2+1-1)
>> +	 *
>> +	 * We receive seq number 8
>> +	 * distance == 6 [inseq(8) - w_wantseq(2)]
>> +	 * newslot == distance
>> +	 * index == 5 [distance(6) - 1]
>> +	 * beyond == 3 [newslot(6) - lastslot((nslots(4) - 1))]
>> +	 * shifting == 2 [min(savedlen(2), beyond(3)]
>> +	 *
>> +	 * slot0_skb == NULL changed from [b] when "savedlen < beyond" is true.
>> +	 */
>> +
>> +	/* Now send any packets that are being shifted out of saved, and account
>> +	 * for missing packets that are exiting the window as we shift it.
>> +	 */
>
> Documentation is in genaral good, but it must be clear what's
> documented here. It took me quite a while to figure out what
> these examples mean, and I'm still not absoluely sure if
> I'm correct. All that might be clear to you when you wrote
> that, but it is very hard to guess what you thought when
> writing this :)

You understood everything correctly. Sliding window code is by nature complex, and as you noted I really wanted to document the crap out of it to try and help. You got it all right so I think I accomplished the goal. :)

>> +	/* If savedlen > beyond we are shifting some, else all. */
>> +	shifting = min(savedlen, beyond);
>> +
>> +	/* slot0 is the buf that just shifted out and into slot0 */
>> +	slot0 = NULL;
>
> slot0 was set to NULL already at the beginning of this function.
>
> It is just hard to notice because of the huge coment in the middle
> of the function. It might make sense to put all that bigger comments
> to a central place. It would make the functions more readable,
> at least.

That was the intention. :) I removed the redundant assignment above, and moved 2 others below to join the rest.

>> @@ -2222,6 +2700,11 @@ static void iptfs_destroy_state(struct xfrm_state *x)
>>  	if (xtfs->ra_newskb)
>>  		kfree_skb(xtfs->ra_newskb);
>>
>> +	for (s = xtfs->w_saved, se = s + xtfs->w_savedlen; s < se; s++)
>> +		if (s->skb)
>> +			kfree_skb(s->skb);
>
> Braces please.

Done.

Thanks,
Chris.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmcmWFYSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlou8P/1wK9Zm0Wyb3nb1mza8GCVNkmwPj5Ipm
ZQo+3mAw7+wawwxCGM5/pmtVTFuBiMYBlHgM6WB+fVGLbFu3mgu8TTlA6p1j27JO
MGsGf+5KHFJ3PvgZbz66YFQ2Iq/H+Vcm4UCLeHkracBINfq7xK8O6yRNjudNG48q
y67/W0ZbYwtJVAZj5+P46raiHoPqETZcVVJQetOqRccoJAp42fy8zCPS9QNaJ57A
etMT/5qasRtd8C3T19/FlVMl08eOMvRvjJo/s3m4tXlIEbNDkjCQOQ0zOj5zk6WP
IRrZDqs6Qdx4Pm7+X0nBsSRYweiP/OJDNHPtOtxlvyM0AOLODhWeuFZH/Wls4MSf
ixntKp36f1Q5RL2SQxmCDsRzCc8yyDUPXgK1hPCOVcrMrbSoJelkSFXcm+3M4HcY
uuag+m9MyqTaQ745i/gK44Z0QxINEJTo6UgfHcY67PqC8SJLcBhVw7eq9RvlauyA
1E7kWkwk8MO6N5Sblu382/H4svZLjuCrzb41YxsvaJSzuu5B8tTU4fgHXtfolm2a
rlTEKWQoBtU/8t/nM0I33uWBHQavaK1nt7PAO56kf4ZL+4GDyRsb3rcClt/qVHAT
XZHwe7YOL3sN1zPwXoDNHKV9EryYHEbgaOFSi6r6TL2bYHeoViXVJENZbXJfv+ln
s9xRZlDDy6y6
=oVS1
-----END PGP SIGNATURE-----
--=-=-=--

