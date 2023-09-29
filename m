Return-Path: <netdev+bounces-36949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9427B2973
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 02:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 01A2B28203F
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E348319C;
	Fri, 29 Sep 2023 00:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B0188
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:19:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177E2F3
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695946797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfVWLVBAfMWK9MpxlC2iz+amb1udFc1jlzh2Yg5zYa8=;
	b=dIbHyrGVKBK2b+405rirYYls/IoZkbsU8XpKO5kfSZTutLMTuoqnzWfstNoeGluRPRTBnR
	hgzh4ebpFN5QFVe5rfIFWAmnIU6a5bKAfpfIxmLBo2lZiV0k7Fa60MHPsgOiIidorC51yn
	bkIfZLxJ93CPTcjgYcjUw/rvEoz3ZRs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-6eACqF6uPUKvYa52mkEGSw-1; Thu, 28 Sep 2023 20:19:55 -0400
X-MC-Unique: 6eACqF6uPUKvYa52mkEGSw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a5d86705e4so1181498066b.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 17:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695946794; x=1696551594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfVWLVBAfMWK9MpxlC2iz+amb1udFc1jlzh2Yg5zYa8=;
        b=AoxlaDh0Q89p1V4MDB0ZGz1rdjAQJ7PqB70ZfescVn+8SmCrVLmn2DS6c63AFSeITE
         TZyV968P8JLr+f6YQg343Ww4Jp+onJv1d1BbfPVLCN8kcQFKxdGOu1s5K1debt9Kh6EZ
         9U0zqOa35Usp4tkYNjw54nDnltKfuNzV/T5YESwt/0wSclVch66ezAxS50A6m5+WbUf6
         2ZPEi44A91+a6XPDfLYarpwKBp7aICULMXnnqIWoSAK1BVzXbGxvFmQzhm/RQryS1YuX
         ivsfazR5fndoSxZbetXJLzJrX1Nra4PO/T1Rvz/5pHYrqew4c7SA+Dg9ZPFUETHTboTF
         G+3A==
X-Gm-Message-State: AOJu0Yw3++ytzle3wOG/IMcYiyUeU2smBIVmtr5uppfnXPTj8ScBdngF
	xuanwwK6xG8DrSA7hhhlw1/aoWvnX4ZLKnh2TZJ/WLs7e7aRWsVahwLhNj3RD6bF353XEATd0Kr
	CJx9dXV59jSTfdTCnrV77jpo0TCUzz+S/
X-Received: by 2002:a17:906:3019:b0:9ae:5db5:13d with SMTP id 25-20020a170906301900b009ae5db5013dmr2530179ejz.72.1695946794040;
        Thu, 28 Sep 2023 17:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBVdSF5Bg0XljEguOqIP7X4cy9GMK7y9bWjc4k0+15mUmzGbWDpl5XS2/sMXIom9F8+mqIaTFWXIM9I4/Y6Q0=
X-Received: by 2002:a17:906:3019:b0:9ae:5db5:13d with SMTP id
 25-20020a170906301900b009ae5db5013dmr2530159ejz.72.1695946793700; Thu, 28 Sep
 2023 17:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
 <20230922155029.592018-8-miquel.raynal@bootlin.com> <CAK-6q+j_vgK_5JQH0YZbqZq30J3eGccMdwB-AHKV6pQKJGmMwA@mail.gmail.com>
 <20230927174037.25708dec@xps-13>
In-Reply-To: <20230927174037.25708dec@xps-13>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 28 Sep 2023 20:19:42 -0400
Message-ID: <CAK-6q+gzgVuQViEC=uBXDtz8wqPBaf9Je5TywHB9n35L1ZqAzA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 07/11] mac802154: Handle association requests
 from peers
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, 
	Romuald Despres <romuald.despres@qorvo.com>, Frederic Blain <frederic.blain@qorvo.com>, 
	Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem Imberton <guilhem.imberton@qorvo.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Wed, Sep 27, 2023 at 11:40=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Tue, 26 Sep 2023 21:37:23 -0400:
>
> > Hi,
> >
> > On Fri, Sep 22, 2023 at 11:51=E2=80=AFAM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote:
> > >
> > > Coordinators may have to handle association requests from peers which
> > > want to join the PAN. The logic involves:
> > > - Acknowledging the request (done by hardware)
> > > - If requested, a random short address that is free on this PAN shoul=
d
> > >   be chosen for the device.
> > > - Sending an association response with the short address allocated fo=
r
> > >   the peer and expecting it to be ack'ed.
> > >
> > > If anything fails during this procedure, the peer is considered not
> > > associated.
> >
> > I thought a coordinator can also reject requests for _any_ reason and
> > it's very user specific whatever that reason is.
>
> Absolutely.
>
> > If we have such a case (that it is very user specific what to do
> > exactly) this should be able to be controlled by the user space to
> > have there a logic to tell the kernel to accept or reject the
> > association.
>
> Agreed (not implemented yet, though).
>
> > However, I am fine with this solution, but I think we might want to
> > change this behaviour in the future so that an application in the user
> > space has the logic to tell the kernel to accept or reject an
> > association. That would make sense?
>
> Definitely, yes.

ok, thanks to have some agreement here for the future.

- Alex


