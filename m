Return-Path: <netdev+bounces-79833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C9187BB07
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 11:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9407C1F260D4
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 10:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D56D1B1;
	Thu, 14 Mar 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C++aWG7d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09D6DCE3
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411074; cv=none; b=BkCbvCB6skvmAi8DrRC4SL0hKgCfrSyUJBgLWjfljxXPBFFMziefht7eNjg7sf2AU6VvJQy7Frcee7p5V5IvqInSMbkJY1BraS5p8SnlhZCKeNxL4KcG2+3EcfiPzR0Aoco/hF5zv4XHjw95nIBwy9hcu75oP36c5MQNK/1E38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411074; c=relaxed/simple;
	bh=dZeKk0Ksfmv6FNgTlKtexgkHzQgSyFz2qYJyREVzJLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNvylCE7PKtkeDND+09EEwiMJ/hQmRixq2P7ULV/dRHHy019gVmZbcgnr1a5Rv/An2450lQlf0ZxUqgYZ+ak7ANuuk4p8iXsw4Gko2e0kC5xprmljbzUTsLXRuEyK+3EBHd6BRh3NFfAYvUwPUI6uYup5hO4KBmuDzg/3tzkToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C++aWG7d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710411071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wtjj6k8BZQxmnPVo1SvkdiyeGn3Buyu85zK0ztz3nI8=;
	b=C++aWG7d5jL0oVyKPXqufGYFe4HvkUicA7MD4blUBk6ET+BtgDJhp4rzITj16yl9Xv/Mx/
	86LbfYtPEKKmzxWaF60PCppnmeBoPLAWIOeieGNqdyNWtTv5Y7MaTYGJPbYbw2pYwEQy8+
	Uzlo8GWYKa9mIGbDalDR9FEH8DhiKTc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-W_P5pmgGPfG-FUFwkEOU9w-1; Thu,
 14 Mar 2024 06:11:07 -0400
X-MC-Unique: W_P5pmgGPfG-FUFwkEOU9w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74A62282D3C7;
	Thu, 14 Mar 2024 10:11:07 +0000 (UTC)
Received: from thinkpad.redhat.com (dhcp-64-123.muc.redhat.com [10.32.64.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8072D492BDA;
	Thu, 14 Mar 2024 10:11:06 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leitao@debian.org
Subject: [PATCH net] hsr: Handle failures in module init
Date: Thu, 14 Mar 2024 11:10:52 +0100
Message-ID: <0b718dd6cc28d09fd2478d8debdfc0a6755a8895.1710410183.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

A failure during registration of the netdev notifier was not handled at
all. A failure during netlink initialization did not unregister the netdev
notifier.

Handle failures of netdev notifier registration and netlink initialization.
Both functions should only return negative values on failure and thereby
lead to the hsr module not being loaded.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 net/hsr/hsr_main.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index cb83c8feb746..1c4a5b678688 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -148,14 +148,24 @@ static struct notifier_block hsr_nb = {
 
 static int __init hsr_init(void)
 {
-	int res;
+	int err;
 
 	BUILD_BUG_ON(sizeof(struct hsr_tag) != HSR_HLEN);
 
-	register_netdevice_notifier(&hsr_nb);
-	res = hsr_netlink_init();
+	err = register_netdevice_notifier(&hsr_nb);
+	if (err)
+		goto out;
+
+	err = hsr_netlink_init();
+	if (err)
+		goto cleanup;
 
-	return res;
+	return 0;
+
+cleanup:
+	unregister_netdevice_notifier(&hsr_nb);
+out:
+	return err;
 }
 
 static void __exit hsr_exit(void)
-- 
2.44.0


