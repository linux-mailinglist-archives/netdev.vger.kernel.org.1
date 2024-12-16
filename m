Return-Path: <netdev+bounces-152151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52499F2E67
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F49016246F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244EE204C06;
	Mon, 16 Dec 2024 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqlzAPaq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2520459B
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345736; cv=none; b=DDOIT+BzhSUyziRfuy4aR8yWa7X0n0w8QcQ/x3Wi4bV9QbiVh7z1RdhOOCknhkKRj751/vlHIX5UBZxjjTKZotVPPJ4Ku+Tf217+3P83RsvPt371wMsqOlKpZ8Aq+Dr7U/3vwzP6mWFjxNaEBy1+cCJWPrW2rB6M7kwed2dbYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345736; c=relaxed/simple;
	bh=6VdqSl8alXvH6pPsK78wHQAqoCIfIhg5UpI5s40sgg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=mZ6DvAJXPNN3zfkfbCigZwX/H03+b97KUwqT+uJEt2YnaJcrF2Zixwl/7Iz7wickULEprQsiuxdpf8Hadc5vgs7t6zEcgDt7dLapMt2McNzhXdK5dJSYoE+tPIa9FG6qAAFF3LksL4Gulb/rY1be0K4QR2Xs+5GbhiG/Jabsywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqlzAPaq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734345733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7tcKVC1kh1dFVI8oN1xiQyOlNqxnj21TIJYyRp/op8=;
	b=CqlzAPaqJDIA9NI3Phivr6bNzxIDE8MVXGBa6a8ZTgE1TXyzI4pFrFSj/j9F3jBqq8YJyP
	EUtoaS7Lo/+Rm3IYNO5fqriKHUY5wrWwV97RXNSCdfWdDZBaHRw/WdZRw+oCYh8cS297xz
	plN2on18A6K55ulRmWT5/FFaODl4dmw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-tUpMBIfLOWWK22VyY4z5Lw-1; Mon,
 16 Dec 2024 05:42:10 -0500
X-MC-Unique: tUpMBIfLOWWK22VyY4z5Lw-1
X-Mimecast-MFC-AGG-ID: tUpMBIfLOWWK22VyY4z5Lw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B6D8195609F;
	Mon, 16 Dec 2024 10:42:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBEE8300F9B5;
	Mon, 16 Dec 2024 10:42:04 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	jdamato@fastly.com
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v3 2/4] tools: ynl: add initial pyproject.toml for packaging
Date: Mon, 16 Dec 2024 11:41:42 +0100
Message-ID: <2a9b6d5a782acfa71ae5fb2f4d3cc538740013b6.1734345017.git.jstancek@redhat.com>
In-Reply-To: <cover.1734345017.git.jstancek@redhat.com>
References: <cover.1734345017.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


