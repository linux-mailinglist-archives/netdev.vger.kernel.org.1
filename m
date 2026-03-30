Return-Path: <netdev+bounces-273298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHdqNvjEymmL/wUAu9opvQ
	(envelope-from <netdev+bounces-273298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:46:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9727735FEA3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A82CC300C366
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342873DFC72;
	Mon, 30 Mar 2026 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="k4xaS/FZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC833939DE;
	Mon, 30 Mar 2026 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896366; cv=none; b=jCf2HjfI/1AAoJSYm8z9c2cOh9itZYA4YU+tHAqnfqmXFHtU87NCbR2ZQD0IIVe3ESzrANa5fLq1uDQaDqOOjuduabswOkfTsu3u3NRMwvPRAvzIyF9V1tfgg14raWdTLXK328GgH+leqAuIHvkX1yausfBMELxoKnQrAz00OWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896366; c=relaxed/simple;
	bh=/3hR/Omnd/Mne96bhoska9NhWkVzECp3mp2oC/dtMK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5O2ef/eoz6V0W6/DNKKPIpBSGvOJtIQ/FfCy/GxHcVi59hm2Exd+EQtDxa34bPFCAYWcjtsvQ6I5cp74GCLNyXfQ0Lc0oNK0xlZiDYnB4+odEZmra2gN69XAju97rdDopXQ46uMG8HcUA0vG8bR+Ne5T5KzJBWiXbpASnmiVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=k4xaS/FZ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [79.139.249.222])
	by mail.ispras.ru (Postfix) with ESMTPSA id 62093413A4BC;
	Mon, 30 Mar 2026 18:45:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 62093413A4BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1774896351;
	bh=dl1hRi0waXOJUFOF2hoWF00XofxxAKlV/NOmwnGxKZs=;
	h=From:To:Cc:Subject:Date:From;
	b=k4xaS/FZozIm7jUXxaskJ0A29AtphtWGzhhnN5UDHd/TNOurODabVQTbmJjXGuEDM
	 zkG+S9uTFaRyhj927xVJzHuCMb4hovZcxTvNJfvmr/7HrdUjZDdXLfToaCWf+G21nn
	 y00QJPfmmmxkc8iKIun1df63OruKfh/qERgzsGrE=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tong Zhang <ztong0001@gmail.com>,
	Bartosz Folta <bfolta@cadence.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net 1/2] net: macb: fix clk handling on PCI glue driver removal
Date: Mon, 30 Mar 2026 21:45:40 +0300
Message-ID: <20260330184542.626619-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ispras.ru,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,cadence.com,vger.kernel.org,linuxtesting.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-273298-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,ispras.ru:dkim,ispras.ru:email,ispras.ru:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9727735FEA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

platform_device_unregister() may still want to use the registered clks
during runtime resume callback.

Note that there is a commit d82d5303c4c5 ("net: macb: fix use after free
on rmmod") that addressed the similar problem of clk vs platform device
unregistration but just moved the bug to another place.

Save the pointers to clks into local variables for reuse after platform
device is unregistered.

BUG: KASAN: use-after-free in clk_prepare+0x5a/0x60
Read of size 8 at addr ffff888104f85e00 by task modprobe/597

CPU: 2 PID: 597 Comm: modprobe Not tainted 6.1.164+ #114
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x8d/0xba
 print_report+0x17f/0x496
 kasan_report+0xd9/0x180
 clk_prepare+0x5a/0x60
 macb_runtime_resume+0x13d/0x410 [macb]
 pm_generic_runtime_resume+0x97/0xd0
 __rpm_callback+0xc8/0x4d0
 rpm_callback+0xf6/0x230
 rpm_resume+0xeeb/0x1a70
 __pm_runtime_resume+0xb4/0x170
 bus_remove_device+0x2e3/0x4b0
 device_del+0x5b3/0xdc0
 platform_device_del+0x4e/0x280
 platform_device_unregister+0x11/0x50
 pci_device_remove+0xae/0x210
 device_remove+0xcb/0x180
 device_release_driver_internal+0x529/0x770
 driver_detach+0xd4/0x1a0
 bus_remove_driver+0x135/0x260
 driver_unregister+0x72/0xb0
 pci_unregister_driver+0x26/0x220
 __do_sys_delete_module+0x32e/0x550
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 </TASK>

Allocated by task 519:
 kasan_save_stack+0x2c/0x50
 kasan_set_track+0x21/0x30
 __kasan_kmalloc+0x8e/0x90
 __clk_register+0x458/0x2890
 clk_hw_register+0x1a/0x60
 __clk_hw_register_fixed_rate+0x255/0x410
 clk_register_fixed_rate+0x3c/0xa0
 macb_probe+0x1d8/0x42e [macb_pci]
 local_pci_probe+0xd7/0x190
 pci_device_probe+0x252/0x600
 really_probe+0x255/0x7f0
 __driver_probe_device+0x1ee/0x330
 driver_probe_device+0x4c/0x1f0
 __driver_attach+0x1df/0x4e0
 bus_for_each_dev+0x15d/0x1f0
 bus_add_driver+0x486/0x5e0
 driver_register+0x23a/0x3d0
 do_one_initcall+0xfd/0x4d0
 do_init_module+0x18b/0x5a0
 load_module+0x5663/0x7950
 __do_sys_finit_module+0x101/0x180
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Freed by task 597:
 kasan_save_stack+0x2c/0x50
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x2a/0x50
 __kasan_slab_free+0x106/0x180
 __kmem_cache_free+0xbc/0x320
 clk_unregister+0x6de/0x8d0
 macb_remove+0x73/0xc0 [macb_pci]
 pci_device_remove+0xae/0x210
 device_remove+0xcb/0x180
 device_release_driver_internal+0x529/0x770
 driver_detach+0xd4/0x1a0
 bus_remove_driver+0x135/0x260
 driver_unregister+0x72/0xb0
 pci_unregister_driver+0x26/0x220
 __do_sys_delete_module+0x32e/0x550
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: d82d5303c4c5 ("net: macb: fix use after free on rmmod")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/ethernet/cadence/macb_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_pci.c b/drivers/net/ethernet/cadence/macb_pci.c
index fc4f5aee6ab3..0ce5b736ea43 100644
--- a/drivers/net/ethernet/cadence/macb_pci.c
+++ b/drivers/net/ethernet/cadence/macb_pci.c
@@ -109,10 +109,12 @@ static void macb_remove(struct pci_dev *pdev)
 {
 	struct platform_device *plat_dev = pci_get_drvdata(pdev);
 	struct macb_platform_data *plat_data = dev_get_platdata(&plat_dev->dev);
+	struct clk *pclk = plat_data->pclk;
+	struct clk *hclk = plat_data->hclk;
 
-	clk_unregister(plat_data->pclk);
-	clk_unregister(plat_data->hclk);
 	platform_device_unregister(plat_dev);
+	clk_unregister(pclk);
+	clk_unregister(hclk);
 }
 
 static const struct pci_device_id dev_id_table[] = {
-- 
2.53.0


