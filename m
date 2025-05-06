Return-Path: <netdev+bounces-188358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B921AAC747
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65EB57B5F71
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832B828150D;
	Tue,  6 May 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=syst3mfailure.io header.i=@syst3mfailure.io header.b="MhLnVgbX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9C17BA5
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540056; cv=none; b=QKdcu969sWh0hN8tg5BcbjUDRWZPsp4QmVqVDora1ZpG2jUPHW1iiLrcwVGwEcv6h64YxqBhFhHNj2PlXvVG9jjfg0g/Y6EnxgmUpTJBFedu4O7AMcjFz0Z5vzwZPwn/do3KiKobLvN/rJzaHE30xXsNJJZQ2biijA5Q8odlczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540056; c=relaxed/simple;
	bh=jfBhPfjLiM6iY0WmAgWEklMpTliZ0Rd+Xz1ClpC+TMk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MX3q4CETJ+JBRQv82Z3/Bx/QlYo8P7nZYF4TAjfawR6CCEilFI7s3dumGr8fBQqpCzi8CS5xd1POi4nJMTMUYj3dw2gJxny32dzA85dOCvFn4i6kXKtbonNB42Twmei9zNvqzydmyRegK+C2I/bxV30gBwQ4XEG59hEYVQOPAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=syst3mfailure.io; spf=pass smtp.mailfrom=syst3mfailure.io; dkim=pass (2048-bit key) header.d=syst3mfailure.io header.i=@syst3mfailure.io header.b=MhLnVgbX; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=syst3mfailure.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syst3mfailure.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syst3mfailure.io;
	s=protonmail2; t=1746540042; x=1746799242;
	bh=KcroGX2/Sy8OMi7AdXYaSu4kr+3tToOUYqSxMG+6NTw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=MhLnVgbXw/BW9b0u8AOrsiR6WTaqt8KDX/uYZG+HqTk9zuztLRhuc05arjQdUj36J
	 m+hUZxR566DJrVJrn42Bu1w+zYgUSugbQYgsyo5M9qlXmcpatSnCKpD6JTE1tztzBq
	 12Atic/KjhGDFfFTOMz0IgHt/kGvpvygSBIIpHpX9TnHzo1A7uOpac4YYRpbMtAJdE
	 CcVmxCXORUIPkOV4qlAJxuRJmZ2lWYkuODwXs3zlq+mX1nfh+7dgtoYpodRxHEYI9/
	 xe1hCzVL6arQcECrF8EZoal1J6RLL0YgtTvp7S07XoLQThTxMO1GjyEMp2YIKUo28i
	 rvAviPfdMy67g==
Date: Tue, 06 May 2025 14:00:36 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: Savy <savy@syst3mfailure.io>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com, willsroot@protonmail.com
Subject: Re: [Patch net 1/2] net_sched: Flush gso_skb list too during ->change()
Message-ID: <krDuBwNbhtDxUlG2tgiXBwSA9KUwph1GfKqwvjBxYDSJv6nVQ98S_inVmQxaRBsndKdgg-rh_vN0xouX4zraF6V3UyQHpWNJUv-rvd-Cwfg=@syst3mfailure.io>
In-Reply-To: <20250506001549.65391-2-xiyou.wangcong@gmail.com>
References: <20250506001549.65391-1-xiyou.wangcong@gmail.com> <20250506001549.65391-2-xiyou.wangcong@gmail.com>
Feedback-ID: 69690694:user:proton
X-Pm-Message-ID: a7b825dec6914280c8d9002f1c056b864630cb69
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, May 6th, 2025 at 12:15 AM, Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:

>=20
> the main skb queue was trimmed, potentially leaving packets in the gso_sk=
b
> list. This could result in NULL pointer dereference when we only check
> sch->q.qlen against sch->limit.
>=20
>=20

Hi Cong,

With this version of the patch, the null-ptr-deref can still be triggered.
We also need to decrement sch->q.qlen if __skb_dequeue() returns a valid sk=
b.

We will take Codel as an example.

        while (sch->q.qlen > sch->limit) {
                struct sk_buff *skb =3D qdisc_dequeue_internal(sch, true);
                ...
        }

If sch->q.qlen is 1 and there is a single packet in the gso_skb list,
if sch->limit is dropped to 0 in codel_change, then qdisc_dequeue_internal(=
) -> __skb_dequeue()
will remove the skb from the gso_skb list, leaving sch->q.qlen unaltered.
At this point, the while loop continues, as sch->q.qlen is still 1, but now=
 both the main queue and gso_skb are empty,
so when qdisc_dequeue_internal() is called again, it returns NULL, and the =
null-ptr-deref occurs.

Something like this can fix the issue (tested with Codel):

static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, boo=
l direct)
{
        struct sk_buff *skb;

        skb =3D __skb_dequeue(&sch->gso_skb);
        if (skb) {
                sch->q.qlen--;
                return skb;
        }

        if (direct) {
                skb =3D __qdisc_dequeue_head(&sch->q);
        } else {
                skb =3D sch->dequeue(sch);
        }
        return skb;
}

Regards,
Savy
Will

