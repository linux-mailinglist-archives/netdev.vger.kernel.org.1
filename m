Return-Path: <netdev+bounces-253300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDJTDCG+dmkYVgEAu9opvQ
	(envelope-from <netdev+bounces-253300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 02:06:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD3383408
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 02:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E80A3000FF5
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 01:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C35D19E968;
	Mon, 26 Jan 2026 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jFYrdIlD"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B98487BE;
	Mon, 26 Jan 2026 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769389598; cv=none; b=QMtDP+f/jIUiJax2NEX88jRaQGYeKcMssppjS62Za202avjmbW41ZLVE38dWI5bSZi1YNoKQyRaK6ue0mfSbGToyqyM7TM4N59k0FDyZ3AHosY5uUjX+NPznx2JDQyTQzy8k8yMW2ZKDzpvaCPsaWAp+7N+zuOfXexVCwz9j7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769389598; c=relaxed/simple;
	bh=kCqO2ZJkcDyyuTwrrkKrfVhZlwsoYyDv6tsJCP9WnZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXWUPFIhQ7bQjzqkrmbsEa5ZpEgn37kcmA906J6ScEQAFcbikQEiA1qgvzoBSJoX9d+9N1+mPLzGDFCHMiOkM74/K0ipxhjCzs0tJYFUugGeQQayNKtnF0VOeOnJ5g6N+p/raMHUSD1tG2yjyDS2t6wL1qmzTuBC8lWdBKRMYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jFYrdIlD; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oTXEVLgDumVCBFxpbO8s07ckXDCKC5Us7m6vOmueETk=;
	b=jFYrdIlD6scNu1lCaG+lOb4ovAPAm3AE9S1DxjPS7XzWJTmJ91siw+9jJyf+J11uZU12gG9yH
	LrnTfdTLhSwbMToijlqDkRUVizKzS3vHaCZhmU4HQ65F+hNejkdJvNhi2AWqUghbMyFPrVX1hO0
	jCqW7GUZ1Ef7kIbZk0dcWgE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dzqz04Wljz1K9CT;
	Mon, 26 Jan 2026 09:03:08 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 28F9440570;
	Mon, 26 Jan 2026 09:06:33 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 26 Jan 2026 09:06:31 +0800
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
Subject: [PATCH net-next v02 4/4] hinic3: RQ use RQ_CTXT_PREF_CI_HI instead of SQ_CTXT_PREF_CI_HI
Date: Mon, 26 Jan 2026 09:03:34 +0800
Message-ID: <522daf5931c4554fcc67672a0bcfa714ca1dce93.1769142701.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1769142701.git.zhuyikai1@h-partners.com>
References: <cover.1769142701.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253300-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim]
X-Rspamd-Queue-Id: 3AD3383408
X-Rspamd-Action: no action

Separate the CTX_PREF_CI_HI of rq and sq to improve readability.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
index d86cd1ba4605..90887d2bb127 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
@@ -162,6 +162,9 @@ struct hinic3_clean_queue_ctxt {
 #define SQ_CTXT_WQ_BLOCK_SET(val, member)  \
 	FIELD_PREP(SQ_CTXT_WQ_BLOCK_##member##_MASK, val)
 
+/* reuse SQ macro for RQ because the hardware format is identical */
+#define RQ_CTXT_PREF_CI_HI(val)            SQ_CTXT_PREF_CI_HI(val)
+
 #define RQ_CTXT_PI_IDX_MASK                GENMASK(15, 0)
 #define RQ_CTXT_CI_IDX_MASK                GENMASK(31, 16)
 #define RQ_CTXT_CI_PI_SET(val, member)  \
@@ -629,7 +632,8 @@ static void hinic3_rq_prepare_ctxt(struct hinic3_io_queue *rq,
 			    RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD));
 
 	rq_ctxt->pref_ci_owner =
-		cpu_to_le32(RQ_CTXT_PREF_SET(SQ_CTXT_PREF_CI_HI(ci_start), CI_HI) |
+		cpu_to_le32(RQ_CTXT_PREF_SET(RQ_CTXT_PREF_CI_HI(ci_start),
+					     CI_HI) |
 			    RQ_CTXT_PREF_SET(1, OWNER));
 
 	rq_ctxt->pref_wq_pfn_hi_ci =
-- 
2.43.0


