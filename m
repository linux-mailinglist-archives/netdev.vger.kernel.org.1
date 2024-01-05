Return-Path: <netdev+bounces-61875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82BE82525B
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0889A1C22B78
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37F024B5F;
	Fri,  5 Jan 2024 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="ceK6AV8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02998250EB
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helmholz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helmholz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=k+YfGyPyuiIftGQeVq2B9CXXzvwQWlmyQ21WNzLOAYM=; b=ceK6AV8/dzRVm8Uxp9XYyCWWJr
	/2ov/5Cjb3ZWXMBoaTLGfvsCiywI6sJTUPiIl9dJbrJcbRhMXw/VZdPCLfG8rTHv16EcZ4/oB4gcT
	VCvs2Jtv3ROdh2sne+KgITu11W0Bl45N2UFcMPwbER6f2lD4DJXVIAw+CPoPIvOUw9PO9IPHLhUCa
	YXqZYI/8xC2n9jrWp8j5KiSXn8CN1UzuMed58V2yfT+Nt/RTy5yO7/ieQpjXWzt9tapqL9m2LGzvw
	UvSiwkH2aA8nlRD3YQZQvGbTOTZg+pEHNWApBE/hI/2+okpTDoq452d/CMRTl79sSLh9Ud18dBN40
	uLgVw2gA==;
Received: from [192.168.1.4] (port=44803 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1rLhiZ-0000eV-0v;
	Fri, 05 Jan 2024 11:46:23 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 5 Jan 2024 11:46:22 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ante.knezic@helmholz.de>
Subject: [RFC PATCH net-next 2/6] net: dsa: add groundwork for cross chip mirroring
Date: Fri, 5 Jan 2024 11:46:15 +0100
Message-ID: <7133d2507c0619e7727c1c44250241fdc9625d2c.1704449760.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1704449760.git.ante.knezic@helmholz.de>
References: <cover.1704449760.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

cross chip mirroring require routing mirrored data
from source to destination switch. Add the necessary
groundwork.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 include/net/dsa.h | 18 ++++++++++++++++++
 net/dsa/dsa.c     | 14 ++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index c1fbe89f8f81..aa0e97150bc3 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -162,6 +162,9 @@ struct dsa_switch_tree {
 
 	/* Track the largest switch index within a tree */
 	unsigned int last_switch;
+
+	/* List of port mirror routes */
+	struct list_head mirrors;
 };
 
 /* LAG IDs are one-based, the dst->lags array is zero-based */
@@ -368,6 +371,21 @@ struct dsa_vlan {
 	struct list_head list;
 };
 
+struct dsa_mirror {
+	struct list_head list;
+	const struct dsa_port *from_dp;
+	const struct dsa_port *to_dp;
+	bool ingress;
+	struct list_head route;
+};
+
+struct dsa_route {
+	struct list_head list;
+	int sw_index;
+	int from_local_p;
+	int to_local_p;
+};
+
 struct dsa_switch {
 	struct device *dev;
 
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index ac7be864e80d..304c7100cf55 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -228,6 +228,8 @@ static struct dsa_switch_tree *dsa_tree_alloc(int index)
 
 	kref_init(&dst->refcount);
 
+	INIT_LIST_HEAD(&dst->mirrors);
+
 	return dst;
 }
 
@@ -923,6 +925,8 @@ static int dsa_tree_setup(struct dsa_switch_tree *dst)
 static void dsa_tree_teardown(struct dsa_switch_tree *dst)
 {
 	struct dsa_link *dl, *next;
+	struct dsa_mirror *dm, *m;
+	struct dsa_route *dr, *r;
 
 	if (!dst->setup)
 		return;
@@ -942,6 +946,16 @@ static void dsa_tree_teardown(struct dsa_switch_tree *dst)
 		kfree(dl);
 	}
 
+	list_for_each_entry_safe(dm, m, &dst->mirrors, list) {
+		list_for_each_entry_safe(dr, r, &dm->route, list) {
+			list_del(&dr->list);
+			kfree(dr);
+		}
+
+		list_del(&dm->list);
+		kfree(dm);
+	}
+
 	pr_info("DSA: tree %d torn down\n", dst->index);
 
 	dst->setup = false;
-- 
2.11.0


