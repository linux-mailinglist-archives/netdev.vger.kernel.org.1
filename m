Return-Path: <netdev+bounces-156282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE83DA05DB3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5651883A53
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBEF1FCFEE;
	Wed,  8 Jan 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aot6jzst"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF116199FA4
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344623; cv=none; b=GDFP8Zo5FZwTuZzYg1ByAezSOKyr7govLN/Rk2n4OJUUkR6LmEqkdguqO4EmLuUHYgS2X8JLqTLad38LnB+SIT7XaJyY6DWMKrd0qNi0o8/Mm2ILh783UCpSPi2qd7I5WKY45mKmPnHgIbd4uLTNBrUxB+OWVHY2DCm2sCI/OXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344623; c=relaxed/simple;
	bh=KqiTIpah+aH+aEUem5mKaYfuJ10MVfQ1odlp5KGoGE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=DSpA6DLfsJxHnoHsp4aOtZSjEjT4c7PA8n9GpBf6BoxRMofnzK2FTdWAu8AhbKf2g9XOD5NVqFgmQAd2wP2J6r/WOmY2HeWWjobLgrXNIaJntkU0gQ/bid7ManS2/tiabOIm3UgOiZpenQ6vzOieC4KbSceBWWdD8BqhAAQG46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aot6jzst; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736344620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGjkt00H/NMicNYLZaNWmBQDtOl1zPOzBTmzN4SUej0=;
	b=aot6jzstG4UFwjgmMxoX2Gzg69A9X/hC+jhPXaV9155BIAtpbdVcFjQ9WZa1L2EmTdZH3v
	nJx3mHMEvrXqXqrr12QO0lTZ41y2VpS/gYzReNaNOIcbpbjyQlogXLuVch8J/cEjwmdlxi
	X5a4SvtV4UWQ7jtgJhsMGxgRpwysGSU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-pAiTxTPjOAWOlZ7rqJnQpw-1; Wed,
 08 Jan 2025 08:56:59 -0500
X-MC-Unique: pAiTxTPjOAWOlZ7rqJnQpw-1
X-Mimecast-MFC-AGG-ID: pAiTxTPjOAWOlZ7rqJnQpw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 304A51956050;
	Wed,  8 Jan 2025 13:56:58 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F106300018D;
	Wed,  8 Jan 2025 13:56:55 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	jdamato@fastly.com
Cc: pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v4 2/4] tools: ynl: add initial pyproject.toml for packaging
Date: Wed,  8 Jan 2025 14:56:15 +0100
Message-ID: <b184b43340f08aef97387bfd7f2b2cd9b015c343.1736343575.git.jstancek@redhat.com>
In-Reply-To: <cover.1736343575.git.jstancek@redhat.com>
References: <cover.1736343575.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add pyproject.toml and define authors, dependencies and
user-facing scripts. This will be used later by pip to
install python code.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/pyproject.toml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 tools/net/ynl/pyproject.toml

diff --git a/tools/net/ynl/pyproject.toml b/tools/net/ynl/pyproject.toml
new file mode 100644
index 000000000000..a81d8779b0e0
--- /dev/null
+++ b/tools/net/ynl/pyproject.toml
@@ -0,0 +1,24 @@
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
-- 
2.43.0


