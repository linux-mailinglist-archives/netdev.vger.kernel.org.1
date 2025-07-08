Return-Path: <netdev+bounces-204975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B78BAFCBB1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36E216A68D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30325215F6C;
	Tue,  8 Jul 2025 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LeIxgVFO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B81188006
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980730; cv=none; b=IzwjGx5Lx01jSVA/EHpszAvmdWTKYn7WJturENWcrLBwD+22BD9exFx9js447jjgbSNfOTxzIB/Ga7K/u4V1FLX327QaIMC73KpdwXN0Q9d3sPDwJlBqrFJGvzYinejeRFLzNybDOEeaMdwGPpqUynceVB8jZk7IFSTmPBrgqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980730; c=relaxed/simple;
	bh=qr8x9SzUJ1+K5emF7cRRqSLQpCR/lfsfTMuo+C2h9HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiY0b/5e16a74QcdTJrLGCmrx8wn1e68xJPzQZkJYnBeJl6FZxqngpFqzXU0eMqWXcVeTNTZOYsNEn4uhKoiTgZ5vmGI9Tg8cMcbTYOtlIPcQSgCDY50xRMRCZhgQs8hlGTeXHT1hdrhRIuuAMq5pEBQhRk7SwPDNOAWsfCjGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LeIxgVFO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b56b1d301so2437291b3a.1
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751980727; x=1752585527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr8x9SzUJ1+K5emF7cRRqSLQpCR/lfsfTMuo+C2h9HI=;
        b=LeIxgVFORhGpBq+U1hXQrOdTBqwr61YlNwrvhwVkiKelEbb7BfE34rmH1KvrzU3WMZ
         PtfcPh/ykNXRYerLrbstRp/K7Xvn2kZD0pBvfCC/0CSbOjhDqCF3AW2j5hxoMUGLGgJm
         HnLbmvxzcZbwzCysCZu4gtqVCzGLLRRLrQAT8djfBaIKu83Q0hBtLoP3WmhKnYHjkKVe
         fTqx/iO4x/8Pz05+lqZ0G5yWmm6N8w/WRicyvbIHOStdQr4OCWMfYdsviIUErUjI81eI
         ADvq8aeq1nN7Lt+MuXxReT0b3Q09Tj4ZhPaX2kfa/7qKdmm2f5opYNXGJAHDbA3pKGWG
         JpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980727; x=1752585527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr8x9SzUJ1+K5emF7cRRqSLQpCR/lfsfTMuo+C2h9HI=;
        b=TJTR8mSuNlPnTBMibjviks/Buv30qePFF3j5EBMZZw2ZAtsa+P4MEGTgm4GADBN1pZ
         mT1LouWp5hSW5Msy+In4JVpUvjb0irQ577zlppCr2TkOWch6hHYecelL5fMiHWhlaFiS
         fzDwaDjqWly0ACMa3pwxyvxyFOW5ywREzqcp6zqbinNRF2C4H08lOvqFKsO5kNGxfsdF
         oIqAU7DQaXsTMk0O4wdotGoEa2k93HQ8jX3hAvE/TooKK20bI0AOl/Hqg1g5hR85N2cl
         MYG8ADypGHE1ZGKllQJVuldRgMCiRGComO9kr82QgnRgFsz6JYzadJthkiGY2wpL/6Xi
         VbLw==
X-Forwarded-Encrypted: i=1; AJvYcCWyuh8yzrNU8uHVXHkktH3T1yYVOqlviU05MmjT7UFnNarMaDwHnfGLuL3aCrfCaZwjg+3Xat8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynK4S1ZP1GNehyJB3T7v/KHgUcYsSFGkU2hJw8TRSOTBhDq8AP
	qJiDDnCr3c8xted1a0uZO7uPKWZMMJ072XpBFn3P/Lt/CZmJ9T/XwqAuaVv2LGmtvgp6oQC+JB2
	EI5F7TETPyF0Vm3BzbS7XOXiLB50eL+1cy6uNmk+n
X-Gm-Gg: ASbGncvTjlsNRNcUrXcQYGy2xTerc5gNpvIE5ZFM4TYyT8heEDDJd64yVmPe/mehDKD
	aEdmflQWaXLkgxE/gqMOpeAbUuhwboecses5aVUu1J467eR3wgohYsnQdKrBrIiiusEbSjLwKAQ
	2GDM6uS/e+K5aqGY29jbQhRoj9PhbDzCI5ZN9mrJaK8X+JnP6owj+V
X-Google-Smtp-Source: AGHT+IFGrveAvkt+HkQzMJvvBd+GviPXeIcNQrJDOYPQqE7p2qkSqX9Mwi5nLIpTZPAOHqYN2TR384dv7JMh6PUm/2w=
X-Received: by 2002:a05:6a00:b4b:b0:748:ff4d:b585 with SMTP id
 d2e1a72fcca58-74ce8acda65mr23282413b3a.19.1751980727559; Tue, 08 Jul 2025
 06:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
 <20250701231306.376762-2-xiyou.wangcong@gmail.com> <aGSSF7K/M81Pjbyz@pop-os.localdomain>
 <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com>
 <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com>
 <aGh2TKCthenJ2xS2@pop-os.localdomain> <CAM0EoM=99ufQSzbYZU=wz8fbYOQ2v+cMa7BX1EM6OHk+dBrE0Q@mail.gmail.com>
 <lhR3z8brE3wSKO4PDITIAGXGGW8vnrt1zIPo7C10g2rH0zdQ1lA8zFOuUBklLOTAgMcw4Z6N5YnqRXRzWnkHO-unr5g62msCAUHow-NmY7k=@willsroot.io>
 <CAM0EoM=SPbm6VdjPTTPRjtm7-gXzTvShrG=EdBiO7nCz=uJw0w@mail.gmail.com> <20250707142617.10849b9e@kernel.org>
In-Reply-To: <20250707142617.10849b9e@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 8 Jul 2025 09:18:36 -0400
X-Gm-Features: Ac12FXxZ3z6sZSf08_nd1Yg6d6F0lhzTRBZNHo0ite-rUJDUWnFZbUP9Klpetrw
Message-ID: <CAM0EoMkZ=X08L2D_3=FiXUDjg4ver-_ahuCv7TCMF3ExDi4HaA@mail.gmail.com>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
To: Jakub Kicinski <kuba@kernel.org>
Cc: William Liu <will@willsroot.io>, Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, 
	stephen@networkplumber.org, Savino Dicanosa <savy@syst3mfailure.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 5:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 7 Jul 2025 16:49:46 -0400 Jamal Hadi Salim wrote:
> > > The tc_skb_ext approach has a problem... the config option that
> > > enables it is NET_TC_SKB_EXT. I assumed this is a generic name for
> > > skb extensions in the tc subsystem, but unfortunately this is
> > > hardcoded for NET_CLS_ACT recirculation support.
> > >
> > > So what this means is we have the following choices:
> > > 1. Make SCH_NETEM depend on NET_CLS_ACT and NET_TC_SKB_EXT
> > > 2. Add "|| IS_ENABLED(CONFIG_SCH_NETEM)" next to
> > > "IS_ENABLED(CONFIG_NET_TC_SKB_EXT)" 3. Separate NET_TC_SKB_EXT and
> > > the idea of recirculation support. But I'm not sure how people feel
> > > about renaming config options. And this would require a small
> > > change to the Mellanox driver subsystem.
> > >
> > > None of these sound too nice to do, and I'm not sure which approach
> > > to take. In an ideal world, 3 would be best, but I'm not sure how
> > > others would feel about all that just to account for a netem edge
> > > case.
> >
> > I think you should just create a new field/type, add it here:
> > include/linux/skbuff.h around line 4814 and make netem just select
> > CONFIG_SKB_EXTENSIONS kconfig
> > It's not the best solution but we are grasping for straws at this
> > point.
>
> Did someone report a real user of nested duplication?
>

None i have seen - regardless, if there was one it would be a strange use c=
ase.

> Let's go ahead with the patch preventing such configurations and worry
> about supporting them IIF someone actually asks.

That was my view as well.

cheers,
jamal

