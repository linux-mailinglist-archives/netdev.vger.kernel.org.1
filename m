Return-Path: <netdev+bounces-179774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A922AA7E80F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDF1175AB3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC6C215F50;
	Mon,  7 Apr 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkDl4ov8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF66211706
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046528; cv=none; b=pOEXmcIj5i+AXCBlvTSnp6y0bqIqkDk887qAMcKRU8W8hCtCazBIDBMiPbcdmGhNWho0zs9nCH9Q9t6ciyAhgUIvoLez2/VQ9Bg+V/Vd8qQiqADcMdVIoYJtrYfFeYk/kn8/tDXA/9d8kcnTz/uTLL/ez3V0X3pMftNdVgGL+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046528; c=relaxed/simple;
	bh=CjYwnQZ25u2d838NlOp+wdlXvIKQHB8ffxgt+oaKiv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9yTTzowNvq/e3xarKAOKXXYPUVttUtpsaeMnodLGLNhXVafmv500MznRVx8Kn6hkkrwiw/rgmF4FpN/jpWLxdaKdnndIR68dSGDPoCg6dOgkwP6XyNhJSitJb8K/hs9PPUjEmDEezOy1qv5o+eVl0PwLQZ2O4Q5SigeWd4Vy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkDl4ov8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso43299625e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046525; x=1744651325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HIyZVJwZJ9OpY61x67PG1EB9MLZ59IGDvhTXKZJ5ShA=;
        b=PkDl4ov8lA7MgoNJFeJjGPIS51SsYmwFSnLH0/sLEC9qkiAbsTKx0McD8mu0pbrZZP
         dZ2tR/nkgdeaXcVk5Dgp0WJqb6GilyhPuKtjbf5EUvNmfv80oib7AGc8+ewCR/Lc3yRs
         FUfu4FtjkN0Q96MfZDzL29stWit1LiQKiId8M389wi1GtBBUOXK4cP4fzBcEv0nAjDFS
         t8SLdCYDGORYbhxQzu0oJbySO5lCSqbucK0aXwb4l0GPLHiJwim1B6YxVnc5HgELsGoN
         S5aUE3raNM/+/kO9/zP8ZON83i0HAkdOE0zTMqRsyYKrz/7j5Y2UbiAaj+1XJwgvl/4F
         edxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046525; x=1744651325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIyZVJwZJ9OpY61x67PG1EB9MLZ59IGDvhTXKZJ5ShA=;
        b=LkuNjcTlTJPVmQO6Jnc9R265J8qZeKqvnLAknfwvnw2h4hinJ8tUT+lRoMf+iTQx6L
         rReMzwed/aEVBwAqiJO6l29tD0ySnVR6i4s75GuLImIxtgskZ9yWB0XwXVNXt858vRvT
         8zG/PRHWd2cGG1sibbZ11VXeRnBfBSJueR0TcvaT3u138X249edqWhb3EzBG0bD0OkqF
         2kWxV5sGZJC8tdzqeoxqMEU60NeNghTiVCdyt3xpNpUwSkJpAgNKeoaE/K3RY1vjqZh7
         3ts7s/w/gxBzbmO6eIXt0wIafSzp1virjLJ08zy9HbqfBe+qdtb50z1CJQ+BjueLZKga
         +z/A==
X-Gm-Message-State: AOJu0Yx8LuOQ/TLY9uY38fa7fXQ88d7YrMAZsL6eGCPZkz07cE2c22uQ
	iD0MugKIWz1Y+rZRKRTTLr2O3DWccdvYiA7H3SqZBe93EJnVdKJDVrBRq2J8
X-Gm-Gg: ASbGncs5QQRiny6HgynzE5klq3x1K0seU4YX6kp7lYnBQ3IPvYyu520FX/fittAC4Qk
	3M9WQKGnNmCFnsGN0X48TDuiA56KrbQ3MTaDznG2PiV4o5YgfX82/jmCzqfkuICADEPujr/WShB
	zPIonowED1MAtszBUn8O+/0xWKb0o+axFYxcKgrpwFi8lrvnxMYKxnzER1ov4e5KOuiPvNURhZW
	p2L+MODERj/GXUbIS962MpbwA1OkcSt2PcMYKNjQytEsBrhbeD7VGDc1izBZbNUNSHepuPdIh3O
	MlNsjo0TOtwF8S5X8rkGa3i3I4D96drnh4TOcYuNzYE=
X-Google-Smtp-Source: AGHT+IHwPQbaZ7vlh9YkgJXi5Zb0VUVnyVtlDxLA+NgXfCcJsMTTA9yPHZMWlIrmD/ZZFwDriBTbzw==
X-Received: by 2002:a05:600c:35c7:b0:43c:e7ae:4bc9 with SMTP id 5b1f17b1804b1-43ecf842969mr112826985e9.1.1744046524585;
        Mon, 07 Apr 2025 10:22:04 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a895fsm135966205e9.13.2025.04.07.10.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 10:22:04 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	suhui@nfschina.com,
	sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next 0/5] eth: fbnic: extend hardware stats coverage
Date: Mon,  7 Apr 2025 10:21:46 -0700
Message-ID: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series extends the coverage for hardware stats reported via
`ethtool -S`, queue API, and rtnl link stats. The patchset is organized
as follow:

- The first patch adds locking support to protect hardware stats.
- The second patch provides coverage to the hardware queue stats.
- The third patch covers the RX buffer related stats.
- The fourth patch covers the TMI (TX MAC Interface) stats.
- The last patch cover the TTI (TX TEI Interface) stats.

Mohsin Bashir (5):
  eth: fbnic: add locking support for hw stats
  eth: fbnic: add coverage for hw queue stats
  eth: fbnic: add coverage for RXB stats
  eth: fbnic: add support for TMI stats
  eth: fbnic: add support for TTI HW stats

 .../device_drivers/ethernet/meta/fbnic.rst    |  49 +++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  34 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 175 ++++++++-
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 335 +++++++++++++++++-
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  48 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  43 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   1 +
 8 files changed, 678 insertions(+), 10 deletions(-)

-- 
2.47.1


