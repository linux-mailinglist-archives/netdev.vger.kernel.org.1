Return-Path: <netdev+bounces-250899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8BAD3978A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5224D300AFEF
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653A533291A;
	Sun, 18 Jan 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHx2FsHX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2222836E
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750813; cv=none; b=PYBmop2abgTo9i3NGBdnjGHlSb2PaV7K0LQpAUiC4iPU9sBg+gu5Y3zmVrFM56OCoQY2FqV1EHODbqfad+JdYDvfxdRlV8A5lA/fiiL19cna9H/NwSR7k/psdYq7GzG4ZLLDCmgMXcIGnQRsE9IJgl4KY5BCXXbLHSx+E/TAcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750813; c=relaxed/simple;
	bh=fa1gz/HKm6O5cLz4U/b6OZOC9lZvrZiBiGt0N+CAGbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dB/jJGkg4Zl/muya/1Oj+JXs4OWmEpvX5S9AWUVc5zmMW8mj1XIVamQ/+yzTmAiSfeBX/wClGnl6xVPXpLppMyC7t3I0CS/0bGQiujtVT8Y528D8iLeBk2oCGbSglG0vEpnOPBakcFAymK6/51L5XnwVnoPm3mFruSUyYq0M7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHx2FsHX; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-502b0aa36feso10786541cf.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768750811; x=1769355611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa1gz/HKm6O5cLz4U/b6OZOC9lZvrZiBiGt0N+CAGbU=;
        b=aHx2FsHXQd3kwh3+8fp1woUOetceFktkrNdns/rlRFX7Ne0L1zpLM/vLTj5W4JcSRG
         0hGeBQxOK9SWzGGgOuAjAxyzKTb5EpSaXRlIrEgxpDD9ux+3iRPhWY+dP1y7ObNa5m68
         4sjX4Ii99ReHdTPEsj8E9dKAvpkanT/u571Xkr1zU7B/vkHG+lAAG8g8ZPuYy8HYui51
         86TC71OURLOLIFT0dddnYvsX/0axtr4oIEO+9oYa5pbpDMbjkm3ZFJ6PEr7mnbVgQbaP
         Vp3R90yMlkMCWGUx6aHBYaZoxOvQnZMRqkpqbQorh88TEKBFzA8DHG1T0sAY4g7lIDeQ
         8uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768750811; x=1769355611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fa1gz/HKm6O5cLz4U/b6OZOC9lZvrZiBiGt0N+CAGbU=;
        b=vfrS+mPi1hNyMASQRFHEYMPRfzVYvhtQbDm8RcL0y8ygJeH4PN638PJusQ+EXQbSW3
         6b+HDJivc+1RT6jBGJZKg20camaQox7o+b1UOni6exDbxNqH8NqYn+qo4vk0wzcrglYN
         OQ9y6s+/EZwTfttL+izquYE3xoEYMzKV+allwlDHIQY94gjiyPOFlTWPudDS9Dji8r+r
         eTO7KCMN3j7RCcsllr226DNj6BpGhac5DxGfUM+xy+KfbeILFLMVM5pgjoOpi2Gcmct4
         vhV7mjXS5QRnfBLCwNAGOaJOtwiqWBUCdxUmwGokwoxjEbfANXD5A45iIPXoyVL2P5sW
         QjeA==
X-Forwarded-Encrypted: i=1; AJvYcCXxT6Kzpecuu915NC8WhH8QFiHiJsxYimiNSxm30n98i5X/VcDV1s9Wd6xz7xYqbi4IRaXlsOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrzPtvtPnls5VyiSZirhLvTirhRuIQ0iE/V/1p9jojtZ6Zx+E
	DWB1NJY+uBFDhbPLyAY0g7NGQW5ZapIkyC2y+nHf0peiC6MQroMrNgCCAerwrQyvjyCSkPNA+q/
	w8z11NAKlYxQtkafn0RhAw9RZR0FssAZH7v3XtCDv
X-Gm-Gg: AY/fxX46PzMTYDR9Qtofl4IR1okYIIyZj2XYj4ZDiCuPXOviI4YhHX3bgtQ+g5ZTXt7
	Q543PMh0xAJoEnBH00MBiE2UKCni4F/bQL4ylCvu1zyukxOhcif0lJrcEyak7YsUbJrMHuDHlSu
	wWVq5Dd0+RrCYH1GO7+99drofG4T0w1mmJ6Nku1Axv1DC+13Ngfap1tNASujrUMkcXJLfhmR99X
	bKOubm4AVLP+ND+6T0vHVgnlTMgk5yR4SouZXvNqNDwmYLfljdUR6GB0vC/Ykr4HGDJcobX
X-Received: by 2002:ac8:7f0a:0:b0:4f1:8bfd:bdc0 with SMTP id
 d75a77b69052e-5019f912733mr196508001cf.39.1768750810630; Sun, 18 Jan 2026
 07:40:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118152448.2560414-1-edumazet@google.com> <aWz89X0y6UNH59I7@strlen.de>
In-Reply-To: <aWz89X0y6UNH59I7@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 18 Jan 2026 16:39:59 +0100
X-Gm-Features: AZwV_QhMpVmXiCR59uw8xjJwtnGFB02TAzx_DglFXkQfqFXIxwTcKmzoczfN5Ro
Message-ID: <CANn89iKqeiiA_-1otsWj8=fLc9s4LPgrN9RNsh7iBkuGDaf3cQ@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
To: Florian Westphal <fw@strlen.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Nicolas Pitre <npitre@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 4:32=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > -#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> > -static __always_inline
> > -#else
> > -static inline
> > -#endif
> > +static inline_for_performance
>
> ..
>
> > -#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> > -static __always_inline
> > -#else
> > -static inline
> > -#endif
> > +static inline_for_performance
>
> ..
>
> > +#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> > +#define inline_for_performance __always_inline
> > +#else
> > +#define inline_for_performance
> > +#endif
>
> Should that read
>
> #else
> +#define inline_for_performance inline
>
> instead?

Damn, of course !

