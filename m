Return-Path: <netdev+bounces-228142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8ABC2C76
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 23:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3068319A0B47
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 21:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0C246BA5;
	Tue,  7 Oct 2025 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDLgdLXV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34052512DE
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873289; cv=none; b=DIo2RB5PIDjj5Ekdgc9yiwweF5LnSgZlgtfhKdOMLCy+f9uie+NZyBkXQxDerZTug1yuJBFdFU4V7hLTb/YMFyq3S3ujuNqNeRFrbIu0JgZprseYrwBTA4pKXyG5Vr4JhPTrLN/4aWjf6FIaIJmVm7KfJBogZstsThyn+Hc21F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873289; c=relaxed/simple;
	bh=ySCbiURSDN5ZR0BnnCkPHTPC4nHlSKf1E9rqgJQMac0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQkM5zOPH5CYNTd9PSC08dcDxDKHseyN72pJ0r+TtZfdUzDqsgp6qwWk+vWkknRpBeHjR3N6WG2YSOD/o9s1+HUPiOrzYhLBO0bhobD4nk2gFjWWCfWQ2sHAG0OcSClKC8+uTO6PJHkXhfflCTxZRVNMxMGf1ASeIvwhCSXneig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDLgdLXV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so73874575e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759873286; x=1760478086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySCbiURSDN5ZR0BnnCkPHTPC4nHlSKf1E9rqgJQMac0=;
        b=lDLgdLXVA/jzDydg/sT5Wljy0fPDwm+exTPyZ5vzsvWu5WKgyOcJI3k/ilQGhHpgMR
         0z85KjfusUDWOokAL7DOfEtT42HMLPOmV67qAmXuJo6NvdaPuZZvgRintKFLurbFYZCd
         gQb/igJJaU2sMWw++svSnPc/XZXM1efF2TMLggHZa47XfyHLXdJco47laJh9mTKfccz1
         kLGBm481+lO2MwDbChZ8sOXEb2+wx0uxdksXA8jja0bLectOIDMTVU1Q/Jo5pl+O0PVk
         xgYZ8YqZ87PFYMeXpBldze3cYH1vxeXRG9TYaEttKw+3bZ/myavdY1BGJghHMNFCYwQv
         Rj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873286; x=1760478086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySCbiURSDN5ZR0BnnCkPHTPC4nHlSKf1E9rqgJQMac0=;
        b=dLwT0PcCMnvAsEGbss7jAG+zMGEdIRtH2mOmoVsqYG9hAfpipb/Qk110zQHaa0EPOT
         4RKgBiGes6nBxfo+QPSSDLP34DSrtILzpplqAMUl2aUcJWOPzqj5BaegqtxvW3U9m31B
         5m8MisYPjxXqoUpsc9oqgAeYyApPS2lG+/Or4hRegOCAKKES/xchJhKOqxmstoTUKdXj
         F37afKm0aPKZwUsFCCVMhokL61BefLKzcxh50eXr4iGrkg+/qtWomnOX2senkf2PKmul
         K2v5ABXvBvUS/X+uozJOvY1Q6OCTzwyFUbs15oBS7UY5j346swZRltG4bZ5fP7j/LPKi
         TPBA==
X-Gm-Message-State: AOJu0YzZDNq+nMEy0Du2cgN31dF3L1eN5mq/eWy+OuVfnKUCVjsllZ1X
	AptYv+kPK8/BcdqYu77mHdfTBkouMlvmd/ISE6FvVOuYJAYUUVQJYoJypp9EaPhShocsgyCK0nv
	MloKwze20hGlLriZHYAqQX71bbv4F8Xn8bFby
X-Gm-Gg: ASbGncuKpjKHpw8qX8KNW8dbAKHFvUVbT6NOauSE+dzyfL25pYkSgJQlledgEPRNAHU
	dg8zrqZKO3vU8ObQm1QH4RG0c6DPRIbXio1t1lBfS7t6BCuHGPv5KSDIEXheTkm+j8ACctgmGP1
	jIWuS7Ypv0Z0wYUSnuxqm1PKsf5NA93gaYfl1yEoZn4GzjOFTHR6/ad4hXw3qXSEa/bT+39k8S8
	aZUuwyiApz9B7uD5wuDYKOWdEXGwpNdqJsX8wNNWK5xwpT/5wW3YAw2HHb4Ts6EqDzRiSKWevw=
X-Google-Smtp-Source: AGHT+IEGGe8qqwvW24SEdYwXTYYiR9/8Ovszv40QtV6Uz0sZp4dA/iusTgbhW+5v1ezEliIHc/QmjsH7PtKEe5QYB4c=
X-Received: by 2002:a05:600c:4753:b0:46e:1d8d:cfb6 with SMTP id
 5b1f17b1804b1-46fa9af0621mr6629455e9.19.1759873285926; Tue, 07 Oct 2025
 14:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+V-a8tWytDVmsk-PK23e4gChXH0pMDR9cKc_xEO4WXpNtr3eA@mail.gmail.com>
 <dd6d8632-7102-4ebc-92e6-f566683f4a33@lunn.ch>
In-Reply-To: <dd6d8632-7102-4ebc-92e6-f566683f4a33@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 7 Oct 2025 22:40:59 +0100
X-Gm-Features: AS18NWBIGrpxoO92vBlA52qdgMqyrtCpNogEWZ9JBsHuN3slwVfjtPUrIuePow0
Message-ID: <CA+V-a8v89b0Mg8ZX6nabNV8bMEan3EkonVhhHCb4t1GNxaxqrg@mail.gmail.com>
Subject: Re: CPU stalls with CONFIG_PREEMPT_RT enabled on next-20251006
 (Renesas RZ/G2L & RZ/G3E)
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Oct 7, 2025 at 7:30=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 07, 2025 at 05:40:09PM +0100, Lad, Prabhakar wrote:
> > Hi All,
> >
> > With CONFIG_PREEMPT_RT enabled, I=E2=80=99m observing CPU stalls from t=
he Rx
> > path on two different drivers across Renesas platforms.
>
> Do you have lockdep/CONFIG_PROVE_LOCKING enabled? Is this a deadlock?
> Something else is already holding the lock?
>
I am using the ARM64 default defconfig with RT_PREEMPT enabled.

CONFIG_LOCKDEP_SUPPORT=3Dy
# CONFIG_PROVE_LOCKING is not set

I need to check if it's a deadlock, but from the looks of it does
definitely look like something is already holding the lock.

Cheers,
Prabhakar

