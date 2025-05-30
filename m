Return-Path: <netdev+bounces-194294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3297BAC8611
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 03:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C064A4959
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1DD155A4E;
	Fri, 30 May 2025 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ezXJMaqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE04C8E
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748569802; cv=none; b=eW9WXv08SnBA4dehG5vi70MRt2lhIY8fmgmtWBOZRhcgbfbih+9q7SBKZDteQftrXZz0QJG+7nRbJM9jRiL2gE4D2xbF96RVuslYjU7HA4/o7q7Ux3bkuymK3CoJAt5Pz1LsnvBUiMDTTfIUHgHMGFEwUX2q4d9SaMQSizY0Sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748569802; c=relaxed/simple;
	bh=CveUHtuP1DptHh8ecfltHD6hRz2GDjqnTk2DrPj0YRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iwlfNjqTd+6ra/Ju4qU8S4dLDaLH+nLAi/iw5efg0AO2NNOEOpV81aXhSfUSpW8d8QE/B+acFLXV22pCc0wtu+FpeSIWcgFewuY1P5VNZhZ6l/0aYjIuYMAkFPbcxWva3YiqPsk/CuH7KUFscIz/DiQHSK3nOuXKQapaaIhamps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ezXJMaqs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2353a2bc210so462915ad.2
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1748569800; x=1749174600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=USkdCPHF2PH5TA65vT+omww+14Kmrvo8xr4kQydMtxQ=;
        b=ezXJMaqslCLlNKM9i1+hOJzpaK/oN8rAv3zj43+6OkTaW3WUtBnHQIDndjbejVB+l+
         aYrFR9mG0PhlrRM8QiZJxU77NEefx+Tx+I6L32AC+jZbpbn75hRsuE4/OWNbQElVC/LN
         kowRAtStycOV8YEzN3ooyAkDhJtUK0T0hkHDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748569800; x=1749174600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USkdCPHF2PH5TA65vT+omww+14Kmrvo8xr4kQydMtxQ=;
        b=YPUZmhEZCvFU8SVInihry0MMAyvjnSPsR6BFuyuDDunKAWU4nU8vkLLBC85uKNK+Oj
         wvRhJUeuu9aIb3wc+RNblYmZP+qFgVyb6nDFt8XyZDo/6gKZ5CAw34LN3i5DwAtc0QFn
         fqjfkkjo0ENRHXzCZZuwvRjqIC08iPQv0iTuPEmOyLhJmrTPXZLEDnV+SI1tKQglU3uN
         TQ7py7aLTFBoGCa9aFhaBpJFM+TCiUTCjkbLSGpXgLpF88/uDRWPzOuATAbjuK8cozGl
         EEr7FJW9QdTwTBYJC/S1zt/+iPcl1AkC9DGD0tlkwvHnDWrfH14VGyOfMcJWJ7cFzz3z
         X+qQ==
X-Gm-Message-State: AOJu0YwM6lUd7VmSQJCs4P73ZHz8eEhBsiIBpzjl19v58owSQJ5/EdL8
	tQWYpWQCdFy1WsaIY/7fY7rIqDdK83OGJ0UAb7cnv2Ge+dOphcjcXdf6g8FuaHpgmEfPlojYTvy
	/Gnhf6EFnZMMkMWa0Ich8TJuJC8cXY4/iBjI4BfTXRKfTKw0j/NLNZmX8ZTSCFZ/qreeqWVoceO
	H4OJ9VirXc33vytk+wB8s26mCSM0m7rsFOVOscl/4=
X-Gm-Gg: ASbGncu8nJbdWwCbcSznclr/JiaoJ4gTuJeqwFNolGEhLKOJl4SSS1vEjrztlQyBvWO
	Q3F28mtvJnJVrEUmZRAtVtfrgUvAinGUQtemCl3Lzo2i5TlVPRl2QZIDYWU6AOrUzpj1dzEC93a
	xZL5xcUoimLkhDHR1ujjnlCVXII1D85zCbPOnQXYfIQc+uk/gDQTkP/GtqM2aCmo/NNMiXYjDMe
	EL4M2hSWKUWIj/ptVMbtc9CEVDcghxrfVw+ZZ5/+DAwsECh5vAP+t1FyeNB3Sy5cMeHSa1ixQPe
	Vu1Cw8Y3YGWjEqCUl4FuDximBAMosbaZ2gCP4MfCoHBpwjjDvDwT3E0QIfs=
X-Google-Smtp-Source: AGHT+IF30dyRi/lEN79RRLEUtNpNXnDs814PCaa5b5ybHznKzvJuCfgL1TejPuzA/dDpqBg0EpC+zQ==
X-Received: by 2002:a17:903:2f89:b0:234:eb6:a35b with SMTP id d9443c01a7336-235396e2b3amr5777265ad.44.1748569800003;
        Thu, 29 May 2025 18:50:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd8c35sm18316405ad.154.2025.05.29.18.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 18:49:59 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	stfomichev@gmail.com,
	john.cs.hey@gmail.com,
	jacob.e.keller@intel.com,
	Joe Damato <jdamato@fastly.com>,
	syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net] e1000: Move cancel_work_sync to avoid deadlock
Date: Fri, 30 May 2025 01:49:48 +0000
Message-ID: <20250530014949.215112-1-jdamato@fastly.com>
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

As reported by users and syzbot, a deadlock is possible due to lock
inversion in the following scenario:

CPU 0:
  - RTNL is held
  - e1000_close
  - e1000_down
  - cancel_work_sync (takes the work queue mutex)
  - e1000_reset_task

CPU 1:
  - process_one_work (takes the work queue mutex)
  - e1000_reset_task (takes RTNL)

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
-- 
2.43.0


