Return-Path: <netdev+bounces-163717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B3CA2B6DC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF6C3A7A57
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602D023BFAC;
	Thu,  6 Feb 2025 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHtlkwBe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C81E23BFAB
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886024; cv=none; b=f/absJNB4cSZvFCeTSC03PDUIylxfcwJ0trzw9plKIuWj0/DA00v7sa7Dc0FAlhct1LKvNactbTHYRrNUBc1ye0EUrVbgfPhtzolDHTlCmuLWUga9k9Aon6p2CTS42zJwZocJ9jNVbobZ4K7KYD2KTvxD8nSxjZqb5f7tbk9TNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886024; c=relaxed/simple;
	bh=2e+tuEdeu+/mQ/Nt1zMjRQi3Td3mssfNNnS/dLsodPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FN91LQX2Y3+8VUhUSZL8BINgisYgz4/5MBWSKjctI7G+HstqACq2dyPFEonA8ZFGpD8818XKEr7x9pBtMdBoktAHQDFFiaVY/lf0cNLzoTVqEFNNvLBEVUmOtaiFE0TpjifR8NomVwybvIHwwffa2aF+k86Jd4vmrhKrfP/34EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHtlkwBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB1BC4CEE6;
	Thu,  6 Feb 2025 23:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738886022;
	bh=2e+tuEdeu+/mQ/Nt1zMjRQi3Td3mssfNNnS/dLsodPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHtlkwBe1llQTwVkUeUAUkvJn5AVxoSQksMS2JMKhMFHuP50cqtvSdNrMKHb0r8fB
	 2KMMJ49IUmTeFSAOx/eqtuu2MaE0MfzV46+dGZXZo+cyAkCwMEU8u9eaAMNq5DosIr
	 F3/qZ54TovK02sQs/tqJeMuNY8SOhcz/5+sPOFQwB9bQhyHbAwtkuXhAKue/1zD7Vw
	 A7zobn8oUyppWKsOdppZJbq8lI5BsCw0p9iXFyJZztV2ddNJ4hyabiAp+BSg8OAD7U
	 CB2s3FAccLFoHNws6sw+sLn9SmMuYDuBZbsOaNMffHEtNjkFMX/1zZy88xMZsP6LLa
	 OFMpsyV3iIBDw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Alexander Duyck <alexanderduyck@meta.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 7/7] eth: fbnic: support listing tcam content via debugfs
Date: Thu,  6 Feb 2025 15:53:34 -0800
Message-ID: <20250206235334.1425329-8-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206235334.1425329-1-kuba@kernel.org>
References: <20250206235334.1425329-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexanderduyck@meta.com>

The device has a handful of relatively small TCAM tables,
support dumping the driver state via debugfs.

  # ethtool -N eth0 flow-type tcp6 \
      dst-ip 1111::2222 dst-port $((0x1122)) \
      src-ip 3333::4444 src-port $((0x3344)) \
      action 2
  Added rule with ID 47

  # cd $dbgfs
  # cat ip_src
  Idx S TCAM Bitmap       V Addr/Mask
  ------------------------------------
  00  1 00020000,00000000 6 33330000000000000000000000004444
                            00000000000000000000000000000000
  ...
  # cat ip_dst
  Idx S TCAM Bitmap       V Addr/Mask
  ------------------------------------
  00  1 00020000,00000000 6 11110000000000000000000000002222
                            00000000000000000000000000000000
  ...

  # cat act_tcam
  Idx S Value/Mask                                              RSS  Dest
  ------------------------------------------------------------------------
  ...
  49  1 0000 0000 0000 0000 0000 0000 1122 3344 0000 9c00 0088  000f 00000212
        ffff ffff ffff ffff ffff ffff 0000 0000 ffff 23ff ff00
  ...

The ipo_* tables are for outer IP addresses.
The tce_* table is for directing/stealing traffic to NC-SI.

Signed-off-by: Alexander Duyck <alexanderduyck@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
index ac80981f67c0..e8f2d7f2d962 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
@@ -44,6 +44,132 @@ static int fbnic_dbg_mac_addr_show(struct seq_file *s, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_mac_addr);
 
+static int fbnic_dbg_tce_tcam_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+	int i, tcam_idx = 0;
+	char hdr[80];
+
+	/* Generate Header */
+	snprintf(hdr, sizeof(hdr), "%3s %s %-17s %s\n",
+		 "Idx", "S", "TCAM Bitmap", "Addr/Mask");
+	seq_puts(s, hdr);
+	fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
+
+	for (i = 0; i < ARRAY_SIZE(fbd->mac_addr); i++) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
+
+		/* Verify BMC bit is set */
+		if (!test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam))
+			continue;
+
+		if (tcam_idx == FBNIC_TCE_TCAM_NUM_ENTRIES)
+			break;
+
+		seq_printf(s, "%02d  %d %64pb %pm\n",
+			   tcam_idx, mac_addr->state, mac_addr->act_tcam,
+			   mac_addr->value.addr8);
+		seq_printf(s, "                        %pm\n",
+			   mac_addr->mask.addr8);
+		tcam_idx++;
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_tce_tcam);
+
+static int fbnic_dbg_act_tcam_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+	char hdr[80];
+	int i;
+
+	/* Generate Header */
+	snprintf(hdr, sizeof(hdr), "%3s %s %-55s %-4s %s\n",
+		 "Idx", "S", "Value/Mask", "RSS", "Dest");
+	seq_puts(s, hdr);
+	fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
+
+	for (i = 0; i < FBNIC_RPC_TCAM_ACT_NUM_ENTRIES; i++) {
+		struct fbnic_act_tcam *act_tcam = &fbd->act_tcam[i];
+
+		seq_printf(s, "%02d  %d %04x %04x %04x %04x %04x %04x %04x %04x %04x %04x %04x  %04x %08x\n",
+			   i, act_tcam->state,
+			   act_tcam->value.tcam[10], act_tcam->value.tcam[9],
+			   act_tcam->value.tcam[8], act_tcam->value.tcam[7],
+			   act_tcam->value.tcam[6], act_tcam->value.tcam[5],
+			   act_tcam->value.tcam[4], act_tcam->value.tcam[3],
+			   act_tcam->value.tcam[2], act_tcam->value.tcam[1],
+			   act_tcam->value.tcam[0], act_tcam->rss_en_mask,
+			   act_tcam->dest);
+		seq_printf(s, "      %04x %04x %04x %04x %04x %04x %04x %04x %04x %04x %04x\n",
+			   act_tcam->mask.tcam[10], act_tcam->mask.tcam[9],
+			   act_tcam->mask.tcam[8], act_tcam->mask.tcam[7],
+			   act_tcam->mask.tcam[6], act_tcam->mask.tcam[5],
+			   act_tcam->mask.tcam[4], act_tcam->mask.tcam[3],
+			   act_tcam->mask.tcam[2], act_tcam->mask.tcam[1],
+			   act_tcam->mask.tcam[0]);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_act_tcam);
+
+static int fbnic_dbg_ip_addr_show(struct seq_file *s,
+				  struct fbnic_ip_addr *ip_addr)
+{
+	char hdr[80];
+	int i;
+
+	/* Generate Header */
+	snprintf(hdr, sizeof(hdr), "%3s %s %-17s %s %s\n",
+		 "Idx", "S", "TCAM Bitmap", "V", "Addr/Mask");
+	seq_puts(s, hdr);
+	fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
+
+	for (i = 0; i < FBNIC_RPC_TCAM_IP_ADDR_NUM_ENTRIES; i++, ip_addr++) {
+		seq_printf(s, "%02d  %d %64pb %d %pi6\n",
+			   i, ip_addr->state, ip_addr->act_tcam,
+			   ip_addr->version, &ip_addr->value);
+		seq_printf(s, "                          %pi6\n",
+			   &ip_addr->mask);
+	}
+
+	return 0;
+}
+
+static int fbnic_dbg_ip_src_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+
+	return fbnic_dbg_ip_addr_show(s, fbd->ip_src);
+}
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_ip_src);
+
+static int fbnic_dbg_ip_dst_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+
+	return fbnic_dbg_ip_addr_show(s, fbd->ip_dst);
+}
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_ip_dst);
+
+static int fbnic_dbg_ipo_src_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+
+	return fbnic_dbg_ip_addr_show(s, fbd->ipo_src);
+}
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_ipo_src);
+
+static int fbnic_dbg_ipo_dst_show(struct seq_file *s, void *v)
+{
+	struct fbnic_dev *fbd = s->private;
+
+	return fbnic_dbg_ip_addr_show(s, fbd->ipo_dst);
+}
+DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_ipo_dst);
+
 static int fbnic_dbg_pcie_stats_show(struct seq_file *s, void *v)
 {
 	struct fbnic_dev *fbd = s->private;
@@ -84,6 +210,18 @@ void fbnic_dbg_fbd_init(struct fbnic_dev *fbd)
 			    &fbnic_dbg_pcie_stats_fops);
 	debugfs_create_file("mac_addr", 0400, fbd->dbg_fbd, fbd,
 			    &fbnic_dbg_mac_addr_fops);
+	debugfs_create_file("tce_tcam", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_tce_tcam_fops);
+	debugfs_create_file("act_tcam", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_act_tcam_fops);
+	debugfs_create_file("ip_src", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_ip_src_fops);
+	debugfs_create_file("ip_dst", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_ip_dst_fops);
+	debugfs_create_file("ipo_src", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_ipo_src_fops);
+	debugfs_create_file("ipo_dst", 0400, fbd->dbg_fbd, fbd,
+			    &fbnic_dbg_ipo_dst_fops);
 }
 
 void fbnic_dbg_fbd_exit(struct fbnic_dev *fbd)
-- 
2.48.1


