Return-Path: <netdev+bounces-249723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A285D1CB85
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADA7F3008F4F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5B236B076;
	Wed, 14 Jan 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoQPAe4v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA92D0298
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373398; cv=none; b=fE6smYH62rvvU06OnP+Ydb/eIBI2zoGXV6NpeCsNON3YwaeIzq+X6HpInt7Evi82e3Hv35IHPQKXT8wZU8Vo/QwmHMrH2IR2EPZoj4boDmOJR8eMoAA5qAlWh8x/ARUteI79JXCIL8fqseC8moJNaZ2/bSozKA/dqm8kqqTWeZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373398; c=relaxed/simple;
	bh=R83SnLC3hEHC9wZZDBppvcqZrdMQG+Fw3T4DHIz875Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SblGISfz3zMTofyayl6RAkH8UNtXyGXrpEv/ypVh+9Hn7xVN+QRv/9XbfeI9unMYlgwghyN2XKQ0Rc5vlusJvRavU8mUWAW07fMxjrHCT0zyGB4VE/ig8Ta3HhbMlkswXjTdS6QmpTaS37Lh2xlWit/ot3kLciYBP8nWFCSqBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoQPAe4v; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a110548cdeso55720195ad.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768373385; x=1768978185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSq5SKgkR03RwVwaqOkyPPbDCNJIaruy2ZKmaKvy1cM=;
        b=OoQPAe4vuKys/P9R2dcUqvba9QGhB3QLGHv7SKlE91MV2vbaqpWOSWVnZZ8uEXXxKH
         1mbphLdzzXOrq16wfXvkcLpAaccNHJtOGUgpMKyupxY0ibpvS3NLZbRZ4Tprznh08IAa
         TndruNaV/GYLq9mq1zTDL4xZcMxUdhP5loq+JIKW95uxoroXPsK+8byKOkNlwz/kaaXM
         jH/aXgLSqRehdFCsafNF7F0E4R/PmM88cZJhisbD5mzLyMYtSvse1ZJmRTJE2ZKag+X1
         qqVC/XKa/QdcQSeW5Vljekoqav3Q+XIG6d4WClyXNahbw8QGDpRTzQEHOafWzmBhG3GJ
         gb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768373385; x=1768978185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSq5SKgkR03RwVwaqOkyPPbDCNJIaruy2ZKmaKvy1cM=;
        b=dzIl4K/ejSky92Knzk4FVNJVHG6sDdXzle7z+aC6eGj8lCkiuPK+hXg2bJKg04Sovv
         J0c6utv6/aWVUc2ZfM/HnrRSxsL/OSAchbXZu65mFAV7/6zJHIUtBOAdw7bYar41z3ht
         FTdUyvGoDQxZ7KDLjK0srv8ul1t7r32Ocat7N1ULTnuKF0r+6BCfFUfILUAObSRBc92p
         T9g8lfURZuwl3r4ruh+e/cjbHWv+Lrp6NnAYrEEe+fcsxPdBJFElyA7YFQQIv3nNOBOl
         YwrzeSaOLJSRDZfHJD7m19mMqQ8lgtEcEb33YkpjYtA42PqGesAv4GnMhLKXp5ObCgUs
         50EQ==
X-Gm-Message-State: AOJu0YyaH6l+L1CepzJIWFQDl4VopZWIHEYuZD1clD2PfkLhwo4vqSmF
	72zNFL3P/OX8IynyA9D8ILsuAWzoqZkxzsfPGgpeGdew5jbpoQVu6P3oua/aYFiM
X-Gm-Gg: AY/fxX7OW2QBOSfID5J3A6+zi5GS+PkOc5v5szEOEe3dywXk7M9sG89PXmPGRO5BKg1
	oM12nH9oo1tZVo9t+0awXYih6j/VyFVCbjws+v6PlIFceqRER/eksdgp2PRJYBpR7023Nxjb4f+
	ZQIMeMNJuJYZ88EJJlDQpmgYMmCqAR84pGeVlO1Bt0gnUUa+b7cKGrfnHfZogiigc+NtfwvFSAs
	JwV4fKxeeAzK+Dy+gbQdx9YwrcxNaRvNKecCxbBRh/j+k0xE8U7xL0zf9wpHIpPTsdMJ+PnkJdZ
	Hnhv18hqVFuJ2MqBhrBiETVj0fpPimvmxhWeeCPeXtExvxfSVN8zk0fQI/rNX3trGYId/LE5bBr
	SVVVGR3QXvvffFOg41O5bZZbLWWSjaGtRqM6KgMvPzrmhA0D13G6Xm8HmvdC8lyh+y9gdBkj17P
	H3t3YJRAI4JXYwgb0=
X-Received: by 2002:a17:903:18a:b0:29d:6b8e:d565 with SMTP id d9443c01a7336-2a599e28a55mr16305815ad.38.1768373384983;
        Tue, 13 Jan 2026 22:49:44 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm96315525ad.98.2026.01.13.22.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 22:49:44 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/3] bonding: fix 802.3ad churn machine and port state issues
Date: Wed, 14 Jan 2026 06:49:18 +0000
Message-ID: <20260114064921.57686-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes two issues in the bonding 802.3ad implementation
related to port state management and churn detection:

1. When disabling a port, we need to set AD_RX_PORT_DISABLED to ensure
   proper state machine transitions, preventing ports from getting stuck
   in AD_RX_CURRENT state.

2. The ad_churn_machine implementation is restructured to follow IEEE
   802.1AX-2014 specifications correctly. The current implementation has
   several issues: it doesn't transition to "none" state immediately when
   synchronization is achieved, and can get stuck in churned state in
   multi-aggregator scenarios.

3. Selftests are enhanced to validate both mux state machine and churn
   state logic under aggregator selection and failover scenarios.

These changes ensure proper LACP state machine behavior and fix issues
where ports could remain in incorrect states during aggregator failover.


v2:
  * The changes are large and not urgent. Post to net-next as Paolo suggested
  * set AD_RX_PORT_DISABLED only in ad_agg_selection_logic to avoid side effect. (Paolo Abeni)
  * remove actor_churn as it can only be true when the state is ACTOR_CHURN (Paolo Abeni)
  * remove AD_PORT_CHURNED since we don't need it anywhere (Paolo Abeni)
  * I didn't add new helper for ad_churn_machine() as it looks not help much.

v1: https://lore.kernel.org/netdev/20251124043310.34073-1-liuhangbin@gmail.com

Hangbin Liu (3):
  bonding: set AD_RX_PORT_DISABLED when disabling a port
  bonding: restructure ad_churn_machine
  selftests: bonding: add mux and churn state testing

 drivers/net/bonding/bond_3ad.c                | 97 ++++++++++++++-----
 .../selftests/drivers/net/bonding/Makefile    |  2 +-
 ...nd_lacp_prio.sh => bond_lacp_ad_select.sh} | 73 ++++++++++++++
 3 files changed, 146 insertions(+), 26 deletions(-)
 rename tools/testing/selftests/drivers/net/bonding/{bond_lacp_prio.sh => bond_lacp_ad_select.sh} (64%)

-- 
2.50.1


