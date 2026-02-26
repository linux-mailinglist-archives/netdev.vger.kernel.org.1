Return-Path: <netdev+bounces-261306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJoyCPIyoGksggQAu9opvQ
	(envelope-from <netdev+bounces-261306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:48:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 947361A5519
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5348A309877C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD38C376491;
	Thu, 26 Feb 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGHwNFYY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B736921C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106193; cv=none; b=UZC+KpuhCprGpFJEPDiw2LK+yVEPKtvdBTEamojEyeItAVEIxBHtsI8M5cnigatZQ2zytVG5FrMhJs8dzHNbgVIZW5ODMT9r3RqtnTcQ6RP2Pz5PdnnvRzL7kTBo/tHOOQeaDJQ2elPltFII1hRP5eoqaVGSgwFk9a0bsO5Hrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106193; c=relaxed/simple;
	bh=dJjhH8ryVeN8VbL+ettl5uMr2GTzSV/PrDSmpGn4P1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sGYJTD0lBDNk7tXEC/ZYWoEXGv6SDYloAoN1a2ZbgsNHei30Z/SR4F0gfI/teGda3PBt6CP4h4+i8BqmsbUA7UE6UatDL86vCQuHB738l/h48/AjFT3GvktXgqgCxNaWIsf7ANoOZApCHxkVWs4/FUNUAM2pqMJONpTZubjg2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGHwNFYY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2adcede372cso2982695ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772106192; x=1772710992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdgMvJCRheKq92C1xI4uXJcoc9Cjrdybv0fSGYfTngw=;
        b=iGHwNFYYnqtMTKZXwzX3O7g5/PT2MTMqUwzUTObYF/7zNa8dRCvgKUULhklyLSkFGO
         9XQFXhgZtJb38e0mJX6gI+aDxtnPvXkbTnX+icXtKbeUDjRYk8Z3EGfx8AN2SJzu2pLI
         OOjbp2tGWsmnABC3jizYfsRUAcXukTHh28Z3L2QzE9MRjMoXQBqrtl6oLcsCGKODbffp
         9LKfv3cYNprmzSjaOGWsJbtpcGinlUdr4e4odj8w6sHGKZC9yG8zstibrpmJxT+Kjx7m
         1XtKJEDt+6ITL1UN/FpCj2RtbDTQLAWTMrNG89lD8lDmHSCLrzJJGkJ+14a/NiqXidGg
         da9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106192; x=1772710992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdgMvJCRheKq92C1xI4uXJcoc9Cjrdybv0fSGYfTngw=;
        b=xLCdoEeDcgj047yJMxOUEup3wFTKXYfYBwoWvvbZ1083xTmOSK9FuC9tKlQWO7dZkc
         orgwwaMXjnQHZfIdb1XrIW+77U/STbJC/EzO4KCWGj57Avbm4a+7Yrhohcx0F0QeF2hv
         kWcoESRZSkp9S8ebd26oKvH3kmgXiA1tLW2EU7nU3U6HF3uG0GdJ8TEOqa7FXme9GXMx
         QNNZQZKODassjEYUhmC6sbVmQ0edi7MzxB6o3PY8Iry5Or8EDgvMLMclagK3+LtO8JEN
         FxP3TxkLYyXtTs1Jja9WZm6GD5cVwb7cRf56GTpljJgqMrh0apNC6sJDAiVZiZdSZNGx
         VNfg==
X-Gm-Message-State: AOJu0Yw5roXPFRTPBbv7oduOVJ5xgNFE7Dz5Xd2QUfJVaZW+1pN/6pks
	VPWVr7KAfjoyt+PPk3qkY9LJMCngMp6pvWJKiFKKdEBwEP/9FFCTyBdTBXmOhcNaPMU=
X-Gm-Gg: ATEYQzzefaOMj1uoVeqrfG9Rw/DxYySWtrxdnHmd42pBT8fmLrlk+J/wXhRogOOd0LH
	RBJ8gplblAhiq8oZsQkOulejE8xHQm3VnBp+LYYukddfcaD8yHIzMOEwx3+ToeVP9oQciXeIU91
	JuGAVc/oz0ODD8ry00d3EUcJ8snJjQgPHAb4rCKV5W7Vc9Hebe35wiNMgXyMCFRCDWvO5uGcuWR
	KRlrF3DZTJglqQI8cu7n7k1bk5EbUzPSXbZRXupM5h+GxzrjHKdG7urTblB7lhGtOYabvQGDM4e
	fllq55rkzx8C7yTGSWGVH7SjfaIdH5m3SM8DDyGLB+It6znmnELb2cZ9O2tGHY0sHDDhc8wOnOm
	VryTEY8rcUiflHM9xo6t/rgnVh044nFapZKWVwdfG99i5JktFxbjtPM/fCu8N4GPNfJluU5IsQ9
	+WXcxK4/+rbEu0zjnctGbk+TGc78rKxadgqYa94Q==
X-Received: by 2002:a17:902:ce03:b0:2aa:ea3d:a37b with SMTP id d9443c01a7336-2ae0305ebeamr20234825ad.2.1772106191620;
        Thu, 26 Feb 2026 03:43:11 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbac7sm34131545ad.37.2026.02.26.03.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:43:10 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCH net-next 0/3] net: add ndo_update_offloads for offload computation
Date: Thu, 26 Feb 2026 11:42:05 +0000
Message-ID: <20260226114208.27774-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,resnulli.us,blackwall.org,nvidia.com,fomichev.me,vger.kernel.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-261306-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 947361A5519
X-Rspamd-Action: no action

Currently, master devices (bonding, bridge, team) manually call
netdev_compute_master_upper_features() scattered throughout their port
add/remove operations. This approach requires each driver to remember
to update features at the right times and leads to code duplication.

The series adds a new ndo_update_offloads callback that is automatically
invoked during feature updates when upper/lower device relationships change.
This centralizes the feature computation flow and removes the burden
from individual drivers.

Changes:
1. Patch 1: Add ndo_update_offloads callback to net_device_ops and invoke
   it from __netdev_update_features()
2. Patch 2: Convert bonding, bridge, and team drivers to use the new
   callback, removing manual feature computation calls
3. Patch 3: Convert net_failover driver, significantly simplifying its
   feature management code

*Discuss*:
1. Should we set ndo_update_offloads after ndo_set_features? Or maybe just
   call netdev_compute_master_upper_features() in ndo_set_features?
2. Do we need to compute the offload feature for hsr?


Hangbin Liu (3):
  net: add ndo_update_offloads
  net: use ndo_update_offloads for bonding/bridge/team
  failover: use .ndo_update_offloads for failover

 drivers/net/bonding/bond_main.c | 10 ++++--
 drivers/net/net_failover.c      | 64 ++++-----------------------------
 drivers/net/team/team_core.c    | 11 +++---
 include/linux/netdevice.h       |  7 ++++
 include/net/net_failover.h      |  7 ----
 net/bridge/br_device.c          |  6 ++++
 net/bridge/br_if.c              |  4 ---
 net/core/dev.c                  | 11 ++++--
 8 files changed, 42 insertions(+), 78 deletions(-)

-- 
2.50.1


