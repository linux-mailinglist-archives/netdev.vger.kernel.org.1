Return-Path: <netdev+bounces-150251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0C79E9955
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8F218889FE
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDAB1C5CBF;
	Mon,  9 Dec 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1317gPX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE151B425A
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755668; cv=none; b=cezq2BjA01G2alDi4DB+FgEBO1wFRcNpRbqActgPcsAf877MdYzmagBXeX9jVydDL4MRODdnkr2bMP8bMjdJmAtdG4uk8/BNY997zMH/A4skkSOqQk+ww0+C8ct+XSghVkxsgraxGb/XNGbwFberTg+rUX91na03o3oyn4ignHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755668; c=relaxed/simple;
	bh=Ruj9EpI/QVkcbt3Z9LyeeOHR4SURDqqGhN024gxfiNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=I92NbJSkV0caWGOOgr59PrSeSKVi+x9LeQA8XqMk+vfNmt+WeZ4Y/lV4R18qCECGqxqk7GZ1ucHKJrLGANtbrLORaohcisPjPC3YnzQ9svC5VGGZMi1WkvjiiRIUohu197QjHXmIlubbbKw8uVfxODQ1z2MkAn3a8ydwpE+IvqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1317gPX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733755665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p63aB6h+Gkmn4rzU5XjiQhRt8zOAxjKtKLZ3OhsF+oY=;
	b=i1317gPXChTJM/VGpAEsCEehNnaMQWvGiGp7M54wzmavIr2BRgT0c5ePwhh1Fy4qZg7n2o
	Rk3976fcGNJQbdX+QVBowDsuyNQHzF/COFu2ijrbUfhp0gwgiYQpRX+OU2rOtUjOkNVTVk
	dNqcgppj+H12wzkcf6wVWMipqpe/iqc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-PAmk5tRBP4CZb-RtTRFjsQ-1; Mon,
 09 Dec 2024 09:47:42 -0500
X-MC-Unique: PAmk5tRBP4CZb-RtTRFjsQ-1
X-Mimecast-MFC-AGG-ID: PAmk5tRBP4CZb-RtTRFjsQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D92F31954211;
	Mon,  9 Dec 2024 14:47:40 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.182])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F1241956089;
	Mon,  9 Dec 2024 14:47:37 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com
Cc: pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jstancek@redhat.com
Subject: [PATCH v2 2/5] tools: ynl: provide symlinks to user-facing scripts for compatibility
Date: Mon,  9 Dec 2024 15:47:14 +0100
Message-ID: <ce653225895177ab5b861d5348b1c610919f4779.1733755068.git.jstancek@redhat.com>
In-Reply-To: <cover.1733755068.git.jstancek@redhat.com>
References: <cover.1733755068.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

For backwards compatibility provide also symlinks from original location
of user facing scripts.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/net/ynl/cli.py         | 1 +
 tools/net/ynl/ethtool.py     | 1 +
 tools/net/ynl/ynl-gen-c.py   | 1 +
 tools/net/ynl/ynl-gen-rst.py | 1 +
 4 files changed, 4 insertions(+)
 create mode 120000 tools/net/ynl/cli.py
 create mode 120000 tools/net/ynl/ethtool.py
 create mode 120000 tools/net/ynl/ynl-gen-c.py
 create mode 120000 tools/net/ynl/ynl-gen-rst.py

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
new file mode 120000
index 000000000000..c26fb97ae611
--- /dev/null
+++ b/tools/net/ynl/cli.py
@@ -0,0 +1 @@
+pyynl/cli.py
\ No newline at end of file
diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
new file mode 120000
index 000000000000..deea4569a939
--- /dev/null
+++ b/tools/net/ynl/ethtool.py
@@ -0,0 +1 @@
+pyynl/ethtool.py
\ No newline at end of file
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
new file mode 120000
index 000000000000..716d34fa1257
--- /dev/null
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -0,0 +1 @@
+pyynl/ynl_gen_c.py
\ No newline at end of file
diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
new file mode 120000
index 000000000000..b02558f540ec
--- /dev/null
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -0,0 +1 @@
+pyynl/ynl_gen_rst.py
\ No newline at end of file
-- 
2.43.0


