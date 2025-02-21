Return-Path: <netdev+bounces-168659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB3BA4009A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8044424E33
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8853253339;
	Fri, 21 Feb 2025 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyU0kV3D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F825333A
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169102; cv=none; b=Rdlxf1RzqnliJ6NSc6wenlXXQLRY/AR55bwKKgkjNpTPc2KdtwlUnyQtgmEHQXzTC8rkGphAAa8YaXPR7BZlhmcjZ2P6AY7XI+AOot4XqmYPca6ymj3zSDTxTPmxfj6rhIt6W1o0wlmcsZe1yvzPTNP2sxBDvxMhsdT59cguWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169102; c=relaxed/simple;
	bh=OViQFdVqisTFg44tFqAqXiiNZ1KsTOM2qhN2G5FKp7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2I5aJVdGyXfYW5cwglSVfsWDGrwwZ4lbe0xaHp8nO8bPrF5P/q+MozfgWVmmCmt60oHciCHHRwiEIJnoq+Tqh72GCtaLxM/w71+jnWwnV3tzGC9Vb3d8oq4tajkE8p396OF9rb+LykfF7hXcmnZM7xtpM1FuXbqEgV/0Zz2LFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyU0kV3D; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbd96bef64so402574966b.3
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169099; x=1740773899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ycGcOM3SocHXEQsupxcT1OgOqO8ojjJ6aLqFO9o3bhw=;
        b=lyU0kV3D4cXYWEWn2m4zxUgNqi0jpJK95DtyqFuCfdYG3SC3vHAlGPMtiYZIIG76Mw
         /loXS/gP+RfKjr0k/4OKJpuyE8cr3IEYh++oZ/pD83t8rzXhHRC3U4CUDd/NSVF8aRtL
         vqGvRRf+AxtqhLlxPcjbe56p/03H8xZYk2cCVtLg679DLvsG7YcWDpIReGmcUADg9hLD
         f6P2lJQlGzYw2H2eE0sMF12DwaFWL23I8Xm54Nx2KR8YJu89TC8g43d2kD7h5OQvWHr/
         cbxqZVR7vniLHyygghXQYL+MuE5Fy0AN64KKlXGrM3apBWV9FjS/RcMiXef0pvJm4ZFG
         ZVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169099; x=1740773899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycGcOM3SocHXEQsupxcT1OgOqO8ojjJ6aLqFO9o3bhw=;
        b=U1/xYH8n3xJVFlQKenSRLCt6PCupmCKTwND2IS/6l1X6tmwqFgL8BkEa/NtwQwttfR
         gmxP6kvxNvJjk0qGKiJOaGU0T3oYYy278aXgd7NoOttNLSUf+pseHkTDVJuYWMUKdRc/
         AuEQiPT7rWOdg/oEn9SPWhsl10qTprOdhIFzTvZNExi8/ea9LAUra1sqgnW0X1+vto8O
         qSsst0JjZoRr6jwQEtMHMq+lsLpXCuG4mqqNJCxGQdeGipBb6G+zIOVIABtvHjmUo6DV
         M//7cvYhC4YzRuaREuerNV2q9RdHa3N9OZEuIj0Egt4YUxAoxGuzr6bA/C/1DRH3ICgD
         8zow==
X-Gm-Message-State: AOJu0YxvuW7m6A4HRs6g2qs/K8D+bjz/b1KSYCmV/h5FP7XdKxJuA+Ih
	bQwP6NnDypoaSwat/yyCjoDtGSP4L47b6GTM0SixQ70sP439iUey/XDVBnfE
X-Gm-Gg: ASbGnctTP8LAUpl2OSF9Oyicx6s6TSu5MmhhHuTarZ6IUfmJJ6FbPAjuag67o5IFwcf
	wo7kV2NMbqMB1MU1mq27coWA3X7EKsqYZuV6Bi1hOMTL/xVw42upP7Rn68eBCZnb/ZYdoqBzNE+
	dvGqkoQkfjZ9do62cSPFNdNvG/zegzgW5mOkDdiSqMFiPfyDiQxrutgWPVRyEo/n49bKcLCpVUa
	fBnJPO1IHdjkpSo5YIQNxyZAoORk7vA/20BAI3qbzHGFTfUhHQfex18HrBa3yPceJ32BF/wPyol
	NsBeYsr4kEFLJgsxlAyRUJ+p
X-Google-Smtp-Source: AGHT+IEggz58gzRFMpbzjrSrKmGMr/tyEdZ3FuXRhreB4gvWcg6+l1T6O8iWDAIm8LIa0U+HFXloNQ==
X-Received: by 2002:a17:907:7242:b0:abb:d820:1073 with SMTP id a640c23a62f3a-abc09aac8d6mr499796466b.24.1740169098791;
        Fri, 21 Feb 2025 12:18:18 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:42::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba7c63162sm913667666b.182.2025.02.21.12.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:18:18 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jdamato@fastly.com,
	sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev,
	sdf@fomichev.me,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next 0/3] eth: fbnic: Update fbnic driver
Date: Fri, 21 Feb 2025 12:18:10 -0800
Message-ID: <20250221201813.2688052-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset makes following trivial changes to the fbnic driver:
1) Add coverage for PCIe CSRs in the ethtool register dump.

2) Consolidate the PUL_USER CSR section, update the end boundary,
and remove redundant definition of the end boundary.

3) Update the return value in kdoc for fbnic_netdev_alloc().

Mohsin Bashir (3):
  eth: fbnic: Add PCIe registers dump
  eth: fbnic: Consolidate PUL_USER CSR section
  eth: fbnic: Update return value in kdoc

 drivers/net/ethernet/meta/fbnic/fbnic_csr.c   |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 78 ++++++++++---------
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  2 +-
 3 files changed, 42 insertions(+), 39 deletions(-)

-- 
2.43.5


