Return-Path: <netdev+bounces-105088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C890FA3F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34219282443
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CEA803;
	Thu, 20 Jun 2024 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+4d+srK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB294EBE;
	Thu, 20 Jun 2024 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843263; cv=none; b=K0A/srimSnIBhemcyg6om0ywerRYit2v88Qpx3gx1ZMBLfG2/Kolu+GmCxBqDh/Fdl8OXgNQU2lgNMIF1+tuQzt6U3IMe5/OMOUzBAwDZJqCS3LYLCwlvNcjzLucGQjIryscmwt+7evIFWCXqz83sIi8U0Bq/j92PUTkMD3i+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843263; c=relaxed/simple;
	bh=baEzJuDcjgC+4UCMQ1X+Q3cE1chMcFBCEvEZni2XdoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSekyL4JIw2vEkKThcRoeKPjGLYqnLfSU0MwQ42TU5K7qs5614RqNAhwNZKJzvoF36IlTQ51Xb0lDtTkhr5hfkbTLhe1m6ZojkBz0NojdDd3yGsGIR1TH+w1PmsWZm8u240qqAqw/JofaTWMz0ebjf3IvufIYcVkLSMyqS3IJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+4d+srK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00354C2BBFC;
	Thu, 20 Jun 2024 00:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718843263;
	bh=baEzJuDcjgC+4UCMQ1X+Q3cE1chMcFBCEvEZni2XdoM=;
	h=From:To:Cc:Subject:Date:From;
	b=r+4d+srKdyI+J5I5QCD4wwP56bk6b6Sdo1qWDHpxZ2s44xoxXDd5DKuEdHJkoMso3
	 cnRVKFH6hs5Gxb1Izbqfqrie6MCg4d9jFuih7BOFEwd13uNNFv95ClzgEGjGRhvIyI
	 QuFVqtp7K0cJ2ey1EdBAh3voMrrpgS4xQDaNGn5F4T/G+Oi+iZjQMjW1LiSSW9J+D9
	 7yIWiCN4zBpPerFDkRwWQV/R/CLm0IDPNPHNZIiBJkiXbgzZauU+9THfp8ZpJmOwlK
	 qEfLiKLpr6h4KlldZ2D2Lfvv85oZkBLYx2wp++PZJaY9AWErIlhsCE7Cde6qcUjKLY
	 46nyeh6p/XWEw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2] docs: net: document guidance of implementing the SR-IOV NDOs
Date: Wed, 19 Jun 2024 17:27:41 -0700
Message-ID: <20240620002741.1029936-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New drivers were prevented from adding ndo_set_vf_* callbacks
over the last few years. This was expected to result in broader
switchdev adoption, but seems to have had little effect.

Based on recent netdev meeting there is broad support for allowing
adding those ops.

There is a problem with the current API supporting a limited number
of VFs (100+, which is less than some modern HW supports).
We can try to solve it by adding similar functionality on devlink
ports, but that'd be another API variation to maintain.
So a netlink attribute reshuffling is a more likely outcome.

Document the guidance, make it clear that the API is frozen.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - edits from Randy
v1: https://lore.kernel.org/all/20240618192818.554646-1-kuba@kernel.org/

CC: corbet@lwn.net
CC: rdunlap@infradead.org
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/index.rst |  1 +
 Documentation/networking/sriov.rst | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 Documentation/networking/sriov.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index a6443851a142..b4b2a002f183 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -105,6 +105,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
    seg6-sysctl
    skbuff
    smc-sysctl
+   sriov
    statistics
    strparser
    switchdev
diff --git a/Documentation/networking/sriov.rst b/Documentation/networking/sriov.rst
new file mode 100644
index 000000000000..5deb4ff3154f
--- /dev/null
+++ b/Documentation/networking/sriov.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+NIC SR-IOV APIs
+===============
+
+Modern NICs are strongly encouraged to focus on implementing the ``switchdev``
+model (see :ref:`switchdev`) to configure forwarding and security of SR-IOV
+functionality.
+
+Legacy API
+==========
+
+The old SR-IOV API is implemented in ``rtnetlink`` Netlink family as part of
+the ``RTM_GETLINK`` and ``RTM_SETLINK`` commands. On the driver side
+it consists of a number of ``ndo_set_vf_*`` and ``ndo_get_vf_*`` callbacks.
+
+Since the legacy APIs do not integrate well with the rest of the stack
+the API is considered frozen; no new functionality or extensions
+will be accepted. New drivers should not implement the uncommon callbacks;
+namely the following callbacks are off limits:
+
+ - ``ndo_get_vf_port``
+ - ``ndo_set_vf_port``
+ - ``ndo_set_vf_rss_query_en``
-- 
2.45.2


