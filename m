Return-Path: <netdev+bounces-250438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BAED2B31A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55577300D931
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A81D32E15B;
	Fri, 16 Jan 2026 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASsKJ2nn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01774308F3E
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536642; cv=none; b=mItTAgoqZ5DzAWS4PWQqT1VgRF7Xa/aULGypnOZJVm7hcmxYgZW2OHr8TiNbXDwdo0XeflTplSzb0HxRd37A1HhVjsrsNL9KA5EgDBj5deuVFU83WFUseFFiSCmSCUfZ22rl2VWqaYjNfghH96M7xrTMy1AtLdpT81Z9ODfiof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536642; c=relaxed/simple;
	bh=O1pwVJR2mtxsLYJsVZiIPKyZKWdE+AKwbznrSla2OEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHz2D4pPad/39wJG0yBS2nQhes1ANb27OpiQZV3i6pftyGU1sySVjV4RPip0fxySwOMSAZelyj4e7Mb7zyvOmIHFF5o5NeXRUdmmhwxRolLYhgiBfiqAq08kFthjOA852/dx49QKKqXqTpwUJVoXDHjUrsEJdgBL/6TBro1pNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASsKJ2nn; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b29ff9d18cso196299685a.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 20:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768536640; x=1769141440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1pwVJR2mtxsLYJsVZiIPKyZKWdE+AKwbznrSla2OEE=;
        b=ASsKJ2nnP8hCcNi3tiZAev2cwQ+HMbiMXhSTNYX0Yk6orUbmaDGntDCWf3C+WQiZqr
         NDXaiAHCv4jhL5+RWVNXSyfuZPpfgNgYBODG/EMiz9X9CijOFwWKt0Pcs76fLRmRBbVc
         tnAL30iSwjT9fC3WOyv+aOIqKunuiq0mWicYYavsQV0cbe5WHwSosunpT+Dns/2WvLJ5
         iUqWG8D2bZbpiynZ+5eMHEHO+J8S+qzLEGd6Q/M3gcFDa5UCUnf0Tjs0eNm6dQ3zH1BA
         7heHkxbuAjArBc9bCBiuWUeLIwvIqxeEPzIZ/yfEHsx51i7lwcgMkUxsgXtDZu8cPedC
         6/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768536640; x=1769141440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1pwVJR2mtxsLYJsVZiIPKyZKWdE+AKwbznrSla2OEE=;
        b=ENYKmFZXKPQXyNRXtABJKXlA0ixTuYYBPAes8w96o5F2ptPrejVSwRjz1jqLiUp3E4
         vhBL1oLfTwoU1eLpwyJfu3BnTLUxKTboGap/coK7vBm51o+9I78BsPR2JwejGmtI7HWA
         VTF2ice0QKTUvpbaqI+b2VLL7C2/94gyvvKF3uNCoUWsgL/Ak5LvbKxtdHPtCDGX3fKp
         9FegSiVVx1Bt2qgrduqoiSc3ju+Qhb0A19dXPpApz4gG/m5QWxodI64h9u31EGMSJOgj
         w8zkDoLcZSMNeL0pB4WCCgsr9MkfY1z7KD/JDsuvhCXAELO0602lTnHDTVg5HKLv8N9h
         ak7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHJtOgdezIkqDzcCDSyNXfX85S+kDd3LEYvEq2RyhYMv8Ub38zXGjtNQ9sG8S2Qm/jY8sCBWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJM54ML4LtLAyDmrJMtc6yETXER1lIKRanJ+tl1eYVTEq3jNK
	aAeTguLnhrDUbJ3jeUM80h4AHUnc9kZ8LxNL62/XZ4a7F0Kc3Zbi+Jf6kq9gO7xF3pZc+8u4Ucq
	s9FFgCTDlSsJP4eSSAvYR584/ul79cyaalUgHBTQj
X-Gm-Gg: AY/fxX4OAh1h+BWfTfNVrGQDcVSZ19LY1McNSxpiQj5EaL3iVUQ7gth4S+WITSqxTk5
	IPzwZdWXMpfKDkMobob6b/GBba1kgL0v3P/vdtpSLpDHY3M3gmQdx51V9qoqpT7emV727m8+9Wf
	CCYewvggtEa834+v8auJZGCEwPm1Es9d/cHSO4rABL9nFLd/MXZd8AGmZX7FgayMJu6z6/PorRL
	HHnKkINd7VLHxiVAq9cQ6r+YO6SaaJAfrH/2X1vp+LdVKolamzpc0+Wgn2RKvU56yUcSKGB
X-Received: by 2002:a05:622a:4c8:b0:501:40af:96c4 with SMTP id
 d75a77b69052e-502a1758656mr24774001cf.54.1768536639586; Thu, 15 Jan 2026
 20:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114212840.2511487-1-edumazet@google.com> <20260115200653.6afa6149@kernel.org>
In-Reply-To: <20260115200653.6afa6149@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Jan 2026 05:10:28 +0100
X-Gm-Features: AZwV_QiDlvtWse-x0ZEkDc7t4e8av1PBGpwVov-2JBwXcSea_hjzDZR2dFoQ0lg
Message-ID: <CANn89i+TX8pJte0o4=82VExJQi17Pyqz8dYaKCnbTvKewgOO1w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: split kmalloc_reserve()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 5:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 14 Jan 2026 21:28:40 +0000 Eric Dumazet wrote:
> > kmalloc_reserve() is too big to be inlined.
> >
> > Put the slow path in a new out-of-line function : kmalloc_pfmemalloc()
> >
> > Then let kmalloc_reserve() set skb->pfmemalloc only when/if
> > the slow path is taken.
> >
> > This means __alloc_skb() is faster :
> >
> > - kmalloc_reserve() is now automatically inlined by both gcc and clang.
> > - No more expensive RMW (skb->pfmemalloc =3D pfmemalloc).
> > - No more expensive stack canary (for CONFIG_STACKPROTECTOR_STRONG=3Dy)=
.
> > - Removal of two prefetches that were coming too late for modern cpus.
> >
> > Text size increase is quite small compared to the cpu savings (~0.5 %)
>
> Could you resend? Looks like this depends on some of the patches that
> were pending so it didn't apply when posted.

Sure thing !

Thanks.

