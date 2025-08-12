Return-Path: <netdev+bounces-212916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B469B22826
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273D242403B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3426980F;
	Tue, 12 Aug 2025 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvQucUr/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848924DD13;
	Tue, 12 Aug 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004267; cv=none; b=V0y/K0oIgqWr57+VRR2XDoE3e/tOweMX7Tigv9jkdc9sTrt/+VK8tEoYGDeKZAlm6gBnY0g5V8QoQQEzSmgJ8jDlNE1SLOkVnzO31lDb0ZeloQvGlsakvaMQdt0C0r37SVKt7nzB4QDKjGb8uDQpgxHKd7rkWO7izRFsjm0dxjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004267; c=relaxed/simple;
	bh=jpvCdzmHJ5xj/A+c0w4r3SpkYQVGzyL63JnKHddt0Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzI53UXuIYM3VYz67h6+YMrVYc4mXl54THubrPQAV7INvC0JZjsSIHW5FpTcH5ChoBbIX2Wdv2CoXcLA0GQ/8OxYmQpf8Rlb9yqr0vM+DeYVA94PIZYHjOxm+vd4FllGKAeilIOKADyYZflIaMMe6ZYjQD0tMAjeGNp7+KHz1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvQucUr/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso5942183a91.3;
        Tue, 12 Aug 2025 06:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755004265; x=1755609065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxIla1HyYnxUj2HsSHmkDkdZP2KuTjodsMUdmS63XNQ=;
        b=KvQucUr/LWDOEcpAPMCwMye2Q6eh47ke7x3uhsnl7EAYP240NqkW3zMQSGZDENc1y/
         j94X4AkOEmRfCHexag9fF/nt3aI6Xq6WQgZqkNb3TCM8+qxBIGw+r0vruj7fzEmLz7w0
         eEA4oLqG4DCH/sBtTTt6HmJ29vZvn+iaXW8QnqMIoS9uKru/N4iEL/28XP/xxoFHKv71
         X6bQNNDGGlWarmiMy/VyXlvZVmq/9q8M+e22/6TA34QKwdrWqvAO/tatl70ul8cVTG8x
         g1ta52hzO0KK01SG05V3nhhSAD3vADsWxd9ATolKG1iSVPdqsDPbZiMwcp3i4EK8OlJ/
         LaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004265; x=1755609065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxIla1HyYnxUj2HsSHmkDkdZP2KuTjodsMUdmS63XNQ=;
        b=J6hhzWFt1kQLoVEM3ANIyGDfIR1AmWGW5N8MDNh7ZYa5vDlQvyO4MqUiyTZpGjdYbC
         T9mkkkz+b59MIhPXhwMCuf9JxJCBN9vUXjnR+J5oIuJ+oIoVnDqMbFBn1j9U6COrd9r9
         +vLEfMs+OhtC4B3YD3roWbhXXtIN1kjO5C6SJnn8F8hP/eUMRbdLA0NdHPSRjzQoeSWG
         51e4GA0dQChoiEwLnUC5UixMjl+DOvg8PR2RjBZthHIqlt+5e/O57KugsuNhKP+OstGF
         xCdJFwde09EQ5oZo9FPHr+8aJfKJXzR8nn6uqmgFv7V16jKtl2qF0/4DpDz/VOq1eS/u
         d0dA==
X-Forwarded-Encrypted: i=1; AJvYcCUSiFZcxXgahw2TieO/LZTGtKuAWg0ONQmrmHRTbKbTgQCQ4qghWLgkZo8ZcSXF/AVGUWZ4+XUW@vger.kernel.org, AJvYcCX2EkRP4yZVjqMR405GaEfc2TBraoLgdOk5kbP+tEdqnuplpXuVs9VzF8PnurgKSoh1ujgYiqR8kMZrVSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqY70tgT99NUs3FZISvulcuxPemFRzQSQiyRSfoPw8LiwLo+Km
	S6mFxki21V+q2vLZ81VbPNX/AcOoUg6zV+V7A2PAFuTYkrC6Dy09k3Qz3tD9ZVx1
X-Gm-Gg: ASbGncuizgp9qk0ZANCdC1vDifZV9CYJf4/NMpqO2lVkCyzvrzvIHc1A6x1zPMNFHTO
	A/dAYqmEbGWdvN+URMgTfjvBah/iD6Za8+XUAqDVmaiHdojgXyTHA8JOoJ4rB01rGy6ATP11zz5
	EYak7Ei8kwx7MGDV7Clt2naP5F6WungN7ynbap38Gddl9XCvvhNic2DeA+xy8J1mrREmHZmp+He
	zFjGrp+tIAVepgBs+rvGcW9gq4XYL+fR2LrcD+2y+GHnfoVd5Ke5iIxFKVpKgwsOysgjlx3ULD4
	KF6nr/3Poq+xrA1+ZrE19ZfkuLFPblnBL9Ga+sgKBF5kzQb0U75xgvjDEPAHi1z2iBtXVpZlTx/
	0YUYla8KHI+FsZJJc/x834qgLx/vyMddQRHro97RoWBlSp9exg8MdSSs=
X-Google-Smtp-Source: AGHT+IGZho0iQ/1nCW0ztaSgx/gJSrFI5h/wMr3ThsyqUo5BdfFFaDonVE6u2aePsc3KlxqPpcFzPw==
X-Received: by 2002:a17:90a:e294:b0:321:2407:3cef with SMTP id 98e67ed59e1d1-321c0b60856mr3040069a91.32.1755004265102;
        Tue, 12 Aug 2025 06:11:05 -0700 (PDT)
Received: from TIANYXU-M-J00K.cisco.com ([2001:420:588c:1300:513:ebe8:5ec0:cab3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4285a15c26sm13545797a12.16.2025.08.12.06.11.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Aug 2025 06:11:04 -0700 (PDT)
From: Tianyu Xu <xtydtc@gmail.com>
X-Google-Original-From: Tianyu Xu <tianyxu@cisco.com>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com,
	kuba@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tianyu Xu <tianyxu@cisco.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Joe Damato <joe@dama.to>
Subject: [PATCH v2] igb: Fix NULL pointer dereference in ethtool loopback test
Date: Tue, 12 Aug 2025 21:10:56 +0800
Message-Id: <20250812131056.93963-1-tianyxu@cisco.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The igb driver currently causes a NULL pointer dereference when executing
the ethtool loopback test. This occurs because there is no associated
q_vector for the test ring when it is set up, as interrupts are typically
not added to the test rings.

Since commit 5ef44b3cb43b removed the napi_id assignment in
__xdp_rxq_info_reg(), there is no longer a need to pass a napi_id to it.
Therefore, simply use 0 as the last parameter.

Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Tianyu Xu <tianyxu@cisco.com>
---
Thanks to Aleksandr and Joe for your feedback. I have added the Fixes tag
and formatted the lines to 75 characters based on your comments.

 drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a9a7a94ae..453deb6d1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4453,8 +4453,7 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
 	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
-			       rx_ring->queue_index,
-			       rx_ring->q_vector->napi.napi_id);
+			       rx_ring->queue_index, 0);
 	if (res < 0) {
 		dev_err(dev, "Failed to register xdp_rxq index %u\n",
 			rx_ring->queue_index);
-- 
2.39.5 (Apple Git-154)


