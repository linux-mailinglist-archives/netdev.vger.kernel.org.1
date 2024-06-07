Return-Path: <netdev+bounces-101667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C78FFC6E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA8CB2225C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981F14F129;
	Fri,  7 Jun 2024 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOVZwLMT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1927F5336A
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742884; cv=none; b=tC/rJ1VBPqqjhZrcb+/Q9QGXvYTmODdOXT3Y4UgrHLWPfc2/ZqCryg0ekCyW84iYLnsyfRtv+g1ib+4U5VD7bqrzRR3jPEFOQWcARFqjrMkiBBy3jM3kWIXhI5tZrXizVZmsibBgVnqwuNAleYQF4SwY6hoiL1oOfqUAMDTB67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742884; c=relaxed/simple;
	bh=IBqgcjtfkPxQ+RYhOLR7CfizykAPSvXKAo4SQJuuNKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc8kQen60ZujRcuSay7K4YJTFOO73+J4pKeZfaFTrJaW5vBbJ/WyJX3ZQcm3zKelhOMtzC62i88sbAjsFujCnWpf/zZQ+tJg/3cqY8lDwKExMEtKlCRiJWsnN9VSPUVurWLXZa19KHpX96QtUuKlkUIaTIKmVL6r61RQY/yVeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOVZwLMT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717742881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J03Kp2Piu0WaqvcpbAKDUqC79Y14t4Zaki70ezbKPXM=;
	b=BOVZwLMTA+dQ/bxnBw5LMdp0R1/QiDcCodDGJCLFRvlomZGB2dkHFaAitsM13CK6z9cHnq
	9pHBqvVTLZuu7byZEl4SxdaDtMLpk+pNSVZNphPmDGD/v/iyvnwKyFCy0YSHIF/yFXcpQe
	OlETuOyWb9vj2zf+xoDQDdz2n9U2BJk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-QklLORSjOderXfkYPjgZbA-1; Fri, 07 Jun 2024 02:47:59 -0400
X-MC-Unique: QklLORSjOderXfkYPjgZbA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c1ed594aa7so1632546a91.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 23:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742876; x=1718347676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J03Kp2Piu0WaqvcpbAKDUqC79Y14t4Zaki70ezbKPXM=;
        b=GawuVi6C70sGfRxhtZaHWS7L04+e8it/2/s8tVWfXkEePCasEbLYbxMYqWbd4vvlBg
         hTl0RIiEmj4YbwFYKnztZstYyabRpkt+JrlYq66ThTYWPAdqzHI18stmaID792ouBG7y
         Z/zJzuVE9S0RbTmLzNP4/1yxl+albtTv+DF0rhJSBbhGG/td4rgfBwb+nF6355a/Y21N
         QiFnrhks6MESKBfOaPH943TlhlDV45hRYnuxzoAEA9K+QBnE/fOnPmM0GHHMOYyDCySj
         MfQyl0EXBmy3nZhxk0rQLvbqGcuDIjI/jvi2+39l2GiSI9EIAK6/enc96Lu8WOpssDEC
         3WBA==
X-Forwarded-Encrypted: i=1; AJvYcCXuUSLZBJWI24mh2VHm9pJUH4HMcglmiWz3zBc8TC1H6C2bRCQy6us8AJzxLL+cr6tfcoF1yTrEO0ry1OTgD9EYmwTCW0sK
X-Gm-Message-State: AOJu0YwOy8MgzP43y4tMBDnzSy9kvZG1ak6jeoh89tvbREKm+RUvOO2j
	gVb+7pY+exMfnJju3OTkiCOBbmP4GrAeld04wE99nCvflH7oExacXNW/+gCh7iP/ej7/9/jPshR
	SXaoIVKKMkkybI4fLueSUL7Z6H0LDt4SGm8anqCoSonbCDr6Kukd2d9P8YIgz/+hPvffuC3mNs1
	XLO9//djeJBbY5vSRI59/hbnsFPXPM
X-Received: by 2002:a17:90a:ab88:b0:2bd:d42b:22dc with SMTP id 98e67ed59e1d1-2c2bcc5d648mr1680451a91.43.1717742876092;
        Thu, 06 Jun 2024 23:47:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYFmmfqHuA2Hv2pzK0DIRXS2in8abdxsG1OUe4Q27XZMjutmwqEaAflzBjQsZNBuB9U9eJ9WCxrytqvrPEzsM=
X-Received: by 2002:a17:90a:ab88:b0:2bd:d42b:22dc with SMTP id
 98e67ed59e1d1-2c2bcc5d648mr1680441a91.43.1717742875690; Thu, 06 Jun 2024
 23:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com> <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org> <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion> <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
In-Reply-To: <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jun 2024 14:47:43 +0800
Message-ID: <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 2:39=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Fri, Jun 07, 2024 at 08:25:19AM CEST, jasowang@redhat.com wrote:
> >On Thu, Jun 6, 2024 at 9:45=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
> >> >On Thu, Jun 6, 2024 at 2:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> >> >>
> >> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> >> >> > > If the codes of orphan mode don't have an impact when you enabl=
e
> >> >> > > napi_tx mode, please keep it if you can.
> >> >> >
> >> >> > For example, it complicates BQL implementation.
> >> >> >
> >> >> > Thanks
> >> >>
> >> >> I very much doubt sending interrupts to a VM can
> >> >> *on all benchmarks* compete with not sending interrupts.
> >> >
> >> >It should not differ too much from the physical NIC. We can have one
> >> >more round of benchmarks to see the difference.
> >> >
> >> >But if NAPI mode needs to win all of the benchmarks in order to get
> >> >rid of orphan, that would be very difficult. Considering various bugs
> >> >will be fixed by dropping skb_orphan(), it would be sufficient if mos=
t
> >> >of the benchmark doesn't show obvious differences.
> >> >
> >> >Looking at git history, there're commits that removes skb_orphan(), f=
or example:
> >> >
> >> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
> >> >Author: Eric Dumazet <edumazet@google.com>
> >> >Date:   Fri Sep 28 07:53:26 2012 +0000
> >> >
> >> >    mlx4: dont orphan skbs in mlx4_en_xmit()
> >> >
> >> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
> >> >    completions) we no longer need to orphan skbs in mlx4_en_xmit()
> >> >    since skb wont stay a long time in TX ring before their release.
> >> >
> >> >    Orphaning skbs in ndo_start_xmit() should be avoided as much as
> >> >    possible, since it breaks TCP Small Queue or other flow control
> >> >    mechanisms (per socket limits)
> >> >
> >> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
> >> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
> >> >    Signed-off-by: David S. Miller <davem@davemloft.net>
> >> >
> >> >>
> >> >> So yea, it's great if napi and hardware are advanced enough
> >> >> that the default can be changed, since this way virtio
> >> >> is closer to a regular nic and more or standard
> >> >> infrastructure can be used.
> >> >>
> >> >> But dropping it will go against *no breaking userspace* rule.
> >> >> Complicated? Tough.
> >> >
> >> >I don't know what kind of userspace is broken by this. Or why it is
> >> >not broken since the day we enable NAPI mode by default.
> >>
> >> There is a module option that explicitly allows user to set
> >> napi_tx=3Dfalse
> >> or
> >> napi_weight=3D0
> >>
> >> So if you remove this option or ignore it, both breaks the user
> >> expectation.
> >
> >We can keep them, but I wonder what's the expectation of the user
> >here? The only thing so far I can imagine is the performance
> >difference.
>
> True.
>
> >
> >> I personally would vote for this breakage. To carry ancient
> >> things like this one forever does not make sense to me.
> >
> >Exactly.
> >
> >> While at it,
> >> let's remove all virtio net module params. Thoughts?
> >
> >I tend to
> >
> >1) drop the orphan mode, but we can have some benchmarks first
>
> Any idea which? That would be really tricky to find the ones where
> orphan mode makes difference I assume.

True. Personally, I would like to just drop orphan mode. But I'm not
sure others are happy with this.

Thanks

>
>
> >2) keep the module parameters
>
> and ignore them, correct? Perhaps a warning would be good.
>
>
> >
> >Thanks
> >
> >>
> >>
> >>
> >> >
> >> >Thanks
> >> >
> >> >>
> >> >> --
> >> >> MST
> >> >>
> >> >
> >>
> >
>


