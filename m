Return-Path: <netdev+bounces-226578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD2BA23B3
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708911C27FD6
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 02:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC945261573;
	Fri, 26 Sep 2025 02:40:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B9261393
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854436; cv=none; b=M/2fRyroJpRmZjsZRbroDLHGP5gqZBDy85Pw96pVYSbJ8S2dAswQWRWZ1VdforyPVcYP+STqjZkwFBzmgEQwFE0XlgjHHdSa+2W7ic/hW3Jc+ZxcmXliAZrgq0Do5F6KQqTq/wk0rhkFj5wRMQN0Qe+nPrLrAl9HBDhtVblepJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854436; c=relaxed/simple;
	bh=HYcrHswZ2rNrscFtHEp7X9oWjpuXPb1PawcyHBkezZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+Iiy4NDvdPhH23xmCApf6lqboaGJDNF3cSMswDPv3nZVz9nxHqz5LluacWd1gq1A68+pS86t2j/IR719AIinCjLK6ZjjCsM8cdU7ieT3u+l19Bb+l6bcqnlHbiL90m8ce441cV6CfxKDrtP/8irigOVnUi0w2+E+V7syqyIxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1758854330t1f523b16
X-QQ-Originating-IP: 9NT9RvM8ns28Itbs6pDsPWb0jUEGgpuxr6VuRqvHqVU=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.236.115])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Sep 2025 10:38:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2700399627837190482
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 0/4] net: wangxun: support to configure RSS
Date: Fri, 26 Sep 2025 10:38:39 +0800
Message-Id: <20250926023843.34340-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MAMW4dxoxFyt6NXv1ZVbA0b9NwIf66I9967o23a5tjL/oGooF89cYmby
	PM0gMBeNat0i4Eh3LvXMiXn3uD/91q4gkT8cMYCaQShXce5+Z7X9Hl4ZerTn/W106IbWdvn
	KuH17qqJoXJzqrHJCsOQn6vOQUjbHMjizQBbTDMDO7wk9/H7zahVZi9/gEs6B5e6S41x1cB
	qDxUq1Cq7ly7vv8wPxke4PTRhvoZ2Or/OiUuA+QaDvRZNc3TcQiIlIhy6ZPR9mhRDCfEqMe
	RNu+bJ918QX9t6X7AGgvykCb4FZsWtBHUN4uE8cg4UXBLltFMDyWli5GWtHnDqx4xTH74Ok
	KuZlmNRGf6ArSNh8o/NnpT2nxEmiRQDT0RnGp0XJwQTNgJMhJkwKrKHpzBuE/zTYiovtjP9
	OcSPAUHo6Pl5yPgfq9pXcH5axg+PqwO6Cf/WdMn3VgV9+tCt4oEw2YE/7jBiE1c9joO/MmF
	p9dow/8UkwwdLBZ59CFBBh9VlUeSLuoa4CytiPPQ1g1oUvUPHGVjbSjO9X6+SvGZLx8SHZ0
	kcd5wbix58x2hmBO3GojSiicSi837LFwq7wNlv7BPfQn306u3Lcicvy2YOvFBLoStwOSiER
	YHfa9cR5uq/4iJdm4U8J7PH9P5+6Gx3sl/DRLb2Vq9nV9sbndrxpAVE2TAY5/W05ci1dqVP
	UJRhXl9xrP7+73eCHDg0mZ1l3OQT4D2mk4uv5eEDVqcxP2pOp1B3R9ON4VoPvW0oIKb7z9X
	RZnilZhtQ9pT6RKamYRgidHD9ja52fkI+en1zxTNGA7ZPQ6+FoEJb4xN6B67FsTCx0FGGPk
	Hu7w2uvU9ePt4A0qUQ69d1JqOWwcY06OHRFjOSIuarDbNDgpmL3E78RFBFGCam9+zl+GEKC
	L5KgHrGe67HzrLbcLexJ2ksLIJDH7EkxKbI26lxMFo5SfIl3feTh0R0YtJaGIVXeAnz1Ma/
	YACcTANq9ckihiag2W9qfpXIwmnigq9j+1N1HG51Pz0bjBhyunooWbV7PT3JMwTwdFB8K2e
	pmIIuA7SlRvs0b9WQ5MfCT3/zpZ7r8h3oImAmDc0QXueKgaCKyu3xw5LT7kioCRNKs5Ia3d
	UKUmX/zJ1I0
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Implement ethtool ops for RSS configuration, and support multiple RSS
for multiple pools.

Kselftest output:
---
TAP version 13
1..12
ok 1 rss_api.test_rxfh_nl_set_fail
ok 2 rss_api.test_rxfh_nl_set_indir
not ok 3 rss_api.test_rxfh_nl_set_indir_ctx
ok 4 rss_api.test_rxfh_indir_ntf
not ok 5 rss_api.test_rxfh_indir_ctx_ntf
ok 6 rss_api.test_rxfh_nl_set_key
ok 7 rss_api.test_rxfh_fields
not ok 8 rss_api.test_rxfh_fields_set
not ok 9 rss_api.test_rxfh_fields_set_xfrm
ok 10 rss_api.test_rxfh_fields_ntf
not ok 11 rss_api.test_rss_ctx_add
not ok 12 rss_api.test_rss_ctx_ntf
# Totals: pass:6 fail:6 xfail:0 xpass:0 skip:0 error:0

TAP version 13
1..17
not ok 1 rss_ctx.test_rss_key_indir
ok 2 rss_ctx.test_rss_queue_reconfigure # SKIP Not enough queues for the test or qstat not supported
ok 3 rss_ctx.test_rss_resize
ok 4 rss_ctx.test_hitless_key_update
not ok 5 rss_ctx.test_rss_context
not ok 6 rss_ctx.test_rss_context4
not ok 7 rss_ctx.test_rss_context32
ok 8 rss_ctx.test_rss_context_dump # SKIP Unable to add any contexts
ok 9 rss_ctx.test_rss_context_queue_reconfigure # SKIP Not enough queues for the test or qstat not supported
not ok 10 rss_ctx.test_rss_context_overlap
not ok 11 rss_ctx.test_rss_context_overlap2
not ok 12 rss_ctx.test_rss_context_out_of_order
not ok 13 rss_ctx.test_rss_context4_create_with_cfg
ok 14 rss_ctx.test_flow_add_context_missing
not ok 15 rss_ctx.test_delete_rss_context_busy
not ok 16 rss_ctx.test_rss_ntuple_addition
not ok 17 rss_ctx.test_rss_default_context_rule
# Totals: pass:3 fail:11 xfail:0 xpass:0 skip:3 error:0
---

Changes logs:
---
v6:
- replace the simple "if else" with "!!"
- remove the check of netif_is_rxfh_configured() in set_channels
- add RSS API test results

v5: https://lore.kernel.org/all/20250922094327.26092-1-jiawenwu@trustnetic.com/
- add a separate patch for moving rss_field to struct wx
- add a patch to restrict change number of ring
- rename "random_key_size"
- use wx->rss_key[i] instead of *(wx->rss_key + i)

v4: https://lore.kernel.org/all/20250912062357.30748-1-jiawenwu@trustnetic.com/
- rebase on net-next

v3: https://lore.kernel.org/all/20250902032359.9768-1-jiawenwu@trustnetic.com/
- remove the redundant check of .set_rxfh
- add a dependance of the new fix patch

v2: https://lore.kernel.org/all/20250829091752.24436-1-jiawenwu@trustnetic.com/
- embed iterator declarations inside the loop declarations
- replace int with u32 for the number of queues
- add space before '}'
- replace the offset with FIELD_PREP()

v1: https://lore.kernel.org/all/20250827064634.18436-1-jiawenwu@trustnetic.com/
---

Jiawen Wu (4):
  net: libwx: support separate RSS configuration for every pool
  net: libwx: move rss_field to struct wx
  net: wangxun: add RSS reta and rxfh fields support
  net: libwx: restrict change user-set RSS configuration

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 136 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 133 ++++++++++++-----
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |  22 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  23 +++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
 9 files changed, 304 insertions(+), 49 deletions(-)

-- 
2.48.1


