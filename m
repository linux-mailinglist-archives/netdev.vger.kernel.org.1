Return-Path: <netdev+bounces-260526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IrkNKSknWmZQwQAu9opvQ
	(envelope-from <netdev+bounces-260526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:16:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9588A18775C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AECE03026513
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF47239E18D;
	Tue, 24 Feb 2026 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QKpMSpAI"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076BB39C65C;
	Tue, 24 Feb 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938975; cv=none; b=tThCN9Q7ZghgAIE3ntpROpqER6TsOPfmylh68tn1brzqF/YaEtuFj5hGRYZIJVpCQ289nW6k0dP+p7ni+vTxM3fQrTIE05J4KtnUImzq9FRlCgTDmCM1H13TjgyCFH79r+VOHFa5L0w39ULzBOVzZXksyGQRMitpvMF/lb4M8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938975; c=relaxed/simple;
	bh=GF/oHl/8hMLdsJmFBHfQUTk9KqyrNTSf61qDfrlAWqk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XekFuHGuLkG7xFRTD9SDLt7p1tbsi+QR6hiNsYo60/NARWfRLm80oFqiLHo8aoALWgxyfqStGSIwhC/dLxMZ+H6oyysm9R8z6BkIt1kYJEJ/hKLWulTlB8CFdRrqB5na5qK3rb/2AKfCjxuc6payWEb96JZshR8s99qz5p9CC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QKpMSpAI; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IMiEa0RUKKNBqPTwHrxxYXdut90yci9zePakTv5j+6g=;
	b=QKpMSpAIVbPsxR2sZZp2mdc/S1BOw/PBnvdgZmpbwUv6aMBExxJnmNgXudjS4orJ2f3gl7bkB
	9Le101kmLy54NvdTEamAVtjVFaPIlNpnoyyCXC1abaD58TYezVe79yfLOlyqWx2GeOTdSJYnI2A
	ViHPeC+kcVz01umL9ahpso4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fKylh4dh4z1T4Mf;
	Tue, 24 Feb 2026 21:11:12 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 471A04056B;
	Tue, 24 Feb 2026 21:16:03 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:02 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>
Subject: [PATCH net-next v01 00/15] net: hinic3: Fix code styles
Date: Tue, 24 Feb 2026 21:15:37 +0800
Message-ID: <cover.1771916043.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260526-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,h-partners.com:mid]
X-Rspamd-Queue-Id: 9588A18775C
X-Rspamd-Action: no action

This patchset provides 4 code styles fixes:

Remove empty lines between error handling.
Remove defensive txq_num check.
Use array_size instead of multiplying.
SQ use SQ_CTXT_PREF_CI_HI to improve readability.

Changes:

PATCH V01: https://lore.kernel.org/netdev/cover.1768915707.git.zhuyikai1@h-partners.com/

PATCH V02: https://lore.kernel.org/netdev/cover.1769142701.git.zhuyikai1@h-partners.com/
* Send "Fix netif_queue_set_napi queue_index parameter passing error" to net (Jakub Kicinski)

PATCH V03:
* Modify commit description to be more accurate and clear (Simon Horman)

Fan Gong (15):
  hinic3: Add command queue detailed-respone interfaces
  hinic3: Add Command Queue/Async Event Queue/Mailbox dump interfaces
  hinic3: Add chip_present_flag checks to prevent errors when card is
    absent
  hinic3: Add RX GRO and VLAN offload support
  hinic3: Add msg_send_lock for message sending concurrecy
  hinic3: Add PF device support and function type validation
  hinic3: Add PF FLR wait and timeout handling
  hinic3: Add PF/VF capability parsing and parameter validation
  hinic3: Add ethtool basic ops
  hinic3: Add ethtool queue ops
  hinic3: Add ethtool statistic ops
  hinic3: Add ethtool coalesce ops
  hinic3: Add ethtool rss ops
  hinic3: Add MTU size validation
  hinic3: Config netdev->watchdog_timeo to set nic tx timeout

 drivers/net/ethernet/huawei/hinic3/Makefile   |    1 +
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  |  225 ++-
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  |   15 +
 .../ethernet/huawei/hinic3/hinic3_common.h    |    1 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |    2 +
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   |   67 +
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   |    6 +
 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 1217 +++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |   53 +-
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |    8 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |   65 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |    2 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |   25 +-
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |   11 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |    1 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |   31 +-
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |    3 +-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |    1 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   10 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |   35 +-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |    2 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |   55 +-
 .../huawei/hinic3/hinic3_netdev_ops.c         |   76 +-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  167 +++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  219 +++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   30 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |    4 +
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |    1 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   |  487 ++++++-
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |   19 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |   84 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |   17 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |   72 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |    2 +
 34 files changed, 2985 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c


base-commit: f77c7b96014471f2c39823ed9fcb42967e7d9ede
-- 
2.43.0


