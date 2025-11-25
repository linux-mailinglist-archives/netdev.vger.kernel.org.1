Return-Path: <netdev+bounces-241423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F197CC83CA3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B39534AB45
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CC2C17A3;
	Tue, 25 Nov 2025 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLa9ZhC9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9713AD05
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057125; cv=none; b=iMVcjiYzGBhcECSZfg5OZARswjKXFb6LqeLyEOXN/9RVf61zWO9zGxJ66aG3GlBiCc2v4yTBaKNfNqKjW6ABb/zQ8eob0tSpyeZofgOqokihr+qnb4UB3CrDd6JhABXtq4qaPCtrA7pCxf6JYo9bbtpLlRa5RYxqjj6tcfQiYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057125; c=relaxed/simple;
	bh=ToYcyZUZTw+Dm3jQvNFQCQnxSnWfBapFKpCC53qV3qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yb+L+C/rvkBYoF401eWgK7r8k277tRm67thRg8L/dbj54accwwhvdaYhZPKHb7oeeUSN/lS8J6PCymIIaurcAeUc/EudvtnUvY6l1KmFh0q4UUKglYmfhiyOBw5BA4CrCkGDdxHCjuAXHsIyI3iCdntsGD6doKd35h79akpGmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLa9ZhC9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso8672768a12.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764057122; x=1764661922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mfd8iMecbKSRaGKozpyXTdFbCrjtIOnZra1xqPtKkQw=;
        b=SLa9ZhC9TELXbyEY3fbNR1kOR0ksTICz5F9gp0+mhzrmUrKPpRxp7LjggUEXKcAy4B
         TW7SmKeXB2lFcaPSQZGegsQL+/MW4fZzvRhpDd7CanwRfs4le/dKYFsaJXriXfuQBA4k
         4CUDPOQwNUPnjpzeKgrD3VIrukjBgZ/PTGzR22wa9s0MNECxdD/9PxVPb5gyGrAFrDc1
         t10pKt7ROgyQQbYxDKwpfc6BPoqz/tRfLXHVBfpX4FZU1JfAO/CT9gDQHBEef4dmhXsh
         SyW4sxPxV53gGmdMMIK1u5wv/Y3AhDLdXyFevSTuZDghcmkCFvLKEOWKb4nf3MKwp164
         FOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764057122; x=1764661922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mfd8iMecbKSRaGKozpyXTdFbCrjtIOnZra1xqPtKkQw=;
        b=R4bSbhOin24y+8dCyWHbAtZGfAmJopaGz2l1baMr9jse8NW87MRS1n2NuWWzRls4xP
         cnXA4kg3VXdID1SSMviNczxXsUPESaTuMajd/W3s7T379NA9piRjsi96/x84/vnoIxj1
         nTAHvQ0Ljw3MQkTLHpf9DgZ5LQWpJ9RVGl36wPGL6+ujszNNTgTFqe5wl/9KTAisabOn
         76F5o8KVqIptslb4LKRKuo11rysEuL3AYhCAmAlihsIA6Q6Z6/jmMBqVWJ1YZAYDq2bZ
         rz4PDQJrssl8EV4s0yyL2MhRJWeVIR6VPgLvlMvmZNS/RA3YJjNJ6XOHpa10c8jhgW64
         cOVw==
X-Forwarded-Encrypted: i=1; AJvYcCUp7XGqukdWRmAp7Hj8HqGkBC/v6xoIZjzx7ASAj9xQYGxLaQJJHHsBM8viPI6LNzNkpKU5eJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdW/3JKkL8z9wftxIKYzH0lWd7PGCnyrKST7FhEMUboub8ykJ
	SGBDd01X5586PVoezKLy2M4skjx7zVHEVEKLUujEelygU93FQgpwCt7E
X-Gm-Gg: ASbGnctfDccTQe0BbvUJRCqlSgDf7f507+rtuF3MjbrK8ZYN9EaNvtqiyxWjWPL95Hq
	6E6xHiiqXwiCTJNUu0Fu7J/XGzD4vCEAEY9PZ/xg47Xbv94RKyPTN7ItpLZVx7/2twIvdFyqbwc
	b2lp6+3thjBeYLx758ijqAMORzYIktZ3OB2tcS2xWZo7Xh052d4tciNksC49Fnx0RQ1JoLBX6pQ
	rhD4SbWO+kycvNS4PuU8HAKYcjqBz/T1O6zXrT6rTUYvXodk0UjD1GlCrpga3O4JQ5H1+JfmC+S
	NDamaORXPLEf/5KNoB5+4SMsJb7E6nK/sp4YvV4Q1I4yofbgCxCrIO/slaY0RkxpgxXkTbXdd5k
	xyWaYzt3PBrKxXPy1+ROzAdQmfLAnSJsRfP3Ev1CoB2Q2nbq40vYsn4a/Cd9280xKna4N7VFJ08
	W1oE2wkOg62fcuGgqli0fnn0NvoDM5stWnYmq4mgHaoLPG9lAsbAK+ta2k5LTe1nnP+F4=
X-Google-Smtp-Source: AGHT+IGmD+DylYSGbM5stDnM6zjuqD48rF3doPTMWL4VJEpnFKbHOAwE9FpZFFCdbGAze7TxqlXHUA==
X-Received: by 2002:a17:907:3e10:b0:b76:5143:edea with SMTP id a640c23a62f3a-b76716953e1mr1435650766b.30.1764057121991;
        Mon, 24 Nov 2025 23:52:01 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d80665sm1485802266b.31.2025.11.24.23.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:52:01 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: dsa: b53: fix ARL accesses for BCM5325/65 and allow VID 0
Date: Tue, 25 Nov 2025 08:51:43 +0100
Message-ID: <20251125075150.13879-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARL entries on BCM5325 and BCM5365 were broken significantly in two
ways:

- Entries for the CPU port were using the wrong port id, pointing to a
  non existing port.
- Setting the VLAN ID for entries was not done, adding them all to VLAN
  0 instead.

While the former technically broke any communication to the CPU port,
with the latter they were added to the currently unused VID 0, so they
never became effective. Presumably the default PVID was set to 1 because
of these issues 0 was broken (and the root cause not found).

So fix writing and reading entries on BCM5325/65 by first fixing the CPU
port entries, then fixing setting the VLAN ID for entries.

Finally, re-allow VID 0 for BCM5325/65 to allow the whole 1-15 VLAN ID
range to be available to users, and align VLAN handling with all other
switch chips.

Sent to net-next as it would cause an ugly, non trivial merge conflict
with net-next when added to net, and I don't want to subject the
maintainers to that. I will take care of sending adapted versions to
stable once it hit linus' tree.

Jonas Gorski (7):
  net: dsa: b53: fix VLAN_ID_IDX write size for BCM5325/65
  net: dsa: b53: fix extracting VID from entry for BCM5325/65
  net: dsa: b53: use same ARL search result offset for BCM5325/65
  net: dsa: b53: fix CPU port unicast ARL entries for BCM5325/65
  net: dsa: b53: fix BCM5325/65 ARL entry multicast port masks
  net: dsa: b53: fix BCM5325/65 ARL entry VIDs
  net: dsa: b53: allow VID 0 for BCM5325/65

 drivers/net/dsa/b53/b53_common.c | 88 ++++++++++++--------------------
 drivers/net/dsa/b53/b53_priv.h   | 40 +++++++++++----
 drivers/net/dsa/b53/b53_regs.h   | 19 ++++---
 3 files changed, 78 insertions(+), 69 deletions(-)


base-commit: cc1b62512abf19c635fe304e253953ca3b33ffa2
-- 
2.43.0


