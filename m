Return-Path: <netdev+bounces-203598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B593BAF67D3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1544F16DBFB
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5486353;
	Thu,  3 Jul 2025 02:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6wubJER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAA20EB;
	Thu,  3 Jul 2025 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508983; cv=none; b=iGn+uUEtq0eVzP/66YYl1zpc3VGRwNYwCMzNg0nKPA7fHtR1ktCctNmbFFykKIrdLg8WocI+ty7AmjOitDRtZntvIk1c+CfL9gupha9IjYErrvlNcjkJ1hJthIGTtivFCQcpopell+bhk10V8jk8BKi4LgQMwmAjsV6fQ3vqlrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508983; c=relaxed/simple;
	bh=w7P/ThZlp2YoPL7eRVXzxVMbMFbrGp7mOD4RD45qZIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osYc7fFuyd7YzeX1A+kWL/Y3R4otLIlm4VQ+b62G8WJL8oxd1GbENPsAA9ToBMbF68PyTANp2ycFx55fvCZ2umoJHMhxcXNvrY3d4xs3ynOZDIHZYshk8dnBMMYNdDlOyZDPf3Jc8P4zo9KnLEUG/2baJwWrrQIbp7AuOmJflhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6wubJER; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23636167afeso48708075ad.3;
        Wed, 02 Jul 2025 19:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751508980; x=1752113780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b73IFjduWMb1WKYfWwZmDk2oXeQfWsAxTJaEVv/UhN4=;
        b=Q6wubJERI9tv+Op0Dphhx3mXJvinblp+wx83cx+xrCFRYf7/n0mNK3oMWzPxiMR/Ot
         Ktb+21TPL8NwbQpyHyFl7dACHMpRJcVz0/951dQA8LzHTDo1xZIzYOEC/XU6MvQB9XTT
         qtcF5W5txiocuMwafMcuhEX9Lka5sl09fuJoJzrFnnwW5KES4LfgUhmrkfL22x6iJmIg
         Ed6jz89M7d1LwkLqVlpjjg5p/Vd8LnkpIx1nyJb3PXG6sgn3yQCFbijQOrFMsSLBWwyl
         7cVMWIK7JT9+6mtAqjXZl0caZVvOb10OsuFH1GFYrd+y1gx/jqeo6qQu/tknW5KaKlOS
         iCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751508980; x=1752113780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b73IFjduWMb1WKYfWwZmDk2oXeQfWsAxTJaEVv/UhN4=;
        b=jbpYgYD86xuB2n6gFe0IOb/w9ZWtkgAfRuTWNYjlgQ2U1A9+LJ4RWn8TM5jQPnstbY
         55yiXyWMMfFjFvJH4NNZd9MTBlDqmhhBEE8jfwoLkw8/Fg1vBYHs0YoKnpSEAX8ohxvy
         h+VeK4RZBSfcsoeSXuy/dWYAEkmR37hn22Y41iysmNHFxP98MKxTwsejepOlsUjdXgu7
         F+EGGAZxsIm9u3OD+DSb996zfYJ2HXaZpoKoWxBwnbPF73H5i4RrhWRX3CfhAIPe4ovg
         m0gQg9h0pRklWNJsxmrwZf77GCqXGPoydzuy60EJm2HJ6/CVWgR3upASpThSz7uHpaVx
         9wKA==
X-Forwarded-Encrypted: i=1; AJvYcCVG0bmvy9Q3z3rTfT/4BJ+DZK/amkLlNhQ0/tgQhDVPr2kqSO2FwdeeQC9Weo6ghV+aGqPaLAICWRx+gEA=@vger.kernel.org, AJvYcCWLeYkvORPThv0YB6X7zx9JqDa1ptVZYGYRsXUp/ZnHd84kMKBE+Hga1yTKowCwzzILa1eP7GMU@vger.kernel.org
X-Gm-Message-State: AOJu0YzfCPqucpZoT1cr4/vQ3W59lmKq5XgHNaA7zbO3WUHScgf8U0/W
	u+yftbvTRuTFtzrT0Oxn8v0VXL637f7gsxCzShFpGMogvsxShoXnf9CI
X-Gm-Gg: ASbGncsQyufZoDdfDnvYYEbKrQzF7Ajc+hU3pGuC/Lqr2Ev5qNHzuoZsxEuLeLoy0BJ
	RP2JS6V04/G6bBJdq33QlNvzFEp3PnMdxW/is+TgY7VS067FcxVVvkdO44i4BKvNxDjBfNJgdNs
	nhZViSfVDuk3VWUW6YZR3P2z1D299FpP+JRIefpAf8WOImYDGdT/25sp5x1b1awJMgEldYzFRWT
	amOY07ACxPcUUeTQT69y7IMbHmLlW5S8dIMEKVLsGyrH0ExIz0tY/J+noqvEwYTYVjAzzF8KJgC
	u1SoQhrH4VTSiKpRBlxuCPx9t7nZqvFvf/w6oMrLzyD8XJnh35tOf/YA9ASstA==
X-Google-Smtp-Source: AGHT+IF3aWQEIJ3OQUGSFDn1pwNfNUpQyfdxXnfcNGViNxR2eItFwHBlfmUboW2xyi3NlJBMfC4t4A==
X-Received: by 2002:a17:903:41c5:b0:234:c5c1:9b5f with SMTP id d9443c01a7336-23c6e502bbemr72113865ad.16.1751508980315;
        Wed, 02 Jul 2025 19:16:20 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2f2557sm139107235ad.83.2025.07.02.19.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 19:16:20 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Ze Huang <huangze@whut.edu.cn>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/3] riscv: dts: sophgo: Add ethernet support for cv18xx
Date: Thu,  3 Jul 2025 10:15:55 +0800
Message-ID: <20250703021600.125550-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device binding and dts for CV18XX series SoC.

Change from RFC v4:
- https://lore.kernel.org/all/20250701011730.136002-1-inochiama@gmail.com
1. split the binding patch as a standalone series.

Change from RFC v3:
- https://lore.kernel.org/all/20250626080056.325496-1-inochiama@gmail.com
1. patch 3: change internal phy id from 0 to 1

Change from RFC v2:
- https://lore.kernel.org/all/20250623003049.574821-1-inochiama@gmail.com
1. patch 1: fix wrong binding title
2. patch 3: fix unmatched mdio bus number
3. patch 4: remove setting phy-mode and phy-handle in board dts and move
	    them into patch 3.

Change from RFC v1:
- https://lore.kernel.org/all/20250611080709.1182183-1-inochiama@gmail.com
1. patch 3: switch to mdio-mux-mmioreg
2. patch 4: add configuration for Huashan Pi

Inochi Amaoto (3):
  riscv: dts: sophgo: Add ethernet device for cv18xx
  riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
  riscv: dts: sophgo: Enable ethernet device for Huashan Pi

 arch/riscv/boot/dts/sophgo/cv180x.dtsi        | 73 +++++++++++++++++++
 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |  8 ++
 2 files changed, 81 insertions(+)


base-commit: a3d69a2aa44f50fb09f513bd2b8d8c91fb175207
prerequisite-patch-id: ab3ca8c9cda888f429945fb0283145122975b734
prerequisite-patch-id: bd94f8bd3d4ce4f3b153cbb36a3896c5dc143c17
prerequisite-patch-id: 52a475a6d4f8743011963384316d9907ed16d5a7
--
2.50.0


