Return-Path: <netdev+bounces-36569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D27B0914
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 17:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DF0C92819AD
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C87F4885C;
	Wed, 27 Sep 2023 15:43:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795B4884C
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 15:43:50 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A183F8;
	Wed, 27 Sep 2023 08:41:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72A161C0004;
	Wed, 27 Sep 2023 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695829242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NdBAHYlEMRazScx1K7OUaAItlYn6RWWuijpEXQAx/ZQ=;
	b=IHiLAVR63G54JpOVVygaSY0HTXhwFj3Yv81Hl+5as40iNALhOH7JNSDM/z8GzX9yq5i84L
	B7vgd2A/LzYHrUEFnJqkZowD0LUhbvVh4EgcVo+hapjE2Qb+KL52knth2ozuBmxZgJAjxm
	s0YXGKr84Vy+kZh02xwn/lk+6zIOKPRZCjIPEIMjnyobGYXnTQUdTNkVtJKy0fCWBft/1U
	HXB/MhJERavdXR8dXlJB2cybdw8UndxFCMgytoItWeBysfpjnaSGc7Xx+HcWr6s4rjtqin
	eXDGKCOkIB38bj17e2+kEOo3BRuBPMhd5i1/x8O7cLP6K20KH4PaVbu5MEZRog==
Date: Wed, 27 Sep 2023 17:40:37 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, Romuald
 Despres <romuald.despres@qorvo.com>, Frederic Blain
 <frederic.blain@qorvo.com>, Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem
 Imberton <guilhem.imberton@qorvo.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v4 07/11] mac802154: Handle association
 requests from peers
Message-ID: <20230927174037.25708dec@xps-13>
In-Reply-To: <CAK-6q+j_vgK_5JQH0YZbqZq30J3eGccMdwB-AHKV6pQKJGmMwA@mail.gmail.com>
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
	<20230922155029.592018-8-miquel.raynal@bootlin.com>
	<CAK-6q+j_vgK_5JQH0YZbqZq30J3eGccMdwB-AHKV6pQKJGmMwA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexander,

aahringo@redhat.com wrote on Tue, 26 Sep 2023 21:37:23 -0400:

> Hi,
>=20
> On Fri, Sep 22, 2023 at 11:51=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Coordinators may have to handle association requests from peers which
> > want to join the PAN. The logic involves:
> > - Acknowledging the request (done by hardware)
> > - If requested, a random short address that is free on this PAN should
> >   be chosen for the device.
> > - Sending an association response with the short address allocated for
> >   the peer and expecting it to be ack'ed.
> >
> > If anything fails during this procedure, the peer is considered not
> > associated. =20
>=20
> I thought a coordinator can also reject requests for _any_ reason and
> it's very user specific whatever that reason is.

Absolutely.

> If we have such a case (that it is very user specific what to do
> exactly) this should be able to be controlled by the user space to
> have there a logic to tell the kernel to accept or reject the
> association.

Agreed (not implemented yet, though).

> However, I am fine with this solution, but I think we might want to
> change this behaviour in the future so that an application in the user
> space has the logic to tell the kernel to accept or reject an
> association. That would make sense?

Definitely, yes.

Thanks,
Miqu=C3=A8l

