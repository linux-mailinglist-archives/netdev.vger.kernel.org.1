Return-Path: <netdev+bounces-131014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A2498C61D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882EF1C21530
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377DC1CCEFD;
	Tue,  1 Oct 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKYxH5iS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE91CC899;
	Tue,  1 Oct 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811315; cv=none; b=oukJDzP10Wk7yk9thuhCkS2kg4My91dd+DDjMhdy7i0BoL+TC368a8zXrUzTfy6AuB8RROza0MgGh9faBjlP8GrkZE//NgD6xiDP7JQ4tWzjYSWTc9V5otOzPL6QrDpiifxZB2L1ITbc67+9WRNN/1GgopiBqyTgk55Ohn06rP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811315; c=relaxed/simple;
	bh=isxFqTDK/suiZw4UKX4am7ZzD4G0kiLkDkhZ2s94FAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfAv+pxfA3Tg5l+VgPaI4Q+LZI8EkDnjCA+/Hur1v3jNyPnNpvxK1lYQFDD3tx7IO9ZrBILigFS4LBMtLOXIUxOrF8Z5BzquUPTheAW+wfUqbFi5t+9/sj7yE9SsPmtkcnGHfsHkvoTmGtsZNpCV0SM6051HJveNl0wptXAzA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKYxH5iS; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6dbc5db8a31so1316767b3.1;
        Tue, 01 Oct 2024 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727811312; x=1728416112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNu3zwj/tQfAay8inZMNecy0eRuttkRsxpO7cBb0KeI=;
        b=SKYxH5iSWgWls9QTQayiRjvoEH7JH5TEgzO9kEynsvyZF520oI2yN5WF2om04upW1H
         8RBAlBNgsfKkMj6/APiVmGyKafa1h6DShUiqHf8WPJSif9RDKcxhuwMWeW0/vkYMH09Z
         xJ4ixiLwAyrbOiBc371huPJ2LYgiDPuC2OLS0SwkhKUTaO4orUtO3Xs9ufmH30mdkqps
         a5x7mnfdhLe2Q8d0dTfpQKdPmFpNveVUSpYUMmsFeVQEaFeSSRj5J6jCnpadyQUR7HHl
         wraUn01q0z7pXP229XKzmYbxSAVVCLjxGT6lb/88gY7Bjd5lSgBgz1HKGSxSQ1+Y176W
         2nEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727811312; x=1728416112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNu3zwj/tQfAay8inZMNecy0eRuttkRsxpO7cBb0KeI=;
        b=H9q5+X8pnLWg5REKC+M6sxJjNKhejLQjCpCJiwkyEYWJcmuFJNg5FR4Zf/gqkqBOJ9
         9HAsIKtZimDCuftWmOeAGK8fcJ5XthUCjn5ee69+2Ex4SqLmVLk0E7lG9h/MtMmIWZoH
         jh2IdT22vFICOnSSbcqazkChVXZGC1+xEHyi6LXOvMbhfFOZJOcWtSEat0Pu7FZeL4MS
         S3z3rz1j94d29cmaj939uPudvZjFy/wdytJ/IdZEIwkOghxDz+nMDjVF5g2bqG2IXBtK
         MwTs3ZJKlO4A/vBM6rs5fMmOTe2+RHRacCOOvIx8TBz8k78XcVgX927srbkAHhTQZ6rq
         zzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnZi8Rom4tOy7ja5BFwYKMccrEhIcvKYjVKbbK4WQr3BPniZ+88YhWsdIWIAlafIK+2jtupLz6ft+PoiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhrIOxQFoPyu/Ncwm/RxaW93eUSAmq6bwMg83UsoKPbcWXkqK
	ocnzUDGMCq/GiONHoM2Okr+Sit+J3daD+buoVe4UXqxakg/4XwlA9PsExC47gTdUUzcdD6Ec5yU
	1I1YI2BefUxw+I6g1JxzuZ2n74wM=
X-Google-Smtp-Source: AGHT+IGR6iivk4Jp51v8pLV+/VeDYv4bj8K4Gtyhmiw+d46SZXGz6+UcrOwKcnWcvc0Sf9GbjI+2Sdpz5jWMWNvkV40=
X-Received: by 2002:a05:690c:2a93:b0:6db:e1e0:bf6a with SMTP id
 00721157ae682-6e2a3364408mr7798557b3.7.1727811312371; Tue, 01 Oct 2024
 12:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930180036.87598-1-rosenp@gmail.com> <20240930180036.87598-14-rosenp@gmail.com>
 <20241001133229.GR1310185@kernel.org>
In-Reply-To: <20241001133229.GR1310185@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 1 Oct 2024 12:35:01 -0700
Message-ID: <CAKxU2N-jBRZWN9b2QkHYqO3wnSAX7K_r=afOv-EaOEfyJ8wXoQ@mail.gmail.com>
Subject: Re: [PATCH net-next 13/13] net: ibm: emac: mal: use devm for request_irq
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, sd@queasysnail.net, 
	chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:32=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Mon, Sep 30, 2024 at 11:00:36AM -0700, Rosen Penev wrote:
> > Avoids manual frees. Also replaced irq_of_parse_and_map with
> > platform_get_irq since it's simpler and does the same thing.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/ibm/emac/mal.c | 47 ++++++++++++-----------------
> >  1 file changed, 19 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet=
/ibm/emac/mal.c
> > index 70019ced47ff..449f0abe6e9e 100644
> > --- a/drivers/net/ethernet/ibm/emac/mal.c
> > +++ b/drivers/net/ethernet/ibm/emac/mal.c
> > @@ -578,15 +578,15 @@ static int mal_probe(struct platform_device *ofde=
v)
> >  #endif
> >       }
> >
> > -     mal->txeob_irq =3D irq_of_parse_and_map(ofdev->dev.of_node, 0);
> > -     mal->rxeob_irq =3D irq_of_parse_and_map(ofdev->dev.of_node, 1);
> > -     mal->serr_irq =3D irq_of_parse_and_map(ofdev->dev.of_node, 2);
> > +     mal->txeob_irq =3D platform_get_irq(ofdev, 0);
> > +     mal->rxeob_irq =3D platform_get_irq(ofdev, 1);
> > +     mal->serr_irq =3D platform_get_irq(ofdev, 2);
> >
> >       if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
> >               mal->txde_irq =3D mal->rxde_irq =3D mal->serr_irq;
> >       } else {
> > -             mal->txde_irq =3D irq_of_parse_and_map(ofdev->dev.of_node=
, 3);
> > -             mal->rxde_irq =3D irq_of_parse_and_map(ofdev->dev.of_node=
, 4);
> > +             mal->txde_irq =3D platform_get_irq(ofdev, 3);
> > +             mal->rxde_irq =3D platform_get_irq(ofdev, 4);
> >       }
> >
> >       if (!mal->txeob_irq || !mal->rxeob_irq || !mal->serr_irq ||
>
> I think this error handing needs to be updated.
> platform_get_irq() returns either a non-zero IRQ number or
> a negative error value. It does not return zero.
I wonder if error handling here is needed. devm_request_irq will error
if something is wrong.
>
> Flagged by Smatch.
>
> ...

