Return-Path: <netdev+bounces-198145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B133ADB669
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DAFC7A4AD8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC52673B0;
	Mon, 16 Jun 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIykZ2so"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5214A639
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090513; cv=none; b=i45rsfhH5TnMUDrDuzPFdG5JgHuqEK4W+iRbuWDy0AlHkUXBUeS7u5OeE9lCy38X8b6oyP7C7G4t/TnjmEpdL8MrDOGEsXcfSvZGlpSGwIrNyUDoU2d94pJ8t65AAsrmmS9lJxeZJH7a8Ue30yC4DZuVzvKBsEEjZQEE2jDYnb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090513; c=relaxed/simple;
	bh=F6Oo7MSRktRLrgUBCZ+ivA+8WxfXvoMDKEId5Ya/CmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkLRKkOP6h/arW0QN/3hN1xR58REOfY3jLrHsk4vGX5jz1i78FyL1exGmrizTt3evwjY+i+qVkrcQXiXCXdWYLRvLqG/q2whob1IjAU5yaq+/nSfkM94Ng0JQDaSv6mcVj6Jdej1O6XpSYRGFfeDiepOq9gXiPfVMdmlHAKGIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIykZ2so; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so2905710f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750090510; x=1750695310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6Oo7MSRktRLrgUBCZ+ivA+8WxfXvoMDKEId5Ya/CmA=;
        b=fIykZ2soJsouRr0DkAP/8FLbGKGVrbDHeaBJD8smejvmYusJJbiFMv/3Puwoc+/DdM
         2SHQpYtkAQGO0XWo8JpLw3KhfXRzUBC7jJeBwqaC2lNO0LPVoiZcHlvLPTn/P62S/Oo/
         1u7yECMbbyXsaiEEuMwxl1sYNJcsAPLST8A10CinzXoMj0TkNGfhPj3OuaAGMVlVStOs
         8HschH9uGE1kewYGr39CihYmBwa6lKfWxSTY8Bec1I1TldCcF5fZ/U/XpMNZZQUqTUlZ
         xFDRtXfrk9d6FAH9Fdu8FEAOt398WWOVt7S2Yzss+s7V0/NelNFrMi+8n8SXxcmP6LBu
         tO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090510; x=1750695310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6Oo7MSRktRLrgUBCZ+ivA+8WxfXvoMDKEId5Ya/CmA=;
        b=cwW8y2hSkDpG9foU8MI13jj/vJ7nNm4evBUmkjXzhJx1zpbT2y8hD/BQHcpj1vdXle
         U0TiFkpgMc6Y7A5GwNHBAeyMHPy4QLKNPcI3gdD4OdgH/yOdr1aa/NoMrNVKQ+3JpBtk
         +30m4jw5fp/xIP3HEiko7onF/R1JaHjUCjFsqNtYdn3cnbA0Y7nKhUkHk4IQEv9tOHsL
         n4eKos39CO7uhD6/k4n9Q9Yxb+34fYIuKKInmItakoWmx6zRB1Xf6guLYn4o0oYKbhVo
         ba3oYfJ9KSTSU3PmMrOE7nApS9AVafmJzsNsGC4ikEvWRbJCRgDexay9ctqKjbORwj3h
         EhrA==
X-Gm-Message-State: AOJu0Yx6H2UyKLl5BkCpd4mrlS1hQWMlgd0QUxXQXdEEuV5MrtpkVTEv
	iVAukIrSLQgC5cTq6hUqoWxJpmU2a7ldNHHmxQKSvZOn6n99Gx/4zKDl1UJYA2OxfycBXET/a1y
	Dbt/VqtePLu1yvBsihORXmtkpBMVlX8Y=
X-Gm-Gg: ASbGncsyTDXHcFZFdLF0Rn8zKTTgnEPZt4Ecy1vG0Pd3R9+HI8Dm9aPMv/I/OBYOY4l
	35yEiAITiAGwfPsp3okd9kxjIqvpailew8Q2QKIRV5avXfh0s1iIZFSDxSwPx8bs2/6zNX21Nht
	J1ArNT1JliWxMu8elKjEA/0wK03M+m2MBWwn6M+BNcmLWrvlap1BeSWoEBMlNnfSXg8++ZN0A/V
	o9X
X-Google-Smtp-Source: AGHT+IFw6HPm4vLZMXCQ2cK51YwrRRHvhLIRH9jxUwuSYACN0ckjKjpAKEMvxH56MpZZ1fw8DTCmw8jVTCEeDuJVt98=
X-Received: by 2002:a05:6000:4716:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3a5723aec40mr7007020f8f.24.1750090509802; Mon, 16 Jun 2025
 09:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
 <174974092054.3327565.9587401305919779622.stgit@ahduyck-xeon-server.home.arpa>
 <20250616153438.GE6918@horms.kernel.org>
In-Reply-To: <20250616153438.GE6918@horms.kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 16 Jun 2025 09:14:33 -0700
X-Gm-Features: AX0GCFumCfPBXEqSTEl9S5YNWo3JJ5j8qLpU541MP-bRwxG-glXZQQ3jD_vwKfw
Message-ID: <CAKgT0UfEkGiAu2mO15yaF1HRdRLsercm4vJsyi-xg8Je0c_i5A@mail.gmail.com>
Subject: Re: [net-next PATCH v2 3/6] fbnic: Replace 'link_mode' with 'aui'
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com, 
	kuba@kernel.org, kernel-team@meta.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 8:34=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Jun 12, 2025 at 08:08:40AM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > The way we were using "link_mode" really was more to describe the
> > interface between the attachment unit interface(s) we were using on the
> > device. Specifically the AUI is describing the modulation and the numbe=
r of
> > lanes we are using. So we can simplify this by replacing link_mode with
> > aui.
> >
> > In addition this change makes it so that the enum we use for the FW val=
ues
> > represents actual link modes that will be normally advertised by a link
> > partner. The general idea is to look at using this to populate
> > lp_advertising in the future so that we don't have to force the value a=
nd
> > can instead default to autoneg allowing the user to change it should th=
ey
> > want to force the link down or are doing some sort of manufacturing tes=
t
> > with a loopback plug.
> >
> > Lastly we make the transition from fw_settings to aui/fec a one time th=
ing
> > during phylink_init. The general idea is when we start phylink we shoul=
d no
> > longer update the setting based on the FW and instead only allow the us=
er
> > to provide the settings.
> >
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
>
> Hi Alexander,
>
> This patch is doing a lot - I count 3 things.
> Could you try and break it up a bit in v3?

Actually I need to clean this up a bit more anyway. Looks like I have
some text from the earlier version still here as the last item was
moved to patch 4 I believe.

Since it is mostly just renames anyway, splitting it up should be
pretty straight forward.

