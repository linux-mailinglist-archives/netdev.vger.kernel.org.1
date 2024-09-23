Return-Path: <netdev+bounces-129386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0787798390C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 23:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293951C20E07
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B94E839EB;
	Mon, 23 Sep 2024 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UhZWKx+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22E43AA4
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126551; cv=none; b=KCo9r/qgsqGB61UC2RYcVb91Q5q76jhPiJtoV+jsEGiBxrnQ+QF1l09V2sFKcnXy2EzpiroM1NUAXcq/xIglodwyQZ7JwTE4BbEn3ubfaJDN2BETnQFVPmwThqYRCrTN9JKYrUB3pEb14/paRMdjb6xMgxbF+snWOBWdMHnROO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126551; c=relaxed/simple;
	bh=TI4UgBvUHxOCfeXggK9U9HOkmwYk1b6eVpu5+BTF+Hc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QzLh/MEWE4pyIUqRtxXFG8eHDUdH7+8tAxIDRnvKWRPwQtpcdSd0U+knD6UL3LqJQA8dR77yYShbfNptGpwiYrmjzlSvDsUY7S1b04NffAetVsila7McRCets6CfUqK9mdCAfW+CQ2zalKjIIWyPaIJPSX2NrYXpFkb5qNpvB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UhZWKx+7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71798a15ce5so4074797b3a.0
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727126548; x=1727731348; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eV4Vklmlj8bqBkSf+z2gjD9tas8DcH2sV0AiX6LOJs=;
        b=UhZWKx+7O8Ifr0Z2oPxbOpORjn5I2J/kHYjUbFBk3XbYnG0FI1p+smKJHQKD0S52iB
         7GJM3/zZHsBZhvXsYDQsvFSonMJWin9nzLwBj5TqzdgrlILj/dR99CK7AVbmPSJM+M4O
         theyonqtF4l8GMLPwb569qSa+bjW+ViONlVJSJ44fvjvXpE867exj/+32CyAJJFhn6kO
         qZASgU2gSB9q+SRBHnqMEuvZMNsGRLlxcUX1EetlvjcCF9k8GyeOsTFZanvhcM8W2eUL
         J7QwAlOg/O3EuH2ri8V3BWx/jbvTtCJrMDoL/DC3JXi1DceBUI4vHtO2bRwVm3iSRYnN
         Q9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727126548; x=1727731348;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eV4Vklmlj8bqBkSf+z2gjD9tas8DcH2sV0AiX6LOJs=;
        b=cI7fueyNL41AoSbEQ07sFMZNXryZ/BlZRY+B6erUD3TTUQtxxwqUjI1/52FRC98+ni
         +gGhmImdArtV4gOXw1MJqvhdmi2gD/ZlrICWTKrOBlgjyPfJDo5sGEUO54h0q4I/XI2g
         0LTSs9AtsR0bC7jL1oyzitQsyo3n7FLtoggKqRqAWLXBri/lLTKlLk6R/CSnXeALskwQ
         BPCJPqLd1wWDsE3j1xF164giyVN+qKRFm7WeYYSXBQoiZmPaRbiO4oFO0a1QSmtjC5gz
         Sl2hnTX80JH4INdrQPC/XNidzRlR3clUKkokhwLbNy4w1cCAdrCrICuG8LD8I7792SEH
         RMXA==
X-Forwarded-Encrypted: i=1; AJvYcCURrS0MGZR5Ym7N5hjgpdLhd6VV7+SjQZq1ePTkdzvq8/8JXaDdap6A8S/kN0Hsp7msX6HzJd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9Et0CbKEDkvsK+AdYyuBBZtiOPt1hTam9EaPAwWLZ9k8McZ/
	AJ58+zXDYIw9MYzsVo5Nd7/vm5OryqjPpA0Yq3U9+TTIv5Xl+aBQUNYwI+JRDAU=
X-Google-Smtp-Source: AGHT+IHyxfMvPUsr9LZzOLYIagUPDr6zEE6tUUXhw4z3fyt80Nvtp1XMDHbKB4CNrD3CfGDt7Umkbw==
X-Received: by 2002:a05:6a21:1346:b0:1d2:e8f6:7f3 with SMTP id adf61e73a8af0-1d343c5645amr1626287637.11.1727126547871;
        Mon, 23 Sep 2024 14:22:27 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71afc847924sm66047b3a.58.2024.09.23.14.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 14:22:27 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Simon Horman <horms@kernel.org>,
	Ying Hsu <yinghsu@chromium.org>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] igb: Do not bring the device up after non-fatal error
Date: Mon, 23 Sep 2024 15:22:12 -0600
Message-Id: <20240923212218.116979-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Commit 004d25060c78 ("igb: Fix igb_down hung on surprise removal")
changed igb_io_error_detected() to ignore non-fatal pcie errors in order
to avoid hung task that can happen when igb_down() is called multiple
times. This caused an issue when processing transient non-fatal errors.
igb_io_resume(), which is called after igb_io_error_detected(), assumes
that device is brought down by igb_io_error_detected() if the interface
is up. This resulted in panic with stacktrace below.

[ T3256] igb 0000:09:00.0 haeth0: igb: haeth0 NIC Link is Down
[  T292] pcieport 0000:00:1c.5: AER: Uncorrected (Non-Fatal) error received: 0000:09:00.0
[  T292] igb 0000:09:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
[  T292] igb 0000:09:00.0:   device [8086:1537] error status/mask=00004000/00000000
[  T292] igb 0000:09:00.0:    [14] CmpltTO [  200.105524,009][  T292] igb 0000:09:00.0: AER:   TLP Header: 00000000 00000000 00000000 00000000
[  T292] pcieport 0000:00:1c.5: AER: broadcast error_detected message
[  T292] igb 0000:09:00.0: Non-correctable non-fatal error reported.
[  T292] pcieport 0000:00:1c.5: AER: broadcast mmio_enabled message
[  T292] pcieport 0000:00:1c.5: AER: broadcast resume message
[  T292] ------------[ cut here ]------------
[  T292] kernel BUG at net/core/dev.c:6539!
[  T292] invalid opcode: 0000 [#1] PREEMPT SMP
[  T292] RIP: 0010:napi_enable+0x37/0x40
[  T292] Call Trace:
[  T292]  <TASK>
[  T292]  ? die+0x33/0x90
[  T292]  ? do_trap+0xdc/0x110
[  T292]  ? napi_enable+0x37/0x40
[  T292]  ? do_error_trap+0x70/0xb0
[  T292]  ? napi_enable+0x37/0x40
[  T292]  ? napi_enable+0x37/0x40
[  T292]  ? exc_invalid_op+0x4e/0x70
[  T292]  ? napi_enable+0x37/0x40
[  T292]  ? asm_exc_invalid_op+0x16/0x20
[  T292]  ? napi_enable+0x37/0x40
[  T292]  igb_up+0x41/0x150
[  T292]  igb_io_resume+0x25/0x70
[  T292]  report_resume+0x54/0x70
[  T292]  ? report_frozen_detected+0x20/0x20
[  T292]  pci_walk_bus+0x6c/0x90
[  T292]  ? aer_print_port_info+0xa0/0xa0
[  T292]  pcie_do_recovery+0x22f/0x380
[  T292]  aer_process_err_devices+0x110/0x160
[  T292]  aer_isr+0x1c1/0x1e0
[  T292]  ? disable_irq_nosync+0x10/0x10
[  T292]  irq_thread_fn+0x1a/0x60
[  T292]  irq_thread+0xe3/0x1a0
[  T292]  ? irq_set_affinity_notifier+0x120/0x120
[  T292]  ? irq_affinity_notify+0x100/0x100
[  T292]  kthread+0xe2/0x110
[  T292]  ? kthread_complete_and_exit+0x20/0x20
[  T292]  ret_from_fork+0x2d/0x50
[  T292]  ? kthread_complete_and_exit+0x20/0x20
[  T292]  ret_from_fork_asm+0x11/0x20
[  T292]  </TASK>

To fix this issue igb_io_resume() checks if the interface is running and
the device is not down this means igb_io_error_detected() did not bring
the device down and there is no need to bring it up.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Yuanyuan Zhong<yzhong@purestorage.com>
Fixes: 004d25060c78 ("igb: Fix igb_down hung on surprise removal")
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ef4cb871452..8c6bc3db9a3d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9651,6 +9651,10 @@ static void igb_io_resume(struct pci_dev *pdev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
 	if (netif_running(netdev)) {
+		if (!test_bit(__IGB_DOWN, &adapter->state)) {
+			dev_info(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
+			return;
+		}
 		if (igb_up(adapter)) {
 			dev_err(&pdev->dev, "igb_up failed after reset\n");
 			return;
-- 
2.45.2


