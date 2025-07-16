Return-Path: <netdev+bounces-207349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C4B06BBA
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 04:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75DA562BCE
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F126E6E8;
	Wed, 16 Jul 2025 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHAwGy8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26481C68F
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633050; cv=none; b=PrPU0qo08nEKUDT+fNyKlStdLroG3XP2eW0kRfSdcheMroXXAEkRbX7AXxKl74dwDOnro3/DHD+vFnm393n67tGpBGBW53zFAMpFraBhY7qdYFU8EL7TuK0XQRSj2zFizH5rwlfBVcnRTq6yKhK2m2s3F9WJrD51MLb7ObANCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633050; c=relaxed/simple;
	bh=1IRwWUtkyxJWxtndLEium7ymKPk86OT7qJZ47Qx7BtE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OiFWudFzHT8HAzwW5s2FmNL8WqzcdDu4Vl/P7yLkK2D5h1paQ3Kjb3i1CP3C4kqVJUfi27Y7o41e8zR5nghMIqaV1AgoFBheoDweWaA844M3z5DWvJyGYjh/oo2icQimvV2Iij1sKul1VzSwhTEs+pQD4YoRdcWkw1tPR7lEmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHAwGy8n; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so47812726d6.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752633048; x=1753237848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yvOpo7nqLut/xj+JXogOji8Fz3FfT0ItyN3/TUwUhV4=;
        b=fHAwGy8nfpzoQVPIC0fEdflt2/8QgTryOY3lOJyChQQ+MCo4BQOAd64rrW7+HRhqTi
         aMJWnhCLmuoeDRDGfyNCESDC5eiJohj+WnJNQer1C6NtJWB4Yc+vqY+9Czrhty+7VvLI
         zz14TxHRV+JG0CpkA3dn0iojg2ktFoFhdUb8zkKhob0rtfL/LeYbnd8VFby72GO78fHB
         HTmmTr9LyZ713wc27qAkc7O0FCzIYwTDPb6rVTlqBreXfWtq5AJiMw1gntnOUbkjOERo
         oKU12JcVXnJGO/HLviIfF798o/HC4SVlWhVElOHKqkDh6ShiZ+su1nqvK3FO0o8Crxeu
         9b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752633048; x=1753237848;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvOpo7nqLut/xj+JXogOji8Fz3FfT0ItyN3/TUwUhV4=;
        b=qgWIvKFwk8CGVTHJkMEAFXQOeI6J2SjaEew5PsIq3IBcE0WBmEL1OWo6pOE19kpOUF
         tWzd/vTWJwovE8YddmoT8lXI5wOxVVrPVgfc9x2CN2mSb+lp1Tz++h7qoJPjdsbdXL8M
         yn9HO7d4AfU0HJpmHhCk4uPA/j9VX/y/aPQ+uyORD0J9fNIM3sc90CG7GuSNjovhBjSv
         lhtzmHk2kD3ROXwLv0R+EmAwXxUD5i5FmPA4En9FSuy1RR8n1ztD+rtoKYki3XDiszzh
         D3g5pAAflnjqfZjl9/AkFQEsvLx4sqdI7H2ZFSzCMa0rYw4PFcggAWYR55kRCwoiqYFr
         sn5w==
X-Gm-Message-State: AOJu0Yy2rcIuW+T8b+p8MEcouVEoGcxcWIGoORJiXA/kPd4eV3iLqSdt
	1Yu+3c8txP0ddFqLXH7rML+ag/GmxJiMncnv7ba0SFRX5S4O3SL6/hLoRhKZZDTqRcXnHCW3jOv
	mMNn8dP+5byBlu7mnSQUPMF1GGnbOmR6DKTGHDeY=
X-Gm-Gg: ASbGncuIsDGxn7NskezDDaeUqlAuLQO3ezeN/I72uDfVT1fauPqpS4dxrqSKL8E/qX1
	JfZKeU1B+lGok1hDJlDDhDoYU+LuJIUTN8gRJ3v0CPB1IA1rFoQHrMbE3SCXhpMH3b6+0hnhfN3
	Ujtc6wXfCwVT0KxrA/pVqTWsD+abzdacQhj7ICT3FurCaUV3+mJ25cyPWAHGQ92CPxU9iHLjx6H
	1EAcFEq+ACkBmpLVSE=
X-Google-Smtp-Source: AGHT+IEOjA329kXF7oMRpkr4/Jo3mu48gebfb7jVzyHxG450tSpf12JPE3J9sPzFVNPtS4HQPZmGly//WH4CuQSOz/Y=
X-Received: by 2002:a05:6214:2a4b:b0:704:aa37:9008 with SMTP id
 6a1803df08f44-704f4aac578mr27348476d6.27.1752633047621; Tue, 15 Jul 2025
 19:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?57uD5Lqu5paM?= <jjm2473@gmail.com>
Date: Wed, 16 Jul 2025 10:30:36 +0800
X-Gm-Features: Ac12FXxzwyDmfY-Of9T8V5t9e6yd9Oga8Q5n2WqG4PM_0k932Ev6GON0eH1umCs
Message-ID: <CAP_9mL46Z3kwaSdyCAaEd0iugDEyva6FMBXTPjDhyuWfKZc+7g@mail.gmail.com>
Subject: net: phy: Motorcomm YT85xx reset issue
To: netdev@vger.kernel.org
Cc: Frank.Sae@motor-comm.com
Content-Type: text/plain; charset="UTF-8"

https://github.com/torvalds/linux/blob/155a3c003e555a7300d156a5252c004c392ec6b0/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtsi

https://github.com/torvalds/linux/blob/155a3c003e555a7300d156a5252c004c392ec6b0/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2.dtsi#L140

nanopi-r2c has a stmmac, which uses clock from yt8521s,
`ip link set dev eth0 down; sleep 1; ip link set dev eth0 up` will
trigger a hard reset on yt8521s (`reset-gpios`), but
`motorcomm,clk-out-frequency-hz` is not applied after reset, then
stmmac die:
```
[   46.656359] rk_gmac-dwmac ff540000.ethernet eth0: Register
MEM_TYPE_PAGE_POOL RxQ-0
[   46.730371] rk_gmac-dwmac ff540000.ethernet eth0: PHY [stmmac-0:03]
driver [YT8521 Gigabit Ethernet] (irq=POLL)
[   46.934670] rk_gmac-dwmac ff540000.ethernet: Failed to reset the dma
[   46.935284] rk_gmac-dwmac ff540000.ethernet eth0: stmmac_hw_setup:
DMA engine initialization failed
[   46.936092] rk_gmac-dwmac ff540000.ethernet eth0: __stmmac_open: Hw
setup failed
```

`motorcomm,clk-out-frequency-hz` should be applied in soft_reset or
config_init, not only in probe.

ref https://github.com/openwrt/openwrt/pull/19415

