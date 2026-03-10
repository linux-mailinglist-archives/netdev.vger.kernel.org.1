Return-Path: <netdev+bounces-266189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDNDF/UusGlHgwIAu9opvQ
	(envelope-from <netdev+bounces-266189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:47:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4568F252618
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5A8C30891E4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7289E2FC876;
	Tue, 10 Mar 2026 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JonHzeZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C032F3C0E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153744; cv=none; b=Md5RHjkbGJ4/EMjbucPs+f7xuGXkA4PCIpg2vTttQ6V0vDbca0VfIR7W7v2AxOfxdWs/+wpPzXRTGFM/4MrSgmUrtOkTFAhby0T9o3vCLOLlMVxDC+a6OluQowqllfk0xavKreJzwW7DWyUQvWHJunz7ta+TfBg3r2lobdjqFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153744; c=relaxed/simple;
	bh=IefuflICElXt+Je/MhJVI1wpKed2MkFOQ2tMDVhy794=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0YH+gIMOyw0qRxkhfzFyfGC8+LeM1KtGCT0Qpr7UhUNA45OL0aWvdVG43/xU9n834QDI1koMAUOOY2OhbVdXhufEuVcki0vAR7LbSzWeA7nRSisSAKhFomUzyquS88xomtmC97uaSp6cu5N3AoD7Rb9C2nJLSY+AnfBQJ7pDUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JonHzeZK; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so55830066d6.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153741; x=1773758541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFhaAtyoG1qP3yVuZbSFuyoblIxRrrEm1ql3jhQTY0s=;
        b=CEt2OV8XQcpys649iLbQQ0aCnhYca4rbGappF1sljFxhzsW60usdhcyasadWVEZJok
         3FtoVp+nUsNLUHcbQuvutm70Kh4RE8MXUQmC4u+lXZnzVcRlcfLFNIvK/SuaKlg29hQa
         5+RvhQsM+A0Ple/ZA8I3koI6uqBRfFhA2taz/m9xCsl5cNITACZiT/4d/QxkWN5BxGxo
         BpjV0NYZsjLs2oR8KDFnjWGEPmIg9/Nv6TvQoHkguM7o9rPfqkjs0mOJ1tTkQROrIydY
         yiKLSEGtn2Ioc9/qZ1YuNK+RQqTRSvnCBaoFVmU5FTAt0wb60Xzj7sh6pPpEZSAedlOT
         8Trw==
X-Gm-Message-State: AOJu0YyFMXcmMI1YDv4bDrqhK2cg4XWkD7g7HwY9hS680qv9CxKv6rvr
	MSHsYaVnbBAzta0sQJzK+UFIjouugxa3gEtdjJJCWHwOPMH2eir6lXLUuf16T9JCd/wohdC7bfE
	HWcWlxcZSq22lDnGv2pfjAwzX8Yx1ZegDsSFlG9vn9LFUQ+nXqJmirILZzpVsjLcfrxyuck3X79
	GcTtz9ENnc1Uo0Kg2hpFVFQ/qhDd1SQT2ct28dP+RBOJZlkFqb1joX1eQVnP698CqccxA1q+P6t
	faLlqHCPyW2upvwJA==
X-Gm-Gg: ATEYQzwtiQMuWoul9G6XoGttvxFdurur/EaQzlNUNnlPjTIBMe9NrfWVF+8PKLM0bck
	711BNNzzvW4Xd5wBXp7I77GDvkvqd6gL4jXFBfITXM7MYvuZHiVeEJnJtu6cUC693Xj3CMpW0+0
	pGLYmKzFxaCAEZLldkL/3fOvQnoZNSBaREJReiaq7XrCI8QG4C464778IQv6BQWofDH07ozHbzo
	S3OevoBxpsx0aqq/QZGuXJwL2RAT6AMe5kQGipKnQIKOxXbeCiOL62rWnALjgmgJy7nhbUio0Ag
	b2kGeaOm0Xz8buTCm2a3b5WoDwfoEOxeUOzpMvOJZHQeby6jhU+J5hWb2mqdd1IckV5piDkp90l
	Q9uoWSplZjqfzItuFwEPv3+yESLVfF6ObHsCu7hxESOziH/UMeCf+bTF46sh06eJG8D9YyxVvqZ
	qqwXyww3NTueIPvBY/EGDWdIBl+5xRqBo9XsE0werQdamk1128jjhO2gf5WmaeeHg=
X-Received: by 2002:a05:6214:400d:b0:89a:ff2:b8da with SMTP id 6a1803df08f44-89a30acb81bmr218838126d6.47.1773153740397;
        Tue, 10 Mar 2026 07:42:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89a57bd5d85sm3301226d6.26.2026.03.10.07.42.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2026 07:42:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae62c87973so389862315ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773153739; x=1773758539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFhaAtyoG1qP3yVuZbSFuyoblIxRrrEm1ql3jhQTY0s=;
        b=JonHzeZK797E8e21zQlpPzA4hwzi9P7LW/Hr3K/gCh0p3Sxj5dmSp1UWcZjRMfzTXQ
         kptGInEaEoPziGdMdM1TXX2nTRTMIAaEWq9vQRe7tHLJAAg0TcQG5w8x6gIYRafMpySu
         5FS3h6nseVJ1KX4gpcm7068FKMFT4wt6CxJ8M=
X-Received: by 2002:a17:903:2409:b0:2ae:55eb:f82d with SMTP id d9443c01a7336-2ae823681eamr163302365ad.1.1773153739133;
        Tue, 10 Mar 2026 07:42:19 -0700 (PDT)
X-Received: by 2002:a17:903:2409:b0:2ae:55eb:f82d with SMTP id d9443c01a7336-2ae823681eamr163301995ad.1.1773153738687;
        Tue, 10 Mar 2026 07:42:18 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783cfsm157096515ad.56.2026.03.10.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:42:18 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rahul Gupta <rahul-rg.gupta@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v6 07/10] bng_en: periodically fetch and accumulate hardware statistics
Date: Tue, 10 Mar 2026 20:10:41 +0530
Message-ID: <20260310144044.21672-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
References: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 4568F252618
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266189-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Use the timer to schedule periodic stats collection via
the workqueue when the link is up. Fetch fresh counters from
hardware via DMA and accumulate them into 64-bit software
shadows, handling wrap-around for counters narrower than
64 bits.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 90 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 2 files changed, 91 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 0b8131d9df46..43446f3f5bd2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -322,9 +322,93 @@ static void bnge_timer(struct timer_list *t)
 		}
 	}
 
+	if (BNGE_LINK_IS_UP(bd) && bn->stats_coal_ticks)
+		bnge_queue_sp_work(bn, BNGE_PERIODIC_STATS_SP_EVENT);
+
 	mod_timer(&bn->timer, jiffies + bn->current_interval);
 }
 
+static void bnge_add_one_ctr(u64 hw, u64 *sw, u64 mask)
+{
+	u64 sw_tmp, sw_val;
+
+	hw &= mask;
+	sw_val = READ_ONCE(*sw);
+	sw_tmp = (sw_val & ~mask) | hw;
+	if (hw < (sw_val & mask))
+		sw_tmp += mask + 1;
+	WRITE_ONCE(*sw, sw_tmp);
+}
+
+static void __bnge_accumulate_stats(__le64 *hw_stats, u64 *sw_stats, u64 *masks,
+				    int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		u64 hw = le64_to_cpu(READ_ONCE(hw_stats[i]));
+
+		if (masks[i] == -1ULL)
+			sw_stats[i] = hw;
+		else
+			bnge_add_one_ctr(hw, &sw_stats[i], masks[i]);
+	}
+}
+
+static void bnge_accumulate_stats(struct bnge_stats_mem *stats)
+{
+	if (!stats->hw_stats)
+		return;
+
+	__bnge_accumulate_stats(stats->hw_stats, stats->sw_stats,
+				stats->hw_masks, stats->len / 8);
+}
+
+static void bnge_accumulate_all_stats(struct bnge_dev *bd)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct bnge_stats_mem *ring0_stats = NULL;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_stats_mem *stats;
+
+		nqr = &bnapi->nq_ring;
+		stats = &nqr->stats;
+
+		if (!ring0_stats)
+			ring0_stats = &bn->bnapi[0]->nq_ring.stats;
+
+		__bnge_accumulate_stats(stats->hw_stats, stats->sw_stats,
+					ring0_stats->hw_masks,
+					ring0_stats->len / 8);
+	}
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		struct bnge_stats_mem *stats = &bn->port_stats;
+		__le64 *hw_stats = stats->hw_stats;
+		u64 *sw_stats = stats->sw_stats;
+		u64 *masks = stats->hw_masks;
+		u16 cnt;
+
+		cnt = sizeof(struct rx_port_stats) / 8;
+		__bnge_accumulate_stats(hw_stats, sw_stats, masks, cnt);
+
+		hw_stats += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		sw_stats += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		masks += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		cnt = sizeof(struct tx_port_stats) / 8;
+		__bnge_accumulate_stats(hw_stats, sw_stats, masks, cnt);
+	}
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		bnge_accumulate_stats(&bn->rx_port_stats_ext);
+		bnge_accumulate_stats(&bn->tx_port_stats_ext);
+	}
+}
+
 static void bnge_sp_task(struct work_struct *work)
 {
 	struct bnge_net *bn = container_of(work, struct bnge_net, sp_task);
@@ -336,6 +420,12 @@ static void bnge_sp_task(struct work_struct *work)
 		return;
 	}
 
+	if (test_and_clear_bit(BNGE_PERIODIC_STATS_SP_EVENT, &bn->sp_event)) {
+		bnge_hwrm_port_qstats(bd, 0);
+		bnge_hwrm_port_qstats_ext(bd, 0);
+		bnge_accumulate_all_stats(bd);
+	}
+
 	if (test_and_clear_bit(BNGE_UPDATE_PHY_SP_EVENT, &bn->sp_event)) {
 		int rc;
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 10ecd5d64a87..ca1977b58964 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -304,6 +304,7 @@ enum bnge_sp_event {
 	BNGE_LINK_SPEED_CHNG_SP_EVENT,
 	BNGE_LINK_CFG_CHANGE_SP_EVENT,
 	BNGE_UPDATE_PHY_SP_EVENT,
+	BNGE_PERIODIC_STATS_SP_EVENT,
 };
 
 struct bnge_net {
-- 
2.47.3


