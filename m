Return-Path: <netdev+bounces-172786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB7CA55FF7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 06:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6C61891647
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 05:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA7185924;
	Fri,  7 Mar 2025 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhfpmlXd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CABC1474A9
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741325167; cv=none; b=K6aZrCfr5qn2jHhlmTfg0879nCD/SyEVUOwYaMT35loh/PcDGKgj6R58M9v6Ow9su7HfkGCkiORAjSCh8BhuhKCfxA+SMZeJ1NzCBw7HECZ8B15tigY6wc2cE0wMQWRzGys2AABfdQQDrW0fbLAJcE0f7aNXc1ZgF2HkPNRuEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741325167; c=relaxed/simple;
	bh=Tmb52u+3UP42Trjl4cLcGHJBSLxP87JyAful9e0CcOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQBSLgW+Bo7jyR1L50P1LDj4cuO1BD0ECzFOoRp2NcVzFItFu01XCC3dkWUJVEq/1fnc2zCCacDsPmUKYRK4ro8lSElYd+qalhahdSKvUt0GY6bMKJEl07N03lqVPXfIRmCUWuVFU55BkfZoAPR19fjGQLaxQSM5gA0KWyMMhkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhfpmlXd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abfe7b5fbe8so198193966b.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 21:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741325164; x=1741929964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmb52u+3UP42Trjl4cLcGHJBSLxP87JyAful9e0CcOM=;
        b=NhfpmlXd3vY0UxjbxC++LKYQs3yJ5GocT7zZ60VkCT4Ve06k/gYNx3RvwXAFS0W6Yw
         GwJlXFjE2ILI31eUFB5tGP6FkaLg2U20YsxrSlQJ8JONjl9mFPV44MTjRS0Ngqm0Kple
         iyWQGIHYapndxKNWH8Y4Ku7Yc3BdjO1U10DbsPb/BrIe31GZ9gh36QA1pB3jcdSbQZdr
         s9PotHtT7oRjOKQQp9gFqkMHjmarXXt4zrmXt5wKMG9g07kGz1PBbbIC7EZKPIF3rNW6
         qMxBPHkVkPF4kDayckpocyECjsCTW568cgq3s9wV/ehGpSaaGcyguHyE7lOvS188DmVK
         ohPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741325164; x=1741929964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmb52u+3UP42Trjl4cLcGHJBSLxP87JyAful9e0CcOM=;
        b=NmP/6Emdip1NiOi8FZwdlbLYDEeM10NWhfzpkWOrVsHp6vHcawWaFvKW1PQHM2BWl5
         rp//Qoj3+1jb9GmbPVmk0P91DpP7dV/ouGLExrhWcdg/6NGwXfNRxxQBrWtwZLhfbLk5
         UNzdxm23LSZRyaBqPrwcjxLwKmZ+2YVaX61Oa0NsLAbtcxpsrn9X13MqGONYSPZYbasi
         mOjB7yiVKP/vovrfPql3tyvR8A7a1WxQEr0ghh3wn10n+HrsneF6pQkFN7PZfCeOdjHE
         GG7hYwbUWut53i8kKuBLcRpz+83xoLqfVSnNFtarFeePs+7szvgsOk8Ja+V5h+aoyXJV
         gPDw==
X-Forwarded-Encrypted: i=1; AJvYcCXPsJbf2xQ8JfJBl8CGEVf2y3mato2ZR4Sq6Q5fdGmRMGfEC/mc+PUdPnh5PeGhchSuAvP4770=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOTyny7f8BN9PsdaUbDv1BaU8Mtkj8uyDke8G0EFXh8hBLZFp
	UqLarzXZf3BW5jtFNrOSUWyK/I1ibOCbd+IB2vs6wj2n3qe8VNq5eEoD6xsQjGyDNuK/YFIgKVb
	HRPQBjKEXiondmbNu5fdzd9+lWXE=
X-Gm-Gg: ASbGncvw9PNCcpTwMFHRLQma+Ybp4wuPI6zG542NUPbec/M7RhLy7IB1VCBRTrqT9Bk
	2PJQ3LCC+xuYjOl3SqKfLHvd753gwfOrNGF8lWJ0gk/7R5USjmddKidl+wRSLqxbpeuR5ML3o7Y
	lhRC0gNqbCrgbLatSRu30Sh4d3IgY=
X-Google-Smtp-Source: AGHT+IG5AT3x1sY58BTzL1X7lh4zkUOvXCKwlJDkAFn7NtJd9i/Ek8eHhFKy7+aqkmRt1gqPvRhhRhyRgO6RY67mzhY=
X-Received: by 2002:a05:6402:50c9:b0:5dc:80ba:dda1 with SMTP id
 4fb4d7f45d1cf-5e5e22bda31mr4655678a12.9.1741325163374; Thu, 06 Mar 2025
 21:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305225215.1567043-1-kuba@kernel.org> <CAMArcTWwuQ0F5-oVGVt9j-juqyrVibQObpG1Jvqfjc17CxS7Bg@mail.gmail.com>
 <20250306072459.658ca8eb@kernel.org> <CACKFLimCb_=c+RUr1mwXe3DAJe6Mg2DK9yYPCqRHtCLGVaGVPA@mail.gmail.com>
In-Reply-To: <CACKFLimCb_=c+RUr1mwXe3DAJe6Mg2DK9yYPCqRHtCLGVaGVPA@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 7 Mar 2025 14:25:51 +0900
X-Gm-Features: AQ5f1JqgQIRRt8DfzZU3mzzFI0fgDEVLsTAQ5-thZ8wHDQQnTjXUEUr0MVTvVzU
Message-ID: <CAMArcTXYF5gV+_ukWcE9=_yfyXuNZ99t07CVcQde2n5x0SsH-g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/10] eth: bnxt: maintain basic pkt/byte
 counters in SW
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, pavan.chebbi@broadcom.com, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:25=E2=80=AFAM Michael Chan <michael.chan@broadcom.=
com> wrote:
>
> On Thu, Mar 6, 2025 at 7:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Thu, 6 Mar 2025 19:54:22 +0900 Taehee Yoo wrote:
> > > It seems that the driver is supposed to return qstats even if interfa=
ce
> > > is down. So, I think bnxt driver needs to store the sw_stats when the
> > > interface is down.
> >
> > I think the driver already stores the stats on close and will report
> > them in "base" values. So all we need in per-queue callbacks is to
> > return early, when the interface is down?
>
> Yes, we can check if (!bp->bnapi) and return early.

Hi Jakub and Michael,
Thanks a lot for the review!

I checked that early return if the interface is down, It works well
without any problem.
So if you're okay with it, I would like to add this fix to my current patch=
set.
https://lore.kernel.org/netdev/20250306072422.3303386-1-ap420073@gmail.com

Thanks a lot!
Taehee Yoo

