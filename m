Return-Path: <netdev+bounces-219033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C1B3F743
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39BCB4E36AB
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5F42E7BC7;
	Tue,  2 Sep 2025 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSFsEhZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5192E7BD9;
	Tue,  2 Sep 2025 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799973; cv=none; b=XCV8mth5EHb3vuamkAHHYkrll+NGRgJKlvvn/g3Us7M6dWtKT2Ay9Ot2VS4+JKJf2+7VJUsZXizEPGlzeSXk6dHwYnEIqWayle0MyKnb877h4+P1iS8uD/sB44xNL9474u1MTFB+AKftuOtNwp3uMNZEja+UAEcGO/fvXeUzDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799973; c=relaxed/simple;
	bh=UetU6Q0k6KRv6T5Ge8HNc+MI7mAoKHwLvsekh+TGmJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErKIdLnq3GR7fvMwNBMWz5699bjkfJtiagVAIuBXd+TPozCape0ojJuNhhZRgBOvuZ3iRKAUJxjBwJyeDp8KAT31btusMl8UmSUIUAeQG3IMNoflg+VbL9+w/lRuZGnCxGSy4VfhT9zX6BE1TAjYzc59NVseUcXMKnFb5C5LruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSFsEhZL; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-88432e6700dso40102839f.3;
        Tue, 02 Sep 2025 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756799971; x=1757404771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UetU6Q0k6KRv6T5Ge8HNc+MI7mAoKHwLvsekh+TGmJM=;
        b=mSFsEhZLgMjim3oiFNWw9y0BVx5Ck2VI0vYaJsmN9AwPBmcyKNVDb+Ml8M0IISNzGQ
         beqjW+nLlkeYE27nhHzLnrrwo6qcG8uPpTOtzRzm/Wf13wKA3S1F1bQqjh3KaG1IPasy
         bymTwki7hc5bskXczcSDNkdq/R2ir6g3rYA/us2WY0NoDDtb1XEmmpb1dRVidVz9b4aq
         vzoN/IXbSFn0Acw5tbFKJKgi11/gf5YgXyLBf9YT70+1G49ex9jU6dE62mUi+vsZbYtm
         hkinDhtqlyZvKbgbtK71EUY0/dztMaIgp3PH4sg/96j0xof4MNvBXZFiBdV3ZPMzlVvE
         UWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799971; x=1757404771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UetU6Q0k6KRv6T5Ge8HNc+MI7mAoKHwLvsekh+TGmJM=;
        b=cVgZBSSsY2A2d5q0rO+L+Ev8/YQpEiKBQahbVCTEUF0Ima64WFq4ICC/vm+McJ23K2
         ZLMgR1qRkMPyUzkk+MtR4etwLMkt+g+yqyp73RehzjwkJp4kLDABXLXJsyybd3HHHih8
         6o3zpOissfWlslvMKCiAOWCtP/p7g596HXRmYa39C+N33a62Je0dxh+zmWa/cmOviUsm
         GEP8TbtlYtKfyZ8+tyMJ5Wer9Bhz3XMhRTu+lvMlPiCwT82f0QWt3kthAB1Uz/Dmu1Dt
         WAt2QNMAWdDlvXUjFLIejA96ecfoYYgKW8RVkBZAm7jTxvAPbSVDpBmUQ4SINt/i8zOg
         HfGg==
X-Forwarded-Encrypted: i=1; AJvYcCUNu+9Sz6OQjpkjGAZCMMKDF/J05J6lxdSyC/R76qeHBJaBK9+vMi4buHeBbJhiGelZbI2D2mJtfR5f2GM=@vger.kernel.org, AJvYcCWRN4a9Rxt/o98n7P9/OVW+nO2vB+uILswW+p8wAXKHmgUWK31s/XH3gpr3BmMTvTzkudjBImv0@vger.kernel.org
X-Gm-Message-State: AOJu0YwrqyANeHViI/pFeZcB51HWBlXEWGqt9SgvXXate2sqJ8Rg2GKY
	6eT3MBDN0vlP4DIebNkgahpy+5KhMBXBUZrPJaY5deQR1W/wxBPeCyqXuB27etyJihv8iR+vl9Q
	q1lffWB3ueje/Z3J260udOp/QfAZT13Q=
X-Gm-Gg: ASbGncs/Yh88zbjajxRTswvDMWrt1qXvh6BqFsVx6gY81YmCRSrYDj9rY0+M5XeK6u1
	/7i1xr92A76/f5ylqri3YGYc7w6buJVg3qfmwmJijeTY/fz5qlmCpEABPnCjJhND+z0HhhxbFbc
	hPocJ/LGUiSB1T4mB36sWHEx/nLOn3OrvTNkiV2Y/iaWl0wtpmPc9mkjKEIB2UQzHIjxH4x4H4L
	/aDwUtPUWvd5w0uKQ==
X-Google-Smtp-Source: AGHT+IGEkf8gg7Ow1PMGLkorRV34nEHMquJJIPNm+rQ3E2LGYOSocGgbgKW015adiEbMvaroPzAP/00jQqW5+KXJsGQ=
X-Received: by 2002:a05:6e02:2165:b0:3e5:51bb:9cd9 with SMTP id
 e9e14a558f8ab-3f400674ac2mr211654925ab.8.1756799970758; Tue, 02 Sep 2025
 00:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902022529.1403405-1-m13940358460@163.com>
In-Reply-To: <20250902022529.1403405-1-m13940358460@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 2 Sep 2025 15:58:53 +0800
X-Gm-Features: Ac12FXzkrriW9NPsuU0kv6Gzb7sSOm_lvfHS5UbJoKxOsdiMQSxWaqEft8y53B0
Message-ID: <CAL+tcoDZf2RC7Y+vfmUv73Mi+PJSCgzGAieekpTnz92V4dBfWw@mail.gmail.com>
Subject: Re: [PATCH v5] net/core: Replace offensive comment in skbuff.c
To: mysteryli <m13940358460@163.com>
Cc: willemdebruijn.kernel@gmail.com, aleksander.lobakin@intel.com, 
	andrew@lunn.ch, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 10:26=E2=80=AFAM mysteryli <m13940358460@163.com> wr=
ote:
>
> From: Mystery <m13940358460@163.com>
>
> The original comment contained profanity to express the frustration of
> dealing with a complex and resource-constrained code path. While the
> sentiment is understandable, the language is unprofessional and
> unnecessary.
> Replace it with a more neutral and descriptive comment that maintains
> the original technical context and conveys the difficulty of the
> situation without the use of offensive language.
> Indeed, I do not believe this will offend any particular individual or gr=
oup.
> Nonetheless, it is advisable to revise any commit that appears overly emo=
tional or rude.
>
> v5:
>
> - Added this detailed changelog section
>
> v4:https://lore.kernel.org/netdev/20250901060635.735038-1-m13940358460@16=
3.com/
> - Fixed incorrect Signed-off-by format (removed quotes) as requested by A=
ndrew Lunn
> - Consolidated multiple versions (v1/v2) into a single version history
>
> v3:Due to some local reasons in my area, this is a lost version. I'm trul=
y sorry
>
> v2:https://lore.kernel.org/netdev/20250901055802.727743-1-m13940358460@16=
3.com/
> - Initial version addressing feedback
>
> v1:https://lore.kernel.org/netdev/20250828084253.1719646-1-m13940358460@1=
63.com/
> - First submission
>
> Signed-off-by: Mystery Li <m13940358460@163.com>

IIUC, you've received an explicit NACK from Jakub at the previous link
https://lore.kernel.org/netdev/20250901114157.5345a56a@kernel.org/.

Thanks,
Jason

