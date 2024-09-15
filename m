Return-Path: <netdev+bounces-128389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4B79794E7
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 08:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3647C1C21559
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 06:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768FD28370;
	Sun, 15 Sep 2024 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CwUs/K4F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425817C69
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726383167; cv=none; b=rCQmeEY6wmnm5doLnAvQHL2pt/j5Z33JkCA5NyLbX86bPHxdzsVEzYQuSJ4hANzvujGpRMkA6eKD+d4XXSNz5smCBGn03/nqAjmsvdas1oliOBSFToPKx+levXqGskQuhh2R14XlJDQS4nsBv2/etwKPlCaeIe7jXUPW4O+K88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726383167; c=relaxed/simple;
	bh=Q5sEALuHPv1QRAJzo37KKiB5cC7Nv0mXzbDU/st89ls=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HPXMg4mF2jcxUU3FCudwTr2qHUTx7ClHgFxABy3nLQgS9TqKSpXiJPZ2jrOVg5ywOBU6TXSTSAdKeOKEbAZO4rsD3w9OGgvEPDi5pUYf0DyN20aTlPOKXh6ZksJOBixzDYHCSm1K0jnahn1AO10sYOilqN0sXcU1/VVbfS5EqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CwUs/K4F; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374b9761eecso2795104f8f.2
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726383163; x=1726987963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISzocak7CfzsdizmFWg8QfL+4cD9AW1fcVI3tqhKr/E=;
        b=CwUs/K4FVrT6mA3mUNHM6skMZBl/bUckQXR9YQqnP8dU/s44i0E4eULRknGqj/c8B5
         OXAqqRgNeR6Ob+hM7RWcPdfEYfzgxfEmE/vncL4pjnMbDE8uzysYuyRF5/MNE50Kt+ft
         5IVsJ8Vmc/leepsJIWL1nmBVcd2utSGPkJgBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726383163; x=1726987963;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISzocak7CfzsdizmFWg8QfL+4cD9AW1fcVI3tqhKr/E=;
        b=PeEFH/eI+D6w37ASc56xDXxkcZB+3m8dlmHdlEGUEyJOMruWb1mIwHSAMl/XDPqBHM
         gslRjRfrqeWSR8ob1RN4feHDhxp2TD4RVFSeMH8NwBsHSl/WENXoonj4s+oLbdM+fiY3
         152NuvqBgbTmI1hr31mDTEIihZ0bztyUykLlH8JD3S6MX/0KBeaBuge8jAa07mb39YFd
         svnF9DHG+SbrXYglHi61XYKBzE9aVOl7mRpm6M93AydPsbNwvVjA5yVKh0emTARjIS29
         o34CuQJXjg+4PEEiVgjmH2pnyxNyZa+Y5vCimpQq3u43gFLNkCb7MSR+A0zFA5EY/qUX
         FD7A==
X-Forwarded-Encrypted: i=1; AJvYcCXh/oCU8ZwFwgFCb+Ru3L3a5Btm1qFpsdFcfRL3fq4EF6u2SKgYbdPd8a77+GlcQJOPFO6Pbzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYG/n01/s+DUA0a3QMRjZu0b7swp6zym2Fxgb3DlBDVSjIw0aJ
	yHORHtDwIkGF3AKKdeej8476XULa8K+O8n0EXe76RvIelJeb9qv0B8SDpHjNpw==
X-Google-Smtp-Source: AGHT+IH88sEKQpcRpCxC3Pmitv3AYGQkPFoJMjKBtTDy2NU+mjIXebpVIEbFql2nmHL7yxkWVb65LA==
X-Received: by 2002:a5d:6743:0:b0:371:6fba:d555 with SMTP id ffacd0b85a97d-378c2cf40bamr6205944f8f.18.1726383162728;
        Sat, 14 Sep 2024 23:52:42 -0700 (PDT)
Received: from [10.229.42.193] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm3920343f8f.30.2024.09.14.23.52.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2024 23:52:42 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>, Ondrej Jirman <megi@xff.cz>
Date: Sun, 15 Sep 2024 08:52:40 +0200
Message-ID: <191f47476d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240910-wireless-mainline-v14-4-9d80fea5326d@wesion.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
 <20240910-wireless-mainline-v14-4-9d80fea5326d@wesion.com>
User-Agent: AquaMail/1.52.0 (build: 105200518)
Subject: Re: [PATCH v14 4/4] wifi: brcmfmac: add flag for random seed during firmware download
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On September 10, 2024 5:05:50 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> Providing the random seed to firmware was tied to the fact that the
> device has a valid OTP, which worked for some Apple chips. However,
> it turns out the BCM43752 device also needs the random seed in order
> to get firmware running. Suspect it is simply tied to the firmware
> branch used for the device. Introducing a mechanism to allow setting
> it for a device through the device table.
>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 52 ++++++++++++++++++----
> .../broadcom/brcm80211/include/brcm_hw_ids.h       |  2 +
> 2 files changed, 46 insertions(+), 8 deletions(-)



