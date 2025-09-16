Return-Path: <netdev+bounces-223642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70581B59CB5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0595C3A833E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00CF33A033;
	Tue, 16 Sep 2025 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OUIkSR5R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F732905
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038312; cv=none; b=l8GQtJCZoyJzt5L8MpS4knrzZmp6fZvTLci3iI3ePZacC6yAKAMU7Nts6MhC8/NsFbGkzC6J7ekD9sWxw/oFXW9cOBl4FskGyUNN4e8FYbS9eOxSoBXvsBhlpqkA+J0WjxWYOZHS6Q4zf30xxh9v8g4fq7TxFrciONhOfHf48Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038312; c=relaxed/simple;
	bh=H0y/vkv139mk6hzPEmPQy8Rch/B/T76IqTvvTBFUxRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8tuLCdSkXTsrQTb/EKKe2bUMv3+MMAQ4aYIZK//jHHz15DlC26x8Q59rG60AFH2kAmwLqLJFd3esOmakg8iZfpvSFebRKR8TIi2Z/onWwYBijkJRiWSzjaErPdv+cmP7UEiaaEs7mEG+49DKg34PUxqqRpnPucF6l2zEtnCEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OUIkSR5R; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-77b0a93e067so611054b3a.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038311; x=1758643111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtGOiuK3qgTLsstDDsX/aw+0/7HAvlc77Okr7vtGNEA=;
        b=h0QVXaugK/2UX3qEgUgc9m3AAK6YUoNekzNjyOce5xEndtTci03spNPogGKQ/c2kEn
         ErTiDaFr5dghKvcZdyaHuDzO9Fjj/H6ecQabpvH2yPigDdEHQPgA0+rGT83jKaVrQgH/
         pIof3x0Xz5uKiDW+swTYwc4hnk4jR1/5c4tEWbvFnniKzm8Ogxb+3H6PCmh6QMR0AUs/
         4Hl8Oz6IG1qgJAK1WHM41sbERjkmFAurpb+cIzG+2dQYZ0dNynrPPi82SzYu3dwsIXBP
         /TXabHVFKNAmTkZGvbNNuFvRiTq8fiaNrGPho1kg7L/sehBcbVCFw6tpuKUSheAxVSwo
         z4yg==
X-Forwarded-Encrypted: i=1; AJvYcCXidM5wKKnKyVHClpkhRZM10pPK35pxG2TfBmBw3a3ihtAU/4pLnFKr9qZtvkjPg3S4gRFlk1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZunuc5AYvlhKs+N/FWLRBY1CxytaP6dE9+ORpjN+9rjjvYtpz
	Ccdj25EKuRijWGgeOdGGxMtn05/Hs3IGaXhPGK9jSufIJJjcpwc/EEFEWtCnLPeIgPmz9WCN5o4
	R//mZuHjDNqrs8wBgJ7PAUGpc7dp5auERTpjLWkFKT4j/ri166THBkKuetxUc3w6/PQPqB2FSiY
	6RcowBM9LErIw95A7FipYsNetNhxvMGVPRGBEzBVaGUwn4gznn4m4m5m/O9WwL4Po6zKfNjkOie
	2KTzI7HicM=
X-Gm-Gg: ASbGnctEyU/a6/IEmqvVBGrltrSAp4ml6rsyohsyD7Uwcn5oCGWDbVoGbBRuHswuF1p
	DvNpvjbQ33Eei6820MSshzk/1uZjTjbKIbtxuKF2kXD8FU0LwT9nzwczzPttSAvJdv9N1V/+vAZ
	7SqsUI3jHf+iTEWnhfihHaqc+G3YO3SCH2vvgpVFYcpZlwTX/SA1GbJgX2nqi4yqbJ5pkVQsDjM
	T9hYSIjqCTjORVOc5NIcMT8cF850iFWwMt4pwxL5shoI19qmpH3+33qpDkJfIxaFiPaJ6+wEqfR
	y5HBdGS+arw3uj9e4iQNzkzzvBFXveSG6ky2Y1Y7JIA85jnbavgwbyvGApf3AwWb48huZXdEKOa
	TieTNFOiI50evysKYJBXdnceT9OdhPurhZNvN+vs0DyZFSsAKPb76SVIGtG7FTVN37nmw7xfOE+
	HqYg==
X-Google-Smtp-Source: AGHT+IGrZIC/XFpHlrSVEiA/ZckZjKHpuCf23TZO8Mrk2cWkpC6gA7dJYsxtRuyzyztSVEUKciLN5P50j5HF
X-Received: by 2002:a05:6a21:33a6:b0:246:3a6:3e41 with SMTP id adf61e73a8af0-2602a5937a8mr21657429637.6.1758038310660;
        Tue, 16 Sep 2025 08:58:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b54b44231d3sm890155a12.4.2025.09.16.08.58.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 08:58:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b04b06659d2so399921966b.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758038309; x=1758643109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtGOiuK3qgTLsstDDsX/aw+0/7HAvlc77Okr7vtGNEA=;
        b=OUIkSR5RAeemC1ry6CQnsAMwcNwYVJqSRKOt7H2pW5A5iimXrx7ZsRWQ7E/bpGLK7h
         mlIzt081Z1Thtb+0K+VZ+H0mWh4A3OYbXp6m+JY9yqSkbWgFH0dKXUI7h/QxcYXhDA/F
         wdhAFkWie0MHahSIEnWU9oThDUs+CUX/jK4qk=
X-Forwarded-Encrypted: i=1; AJvYcCUsW/DeyoKICnYkGZzJeBzr7inCnLoTK+QeTo/6p5H940dkSfRhRUbVRGwmqadsl5gYwzKIjAo=@vger.kernel.org
X-Received: by 2002:a17:907:3e20:b0:b04:848f:a0d4 with SMTP id a640c23a62f3a-b0e4636d0edmr972630466b.13.1758038308625;
        Tue, 16 Sep 2025 08:58:28 -0700 (PDT)
X-Received: by 2002:a17:907:3e20:b0:b04:848f:a0d4 with SMTP id
 a640c23a62f3a-b0e4636d0edmr972627866b.13.1758038308157; Tue, 16 Sep 2025
 08:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915030505.1803478-1-michael.chan@broadcom.com>
 <20250915030505.1803478-5-michael.chan@broadcom.com> <7effec89-1f94-4313-b68f-c653ee07a6b2@redhat.com>
In-Reply-To: <7effec89-1f94-4313-b68f-c653ee07a6b2@redhat.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 16 Sep 2025 08:58:16 -0700
X-Gm-Features: AS18NWBI-zTpBlBqwuP_vaj3IEWCgJTA_1eSMmXD_BzQd2lSUZ_VKVptGii9yd4
Message-ID: <CACKFLim09whYXguLVgvUA8oXot051zK5MnLbujDMkTZsQqRc0A@mail.gmail.com>
Subject: Re: [PATCH net-next 04/11] bnxt_en: Improve bnxt_hwrm_func_backing_store_cfg_v2()
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 16, 2025 at 4:19=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/15/25 5:04 AM, Michael Chan wrote:
> > Optimize the loop inside this function that sends the FW message
> > to configure backing store memory for each instance of a memory
> > type.  It uses 2 loop counters i and j, but both counters advance
> > at the same time so we can eliminate one of them.
>
> The above statement does not look correct.
>
> > @@ -9128,20 +9128,20 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(=
struct bnxt *bp,
> >       req->subtype_valid_cnt =3D ctxm->split_entry_cnt;
> >       for (i =3D 0, p =3D &req->split_entry_0; i < ctxm->split_entry_cn=
t; i++)
> >               p[i] =3D cpu_to_le32(ctxm->split[i]);
> > -     for (i =3D 0, j =3D 0; j < n && !rc; i++) {
> > +     for (i =3D 0; i < n && !rc; i++) {
> >               struct bnxt_ctx_pg_info *ctx_pg;
> >
> >               if (!(instance_bmap & (1 << i)))
> >                       continue;
> >               req->instance =3D cpu_to_le16(i);
> > -             ctx_pg =3D &ctxm->pg_info[j++];
> > +             ctx_pg =3D &ctxm->pg_info[i];
>
> `j` is incremented only for bit set in `instance_bmap`, AFAICS this does
> not introduces functional changes only if `instance_bmap` has all the
> bit set.
>
Yes, you are absolutely right.  The original code will skip over zeros
in the instance_bmap without incrementing j.  Let me rethink this
patch or drop this patch.  Thanks for the review.

