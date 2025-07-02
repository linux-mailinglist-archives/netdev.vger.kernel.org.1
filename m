Return-Path: <netdev+bounces-203502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC32AF62B3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B2A161016
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839652E03F8;
	Wed,  2 Jul 2025 19:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A71C07C3;
	Wed,  2 Jul 2025 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484777; cv=none; b=WwtsHkhfct1AhpOSgHCff1l/8UKT+CMz9iXt7VaEZlAT9+GYQ6TYCFDagCXqDiMM08jX3Uo864YSymfZsYTaHL15xXsYEAKeR1YMVT3xh3zitoiy0P2RlqRP9371vxKc9MCrpPPHWbgKGk9G+0NkZZw0tK4aTj+OfiSKUetsfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484777; c=relaxed/simple;
	bh=OTJq42Qkwhx1ePJXn5n7/Ct+lnb367awCNBOaQN5OIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr7+Fj8twjZOUkEPRFxRR3q3gG5/4jQZ5WTJpK+Q/ux1ummPHOj5g3yCsniYbxt6BLGZaOlUFa2S3q5DCL0DY9E4Et3wOBKPRzjfajG59XTwSbgc/D04/yzCgGr9stpmvP93SNanouYZxRXRp2oht4X6nnZdnb98/211llsY9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uX3CK-00082Y-2T; Wed, 02 Jul 2025 19:32:48 +0000
From: Lee Trager <lee@trager.us>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Su Hui <suhui@nfschina.com>,
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 6/6] eth: fbnic: Create fw_log file in DebugFS
Date: Wed,  2 Jul 2025 12:12:12 -0700
Message-ID: <20250702192207.697368-7-lee@trager.us>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702192207.697368-1-lee@trager.us>
References: <20250702192207.697368-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow reading the firmware log in DebugFS by accessing the fw_log file.
Buffer is read while a spinlock is acquired.

Signed-off-by: Lee Trager <lee@trager.us>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index e8f2d7f2d962..b7238dd967fe 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -170,6 +170,33 @@ static int fbnic_dbg_ipo_dst_show(struct seq_file *s, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_ipo_dst);

+static int fbnic_dbg_fw_log_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+	struct fbnic_fw_log_entry *entry;
+	unsigned long flags;
+
+	if (!fbnic_fw_log_ready(fbd))
+		return -ENXIO;
+
+	spin_lock_irqsave(&fbd->fw_log.lock, flags);
+
+	list_for_each_entry_reverse(entry, &fbd->fw_log.entries, list) {
+		seq_printf(s, FBNIC_FW_LOG_FMT, entry->index,
+			   (entry->timestamp / (MSEC_PER_SEC * 60 * 60 * 24)),
+			   (entry->timestamp / (MSEC_PER_SEC * 60 * 60)) % 24,
+			   ((entry->timestamp / (MSEC_PER_SEC * 60) % 60)),
+			   ((entry->timestamp / MSEC_PER_SEC) % 60),
+			   (entry->timestamp % MSEC_PER_SEC),
+			   entry->msg);
+	}
+
+	spin_unlock_irqrestore(&fbd->fw_log.lock, flags);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_fw_log);
+
 static int fbnic_dbg_pcie_stats_show(struct seq_file *s, void *v)
 {
 	struct fbnic_dev *fbd = s->private;
@@ -222,6 +249,8 @@ void fbnic_dbg_fbd_init(struct fbnic_dev *fbd)
 			    &fbnic_dbg_ipo_src_fops);
 	debugfs_create_file("ipo_dst", 0400, fbd->dbg_fbd, fbd,
 			    &fbnic_dbg_ipo_dst_fops);
+	debugfs_create_file("fw_log", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_fw_log_fops);
 }

 void fbnic_dbg_fbd_exit(struct fbnic_dev *fbd)
--
2.47.1

