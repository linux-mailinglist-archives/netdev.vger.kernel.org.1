Return-Path: <netdev+bounces-260529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PjiLyOlnWmZQwQAu9opvQ
	(envelope-from <netdev+bounces-260529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:18:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 416931877F1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B55AC30EAF8F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7998D39E6E8;
	Tue, 24 Feb 2026 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xcMFw7uH"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F639C654;
	Tue, 24 Feb 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938979; cv=none; b=FymbXyodcKcdST2IoAFe1TyH6sm2hoXbLr/VAdEbQACcPQzIBN1lAJImVlpTwi6ZKdX+mKcW5MxNhh0GKbE7iFUUmrvxkZSfS5Wg88Dulas5j5cB1xTH499cCQouO9fvXUEesKGFvtDfSr5k1l5FCaHBbSuUyFeMx/rfhaFD4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938979; c=relaxed/simple;
	bh=BeWFJxf2XYxYu02a4dfK8lnCInbOQTUZD7emoGiYkG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlQUxqv15fpkwviFdi94a58HqK7f0+oiJdaS+Yt7fx3WbFH1Z6R2lv06ylBfYrnKfwjomUkptRrygKugtmBHHEfNkwD571tz/GYATxq39vo5QJV1TmTVzPy55kBT9lVPqXXWsYpaVyDBG6MFealuqbFJSrD3YT28K0DGF/uQ8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xcMFw7uH; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k1otGlIq0DvgLuj19r0nerBLtwuaRaSRi85XHRod0V8=;
	b=xcMFw7uHzi5CQE7UeAXBxeggg7RIuzbRwPIedMRkBYtca47A4zZFPVC25zRr2B5KMaxQ+R/j1
	7vxHOQEEGVK5d6k4zFRCpmx5wMw0N8lZNtXs9V0oBsmj/qyYunFtNLagXhOVRRkImMjXlK+Pwg/
	F1FMfnEzKZleqegzYMpTPK4=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fKym55QlGznTV9;
	Tue, 24 Feb 2026 21:11:33 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E980640561;
	Tue, 24 Feb 2026 21:16:14 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:14 +0800
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
Subject: [PATCH net-next v01 07/15] hinic3: Add PF FLR wait and timeout handling
Date: Tue, 24 Feb 2026 21:15:44 +0800
Message-ID: <0b0cacfc5dad177c49a25385e9857dfe95a08a7f.1771916043.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1771916043.git.zhuyikai1@h-partners.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260529-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,h-partners.com:mid,h-partners.com:email]
X-Rspamd-Queue-Id: 416931877F1
X-Rspamd-Action: no action

Add a mechanisim for PF to wait for FLR completion, ensuring HW state
consistency after a FLR event.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index dc2f236a88b8..e494e3ce61f6 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -292,6 +292,28 @@ int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth)
 	return 0;
 }
 
+#define HINIC3_FLR_TIMEOUT    1000
+
+static enum hinic3_wait_return hinic3_check_flr_finish_handler(void *priv_data)
+{
+	struct hinic3_hwif *hwif = priv_data;
+	enum hinic3_pf_status status;
+
+	status = hinic3_get_pf_status(hwif);
+	if (status == HINIC3_PF_STATUS_FLR_FINISH_FLAG) {
+		hinic3_set_pf_status(hwif, HINIC3_PF_STATUS_ACTIVE_FLAG);
+		return HINIC3_WAIT_PROCESS_CPL;
+	}
+
+	return HINIC3_WAIT_PROCESS_WAITING;
+}
+
+static int hinic3_wait_for_flr_finish(struct hinic3_hwif *hwif)
+{
+	return hinic3_wait_for_timeout(hwif, hinic3_check_flr_finish_handler,
+				       HINIC3_FLR_TIMEOUT, 0xa * USEC_PER_MSEC);
+}
+
 #define HINIC3_WAIT_CMDQ_IDLE_TIMEOUT    5000
 
 static enum hinic3_wait_return check_cmdq_stop_handler(void *priv_data)
@@ -389,6 +411,14 @@ int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev)
 		ret = err;
 	}
 
+	if (HINIC3_FUNC_TYPE(hwdev) != HINIC3_FUNC_TYPE_VF) {
+		err = hinic3_wait_for_flr_finish(hwif);
+		if (err) {
+			dev_warn(hwdev->dev, "Wait firmware FLR timeout\n");
+			ret = err;
+		}
+	}
+
 	hinic3_toggle_doorbell(hwif, ENABLE_DOORBELL);
 
 	err = hinic3_reinit_cmdq_ctxts(hwdev);
-- 
2.43.0


