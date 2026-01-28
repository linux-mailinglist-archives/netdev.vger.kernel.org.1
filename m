Return-Path: <netdev+bounces-254120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GH8N9q0eWk0ygEAu9opvQ
	(envelope-from <netdev+bounces-254120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:03:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7539D929
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C928F301A70E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37535327218;
	Wed, 28 Jan 2026 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzHXaKhg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOEM4+gn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7D231832
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769583815; cv=pass; b=GPPvWydJ62S7cv27QJeaRMCMCduRtjVsKiBcg+0feuneZ+uqvNvQ2JWKMCtF2H0dIEO0Os3X6aDLwezF9wq2pFTfnmk/s3P9WRKafQZfFa3VZpjpz9Uvg1vV3VIwJZwn0BGRqTw5lCUB0w6beWANO8MT2bPLYiMZHkFTnrHgCpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769583815; c=relaxed/simple;
	bh=Cg45hZ0q54h2bhG/P3fSulN0EvcFY+v0s3Ih49jJOI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt/T18D3yt5B0CZBoha+523rsV5cxR19hhkHvibWVDSDFPCTcggSlhMNW0awV8mqUR/UYZYLTMjCfQQk8EAPKXbJm4A7FTcvIKJnxJumd6thw7K4H+Cs973F+mbAjP69298sPaT+P3wGrinCwrvFY+3N70fQxzEcck1oBIm5/Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JzHXaKhg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOEM4+gn; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769583810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuKStyX4gBGrd4NIad9hOrKnHqdXGE6jzr0Ewri1egY=;
	b=JzHXaKhgC+tf+K5NHHHsL73MN9lhcJwiZTpUAbpitz0zqpblGCIxvNwChOPQLp/brN6Uvv
	JrtIkDQcjaEEb3TOa+2u67Wn/vSAgelMSxyZaZH7yIwmLsoqKL2SsP1efvhnY+n9PSy5jr
	YKoLuuRG8InAte22BFXT4U8uQW/PCfw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-hfEgysMqOkSPlmPUdavRDw-1; Wed, 28 Jan 2026 02:03:28 -0500
X-MC-Unique: hfEgysMqOkSPlmPUdavRDw-1
X-Mimecast-MFC-AGG-ID: hfEgysMqOkSPlmPUdavRDw_1769583807
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c613929d317so3712194a12.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 23:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769583807; cv=none;
        d=google.com; s=arc-20240605;
        b=D8NJbyVePH4DwcV54t7Xu0PeGKN13LM9HLtxokXENsC5Ub6Hq2Llw1n6Eg0Kawl0dt
         51t7yP0O4r7PB/NaIzujt5EFjPe+eyh6lOCH+oghX19r1wk+TivgS9c2zCDRwVqTCNQa
         nOGOFl18mJIp7a/CtjmH4rUibT4Oh/Vx+Np1dn3jqqV92gA4DqtXT2ClFlVSr2+BMBbH
         ESUdlqT+1jP2cY5Y6QnfmxbKGbA5kDM1rZUWePrHqUN4xK2nBW/YB4d6sehO2B0f4Q0z
         afejvb4uvwnn++it8KrkljCJvc1vGV0vpgtB5S+qUi9lKl60Zr/v5Zb62zhmo1KhkMfe
         nTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xuKStyX4gBGrd4NIad9hOrKnHqdXGE6jzr0Ewri1egY=;
        fh=mq8jVJvv0DFHt8zGD2Cu5FID6dK5Whd3XZsssQu/CW8=;
        b=KGA+Kv/7pLaqFbiACLQlxclI2fNrvHwWSTzbXtO4HXNin1VrkIfqvszEzW0cKD5aGe
         KryZB8UHbLlDznsBKpLWABIDsiijRKiitbW5gJHCWUD+r+UQc+IzAmFn2CpLjSWwsklX
         ykgSCydcnQ130iT/YO/+1EcxoiW5ALnYfVjtymdx+CEbUsDIQvxP9dSbGHiv75+bSQli
         j3O6ogwYPBfPCI6NSaCkt9lnLV5l7PBwtofaA8uqMNt26ojk9OuoN8V0pFhn/PLh4WTr
         5GbJrCP5nL4hpS5BThgXpJLVhSA3RQaU2nsKJzbbKVU+4uWDimDlP3ZVu5FwJFxgYyNJ
         ZbeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769583807; x=1770188607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuKStyX4gBGrd4NIad9hOrKnHqdXGE6jzr0Ewri1egY=;
        b=YOEM4+gnJZUk30LUPLwLrlFKtK+Y6MLBmsx6mHfzbvg9tCn2h3cdA3OSsB83ftVhDo
         W7REoM6jGoVG2qv67oUorc6F+RQSCC4C+bXv3dpuQp/UAuUh2K7EekJ9Y0soUYZ4dvUW
         q+rwUOL8PuOBcHe+oueDgExV93EEg+uoRrC6f8w1BqztuVyrsz/hrtZx2dP393PDL0pP
         w9jQqWuTWlxovUmMKkDUIkYZ9Nbla33KFVca6fHxbM55mPWqQ5BrVqJw02SPd4reKGgV
         RQhtn1jTqcSSh0OxbmEWZUOqVGYLv2UJEgnxw7nZeDlOH/oOoZHlD+ekbbTTO4qKFM3k
         ad1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769583807; x=1770188607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuKStyX4gBGrd4NIad9hOrKnHqdXGE6jzr0Ewri1egY=;
        b=c0nGCd0iH9PEZZm+dsFiYbEEqbLy0oMeSlM6pFwv9jxa09j8oBwcqints5ZzvrjpGS
         4wTMK5qbvyqtvIklwRT4fB7hekAdbLdpKioTndgDGqXQ9+6I0NSDqoyV7eemYHnIO991
         FFCugsA4JTQnmnctqvt5T7FKweyjWK3XjHibYALaEq5aSPkWzRPZCJLdNUi7OYJm3xlE
         FUj3coT+FnlqyDsyy1T7/ORE/CdCv8c1OJUB5pDLBQBV6uqQ2nht6xOmKo/S5iDlIpXz
         pXSZjVTqvx1udTTlB5GlBc6Ltrd0jk+7OwCYnCptY3rxDgqjJKcL6wj+GctIAlaxPN0T
         hNpw==
X-Forwarded-Encrypted: i=1; AJvYcCXGYQoToHAw9q9ykIYLwqcqFnHY57SR+jOi/Ne8uAmqfC1nmqBmysa6ZYOTp1oHNNW+4SlvaH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyexe/eXOa+PmyphRTbByZzF49CgzafDTrqQwP9+FVPmK7RIfFi
	xM+Nv0L7jNa6ck/wUvC6QuUFGENbC4cosuZoeqvrwemWStQsnzIQa9MVVYMDTOZ9CJpLrO/wHgE
	Ui1kiTDYQDWUyQfrHBA91AF/opHveuDnTwAN4XueYFBvU+/IdNsHCSFKkQMyMrRYE4v3zsEEot0
	MyFAlUe8024LFxQpSoBGzfvGFcxGSFasl8
X-Gm-Gg: AZuq6aLBjbES7bz60EATL6omKLSwJAKpC9FhLsybchNx1VuhtgIueuP1QIdfwwmj49R
	k5ejbTKdHpIdWfNgQASsa4Tn1QCrG9d6OLl/FpBP0dPBn0ugUigCT30TGRxrxWxpmsxj22lTv6s
	kYQdN55ECbfbKOVFugcEXrDIeeJvs/lJu09CBfHHsoDi2RbtZVuT3pYXQwo/h6yElN
X-Received: by 2002:a05:6a21:3388:b0:38d:ee4a:e833 with SMTP id adf61e73a8af0-38ec6549c19mr3702317637.62.1769583806875;
        Tue, 27 Jan 2026 23:03:26 -0800 (PST)
X-Received: by 2002:a05:6a21:3388:b0:38d:ee4a:e833 with SMTP id
 adf61e73a8af0-38ec6549c19mr3702286637.62.1769583806348; Tue, 27 Jan 2026
 23:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-4-simon.schippers@tu-dortmund.de> <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
 <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de> <CACGkMEtzD3ORJuJcc8VeqwASiGeVFdQmJowsK6PYVEF_Zkcn8Q@mail.gmail.com>
 <afa40345-acbe-42b0-81d1-0a838343792d@tu-dortmund.de> <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
 <CACGkMEsJKeEsH=G8H5RzMNHY4g3HNdciMDMhciShawh-9Xb9hg@mail.gmail.com>
 <bc1078e5-65fc-4de6-8475-517f626d8d96@tu-dortmund.de> <3a1d6232-efe4-4e79-a196-44794fdc0f33@tu-dortmund.de>
In-Reply-To: <3a1d6232-efe4-4e79-a196-44794fdc0f33@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jan 2026 15:03:11 +0800
X-Gm-Features: AZwV_QhDC_bWR-juret8NZb1IfXLfm23zEjia-LWh6nai9zCNajkiH0ao9SG7CE
Message-ID: <CACGkMEv71kn91FPAUrxJg=YB3+B0MRTgOidMPHjK7Qq0WEhGtw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254120-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tu-dortmund.de:email]
X-Rspamd-Queue-Id: 4F7539D929
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:48=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/23/26 10:54, Simon Schippers wrote:
> > On 1/23/26 04:05, Jason Wang wrote:
> >> On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> >>>
> >>> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 1/9/26 07:02, Jason Wang wrote:
> >>>>> On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> On 1/8/26 04:38, Jason Wang wrote:
> >>>>>>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>
> >>>>>>>> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_ring_=
consume()
> >>>>>>>> and wake the corresponding netdev subqueue when consuming an ent=
ry frees
> >>>>>>>> space in the underlying ptr_ring.
> >>>>>>>>
> >>>>>>>> Stopping of the netdev queue when the ptr_ring is full will be i=
ntroduced
> >>>>>>>> in an upcoming commit.
> >>>>>>>>
> >>>>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>>>>>> ---
> >>>>>>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>>>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>>>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>>>> index 1197f245e873..2442cf7ac385 100644
> >>>>>>>> --- a/drivers/net/tap.c
> >>>>>>>> +++ b/drivers/net/tap.c
> >>>>>>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_queu=
e *q,
> >>>>>>>>         return ret ? ret : total;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>>>>>> +{
> >>>>>>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>>>>>> +       struct net_device *dev;
> >>>>>>>> +       void *ptr;
> >>>>>>>> +
> >>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>> +
> >>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(rin=
g, 1))) {
> >>>>>>>> +               rcu_read_lock();
> >>>>>>>> +               dev =3D rcu_dereference(q->tap)->dev;
> >>>>>>>> +               netif_wake_subqueue(dev, q->queue_index);
> >>>>>>>> +               rcu_read_unlock();
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       spin_unlock(&ring->consumer_lock);
> >>>>>>>> +
> >>>>>>>> +       return ptr;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>>>                            struct iov_iter *to,
> >>>>>>>>                            int noblock, struct sk_buff *skb)
> >>>>>>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queue =
*q,
> >>>>>>>>                                         TASK_INTERRUPTIBLE);
> >>>>>>>>
> >>>>>>>>                 /* Read frames from the queue */
> >>>>>>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>>>>>> +               skb =3D tap_ring_consume(q);
> >>>>>>>>                 if (skb)
> >>>>>>>>                         break;
> >>>>>>>>                 if (noblock) {
> >>>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>>>> index 8192740357a0..7148f9a844a4 100644
> >>>>>>>> --- a/drivers/net/tun.c
> >>>>>>>> +++ b/drivers/net/tun.c
> >>>>>>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun_s=
truct *tun,
> >>>>>>>>         return total;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>>>>>> +{
> >>>>>>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>>>>>> +       struct net_device *dev;
> >>>>>>>> +       void *ptr;
> >>>>>>>> +
> >>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>> +
> >>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(rin=
g, 1))) {
> >>>>>>>
> >>>>>>> I guess it's the "bug" I mentioned in the previous patch that lea=
ds to
> >>>>>>> the check of __ptr_ring_consume_created_space() here. If it's tru=
e,
> >>>>>>> another call to tweak the current API.
> >>>>>>>
> >>>>>>>> +               rcu_read_lock();
> >>>>>>>> +               dev =3D rcu_dereference(tfile->tun)->dev;
> >>>>>>>> +               netif_wake_subqueue(dev, tfile->queue_index);
> >>>>>>>
> >>>>>>> This would cause the producer TX_SOFTIRQ to run on the same cpu w=
hich
> >>>>>>> I'm not sure is what we want.
> >>>>>>
> >>>>>> What else would you suggest calling to wake the queue?
> >>>>>
> >>>>> I don't have a good method in my mind, just want to point out its i=
mplications.
> >>>>
> >>>> I have to admit I'm a bit stuck at this point, particularly with thi=
s
> >>>> aspect.
> >>>>
> >>>> What is the correct way to pass the producer CPU ID to the consumer?
> >>>> Would it make sense to store smp_processor_id() in the tfile inside
> >>>> tun_net_xmit(), or should it instead be stored in the skb (similar t=
o the
> >>>> XDP bit)? In the latter case, my concern is that this information ma=
y
> >>>> already be significantly outdated by the time it is used.
> >>>>
> >>>> Based on that, my idea would be for the consumer to wake the produce=
r by
> >>>> invoking a new function (e.g., tun_wake_queue()) on the producer CPU=
 via
> >>>> smp_call_function_single().
> >>>> Is this a reasonable approach?
> >>>
> >>> I'm not sure but it would introduce costs like IPI.
> >>>
> >>>>
> >>>> More generally, would triggering TX_SOFTIRQ on the consumer CPU be
> >>>> considered a deal-breaker for the patch set?
> >>>
> >>> It depends on whether or not it has effects on the performance.
> >>> Especially when vhost is pinned.
> >>
> >> I meant we can benchmark to see the impact. For example, pin vhost to
> >> a specific CPU and the try to see the impact of the TX_SOFTIRQ.
> >>
> >> Thanks
> >>
> >
> > I ran benchmarks with vhost pinned to CPU 0 using taskset -p -c 0 ...
> > for both the stock and patched versions. The benchmarks were run with
> > the full patch series applied, since testing only patches 1-3 would not
> > be meaningful - the queue is never stopped in that case, so no
> > TX_SOFTIRQ is triggered.
> >
> > Compared to the non-pinned CPU benchmarks in the cover letter,
> > performance is lower for pktgen with a single thread but higher with
> > four threads. The results show no regression for the patched version,
> > with even slight performance improvements observed:
> >
> > +-------------------------+-----------+----------------+
> > | pktgen benchmarks to    | Stock     | Patched with   |
> > | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> > | 100M packets            |           |                |
> > | vhost pinned to core 0  |           |                |
> > +-----------+-------------+-----------+----------------+
> > | TAP       | Transmitted | 452 Kpps  | 454 Kpps       |
> > |  +        +-------------+-----------+----------------+
> > | vhost-net | Lost        | 1154 Kpps | 0              |
> > +-----------+-------------+-----------+----------------+
> >
> > +-------------------------+-----------+----------------+
> > | pktgen benchmarks to    | Stock     | Patched with   |
> > | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> > | 100M packets            |           |                |
> > | vhost pinned to core 0  |           |                |
> > | *4 threads*             |           |                |
> > +-----------+-------------+-----------+----------------+
> > | TAP       | Transmitted | 71 Kpps   | 79 Kpps        |
> > |  +        +-------------+-----------+----------------+
> > | vhost-net | Lost        | 1527 Kpps | 0              |
> > +-----------+-------------+-----------+----------------+

The PPS seems to be low. I'd suggest using testpmd (rxonly) mode in
the guest or an xdp program that did XDP_DROP in the guest.

> >
> > +------------------------+-------------+----------------+
> > | iperf3 TCP benchmarks  | Stock       | Patched with   |
> > | to Debian VM 120s      |             | fq_codel qdisc |
> > | vhost pinned to core 0 |             |                |
> > +------------------------+-------------+----------------+
> > | TAP                    | 22.0 Gbit/s | 22.0 Gbit/s    |
> > |  +                     |             |                |
> > | vhost-net              |             |                |
> > +------------------------+-------------+----------------+
> >
> > +---------------------------+-------------+----------------+
> > | iperf3 TCP benchmarks     | Stock       | Patched with   |
> > | to Debian VM 120s         |             | fq_codel qdisc |
> > | vhost pinned to core 0    |             |                |
> > | *4 iperf3 client threads* |             |                |
> > +---------------------------+-------------+----------------+
> > | TAP                       | 21.4 Gbit/s | 21.5 Gbit/s    |
> > |  +                        |             |                |
> > | vhost-net                 |             |                |
> > +---------------------------+-------------+----------------+
>
> What are your thoughts on this?
>
> Thanks!
>
>

Thanks


