Return-Path: <netdev+bounces-68897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662CC848C44
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 09:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934B11C22B69
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68411C88;
	Sun,  4 Feb 2024 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+OIF3p4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE114284
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036703; cv=none; b=MJg+uATB9j5qHofM0d3b1E/WxXUUCQZz51bBYKQ2Fw14TH5jnxzGLHYuFSS/Oya8vRb3qu5sEDsiHXqCHjL1TROXaf5DtO51kWo7IDJLITecF5Wm2bKt9WKE+h5cYJhbcdPchTIxZDceGVYYYT6ikzo1JGSBCOnZSsDGGKnOZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036703; c=relaxed/simple;
	bh=x7+KTXbxhZvO+kRL3f1yL0fKyIkdlMSd/T+/s0p+0SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajqXbEmoSA3xUCz3m7NGiOsI2k5jS5FsyHqxmFDQVX/qpoAjERh9S09DDyg3n77IBtTVBDGvQpedYhH7ieUw/ki+xHdOBUxYnXG/nwp31OMH2wFGc1xbyDPdKT+Dq9WxOZydTkf9LGqyeSuwS75H/SWdhalp6DiYF95+ZFo3gz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+OIF3p4; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bda4bd14e2so3084161b6e.2
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 00:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707036700; x=1707641500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr5Ma53ZIQFxVlqjjt3fvMokaHC0OGqyDT7hT2pvB9c=;
        b=B+OIF3p4gnoGCjWva0vho5DTrJ44KYEbzTSIc90XXXbY8WZybt39OdIZ1Yl7cfezXI
         euw75nXPLIhE+l4GqKTlHzWtZ4o94O03wjasrck56sOzJejvjPZ/4v8wdFoYzPAP8J8R
         jVmdgbJdpvnc9UkIMOZYzzgkVcVvUYG3pvR5QYzjR+GyXyYvu6bG2RB7iWlqani3PB/V
         coQ4+yOc+a+Yo2cF4HAxP8Xxp48TjX/PgKFWGXXflmOpdGrMtIFOi+X7RRHQz7l0KnZ5
         sEEYj1xXioXwFT26yUHUuYVMfVrVbxaoVuITlU2eqZsqtxmr5iTCQ9K15CtILQbzKfu2
         oUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707036700; x=1707641500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jr5Ma53ZIQFxVlqjjt3fvMokaHC0OGqyDT7hT2pvB9c=;
        b=pJ1n2RwUMOsCoPCc+Gm/uvuFWmDc6ZeWU2lTgn/tGWlmNMnrNieKngktwH2xAScLFL
         tpjnPcZe5G234WbpEWGT1fGBXyBTzJ9Gmx5/skbKvi/XpXTgdA/Cnd5khKWXtSVDZOYr
         6zRzupROrpDiGMH7jkueZBjhsGst4oF6h2BYJzy/0rHEYBeZwfkI8nFSadgpFdg5RjYz
         3toZyWKldks30YBJwDRC4AEBrlbvabMHcUV8UkqnMnklJxMd6NlovgTrvKgX1jnVDlo6
         b/kCRRCLu7opvPIxq4v2fq44LBCZNi8XNKyMep1wbBKbPsuwI1auRSiIdA5A7EDEtCd4
         RboA==
X-Gm-Message-State: AOJu0YwuH7+Tw4NhS7t3XOZUxZGsmlASzqwiBeG0jn2LHRMt8jkJCfHW
	P1U2pXmez75ID2kXsjiqC37FpP8gmV4Igc69T7HK/QKeWJJLDwnT/lkmmQtIpLcYQg==
X-Google-Smtp-Source: AGHT+IFXBY/aq6l6KMRC3CsePikWzxbFKeNmEsxgAXcnn1iJxfU3hq/3OaJDdBN52wGGR2aCfEjjsQ==
X-Received: by 2002:a05:6808:1589:b0:3bd:a199:cea2 with SMTP id t9-20020a056808158900b003bda199cea2mr15574721oiw.30.1707036700417;
        Sun, 04 Feb 2024 00:51:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUpaBePN8979opwDE3jV395aAlPNOBo7vNsbG4zMx2LtvVECFKWmictwL/rpt6WTG+Yr8eJsmQzVJHIwzf+Q5MuJ4r1prjEk//PeUSlcZJPFLDgOrlKDgJrlEBd7XcDkAJbFYlJPhabxDpHKcvCFcf8F5pM4ygWRyS/0XRV4eO2VjuZjjNP4MtfGx97X1MH8XCgW/yU3d3x6hPAozNd7QAT/NB5MSnHyX1f5rFSkKD+54b02yTd05EPwmxuH/0OJAZ55Q==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ka39-20020a056a0093a700b006d9b2694b0csm4398228pfb.200.2024.02.04.00.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 00:51:39 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 0/4] selftests: bonding: use slowwait when waiting
Date: Sun,  4 Feb 2024 16:51:24 +0800
Message-ID: <20240204085128.1512341-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a lot waitings in bonding tests use sleep. Let's replace them with
slowwait(added in the first patch). This could save much test time. e.g.

bond-break-lacpdu-tx.sh
  before: 0m16.346s
  after: 0m2.824s

bond_options.sh
  before: 9m25.299s
  after: 6m14.439s

bond-lladdr-target.sh
  before: 0m7.090s
  after: 0m6.148s

bond_macvlan.sh
  before: 0m44.999s
  after: 0m26.468s

In total, we could save about 200 seconds.

v4: Make sure the client could reach to macvlan2 (Jakub Kicinski)
v3: Rebase to latest net-next
v2: Reduce slowwait sleep time to 0.1 (Paolo Abeni)
    Reduce num_grat_arp() miimon time (Paolo Abeni)
    Use slowwait for ping result in lag_lib.sh

Hangbin Liu (4):
  selftests/net/forwarding: add slowwait functions
  selftests: bonding: use tc filter to check if LACP was sent
  selftests: bonding: reduce garp_test/arp_validate test time
  selftests: bonding: use slowwait instead of hard code sleep

 .../net/bonding/bond-break-lacpdu-tx.sh       | 19 +++++-----
 .../drivers/net/bonding/bond-lladdr-target.sh | 21 ++++++++--
 .../drivers/net/bonding/bond_macvlan.sh       |  5 +--
 .../drivers/net/bonding/bond_options.sh       | 38 ++++++++++++++-----
 .../drivers/net/bonding/bond_topo_2d1c.sh     |  6 +--
 .../selftests/drivers/net/bonding/lag_lib.sh  |  7 ++--
 tools/testing/selftests/net/forwarding/lib.sh | 35 +++++++++++++++++
 7 files changed, 99 insertions(+), 32 deletions(-)

-- 
2.43.0


