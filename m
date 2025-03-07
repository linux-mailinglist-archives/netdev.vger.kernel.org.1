Return-Path: <netdev+bounces-172835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB5A56499
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E4A18979BD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB44020D4F4;
	Fri,  7 Mar 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PY2lTVOU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0320CCCD
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341945; cv=none; b=JOftC5X7JRFEQrZ3eDdXhB8JXy1PNt2jcE/tLP9miZBfTXRMjlqARn9WxWuVrD/I+gwFy6+VkgOW7BGl81H6j1N0kwTGf6YuXSdKUPrDYYSs6U8kR0eI82T49tgbpPiBj32GBZCNF2Sb2rib+SABY/6sY+7TimsXGSEi82CakVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341945; c=relaxed/simple;
	bh=cLIUHCecooBF+rqXN1y9hNQRtLd+eNqLh/ZepiT9yvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJJOZ+SnKPHU5ttGz9i2FpOZ8LuPwullNLr6Lwn+nKeBEf6kVAPek1xWgMc2vhqULEYlTxLY6rvpIR0VowUnT0c0BG4lQj9A3NpXGmfIdcxmdHYxJihb+Agon7zSOjwtTRg4s/f3U+e6+QgYh3mqjFpE39Vgc/hjSOMAb9qdrvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PY2lTVOU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4751507fd08so13203131cf.2
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 02:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741341943; x=1741946743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLIUHCecooBF+rqXN1y9hNQRtLd+eNqLh/ZepiT9yvc=;
        b=PY2lTVOUmpopFmQXhO7DiI5ZAJI7p88onM/w2j+BxWKraBEjbo3QSWGfDiVDz5o1fv
         NbUcYXpnLRJpNFpWZn+x9acXcwnn7mevNZKo5xSvenWnCTQQIuyOrpcwyXUexJonLijg
         3Cg5/Mte91PnJEeUN32s9sYd8Qi7lOl3nqPFPzHd/ChQENwey7Xt/fej5RZXr5mR6cbJ
         fhTmQmcFgrp2tQfIwctgLLvCZYVM88Sny1iJnIXch5mgBlmRgH4Xku1UucZ1Brp1sYse
         OapOYztVfyMC/p6TB60s8x5I8iVLJ+uGzPXYjM+oR0hAnLMXM6mMU2n8zucX4DYMK/7m
         YNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741341943; x=1741946743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLIUHCecooBF+rqXN1y9hNQRtLd+eNqLh/ZepiT9yvc=;
        b=skUIhsv6tPNMIYwqnVbPYHVmVb9iO0FXQ9AFfQUNJpmzW+VvRBioinJSjnAM70I923
         XY8BimFTdxokkdR5Gpja9my1KFaKvZok1gVKWPd8Pw+PCR2fz/u4wNUhMenQjElDbVKK
         5Nx9RKr4i7dYChBwGBIGmNY4t3kBpLyQUPo/W7WqgJmy1DpQwL8crRUPczhneHN58vXn
         aMAUsGxaOVGc9P4hRmFGsHv0iJL350KgcRb6LM9VB1JqcySDBqalqgtHdnYeKZqURizG
         TVFHUOhCrcOqX0laoDmhZtVMCLTn+sCNPUbumXS513ZZEbtSifBJlQw5WFKCOfohOFYb
         nImg==
X-Gm-Message-State: AOJu0YzhSzhiyiGSboNJVea/7SExY3lB3kDyZnr4YQ6MwKf4k+Iwy+fa
	lGnDLhP1PQkVTOE1Q0LoMwgQv4I+JiO2m+Vlqj5/sSUYyqPxBZ+ULpegpt4yq3+eGhtlA2Jl7W6
	gfRbPlAearKRiJ2x4z+3QAHFun/NggDx/2IGG
X-Gm-Gg: ASbGncudkzPkexQhOraIF4P9sjtmN5eEerv8ZOHfrFLMw0oxrnNJV0LjrGiNzjtO1c8
	k++TgCtF8Le3BB+KByJyzWBD+RRpWsDkZ8xx8R2q+D6Rg5rN8ssFIHl89zLt14VTB/nMIc3YuQy
	G+uKgwhs1c3dWD0Ckr9tZ/9SHMbLw=
X-Google-Smtp-Source: AGHT+IHhhgfYmDfR+dfbfOK+gHYo9tAPXa+E7+HhogrWrtgmm4wUUjzqFrvGOn2Nf57X1l3dPH++aAIaew17tn3Hwto=
X-Received: by 2002:a05:622a:18a7:b0:474:f54d:6160 with SMTP id
 d75a77b69052e-47618aeff89mr37158611cf.46.1741341942755; Fri, 07 Mar 2025
 02:05:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com> <20250307033620.411611-2-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250307033620.411611-2-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Mar 2025 11:05:31 +0100
X-Gm-Features: AQ5f1Jr58XM0aiY94-3k0F5aDfF3R_AruQKSU8fgXUiYD0I18iw5sXk6Gyhql74
Message-ID: <CANn89i+zJOCutKxgsi0Ubi+Z3VyuR+fSdRuNHf=Tt_QqAQwUFg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] ipv6: remove leftover ip6 cookie initializer
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:36=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> As of the blamed commit ipc6.dontfrag is always initialized at the
> start of udpv6_sendmsg, by ipcm6_init_sk, to either 0 or 1.
>
> Later checks against -1 are no longer needed and the branches are now
> dead code.
>
> The blamed commit had removed those branches. But I had overlooked
> this one case.
>
> UDP has both a lockless fast path and a slower path for corked
> requests. This branch remained in the fast path.
>
> Fixes: 096208592b09 ("ipv6: replace ipcm6_init calls with ipcm6_init_sk")
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

