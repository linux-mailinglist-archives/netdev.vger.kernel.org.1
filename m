Return-Path: <netdev+bounces-128049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F91977AAC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EC51F26C39
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BA21BD02E;
	Fri, 13 Sep 2024 08:07:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35912154C04;
	Fri, 13 Sep 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214870; cv=none; b=cZGddZ0eUJ3rpXpaxqCtzs3Nhe4qkxuiZsgQP7CRaobRH4RWVkAWXjHekGQT7ZEXuB3UPDzLIO1k1+34lUPZ23lCLGX8YHKx6VFqtIpPzC7AelsIEBrYqGRfR5+S2ecKdZ895mpFF9abz3MCUVQf01V6avf6DzXrFwWr00GmEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214870; c=relaxed/simple;
	bh=9ujN5GDn3kjjokM6XfuxHvZV/LXXR6pjqoGAAGI+SfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NynwcQSgbfJFci/N16rfI4AOWwILFVYvHn5hfRntRJTBuNYdG3l5MbJtlAm7wcZo05kWBM+TwW8XsqZnSH/tfbHO1prfI9+/vNw/5OkxbRv+ELTnwieptx40jvzeq6J8T0E1cW29G1jfqk1NkvXxabmXuMvBbuZyPTVlkaBfXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D3XOTJ008583;
	Fri, 13 Sep 2024 01:07:18 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gpbk6qfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Sep 2024 01:07:18 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 01:07:17 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 01:07:14 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com>
CC: <christophe.leroy@csgroup.eu>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <maxime.chevallier@bootlin.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH net-next] net: ethtool: phy: Distinguish whether dev is got by phy start or doit
Date: Fri, 13 Sep 2024 16:07:13 +0800
Message-ID: <20240913080714.1809254-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000d3bf150621d361a7@google.com>
References: <000000000000d3bf150621d361a7@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _3xazUSHFPwHRqc0I3lfNArgubU8KGIU
X-Authority-Analysis: v=2.4 cv=Ye3v5BRf c=1 sm=1 tr=0 ts=66e3f2b6 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=EaEq8P2WXUwA:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=40mUqnhr4SogbDg-WAEA:9 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: _3xazUSHFPwHRqc0I3lfNArgubU8KGIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_04,2024-09-13_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=888 clxscore=1011 bulkscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409130055

Syzbot reported a refcount bug in ethnl_phy_done.
This is because when executing ethnl_phy_done, it does not know who obtained
the dev(it can be got by ethnl_phy_doit or ethnl_phy_start) and directly
executes ethnl_parse_header_dev_put as long as the dev is not NULL.
Add dev_start_doit to the structure phy_req_info to distinguish who obtains dev.

Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on an interface")
Reported-and-tested-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e9ed4e4368d450c8f9db
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 net/ethtool/phy.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 4ef7c6e32d10..321a7f89803f 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -13,6 +13,7 @@
 struct phy_req_info {
 	struct ethnl_req_info		base;
 	struct phy_device_node		*pdn;
+	u8 dev_start_doit;
 };
 
 #define PHY_REQINFO(__req_base) \
@@ -157,6 +158,9 @@ int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
+	if (req_info.base.dev)
+		req_info.dev_start_doit = 0;
+
 	rtnl_lock();
 
 	ret = ethnl_phy_parse_request(&req_info.base, tb, info->extack);
@@ -223,10 +227,14 @@ int ethnl_phy_start(struct netlink_callback *cb)
 					 false);
 	ctx->ifindex = 0;
 	ctx->phy_index = 0;
+	ctx->phy_req_info->dev_start_doit = 0;
 
 	if (ret)
 		kfree(ctx->phy_req_info);
 
+	if (ctx->phy_req_info->base.dev)
+		ctx->phy_req_info->dev_start_doit = 1;
+
 	return ret;
 }
 
@@ -234,7 +242,7 @@ int ethnl_phy_done(struct netlink_callback *cb)
 {
 	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
 
-	if (ctx->phy_req_info->base.dev)
+	if (ctx->phy_req_info->base.dev && ctx->phy_req_info->dev_start_doit)
 		ethnl_parse_header_dev_put(&ctx->phy_req_info->base);
 
 	kfree(ctx->phy_req_info);
-- 
2.43.0


