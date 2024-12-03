Return-Path: <netdev+bounces-148417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9279E176F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420742837B9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69711E04B4;
	Tue,  3 Dec 2024 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EivmwcoZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322011DF72C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218055; cv=none; b=D3NDPOuAwAmPzbZ+k7BRC5qAkopp2H1J0+1oTAliLxkhdtf12+pRyuKib7llFfh8uq8IO+3XZYDX0Xqkz1owI+7/yT6woAHmVP7/3bEcL3/iMHP9cI/CXvDMHV1m4CbLv2w0uyb1FIk4D7zvFgPJFSaCjivYHOYviFrl9jphcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218055; c=relaxed/simple;
	bh=q1aC8FipRxk5/ELsDousM9EAhvQgS6rDXwqI8l+rB/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=KPnT2X14QpR3URtfTby5Vo7Zx8JAfhXLnSwfFZMNdz0a7eM7rpoto0Uud26WTEbwacAAvlizGzvM9S2s+R4K2VpeirpD4J4Y2ztm2+/8wHZCUJhewMfMetvZpCKupx3OU0IZStidZWVT73XhLLUBFMKu5HRSzYy9KjoJ0aQm2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EivmwcoZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAWrhRTAmjG9tfueAyBFJRTAuQHFdszPKgmlhu4/3z8=;
	b=EivmwcoZ4sqqnfUMw3WEnSK2wX4LMoR+HZHbNrVwyAsO33zD5e5VOcITvkdIF/HegKnFFB
	FAub6wkwDy/6nMBkryJdNwBOm0boXND0tU5jnHL/0043RmZtW2B3tCprU3qEWQoyQmcxWS
	z8AS1Kw2k38nNsxT2SXnB718jyBwih8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-oDIRuECFPhGJt_5VzMyp-A-1; Tue,
 03 Dec 2024 04:27:29 -0500
X-MC-Unique: oDIRuECFPhGJt_5VzMyp-A-1
X-Mimecast-MFC-AGG-ID: oDIRuECFPhGJt_5VzMyp-A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F388F19560B3;
	Tue,  3 Dec 2024 09:27:27 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00C901956052;
	Tue,  3 Dec 2024 09:27:24 +0000 (UTC)
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
Subject: [PATCH 3/5] tools: ynl: add initial pyproject.toml for packaging
Date: Tue,  3 Dec 2024 10:27:02 +0100
Message-ID: <3b652cc0da01ed6e9e721a32355566b3b14ebb5a.1733216767.git.jstancek@redhat.com>
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

And define entrypoints for cli tools.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/pyproject.toml | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 tools/net/ynl/pyproject.toml

diff --git a/tools/net/ynl/pyproject.toml b/tools/net/ynl/pyproject.toml
new file mode 100644
index 000000000000..677ea8f4c185
--- /dev/null
+++ b/tools/net/ynl/pyproject.toml
@@ -0,0 +1,26 @@
+[build-system]
+requires = ["setuptools>=61.0"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "pyynl"
+authors = [
+    {name = "Donald Hunter", email = "donald.hunter@gmail.com"},
+    {name = "Jakub Kicinski", email = "kuba@kernel.org"},
+]
+description = "yaml netlink (ynl)"
+version = "0.0.1"
+requires-python = ">=3.9"
+dependencies = [
+    "pyyaml==6.*",
+    "jsonschema==4.*"
+]
+
+[tool.setuptools.packages.find]
+include = ["pyynl", "pyynl.lib"]
+
+[project.scripts]
+ynl = "pyynl.cli:main"
+ynl-ethtool = "pyynl.ethtool:main"
+ynl-gen-c = "pyynl.ynl_gen_c:main"
+ynl-gen-rst = "pyynl.ynl_gen_rst:main"
-- 
2.43.0


