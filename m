Return-Path: <netdev+bounces-256945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM70MMYVhGkIygMAu9opvQ
	(envelope-from <netdev+bounces-256945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:00:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7AEE710
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E96F300469C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 03:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CAF2E9733;
	Thu,  5 Feb 2026 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="as28+Bwo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEqep7NQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D742E8897
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263994; cv=pass; b=SUa9epv7XIN5XzbUO8Rv7QX8aQs4Ta4/DC4dGAcsOtZo85frhV2jutV5PnmMBxtziFUx50AABjEUucuQlO5z3R4TCjsVADD0PtYTWhvXMeVGbj3rOlK2YgYzj2cp3xStEyBymTaxp3BcZhncGsLVjjEzRs64Pneskcke9p1FOk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263994; c=relaxed/simple;
	bh=bfhphnRA5zer3H1zeiNu4pF41M4BAfyhbX6/oa7Kygc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/37s7Pkc8s7CTB0dRcrdBHJg8rTT3NV5UmtdH30ImIceU52hNo5qPU468PaUjRzt1SKZ1GwZ6qolFNlilpY7NcxFGjGpTfFATZIZ4XCdGWODd92MtXje00Zs2xIn4faPV0HKVXLQB5H8UOaBo2izSR9i3niltO/b2pG9pluqas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=as28+Bwo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEqep7NQ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770263993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljtQzezi2FxbD86kjMOelb1Xz/e3jR0e/78H4lX77ko=;
	b=as28+BwoyBIuaqnlwvG+xjIokjSEjmcxKxbGYBEVYkYumz+ZrnioiyOgNKdtSbCLf0Hi1A
	M3HvJBC3AQZq42FleDZqZuOb49GBOOPEk4jOvMoL3PgA+LYiQqIv7HEMyPGP+aTENT3NsF
	iED6YuG+XQGbmTqm+GWyzTQvL7K5vRI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-EkODMjj3OO643VePcAwosw-1; Wed, 04 Feb 2026 22:59:52 -0500
X-MC-Unique: EkODMjj3OO643VePcAwosw-1
X-Mimecast-MFC-AGG-ID: EkODMjj3OO643VePcAwosw_1770263991
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso1939821a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 19:59:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770263987; cv=none;
        d=google.com; s=arc-20240605;
        b=fjGFAKfGHv5ikdcu5d4UxFZmKnYEbTV53l2S2xjPBLNFEdmaDx5ozpONCWk++Hm1Fm
         MFL8PC/OhBbQ/IxbTfqKqFle4dgaVPe75IC5Qa83Fzt8arrtmjczpW5rjUbw8NeWm+Zc
         wQ+U157kcqtpIpOVpWcqlbGpDlovyYhK2TBWY4OYlYDLbOt8/Icdq6WfBdxLaNGIBins
         RhR+gG9SL7I1IH+cpqQD14vEBsYakhBI46G2S4muU9kifMzuvVAVv6cZpYtlGSZzCxn3
         4aoMv0Fbo7FN2nwdOGqGuPV1JNLrZOq0Umg6pY6djjWUf3KMxAllcaJ2DyhLpOCvfoht
         hy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ljtQzezi2FxbD86kjMOelb1Xz/e3jR0e/78H4lX77ko=;
        fh=hfG0pxEyIe+Y+5Y32c8zs75/wbV1uo4s2whPg5rkYgI=;
        b=MHPXkmufPab64jirO5FQXRCF9ItYdVfy9jCg5fwajnxtd7+aJm9ANpi3kYAl4G7wmQ
         aHVsj3Us2oI5GDGQZJmBqd3DagRUBIXROvjD+cFW59TqLWd24ZWCbBY8drQanMkloFX8
         xAgNLJQvZDl1EJI9w1eoH3rF6FLWfNZjcYXxyZI78Tix1yu/8z8fQqXn0KntYAeKoCCe
         rVa88tGo9fkC/mSN3mIVy65Q/b9qrFifH0z82vkuWjdWSy26u8yrjjC6STNzk6v5IzWI
         GpyHPdtmSFp0fdTmmVl3i8lWoOchik+cBLp0VNA/OHUhBlfN8hzM+lx3V9K6gK6znZVf
         242A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770263987; x=1770868787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljtQzezi2FxbD86kjMOelb1Xz/e3jR0e/78H4lX77ko=;
        b=BEqep7NQu8Q2bdbDpnCH5AFbzr8yg0PiZ6hEc2KIvHKaqPeH1IeTco+mHqQh/QODQ0
         jffpiObdmvI4VtcjRnfrzDnTxPwzCdAUkZVIeQkxAaBxZ6QmNgNbRSRVqoAym3kQwTb7
         Fnc3U/rYXxRgGcljljaW6L7avh3Hep7hC9AXq0wKKHwdZmzSGLZ4y8T75kuY9rFUZ4zg
         M619Ai+tfNl6xxk+GyLLgQZbS9NefKvRGKcF+NhXl94xe/wWO29o8VETMR168nNpwn/0
         QRwXJVd30bsQTjEi2pCofgxCUdSKAzwSQyoN0nH05JdxYuCULWKQWpEfMRJkAtFjEQsk
         8M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770263987; x=1770868787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ljtQzezi2FxbD86kjMOelb1Xz/e3jR0e/78H4lX77ko=;
        b=OOYUZD6Hs21lrynAhvBeeU9fjW1Tu6ZOYLVz6/m9JJxOZ1ageJL6E1idE4nIlFJMVF
         tyu3EohRpfRaUTEOKjz3q0GqznnzbHRGYnecFReWNpszQ6Pkf/o5RDS4VZ1NHwoY99uB
         8FILDO+JLmvBEE/WsNY2KvPR/Qjo9KtoRRdoA7LNxudU383aTTzAWiDsANFMOB9edioI
         woCGfVgbproEMXLWZNm9EgTZpWebxgwvL+SszaYl5vauyx6/TjxZprGQGrvzrhc9wPDd
         mxyL2izW4NoNxYsdkNokWDQX093HSBmd06Qhm0/+kb78OCid/CdyHNEuYrKdXErRhIxn
         4FmA==
X-Forwarded-Encrypted: i=1; AJvYcCXtHT+ZJ9PM5il8VCmTHH45r80yZZxeChpuOU35Lu8SPUOZQXG6N4jdjAxh5ZQycpJyHZM0OCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwaCjj9mEJ49wvnnXtQP/hmVP0t3oNFAXFHCnCmyMoRPFoMHTN
	3HEZ69TKuWBA0TDJo3syH4fgUJ/RYVqWy7aJdzjWizxQ4L0fuzv/G53fTkSqR0A/BVaYW8QUL1e
	4Cr4gKkoGHBzO/XdX2dq371UaXiBUzWLDddIJwwNqeLASgu62DrcEap9Hw6MAl0JHFYQDgelJU9
	ZMuz0NKtD4kUGNUStvzYSAlfC/P/0PKuuvgv2KfMtQ
X-Gm-Gg: AZuq6aIV83qnUX4QrMzFuxI3WgJ32d8RZtx1m2SEEGPLBE6Ev1ZHFmq20oa8iOXQcQk
	xSxxAMeCh96Jd+i3lgOw7B8wo8DtvZjCpaWU2a/oP31ShRT1l1yexEfDzQHq0saf6j4EU3eRva+
	KznzysHZb74slcghfIbBQLnRoGMzMMtAInDyyhDP0SpkbNbLQYw9MgFwts4pj1gxKOVQ==
X-Received: by 2002:a17:90b:51c1:b0:340:b501:7b83 with SMTP id 98e67ed59e1d1-3549beb61d0mr1342219a91.10.1770263986585;
        Wed, 04 Feb 2026 19:59:46 -0800 (PST)
X-Received: by 2002:a17:90b:51c1:b0:340:b501:7b83 with SMTP id
 98e67ed59e1d1-3549beb61d0mr1342194a91.10.1770263986077; Wed, 04 Feb 2026
 19:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
 <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de> <CACGkMEtzD3ORJuJcc8VeqwASiGeVFdQmJowsK6PYVEF_Zkcn8Q@mail.gmail.com>
 <afa40345-acbe-42b0-81d1-0a838343792d@tu-dortmund.de> <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
 <CACGkMEsJKeEsH=G8H5RzMNHY4g3HNdciMDMhciShawh-9Xb9hg@mail.gmail.com>
 <bc1078e5-65fc-4de6-8475-517f626d8d96@tu-dortmund.de> <3a1d6232-efe4-4e79-a196-44794fdc0f33@tu-dortmund.de>
 <CACGkMEv71kn91FPAUrxJg=YB3+B0MRTgOidMPHjK7Qq0WEhGtw@mail.gmail.com>
 <260f48cd-caa1-4684-a235-8e1192722b3a@tu-dortmund.de> <CACGkMEsVMz+vS3KxykYBGXvyt3MZcstnYWUiYJZhLSMoHC5Smw@mail.gmail.com>
 <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de> <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
 <0ebc00ba-35e7-4570-a44f-b0ae634f2316@tu-dortmund.de> <CACGkMEsJtE3RehWQ8BaDL2HdFPK=iW+ZaEAN1TekAMWwor5tjQ@mail.gmail.com>
 <197573a1-df52-4928-adb9-55a7a4f78839@tu-dortmund.de>
In-Reply-To: <197573a1-df52-4928-adb9-55a7a4f78839@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Feb 2026 11:59:34 +0800
X-Gm-Features: AZwV_QiJtn5H5gbXXSINnNFKoMHH3t5eiT8AX-RzqcNru-kUb1aFsLgKadZkfcw
Message-ID: <CACGkMEveEXky_rTrvRrfi7qix12GG91GfyqnwB6Tu-dnjqAm9A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256945-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pktgen_sample02_multiqueue.sh:url,pktgen_sample03_burst_single_flow.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.0:email]
X-Rspamd-Queue-Id: D6F7AEE710
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 11:44=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 2/3/26 04:48, Jason Wang wrote:
> > On Mon, Feb 2, 2026 at 4:19=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 1/30/26 02:51, Jason Wang wrote:
> >>> On Thu, Jan 29, 2026 at 5:25=E2=80=AFPM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 1/29/26 02:14, Jason Wang wrote:
> >>>>> On Wed, Jan 28, 2026 at 3:54=E2=80=AFPM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> On 1/28/26 08:03, Jason Wang wrote:
> >>>>>>> On Wed, Jan 28, 2026 at 12:48=E2=80=AFAM Simon Schippers
> >>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>
> >>>>>>>> On 1/23/26 10:54, Simon Schippers wrote:
> >>>>>>>>> On 1/23/26 04:05, Jason Wang wrote:
> >>>>>>>>>> On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowang@r=
edhat.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> >>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 1/9/26 07:02, Jason Wang wrote:
> >>>>>>>>>>>>> On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> >>>>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 1/8/26 04:38, Jason Wang wrote:
> >>>>>>>>>>>>>>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>>>>>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Introduce {tun,tap}_ring_consume() helpers that wrap __p=
tr_ring_consume()
> >>>>>>>>>>>>>>>> and wake the corresponding netdev subqueue when consumin=
g an entry frees
> >>>>>>>>>>>>>>>> space in the underlying ptr_ring.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Stopping of the netdev queue when the ptr_ring is full w=
ill be introduced
> >>>>>>>>>>>>>>>> in an upcoming commit.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de=
>
> >>>>>>>>>>>>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>>>>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortm=
und.de>
> >>>>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>>>>>>>>>>>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>>>>>>>>>>>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>>>>>>>>>>>> index 1197f245e873..2442cf7ac385 100644
> >>>>>>>>>>>>>>>> --- a/drivers/net/tap.c
> >>>>>>>>>>>>>>>> +++ b/drivers/net/tap.c
> >>>>>>>>>>>>>>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct =
tap_queue *q,
> >>>>>>>>>>>>>>>>         return ret ? ret : total;
> >>>>>>>>>>>>>>>>  }
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>>>>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_s=
pace(ring, 1))) {
> >>>>>>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>>>>>> +               dev =3D rcu_dereference(q->tap)->dev;
> >>>>>>>>>>>>>>>> +               netif_wake_subqueue(dev, q->queue_index)=
;
> >>>>>>>>>>>>>>>> +               rcu_read_unlock();
> >>>>>>>>>>>>>>>> +       }
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +       spin_unlock(&ring->consumer_lock);
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +       return ptr;
> >>>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>>>>>>>>>>>                            struct iov_iter *to,
> >>>>>>>>>>>>>>>>                            int noblock, struct sk_buff *=
skb)
> >>>>>>>>>>>>>>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct ta=
p_queue *q,
> >>>>>>>>>>>>>>>>                                         TASK_INTERRUPTIB=
LE);
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>                 /* Read frames from the queue */
> >>>>>>>>>>>>>>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>>>>>>>>>>>>>> +               skb =3D tap_ring_consume(q);
> >>>>>>>>>>>>>>>>                 if (skb)
> >>>>>>>>>>>>>>>>                         break;
> >>>>>>>>>>>>>>>>                 if (noblock) {
> >>>>>>>>>>>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>>>>>>>>>>>> index 8192740357a0..7148f9a844a4 100644
> >>>>>>>>>>>>>>>> --- a/drivers/net/tun.c
> >>>>>>>>>>>>>>>> +++ b/drivers/net/tun.c
> >>>>>>>>>>>>>>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(stru=
ct tun_struct *tun,
> >>>>>>>>>>>>>>>>         return total;
> >>>>>>>>>>>>>>>>  }
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>>>>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_s=
pace(ring, 1))) {
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I guess it's the "bug" I mentioned in the previous patch =
that leads to
> >>>>>>>>>>>>>>> the check of __ptr_ring_consume_created_space() here. If =
it's true,
> >>>>>>>>>>>>>>> another call to tweak the current API.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>>>>>> +               dev =3D rcu_dereference(tfile->tun)->dev=
;
> >>>>>>>>>>>>>>>> +               netif_wake_subqueue(dev, tfile->queue_in=
dex);
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> This would cause the producer TX_SOFTIRQ to run on the sa=
me cpu which
> >>>>>>>>>>>>>>> I'm not sure is what we want.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> What else would you suggest calling to wake the queue?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I don't have a good method in my mind, just want to point o=
ut its implications.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I have to admit I'm a bit stuck at this point, particularly =
with this
> >>>>>>>>>>>> aspect.
> >>>>>>>>>>>>
> >>>>>>>>>>>> What is the correct way to pass the producer CPU ID to the c=
onsumer?
> >>>>>>>>>>>> Would it make sense to store smp_processor_id() in the tfile=
 inside
> >>>>>>>>>>>> tun_net_xmit(), or should it instead be stored in the skb (s=
imilar to the
> >>>>>>>>>>>> XDP bit)? In the latter case, my concern is that this inform=
ation may
> >>>>>>>>>>>> already be significantly outdated by the time it is used.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Based on that, my idea would be for the consumer to wake the=
 producer by
> >>>>>>>>>>>> invoking a new function (e.g., tun_wake_queue()) on the prod=
ucer CPU via
> >>>>>>>>>>>> smp_call_function_single().
> >>>>>>>>>>>> Is this a reasonable approach?
> >>>>>>>>>>>
> >>>>>>>>>>> I'm not sure but it would introduce costs like IPI.
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> More generally, would triggering TX_SOFTIRQ on the consumer =
CPU be
> >>>>>>>>>>>> considered a deal-breaker for the patch set?
> >>>>>>>>>>>
> >>>>>>>>>>> It depends on whether or not it has effects on the performanc=
e.
> >>>>>>>>>>> Especially when vhost is pinned.
> >>>>>>>>>>
> >>>>>>>>>> I meant we can benchmark to see the impact. For example, pin v=
host to
> >>>>>>>>>> a specific CPU and the try to see the impact of the TX_SOFTIRQ=
.
> >>>>>>>>>>
> >>>>>>>>>> Thanks
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I ran benchmarks with vhost pinned to CPU 0 using taskset -p -c=
 0 ...
> >>>>>>>>> for both the stock and patched versions. The benchmarks were ru=
n with
> >>>>>>>>> the full patch series applied, since testing only patches 1-3 w=
ould not
> >>>>>>>>> be meaningful - the queue is never stopped in that case, so no
> >>>>>>>>> TX_SOFTIRQ is triggered.
> >>>>>>>>>
> >>>>>>>>> Compared to the non-pinned CPU benchmarks in the cover letter,
> >>>>>>>>> performance is lower for pktgen with a single thread but higher=
 with
> >>>>>>>>> four threads. The results show no regression for the patched ve=
rsion,
> >>>>>>>>> with even slight performance improvements observed:
> >>>>>>>>>
> >>>>>>>>> +-------------------------+-----------+----------------+
> >>>>>>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>>>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>>>>>> | 100M packets            |           |                |
> >>>>>>>>> | vhost pinned to core 0  |           |                |
> >>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>> | TAP       | Transmitted | 452 Kpps  | 454 Kpps       |
> >>>>>>>>> |  +        +-------------+-----------+----------------+
> >>>>>>>>> | vhost-net | Lost        | 1154 Kpps | 0              |
> >>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>>
> >>>>>>>>> +-------------------------+-----------+----------------+
> >>>>>>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>>>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>>>>>> | 100M packets            |           |                |
> >>>>>>>>> | vhost pinned to core 0  |           |                |
> >>>>>>>>> | *4 threads*             |           |                |
> >>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>> | TAP       | Transmitted | 71 Kpps   | 79 Kpps        |
> >>>>>>>>> |  +        +-------------+-----------+----------------+
> >>>>>>>>> | vhost-net | Lost        | 1527 Kpps | 0              |
> >>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>
> >>>>>>> The PPS seems to be low. I'd suggest using testpmd (rxonly) mode =
in
> >>>>>>> the guest or an xdp program that did XDP_DROP in the guest.
> >>>>>>
> >>>>>> I forgot to mention that these PPS values are per thread.
> >>>>>> So overall we have 71 Kpps * 4 =3D 284 Kpps and 79 Kpps * 4 =3D 32=
6 Kpps,
> >>>>>> respectively. For packet loss, that comes out to 1154 Kpps * 4 =3D
> >>>>>> 4616 Kpps and 0, respectively.
> >>>>>>
> >>>>>> Sorry about that!
> >>>>>>
> >>>>>> The pktgen benchmarks with a single thread look fine, right?
> >>>>>
> >>>>> Still looks very low. E.g I just have a run of pktgen (using
> >>>>> pktgen_sample03_burst_single_flow.sh) without a XDP_DROP in the gue=
st,
> >>>>> I can get 1Mpps.
> >>>>
> >>>> Keep in mind that I am using an older CPU (i5-6300HQ). For the
> >>>> single-threaded tests I always used pktgen_sample01_simple.sh, and f=
or
> >>>> the multi-threaded tests I always used pktgen_sample02_multiqueue.sh=
.
> >>>>
> >>>> Using pktgen_sample03_burst_single_flow.sh as you did fails for me (=
even
> >>>> though the same parameters work fine for sample01 and sample02):
> >>>>
> >>>> samples/pktgen/pktgen_sample03_burst_single_flow.sh -i tap0 -m
> >>>> 52:54:00:12:34:56 -d 10.0.0.2 -n 100000000
> >>>> /samples/pktgen/functions.sh: line 79: echo: write error: Operation =
not
> >>>> supported
> >>>> ERROR: Write error(1) occurred
> >>>> cmd: "burst 32 > /proc/net/pktgen/tap0@0"
> >>>>
> >>>> ...and I do not know what I am doing wrong, even after looking at
> >>>> Documentation/networking/pktgen.rst. Every burst size except 1 fails=
.
> >>>> Any clues?
> >>>
> >>> Please use -b 0, and I'm Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz.
> >>
> >> I tried using "-b 0", and while it worked, there was no noticeable
> >> performance improvement.
> >>
> >>>
> >>> Another thing I can think of is to disable
> >>>
> >>> 1) mitigations in both guest and host
> >>> 2) any kernel debug features in both host and guest
> >>
> >> I also rebuilt the kernel with everything disabled under
> >> "Kernel hacking", but that didn=E2=80=99t make any difference either.
> >>
> >> Because of this, I ran "pktgen_sample01_simple.sh" and
> >> "pktgen_sample02_multiqueue.sh" on my AMD Ryzen 5 5600X system. The
> >> results were about 374 Kpps with TAP and 1192 Kpps with TAP+vhost_net,
> >> with very similar performance between the stock and patched kernels.
> >>
> >> Personally, I think the low performance is to blame on the hardware.
> >
> > Let's double confirm this by:
> >
> > 1) make sure pktgen is using 100% CPU
> > 2) Perf doesn't show anything strange for pktgen thread
> >
> > Thanks
> >
>
> I ran pktgen using pktgen_sample01_simple.sh and, in parallel, started a
> 100 second perf stat measurement covering all kpktgend threads.
>
> Across all configurations, a single CPU was fully utilized.
>
> Apart from that, the patched variants show a higher branch frequency and
> a slightly increased number of context switches.
>
>
> The detailed results are provided below:
>
> Processor: Ryzen 5 5600X
>
> pktgen command:
> sudo perf stat samples/pktgen/pktgen_sample01_simple.sh -i tap0 -m
> 52:54:00:12:34:56 -d 10.0.0.2 -n 10000000000
>
> perf stat command:
> sudo perf stat --timeout 100000 -p $(pgrep kpktgend | tr '\n' ,) -o X.txt
>
>
> Results:
> Stock TAP:
>             46.997      context-switches                 #    467,2 cs/se=
c  cs_per_second
>                  0      cpu-migrations                   #      0,0 migra=
tions/sec  migrations_per_second
>                  0      page-faults                      #      0,0 fault=
s/sec  page_faults_per_second
>         100.587,69 msec task-clock                       #      1,0 CPUs =
 CPUs_utilized
>      8.491.586.483      branch-misses                    #     10,9 %  br=
anch_miss_rate         (50,24%)
>     77.734.761.406      branches                         #    772,8 M/sec=
  branch_frequency     (66,85%)
>    382.420.291.585      cpu-cycles                       #      3,8 GHz  =
cycles_frequency       (66,85%)
>    377.612.185.141      instructions                     #      1,0 instr=
uctions  insn_per_cycle  (66,85%)
>     84.012.185.936      stalled-cycles-frontend          #     0,22 front=
end_cycles_idle        (66,35%)
>
>      100,100414494 seconds time elapsed
>
>
> Stock TAP+vhost-net:
>             47.087      context-switches                 #    468,1 cs/se=
c  cs_per_second
>                  0      cpu-migrations                   #      0,0 migra=
tions/sec  migrations_per_second
>                  0      page-faults                      #      0,0 fault=
s/sec  page_faults_per_second
>         100.594,09 msec task-clock                       #      1,0 CPUs =
 CPUs_utilized
>      8.034.703.613      branch-misses                    #     11,1 %  br=
anch_miss_rate         (50,24%)
>     72.477.989.922      branches                         #    720,5 M/sec=
  branch_frequency     (66,86%)
>    382.218.276.832      cpu-cycles                       #      3,8 GHz  =
cycles_frequency       (66,85%)
>    349.555.577.281      instructions                     #      0,9 instr=
uctions  insn_per_cycle  (66,85%)
>     83.917.644.262      stalled-cycles-frontend          #     0,22 front=
end_cycles_idle        (66,35%)
>
>      100,100520402 seconds time elapsed
>
>
> Patched TAP:
>             47.862      context-switches                 #    475,8 cs/se=
c  cs_per_second
>                  0      cpu-migrations                   #      0,0 migra=
tions/sec  migrations_per_second
>                  0      page-faults                      #      0,0 fault=
s/sec  page_faults_per_second
>         100.589,30 msec task-clock                       #      1,0 CPUs =
 CPUs_utilized
>      9.337.258.794      branch-misses                    #      9,4 %  br=
anch_miss_rate         (50,19%)
>     99.518.421.676      branches                         #    989,4 M/sec=
  branch_frequency     (66,85%)
>    382.508.244.894      cpu-cycles                       #      3,8 GHz  =
cycles_frequency       (66,85%)
>    312.582.270.975      instructions                     #      0,8 instr=
uctions  insn_per_cycle  (66,85%)
>     76.338.503.984      stalled-cycles-frontend          #     0,20 front=
end_cycles_idle        (66,39%)
>
>      100,101262454 seconds time elapsed
>
>
> Patched TAP+vhost-net:
>             47.892      context-switches                 #    476,1 cs/se=
c  cs_per_second
>                  0      cpu-migrations                   #      0,0 migra=
tions/sec  migrations_per_second
>                  0      page-faults                      #      0,0 fault=
s/sec  page_faults_per_second
>         100.581,95 msec task-clock                       #      1,0 CPUs =
 CPUs_utilized
>      9.083.588.313      branch-misses                    #     10,1 %  br=
anch_miss_rate         (50,28%)
>     90.300.124.712      branches                         #    897,8 M/sec=
  branch_frequency     (66,85%)
>    382.374.510.376      cpu-cycles                       #      3,8 GHz  =
cycles_frequency       (66,85%)
>    340.089.181.199      instructions                     #      0,9 instr=
uctions  insn_per_cycle  (66,85%)
>     78.151.408.955      stalled-cycles-frontend          #     0,20 front=
end_cycles_idle        (66,31%)
>
>      100,101212911 seconds time elapsed

Thanks for sharing. I have more questions:

1) The number of CPU and vCPUs
2) If you pin vhost or vCPU threads
3) what does perf top looks like or perf top -p $pid_of_vhost

>
> >>
> >> Thanks!
> >>
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>> Thanks!
> >>>>
> >>>>>
> >>>>>>
> >>>>>> I'll still look into using an XDP program that does XDP_DROP in th=
e
> >>>>>> guest.
> >>>>>>
> >>>>>> Thanks!
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>> +------------------------+-------------+----------------+
> >>>>>>>>> | iperf3 TCP benchmarks  | Stock       | Patched with   |
> >>>>>>>>> | to Debian VM 120s      |             | fq_codel qdisc |
> >>>>>>>>> | vhost pinned to core 0 |             |                |
> >>>>>>>>> +------------------------+-------------+----------------+
> >>>>>>>>> | TAP                    | 22.0 Gbit/s | 22.0 Gbit/s    |
> >>>>>>>>> |  +                     |             |                |
> >>>>>>>>> | vhost-net              |             |                |
> >>>>>>>>> +------------------------+-------------+----------------+
> >>>>>>>>>
> >>>>>>>>> +---------------------------+-------------+----------------+
> >>>>>>>>> | iperf3 TCP benchmarks     | Stock       | Patched with   |
> >>>>>>>>> | to Debian VM 120s         |             | fq_codel qdisc |
> >>>>>>>>> | vhost pinned to core 0    |             |                |
> >>>>>>>>> | *4 iperf3 client threads* |             |                |
> >>>>>>>>> +---------------------------+-------------+----------------+
> >>>>>>>>> | TAP                       | 21.4 Gbit/s | 21.5 Gbit/s    |
> >>>>>>>>> |  +                        |             |                |
> >>>>>>>>> | vhost-net                 |             |                |
> >>>>>>>>> +---------------------------+-------------+----------------+
> >>>>>>>>
> >>>>>>>> What are your thoughts on this?
> >>>>>>>>
> >>>>>>>> Thanks!
> >>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
>


