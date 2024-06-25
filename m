Return-Path: <netdev+bounces-106689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A174B91749B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477251F2159C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 23:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03017F4F5;
	Tue, 25 Jun 2024 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7yLHlZf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4EF176AC2
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357234; cv=none; b=uS+6Od5teS/kwXnSHezQ6c+b/yHpscVjDl6bSQRmDInPsPazJ96+AweiVel716Gsr7y3ZH4ivgbjUwqKGTLsDTraQykmUvLXMGbzhO9jYY0wdqtovEX1Ncr0ifNxpargaCmc+My99u21P+ETZ85ijFT5Q4e14cxgPfVWsVPZLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357234; c=relaxed/simple;
	bh=T1T4+cJV7x4YSh2ZBI6h6B2wJ+UT911KOXHSnp/csEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XfXvOTWUQszt0mM7tWWj1FZCWmCLvEGMqfLeac3xSpyO31nZ9AIVh4DLvxApR7pWOcT7qBfaPEnpW93tklP5xWvr9J6TWDff/Ghdc3xR3fCuki2CsKULuabWE5NJcmnG9VVsmW3NpzEZ6e3ngvsc+I2A+Cp2LYD7lo0FHMwssuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7yLHlZf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36532d177a0so3956623f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 16:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719357231; x=1719962031; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhVYKjv6xyfhxZK6zSgKqeOGMluTTC9T/pU86A5GuIQ=;
        b=T7yLHlZf401/c1U4iAGdRXVENDaMfgoIbKQn0hX9jS6tk+b1GzjUhUNi+R/EyQgykZ
         qcBZaXlZR1/vSwV5gmYyLHtRb1EQfbdEvSXIP22BAjPqYeg0857abjmawd0WLsconGYF
         84Cc/jFPUrcpw6e+zAlmhjpwLuaRmV7/c/nD3QnkOjVXRMt45i2eZTtItzeyzW3Ak857
         6qMUL4mnDUlwFuOChCrbkbjBJ/wONgR8aWJiCImxqB4hL5q+Ra4/OuGtNMKmBCgb9Et4
         YH6678DLt153yVJQ1wxm+q20iWu6EiqASPlfrizKJYjZilPUTrNc2OV/kJqx3fv/fdyR
         VkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719357231; x=1719962031;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhVYKjv6xyfhxZK6zSgKqeOGMluTTC9T/pU86A5GuIQ=;
        b=BIhjWAmmq14T0Deo+CmydEDKHSj+jxiYUcmvPctO5LPIz1IVqyIc2I6V74adyO0+rO
         htDiuwRLqwXdDE/GILm7TotHa9Y/XoL6MQIKDq48z8pKEV1NOJt6ZJpgfSRyDK7x8Yoe
         x1M4cZG1C2eXYxUywGo1Oy1sPtme3dFRgvcJfLmagtydjRhtgj5qe0uPMbc9M4qE/g/o
         XG8x5e0ToDpYCrygJ+iMqnr94w2NIXntGAZfkBARcOhWHfDK9QjHfeTqhT+ZDWWXXsPZ
         5ZHvQcKJh7kdDMBYIVK5stW5cSKSZrHUSML4jVyn5YDGKnux0dTj5k+EaPgaq2Mb68st
         UvuA==
X-Forwarded-Encrypted: i=1; AJvYcCVcDnKv0JnApU0f/8+ypTrUt/L8pl0ecNXsYT97ekt/en0uh+a252HtS7t5Lcycb0KN829ZYjs//c2ybkpT5M7/P0oEA3JN
X-Gm-Message-State: AOJu0YzRUI4GXyE6hfwrB4b7AYNOMFfjB4bXHr2YfNFjtMXU+Bi3p4UR
	mzNU9+eC/6PJuIUWoTknjlbAUA0ouw2CefPM3E7sr3XWz4CJ95FwYfI5qbmvdTl7GRaMQ9T1Fuk
	DxYxOC/2bmFXFlAJ35XpzGNbiaR0=
X-Google-Smtp-Source: AGHT+IEVN8FT3xTNIbT2HrQCYiHYJESzgfp58n1V4xoYgX9jQvh+TRnMiF6nVtGwimv4pNcZ7UjECmFtF2UT1G94dBg=
X-Received: by 2002:adf:f512:0:b0:362:3526:4ebb with SMTP id
 ffacd0b85a97d-366e4ede448mr6625916f8f.37.1719357230725; Tue, 25 Jun 2024
 16:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
 <171932616332.3072535.5928220031237925415.stgit@ahduyck-xeon-server.home.arpa>
 <Zns0Kjv02mjC-6oU@LQ3V64L9R2>
In-Reply-To: <Zns0Kjv02mjC-6oU@LQ3V64L9R2>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 25 Jun 2024 16:13:14 -0700
Message-ID: <CAKgT0UdtF9=Tm29UVZcGMsNFzwcDuohchec-DFjTVptsjmbGbQ@mail.gmail.com>
Subject: Re: [net-next PATCH v2 07/15] eth: fbnic: Allocate a netdevice and
 napi vectors with queues
To: Joe Damato <jdamato@fastly.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 2:18=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Tue, Jun 25, 2024 at 07:36:03AM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
>
> [...]
>
> > +int fbnic_alloc_napi_vectors(struct fbnic_net *fbn)
> > +{
> > +     unsigned int txq_idx =3D 0, rxq_idx =3D 0, v_idx =3D FBNIC_NON_NA=
PI_VECTORS;
> > +     unsigned int num_tx =3D fbn->num_tx_queues;
> > +     unsigned int num_rx =3D fbn->num_rx_queues;
> > +     unsigned int num_napi =3D fbn->num_napi;
> > +     struct fbnic_dev *fbd =3D fbn->fbd;
> > +     int err;
> > +
> > +     /* Allocate 1 Tx queue per napi vector */
> > +     if (num_napi < FBNIC_MAX_TXQS && num_napi =3D=3D num_tx + num_rx)=
 {
> > +             while (num_tx) {
> > +                     err =3D fbnic_alloc_napi_vector(fbd, fbn,
> > +                                                   num_napi, v_idx,
> > +                                                   1, txq_idx, 0, 0);
> > +                     if (err)
> > +                             goto free_vectors;
> > +
> > +                     /* Update counts and index */
> > +                     num_tx--;
> > +                     txq_idx++;
> > +
> > +                     v_idx++;
> > +             }
> > +     }
> > +
> > +     /* Allocate Tx/Rx queue pairs per vector, or allocate remaining R=
x */
> > +     while (num_rx | num_tx) {
> > +             int tqpv =3D DIV_ROUND_UP(num_tx, num_napi - txq_idx);
> > +             int rqpv =3D DIV_ROUND_UP(num_rx, num_napi - rxq_idx);
> > +
> > +             err =3D fbnic_alloc_napi_vector(fbd, fbn, num_napi, v_idx=
,
> > +                                           tqpv, txq_idx, rqpv, rxq_id=
x);
>
> Mostly a nit / suggestion (and not a reason to hold this back): In
> the future, adding support for netif_queue_set_napi would be great,
> as would netif_napi_set_irq.
>
> Apologies if you've already added that in a future patch that I
> missed.

I haven't added that as we weren't doing much with busy polling so it
was overlooked. I should be able to add that for the v3 of the patch
set.

Thanks for calling that out.

- Alex

