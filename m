Return-Path: <netdev+bounces-138010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F299AB7A4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 22:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C41F2376C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 20:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0121CBE94;
	Tue, 22 Oct 2024 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgK3n1Ss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162E1474A9;
	Tue, 22 Oct 2024 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629165; cv=none; b=o08NU+j70m3+SsCyllbetuileEjck4PIcp0oNIVpvTCS6rr3F+9o6IehIBhPZsK+0tIatAzVdQEplvsZreqVN5adqbvAW2TxU+Z5I3yxoOvzl1Z6oNx5innLr+gP9zX6ERQU1+LeH9kXbW8BcXtFqutJM3OGDC4tP2pSo7UhFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629165; c=relaxed/simple;
	bh=UeVT67coF+dsRLgWQ++/Sjd/zmllkbNnFB/WlVA+bKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+ffbn7qHxQ9zBUw7lXh9QA5RnBaK0NClxJtZDXbXb0lQCa4lMvUZo97rngegLcVjKZSUmwYYkgwihNieNu/M5T+yHhZijvIQEBKnETDxTVml1NSpjfQd7HbCR2df65p3TlnUDRN2xJKtHbKMZIGIXYYil80impx+98cJpmFIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgK3n1Ss; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c805a0753so52819045ad.0;
        Tue, 22 Oct 2024 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729629163; x=1730233963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZ+4PADPN2uTECD/Dh3GFRRtK+3UQEC1z/LtDuogd5I=;
        b=QgK3n1SsJQsTLL53RLXW34D3mQo6915opstUdRkPMYT10Gld1SKKqVN2hTZKJ+WmMF
         YtlmrOqANZa2Iddw6DAoMkJnyR7FqJCMx3AXIDeIg6qkYtEzkypg4v1Y0yKVAWxZSlD4
         CfybZ034Rp1RuhJRWMevXskJJhWmQCv9xHBslV1K07QGV+r0CqM5QKeu3MHJHjH0vjvF
         q5ZAD/THVkwed0bvQm4d1gfdEtTImcAwmNPVhdhx3Dst0bvuUDPs5icTxvcMT4zDRXL6
         /UOHbFVMSGjAwE8V4XDt5/8tZ4WgqRqt596jUKENzyLkizWikOdXugFnQHThqKMgv6lL
         j1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729629163; x=1730233963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZ+4PADPN2uTECD/Dh3GFRRtK+3UQEC1z/LtDuogd5I=;
        b=LAZBKwI0VaTMpeTuGaknkv2ebxyctp/CwA464E/jJcGYT1tZZ4qgL/69eNIOukD1A9
         yV0awBLr02UmhbI+MAEk2paZ9igOVwXxsVU1C61ZRQ1Gz4NvltiNPQxZeD/R/B/JKBpU
         86ywHY/4jkdXrCaT5/bkhIe2cIwHmOOVMLqf6UXFTORlVAue8mimPbJbVuLvsGhk3Dve
         cvDGPTHy6tLAcNhhBRLWGMbv6YB7neKfTkB9tIvniEJjpl45DtfNUgIkQ27KBrJOr+DH
         MsWlbtsBEyPrHJmIJWIX1ZqPR3myB5rM1ze9v+PFFVS6KR1YytILq37oiBoEjsqpmhER
         +Lrw==
X-Forwarded-Encrypted: i=1; AJvYcCUNp+K/uuyk7tkyf9InKZzOmMyCPeq6CsDuQhACNF8SoHQdHBIrlHP+jhqCLxhSL52qY7R/sTt4X2EtFZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrda9Kh3+uQhKExxV1ubi50w3rHIzoFyFayNpHHymhVHxNux5W
	D1VfWCLcQvC4pNrwCQSTo6ucl2qKWaF1JzsRdsWhNpa/OLZqWLMFoGglzdbY
X-Google-Smtp-Source: AGHT+IGcDqy20KPoabg7ESPBAC5OmxPOAcjQtMj/wH5Mv0MFuAdhMh+A6qVzGB2rUcn/bbgjEQMb9A==
X-Received: by 2002:a17:902:c945:b0:20c:da66:3875 with SMTP id d9443c01a7336-20fa9e5405cmr3800315ad.24.1729629163038;
        Tue, 22 Oct 2024 13:32:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0dd53esm46521235ad.222.2024.10.22.13.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:32:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] ibmvnic: use ethtool string helpers
Date: Tue, 22 Oct 2024 13:32:40 -0700
Message-ID: <20241022203240.391648-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They are the prefered way to copy ethtool strings.

Avoids manually incrementing the data pointer.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index cca2ed6ad289..e95ae0d39948 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3808,32 +3808,20 @@ static void ibmvnic_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 	if (stringset != ETH_SS_STATS)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(ibmvnic_stats); i++, data += ETH_GSTRING_LEN)
-		memcpy(data, ibmvnic_stats[i].name, ETH_GSTRING_LEN);
+	for (i = 0; i < ARRAY_SIZE(ibmvnic_stats); i++)
+		ethtool_puts(&data, ibmvnic_stats[i].name);
 
 	for (i = 0; i < adapter->req_tx_queues; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "tx%d_batched_packets", i);
-		data += ETH_GSTRING_LEN;
-
-		snprintf(data, ETH_GSTRING_LEN, "tx%d_direct_packets", i);
-		data += ETH_GSTRING_LEN;
-
-		snprintf(data, ETH_GSTRING_LEN, "tx%d_bytes", i);
-		data += ETH_GSTRING_LEN;
-
-		snprintf(data, ETH_GSTRING_LEN, "tx%d_dropped_packets", i);
-		data += ETH_GSTRING_LEN;
+		ethtool_sprintf(&data, "tx%d_batched_packets", i);
+		ethtool_sprintf(&data, "tx%d_direct_packets", i);
+		ethtool_sprintf(&data, "tx%d_bytes", i);
+		ethtool_sprintf(&data, "tx%d_dropped_packets", i);
 	}
 
 	for (i = 0; i < adapter->req_rx_queues; i++) {
-		snprintf(data, ETH_GSTRING_LEN, "rx%d_packets", i);
-		data += ETH_GSTRING_LEN;
-
-		snprintf(data, ETH_GSTRING_LEN, "rx%d_bytes", i);
-		data += ETH_GSTRING_LEN;
-
-		snprintf(data, ETH_GSTRING_LEN, "rx%d_interrupts", i);
-		data += ETH_GSTRING_LEN;
+		ethtool_sprintf(&data, "rx%d_packets", i);
+		ethtool_sprintf(&data, "rx%d_bytes", i);
+		ethtool_sprintf(&data, "rx%d_interrupts", i);
 	}
 }
 
-- 
2.47.0


