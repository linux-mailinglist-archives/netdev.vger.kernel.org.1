Return-Path: <netdev+bounces-89612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1148AAE33
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E611F21C15
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F083CC7;
	Fri, 19 Apr 2024 12:12:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m25499.xmail.ntesmail.com (mail-m25499.xmail.ntesmail.com [103.129.254.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312378285;
	Fri, 19 Apr 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528766; cv=none; b=Fk+MsmtDSYiauG3Wri77oc+a3ZseTDq7m02XcisARHpoOPu/KyX5U80JTl1z1+WwFLwNsHvCXbIH1qPBkqgaKM7o2NZWMNHFwLPEZHWkzV7k0i6gdGdxXfzywCPoJtZ6Ei/Yex4F2QrU5fPwauNT5puFAJEQlTdfVgfN9eEoxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528766; c=relaxed/simple;
	bh=KZGUHlRWEuj7dHpQ9LaQKSzrzqTzErAnF5h96rQdeJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=df+Wz76eGw2j8kZMQhMIWr1ahw+qZzZ/Rv3QJNrCxgkV4LA3o/cnWZP5274YDUbuaUYbD1eSGIdHszHKGGRjG/3ikKEY0UBgBV2gDY7scFf4sFHc5enl7++pYSY8z3FDPudzJKjLuQtSp/ltonmPKWB3PZgk71QWfXHupAogvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=103.129.254.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 6F0EF56025F;
	Fri, 19 Apr 2024 14:14:28 +0800 (CST)
From: Jun Gu <jun.gu@easystack.cn>
To: kuba@kernel.org
Cc: dev@openvswitch.org,
	echaudro@redhat.com,
	jun.gu@easystack.cn,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4] net: openvswitch: Check vport netdev name
Date: Fri, 19 Apr 2024 14:14:25 +0800
Message-Id: <20240419061425.132723-1-jun.gu@easystack.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTh8eVk5DGksYGh4dTxgfSlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8ef4fdf7cc023dkunm6f0ef56025f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ok06Pxw5Gjc0Th8uMRwoLA9N
	GQkaFChVSlVKTEpITktMSU1DQ0JCVTMWGhIXVREOFVUcDjseGggCCA8aGBBVGBVFWVdZEgtZQVlK
	SktVSkNOVUpMS1VJSUxZV1kIAVlBSkxJSjcG

Ensure that the provided netdev name is not one of its aliases to
prevent unnecessary creation and destruction of the vport by
ovs-vswitchd.

Signed-off-by: Jun Gu <jun.gu@easystack.cn>
Acked-by: Eelco Chaudron <echaudro@redhat.com>
---
 net/openvswitch/vport-netdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 903537a5da22..618edc346c0f 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -78,7 +78,10 @@ struct vport *ovs_netdev_link(struct vport *vport, const char *name)
 	int err;
 
 	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
-	if (!vport->dev) {
+	/* Ensure that the device exists and that the provided
+	 * name is not one of its aliases.
+	 */
+	if (!vport->dev || strcmp(name, ovs_vport_name(vport))) {
 		err = -ENODEV;
 		goto error_free_vport;
 	}
-- 
2.25.1


