Return-Path: <netdev+bounces-194804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38221ACCB5A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 18:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0293A3CEF
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F60192580;
	Tue,  3 Jun 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dL3X8bF1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA58179A3
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748968449; cv=none; b=O7+9ujtE2P9BrHSsEOt8xylRYnPsNVFrGpscmMajMNDpwY6n0XypuT2oyfX/XiIf8wDCxyeJZqWyEIIJ7YlENajIdaDxnU8INbcI8ctcG63idc9k7z2BLjgadqR4PeLig/xGQNJqBpTF9xRta/CayBPDqNVv5+s44eWom3zKkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748968449; c=relaxed/simple;
	bh=nlLPe4JNT/I7zrGVVpCD4KiakPXWJEJV8KoS2+0nDE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEA3sIbIBqqqMRqfPenzWAyvH7Gmqonh28Q+hrAYsRKOEcnlwnceX1IpPvsoKHmYgsV6C2/mUbF5pyWdMtikgPvYYG0iK45S1rVUa3MLaHtRUn6+m/wnEyhPQAJvG3o+ciUTKziZw/H6jv8mDwm6FJSOOSiBxQmW9Ziv/HqO0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dL3X8bF1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23508d30142so61224865ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1748968446; x=1749573246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVPg9RSU5+0wf5EHqV7EnA6nX7rFFrDnz8hGU29mQNM=;
        b=dL3X8bF1bN8aazE/WVkQOSJUQBEQvuckfDCxs+yNAwNdl3CqFTiEvclmuSBobZkfXO
         hoRlSPrlpGx/e2AeXU9jrBSYk4gDcAgEbPebP/bVnLw+9JRe6EiDao5MbzEX8SwtZKbo
         1LUVF23tmslwhhEArYozqPRE3iUsFN04Kb+XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748968446; x=1749573246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVPg9RSU5+0wf5EHqV7EnA6nX7rFFrDnz8hGU29mQNM=;
        b=gkIvZwEpASzGxHJ+ltc6muswt2pPOXPyi3UIPzTtwWSomDY6RLLN3mGcR81g35748e
         MKzNaNO8T8VT7CfLdfllKU/yF8LHnW9NDtAEbMidiCSl6vWqhTATG3OD3nXmzvqks3Jz
         +Nkb9Q+66Ys7tDerAuQ6ndju+yj4JR1cvl9kim0xUQI30ZHLVC2uQD+HB2GHLeMLFbm+
         4r1EofJ4QTlfQzLTUCL8lPYdVV9DPUSvBQq+X4RcAMkDSUZ6nVd6Gh9QD5Zb7MPzNmJ0
         J5JO33waN31mQqYSALMz3CrouueIRd5maIbbjoQmLCYD7O13bOyv+byILVHsA0bhRA0Y
         vZEg==
X-Gm-Message-State: AOJu0YzzI6f5gQyDGKa0ODR4UnRgaKLu1E2xY+5GV72A5ER9mwEBxB7a
	WE7zweIpfLn/yRBDEXaBV55gpVmawveGqpJ2Rth6k4T2vrMizM//o8UMux2Klb9QWysQS1EpUyY
	n58k6Ded2fNoGXuIozIxqOLhsvEbyNWQ4rhzwZVu5lZElH0z05yOQLElkZYDHfpCx0kJqRDOzwJ
	XTH0BMUGmOMFPCUjafwUXjS59G7TVR+ngGDW4QK6o=
X-Gm-Gg: ASbGncsmRO2gJ+7Y7GJc6TFRIHB36mEMeio8jOFJ+zcTbHfNB2dPN1w+ojQDMegbHFV
	iXeaowcnCrNcZXbn1+WdhknH4MCsEP25vKEz2Z1qHkZ8guD1BkY8w0CFdNBAZKuKsyf4rIX7Xl8
	NKAO6/fIXY72UcnUZQAEx6GDkF4KYkTy/HMhcYYEaeI6bPzP/6PYntyzbCsfsT6y/pS9ihFnAgM
	xuODXFAxbIs6jXq5cXNixJo0ajLADMbIrx7nJmTKfJ8P2VClIPaLvVa+7KDppXFNl7CEUVeFD3T
	Dnb7GHqJ2Lav3b+QZQdebU6ERytGy8xvrbUIp4TSMuyhQSrsb3pNo+t/pK4=
X-Google-Smtp-Source: AGHT+IEsG8RwJJ/qUZ31YozpAFPSnp5YLObkgNdPKm6K9ikVW9NpcBa7mfYOTaEM2xDXXZhOeTyawQ==
X-Received: by 2002:a17:902:f642:b0:234:de0a:b36e with SMTP id d9443c01a7336-23539648068mr242371285ad.49.1748968446027;
        Tue, 03 Jun 2025 09:34:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3723sm89477255ad.133.2025.06.03.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 09:34:05 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	john.cs.hey@gmail.com,
	jacob.e.keller@intel.com,
	stfomichev@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net v2] e1000: Move cancel_work_sync to avoid deadlock
Date: Tue,  3 Jun 2025 16:34:01 +0000
Message-ID: <20250603163402.116321-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, e1000_down called cancel_work_sync for the e1000 reset task
(via e1000_down_and_stop), which takes RTNL.

As reported by users and syzbot, a deadlock is possible in the following
scenario:

CPU 0:
  - RTNL is held
  - e1000_close
  - e1000_down
  - cancel_work_sync (cancel / wait for e1000_reset_task())

CPU 1:
  - process_one_work
  - e1000_reset_task
  - take RTNL

To remedy this, avoid calling cancel_work_sync from e1000_down
(e1000_reset_task does nothing if the device is down anyway). Instead,
call cancel_work_sync for e1000_reset_task when the device is being
removed.

Fixes: e400c7444d84 ("e1000: Hold RTNL when e1000_down can be called")
Reported-by: syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/683837bf.a00a0220.52848.0003.GAE@google.com/
Reported-by: John <john.cs.hey@gmail.com>
Closes: https://lore.kernel.org/netdev/CAP=Rh=OEsn4y_2LvkO3UtDWurKcGPnZ_NPSXK=FbgygNXL37Sw@mail.gmail.com/
Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3f089c3d47b2..d8595e84326d 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -477,10 +477,6 @@ static void e1000_down_and_stop(struct e1000_adapter *adapter)
 
 	cancel_delayed_work_sync(&adapter->phy_info_task);
 	cancel_delayed_work_sync(&adapter->fifo_stall_task);
-
-	/* Only kill reset task if adapter is not resetting */
-	if (!test_bit(__E1000_RESETTING, &adapter->flags))
-		cancel_work_sync(&adapter->reset_task);
 }
 
 void e1000_down(struct e1000_adapter *adapter)
@@ -1266,6 +1262,10 @@ static void e1000_remove(struct pci_dev *pdev)
 
 	unregister_netdev(netdev);
 
+	/* Only kill reset task if adapter is not resetting */
+	if (!test_bit(__E1000_RESETTING, &adapter->flags))
+		cancel_work_sync(&adapter->reset_task);
+
 	e1000_phy_hw_reset(hw);
 
 	kfree(adapter->tx_ring);

base-commit: b56bbaf8c9ffe02468f6ba8757668e95dda7e62c
-- 
2.43.0


