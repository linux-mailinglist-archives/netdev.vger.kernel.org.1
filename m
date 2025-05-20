Return-Path: <netdev+bounces-191898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78DAABDD42
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36E14E6C6A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E1253326;
	Tue, 20 May 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C48QBauZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B962505C7;
	Tue, 20 May 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750685; cv=none; b=KiZ427tURaURtUtzhiqs34c5vz5S39cJ2cmtrm2LjesY6rqAqK77TkBSMNrqG7pF+Z4og4TbZc1VynQmT/ezUGPNdv8K8/QI6viiT6dPZtMs77IHHLzTVnnoD+t3mGXjkCeSmVtra7qy9D4H7imxllnQz2KBVKIaCGNOqFvz/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750685; c=relaxed/simple;
	bh=n5HLSG+HZfhC0Gthpz8JGBNHOZuHr52+38rD1o9D0lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NM3Jl0A6+Dy08KznMrzXK1ZitkT1hqIZrHG6reTOrhkLmIQye1ieveNhdEvQ5SUgrEWKFHL/cKQjIRvUYIq6/dvCSuomO7UxB99yRkIQPGbR4uaRqvChsE2T/1e9kFe2IPAm+VUxwErf6bfBBgOrVc95izVaGn0l0geFqAp1cao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C48QBauZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30ecc762cb7so2412931a91.1;
        Tue, 20 May 2025 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747750683; x=1748355483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV/OQIV8ztouckrklGIhTFHAEbzSsaIMTwiOmhCaP08=;
        b=C48QBauZAzvrCEkx9l9IdUtN9txVIgO1SUMxsplEgmS1Ey/qSGy0NTPZEEnHgkFxJk
         bvgZsLKUsh9Cm9UYvhcw2GOkHIuB9ks+tlgdtlMxY5v4pRM/ncRS3ewcbmskbGi1dCKs
         s0lYtG/P1MyjzJ/9RvlpmqoeiLyp3EBiqAOA6xAAGFg0AQOknybKV1N82ZdQFL+m/OCO
         Rb/NkA5QPyuqyTBvkQKgr1qAohyV/DamIT7mQLzx666IJFT9u81n1AVAiuSRmUBf6GXH
         Fs8gUcdXbrSQQFmHojmvC04ga3m7tCNjhyFkZVNcnRmHOFC+nZOMxY49ZBReuUOnXOxt
         oZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747750683; x=1748355483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cV/OQIV8ztouckrklGIhTFHAEbzSsaIMTwiOmhCaP08=;
        b=CFZaAQfS+mreCd1AvpwtZeHKRMHg2UmW0yjpb1Q/dNrARnbk7i6g8Wn6Lb6PwDnazY
         KJsVEjm/W6PTOeuVKR6H0dMCKla5JDxIKs+Tb3g7Gudjcyo87IFVNfhDkr5Oo5nDrEqM
         uVvAr+6Zg2MgeMQG8f/mz2YVhIxZOjs2X6pdTjPa448l6SdVQpdj8hNqJReB96OPS8gS
         adAcpfGyN0TbexaKz0RUuobFUV1KvaaOeX9asdgB/UEPrKb+KPI2gLD1QnC1TpbeqwvX
         rYT0nPYFaHFECQqlulbdOVEDAsWSL78WUl45oP4LFwFomOtOLWOuB6FNfTDmCoHitnId
         vqYA==
X-Forwarded-Encrypted: i=1; AJvYcCX7qkQymgs+ybvWbHDcE2NizxQnajoVRswb5PeveFCyyaaIU/53zREzwa901x5Ium9gQsloS31bef1Jeq0=@vger.kernel.org, AJvYcCXfMpcnLsIa3ABzriOoP8ixG/+0jbSWzey5ZvnLVgd0Fgq5JaLZdmYiJQFC0+8keRwdUXCwXRde@vger.kernel.org
X-Gm-Message-State: AOJu0YwFWCDJwMdRd+NODQwgSmZF6rqSysdqbdqMb4ks0yQRStGS6gkI
	4+7w+P0+NfsmX7W6UHsnEJ8x5tGiNZl+hWCZwGoWQ/LW3AQgq/p2YX2rxboLa4FhlOiKbfXLD12
	+0LAFwDKlDKfu3oNhSxrE47WQajUK5Fs=
X-Gm-Gg: ASbGncuY2+QcIsQzy8nPKRh8ElAr03ekGwXdJPEuuOKImwjQCK7N22GjafhA2mxrURa
	sYkBqB9RxU//ZkUWs4bddqxEDtUr8bainIIRIOlnCX7++/1AgHnHr62NpJj3GmVw6r8rWxkT/Ik
	AiKn9i7mqwkA6LFsoICUPNKqy6j00NM7SD9lY=
X-Google-Smtp-Source: AGHT+IHop0vmNJRZlUx6caCyeoeYe6BDnYX4Gm7Du+V6bm/RRJ8NWj0JlPUUEXPwgVB01rPgXJlziSg6bf/mQEtweI4=
X-Received: by 2002:a17:90b:2f03:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-30e7d6d17e6mr25420919a91.0.1747750683051; Tue, 20 May 2025
 07:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519153735.66940-1-aha310510@gmail.com> <aCyAcbNqKRlPnadx@hoboy.vegasvil.org>
In-Reply-To: <aCyAcbNqKRlPnadx@hoboy.vegasvil.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 20 May 2025 23:17:54 +0900
X-Gm-Features: AX0GCFtcL76npAhxQUeiUE6yEiaTCAtDhflj2Ax0XR2OXCJwmO4Pk_G2kOAmp3A
Message-ID: <CAO9qdTHe1bR=c6dn4WEDsVZS8pRtf9FsMMQXNFVV_DT0wm_FVw@mail.gmail.com>
Subject: Re: [PATCH] ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()
To: Richard Cochran <richardcochran@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, yangbo.lu@nxp.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Richard Cochran <richardcochran@gmail.com> wrote:
>
> On Tue, May 20, 2025 at 12:37:35AM +0900, Jeongjun Park wrote:
>
> > diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> > index 35a5994bf64f..0ae9f074fc52 100644
> > --- a/drivers/ptp/ptp_clock.c
> > +++ b/drivers/ptp/ptp_clock.c
> > @@ -412,9 +412,8 @@ static int unregister_vclock(struct device *dev, vo=
id *data)
> >
> >  int ptp_clock_unregister(struct ptp_clock *ptp)
> >  {
> > -     if (ptp_vclock_in_use(ptp)) {
> > +     if (ptp_vclock_in_use(ptp))
> >               device_for_each_child(&ptp->dev, NULL, unregister_vclock)=
;
> > -     }
> >
> >       ptp->defunct =3D 1;
> >       wake_up_interruptible(&ptp->tsev_wq);
>
> This hunk is not related to the subject of the patch.  Please remove it.
>
> Thanks,
> Richard
>

While working on the patch, I noticed an unnecessary pair of braces in
ptp_clock_unregister() and included their removal in the patch. Since
you=E2=80=99ve pointed out that this isn=E2=80=99t the right approach, I=E2=
=80=99ll fix it
immediately and send over the v2 patch.

Regards,

Jeongjun Park

