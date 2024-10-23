Return-Path: <netdev+bounces-138375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C29AD2E9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C059B1C21AF6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB71CF7DF;
	Wed, 23 Oct 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZDVEYmIh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5FF1C9DF0
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704487; cv=none; b=L3h6cPVgdMI4s8HCUqGPAiSS/YxvailVwZmW+Pa9aks+yHUlSmsoi+He9sSECUwe6OPFabp17+Pl9aeANimbCt7vD6yjeYUFXkEJbRsj2WGek6NTNYFq8nhlo0P5T8N4QfgCHjr4yPwbQxQ4Mrqt+tnz0PWIK/3Qab/gFYPsUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704487; c=relaxed/simple;
	bh=GEYst81Ty/eex+e2+Hr0maNmWSAdXTnCbjRB00LJ29M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nFdAeLKepl+PSSSetVMTNOaEXZg0XC2ReRS5d7Y/fJJAKoggL7OwGRReb49cecQ+hgQ8i56NjJHUz0sbGutRebFkfA7/6q7yDYmwPC08XFHqHT2NihgNDhLEml98IyrF65XUpNrWcouq5jqBq6urnTuAiaPmhRsBJQKiFjK0r/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZDVEYmIh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e57d89ffaso59779b3a.1
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729704484; x=1730309284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDXXNue6psjylQE85p9KLrQo9I2faybviN6SW/hT9xU=;
        b=ZDVEYmIhDRp8SyoLyZtMEE7cPMzPEhFf6F4gi43POvJDRLe+EGhqRxDeZ5mltYXHxP
         u+DpV9J4ncGABGz2ncAVQVNaXs4GAyACLRyiV6oNfU9Sr1A6lAulylCp820Ew975FNsK
         4F+RO+zhtRet9jSL+J7OR0BT0qsrZM47t7y9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704484; x=1730309284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDXXNue6psjylQE85p9KLrQo9I2faybviN6SW/hT9xU=;
        b=vlRF15BgZqRrsA34j1MackQ1xIcsh4Vxtfc3Vm4X9HX9O8AnNPvpGm9S7yvpIh081B
         CBW8abjoSWEURfLbqKXCuw8sNT5rTqBvsjlCigiICdvOj1k/MzveLX/ci63DrtYydFri
         gKBvF/PGOnApgutpvnsR8vSLqHIXrKBRRbRQZbGigVCoynkK1Tz4jjRSpzWk97Jz7Ug1
         WonxUrJLa8lXnojmb9y5uctMOrecZSg38/RhGRcenr+DCG0nQuatPKoG6TP6H1C6IXnp
         8ALYMG0mk9flNT9KfFqcTJJfQjBLqKPQ5YnrvE9lCtN8dvVjrLzufGlLr0wkIAi0auwv
         39Yg==
X-Gm-Message-State: AOJu0YwfgTVYc9ypnA2ixPM5hElZkChNkZCG6m0dizE89zNdnGqU6beA
	7Yc2VsUGdeXjjmnClSnHnEGdhntxX4kEh2HNCjqt4eH0XFGbnTanzqejP+Oc/QKzdT9rLXi8LEJ
	sy7izue6RD+AQLW4+MDsG9ZQG3/Pli08nTjDJ5Re4+VYk/BA0NzfbTrW040WZXStk7fsHM9ogbz
	AZrI0EQGdMl44Nvyt6jk27Qp7Awt54pyqb6vY=
X-Google-Smtp-Source: AGHT+IHXXArha9jNHjLZbUZOKXb2fAUQmfhtIzPjAskZgyUcPyxmLBYIsFCiKKKWKAuVsa/v95cbrA==
X-Received: by 2002:a05:6a21:3942:b0:1d9:17fa:e5d8 with SMTP id adf61e73a8af0-1d978b3e396mr3930524637.26.1729704484409;
        Wed, 23 Oct 2024 10:28:04 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13355casm6554748b3a.59.2024.10.23.10.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:28:04 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [iwl-net v2] e1000: Hold RTNL when e1000_down can be called
Date: Wed, 23 Oct 2024 17:27:45 +0000
Message-Id: <20241023172745.181265-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

e1000_down calls netif_queue_set_napi, which assumes that RTNL is held.

There are a few paths for e1000_down to be called in e1000 where RTNL is
not currently being held:
  - e1000_shutdown (pci shutdown)
  - e1000_suspend (power management)
  - e1000_reinit_locked (via e1000_reset_task delayed work)
  - e1000_io_error_detected (via pci error handler)

Hold RTNL in three places to fix this issue:
  - e1000_reset_task: igc, igb, and e100e all hold rtnl in this path.
  - e1000_io_error_detected (pci error handler): e1000e and ixgbe hold
    rtnl in this path. A patch has been posted for igc to do the same
    [1].
  - __e1000_shutdown (which is called from both e1000_shutdown and
    e1000_suspend): igb, ixgbe, and e1000e all hold rtnl in the same
    path.

The other paths which call e1000_down seemingly hold RTNL and are OK:
  - e1000_close (ndo_stop)
  - e1000_change_mtu (ndo_change_mtu)

Based on the above analysis and mailing list discussion [2], I believe
adding rtnl in the three places mentioned above is correct.

Fixes: 8f7ff18a5ec7 ("e1000: Link NAPI instances to queues and IRQs")
Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
Closes: https://lore.kernel.org/netdev/8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru/
Link: https://lore.kernel.org/netdev/20241022215246.307821-3-jdamato@fastly.com/ [1]
Link: https://lore.kernel.org/netdev/ZxgVRX7Ne-lTjwiJ@LQ3V64L9R2/ [2]
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - No longer an RFC
   - Include an rtnl_lock/rtnl_unlock in e1000_io_error_detected
     inspired by ixgbe's implementation of the same

 drivers/net/ethernet/intel/e1000/e1000_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 4de9b156b2be..3f089c3d47b2 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3509,7 +3509,9 @@ static void e1000_reset_task(struct work_struct *work)
 		container_of(work, struct e1000_adapter, reset_task);
 
 	e_err(drv, "Reset adapter\n");
+	rtnl_lock();
 	e1000_reinit_locked(adapter);
+	rtnl_unlock();
 }
 
 /**
@@ -5074,7 +5076,9 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
 			usleep_range(10000, 20000);
 
 		WARN_ON(test_bit(__E1000_RESETTING, &adapter->flags));
+		rtnl_lock();
 		e1000_down(adapter);
+		rtnl_unlock();
 	}
 
 	status = er32(STATUS);
@@ -5235,16 +5239,20 @@ static pci_ers_result_t e1000_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 
+	rtnl_lock();
 	netif_device_detach(netdev);
 
-	if (state == pci_channel_io_perm_failure)
+	if (state == pci_channel_io_perm_failure) {
+		rtnl_unlock();
 		return PCI_ERS_RESULT_DISCONNECT;
+	}
 
 	if (netif_running(netdev))
 		e1000_down(adapter);
 
 	if (!test_and_set_bit(__E1000_DISABLED, &adapter->flags))
 		pci_disable_device(pdev);
+	rtnl_unlock();
 
 	/* Request a slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;

base-commit: d05596f248578be943015c1237120574a8d845dd
-- 
2.25.1


