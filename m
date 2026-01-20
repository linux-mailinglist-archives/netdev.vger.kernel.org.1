Return-Path: <netdev+bounces-251479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF8WMgZTcGlvXQAAu9opvQ
	(envelope-from <netdev+bounces-251479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:16:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6FC50E7E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 342B76A03E1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFA942884C;
	Tue, 20 Jan 2026 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="g58fS7u9"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D727428846;
	Tue, 20 Jan 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912736; cv=none; b=WF1GYrBnYaOXARM8OvgwJtz4PCRLvo+fidOPfLZV0xEukCGzFMy1ZjuEe6wZIlFZiDjUtJZvWEe4jspe9H9fmNJCwdHTAsV2xrHWk7xNyfDX6tUONbQDe/Ve331tde5M/XPlJmyExfm2GNlSNvkAvuHRiyfUDBo5NOg37jNPfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912736; c=relaxed/simple;
	bh=GJJxBVl/ChCYeskZ/WAStFbDDjrKJv9+4Bm/AQd5EjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b+vHfrKDPKUKC8mL2+LvxQViUoZMIW/cqo8PUW74Z6Q/ZC5NUk6v2OjYxOcxQ9W0VXE4KqLH9qufa0APgGuU5QHIKafqsxdYDl3E8P1Oba1gf41VnVr52pUEmqm+Pf0vR/CTmED/xQNFBKiiUs4sjG5+boIzFHsg3ssuc5CJmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=g58fS7u9; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Pc4QhX2FrFGoxvelexjtpvyVwVFTxxhfJ2JkUXZ+Vx0=;
	b=g58fS7u9Rq5eHrE498axQ2lQ+B+fUBq2qUpg1ZeMdEhQ5NIfLZLI3222DsKSrb6HhVQUJx+SM
	Fm6x+qjMPzPkPjrERPGmAsr1wZKg8HIAEJRE4CD2AqiZt1xVqymRsdoTRqZAtu6oAN/40Rcwhk8
	P1hlTr+CLcBi6/EiVPchvHg=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dwRc96WPVzpSt7;
	Tue, 20 Jan 2026 20:35:05 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4783040571;
	Tue, 20 Jan 2026 20:38:50 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 20:38:49 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net v01 0/5] net: hinic3: Fix netif_queue_set_napi input parameters and code styles
Date: Tue, 20 Jan 2026 20:38:38 +0800
Message-ID: <cover.1768911232.git.zhuyikai1@h-partners.com>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251479-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,h-partners.com:mid]
X-Rspamd-Queue-Id: EC6FC50E7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset provides netif_queue_set_napi bug fix and serveral code styles
fixes to :

Fix netif_queue_set_napi queue_index parameter passing error.
Remove empty lines between error handling.
Remove redundant defensive code.
Use array_size instead of multiplying.
Sq use SQ_CTXT_PREF_CI_HI to improve readability.

Thanks,
Fan gong

Fan Gong (5):
  hinic3: Fix netif_queue_set_napi queue_index parameter passing error
  hinic3: Fix code Style(remove empty lines between error handling)
  hinic3: Remove redundant defensive code
  hinic3: Use array_size instead of multiplying
  hinic3: RQ use RQ_CTXT_PREF_CI_HI instead of SQ_CTXT_PREF_CI_HI

 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  |  3 ---
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   |  1 -
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 23 +++++++++++--------
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  5 ----
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |  4 ----
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  2 --
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  6 +++--
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  6 ++++-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  7 ------
 9 files changed, 23 insertions(+), 34 deletions(-)


base-commit: 4515ec4ad58a37e70a9e1256c0b993958c9b7497
-- 
2.43.0


