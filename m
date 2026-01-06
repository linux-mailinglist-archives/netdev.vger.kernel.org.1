Return-Path: <netdev+bounces-247343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EFFCF80D6
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A081A3019860
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00F63218CF;
	Tue,  6 Jan 2026 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DylaO6ER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A426ED41
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699163; cv=none; b=G3GIvUtCAokjRR9gjS0znsR2b+/mILWsaV1zxmN0HR+xnqjUiAMtMv9iBYFnXdlCtHNWlhs6+6coPNB2MrYupqRnRetuajWAibLLPvh7Bze6Hfqhqf8fGZTY1WStoyEk4WUb3fLyPwYyCZfeS0JiPAOE+Qdd2S67M6abYObnZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699163; c=relaxed/simple;
	bh=ROnipINx8zOAdAYzFa4zNtkeHxHNss/1pAqZSsUCb38=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=jkEDtQJJj2p/eyKIeSz+ZSL1p51tnbnkTSGWlr6QKtnOwzyyf/JkuIqdI285zSlUR+GGAktUEJVeeJp0JVpaXFOYecWTzv1OMGTtWeGAmG377/jccQtfKBqFjpPEAELkt+Mn+4jbl/P7gI2K+uy82MKdVOJje+Pxv8nKONA7vhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DylaO6ER; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7f216280242so799501b3a.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 03:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699162; x=1768303962; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+3KjH60Dm9rvQ852XVz2fhdFkdzy05hIdDbcSAi/v8=;
        b=DylaO6ERohEj/Ey/HIj9TPfA+MMg6dDny92Y/618DJDjSjCcIdTt1dSIcaceN29CUa
         B8vlunwG73d4YbCLEmnrZdPSeUA4ArwlUQoyfeMeO694bVBlyQFAezI37qYhWU3JYzMc
         iQTI6HLoACapmHQIQogp1MvMKLJUpOLxFlhg4WqOpnNsiL688jT712C2hYaz9fxg+9KY
         dCLaR5g33fZjYabfIHpcoUa/N/AdetzQQZL7hRpKkt/w6afryRMZFaJuw+UjW+s78YJh
         UuWzZqUoCzRTKWNUbjtpIXAUJYinu8kLuy5Oupe+gVc9hujLk87DP0LKp4M+3dJtt57k
         DwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699162; x=1768303962;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+3KjH60Dm9rvQ852XVz2fhdFkdzy05hIdDbcSAi/v8=;
        b=MsiYwnZM5ZrH68TjPVRWgIylVAiLmBbT+HEwVj5/fMS18LdlCEGlEGShgrOd/FmgSm
         MC2cirYAoI1L2P9LPjl4pC91DhvddudlTE2GbgiygbfhksigGuRk8hY+eW1Anqkp3gIT
         bNecP6tmezNmT+Q4mOBWKkMTNE4Cctj0SMeLMxWRev1UtY4yrbGazq7pxaPoIDcIAGiS
         OL0R3men1qqPkOMOhwJqBlD7fiJEUyrR3YhmENtmtcBgdc+kfmykUAwTLF9eJ+BGce/Y
         vtqdLEVAH8FLAANasfXZRrFFg29iKdZZF/OYmiD7Xw+5M7UAR+fBjxXxQXyrnzl6Kik3
         3YKw==
X-Forwarded-Encrypted: i=1; AJvYcCXvV6MF4zIxgG4z5vWpABw68NiYS1DoIRfoiDfMUO4/ZSStBjSb0LMeKDaLFmf27EDCfMnEXA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMZqr8H4zDzUiHWhCkTk87b5VuiFQc9/k9pldJNTFxnZuCPyE
	K/JZCOYPA6UposDG5PV6Q2hBV7Ta0s9H8LFrgq7SJuzCyAQlyKg8fcf+
X-Gm-Gg: AY/fxX6X0rPmT1hfCWhimBfr1jZ73cwMH0VVoPrNcio7iK4MVhuyuUycvYc6lViqvW2
	9pFEoTRgBodbe/HC++C2Q5PeJRH4WI5Aj00NZqi/T4d3PyetJhjzMit1QI+Q3JYZyEidgXz3RXj
	gkydAWlZ75PdUzhqP4IKPuedWkpRGrAEoybhrfwsHSyfjkL7xurTo0NMMK8ectZx+sJQR1pGEXb
	JdlBg3sSVv3tordF8ZZmrCq9jNzJ7gVPcdVjfpJj6+NWmRezTzROkN3TL8Nn341Hj/DJMGeVdMg
	lnGv4zVN9mMja9foFkFytcNl97WVe/xNKPnz4njlRUPt3EejYHMpEIazcT0z9Adfgqtvw0oS7wd
	K1jeVI+IkQvLMzdXNRy9n69jbEPy9XtAUkyQwHddCF8jP5YH/saoFdKmRhI27L0m6rcz5UpPLln
	ijPm0jcbkDD072aHk=
X-Google-Smtp-Source: AGHT+IHx+0kZCP/PYQGYanijnE9StrBuMNGk7/pymjAj7yNoOv+s4Hn79S0p3064GaUlLq3azFoM+Q==
X-Received: by 2002:a05:6a20:6a03:b0:34f:66ca:60aa with SMTP id adf61e73a8af0-38982a56f71mr2272659637.6.1767699161780;
        Tue, 06 Jan 2026 03:32:41 -0800 (PST)
Received: from localhost ([61.82.116.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cb5352268sm2180162a12.0.2026.01.06.03.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 03:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 20:32:37 +0900
Message-Id: <DFHH1YC7TYP5.NHWGAYXDE0FQ@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Yeounsu Moon" <yyyynoom@gmail.com>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net v2] net: dlink: mask rx_coalesce/rx_timeout before
 writing RxDMAIntCtrl
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260103092904.44462-2-yyyynoom@gmail.com>
 <20260105165854.104e6c1d@kernel.org>
In-Reply-To: <20260105165854.104e6c1d@kernel.org>

On Tue Jan 6, 2026 at 9:58 AM KST, Jakub Kicinski wrote:
> Realistically IDK if this is worth it.
>
> Paolo suggested in discussion on v1 that error checking could introduce
> a regression. If we take that concern seriously we can't change the
> (buggy) behavior at all.
>
> That said the overflow is on frames, for values > 64k and the ring is
> 256 so IDK how high values could possibly work here in the first place.
>
> Given this driver is using module params to configure coalescing I'd
> just leave this mess be. If you add ethtool configuration for
> coalescing make sure to correctly bound-check it.

Thanks for the feedback.

Understood. I'll drop this patch rather changing the current behavior.

If I add ethtool coalesce support for this driver, I'll make sure to
valid and properly bound-check the values before writing the register.

    Yeounsu Moon

