Return-Path: <netdev+bounces-182118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2EA87E34
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF929175AFD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317127E1B4;
	Mon, 14 Apr 2025 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P58rEOhG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD127E1AC;
	Mon, 14 Apr 2025 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628194; cv=none; b=Ck9+pAk+Chyo2G3/1O/lpYArtDczsm/z01Dv50HZvl1VtBTWkE88Nr45G6/p9u3vPR2Fh0fV/UbL6gXGM1kNVkcllI2WIPADt8wDR3ANNOFJsy9FmmEA+O8OsHcL1Or/Fq2QiPOb1FmU8Xh8MAk8W5p5Wd75GYTifgFN4Slh8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628194; c=relaxed/simple;
	bh=qPsl1p/pnSxH6jU9ZCSFGRHHz0vNml6RGHCMU0Fw1AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAw53kQzsTEwJ0AvuOBWmeZk6MsXmARKEs0zf7lM5cAOC62OcMzejZb5tscQK+aHWbu1KF5Nah0JY+9QBCiBeevRXn4dMT5ps/Xm/h/pBYD8KUH2s6T9HtR6+6NNvJ8uTciZ+s0pQNZaUd80Dt3ECRdqXHxByolphAxPtTf3e5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P58rEOhG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2aeada833so815287566b.0;
        Mon, 14 Apr 2025 03:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744628191; x=1745232991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXHgCoRS0YwOf8Q53qIdanPklBmiKbG3Rq6TfM+45WI=;
        b=P58rEOhGkn7EDFrOixFc3AhjTZo4LQg/H58ej6ewUU7M9q72uh5vV7z7Z8HRBYFs18
         ekhUauYybDdv1ai5QXtdBj73iHmuwkcF8JZxttg6PnJ8Jm+eoOqxpJz9g52F4VRRAwD+
         RJWghzyqjkqOLyuMi+RiBp66Vpjatl8xAE+uXe/EIkR0DgVsOBUqBojqWRIJXTCzwFQy
         mDDEAuiDqtqhv58XnW1CsY+U4Aw0L/JldTlpdzM6QkFrio4AaBpFxDvXPn12VXv6mnAK
         nI8tnZ/n5BEcRLThivP9jQFQTYAunB2MNl35Ry09Kto0N084UojpQSK4VY08H9NZpCae
         0hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628191; x=1745232991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXHgCoRS0YwOf8Q53qIdanPklBmiKbG3Rq6TfM+45WI=;
        b=MfTWdJyA3r0avU2Qlc1Ih8eJuSROgL87l5Z3MVu7aaUhoJQDlNtETG/Gd00dN1Mn75
         xamshqZLipyZXznGoQIyVADLDF5wsixKkBV8rg/SvXKm+hDPly47plFQaN+iCdwlWrAU
         LAJQbDTdgkvewrGgBuNFY5Khdz9CM1lNDcZ2DS7idEGZnV99BngaHArNJwHzCy/5SeGL
         /OlwUKUgZUljMIDIZSkxZeMITvTNPcsjiTi7chuBtEyJ+TDuKwgV8Z0+uRmhSZ1QgjGF
         Qg2sEUkLJvD+93PKEFiF4Pr8+gzK+yWIbjObUbevuzm93ZmVildDwAkb1t9xEauFvnTD
         xTsA==
X-Forwarded-Encrypted: i=1; AJvYcCVXg/dMEMph+EKfZ8pnNiUeyp9ch8GhS5LxOhk635F+JxgnIWU9eAkNtH3JO/W4/kcSEyxK1c/BPqvVWyc=@vger.kernel.org, AJvYcCW2Q/noo3eUU2IKdWBifizZBhDiHMWZY6250fTGjvdeyh8gbBZbatgp/nJ4DJgHkoLiDOuio4Cr@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZJ6YT9cFU1+fyJ4H5nW4907udNBfg8IbFbyedCw9zDUA0ZIv
	eA51QLC1qrxNUKmxgsgNOuh/QBuzdS8K4moHaXBNcyvkb6tCtFIcPdZzLbFxuDubUCTlCe+PbYv
	Hm1+EDrwIxVH5gAq3Mo2ZmwBrhH4=
X-Gm-Gg: ASbGncvZsdwqcZPPDcLFR1v8vhNcNkB9l4kPtF7jkz8u2RR1NX1dto4L88kELWOLxpr
	mjnawWx105yWcm5tn+u3he5HDPc8uRTsZX85kXsRzTIEG5B1N2107K9hsafewNOceeJUb0UBmki
	478Dg4APNh3mRYgKDcOHTI
X-Google-Smtp-Source: AGHT+IEvDvPQZgPAoeGnnFsZrVJ3o2c9ryxxE5kj2iI8UmbuWpxSwT2OgF8oUCNJxp8+9r2VQDpWUAH7/WPQKyq5PQw=
X-Received: by 2002:a17:907:6e9e:b0:ac7:b494:8c0c with SMTP id
 a640c23a62f3a-acabc24974cmr1125809966b.16.1744628190945; Mon, 14 Apr 2025
 03:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414085412.117120-1-maimon.sagi@gmail.com> <b6aea926-ebb6-48fe-a1be-6f428a648eae@linux.dev>
In-Reply-To: <b6aea926-ebb6-48fe-a1be-6f428a648eae@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Mon, 14 Apr 2025 13:56:04 +0300
X-Gm-Features: ATxdqUFLPdurWYyYiq28ZD3_gow2Jut3gXA3TatPsfgs-Xz52ZZYmbXK34K6oHg
Message-ID: <CAMuE1bG_+qj++Q0OXfBe3Z_aA-zFj3nmzr9CHCuKJ_Jr19oWEg@mail.gmail.com>
Subject: Re: [PATCH v1] ptp: ocp: fix NULL deref in _signal_summary_show
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 12:37=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 14/04/2025 09:54, Sagi Maimon wrote:
> > Sysfs signal show operations can invoke _signal_summary_show before
> > signal_out array elements are initialized, causing a NULL pointer
> > dereference. Add NULL checks for signal_out elements to prevent kernel
> > crashes.
> >
> > Fixes: b325af3cfab9 ("ptp: ocp: Add signal generators and update sysfs =
nodes")
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> > ---
> >   drivers/ptp/ptp_ocp.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> > index 7945c6be1f7c..4c7893539cec 100644
> > --- a/drivers/ptp/ptp_ocp.c
> > +++ b/drivers/ptp/ptp_ocp.c
> > @@ -3963,6 +3963,9 @@ _signal_summary_show(struct seq_file *s, struct p=
tp_ocp *bp, int nr)
> >       bool on;
> >       u32 val;
> >
> > +     if (!bp->signal_out[nr])
> > +             return;
> > +
> >       on =3D signal->running;
> >       sprintf(label, "GEN%d", nr + 1);
> >       seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%d",
>
> That's not correct, the dereference of bp->signal_out[nr] happens before
> the check. But I just wonder how can that even happen?
>
The scenario (our case): on ptp_ocp_adva_board_init we
initiate only signals 0 and 1 so 2 and 3 are NULL.
Later ptp_ocp_summary_show runs on all 4 signals and calls _signal_summary_=
show
when calling signal 2 or 3  the dereference occurs.
can you please explain: " the dereference of bp->signal_out[nr] happens bef=
ore
the check", where exactly? do you mean in those lines:
struct signal_reg __iomem *reg =3D bp->signal_out[nr]->mem;
struct ptp_ocp_signal *signal =3D &bp->signal[nr];
> I believe the proper fix is to move ptp_ocp_attr_group_add() closer to
> the end of ptp_ocp_adva_board_init() like it's done for other boards.
>
> --
> pw-bot: cr

