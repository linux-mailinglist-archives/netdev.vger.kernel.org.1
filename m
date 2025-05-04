Return-Path: <netdev+bounces-187641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A7AA8750
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 17:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6631737C7
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4B31B0F23;
	Sun,  4 May 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="N18HVlxl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3615199A
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746372975; cv=none; b=J+mYvKlgehwJhobk/UBeNw+4gisFk2zLKkECISZHNfLRz/l4XuK5yRZzhcn4uF/3E7cSb9ralo1IYZpZF4bSiVtegggrmlPiB9IoevJ0zx1EjnLg8S7e1jXlKWii9qt9NIMohJwkIbsVLIwg1n4kk1Ll79La7k1kzsLnTOuPCZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746372975; c=relaxed/simple;
	bh=ZWPfXpUGLTrJIXY7Ml6PlFZv34Nvka4JlcT+J5A+e6o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MV9j6InJm4LpMFcX2W+SaUBTozLort1MZmJ3mo3BzoeybI9UJdyaEUpNGag9DT3PrMMMQ4sE1EcPn8cJPQlL1JXcFqoeERSStEywrGeP689/1VKHq+XgsMfXuTdlo+iE7Lk8bGjMNtSozkJFJngocLfqyC7AWnQQ0nYmxBV0bh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=N18HVlxl; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1746372963; x=1746632163;
	bh=ZWPfXpUGLTrJIXY7Ml6PlFZv34Nvka4JlcT+J5A+e6o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=N18HVlxlHae5k8jLzadx7vLxH45VYnQy68pkfwIfkYyva00MCPP4urCpZpe+GkFhd
	 l2pe2jm5rwm+7G4S/OKhksDiXpi/NBwBKcAMr195yq0gjq97XAQG+PZ3kvn7MhjnZr
	 1UzYutUOqmQB92zGO+4E3j9xI2mnCTUCM28xPp6ImWGDzSo6M5Igp4To9q16b9rq8u
	 fQepGeA9lD2EjzcnCDV/h7EUpVxVbvByNRCv8XQUf08WXObRTsaw2Bp/hGzgJlo2DM
	 g5JrqcfixGItPKrfKyV9RIoTmTDRhhii6X/Q/6dq6HhpNb3/+tjI4IewLWm4WqQCAv
	 5k0sYcswshE/A==
Date: Sun, 04 May 2025 15:35:58 +0000
To: Savy <savy@syst3mfailure.io>
From: Will <willsroot@protonmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [BUG] net/sched: Race Condition and Null Dereference in codel_change, pie_change, fq_pie_change, fq_codel_change, hhf_change
Message-ID: <_Q1nNg0fi4eK6GzUh37pUz0t4_ce3LMlVRJ0daPQvjmM2OvYVmCpi1nSoYIIJllt8NxeSm02laUHa5-i3HHAAB3KXsf-flCsartZej5ykZg=@protonmail.com>
In-Reply-To: <EBHeQZeq5AJteszZoHrsiJv6EGOnuByQ-XNejgA9WiqQ8g2jIXowzoGjuJowDcV6xi9xBgyMTwNlS8wN0zUOlRl4Bl2Mv-x883IKCvdySyU=@syst3mfailure.io>
References: <UTd8zf-_MMCqMv9R15RSDZybxtCeV9czSvpeaslK7984UCPTX8pbSFVyWhzqiaA6HYFZtHIldd7guvr7_8xVfkk9xSUHnY3e8dSWi7pdVsE=@protonmail.com> <aA1kmZ/Hs0a33l5j@pop-os.localdomain> <B2ZSzsBR9rUWlLkrgrMrCzqOGeSFxXIkYImvul6994v5tDSqykWo1UaWKRV-SNkNKJurgVzRcnPN07ZAVYykRaYhADyIwTxQ18OQfKDpILQ=@protonmail.com> <aA/czQYEtPmMim0G@pop-os.localdomain> <EBHeQZeq5AJteszZoHrsiJv6EGOnuByQ-XNejgA9WiqQ8g2jIXowzoGjuJowDcV6xi9xBgyMTwNlS8wN0zUOlRl4Bl2Mv-x883IKCvdySyU=@syst3mfailure.io>
Feedback-ID: 25491499:user:proton
X-Pm-Message-ID: 7b20d27de24f7a911e85d478e4b4011e73ca78ee
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Cong,

Just following up on this - are there any updates for a fix?

Thank you,
Will

On Tuesday, April 29th, 2025 at 1:41 PM, Savy <savy@syst3mfailure.io> wrote=
:

>=20
>=20
>=20
> On Monday, April 28th, 2025 at 7:53 PM, Cong Wang xiyou.wangcong@gmail.co=
m wrote:
>=20
> > Excellent analysis!
> >=20
> > Do you mind testing the following patch?
> >=20
> > Note:
> >=20
> > 1) We can't just test NULL, because otherwise we would leak the skb's
> > in gso_skb list.
> >=20
> > 2) I am totally aware that maybe there are some other cases need the
> > same fix, but I want to be conservative here since this will be
> > targeting for -stable. It is why I intentionally keep my patch minimum.
> >=20
> > Thanks!
> >=20
> > --------------->
>=20
>=20
> Hi Cong,
>=20
> Thank you for the reply. We have tested your patch and can confirm that i=
t resolves the issue.
> However, regarding point [1], we conducted some tests to verify if there =
is a skb leak in the gso_skb list,
> but the packet remains in the list only for a limited amount of time.
>=20
> In our POC we set a very low TBF rate, so when the Qdisc runs out of toke=
ns,
> it reschedules itself via qdisc watchdog after approximately 45 seconds.
>=20
> Returning to the example above, here is what happens when the watchdog ti=
mer fires:
>=20
> [ ... ]
>=20
> Packet 2 is sent:
>=20
> [ ... ]
>=20
> tbf_dequeue()
> qdisc_peek_dequeued()
> skb_peek(&sch->gso_skb) // sch->gso_skb is empty
>=20
> codel_qdisc_dequeue() // Codel qlen is 1
> qdisc_dequeue_head()
> // Packet 2 is removed from the queue
> // Codel qlen =3D 0
> __skb_queue_head(&sch->gso_skb, skb); // Packet 2 is added to gso_skb lis=
t
>=20
> sch->q.qlen++ // Codel qlen =3D 1
>=20
>=20
> // TBF runs out of tokens and reschedules itself for later
> qdisc_watchdog_schedule_ns()
>=20
> codel_change() // Patched, (!skb) break;, does not crash
>=20
> // ... ~45 seconds later the qdisc watchdog timer fires
>=20
> tbf_dequeue()
> qdisc_peek_dequeued()
> skb_peek(&sch->gso_skb) // sch->gso_skb is not empty (contains Packet 2)
>=20
> // TBF now has enough tokens
> qdisc_dequeue_peeked()
> skb =3D __skb_dequeue(&sch->gso_skb) // Packet 2 is removed from the gso_=
skb list
>=20
> sch->q.qlen-- // Codel qlen =3D 0
>=20
>=20
> Notice how the gso_skb list is correctly cleaned up when the watchdog tim=
er fires.
> We also examined some edge cases, such as when the watchdog is canceled
> and there are still packets left in the gso_skb list, and it is always cl=
eaned up:
>=20
> Qdisc destruction case:
>=20
> tbf_destroy()
> qdisc_put()
> __qdisc_destroy()
> qdisc_reset()
> __skb_queue_purge(&qdisc->gso_skb);
>=20
>=20
> Qdisc reset case:
>=20
> tbf_reset()
> qdisc_reset()
> __skb_queue_purge(&qdisc->gso_skb);
>=20
>=20
> Perhaps the skb leak you mentioned occurs in another edge case that we ov=
erlooked?
> In any case, we believe your patch is technically more correct,
> as it makes sense to clean up packets in the gso_skb list first when the =
limit changes.
>=20
> Best regards,
> Savy
> Will

