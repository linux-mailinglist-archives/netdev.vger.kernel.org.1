Return-Path: <netdev+bounces-129621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4860F984C87
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 23:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8B61F23C8A
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 21:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BA813B5B4;
	Tue, 24 Sep 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YAi3ps53"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E413A3F0
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212017; cv=none; b=HAYzZy6e2Z6xnL6FPgUDfcXGaL9b6HbLN3g8OSsVG2lShUkzCUFuCksh19QCpNYK07mEPkLoqqcnBhMFKXSSHtFsOixMTk6eAIpiFTOZ5Up0DkupJvPWCJsjKQrdGN9X8yMKNVH8OGUD2XtkUXV9duAqgv4+0cBuTvAQTtqeT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212017; c=relaxed/simple;
	bh=DXNZkOA77RXi62rcIEhLJXZxQfK1+7mSL4ZFunO7ozQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=a7fIdS+g7ABbcpcOeTt1883ifb72RYawAw/M/HgKV8CyEzzLo9FRI6zYAtPy1c6r2uW2C/SLfhU9kUutmRv/fUOjwpWsqlQCbquKB5/H2CP5El0V6WE4t5yF6x8OmDGJhp4DcgENv0YgcLqyh1iNOgYPjauvla2r4rFgARq9+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YAi3ps53; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-206e614953aso59098375ad.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727212015; x=1727816815; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zze8MV+a5IZuaNoaIPGWHIQDnCuS1cR3u4TVceY5GpQ=;
        b=YAi3ps53+1hF2Eg/HQeegOUOb5c8+EXhico9ZkktkIei4xepbMrQxw9MG7Zy81KPiG
         ymbz3XDfAM0oyGcKe1JQWtcUMdqy9CFONa9szSqm+h6LABB9yZ82m4FyaP/3hNCbfXlZ
         /LUj7P+1clh5ihBpnbYEl4Zi3AMjRluBYkIOVdJqKAww6YJL4o9G8DWN32hCmZ6ZCLUl
         3/Roef7s6k85Yxa7QVlP++2xIRA1e0PGIK2pRFrsI58P8lFwzdtuuK3lIg1rkzjx3cy/
         /Yymu7NDmcmAxsIEeF6Oxj9P7OBFd7NUOouMOyU2Vw7LArPaixrxv7P4X8QFI3BY7UvJ
         UlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212015; x=1727816815;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zze8MV+a5IZuaNoaIPGWHIQDnCuS1cR3u4TVceY5GpQ=;
        b=HGex8yS3ZL+1PrhN6wvVhqvW5gzWHml+9VcNh5uRhlxm+eZY85DloveXu4wNumBB2U
         ft4eN95it5bzfoD3cUJu4BcPzuwgdT7/AaNu8joJ8yChzHsuZbpWWvm4pLWWKucL9+Up
         o2qCa4yO7r2oVb137aE7t+mSKj4SNRRci2GxPnPYta0hSsvwjoFztDjiehM345PVS4We
         Mf0RWx/TuO1MJImbpRIurim53sFjjmIvhZ47D6vdnv5Le7YwwP51RL19NWrQgHW2+ubA
         Caxd5TOKD2h/By4cEVK5cHc4b2gEOQpg2cVU+aaVQQ7EemSfEmoNTZ4EglHJ6Th5N6Kh
         Z8gg==
X-Forwarded-Encrypted: i=1; AJvYcCXT7sSP6hAaA8ITQr0MtRpeQG08lWfQpqo7lGpK0nezJjKsNmFsb7MFa0KOpCsO8pYRK2fpBwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBe9K4MQKjrhoTnqZUxp8hPrngn1GL4QuQmulIdal4GT6XNFne
	8UVcdFd88p2SCDKdXNkLfvYhRn+dstXNq+6OiC6TKYjgGU02RjTCiryKdVE8Ntw=
X-Google-Smtp-Source: AGHT+IHX3x5sr2y+cTrUUt+sNEM5mWSUWbyv2wne6NfTdQiuQ1/NbXsHRbIcp7XwwrX4t2d+S7Qg/g==
X-Received: by 2002:a17:903:2309:b0:207:1913:8bae with SMTP id d9443c01a7336-20afc477029mr7357425ad.14.1727212014748;
        Tue, 24 Sep 2024 14:06:54 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20af1818f69sm13717095ad.184.2024.09.24.14.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:06:54 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Ying Hsu <yinghsu@chromium.org>,
	Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] igb: Do not bring the device up after non-fatal error
Date: Tue, 24 Sep 2024 15:06:01 -0600
Message-Id: <20240924210604.123175-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240924210604.123175-1-mkhalfella@purestorage.com>
References: <20240924210604.123175-1-mkhalfella@purestorage.com>
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
index 1ef4cb871452..f1d088168723 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9651,6 +9651,10 @@ static void igb_io_resume(struct pci_dev *pdev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
 	if (netif_running(netdev)) {
+		if (!test_bit(__IGB_DOWN, &adapter->state)) {
+			dev_dbg(&pdev->dev, "Resuming from non-fatal error, do nothing.\n");
+			return;
+		}
 		if (igb_up(adapter)) {
 			dev_err(&pdev->dev, "igb_up failed after reset\n");
 			return;
-- 
2.45.2


