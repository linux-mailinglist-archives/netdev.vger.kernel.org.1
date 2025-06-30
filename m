Return-Path: <netdev+bounces-202379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B28AEDA77
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0782216F852
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8E1258CC1;
	Mon, 30 Jun 2025 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="02ldjveY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D1126BF7
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281613; cv=none; b=eHKU64HDnCSLBdZHb7+hqeYCUqxkJIqSQNL3jKQEff+gaFjdyEDEf0BV+GKoj4pcKLqjI1JNWL980WdQ1ty6WC/OlFZcTCi5jIop/q2GyIB5/Ll/9Wa3Y/U1YSYw66mQf5WiVNtr4mBZDaVUZwsx1DawPYoI7hhJpqTfKpOSDvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281613; c=relaxed/simple;
	bh=1R9OTrrSkwazrojI6llJHWHnwbroyoZOwj924B9ePvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKs8lL41U8hUcjcQaVMnzmxej4Lh28LY9iFUKwxU4efmGwGlvhxsQ9+BrDl5AeyL0N/yB1FlFMJoyvDv3FfmOZ2iDe+gzkp0qskGEBsocs15qjO2AnJGehB/E4j+gvIOnyKxLfV1y61W/EKXixKhc8bnmCNhup1f96GX7SsHFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=02ldjveY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74924255af4so1740747b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751281611; x=1751886411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R9OTrrSkwazrojI6llJHWHnwbroyoZOwj924B9ePvY=;
        b=02ldjveY8Ukp/8o4UkNHDJsOfgI45g0f80QEpaiDyNLqG1TesdQnxYl7WPy+Tjz3V1
         yNgDrZQ4H7gtq3tvc5JUCKLpeiEONHZtoc1KTfdcbbFAB76OxRI/RnjCPqVihu5ud+iz
         X+qTEzDeFvcJQrpRvvxVF1Pv/Nge5manwCX4s0qPGSY3/i+4HIgEgL1UZlHvqB53SeHG
         sJMOAT11pa7JALQqqWB502rWmEq4+QoYmQiDrjYXvaaE30uMWT9czE+Npj1iAxpPaMew
         zVzS9K+BcipdV2n1781VsYQSkvK+2fi9c2Ha9A49f5HH6yWn8ABqixXkOvEewB9ExvFR
         NPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751281611; x=1751886411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1R9OTrrSkwazrojI6llJHWHnwbroyoZOwj924B9ePvY=;
        b=sLKfV+gjoeocu0yNjC0wPIHK+b+rUCqVFnYZ8YqYHzQ5JNYU9YAOEb+vjF5Yxj31NE
         a/Hs0uVNW45NWjs6ht+XA0xmQU90phng/91v8Vz6uy0W7Ic3nFJ2DVh2DO2/umCqa6LA
         seHx4Jay+8B/A4iRknY+5WGugPGR7AZxttBTwQCbFSG5IMEDjU8HJ6foZ4suD38S8Kb5
         e6mAz5ulxfV3Dp0TL+9Y9u0k8k88SZOMCZviKyH95OAFUjd4OSrVg3VXm93M+Tod8TN+
         Rm36aCyZw6hwpryEPrOZZDPl5dfGhZdUIHnBs3wuXHGlMBZYOpCC+YZij1EagWfqVpDN
         SXDA==
X-Forwarded-Encrypted: i=1; AJvYcCXnZZb270q2bMnQuzjA5rYYq9P2Dp0aFPayIVpg30zo2PQ9IOZanMKZmqA9MPfvYtdnm+RJAyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCvxUSqroIi8xnaQuWsMuFF/P+FMrPnBQM10ogpcNLpKnEysiU
	WNP5Uqul5RRNOrqRNJKxcEQe1NGPIyvydrGY1UhwXi8i2rVpPqMyZXIC40vqoWLmTb5et5eQt/e
	G+G5ODUDFXzFLS5ZCWOrYhQnJcYOpdT2PRoH/YzmA
X-Gm-Gg: ASbGncu//UbL0thkb8gZvWzDCx48hA7Zc00nOAR4FRY0rZu/6TZ0RU8sWm/8GVKg+iS
	Esum97Oko83typPI+RttWvE2A8qHwM4nHxsJogOlaTLgupb/1fNbM3KXZ4KsUyMzluKqLzD/g3k
	72xgsRgGOn0tnSo1X9mymTBWkImBAWFZ3E5ERAhtx95w==
X-Google-Smtp-Source: AGHT+IHX6Dv3BEPiK4HEe8rArUBWkyWHlCVtP+Y3kHg6O1WIkYwO4mgHlHfmsOV3i+URtCrtoe+6QBzIYvCqX6XZfN4=
X-Received: by 2002:a05:6a00:1953:b0:74a:d1ac:dd48 with SMTP id
 d2e1a72fcca58-74af6f80730mr21823803b3a.23.1751281611629; Mon, 30 Jun 2025
 04:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE1YQVoTz5REkvZWzq_X5f31Sr6NzutVCxxmLfWtmVZkjiingA@mail.gmail.com>
 <CAM_iQpV8NpK_L2_697NccDPfb9SPYhQ7BT1Ssueh7nT-rRKJRA@mail.gmail.com>
 <CAM_iQpXVaxTVALH9_Lki+O=1cMaVx4uQhcRvi4VcS2rEdYkj5Q@mail.gmail.com>
 <CAM_iQpVi0V7DNQFiNWWMr+crM-1EFbnvWV5_L-aOkFsKaA3JBQ@mail.gmail.com>
 <CAM0EoMm4D+q1eLzfKw3gKbQF43GzpBcDFY3w2k2OmtohJn=aJw@mail.gmail.com>
 <CAM0EoMkFzD0gKfJM2-Dtgv6qQ8mjGRFmWF7+oe=qGgBEkVSimg@mail.gmail.com>
 <CAE1YQVq=FmrGw56keHQ2gEGtrdg3H5Nf_OcPb8_Rn5NVQ4AoHg@mail.gmail.com>
 <CAM0EoMnv6YAUJVEFx2mGrP75G8wzRiN+Z=hSfRAz8ia0Fe4vBw@mail.gmail.com> <aGGrP91mBRuN2y0h@pop-os.localdomain>
In-Reply-To: <aGGrP91mBRuN2y0h@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 30 Jun 2025 07:06:40 -0400
X-Gm-Features: Ac12FXyUp40h20YQiCRBY0CTEfQVzcjPEvkUlYCY2EmiXZ-AtWuBYTnFJKQu0jM
Message-ID: <CAM0EoM=jc7=JdHMdXM9hmcP2ZGF0BnByXWbMZUN44LvaGHe-DQ@mail.gmail.com>
Subject: Re: Use-after-free in Linux tc subsystem (v6.15)
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Mingi Cho <mgcho.minic@gmail.com>, security@kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 5:08=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Sat, Jun 28, 2025 at 05:26:59PM -0400, Jamal Hadi Salim wrote:
> > On Thu, Jun 26, 2025 at 1:11=E2=80=AFAM Mingi Cho <mgcho.minic@gmail.co=
m> wrote:
> > > Hello,
> > >
> > > I think the testcase I reported earlier actually contains two
> > > different bugs. The first is returning SUCCESS with an empty TBF qdis=
c
> > > in tbf_segment, and the second is returning SUCCESS with an empty QFQ
> > > qdisc in qfq_enqueue.
> > >
> >
> > Please join the list where a more general solution is being discussed h=
ere:
> > https://lore.kernel.org/netdev/aF847kk6H+kr5kIV@pop-os.localdomain/
>
> I think that one is different, the one here is related to GSO, the above
> linked one is not. Let me think about the GSO issue, since I already
> looked into it before.

TBH, they all look the same to me - at minimal, they should be tested
against Lion's patch first. Maybe there's a GSO corner case but wasnt
clear to me.

cheers,
jamal

