Return-Path: <netdev+bounces-275855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLdwLrRy1GmSuAcAu9opvQ
	(envelope-from <netdev+bounces-275855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:57:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 313E03A946B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4282E302011A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EFC372B37;
	Tue,  7 Apr 2026 02:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D941474CC
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530658; cv=none; b=crCwwvh/4aB+kxoloPq/VOxrE15qpkHnNhBQb+lAKbPdGjxnm/iTgQ1jxbrkBVw98r700xVXPcn3qzx7RB8v6B7yYLQQuaOLCVucUBnNxPjTab7SMlCsyIAUZ8KbUFYeTPkGOSdFkZbHGyNIik1jjDJ/S9PsgsWv0enpRniVMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530658; c=relaxed/simple;
	bh=OZAyKRLbYvnVJJ/bV1ihc1E9k+nnXy2yb4sZIaWjbAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sSdRR8Qsab3m2WTFVrGPP4mJMJuZoBLjTv0cduSYvy1yhpVYDIQZ2K4ZGGpB7Uekieo0FiC/dJ6jjI4JugeJUmvT9VqMgWTNCEwIEjNscWX9d8cLOhXra5tRiR/pOqGKtznTK7zYfhxWSIn7Fqp/TBQ5nkGyEiv2fcW4njjXVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1775530618t4f6387af
X-QQ-Originating-IP: oDjAHEP5ht65IJvabg3peAldcMUQvngKmvfTc1ORPLk=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 10:56:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13454302501692638748
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 8/9] net: libwx: wrap-around and reset qmprc counter
Date: Tue,  7 Apr 2026 10:56:15 +0800
Message-Id: <20260407025616.33652-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260407025616.33652-1-jiawenwu@trustnetic.com>
References: <20260407025616.33652-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MoXwTY6T4qpUzI1+RGBUZFeTeNbZBBWzVxoimS9Oun/9LfoCEla1nU5f
	+hxOjIId2WuLlSpV96umUiSswuDWCxg9l9Z87MOuu7zGTyoUOJa49qSF7hgWGoBnp9tzUdr
	wbbvtpSZFyafKVCtNa2+1WTgVIPcLJZevSlqcekgDadYipnpqjWDFSudNPfe8VthWoEh7M/
	X4Szzmc85heayw14IgclCAhc3ZSau7KfoBfSzcu8OZRTNdE6S4PcF567Qj5aT/BqRppsFSr
	O7kcPz7PchNpGrK8PFc90qekZOXbhrKuLYb04U8wTjCYfvGgCvBfq4ZcI/teRs/8QY0qBzP
	z1FktJ9EskSfCSKh8q+CI1fgqomaE/ZlJDgRhkqAUBQ7Aq9V4XbP65Eb+8VVc0RYsm/TNmZ
	ociv2tMphhzi47RN+hQQVfwg/m1xdpf+GRtdK0JHfw32/5vqPbbVW+2DL+nILoo1LM+fQe9
	xKkYis6ikwT9m4w08w4ycbm+Bc2b9PazbLlppkftCPVlJRrW3/VwujIG44c8uGB7qqiBfnc
	rmiefaxrRdCE6q8GpaCthWHkbsA5k2yRYgd/H3nh8vhQxhSQ1xO8TLsvCmn+pznawDHS+Xh
	Tma78HyQ4zJi0zmi8jhZqJ84OTlcEsSOON/R303/uLvzkClEyxVARxUOETeT2epKbGpCJaC
	y+jvxWfvLXLcZbrG2gYonAgY/3dttFIks6acWERTMWN4KWZD+rz1iVilIRDpOjsTMABPCz8
	/ALGpu0f+ozLD4HVplrAAgtoyPUVRneTWIT650qmfX5/NMLs/IbNC+z88lrjjUOe03eahpv
	cF3L/+w1oXrhnq8ZA0wW/MAhLBnqWk6SMA1WD/evoU6pbk/rRSOlgUeorQ8jGMwM7xO7mEK
	G8ANunG9PO8S1G1oDYSC89SjDMZwWoY7yCOl7NhRPGqdB0oAqAuSNhzU6smeOb2oZEgVdm4
	sfMINM0EZH+0oj46mfZiBjIejzDAuN2RQ5VO7LdZW0331EAEWhI6+WJNBcjFJ8eRQW++TRY
	IA9xi/gKsE+nQlEVCgdgJxdWpnJd5m3OLj72exAVimrxw5vGpXc/NSI9sJXBM=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275855-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,gmail.com,debian.org,trustnetic.com];
	NEURAL_SPAM(0.00)[0.362];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: 313E03A946B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The WX_PX_MPRC registers are not clear-on-read hardware counters. The
previous implementation directly read and accumulated these 32-bit values
into a 64-bit software counter. Now implement a rd32_wrap() helper
function to calculate the delta counter to correct the statistic.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 10 ++++++----
 drivers/net/ethernet/wangxun/libwx/wx_type.h | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 31259f69c0e2..57d6671ec618 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2915,11 +2915,10 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
-	/* qmprc is not cleared on read, manual reset it */
-	hwstats->qmprc = 0;
 	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
 	     i < wx->mac.max_rx_queues; i++)
-		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
+		hwstats->qmprc += rd32_wrap(wx, WX_PX_MPRC(i),
+					    &wx->last_stats.qmprc[i]);
 
 	spin_unlock(&wx->hw_stats_lock);
 }
@@ -2936,8 +2935,11 @@ void wx_clear_hw_cntrs(struct wx *wx)
 {
 	u16 i = 0;
 
-	for (i = 0; i < wx->mac.max_rx_queues; i++)
+	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
+	     i < wx->mac.max_rx_queues; i++) {
 		wr32(wx, WX_PX_MPRC(i), 0);
+		wx->last_stats.qmprc[i] = 0;
+	}
 
 	rd32(wx, WX_RDM_PKT_CNT);
 	rd32(wx, WX_TDM_PKT_CNT);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 7831c5035be8..3c5a351974dd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1182,6 +1182,10 @@ struct wx_hw_stats {
 	u64 fdirmiss;
 };
 
+struct wx_last_stats {
+	u32 qmprc[128];
+};
+
 enum wx_state {
 	WX_STATE_RESETTING,
 	WX_STATE_SWFW_BUSY,
@@ -1354,6 +1358,7 @@ struct wx {
 	bool default_up;
 
 	struct wx_hw_stats stats;
+	struct wx_last_stats last_stats;
 	spinlock_t hw_stats_lock; /* spinlock for accessing to hw stats */
 	u64 tx_busy;
 	u64 non_eop_descs;
@@ -1464,6 +1469,18 @@ wr32ptp(struct wx *wx, u32 reg, u32 value)
 	return wr32(wx, reg + 0xB500, value);
 }
 
+static inline u32
+rd32_wrap(struct wx *wx, u32 reg, u32 *last)
+{
+	u32 val, delta;
+
+	val = rd32(wx, reg);
+	delta = val - *last;
+	*last = val;
+
+	return delta;
+}
+
 /* On some domestic CPU platforms, sometimes IO is not synchronized with
  * flushing memory, here use readl() to flush PCI read and write.
  */
-- 
2.48.1


