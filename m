Return-Path: <netdev+bounces-203024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08999AF0292
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 20:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB0D4E4C0B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C927EFF3;
	Tue,  1 Jul 2025 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKbzjJBK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2FE1B95B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393477; cv=none; b=Toj6gt9qr5tcNguKScHmofJlrS8/ydp9ovWHNO/DRAM9s2u71BHP3SDkANgT4tHEt2wjgH/4U4dARFxdu4PQ7qS3HqqOYTv5VfiR9N+6fUx81ECh/Ff3eMyZnvA4yDb0tg4sulNwvOPbNCU9pdNeKYygpJ2il4UzloSt9etTtBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393477; c=relaxed/simple;
	bh=9va88OGjCRPZ6rwaPmmpSSECNvEd3AZ4t97cd7WstFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krz2JITRTBr06Vzud1UMOQKdE+hApNs94RE0cDksStf0vozrW96oynGZHVyXUltJshPtC0Ob6tqCLDtwqE7fzorNAjTRGR375g11Dm+Wqwi++1tLgmBXOzXMHNbyl5eTSC8h+fth7KT1AlcnPJXUnwrISG3eTCh8LnAqXiTltts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gKbzjJBK; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a76ea97cefso35094491cf.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751393475; x=1751998275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJCGsPe8wteTutHRwOrgctZJiOCKv4gYhVxNNQouubI=;
        b=gKbzjJBKmTPUxt5ruM4NU4WniGPuzy5ETfnWS3GKgwOlxbGujaMhyVe0kEYOEZP0YH
         o2yfYi3umlRl+6924vVHVSO90IV8Ly4mXh2vHt4OpLj6xPkXNuUrw0h5cwuRL0iZDLEB
         9yeKyim+YdI01BFaLUMvIe4h24TetiINpGfuNqQ3sux01GBgvF/LPJhzIlPP51djSbvm
         tW/UtNtJ56rAxZD+qOq72oo4D4rLM0Cd3PJ6nVjBAStYlCjiB1OWUfuU4hvK9ySm3+d8
         gvLPQ7+YUDCicEfCtXpXhOekrhQNykVz0BJ3hNPg7m863aStbItlJnTM01n6MKOhlxei
         qjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751393475; x=1751998275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJCGsPe8wteTutHRwOrgctZJiOCKv4gYhVxNNQouubI=;
        b=ajD8RDeb7ejDT5zwhB+UvGne0/NDu2Ss3hEpy0RiHgbYCaHQweOhbqIG/L9U1AEkaz
         enp4j3US89TUXYkXxo7uwkkMwXJWy8eyA5IIDBoQikmedRFsAMM+6AOjFRuyQatxoVV1
         bso9Y2QODlgj74URTTM9e5F1d+bT7amf2vYAPfhgC6gIo2Bs4t1teETLk8+kI2qSgAyR
         vsnCY3AMY72F1VCQDy8G/dYnKGx6aFbe6BDAdFj9iRX6nIjO80OScVUQl3LY9Ute4LE1
         CkAjMRy8SfyipYiJZYEcV2tDSt19CKMi4Ro1fhMHvspgrt3Eye9cHalL1IxwJGQ7hLe9
         y/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVOtqAr4ACiAPVSkcpLKnUP4jzr2qEH+bXE2Q4UtvlVUfNbzGzEA+4bnR6+yv+6M4CFUetkpLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNO3z+C4xQkI4XhdNH9b29nf7tmGj4PI2ewluBeCZKNaUZOqVw
	ZYcdnev8gAeY5Q6XRpMYcvMV/1zAnSiZhOvoM8TrQ/9IqBLTh/lzt6/qEo2UWOwXh1fJVk0vKGY
	GLbRuhWTAvqSpj0O+t3pUUW4mGo65lS/2GWdVY1n+fWBq7N0KoU90yctVZ9c=
X-Gm-Gg: ASbGncsHQen1wdZ+3RhUSDxcuapfkxwUPapmkT/XkA94WDiW0f4UsAb2KfE1+n/LJ2F
	Wp91mpqgg+ZiNPGagmBdIqr3hJU6D4a6rfKVkoclQlpsUkG1RwE2dI2+Ks7o1SGJZFFPa1J40cZ
	d79R/s7oQiH/L7R4KBY8BTMz2WIZ4dPTUUwRk8G+WSGgw=
X-Google-Smtp-Source: AGHT+IHzKZ5xLzvCFd7uffcF0chXyCwQzsakXge8PFnEXdpa0Ubex5ARTd6R75I2E0d2SI2/uURfh4SvFFI/IEsiW6c=
X-Received: by 2002:a05:622a:1b8f:b0:4a7:f683:9749 with SMTP id
 d75a77b69052e-4a7fcacff9emr314801741cf.30.1751393474313; Tue, 01 Jul 2025
 11:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627061600.56522-1-will@willsroot.io> <aF80DNslZSX7XT3l@pop-os.localdomain>
 <20250628081510.6973c39f@hermes.local>
In-Reply-To: <20250628081510.6973c39f@hermes.local>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Jul 2025 11:11:02 -0700
X-Gm-Features: Ac12FXzD5CZvaejnGA_DWMdbFg1eLeBs7vCCAKBrxQ3pLY_hZhF5ILf_MiGU_jQ
Message-ID: <CANn89iLp12_MzcniYqNU2zADVpG8Fs+ZiiMtpV3bCXW2z55DvA@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, William Liu <will@willsroot.io>, netdev@vger.kernel.org, 
	jhs@mojatatu.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	pabeni@redhat.com, kuba@kernel.org, dcaratti@redhat.com, 
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 8:15=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>

>
>
> Why a whole u32 for one flag?
>
> This increases qdisc_skb_cb from 28 bytes to 32 bytes.
> So still ok, but there should be a build check that it is less than
> space in skb->cb.

I am pretty sure this will break some configs. This has been discussed
in the past.

I would guess drivers/net/amt.c would need some tweaks.

commit bec161add35b478a7746bf58bcdea6faa19129ef
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Sun Jan 7 14:42:41 2024 +0000

    amt: do not use overwrapped cb area

Also net/core/filter.c:9740 would complain.

