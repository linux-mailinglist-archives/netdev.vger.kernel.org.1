Return-Path: <netdev+bounces-195954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425AAAD2E3A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4D71892E27
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CAA27CCCC;
	Tue, 10 Jun 2025 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DjWhc+r8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C785927AC5A
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749538856; cv=none; b=KwrDpi0DD1isoPvg9PmMuXiAiK73CDLiHUQYluZ+PGYTKPWHKtFhDGk5pIdFrxKtTD9nL2UIgRS1EzzvaszcFAuFj90SRlgVyv5zyedNNwUdaQpXW9zEsf6SIH0T/UrmZaHP6+rXC7TC4X14duxWoTNq0nPUjPKcNZIYzIOir0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749538856; c=relaxed/simple;
	bh=nxzPfqmfptUSQtLazHsiK0dcb5LFkkFm+nAYN/C+p7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JEmY1ozWH2SY/X8W7D0Ux6ejNeCbOr+Xr/p4rWtOXp1TzNBPodlKevH0KLNJvS27rxNojKDk9gCusf1gbhkGppNrn6B+XGr10ViYRRaG/ngu49B60q25M75FN1HsYTwaJ7JZ1F7+4EhhiH5sN+CvhONSrIFPiMZN1UUpXdiiGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DjWhc+r8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c27df0daso4569464b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 00:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749538854; x=1750143654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUJitp02dLbwyW6XXbPMt7kAqtrb2lpqnpotbucX9CA=;
        b=DjWhc+r8grExgGyU+ffVVX9BHLHhw7Xb3RUTpcLrAIZmfpfabTNrvlpGYRTFsevL7n
         VMqZCLMcdY/zeQ/r3ZXYPHKiraK6q8Zipu2KBJxgupIvGEnZp0IWVV9BIieBjAQ1NM/L
         bcA2gNX2Va4tK8nRSRZr5/ICMHEHbtk16iH9z1KOE8gdhQQKuxFJS6QZD4JMYxko1q/o
         n4ABDTZuGMbuXJkblw8x9Apg37ahy9IVGklw3PM5DxuXLOwqiIQV/PkxPyrz5rMt9/QV
         xkdQVixlyaae9Y66ARCHPziR8j5IyqGaZ5qDYHvoOCcpz9UpF5HKC/1/jf/Hn5oIPaNR
         FtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749538854; x=1750143654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUJitp02dLbwyW6XXbPMt7kAqtrb2lpqnpotbucX9CA=;
        b=CStkXnTM60GLs6YDiapOJko3raIV/dvQ9Bu6PSpIBIkoGuRL0usl714RrcDfQqJwyJ
         3nN6e8yyT80YREQqg9rJggIEWQKWSw47SmIR0qgE3wasnHKkz4ARca15JusOuunKFKNL
         s61excX00nFUdn09JlrBdWweYP2lOqZ5XzVpnZI9RDokYPtk0H8SqypQszaPUJUTPj5A
         bA80a44Ruoo2td8QP3d0rODd8LSPyZCk166hEvGmn8gS05Aqym/Wj1jzCqK/5h6dv8Pk
         PDQyeHITWjzML6p5o4IL5M9JX8g28oI0geupNAlLS0YC2REzG5Vkxy2xprdxNZTuO5Cs
         1XHg==
X-Forwarded-Encrypted: i=1; AJvYcCVTE2VULmYvZ+33/I03tH18yG46lb4GrV5H/ud5JCl4rw09xXE+ix10LJ38uaclhH9t10PX1gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbG64sRDnRG73+8gpPTISixnoUz1LLS6Nbi0vAxpaUQ04jO6T
	+pHA4Ut5+KKrR9d3ezW/R28hhqCiarIik9fTgv0tRggUx3g7LmcM1A3Wx2GFLLaqyJI=
X-Gm-Gg: ASbGncv3TRMpA1Yfmmqhf6vhyrsJ8GGZPHCZmOB0pS8KZLvMMiU6+nkKFS7JUGCfuuN
	lRqINZpVEdK3pee6MbEbB8anm71HgbAEBxLEvD6wVLDIZl4Kq2vKQjSkyRsH2b+ihajR9TpoTxX
	lyyeJgOG8SnNUHKIgUfHf+QnY1Ls+2CZPA4WAHh44IemTFGHLTo73loU232TP67rgY5P+guUVRy
	97AmggyjXZ0el4bJHwvpYrEGfDLazzu7wIAM+lW6i6tfrYI33W6SCNavTWPYG2CDPSe2kjEglmn
	Vr+oTkXfxSX2ZoYhCCHnc2LKkAfkWIIg0JAvDUuLGnrnO/HgmwYWpsxrlGTqqxxWnJ7/2wika2C
	d/o3en2uw3SkMvp6f/8VU/bM=
X-Google-Smtp-Source: AGHT+IF8uzdNqEI314pocfYYQWBeowDkb4F+LwQ50ySlNHswx1qiGOLWHPFnpEwYjMluBjhKg3WXFg==
X-Received: by 2002:aa7:88c1:0:b0:748:1bac:aff9 with SMTP id d2e1a72fcca58-74861888babmr2307166b3a.18.1749538849387;
        Tue, 10 Jun 2025 00:00:49 -0700 (PDT)
Received: from mattc--Mac15.purestorage.com ([165.225.242.245])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7482af7af0csm7038483b3a.62.2025.06.10.00.00.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 00:00:48 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	helgaas@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	oohall@gmail.com,
	pabeni@redhat.com,
	pali@kernel.org,
	saeedm@nvidia.com,
	sr@denx.de,
	wilson@tuliptree.org
Subject: PCI: Work around PCIe link training failures
Date: Tue, 10 Jun 2025 00:00:44 -0700
Message-Id: <20250610070044.92057-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <alpine.DEB.2.21.2410031135250.45128@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2410031135250.45128@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello again.. It looks like there are specific system configurations that are
extremely likely to have issues with this patch & result in undesirable
system behavior..

  Specifically hot-plug systems with side-band presence detection & without
Power Controls (i.e PwrCtrl-) given to config space. It may also be related
to presence on U.2 connectors being first-to-mate/last-to-break, but
I don't have much experience with the different connectors. The main
issue is that the quirk is invoked in at least two common cases when
it is not expected that the link would train. 
  For example, if I power off the slot via an out-of-band vendor specific
mechanism we see the kernel decide that the link should be training,
presumable because it will see PresDet+ in Slot Status. In this case it
decides the link failed to train, writes the Gen1 speed value into TLS
(target link speed) & returns after waiting for the link one more time.
The next time the slot is powered on the link will train to Gen1 due to TLS.
  Another problematic case is when we physically insert a device. In my case
I am using nvme drives with U.2 connectors from several different vendors.
The presence event is often generated before the device is fully powered on
due to U.2 assigning presence as a first-to-mate & power being last-to-mate.
I believe in this case that the kernel is expecting the link to train too
soon & therefore we find that the quirk often applies the Gen1 TLS speed.
Later, when the link comes up it is frequently observed at Gen1. I tried
to unset bit 3 in Slot Control (Presence Detect Changed Enable), but we
still hit the first case I described with powering off slots.
  I should be clear and say that we are able to see devices forced to Gen1
extremely often in the side-band presence configuration. We would really like
to see this "quirk" removed or put behind an opt-in config since it causes
significant regression in common configurations of pcie-hotplug. I have tried
to come up with ideas to modify/improve the quirk, but I am not very
confident that there is a good solution if the kernel cannot know for certain
whether the link is expected to train.

Thanks,
-Matt

