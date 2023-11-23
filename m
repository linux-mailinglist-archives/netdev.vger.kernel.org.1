Return-Path: <netdev+bounces-50554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C77F6178
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C04281306
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A925778;
	Thu, 23 Nov 2023 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtjOtDeV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CFC19E
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700749744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGj+eyDaiuIrKyXlLkOwJ4t9L95zBfuirgvuRXre1So=;
	b=GtjOtDeV3lhRev45wDCs1UeB7y4GvivxgoiG1EzpNNri8yWp7OHunoLFP7mT65XGL817TB
	+hP11XAzhEZqEgfzlCva8eeIQa9LeN9qQ8b+Vn1j5jqR6skeMmcm5w/bY2WVLSx7hqenzy
	0bf7W2jT0n31f4sdngPr4vs86WTkEBE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-WpBQVl68OK-cLPDicvzkrg-1; Thu, 23 Nov 2023 09:29:03 -0500
X-MC-Unique: WpBQVl68OK-cLPDicvzkrg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-548dfaaaee8so638085a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700749742; x=1701354542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vGj+eyDaiuIrKyXlLkOwJ4t9L95zBfuirgvuRXre1So=;
        b=YeGS4grWaIascOGkjGAYMdxpnQXnWaAIQn1eFqX19ALundIirwiayNprBRPoI1iVWs
         Gj0aSQoIB0iY+YE34JKC5AHC7adgzGkwgPSEBypHxm4CVrpsHfLNuMVKZ6XU77IuksEb
         QlswsWyRadU3gniBE08FGXf4KD6dr/9napVbss4c0iY2nYjTsNg0cZ7dxfRIHgmONSaX
         wQuL5/UUTHHW/kYj4FyneVT4nQ26LPceMWH5uB9xCrNWAFBpbSjTQymoFC1hCWVHo6f7
         FHAzaas7uq37kIdUl4J/TPQ6Tx3yrDOTETjHWnyJIEdZxghOztSZgEtDrHjq8POU3EIE
         cZbg==
X-Gm-Message-State: AOJu0Yz4M08FG/GMTXSMpODzjqc4yvIZkGw1J9RQ6KPjY6PUfJmgN9jr
	ddPosspGjULHLrSbiBfnLQs3d0+XpcMgbVpKrxlRTIvNsTmzWd/6eBUREuzDvUdk4UgF8pTe4Ms
	KS7u9fstIOCwijKFfvBZDetl1fwelpnkS
X-Received: by 2002:a05:6402:33a:b0:542:db91:9531 with SMTP id q26-20020a056402033a00b00542db919531mr4030652edw.27.1700749742197;
        Thu, 23 Nov 2023 06:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGageAynn5b/AyqnAZeecltSL2Q5G+5liUbEztSM0itGJ7/tnGu2iLH0mDA3v17dHV0PI+3w8XdewgbkV7DxR4=
X-Received: by 2002:a05:6402:33a:b0:542:db91:9531 with SMTP id
 q26-20020a056402033a00b00542db919531mr4030638edw.27.1700749741874; Thu, 23
 Nov 2023 06:29:01 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Nov 2023 06:29:00 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20231110214618.1883611-1-victor@mojatatu.com> <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho> <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
Date: Thu, 23 Nov 2023 06:29:00 -0800
Message-ID: <CALnP8ZZkee5kKAFeNhQdVFxJgcs1DREEmtEk9pN8isGOuh0s-w@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, vladbu@nvidia.com, paulb@nvidia.com, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 08:37:13AM -0500, Jamal Hadi Salim wrote:
> On Thu, Nov 23, 2023 at 3:51=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >
> > Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
> > >This action takes advantage of the presence of tc block ports set in t=
he
> > >datapath and multicasts a packet to ports on a block. By default, it w=
ill
> > >broadcast the packet to a block, that is send to all members of the bl=
ock except
> > >the port in which the packet arrived on. However, the user may specify
> > >the option "tx_type all", which will send the packet to all members of=
 the
> > >block indiscriminately.
> > >
> > >Example usage:
> > >    $ tc qdisc add dev ens7 ingress_block 22
> > >    $ tc qdisc add dev ens8 ingress_block 22
> > >
> > >Now we can add a filter to broadcast packets to ports on ingress block=
 id 22:
> > >$ tc filter add block 22 protocol ip pref 25 \
> > >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> >
> > Name the arg "block" so it is consistent with "filter add block". Make
> > sure this is aligned netlink-wise as well.
> >
> >
> > >
> > >Or if we wish to send to all ports in the block:
> > >$ tc filter add block 22 protocol ip pref 25 \
> > >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all
> >
> > I read the discussion the the previous version again. I suggested this
> > to be part of mirred. Why exactly that was not addressed?
> >
>
> I am the one who pushed back (in that discussion). Actions should be

Me too, and actually I thought Jiri had agreed to it with some
remarks to be addressed (which I don't know if there were, I didn't
read this version yet).

> small and specific. Like i had said in that earlier discussion it was
> a mistake to make mirred do both mirror and redirect - they should
> have been two actions. So i feel like adding a block to mirred is
> adding more knobs. We are also going to add dev->group as a way to
> select what devices to mirror to. Should that be in mirred as well?
>
> cheers,
> jamal
>
> > Instead of:
> > $ tc filter add block 22 protocol ip pref 25 \
> >   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> > You'd have:
> > $ tc filter add block 22 protocol ip pref 25 \
> >   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
> >
> > I don't see why we need special action for this.
> >
> > Regarding "tx_type all":
> > Do you expect to have another "tx_type"? Seems to me a bit odd. Why not
> > to have this as "no_src_skip" or some other similar arg, without value
> > acting as a bool (flag) on netlink level.
> >
> >
>


