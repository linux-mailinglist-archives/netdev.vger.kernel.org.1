Return-Path: <netdev+bounces-196235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4F0AD401C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556A57A6A9E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C573724336D;
	Tue, 10 Jun 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7x4rV1A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DF23FC49
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575484; cv=none; b=UhetwQfg0woSYaN1htECzwK04B66qpl7M1OTJA2cTQkQXr8lJcact+7qK4D0EY+tiuy6T43R2fUClR5aT/+bTqahcEQVoCvCI0LUVPJ6+5Osw6BtfB6DRYFSa4sGvxST6hFlSnXLwSYbHQABlselz8++ZWtW45uetqEayU9ASDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575484; c=relaxed/simple;
	bh=a5qVHiz/3iv53gr/jtsjkVjuokmhWoFmA85RHLFITYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDbihyoOf8wiEV7XJLT2f7qeawLLFvwNB20tiyB1HPN1mB5WfiDZLpJjJdFu+Q0PmYxKkj7zXsxxi4MtTuV/Ccb7+y6OVNoP7A1MqWMXvkhJge99AvubWb8QI4Tl/2OXX9WwOs7kJpm4jATniwK5UzNjpZdPF+IWnQ7/fi7+bHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7x4rV1A; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so69656355e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575481; x=1750180281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8vGz5z1XPsBRbblDD+JtuNWJ8MQYVOgqlSaKhIU6L/M=;
        b=i7x4rV1ArcZOl65zTeQAN43JU8qpc4KUJKpdQmMUPwb4eqeHgUTfhjiRpKZKZQWmpe
         9IgaSJX+TH+4VCqZZaHyP6kGNSyF3E1a3JL9hbYVbQ72o+1Ti6xrz7kn8OshLYjiJi6X
         6+XHA9JE/ZSebPty3STCoKZ0P7WgokwiQAoyYJIosj0mRS2iPaZr6Eu9vaAaMd/MSxdk
         1T9cAW40IcEOjVZPyKmQE7/AWDuVTctByiDBVTeRnko5KpE1AvmzEUq8rO7pkY2Ojn2w
         qxhaXZkMLuwaXdbOUrZqdvahAHWMbTRBQhrUwfNq9z4HnBRYunE+6FiiE/SX+U2B8b8E
         IcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575481; x=1750180281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vGz5z1XPsBRbblDD+JtuNWJ8MQYVOgqlSaKhIU6L/M=;
        b=mKOD6myRrEqsvIDBbI8SeOGOiPVSL0EGlLVY2DvDtuX6y6XHKdGWgSV7YRmLtTACu0
         wnhbME2XlJJyhbSjFwXXnt9GuAqpodLbTd8z495nZs0GG+9k8IDJi5ruPrY4fUb/XRU8
         f6saS+PpNqC4ZX3bZLRCtswoWfeQCy99d/ZL+vPVaU/RwD9O/cTRl4iv1Bt86O9ypMeo
         j881G4TI40fCsuf3lVi/S2vv2XohCF7wdK9pRmEAce9tomuiCay1S6y3ciPVAcSH0SEI
         e7OD8/p4ZAkpqqvqBByDkTvcsQahB+Lz40wFuk1WnI7j/apUYP0afkGLlsJJYCx4keJR
         Zd9Q==
X-Gm-Message-State: AOJu0YxSr3scXQgLVYZl7OW++6IGd5fR8M+gsIlZw2qx7rEwsSYwcpQX
	gduBuctU+Y9JMiYjYeUd9KendrOv4l7UgmwOnaJO2WvyxNcHmTtAfxcTWkfVAwxU
X-Gm-Gg: ASbGncv697dY26LUC2UugTs3wMNlljk4HSAKE4eQGfok4wY2p8fYE/2a0W0cXcB9x9V
	wj6DNJdixYy3UtI8x3Pl4r6W0gCIt2quy5iKSmanfiqBSeTqV5aWJUja4f+tpTWP0J17LYp+h88
	8VvVi/U+fzUwOWefZvG5Q6MgXLoQbBmEC9mrnXyyoitBG33nwa6/4+bvArc9VU2Gab+pgytBCwE
	qgi+NTb1MeZBOzy/vh5o/4Q4HF3K4j5T1mldLv8I6aVdMmKuDsHn3Nu1hvo3KKtP8Vlv6uZe9Yy
	/24fOWutV+4TZZuzYFiRFrXtap3A2Z9xRx5rYs2IBstxB0x5yKMlGoNR
X-Google-Smtp-Source: AGHT+IEME7K56wCmN+kFI/RLWk2+X8b8hGVbMQbdWQB/+0hKD4dy2J0N+OAmanem4gmEuj/c1DKfzw==
X-Received: by 2002:a05:600c:a44:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-4520140470fmr147000395e9.25.1749575480619;
        Tue, 10 Jun 2025 10:11:20 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730b9caasm143617435e9.20.2025.06.10.10.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:11:20 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	sanman.p211993@gmail.com,
	jacob.e.keller@intel.com,
	lee@trager.us,
	suhui@nfschina.com
Subject: [PATCH net-next 0/2] fbnic: Expand mac stats coverage
Date: Tue, 10 Jun 2025 10:11:07 -0700
Message-ID: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series expand the coverage of mac stats for fbnic. The first
patch increment the ETHTOOL_RMON_HIST_MAX by 1 to provide necessary
support for all the ranges of rmon histogram supported by fbnic. The
second patch add support for rmon and eth_ctrl stats.

Mohsin Bashir (2):
  eth: Update rmon hist range
  eth: fbnic: Expand coverage of mac stats

 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 112 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  66 +++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  19 +++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  72 +++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   4 +
 include/linux/ethtool.h                       |   2 +-
 6 files changed, 274 insertions(+), 1 deletion(-)

-- 
2.47.1


