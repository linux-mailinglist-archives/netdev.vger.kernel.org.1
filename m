Return-Path: <netdev+bounces-296530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8XeIHNu3JmoIbwIAu9opvQ
	(envelope-from <netdev+bounces-296530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:38:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 922E265640D
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:38:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=xDRLn8Lq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296530-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296530-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 478FF30105BA
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4484F37B40E;
	Mon,  8 Jun 2026 12:36:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181737B007;
	Mon,  8 Jun 2026 12:36:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922207; cv=none; b=WpbBW526ZdU8sS/PleSdj8lQPxyNlEFCY2YWh3i4hCGf73c3UbYY7z8/DARxb0M/4eUsUJA5381v+PXIgSIDtzF0vU31CQCj94rgp/DuiN5ofFr68wGyC+KRf/IKPxZGYY/LjlG1+X6QTYw8Rr5o7jjSTOVk1+OwDafbbmnghf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922207; c=relaxed/simple;
	bh=g4CluzOIL2rNCpaQ8WP9NcVs3xRNMTRtbY2z4rvFoWE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T1fUKBDFfRfoJDklIOBETDBeUFtzNz0TMsD/9HOquz1mPu7KUGDRc7y2LDu6RBQ9hCh5N1zI76sVrB8iafF1Iy4q56I3y2vQ4GvC+ou3l1coNW8zsDsC7CAfnqt3BsjforwV9r1qnGTcUgUOOPE6MSepiEiJQY5aGpuVLP8HjOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xDRLn8Lq; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zVuxhTpZ6bEfn2g5B4QNJUaJWBugeusAhx29I6uSzXc=;
	b=xDRLn8Lq1SN6Jfl/qhGV9p+91uENOCLpxM4pBVogkOg2yGfKrs21bISAlxcPvf/QGmuBwQkbO
	DsAGBtdhFZ49vqBfGldzphGEqDrxL5qyuupI/IpHFInBjN9Pagr5tiWtwQtUwHnkIxnglywki+A
	8VSdiQ3I4aiBLKo/klwQuZM=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gYrtF4MW1z1T4HJ;
	Mon,  8 Jun 2026 20:28:21 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id EDACE40571;
	Mon,  8 Jun 2026 20:36:39 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 8 Jun 2026 20:36:38 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v08 0/5] net: hinic3: PF initialization
Date: Mon, 8 Jun 2026 20:36:29 +0800
Message-ID: <cover.1780907605.git.wudi234@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-296530-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 922E265640D

This is [3/3] part of hinic3 Ethernet driver second submission.
With this patch hinic3 becomes a complete Ethernet driver with
pf and vf.

Add 20 ethtool ops for information of queue, rss, coalesce and eth data.
Add MTU size validation
Config netdev watchdog timeout.
Remove unneed coalesce parameters.

Changes:

PATCH 03 V01: https://lore.kernel.org/netdev/cover.1773387649.git.zhuyikai1@h-partners.com/
* Add rmon/pause/phy/mac/ctrl stats (Ioana Ciornei)

PATCH 03 V02: https://lore.kernel.org/netdev/cover.1774684571.git.zhuyikai1@h-partners.com/
* Modify "return -EINVAL" intension problem (AI review)
* Use le16_to_cpu for rss_indir pair.out->buf (AI review)
* Use u32 instead of int in coalesce_limits to avoid overflow (AI review)
* Remove redundant u64_stats_update_begin/end when reading stats without
  concurrent reader (AI review)
* Modify nic_dev->stats.syncp logic (AI review)
* Complete rxq/txq stats stats fileds in hinic3_rx/txq_get_stats (AI review)
* Remove statistics values in rtnl_link_stats64 from ethtool statistics
  values (AI review)
* Add channel_cfg_lock & channel_res_lock to protect resources access (AI review)
* Remove OutOfRangeLengthField, FrameToolong and InRangeLengthErrors (Ioana Ciornei)
* Remove redundant mtu commit (Maxime Chevialler)

PATCH 03 V03: https://lore.kernel.org/netdev/cover.1774940117.git.zhuyikai1@h-partners.com/
* Change unnedd to unneeded (AI review)
* Remove packets,bytes,errors and dropped in hinic3_rx/tx_queue_stats (AI review)
* Remove duplicated entried in hinic3_port_stats[] (AI review)
* change stats_info.head.status to ps->head.status (AI review)

PATCH 03 V04: https://lore.kernel.org/netdev/cover.1775618797.git.zhuyikai1@h-partners.com/
* Remove restore_drop_sge in hinic3_rx_queue_stats (AI review)
* Remove hinic3_nic_stats (AI review)
* Use old_q_param to store old config and use it in error handling (Mohsin Bashir)
* Add netdev_info to inform the user that depth is trimmed (Mohsin Bashir)
* Remove const in hinic3_get_qp_stats_strings parameters (Mohsin Bashir)
* Change EOPNOTSUPP to ERANGE in is_coalesce_exceed_limit (Mohsin Bashir)
* Update nic_dev->rss_type after hinic3_set_rss_type (Mohsin Bashir)
* Modify MGMT_STATUS_CMD_UNSUPPORTED to EOPNOTSUPP for complying with the
  error code specifications (Mohsin Bashir)

PATCH 03 V05: https://lore.kernel.org/netdev/cover.1775711066.git.zhuyikai1@h-partners.com/
* Clear HINIC3_CHANGE_RES_INVALID bit in error handling (AI review)
* Use low >= high to avoid low=high in is_coalesce_legal (AI review)
* As tx and rx share interrupts, we only use ETHTOOL_COALESCE_RX_USECS for
user setting to avoid user misunderstanding. So we do not add
ETHTOOL_COALESCE_TX_USECS. (Mohsin Bashir & AI review)

PATCH 03 V06: https://lore.kernel.org/netdev/cover.1779867397.git.zhuyikai1@h-partners.com/
* Remove redundant rx_jumbo_pending and rx_mini_pending judgement (Jakub Kicinski)
* Remove redundant max tx_pending judgement when .get_ringparam already got the
   max value (Jakub Kicinski)
* Use extack instead of netdev_err/netdev_info/netdev_warning (Jakub Kicinski)
* Remove HINIC3_CHANNEL_RES_VALID and only use HINIC3_CHANGE_RES_INVALID
  bit (Jakub Kicinski)
* Deference freed pointers in hinic3_change_channel_settings error
  handling (Jakub Kicinski)
* Modify hinic3_open_channel (Jakub Kicinski)

PATCH 03 V07: https://lore.kernel.org/netdev/cover.1779940072.git.zhuyikai1@h-partners.com/
* Remove the trailing '\n' in NL_SET_ERR_MSG* (Jakub Kicinski)

PATCH 03 V08:
* Update patch commit to be more accurate for change information (AI review)
* Modify <net/devlink.h> to <linux/netlink.h> (AI review)
* Use sq/rq_depth instead of rx/txqs[0].q_depth (AI review)
* hinic3_change_channel_settings() runs under change_res_mutex
  to protect dynamic channel updates (AI review)
* hinic3_close() serializes close and channel reconfiguration paths (AI review)
* Remove useless u64_stats_init in hinic3_get_drv_queue_stats() (AI review)
* hinic3_get_drv_queue_stats() fills rxq stats at correct idx
  when txq is null (AI review)
* Remove unnecessary semicolons after the closing bracket of
  static inline functions (AI review)
* Disable preemption in hinic3_rx_fill_buffers() (AI review)
* Add spinlock to protect per-queue coalesce parameters from
  concurrent access (AI review)
* Reject static coalesce config when adaptive RX coalesce is
  enabled (AI review)
* Validate interface state and queue ID before modifying coalesce
  parameters (AI review)
* Differentiate get_coalesce output for adaptive/static modes and
  zero-fill the struct (AI review)
* Return -ERANGE for invalid coalesce frame limits and simplify
  error message (AI review)
* Remove unused watchdog timeout definition and assignment (AI review)
* Return -EOPNOTSUPP when RSS type query is unsupported by firmware (AI review)
* Reject L4 hash bits for pure L3 flow types (AI review)
* Split RSS type conversion to correctly handle L3-only flows (AI review)
* Reprogram RSS indir table and HW parameters after channel count
  changes (AI review)
* Propagate exact error code from channel parameter validation (AI review)
* Update SW RSS indir copy only after HW programming succeeds (AI review)
* Program RSS hash type to HW before updating SW state to prevent
  inconsistency (AI review)

Fan Gong (5):
  hinic3: Add ethtool queue ops
  hinic3: Add ethtool statistic ops
  hinic3: Add ethtool coalesce ops
  hinic3: Add ethtool rss ops
  hinic3: Remove unneeded coalesce parameters

 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 841 +++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  11 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  14 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   7 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  39 +
 .../huawei/hinic3/hinic3_netdev_ops.c         | 104 ++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  64 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 109 +++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  11 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |   4 +-
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |   8 +-
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 539 ++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  19 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  72 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  18 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  62 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |   2 +
 17 files changed, 1890 insertions(+), 34 deletions(-)


base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
-- 
2.43.0


