Return-Path: <netdev+bounces-190178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB7FAB5766
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8071516FCE8
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2879323CEF8;
	Tue, 13 May 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lekU8uJu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E5255E2B;
	Tue, 13 May 2025 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147297; cv=none; b=RWIfYcad+2MBwDRxv/9Xk2y8yOuSzKVFVUHgv9jzyZcbakq5b15VWroJ2PGgD3WYbi+1OZO6rIJ8Fc7xBj2tgKswwKMkuuAEqeAPz4dgMIiMBQw8Hu4j9VzocRxhOP8vdT8LgGtv8jLXnX9BAx4SohkTDu0pJq9xPS5TjllWcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147297; c=relaxed/simple;
	bh=mb8IYcPf0v9mQ3lN7BV4NxzF8+trVK3fEDW/UJOXu58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jYIhBhgRbWN+GmORLHktAVxzYu8gtKa9HhC8ew61Lw2t/gKzavjNl1c0LCHOhATJhASWpomFjQ7bobF6cZbIZwCKkKgOAasdmBbEWfVDN9ypIWzCmbu/z+hsEtEtb2PC+KKvahL591HDexyYKtG7D8z/eHiPQAdFOLmd67TgovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lekU8uJu; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbcd9088a7so197657a12.0;
        Tue, 13 May 2025 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747147293; x=1747752093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj9JWobjjURndiB5voh74O3FyUWIq5WzIHSbkeGfY7w=;
        b=lekU8uJuAHyJIMkEvbflsgr5rTLYm6cxGUltXEvh6uqdPzdW4uJO2ew/5LvrAS8a8s
         TD56KgS+uEzQTDAyFL2Yv5t4yUg2vAQTgwqQ8PFBC7hiMyRkLpsUN+M7dBZBDjuvG0N+
         QLlaXRUlgr4d2tOWBSHtBBHDLb2/cQzV9n8eHM68KZf29w53r1tyxB0H/cjAK/UeH/k+
         gHfxC2xvXdtBEVzyEqtgrLWOA4We67ISsKZaKBhZ4q2QLq2f9mqbC60LrDEi/14KZ5i7
         Qo19yZMmxYzSwIdM0MTZeG9dakcnkidR1aEfLKLaXiFxSLKLyt6NCpRKXv4lSDx1ajEC
         EA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147293; x=1747752093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sj9JWobjjURndiB5voh74O3FyUWIq5WzIHSbkeGfY7w=;
        b=A74bm34nD0riPTDXf0gHeMgjM4usH65dIqJIUejLOfRqVU1QUSZPn210RqTY5Rcl90
         Tbx65xIPSUZT6E500HQ3Q1iHvqwWvZ5UKTd21MjsnMHUe5iQx8RAQRfQqlAaKS34a5Un
         o28kdX0EcBmeDyYUAEgFPYBXu5BIzAiv2ZD6UMxiglRKU7JEBwevd/K+H+FV+qqyop+m
         3g3gR/qy7xL6TbfRW4iYLfFGVU9g/5zMwi3865SUTVsMXapyievlMePDbqUUmRVosOqp
         +JisAPG4IU/AzswSs7fXXN90dcX3J28Pq4YxM9zk6GHskn9GF6KNBbTxRLd9l+fpBSDz
         heKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfJhDCC0YD/gjOqAa0DJG03lU2GP1zeLHD7UNq8Bm9rM15ZKAZoiSAY8dRSR19tQtc13xP2D4fjC5Hm1I=@vger.kernel.org, AJvYcCXBgZuP78mTbsk/7H2/P8lyYfR/UP1IxOTemK99ZjG3N6OXCoENSS0TleHFkWU1EkmLcSF7aCPq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9AbfbIELdmi0QCgkawpCe6DqaAQraMuU6RKpePwWcLi+FbUYB
	VQDGv3WE/RTePH1HzCT8+qfEWiC0ad+zII5phZQRfxXX9LRBLe2D
X-Gm-Gg: ASbGncvY15Xco1NynE+JM9mJrbzW3+pcGU/GlLdM6a+RtSeWQ6x34iywJngWaoE4BF8
	uKvw/cmWWGRh2VnUPTk1532AtlnEenxczf2FNEpqzuLfcPzDpV/xHhRFuA5uO7bPsWI1n7PpM4m
	UT1dnzDsur1uqxwXgpCb3dyBZPS6+ciqYE7bhrg1/SkKxHchLPe4OQTXjStmuwvoloyPrKaGhwj
	dM2QmZ4QCgBV16BPc1QS89NKQZ0DA/QIp9wrAg30EFqYdmbkDrpena8hhPZs4dYqwVQ600VG5pZ
	z4n0+AHkMR5MJ1MwkXPc2BLOEOsuVBCJQkLFqUb0t0Nb/hf/O4M0FOVqJ+S77w==
X-Google-Smtp-Source: AGHT+IGFa9mS6+Nc4qN7oSyL9hgE8zSKSOzKP1YZ2WxaGrwH+6/a691+vK33Dfrpje5zGQyh50Dbhg==
X-Received: by 2002:a05:6402:270c:b0:5fc:af59:e180 with SMTP id 4fb4d7f45d1cf-5feebe47c84mr2963420a12.15.1747147293309;
        Tue, 13 May 2025 07:41:33 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700e56sm7301556a12.57.2025.05.13.07.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:41:33 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH 0/3] net: bcmgenet: 64bit stats and expose more stats in ethtool
Date: Tue, 13 May 2025 15:41:04 +0100
Message-Id: <20250513144107.1989-1-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, this patchset updates the bcmgenet driver with new 64bit statistics via
ndo_get_stats64 and rtnl_link_stats64, now reports hardware discarded
packets in the rx_missed_errors stat and exposes more stats in ethtool.

Zak Kemble (3):
  net: bcmgenet: switch to use 64bit statistics
  net: bcmgenet: count hw discarded packets in missed stat
  net: bcmgenet: expose more stats in ethtool

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 263 +++++++++++++-----
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  32 ++-
 2 files changed, 214 insertions(+), 81 deletions(-)

-- 
2.39.5


