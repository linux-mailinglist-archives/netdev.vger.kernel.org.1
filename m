Return-Path: <netdev+bounces-135870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3199F776
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565651C2324E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B7E1B85DB;
	Tue, 15 Oct 2024 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chUQo1UN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FD1B6CF6;
	Tue, 15 Oct 2024 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021552; cv=none; b=SyCfUZ6E5Ny8pgdJNHLypgzI3sLiNC3JoiPdsOKxv/51vmCSnK44BulrCJB/mm/f34Dy6UBp95qCDLXohzORip3PzgSTzlxzI1ag453wHTomk1WbDZdA0iqWztru6IjZrDmcjTxADNqNGQlIhK72l9vQZJ1mwrZ+5i5/LQ65LHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021552; c=relaxed/simple;
	bh=AsXgrgElAqeyg/3ruB7Ekzfjodq40Q8l1Ja+T5NjlZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRFJ/fxfs3UFNwaItZ1kze6uhFWX3TH/iOPzehQcPe1droe6W+sYdQSOVlHm7H+2h9zdlBsiFfV1cSgcxSnvj6P9JyucsWpveCojnmr4Xqv3aHoH9DEQ27UgHEi1Kx+LXDolsb51H1VMZmvzKAH/J+p25A1Mx+9rwtcHALkUySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chUQo1UN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e3d97b8274so821677b3.1;
        Tue, 15 Oct 2024 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729021549; x=1729626349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rkt0JKUXF/S078vhZLSbZ5KsSqfzEMKVm++kKWs1278=;
        b=chUQo1UNe4t7JbolUhg3QTUipmCtcuMyb0CI7JAKxNMqngJdrN6tPJEp4B+ek3QVlI
         5RUzhlVUZbmpma0Ns7KQ55nuUkB/yX8f9yKgnur7wgftN4Uf2F97vsKbWfBVftzOa+JT
         wtXDJUay1nrDRAS1O2hyLIzt5QSYuhBWNacBWLv/GTPkghgaK6B9qzTcWHqbpKVrCr3d
         SH1NLoHQhQ/NPedgBn29cXoPuaZ7RyAhCBd9WF1zqHUSv2j24g1jHs7+AG1W4jO4XnL8
         maD2ei5PK6JPMDxfHFkx07XThMMBpDBG6AhxVbmRjKiGkO2Y7r1mvVtGIIGeJiUMBCuA
         DRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729021549; x=1729626349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rkt0JKUXF/S078vhZLSbZ5KsSqfzEMKVm++kKWs1278=;
        b=mBS9TdlsddP7AAu5gv7QxcmHe4xhHemo6gmU24YjchEwxDAap48htOS4yE7zIsH0tX
         eEcK96eHFv3kZZz9Kjdm+Gff7z/fAO0yYolnfaCleCUeSNMi+UC961Buwxy1Bbep6pq9
         aB7S59yOEHzlmxQ5hkPnrh7HuBF5cX1vMmwXZHp8vOP25PwvvdXyrFOGt9dpPMqMh5w9
         0wIA3mmf8piDKgbCh0BvuKGvDION8/Vy/nDvI6Ygadf3hoDPRP2oM8OFM/Z7LM68G9qO
         QurA99l3/h1sPGgmofKMRHixwFbLK0lHYqsORBw5UjT2PFcAKscj+JGPHJNTmzZ1y8WD
         c8+A==
X-Forwarded-Encrypted: i=1; AJvYcCXe7gz+xdHQoqnSMfDhqAVCn8jXw7H/yXk2NCxGIx/olywNqf26HZonWaCODmuZdOtsjHbwlmMPIzm2fKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkknojlrefFrrgSsPtegD6c6th4vSu4ZDpXBGcuVGLvCqMEEZS
	12TSNzE3iamTulOGw/X+hRp9iH/EIFgNe1FjmkiHOgwlfk23mfy3yj+VyEhFtbSDytAwYtHm++x
	m9hBcd82IlQQboKYXzXf4kmHicEU=
X-Google-Smtp-Source: AGHT+IH8oW0jckDR/xoIXDCdOaWcak+kHVJkRlwUYZBmK2NvyyPhsdMHprTdb4ZNJFobCa8nWbkqVoT0ZQXOJsxYqYU=
X-Received: by 2002:a05:690c:4391:b0:6e3:16da:e6e with SMTP id
 00721157ae682-6e3479c736fmr87337257b3.19.1729021549522; Tue, 15 Oct 2024
 12:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011195622.6349-1-rosenp@gmail.com> <20241011195622.6349-8-rosenp@gmail.com>
 <20241012132137.GF77519@kernel.org>
In-Reply-To: <20241012132137.GF77519@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 15 Oct 2024 12:45:38 -0700
Message-ID: <CAKxU2N8cm_ku876uKcZmJKsXESM25z+xe9r0HqFWiuHGCP0cFQ@mail.gmail.com>
Subject: Re: [PATCHv6 net-next 7/7] net: ibm: emac: use of_find_matching_node
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Shannon Nelson <shannon.nelson@amd.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Breno Leitao <leitao@debian.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 6:21=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Oct 11, 2024 at 12:56:22PM -0700, Rosen Penev wrote:
> > Cleaner than using of_find_all_nodes and then of_match_node.
> >
> > Also modified EMAC_BOOT_LIST_SIZE check to run before of_node_get to
> > avoid having to call of_node_put on failure.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/ibm/emac/core.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/etherne=
t/ibm/emac/core.c
> > index faa483790b29..5265616400c2 100644
> > --- a/drivers/net/ethernet/ibm/emac/core.c
> > +++ b/drivers/net/ethernet/ibm/emac/core.c
> > @@ -3253,21 +3253,17 @@ static void __init emac_make_bootlist(void)
> >       int cell_indices[EMAC_BOOT_LIST_SIZE];
> >
> >       /* Collect EMACs */
> > -     while((np =3D of_find_all_nodes(np)) !=3D NULL) {
> > +     while((np =3D of_find_matching_node(np, emac_match))) {
> >               u32 idx;
> >
> > -             if (of_match_node(emac_match, np) =3D=3D NULL)
> > -                     continue;
> >               if (of_property_read_bool(np, "unused"))
> >                       continue;
> >               if (of_property_read_u32(np, "cell-index", &idx))
> >                       continue;
> >               cell_indices[i] =3D idx;
> > -             emac_boot_list[i++] =3D of_node_get(np);
> > -             if (i >=3D EMAC_BOOT_LIST_SIZE) {
> > -                     of_node_put(np);
> > +             if (i >=3D EMAC_BOOT_LIST_SIZE)
> >                       break;
> > -             }
> > +             emac_boot_list[i++] =3D of_node_get(np);
>
> Reading the Kernel doc for of_find_matching_node() it seems
> that of_node_put() needs to called each time it (and thus
> of_find_matching_node() returns a np. But that doesn't seem
> to be the case here. Am I mistaken?
Bad change. Will remove.
>
>
> >       }
> >       max =3D i;
> >
> > --
> > 2.47.0
> >

