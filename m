Return-Path: <netdev+bounces-42090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291467CD1A0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D945E281839
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F1ECC;
	Wed, 18 Oct 2023 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRC30WUM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF3A5B;
	Wed, 18 Oct 2023 01:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD4DC433C8;
	Wed, 18 Oct 2023 01:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697591281;
	bh=59vR46bvuqiPB0urnwSGzHyDUKCLr3i2AhjG3vuElWU=;
	h=From:To:Cc:Subject:Date:From;
	b=MRC30WUMYsWZFaB8jEOuzyQ4Scjb3qySmsyt2S+y4Y1jLdAFZK1NQuo+Y12nRrgL2
	 Z5n4sOW5K+0+kEwGwo7DQv1oayKFR3Bu+c2S/4JoDx6KjKK3hfoZuAOzZSRTqBN0SF
	 fYe4vp3rFWbSZ8AaJEnTD16Wlge5DM3zEx5+Rma+xyTn8R4/mnSYhMlCyp/5z3B+HT
	 6hwhZVYFC4rpupLXQxrvNVICLD+mFK7TF6nd4afmZs4NX/GMCtXdqvbBbW2fWMRA5s
	 +6mTGyeUKs+AOrUZU+fZdDFXgYiae0PWWlWbDa96fJ+W7U255gPfeGlcyrlR7icuMM
	 wzS92xp3FPTJw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	ecree.xilinx@gmail.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs: networking: document multi-RSS context
Date: Tue, 17 Oct 2023 18:07:58 -0700
Message-ID: <20231018010758.2382742-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be no docs for the concept of multiple RSS
contexts and how to configure it. I had to explain it three
times recently, the last one being the charm, document it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ecree.xilinx@gmail.com
CC: corbet@lwn.net
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/scaling.rst | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 92c9fb46d6a2..03ae19a689fc 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -105,6 +105,48 @@ a separate CPU. For interrupt handling, HT has shown no benefit in
 initial tests, so limit the number of queues to the number of CPU cores
 in the system.
 
+Dedicated RSS contexts
+~~~~~~~~~~~~~~~~~~~~~~
+
+Modern NICs support creating multiple co-existing RSS configurations
+which are selected based on explicit matching rules. This can be very
+useful when application wants to constrain the set of queues receiving
+traffic for e.g. a particular destination port or IP address.
+The example below shows how to direct all traffic to TCP port 22
+to queues 0 and 1.
+
+To create an additional RSS context use::
+
+  # ethtool -X eth0 hfunc toeplitz context new
+  New RSS context is 1
+
+Kernel reports back the ID of the allocated context (the default, always
+present RSS context has ID of 0). The new context can be queried and
+modified using the same APIs as the default context::
+
+  # ethtool -x eth0 context 1
+  RX flow hash indirection table for eth0 with 13 RX ring(s):
+    0:      0     1     2     3     4     5     6     7
+    8:      8     9    10    11    12     0     1     2
+  [...]
+  # ethtool -X eth0 equal 2 context 1
+  # ethtool -x eth0 context 1
+  RX flow hash indirection table for eth0 with 13 RX ring(s):
+    0:      0     1     0     1     0     1     0     1
+    8:      0     1     0     1     0     1     0     1
+  [...]
+
+To make use of the new context direct traffic to it using an n-tuple
+filter::
+
+  # ethtool -N eth0 flow-type tcp6 dst-port 22 context 1
+  Added rule with ID 1023
+
+When done, remove the context and the rule::
+
+  # ethtool -N eth0 delete 1023
+  # ethtool -X eth0 context 1 delete
+
 
 RPS: Receive Packet Steering
 ============================
-- 
2.41.0


