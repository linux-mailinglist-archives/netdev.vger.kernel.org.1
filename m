Return-Path: <netdev+bounces-127697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE79761C2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE422286102
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B218BB8B;
	Thu, 12 Sep 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEXNTh35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B71282FB;
	Thu, 12 Sep 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123448; cv=none; b=VEUqQxdiUuopBUsN9/fjwL9ElgavjtG/if0ZnTRu9yIbOpeX6KKwHKNQI74c2WVYHeOgedQJi/7wQsDAGPqneyO24UflflMLZ3cJpPTyCiwiZDQJ4x6LLbw+UvFAdvLflH62El23iPXqUPlFzCKge8zgO8fQnm6cvTtUaw1HIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123448; c=relaxed/simple;
	bh=RIg5FqMY3WCyjaVG7wZTmaeOMd2Lc0QI9AIKIbcjRBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJEP9EmyQCoZMpegBGJ899fzPDkVhxV3Z8db/ohZ2RkCPCJt+YxB5PqD9bnzlUsoLnBJPUkI8H87Gs2iENyT6R3rTaAnenQwxLv9X8I3h252koOjF+r2DKMUmDyR5ccOdjdhE6B0p8foda3jlfMsZb6gGmgfN53tpE7H1wr7sZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEXNTh35; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718f28f77f4so535854b3a.1;
        Wed, 11 Sep 2024 23:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726123446; x=1726728246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7hy43Re2oXJOlp1c0ylXP5QjQeV2Hny88PsAJJ3TBU=;
        b=kEXNTh35ZUL3OHwQj3nkct2ceGOPrID3DD+bJIIoriRz5/r0kjgjKCPx1SDTVv38Ed
         GyOy4qhvNo5XWoojvgX6ZNnl2mGyFDiC22HLXRxj9md+70r3iOJUUHuNRl5n06LP80vc
         eUqkFqkiLdYB3QzzdROIN4UuuU7AOws/O4vaG3vysE7IRA8Ai4B/wzKHgGYyWyurPK1D
         cJG3jSUrhQ2EYNOeokLX8qN0czLGRHGABls2gMdblygFBvMkvxMUqI/FF3mg68sjNggH
         NlTTNrHZl7suKRpHlC3OTKWC+pOHJQSqDD9pBiLJFFX7YL4Prx7RbW+8Ud/hBBQsFBh5
         rTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726123446; x=1726728246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7hy43Re2oXJOlp1c0ylXP5QjQeV2Hny88PsAJJ3TBU=;
        b=lMShP0c6It5rN3rKbtJT1dugiHhqc01EXI3a7dWDFq2IrUTMavV8d2ccmy0OmoGNk2
         wlKYTCgv4nsPxtpgcLlFk2eO5c8qRh8rlwnMqOuM0wCgxpIZa4scJ1kq9krAQwi+UGsu
         8iIIgEoJv6kln/+IMJvsFGcPpPWqBS4p7E84tiHk/M2tlLGP5PyfeIp1XIgFHHeLmnVF
         XCzwEVOplVAHbTjO28i7ipLc6ZTBaQDGwKvK5HlVRfY48nvEmVl9yg0k9ubFY5OK7Lqx
         wkXfr5yQnyOGCfy/rC0wZguptkyLdcDmBPZk+wl67k6UInFi71a6Mx5D84BOa89gobXf
         NNjg==
X-Forwarded-Encrypted: i=1; AJvYcCUZF54Eql/m89hib4RlkycRgzDvKqNkVoH+ToNbpZ2raOx3HO27m5bHP59csN9pIVXWSRju7IWtKdse30Y=@vger.kernel.org, AJvYcCVKNQSiYYZTw+7yzPPAljiXIAvD8OGrJwjVu5RN+PEAolc4MSS//55VHbzKv/vFi63cEAnocNf0@vger.kernel.org
X-Gm-Message-State: AOJu0YwyzUoC4Hav1uidxzTlKNYzo99jN4ixkx9ec2bSXTNBNRwSkJX1
	17LX3bHiREeeW0hHlVRWmyntcA2EMbTXL0zK4NqSo8QVOQKX9GFT
X-Google-Smtp-Source: AGHT+IHtS+LhpiXKHiUQ6YZQT+Z2rziYfmj2WgD9t7Oybxe3a3jJ3OAbYWbkecS+lUjr9ilVuJ5kSQ==
X-Received: by 2002:a05:6a00:92a6:b0:714:25ee:df58 with SMTP id d2e1a72fcca58-719261e772amr2789330b3a.18.1726123446302;
        Wed, 11 Sep 2024 23:44:06 -0700 (PDT)
Received: from fedora.redhat.com ([2402:e280:3e0d:606:d0c9:2a06:9cc6:18a3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090ae309sm3948927b3a.164.2024.09.11.23.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 23:44:05 -0700 (PDT)
From: Suresh Kumar <suresh2514@gmail.com>
To: jv@jvosburgh.net,
	andy@greyhouse.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Suresh Kumar <suresh2514@gmail.com>
Subject: [PATCH] net: bonding: do not set force_primary if reselect is set to failure
Date: Thu, 12 Sep 2024 12:10:43 +0530
Message-ID: <20240912064043.36956-1-suresh2514@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when bond_enslave() is called, it sets bond->force_primary to true
without checking if primary_reselect is set to 'failure' or 'better'.
This can result in primary becoming active again when link is back which
is not what we want when primary_reselect is set to 'failure'

Test
====
Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)

Bonding Mode: fault-tolerance (active-backup)
Primary Slave: enp1s0 (primary_reselect failure)
Currently Active Slave: enp1s0
MII Status: up
MII Polling Interval (ms): 100
Up Delay (ms): 0
Down Delay (ms): 0
Peer Notification Delay (ms): 0

Slave Interface: enp1s0
MII Status: up
Speed: 1000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 52:54:00:d7:a7:2a
Slave queue ID: 0

Slave Interface: enp9s0
MII Status: up
Speed: 1000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 52:54:00:da:9a:f9
Slave queue ID: 0


After primary link failure:

Bonding Mode: fault-tolerance (active-backup)
Primary Slave: None
Currently Active Slave: enp9s0 <---- secondary is active now
MII Status: up
MII Polling Interval (ms): 100
Up Delay (ms): 0
Down Delay (ms): 0
Peer Notification Delay (ms): 0

Slave Interface: enp9s0
MII Status: up
Speed: 1000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 52:54:00:da:9a:f9
Slave queue ID: 0


Now add primary link back and check bond status:

Bonding Mode: fault-tolerance (active-backup)
Primary Slave: enp1s0 (primary_reselect failure)
Currently Active Slave: enp1s0  <------------- primary is active again
MII Status: up
MII Polling Interval (ms): 100
Up Delay (ms): 0
Down Delay (ms): 0
Peer Notification Delay (ms): 0

Slave Interface: enp9s0
MII Status: up
Speed: 1000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 52:54:00:da:9a:f9
Slave queue ID: 0

Slave Interface: enp1s0
MII Status: up
Speed: 1000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 52:54:00:d7:a7:2a
Slave queue ID: 0

Signed-off-by: Suresh Kumar <suresh2514@gmail.com>
---
 drivers/net/bonding/bond_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index bb9c3d6ef435..731256fbb996 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2146,7 +2146,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		/* if there is a primary slave, remember it */
 		if (strcmp(bond->params.primary, new_slave->dev->name) == 0) {
 			rcu_assign_pointer(bond->primary_slave, new_slave);
-			bond->force_primary = true;
+            if (bond->params.primary_reselect != BOND_PRI_RESELECT_FAILURE  &&
+                bond->params.primary_reselect != BOND_PRI_RESELECT_BETTER)
+			    bond->force_primary = true;
 		}
 	}
 
-- 
2.43.0


