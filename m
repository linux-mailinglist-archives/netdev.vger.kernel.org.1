Return-Path: <netdev+bounces-204356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17CFAFA255
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 01:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC107A788C
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD2239E99;
	Sat,  5 Jul 2025 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbUYt/sp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B318DB1C
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751757906; cv=none; b=JrqLynpkU9t2AJKVxsku9fXtGs5NGqQ4GBeDi7cd9Y6ztSUP3eqWr1ZbMBrM81RkmibEVg2p6SKD1JtXcFt4qkyG7xjbZWwLLKRLyfFj0Vdxfsey55jam/MaRvTWxrU8iYprlWlymvAJHjDEyG9Ynf/SiTsH6xo9Z8IkxVi53Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751757906; c=relaxed/simple;
	bh=Th7sd1MLpQu456VCPHWtcF/yuMndqlugKoYqYg3ElXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fj+lx3eyV1/EekYSr+P4IPGVc3fIE9aE2aAkQcmn9vG+nGwd8jGScG13kbM56l76T9Nujx2kUWVWB/J0bOqSwc52VZvUzRs++VkazCuj6lNGprxjj9IyllQnCTCUkcCVZRMRUhvBuemwRNme5A9v8I+5A24Kf2DjNe8U3vt/2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbUYt/sp; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fad77c3ce1so2301426d6.2
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 16:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751757904; x=1752362704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th7sd1MLpQu456VCPHWtcF/yuMndqlugKoYqYg3ElXg=;
        b=EbUYt/spcO+R9N1YmYBIIp4o0MrGWn52MrtcT1WSKH9roZ2aI6hxiUh/LcW/NHr5V6
         umlo8LvIWqBJ2uz97kgB+KAfGVjML97jrDBLTDu9JVqw2mIUEP3BGMll3j9SvV267onb
         lsUH1plU142/cXdSqicYAtmEsGYZS1y3cRhjmcuVpsM6YrK+8+sJeN0nOYEofGDZI9na
         Gj7zktVg3iwAEyYuTt1LfHBNds6CSb1fVUGPQv84eoR5+yaIX6wtRCHoNg1CdC0ustLj
         jFjzB3UGtwj+QZVqllqEZOfT3u9YYGrGKfsqb8wff9TtrM2AnYiNsoureKz2LOdYHJ3Y
         zpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751757904; x=1752362704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th7sd1MLpQu456VCPHWtcF/yuMndqlugKoYqYg3ElXg=;
        b=dhKPs7nBfG4qPSc4Qn5pYPrxm45qLbTHchmoKOcB2UXABbOaO13DLL5LicSCVheVZK
         u2XC1K8a0E/hnrKdnoMzzagg+jEHYrsZeQGKQfx+8T9UgMdBo+xUM3frh1aKE5+mwI3h
         tb1xzWB3jU5/Obf3isp3VQ8cdh3/2EOssKasWymZxaU5afmSp/9CJpZOZMX533u+SVKe
         +jNYVZnLI6oENnT8JjGO92QOJHmJXhIqj9LsyXZ6I+Oi2r9s8IByRzG4wTERw94WO0ax
         wOuKO95HPshwuDRSiBeUbWAO0ZYLPH+OAWQiav6bQzt1//5Su67OWKuEzwHXm/JIFqXh
         skkw==
X-Forwarded-Encrypted: i=1; AJvYcCXi9wV+SWnZrXC5ZBEmuhBw8y1MFzLKHj/vVGqlc2cWxyKSdhJaUV2sEzJhzq8mtdLARD74e9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmDNEFWc5ceaHdFcDlX+ARs+hJdHw1MWliEgALjBuFQ6MesTto
	RwuKFPI/59QWpC0+C25JHM+SlYhddSbKA4SACz7///+gMtJnXLRAMh2dXTQaR66uhr9ekWVfSp1
	4/RAPAdX63G9gRE9Pip9cBiQUkygaCw==
X-Gm-Gg: ASbGncvI5TuEXoVr2BdMehy/nl8Ovwl0gMMncsqWqsWyQzHLQaYECXE/rJlyLPPeXKc
	jT9mkcvTGkO90PxQLHmRoa1TiV2YR294gKkQqxxwATXKuNLX6Lcfr+gk4uVddDHWelCwLL2d1Ti
	alqJW+mDpYe6jpRinvKebdiEMd7tR9etqaTZrkzOk=
X-Google-Smtp-Source: AGHT+IH00ptDSlVI+An0vNXUSgmnn108Hz0cb4WYUsVvEtS4wH8+2uEwyZvZOUXZQNbV9/wxf0jKdYb6SJBjPh9fVno=
X-Received: by 2002:a05:620a:172c:b0:7c0:be0e:cb09 with SMTP id
 af79cd13be357-7d5ddb98bb1mr389834185a.7.1751757903753; Sat, 05 Jul 2025
 16:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705163647.301231-1-guoxin0309@gmail.com> <CADVnQy=nXuhs514XXm18zhPSFc_z4XjO+b-+rm5oA9egEkk=RA@mail.gmail.com>
In-Reply-To: <CADVnQy=nXuhs514XXm18zhPSFc_z4XjO+b-+rm5oA9egEkk=RA@mail.gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Sun, 6 Jul 2025 07:24:52 +0800
X-Gm-Features: Ac12FXztUbmC2_ofTFf-uaksjEet0txI1DYUDdZG5_5IbGJwYn88Lvm6r66R7N4
Message-ID: <CAMaK5_hQvpOYMfs9ofAz=X1J8oOTsu4H36mQ7xiwZjh=g31A9g@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: update the outdated ref draft-ietf-tcpm-rack
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks neal, have a nice weekend!

Regards
Guo Xin.

On Sun, Jul 6, 2025 at 2:24=E2=80=AFAM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Sat, Jul 5, 2025 at 12:37=E2=80=AFPM Xin Guo <guoxin0309@gmail.com> wr=
ote:
> >
> > As RACK-TLP was published as a standards-track RFC8985,
> > so the outdated ref draft-ietf-tcpm-rack need to be updated.
> >
> > Signed-off-by: Xin Guo <guoxin0309@gmail.com>
>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>
>
> Looks good to me.
>
> BTW, normally I think a second version of a patch like this would be
> marked as v2 rather than v1. (That is, the first post of a patch is
> implicitly v1.) But AFAIK there's no need to resend. :-)
>
> Thanks!
>
> neal

