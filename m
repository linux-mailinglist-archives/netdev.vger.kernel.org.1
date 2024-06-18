Return-Path: <netdev+bounces-104650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECCB90DC67
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705F4286AF7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B509D16191B;
	Tue, 18 Jun 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjVe0YRf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514415747F;
	Tue, 18 Jun 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738905; cv=none; b=SmBIgHnA5qYxuLabGZX5t05G3PiwRWra5iIa2VmyEExE6Yh7kK+B0sA9J87DXZDz9Bh/vYF1Zm0dJoCGqUc76Qh2vVuTrH+31gFl1HGGuvySnNeyhdUJnu81Hc/px3tLcQtl/W4eZRi4xCw1bymNQXRh52/6gsRqP1pqQzdqu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738905; c=relaxed/simple;
	bh=O8y8OYQOXKLabxuSeZKjIefJkNb84l+ZbPGZWtoJcG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LXFu27gjziNey5+2xs4pXtzk0G24qEVwcit/ghCIqCDF4AWhGuEw4a0s+Y/jqzX5igibLhUAmWORY5oM0dEklt38WuGqS9L0yV1UkCRDxerobGXr97xuydzi+soRFSTPMSzurED6PW2xk35y5HvaW84mYXB2Z3faodk5yrbaWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjVe0YRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C8DC3277B;
	Tue, 18 Jun 2024 19:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718738905;
	bh=O8y8OYQOXKLabxuSeZKjIefJkNb84l+ZbPGZWtoJcG8=;
	h=From:To:Cc:Subject:Date:From;
	b=kjVe0YRffRanXyIDonCjBL8X+0N85uDm/O78DX7tSDHIx5ALzS0fmB1bNIaYF8dir
	 Qh6qy6MdQtXSiWxFN4ynAFEymR+pOggaf7RN9mvQdmXZVQtWuMbvNbppCUfY2rXCkB
	 Wo5xfp0jxNF8e+1vQYvOwGdDqLAImBjHwBev8SB8gWg20Nc9Ln8Cllv2lJxmHalCPQ
	 /USKu5QcxIgchqb8WNhuNJb516iJ3DNJLIl0XyqwjE7rPNvlbw4bEil2QfGRKVL/8L
	 pPSzOy1rJVEQLze02vAWaGNnqbHs3cVovrMmaX89p/nROaw5SrNxb12vTPfa7mMmAx
	 R8rF1VcpRCdPw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev-driver-reviewers@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs: net: document guidance of implementing the SR-IOV NDOs
Date: Tue, 18 Jun 2024 12:28:18 -0700
Message-ID: <20240618192818.554646-1-kuba@kernel.org>
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
CC: corbet@lwn.net
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
index 000000000000..652ffb501e6b
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
+Since the legacy APIs does not integrate well with the rest of the stack
+the API is considered frozen, no new functionality or extensions
+will be accepted. New drivers should not implement the uncommon callbacks,
+namely the following callbacks are off limits:
+
+ - ``ndo_get_vf_port``
+ - ``ndo_set_vf_port``
+ - ``ndo_set_vf_rss_query_en``
-- 
2.45.2


