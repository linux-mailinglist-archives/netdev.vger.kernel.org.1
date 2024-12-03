Return-Path: <netdev+bounces-148416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B0D9E176D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462631671F0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905991DFE2C;
	Tue,  3 Dec 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gy+bFev7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79C1DFE0D
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218051; cv=none; b=t1iC5nNBxqL2JsNwTaH0H1/F8lcR6nS5arHVbvlmNXsMcIWhm8dsijR+HxdJ2jjIf0IWSZ6qhd7n8wOfV0V4PpBMdtA0EHjcBqzE1upILZqp6pBhdNlq7xy1SDD6IpOlPBhAIVEZRCTiZeqS+WvC9gXX8iVpN7fogRY2T3sUgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218051; c=relaxed/simple;
	bh=WBYA0qsg8BBcxyRwDzyxnfN8T65ufKtAFdlewzdEWb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=L7WUKEox04SaZmAWw3sm4/IgizNBzBAFSWDykduBbN2g0sXc3VtbKk1LDaSdUCMQrIIfh9OjNEME267oB58Cz9qaLpPSm9/hktALn3hB2ZkUoWtWZ2f9BbUHq6qqBZk2mYz0IxRG/V+czt+NN9q5JFWjuftNx4U7vm2iAm4zSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gy+bFev7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1p3ps2XMMc8k3RPA96MAQqh9azEdDuQn6tnN7ml4mUc=;
	b=gy+bFev7MSMFXSLnGqwHBgCvG7IfsfvhYSjEh44IQG7u8VQVkh0nBeIbfmX9Lb9GQHBmTz
	2C9RqpURTYfAK9vx/OpCWuMSYp7W37bCHkOX0VyFE6XPHrBBn/JELdS/WMtY8vST/0cFb2
	iZ/pQeOfCJ0T/EJvFM4cyoI6hsXNQQg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-vmZ2vor3OnOc9XkV77THrg-1; Tue,
 03 Dec 2024 04:27:25 -0500
X-MC-Unique: vmZ2vor3OnOc9XkV77THrg-1
X-Mimecast-MFC-AGG-ID: vmZ2vor3OnOc9XkV77THrg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FAF01955EA7;
	Tue,  3 Dec 2024 09:27:24 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 712B71956052;
	Tue,  3 Dec 2024 09:27:21 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH 2/5] tools: ynl: rename ynl-gen-[c|rst] to ynl_gen_[c|rst]
Date: Tue,  3 Dec 2024 10:27:01 +0100
Message-ID: <399b6bfbe90b4b8ce10e38ce8c7cf1f52ecac627.1733216767.git.jstancek@redhat.com>
In-Reply-To: <cover.1733216767.git.jstancek@redhat.com>
References: <cover.1733216767.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Don't use dashes as these prevent easy imports for entrypoints.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/generated/Makefile                       | 2 +-
 tools/net/ynl/pyynl/{ynl-gen-c.py => ynl_gen_c.py}     | 0
 tools/net/ynl/pyynl/{ynl-gen-rst.py => ynl_gen_rst.py} | 0
 tools/net/ynl/ynl-regen.sh                             | 2 +-
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/net/ynl/pyynl/{ynl-gen-c.py => ynl_gen_c.py} (100%)
 rename tools/net/ynl/pyynl/{ynl-gen-rst.py => ynl_gen_rst.py} (100%)

diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 36519ea2792a..00af721b1571 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -12,7 +12,7 @@ include ../Makefile.deps
 YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 	--exclude-op stats-get
 
-TOOL:=../pyynl/ynl-gen-c.py
+TOOL:=../pyynl/ynl_gen_c.py
 
 GENS_PATHS=$(shell grep -nrI --files-without-match \
 		'protocol: netlink' \
diff --git a/tools/net/ynl/pyynl/ynl-gen-c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
similarity index 100%
rename from tools/net/ynl/pyynl/ynl-gen-c.py
rename to tools/net/ynl/pyynl/ynl_gen_c.py
diff --git a/tools/net/ynl/pyynl/ynl-gen-rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
similarity index 100%
rename from tools/net/ynl/pyynl/ynl-gen-rst.py
rename to tools/net/ynl/pyynl/ynl_gen_rst.py
diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index 3212dab1cc6e..81b4ecd89100 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
-TOOL=$(dirname $(realpath $0))/pyynl/ynl-gen-c.py
+TOOL=$(dirname $(realpath $0))/pyynl/ynl_gen_c.py
 
 force=
 search=
-- 
2.43.0


