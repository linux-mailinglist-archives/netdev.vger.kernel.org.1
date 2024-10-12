Return-Path: <netdev+bounces-134872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DEF99B6B2
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 21:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E436A1F2230D
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 19:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC9C83CD2;
	Sat, 12 Oct 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-m-m-be.20230601.gappssmtp.com header.i=@t-m-m-be.20230601.gappssmtp.com header.b="iHREx1yz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A733ECF
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728759829; cv=none; b=OcQxY69o15JZH+9vf9riJfL35dZWoAJEH59eyP8O8wq4Lv4ZVVPKfRmC3Z2P0em6lnhWcTgTWJV6gXFYf3vd9RVpdhURu0IWVZr3ucIzLvNMEQzo2EFHq/ZuB3NYxHmWazZdIcJpIXIV6NvMuuFx7uD3+VcSE9DSi8g72E0i1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728759829; c=relaxed/simple;
	bh=UpPzyZEORBrCABKJgspHxHQsgtS/0F3URyM/SohjHjI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PZ7V03sz6k0cOV5ooxF8+2QqoFC+LaOAZ9dWndOhvGXQrmRMojgo1vYFuOu4syb9KAsL2RCEdzbR+LOaM7IK/fIkHBMMV1tHx+wN+33CrsFXF7OIRd7branuhvB9Exu6RBYP0SmP4x4EOas8xhZi5vHzjM6eVJUNYsGHT+f1nfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-m-m.be; spf=pass smtp.mailfrom=t-m-m.be; dkim=pass (2048-bit key) header.d=t-m-m-be.20230601.gappssmtp.com header.i=@t-m-m-be.20230601.gappssmtp.com header.b=iHREx1yz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-m-m.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-m-m.be
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e8586b53so426525e87.1
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=t-m-m-be.20230601.gappssmtp.com; s=20230601; t=1728759824; x=1729364624; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Gs2kpH1Cf/bKfNYq/B8dBkAiTzQ2zsvkAVJYXLc4yk=;
        b=iHREx1yzgOdP3GOP5UDd9Yb3Y7mQkl4B3FZJ6vBifD1HbOkLK+waOepR/35pMh1ybl
         3u3qwFABqlQ3OTitosuA70AmAiWrYdUbIwzUDV9F9p02BeQoh9NZypDYn8WFEWd/4nOO
         KYKhaV3GbZRpgxzWvyCobm+IqaSxoU0XK+RaTN4zQMo6mhqTxJ3cm4fKvDok0cmXsd+q
         yna+nuKh4qHP84FUORteAe85wYT8F8KVsLsi8XnD4AGHLiqTCuc5UQ3dVyugD6sB8tnw
         kcHZOBCqfq8GF5sw8o9G/B9zXL8EV1vfvOK9NPh2hvubsrxnNCgO0dPRTb0v/So2Ssnb
         PhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728759824; x=1729364624;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Gs2kpH1Cf/bKfNYq/B8dBkAiTzQ2zsvkAVJYXLc4yk=;
        b=AlhP9QXrGKCgqDhOoBMMbFACu8vULfrAe0H7JCzazy6u0JTSBwfaX2s65zJ94laCFD
         pr7cqcSNmVYFJ7qczzLExdWpsfgWJzpcOnvDk+rtae/ihiS6p2na2UPAu+ACpMmjCY8t
         RZ4JwVJmwPk5YkxNouA5b1Wr+e+Tuso4utFFTxYakv9ixh8iqtXD0cZpbdih83890jnl
         gtk7mtA41EpzCZIgHMnTouyqJO5cqzX+UrtA6PodAEU8RUFK/p2fdrV/Ep9XY4NBR6Tw
         9h+RijnkiQlad6he4DsO3Nq8U7pzfzgDb+unrn2brWwbAd1u24xw5cAPkFiqUIk4RfJU
         TqRA==
X-Gm-Message-State: AOJu0Yxm5hrSD4hXsoMdxjivUQB3jIcvEkt1hjsQ3WrRuVf1sLhjWB9q
	7BACf8x/YAN3+NXvyrPJg+VMU7ysNQ8wIyZfw0GLFAAvN1J++aPwobV5sRzgbdomOyfbGOZm0Kk
	wrkXi7KJbBIfNhBjYTA4g91Xa5xltZiqvS7O6GmWaBw6XFIJi684=
X-Google-Smtp-Source: AGHT+IHeiixmsQtw0Tj2rTy9fHP8Uiph+EyDEF+eL2SXcqraXXFIGx4snZS4I4VPz8udCyoWhXIjl1OHe7nTwv+ZGhw=
X-Received: by 2002:a05:6512:3343:b0:539:93e8:7ed8 with SMTP id
 2adb3069b0e04-539c9881beamr3865732e87.15.1728759823836; Sat, 12 Oct 2024
 12:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luc Willems <luc.willems@t-m-m.be>
Date: Sat, 12 Oct 2024 21:03:31 +0200
Message-ID: <CAHJ97wTDiqgOHfLJc3pEjz=ZwpWP4LJV7sxUfYxQmkryi-rv0A@mail.gmail.com>
Subject: r8169 unknown chip XID 688
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

using new gigabyte X870E AORUS ELITE WIFI7 board, running proxmox pve kernel

Linux linux-s05 6.8.12-2-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-2
(2024-09-05T10:03Z) x86_64 GNU/Linux

11:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
2.5GbE Controller (rev 0c)
        Subsystem: Gigabyte Technology Co., Ltd RTL8125 2.5GbE Controller
        Flags: fast devsel, IRQ 43, IOMMU group 26
        I/O ports at e000 [size=256]
        Memory at dd900000 (64-bit, non-prefetchable) [size=64K]
        Memory at dd910000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [70] Express Endpoint, MSI 01
        Capabilities: [b0] MSI-X: Enable- Count=64 Masked-
        Capabilities: [d0] Vital Product Data
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [164] Device Serial Number 01-00-00-00-68-4c-e0-00
        Capabilities: [174] Transaction Processing Hints
        Capabilities: [200] Latency Tolerance Reporting
        Capabilities: [208] L1 PM Substates
        Capabilities: [218] Vendor Specific Information: ID=0002 Rev=4
Len=100 <?>
        Kernel modules: r8169

root@linux-s05:/root# dmesg |grep r8169
[    6.353276] r8169 0000:11:00.0: error -ENODEV: unknown chip XID
688, contact r8169 maintainers (see MAINTAINERS file)

