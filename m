Return-Path: <netdev+bounces-256110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPy3AUhwgWlLGQMAu9opvQ
	(envelope-from <netdev+bounces-256110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:49:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58980D4365
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D260B304EAA5
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 03:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AF2F39B5;
	Tue,  3 Feb 2026 03:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuTLZwPZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nbRfdM0b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A91C28E
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 03:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770090538; cv=pass; b=C7UG5iKs7sfPeiUY3LXvGynOdfTCcRY23h0Q0DzCcQWPNdKzOxeE8avyfmnqz5OnAJuF8U2J5GS7eNtOFYqOW9fnWeHxlj3xtpGM3ESyezoH8FzRTuRWA0wsTno8SRyi/n8EGoQV2GwqwXQbIePPKdo3rGK8LET2ytF7Xvjfxe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770090538; c=relaxed/simple;
	bh=Ab2Jstto+ny4j1NIR5kZUolDQEjl5APTwBJjwoHUpOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+lCuMhrlwHZBo8SM99txqIs/TF38oDC1eAgI1VG4nYn/myUBxudmagWlVCGqHm1L+IC0X7S8U5JLUR/bxKLT8xelTzYPK935ehaUOPpbHVIY3Rro4KzONYxeNEaXKG2bPMqo8zQbifT8Q2rzmORHEtTQG1QgRNjImTMlDtsl0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuTLZwPZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nbRfdM0b; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770090535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9Ma1r17hH/la3W1p6fFaX3L2SwJmH0RiR5aM5Sicfk=;
	b=IuTLZwPZO98+vLnDh5tsJM3FhReDw2PAXJ4zj3m6OHDsw5c/cBPVS2L+dB7AOc7JkL44eC
	GepVce+ip/i7gfzKRmU6vYRw+x3N6xK44+G1WaRYmZlvyDk5yHiNDCoypNSyGvp+SytpM5
	u6yw8EOTLaI3fxNyIAl+pZgZRuG/IUc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-bDf_EyuzPDyqeFR684o9vw-1; Mon, 02 Feb 2026 22:48:54 -0500
X-MC-Unique: bDf_EyuzPDyqeFR684o9vw-1
X-Mimecast-MFC-AGG-ID: bDf_EyuzPDyqeFR684o9vw_1770090533
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-352e214cce9so3848926a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 19:48:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770090532; cv=none;
        d=google.com; s=arc-20240605;
        b=OLTmgYsvEynAlGx8s0uTwjCiEq6d1tQRx5DbCf/NaFMNYXnKkYB8+2544Z7/B8qj3q
         dibmQ+M9k74SRdO+vFh6RcaUX6jBVqZBhCFW9VY+aTxqWoxiebUS6qPXMRkSZwBcichN
         05H3EHkRTqbB1RkXyF9NBgZlAgjk3FU6EUhVw5P/ccGRVNWSfFHcmmHoHSRUM8/VIEV3
         psvQe9EUGxhgPM1ILaY/pZ83Z/HuwHzusMh3aDXG4hSFnq4HD+VMnsUFtOE6qJwnVnNT
         ENHUa2zF+TPDstUmMJzrZ1UX7ZA+6pdUFwcPvk1FeKkHhN7Y+rV/Z/mAOlRsGOAjeFIX
         7m1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w9Ma1r17hH/la3W1p6fFaX3L2SwJmH0RiR5aM5Sicfk=;
        fh=LS50p3wAWKibUdXQxnWfEFtAdiD1FshINBd/JPL/MHw=;
        b=S9FA0ZuR9qdvSBEja+Hxtk7q8PRTqkjXXbLEHMl00K5JcSboq5mvg7jSi0hfI5z46p
         DW9wcERaVA8aESjRveginaCluEfaoQhjCiwYcd3HYpFHg8IS0Q4QB92Tjqrq4bNNN4IK
         vwO6WuX1j7g/AH5+4LhqPM8cDinUoa9A70U2gLYLGjY1/LqATjwLTFJImPxPF//RocAC
         pYLkf+K5QvuoWcXhHrHtizjI6gxSUDvDbzs50WJEDSuGf37fwQXeN4+/n20efSd2oi7O
         Hl7K5w5cvXTw18mVMEDMiCrVKb4OHjx4pzW7Z1u6t/MbtUAjXNSwK6Wz41IrvEG7GxVL
         zFgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770090532; x=1770695332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9Ma1r17hH/la3W1p6fFaX3L2SwJmH0RiR5aM5Sicfk=;
        b=nbRfdM0bgyzURPyIOdE9md+pBNhdCBqJNFHPB8bYkX1cLT4UyWTcEVRB55Li70aO+Y
         SUas7+/x7U11NN0GRtGp+OJZLXbd5SDvwf82Vyxf7v2gD6irYROxLN5VpUBeb9/oZgv2
         GotSYxpNDOYm/A/OuZcg94CGcVi2qWVHBu+kncJdfDs+Srtud0a56d4o4uHHQzmpq5Lu
         KNQ3vuuW1bbbawELSvZGR09hkip3y90S+UXJodpxkSHFTDh6fayVJDxW8VGd7O8m9EJv
         CbdXb2TGFcHk1UjLG81Pj1LHmbHQYtDd5knWFSHRzN9qkEgkeOO57oBSgEL86B/FDKH1
         YshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770090532; x=1770695332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w9Ma1r17hH/la3W1p6fFaX3L2SwJmH0RiR5aM5Sicfk=;
        b=hsxwnazH+670viCndb7+Qs2IL4X4qridpfXDlpxy3qz+4NFpbNipdX0gHeVRAljDjx
         LjV77x7oa24DmpkdJ7JNjpl2edmuNsTTxI/TXcy8XP3qMCFQXspCORz6twgkbd2aOazR
         MtwOTOae6fp3ErlHHIOUKTxRhqzViI7MsreVf1xI4uMCPFxR5tZxnGXcIV+AyocRLGc7
         JOBpEwGUy89nD1gh/E2hmN4NeXiWbdcBKQiyhpBDih8QuzDV0ZxZd7ypf/Agnql0Deye
         N6m8F/HJHWnUX+WkdxwPDIxRdCUB3EAVHTeDUQoP6MmK0lA3bznK1U2lWRLPW9ThSU9J
         Ew9w==
X-Forwarded-Encrypted: i=1; AJvYcCURFE3TavsKsx0bB9R+PfkEMR8qwrG+VUzSHBMb7AYf/nQpe+vTNTynpnyYZimGeJUaePGdoHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvJeiVr21WpDDUyjbH9sZUGjeR7w381pyOW4n5VlpnJ9dhRyJ
	6r7Ljz3IU9vtyAWiFCwIks+xJR0T6V55R9l9/IQYYwiOY08BplYNaL6H1H8CH0splkmdTQtQAIE
	+rSP1eEtlPc8AZvvyigDjs1JEq/4PEkAz4msgLnSDb6Ltan15Nxg15mrCEUXiSPVwx9f8TsmYvd
	1OwHE8uQosM8QqL1blhtAlyviQdrwR0T/W
X-Gm-Gg: AZuq6aLr0pyS0GaEuiJ1xVbNqnamW1zSVx9oJYljrX9M2BmpM26ll4S44NROji5wWUt
	xhvy11VpdjY4bpeV1quf59AYH6S6WsA/Po/6OhUNSz5JarPuDkrxw4wNj3CHWOr5ugQo0Tcf5mq
	aUZ15Mz53RRxqeSuUDA15NgvWLHPLGlNskaFuPlHjv9dt4kUmyKBw6LFDH8vpyL8ccY3U=
X-Received: by 2002:a17:90b:2542:b0:34c:2db6:57a7 with SMTP id 98e67ed59e1d1-3543b2f7db5mr10729552a91.8.1770090532506;
        Mon, 02 Feb 2026 19:48:52 -0800 (PST)
X-Received: by 2002:a17:90b:2542:b0:34c:2db6:57a7 with SMTP id
 98e67ed59e1d1-3543b2f7db5mr10729530a91.8.1770090531977; Mon, 02 Feb 2026
 19:48:51 -0800 (PST)
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
 <CACGkMEv71kn91FPAUrxJg=YB3+B0MRTgOidMPHjK7Qq0WEhGtw@mail.gmail.com>
 <260f48cd-caa1-4684-a235-8e1192722b3a@tu-dortmund.de> <CACGkMEsVMz+vS3KxykYBGXvyt3MZcstnYWUiYJZhLSMoHC5Smw@mail.gmail.com>
 <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de> <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
 <0ebc00ba-35e7-4570-a44f-b0ae634f2316@tu-dortmund.de>
In-Reply-To: <0ebc00ba-35e7-4570-a44f-b0ae634f2316@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Feb 2026 11:48:40 +0800
X-Gm-Features: AZwV_QgBhOcRjgv5wyECAL_F6v-Now5vyuFfLWGnwHp0pRicaJytEMlvsNIh2zU
Message-ID: <CACGkMEsJtE3RehWQ8BaDL2HdFPK=iW+ZaEAN1TekAMWwor5tjQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-256110-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pktgen_sample02_multiqueue.sh:url,mail.gmail.com:mid,0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pktgen_sample03_burst_single_flow.sh:url,tu-dortmund.de:email]
X-Rspamd-Queue-Id: 58980D4365
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 4:19=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/30/26 02:51, Jason Wang wrote:
> > On Thu, Jan 29, 2026 at 5:25=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 1/29/26 02:14, Jason Wang wrote:
> >>> On Wed, Jan 28, 2026 at 3:54=E2=80=AFPM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 1/28/26 08:03, Jason Wang wrote:
> >>>>> On Wed, Jan 28, 2026 at 12:48=E2=80=AFAM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> On 1/23/26 10:54, Simon Schippers wrote:
> >>>>>>> On 1/23/26 04:05, Jason Wang wrote:
> >>>>>>>> On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowang@red=
hat.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> >>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 1/9/26 07:02, Jason Wang wrote:
> >>>>>>>>>>> On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> >>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 1/8/26 04:38, Jason Wang wrote:
> >>>>>>>>>>>>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>>>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr=
_ring_consume()
> >>>>>>>>>>>>>> and wake the corresponding netdev subqueue when consuming =
an entry frees
> >>>>>>>>>>>>>> space in the underlying ptr_ring.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Stopping of the netdev queue when the ptr_ring is full wil=
l be introduced
> >>>>>>>>>>>>>> in an upcoming commit.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>>>>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmun=
d.de>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>>>>>>>>>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>>>>>>>>>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>>>>>>>>>> index 1197f245e873..2442cf7ac385 100644
> >>>>>>>>>>>>>> --- a/drivers/net/tap.c
> >>>>>>>>>>>>>> +++ b/drivers/net/tap.c
> >>>>>>>>>>>>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct ta=
p_queue *q,
> >>>>>>>>>>>>>>         return ret ? ret : total;
> >>>>>>>>>>>>>>  }
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_spa=
ce(ring, 1))) {
> >>>>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>>>> +               dev =3D rcu_dereference(q->tap)->dev;
> >>>>>>>>>>>>>> +               netif_wake_subqueue(dev, q->queue_index);
> >>>>>>>>>>>>>> +               rcu_read_unlock();
> >>>>>>>>>>>>>> +       }
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +       spin_unlock(&ring->consumer_lock);
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +       return ptr;
> >>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>>>>>>>>>                            struct iov_iter *to,
> >>>>>>>>>>>>>>                            int noblock, struct sk_buff *sk=
b)
> >>>>>>>>>>>>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_=
queue *q,
> >>>>>>>>>>>>>>                                         TASK_INTERRUPTIBLE=
);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>                 /* Read frames from the queue */
> >>>>>>>>>>>>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>>>>>>>>>>>> +               skb =3D tap_ring_consume(q);
> >>>>>>>>>>>>>>                 if (skb)
> >>>>>>>>>>>>>>                         break;
> >>>>>>>>>>>>>>                 if (noblock) {
> >>>>>>>>>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>>>>>>>>>> index 8192740357a0..7148f9a844a4 100644
> >>>>>>>>>>>>>> --- a/drivers/net/tun.c
> >>>>>>>>>>>>>> +++ b/drivers/net/tun.c
> >>>>>>>>>>>>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct=
 tun_struct *tun,
> >>>>>>>>>>>>>>         return total;
> >>>>>>>>>>>>>>  }
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_spa=
ce(ring, 1))) {
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I guess it's the "bug" I mentioned in the previous patch th=
at leads to
> >>>>>>>>>>>>> the check of __ptr_ring_consume_created_space() here. If it=
's true,
> >>>>>>>>>>>>> another call to tweak the current API.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>>>> +               dev =3D rcu_dereference(tfile->tun)->dev;
> >>>>>>>>>>>>>> +               netif_wake_subqueue(dev, tfile->queue_inde=
x);
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> This would cause the producer TX_SOFTIRQ to run on the same=
 cpu which
> >>>>>>>>>>>>> I'm not sure is what we want.
> >>>>>>>>>>>>
> >>>>>>>>>>>> What else would you suggest calling to wake the queue?
> >>>>>>>>>>>
> >>>>>>>>>>> I don't have a good method in my mind, just want to point out=
 its implications.
> >>>>>>>>>>
> >>>>>>>>>> I have to admit I'm a bit stuck at this point, particularly wi=
th this
> >>>>>>>>>> aspect.
> >>>>>>>>>>
> >>>>>>>>>> What is the correct way to pass the producer CPU ID to the con=
sumer?
> >>>>>>>>>> Would it make sense to store smp_processor_id() in the tfile i=
nside
> >>>>>>>>>> tun_net_xmit(), or should it instead be stored in the skb (sim=
ilar to the
> >>>>>>>>>> XDP bit)? In the latter case, my concern is that this informat=
ion may
> >>>>>>>>>> already be significantly outdated by the time it is used.
> >>>>>>>>>>
> >>>>>>>>>> Based on that, my idea would be for the consumer to wake the p=
roducer by
> >>>>>>>>>> invoking a new function (e.g., tun_wake_queue()) on the produc=
er CPU via
> >>>>>>>>>> smp_call_function_single().
> >>>>>>>>>> Is this a reasonable approach?
> >>>>>>>>>
> >>>>>>>>> I'm not sure but it would introduce costs like IPI.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> More generally, would triggering TX_SOFTIRQ on the consumer CP=
U be
> >>>>>>>>>> considered a deal-breaker for the patch set?
> >>>>>>>>>
> >>>>>>>>> It depends on whether or not it has effects on the performance.
> >>>>>>>>> Especially when vhost is pinned.
> >>>>>>>>
> >>>>>>>> I meant we can benchmark to see the impact. For example, pin vho=
st to
> >>>>>>>> a specific CPU and the try to see the impact of the TX_SOFTIRQ.
> >>>>>>>>
> >>>>>>>> Thanks
> >>>>>>>>
> >>>>>>>
> >>>>>>> I ran benchmarks with vhost pinned to CPU 0 using taskset -p -c 0=
 ...
> >>>>>>> for both the stock and patched versions. The benchmarks were run =
with
> >>>>>>> the full patch series applied, since testing only patches 1-3 wou=
ld not
> >>>>>>> be meaningful - the queue is never stopped in that case, so no
> >>>>>>> TX_SOFTIRQ is triggered.
> >>>>>>>
> >>>>>>> Compared to the non-pinned CPU benchmarks in the cover letter,
> >>>>>>> performance is lower for pktgen with a single thread but higher w=
ith
> >>>>>>> four threads. The results show no regression for the patched vers=
ion,
> >>>>>>> with even slight performance improvements observed:
> >>>>>>>
> >>>>>>> +-------------------------+-----------+----------------+
> >>>>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>>>> | 100M packets            |           |                |
> >>>>>>> | vhost pinned to core 0  |           |                |
> >>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>> | TAP       | Transmitted | 452 Kpps  | 454 Kpps       |
> >>>>>>> |  +        +-------------+-----------+----------------+
> >>>>>>> | vhost-net | Lost        | 1154 Kpps | 0              |
> >>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>
> >>>>>>> +-------------------------+-----------+----------------+
> >>>>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>>>> | 100M packets            |           |                |
> >>>>>>> | vhost pinned to core 0  |           |                |
> >>>>>>> | *4 threads*             |           |                |
> >>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>> | TAP       | Transmitted | 71 Kpps   | 79 Kpps        |
> >>>>>>> |  +        +-------------+-----------+----------------+
> >>>>>>> | vhost-net | Lost        | 1527 Kpps | 0              |
> >>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>
> >>>>> The PPS seems to be low. I'd suggest using testpmd (rxonly) mode in
> >>>>> the guest or an xdp program that did XDP_DROP in the guest.
> >>>>
> >>>> I forgot to mention that these PPS values are per thread.
> >>>> So overall we have 71 Kpps * 4 =3D 284 Kpps and 79 Kpps * 4 =3D 326 =
Kpps,
> >>>> respectively. For packet loss, that comes out to 1154 Kpps * 4 =3D
> >>>> 4616 Kpps and 0, respectively.
> >>>>
> >>>> Sorry about that!
> >>>>
> >>>> The pktgen benchmarks with a single thread look fine, right?
> >>>
> >>> Still looks very low. E.g I just have a run of pktgen (using
> >>> pktgen_sample03_burst_single_flow.sh) without a XDP_DROP in the guest=
,
> >>> I can get 1Mpps.
> >>
> >> Keep in mind that I am using an older CPU (i5-6300HQ). For the
> >> single-threaded tests I always used pktgen_sample01_simple.sh, and for
> >> the multi-threaded tests I always used pktgen_sample02_multiqueue.sh.
> >>
> >> Using pktgen_sample03_burst_single_flow.sh as you did fails for me (ev=
en
> >> though the same parameters work fine for sample01 and sample02):
> >>
> >> samples/pktgen/pktgen_sample03_burst_single_flow.sh -i tap0 -m
> >> 52:54:00:12:34:56 -d 10.0.0.2 -n 100000000
> >> /samples/pktgen/functions.sh: line 79: echo: write error: Operation no=
t
> >> supported
> >> ERROR: Write error(1) occurred
> >> cmd: "burst 32 > /proc/net/pktgen/tap0@0"
> >>
> >> ...and I do not know what I am doing wrong, even after looking at
> >> Documentation/networking/pktgen.rst. Every burst size except 1 fails.
> >> Any clues?
> >
> > Please use -b 0, and I'm Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz.
>
> I tried using "-b 0", and while it worked, there was no noticeable
> performance improvement.
>
> >
> > Another thing I can think of is to disable
> >
> > 1) mitigations in both guest and host
> > 2) any kernel debug features in both host and guest
>
> I also rebuilt the kernel with everything disabled under
> "Kernel hacking", but that didn=E2=80=99t make any difference either.
>
> Because of this, I ran "pktgen_sample01_simple.sh" and
> "pktgen_sample02_multiqueue.sh" on my AMD Ryzen 5 5600X system. The
> results were about 374 Kpps with TAP and 1192 Kpps with TAP+vhost_net,
> with very similar performance between the stock and patched kernels.
>
> Personally, I think the low performance is to blame on the hardware.

Let's double confirm this by:

1) make sure pktgen is using 100% CPU
2) Perf doesn't show anything strange for pktgen thread

Thanks

>
> Thanks!
>
> >
> > Thanks
> >
> >>
> >> Thanks!
> >>
> >>>
> >>>>
> >>>> I'll still look into using an XDP program that does XDP_DROP in the
> >>>> guest.
> >>>>
> >>>> Thanks!
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>>>
> >>>>>>>
> >>>>>>> +------------------------+-------------+----------------+
> >>>>>>> | iperf3 TCP benchmarks  | Stock       | Patched with   |
> >>>>>>> | to Debian VM 120s      |             | fq_codel qdisc |
> >>>>>>> | vhost pinned to core 0 |             |                |
> >>>>>>> +------------------------+-------------+----------------+
> >>>>>>> | TAP                    | 22.0 Gbit/s | 22.0 Gbit/s    |
> >>>>>>> |  +                     |             |                |
> >>>>>>> | vhost-net              |             |                |
> >>>>>>> +------------------------+-------------+----------------+
> >>>>>>>
> >>>>>>> +---------------------------+-------------+----------------+
> >>>>>>> | iperf3 TCP benchmarks     | Stock       | Patched with   |
> >>>>>>> | to Debian VM 120s         |             | fq_codel qdisc |
> >>>>>>> | vhost pinned to core 0    |             |                |
> >>>>>>> | *4 iperf3 client threads* |             |                |
> >>>>>>> +---------------------------+-------------+----------------+
> >>>>>>> | TAP                       | 21.4 Gbit/s | 21.5 Gbit/s    |
> >>>>>>> |  +                        |             |                |
> >>>>>>> | vhost-net                 |             |                |
> >>>>>>> +---------------------------+-------------+----------------+
> >>>>>>
> >>>>>> What are your thoughts on this?
> >>>>>>
> >>>>>> Thanks!
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>
> >>>
> >>
> >
>


