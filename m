Return-Path: <netdev+bounces-184347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E9EA94DFC
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 10:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FF13A5E15
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82020E03C;
	Mon, 21 Apr 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxVcWgr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9296202C44;
	Mon, 21 Apr 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745223669; cv=none; b=VJaIevEYjQEcSNjtzVLGHYVr2q15159dpnINseLXY03G4He6JlgExm7tup3h5DTM0kFZp2OVpZRjqUFI+R5tcqvVlDKkR7e6sbYbTK2+HmxQd6SjlBNTyWwllqGe0U4ivxUcrtmM0BxPrcjJxc2nRx3PxwpN1OheGZ6Q03K3wbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745223669; c=relaxed/simple;
	bh=6xXvX5zsd/VN8kioDZTWsUfg0t+oDX1X/vjarSB2Ruw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPW0AQQvKgusRPlyZuHdQy2QV9kLM2p3wqa+mAx0x0wIwVQ4+VR7DfovFm0IAXJ5q0wdBS0Y7n6ROYuOeaO1I+0pT6wSBfMB/aKdyc4Ly9pFf8wVQqZaahTJfwqbzLK5ry/GKTssxreBTWcHfOO7wZfoPaFluuh2Isqd3DNFzKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxVcWgr2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912622c9c0so429767f8f.3;
        Mon, 21 Apr 2025 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745223666; x=1745828466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6xXvX5zsd/VN8kioDZTWsUfg0t+oDX1X/vjarSB2Ruw=;
        b=LxVcWgr2YEBzNnmmiQIkdACMhZFLjwRE7o0XfHDKQRFqKx1SQLj/TvYDG4guKMhiZz
         pdrHR6mi8u8n6jJFDKzLkDD7YxfYbKpMoUt+gP/tXJHYa39UgtBWPGaJJChEvoa32elG
         hYZwOGm4HZNfui2qD8gxLJxHQiKvc6ocVt2DNWhQbFspDJ8Glr4c8mhnhC6lHjTGAgf0
         srUbSuXMOvZJBubyynk37uuaS82biCqk3dpv1SLg7kjzD3mKe46LJAtJdRqY0WQvBGme
         BxsIsG4j8L397fe2OUgT7BdXdK6jDToWV3M8lmUMsF96D8B/rS4sRXX07W63KC+82HVB
         zkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745223666; x=1745828466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xXvX5zsd/VN8kioDZTWsUfg0t+oDX1X/vjarSB2Ruw=;
        b=Ou/eOD7IGhfyeZxy2wBGLKExJmoVkPVSZcIfNhMoXP1Fn3usaP1NvDVsb3iSUZ70Ty
         Nc34tjIXNh7X3q70cDuX1Fzf6udID3/Xh5e4G2AAqSdS+iVeRcvZgNFvmtXwA9L7rA5i
         mNMVWDjEWrYyYnTjjKKnTTlgy40uGzCh0bisFCeW8g5wCooxwTr+f2/PFbwQjRIPzyPY
         mNVJeuZD4dpm2IbgWEv3+vD6q4V6fRWdjLVhQDG38s1EsIwnfmVanv/FFUgoZYd8DXHA
         noZIOM1nd/i+WADjZRHOJNyUzlg5Y8sBJD4nPi32Q3OnV8AyvP9Dojnh9MlNVWcctv/4
         6z7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIpX3JSp8RglDIpjPtfI8mTuC3cca9z3e/AiX9EOj1CpaoeTeivxOrQlI7v3UOJdOH7+mSWqAoUWit0WU=@vger.kernel.org, AJvYcCWo0KmAk9YorYV6hj55vMVSe7pe5ZqbjsBk7Xqzr2hH0lPGxRapAvzj/ZpTTTphJhLobM2/cNRP@vger.kernel.org
X-Gm-Message-State: AOJu0YwTgNcb5iCXJ0kajHObNZ0ZI/cgjjTcbN3+Nx8EIv26bEuplWqe
	PfU9mDSQSVjtUjVaN2jZNuBBKsDSQiYQsllugFUWFCUDaV4b2SkiqpWpFVECjnMy+bosbI2gvJu
	NUxFw8dPEmX9QXxLtrzHqh3DFqk4=
X-Gm-Gg: ASbGncsMAUF3n4+jXbmKT7LjtceNS9niT8eizIxZi2q/+gtgAvMNsKOA4/VL/N/jBou
	9BXFiZ3KHHQ7/Gw2ScSgZAQdwdNX0f1Ft/m219+oiUl8WlbjbMLjvSNVmvD3mKEKpfp9RfNqlyM
	Wi/gsDUyT4I8gpDYF4dvPk91MK
X-Google-Smtp-Source: AGHT+IFJTMIPprGX73kXkBg1Zi1q8LQ4SFbZCooejQCP7CnMft+S8y7C6HGxshsN6hmYf+fTgImfhnpSKW9lEBYgelE=
X-Received: by 2002:a5d:5f8d:0:b0:391:277e:c400 with SMTP id
 ffacd0b85a97d-39efbaee015mr3201895f8f.13.1745223665978; Mon, 21 Apr 2025
 01:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324125543.6723-1-crag0715@gmail.com> <278ceb1e-a817-4c63-9bc9-095d0b081e50@gmail.com>
In-Reply-To: <278ceb1e-a817-4c63-9bc9-095d0b081e50@gmail.com>
From: Crag Wang <crag0715@gmail.com>
Date: Mon, 21 Apr 2025 16:20:54 +0800
X-Gm-Features: ATxdqUGt2ieMFkZsp6EaR1Xawm5go5f2rFR6PlN7a09rCbPREJ6Vdr6DyVaX9wg
Message-ID: <CAP-8N0iMW_KF-GG0V69Ugzf8TTm5CWCZ+4n7uODssBb6A9aKAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] r8169: add module parameter aspm_en_force
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, crag.wang@dell.com, 
	dell.client.kernel@dell.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Adding module parameters is discouraged.
> Also note that you have the option already to re-activate ASPM, you can use the
> standard PCI sysfs attributes under /sys/class/net/<if>/device/link for this.
>

How about adding a quirk table for the matched DMI patterns, allowing
the hardware
makers to opt-in ASPM settings in the kernel segment as an alternative
to the PCI sysfs?

