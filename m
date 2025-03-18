Return-Path: <netdev+bounces-175859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E225A67C80
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B3988235E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFC7211A3D;
	Tue, 18 Mar 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jQtxxWMN"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725FB20F073
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324186; cv=none; b=YV4k1jNm1zyB4fI55H1W7q4Ju03D920RQywHXYnU6KJTl9ejOu+VyXwJpBSh6LdJGHJ+jNQx174bNO9F+WDZHYXxAD6hErtqRGQotDQKZ7GrU4OYWhXq34ul1QTS8oOSNPRuGEfeuzbZpUwi3seHbUrmGlgJVPgvf1B7R/oyR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324186; c=relaxed/simple;
	bh=3pC3gjvSu3lQEdG9zh7ylkORQiG7ySyfjcVk4Nq9ttw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGb9EAg2Z2gfyRKuhXqrLSdoR475mhz5Gnu5BZy+T7aPlr/8mIUVRkgdj5Q1KdOg0Au5YlFKqe2HQbanb/OlxUaptnD+e1Ff06zlV7NqSxZt0I+mzh3SdR44bWW/WfCgH5Sxre9QxPQ8YCSQ62IAHtipc4Dk/2tdkcTGcDnURFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jQtxxWMN; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742324178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=djNKGzX9ZcA55R+w5dijyS9ARkrFmZ7NXtXx0AoZVw8=;
	b=jQtxxWMNDhi/Xrme4343z8GIhKshDUS/qBiefA8vduB3JEb5BOYt9aDHT/a+ugnRRzSZcB
	vdA6F8Ou1n52SKyffUQ0AHMn1UhzqDkVOKCpBE08KPyPuOFcPt9tH56Y/IMWVsBzFUUrQi
	AekjmmJcaoIEq6lq9kauiWFCbRN7fjk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] netfilter: xtables: Use strscpy() instead of strscpy_pad()
Date: Tue, 18 Mar 2025 19:55:19 +0100
Message-ID: <20250318185519.107323-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

kzalloc() already zero-initializes the destination buffer, making
strscpy() sufficient for safely copying the name. The additional NUL-
padding performed by strscpy_pad() is unnecessary.

The size parameter is optional, and strscpy() automatically determines
the size of the destination buffer using sizeof() if the argument is
omitted. This makes the explicit sizeof() call unnecessary; remove it.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/netfilter/xt_repldata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_repldata.h b/net/netfilter/xt_repldata.h
index 5d1fb7018dba..600060ca940a 100644
--- a/net/netfilter/xt_repldata.h
+++ b/net/netfilter/xt_repldata.h
@@ -29,7 +29,7 @@
 	if (tbl == NULL) \
 		return NULL; \
 	term = (struct type##_error *)&(((char *)tbl)[term_offset]); \
-	strscpy_pad(tbl->repl.name, info->name, sizeof(tbl->repl.name)); \
+	strscpy(tbl->repl.name, info->name); \
 	*term = (struct type##_error)typ2##_ERROR_INIT;  \
 	tbl->repl.valid_hooks = hook_mask; \
 	tbl->repl.num_entries = nhooks + 1; \

