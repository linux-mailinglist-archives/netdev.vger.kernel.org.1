Return-Path: <netdev+bounces-137384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF789A5E7A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5BFB224DD
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 08:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2D01E0E15;
	Mon, 21 Oct 2024 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="iuHxc1JL"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2581C69A
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498885; cv=none; b=AaXc7aXml0hJd/jFA2nXvQpiAuoWcMNgeQpjTuBYbduvZqa/HqEC/fGo/iq2Cecnwz01LDARKypIscuUBSzxUR6CvEE2cgI0irJI8aVkBhNBuSbgxs39KKIWo8gu08OM5e1qbTX2Ip4JvcAfLQtO+7wYTfBqsry0LdUyAwfPoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498885; c=relaxed/simple;
	bh=kBHR1f0RufMLAMDVjAGxy2gJx38zsfev1Jg0Io82XEY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4q4jq/cyZONEJhf3talp9Pfd7OMPJtuEz9tY9TPdyraw7e3UwKrJCSELeKlcwJgmzgDVJfJWi3OWw49pg/a7iyvIplgHv0AtFp7sLZA5ookoHhfCFr1NCje/Hr63u/GOTnm6LEB5X37tGrs/zb2D5b69h7VaAf5dDiUbNK181E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=iuHxc1JL; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 46BA42067F;
	Mon, 21 Oct 2024 10:21:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RU0H8J2Tmnlv; Mon, 21 Oct 2024 10:21:13 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 754A02065A;
	Mon, 21 Oct 2024 10:21:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 754A02065A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729498873;
	bh=p5IAlqllvEyc5TLgxbOOzjP4/km+RR8dTtOwS1npMsU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=iuHxc1JL9MrI3NCYMNC4lRyZXaSa7OH8/wVsTgo0EZMq3RIGBC2JPpINF3AckprSg
	 BCGdRZI+63UOzJpyqmp6MkWlM0p0swBFqU3Ubq3Qp9BmOkjKVEREEav5M14OGy8Fkl
	 DipfMbDtTEx3o0fQMcgi9z5bwd0zrHK/56nuHjTz9znhiMhOAlqfUv87cVx2X8Qrrb
	 iOr0HaBp0PxAYM+G4QfV0KEsr5IasKOzfvR9zPQC0ZT55KGb1ls5duunfWpxA/dM1p
	 uLlOV5mTwL5n30Cu0f/X+pbiKk8DJyXtcfT9Sy3EKuUuGj5BhxsXbRWk8ub6ujRcMg
	 6QSPwykNGF87g==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 10:21:13 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 10:21:13 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DDCB631807A6; Mon, 21 Oct 2024 10:21:12 +0200 (CEST)
Date: Mon, 21 Oct 2024 10:21:12 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, <netdev@vger.kernel.org>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
	<horms@kernel.org>, Antony Antony <antony@phenome.org>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [PATCH ipsec-next v12 15/16] xfrm: iptfs: handle reordering of
 received packets
Message-ID: <ZxYO+BuvEyROVORj@gauss3.secunet.de>
References: <20241007135928.1218955-1-chopps@chopps.org>
 <20241007135928.1218955-16-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007135928.1218955-16-chopps@chopps.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Oct 07, 2024 at 09:59:27AM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> +static u32 __reorder_drop(struct xfrm_iptfs_data *xtfs, struct list_head *list)
> +
> +{
> +	struct skb_wseq *s, *se;
> +	const u32 savedlen = xtfs->w_savedlen;
> +	time64_t now = ktime_get_raw_fast_ns();
> +	u32 count = 0;
> +	u32 scount = 0;
> +
> +	WARN_ON_ONCE(!savedlen);
> +	if (xtfs->w_saved[0].drop_time > now)
> +		goto set_timer;
> +
> +	++xtfs->w_wantseq;
> +
> +	/* Keep flushing packets until we reach a drop time greater than now. */
> +	s = xtfs->w_saved;
> +	se = s + savedlen;
> +	do {
> +		/* Walking past empty slots until we reach a packet */
> +		for (; s < se && !s->skb; s++)
> +			if (s->drop_time > now)
> +				goto outerdone;

Please use braces if there is more that one line in the loop.

> +
> +static void __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
> +				    struct sk_buff *inskb,
> +				    struct list_head *list,
> +				    struct list_head *freelist)

freelist is unused in this function.

> +{
> +	const u32 nslots = xtfs->cfg.reorder_win_size + 1;
> +	const u64 inseq = __esp_seq(inskb);
> +	u32 savedlen = xtfs->w_savedlen;
> +	u64 wantseq = xtfs->w_wantseq;
> +	struct sk_buff *slot0 = NULL;
> +	struct skb_wseq *wnext;
> +	u32 beyond, shifting, slot;
> +	u64 distance;
> +
> +	WARN_ON_ONCE(inseq <= wantseq);

Do we really need this warning? You checked exactly this before calling
__reorder_future_shifts.

> +	distance = inseq - wantseq;
> +	WARN_ON_ONCE(distance <= nslots - 1);

Same here. There are a lot of these WARN_ON_ONCE all over the
place. I don't think we need it at places where it is clear
that the warn condition will never be true.

> +	beyond = distance - (nslots - 1);
> +
> +	/* Handle future sequence number received.
> +	 *
> +	 * IMPORTANT: we are at least advancing w_wantseq (i.e., wantseq) by 1
> +	 * b/c we are beyond the window boundary.
> +	 *
> +	 * We know we don't have the wantseq so that counts as a drop.
> +	 */
> +
> +	/* ex: slot count is 4, array size is 3 savedlen is 2, slot 0 is the

What means 'ex:'?

> +	 * missing sequence number.
> +	 *
> +	 * the final slot at savedlen (index savedlen - 1) is always occupied.
> +	 *
> +	 * beyond is "beyond array size" not savedlen.
> +	 *
> +	 *          +--------- array length (savedlen == 2)
> +	 *          |   +----- array size (nslots - 1 == 3)
> +	 *          |   |   +- window boundary (nslots == 4)
> +	 *          V   V | V

window boundary points to seq number 6 here. In all other
examples, it points between 5 and 6. Is that intentional?

> +	 *                |
> +	 *  0   1   2   3 |   slot number
> +	 * ---  0   1   2 |   array index

This looks odd. I guess this is because slot0 does
not belong to the array. Why is that?

Can we have slot0 integrated in the array? This would make
the counting much simpler IMO.

> +	 *     [b] [c] : :|   array
> +	 *                |
> +	 * "2" "3" "4" "5"|*6*  seq numbers

Is it so that in the example above packet [a] with seq number 2
is missing and we have packet [b] with seq number 3 in slot 1
and packet [c] with seq number 4 in slot 2?

> +	 *
> +	 * We receive seq number 6
> +	 * distance == 4 [inseq(6) - w_wantseq(2)]
> +	 * newslot == distance
> +	 * index == 3 [distance(4) - 1]
> +	 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
> +	 * shifting == 1 [min(savedlen(2), beyond(1)]
> +	 * slot0_skb == [b], and should match w_wantseq

We don't have slot0_skb, I guess this is slot0.

How will the example above look like after shifting?
Is it this:

	 *  0   1   2   3 |   slot number
	 * ---  0   1   2 |   array index
	 * [b] [c] : : [e]|   array
	 *                |
	 * "3" "4" "5" "6"|  seq numbers

Whereby [e] is the packet with seq number 6.

> +	 *
> +	 *                +--- window boundary (nslots == 4)
> +	 *  0   1   2   3 | 4   slot number
> +	 * ---  0   1   2 | 3   array index
> +	 *     [b] : : : :|     array
> +	 * "2" "3" "4" "5" *6*  seq numbers

What's the difference to the first example? Is it
the same but packet [c] is missing?

> +	 *
> +	 * We receive seq number 6
> +	 * distance == 4 [inseq(6) - w_wantseq(2)]
> +	 * newslot == distance
> +	 * index == 3 [distance(4) - 1]
> +	 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
> +	 * shifting == 1 [min(savedlen(1), beyond(1)]
> +	 * slot0_skb == [b] and should match w_wantseq
> +	 *
> +	 *                +-- window boundary (nslots == 4)
> +	 *  0   1   2   3 | 4   5   6   slot number
> +	 * ---  0   1   2 | 3   4   5   array index
> +	 *     [-] [c] : :|             array

What does [-] mean? Is it the [b] is missing?

> +	 * "2" "3" "4" "5" "6" "7" *8*  seq numbers
> +	 *
> +	 * savedlen = 2, beyond = 3
> +	 * iter 1: slot0 == NULL, missed++, lastdrop = 2 (2+1-1), slot0 = [-]
> +	 * iter 2: slot0 == NULL, missed++, lastdrop = 3 (2+2-1), slot0 = [c]
> +	 * 2 < 3, extra = 1 (3-2), missed += extra, lastdrop = 4 (2+2+1-1)
> +	 *
> +	 * We receive seq number 8
> +	 * distance == 6 [inseq(8) - w_wantseq(2)]
> +	 * newslot == distance
> +	 * index == 5 [distance(6) - 1]
> +	 * beyond == 3 [newslot(6) - lastslot((nslots(4) - 1))]
> +	 * shifting == 2 [min(savedlen(2), beyond(3)]
> +	 *
> +	 * slot0_skb == NULL changed from [b] when "savedlen < beyond" is true.
> +	 */
> +
> +	/* Now send any packets that are being shifted out of saved, and account
> +	 * for missing packets that are exiting the window as we shift it.
> +	 */

Documentation is in genaral good, but it must be clear what's
documented here. It took me quite a while to figure out what
these examples mean, and I'm still not absoluely sure if
I'm correct. All that might be clear to you when you wrote
that, but it is very hard to guess what you thought when
writing this :)

> +	/* If savedlen > beyond we are shifting some, else all. */
> +	shifting = min(savedlen, beyond);
> +
> +	/* slot0 is the buf that just shifted out and into slot0 */
> +	slot0 = NULL;

slot0 was set to NULL already at the beginning of this function.

It is just hard to notice because of the huge coment in the middle
of the function. It might make sense to put all that bigger comments
to a central place. It would make the functions more readable,
at least.

> @@ -2222,6 +2700,11 @@ static void iptfs_destroy_state(struct xfrm_state *x)
>  	if (xtfs->ra_newskb)
>  		kfree_skb(xtfs->ra_newskb);
>  
> +	for (s = xtfs->w_saved, se = s + xtfs->w_savedlen; s < se; s++)
> +		if (s->skb)
> +			kfree_skb(s->skb);

Braces please.


