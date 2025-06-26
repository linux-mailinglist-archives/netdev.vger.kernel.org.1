Return-Path: <netdev+bounces-201459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C9AE97EF
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF40A3B142B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5F928935A;
	Thu, 26 Jun 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bni07tGi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8612882AF;
	Thu, 26 Jun 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925630; cv=none; b=iWpKEUKAjnzPGjRCaGjkazYMULWneUjEzdfQRlg+csaX/rZjg3IgXdMWc3DTbw42WVdaoDq0qJeYI8M0fxkKBkwikiVQoBBpKMr0YOJ5HM/Ik77jhP4d2u3vxPJQltgXDtueWT8YjAr72IkF8Gp9jPxYbC4lvOjQnBvGk63s18g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925630; c=relaxed/simple;
	bh=Hv3gLw50JLGG5g7ccl776oKGKqF7lxHBB7tVJrn/eaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXr8LeH74qh37KagBwsIPFf/JDVbYCWXWf6aIvt3cu4QyekOCrKhFhqQoQ3Ef2bOvNwX/oAwSTExCQjve+y93MQtjX+ys/Pfa9iYi3yNpneBdrOvKPYD5YPj41HoGMrykpfdrwFMO1jW2yZ4eYUv65wfA2C0+E62SVYWxd063eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bni07tGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4443C4CEEE;
	Thu, 26 Jun 2025 08:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925629;
	bh=Hv3gLw50JLGG5g7ccl776oKGKqF7lxHBB7tVJrn/eaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bni07tGieiYEANMpXUwwdQnkzn9JLi5x0RhWIGJxzWavigd369YO/S3o3X7elXh1+
	 RK+fEIXqnvIK5tebNEdB7NNWsF8ywjWHe3iRj3YNdjp4mq9Z9dD+HXC6Mtk3IXUlXk
	 N17fkSmmFpd4quoFCtXYWxttyMXsQIRIpy2agbz9wzqI4aYvL0gwNfR886+gs8FeN4
	 dMTFjnuBpkbKSa8k2LXhMjQ/HXbuY+pttk9XGLKhpWMox3bsDO1TcK+CFPnvQW4uOw
	 As89ervv3Kn6Fiiox4RdJ+7OYo9Q9wMNy/N0jYy+iAvZ+RttgDyA+M6AQud2n4SZKL
	 kt/fPogfr0iRA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004sva-1BWA;
	Thu, 26 Jun 2025 10:13:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v8 03/13] docs: netlink: index.rst: add a netlink index file
Date: Thu, 26 Jun 2025 10:12:59 +0200
Message-ID: <ac5ac2de57661b6f993f44a9b97f2e3921804f3b.1750925410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750925410.git.mchehab+huawei@kernel.org>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Instead of generating the index file, use glob to automatically
include all data from yaml.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/index.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/netlink/specs/index.rst

diff --git a/Documentation/netlink/specs/index.rst b/Documentation/netlink/specs/index.rst
new file mode 100644
index 000000000000..7f7cf4a096f2
--- /dev/null
+++ b/Documentation/netlink/specs/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _specs:
+
+=============================
+Netlink Family Specifications
+=============================
+
+.. toctree::
+   :maxdepth: 1
+   :glob:
+
+   *
-- 
2.49.0


