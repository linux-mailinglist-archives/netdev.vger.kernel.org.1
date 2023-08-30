Return-Path: <netdev+bounces-31459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086FE78E210
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 00:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B373D2810B5
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B28BE5;
	Wed, 30 Aug 2023 22:07:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA758468
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 22:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260A1C433C9;
	Wed, 30 Aug 2023 22:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693433229;
	bh=iOlG6QCwPEJAv18mUAR+gdYgQ3y/Ze8QpP2zXy4kL3o=;
	h=From:To:Cc:Subject:Date:From;
	b=OSGioPeq7kf+PXKsN9z4re0fo54QSQB74WhbvhWvlQ9x1HR+fMd0ddWlA8zQDRA6X
	 kKLqf95hKIZKgoZfEBNc+EuV2GsjbsOOicm323e1xCIg39xa/NnIdCoMlpfxgt0Izw
	 FjKy7RpolV5TiAkHKpYnruB1xCWCFyaXfBaQY6mX9RQyxTBbxpA9ZmpDH6M+LnISpL
	 NILcX4ZyRnz6+qAWAfmNeus3GNMTU7dsWZ3BzHrNkyFP0RFBqLjA1Xp41iyS9eKOpL
	 edDfpkjxispR+CgX2ute1NZKTfZObfkgLMW+vgOGU1O92+kfqy8XEpIihd3ZzdxYre
	 Vb+B6gkcZ6y9A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	rdunlap@infradead.org,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH net v2] docs: netdev: document patchwork patch states
Date: Wed, 30 Aug 2023 15:06:58 -0700
Message-ID: <20230830220659.170911-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patchwork states are largely self-explanatory but small
ambiguities may still come up. Document how we interpret
the states in networking.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add a sentence about New vs Under Review
 - s/maintainer/export/ for Needs ACK
 - fix indent
v1: https://lore.kernel.org/all/20230828184447.2142383-1-kuba@kernel.org/

CC: corbet@lwn.net
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org

CC: rdunlap@infradead.org
CC: laurent.pinchart@ideasonboard.com
---
 Documentation/process/maintainer-netdev.rst | 29 ++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index c1c732e9748b..b2c082e64c95 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -120,7 +120,34 @@ Status of a patch can be checked by looking at the main patchwork
   https://patchwork.kernel.org/project/netdevbpf/list/
 
 The "State" field will tell you exactly where things are at with your
-patch. Patches are indexed by the ``Message-ID`` header of the emails
+patch:
+
+================== =============================================================
+Patch state        Description
+================== =============================================================
+New, Under review  pending review, patch is in the maintainer’s queue for
+                   review; the two states are used interchangeably (depending on
+                   the exact co-maintainer handling patchwork at the time)
+Accepted           patch was applied to the appropriate networking tree, this is
+                   usually set automatically by the pw-bot
+Needs ACK          waiting for an ack from an area expert or testing
+Changes requested  patch has not passed the review, new revision is expected
+                   with appropriate code and commit message changes
+Rejected           patch has been rejected and new revision is not expected
+Not applicable     patch is expected to be applied outside of the networking
+                   subsystem
+Awaiting upstream  patch should be reviewed and handled by appropriate
+                   sub-maintainer, who will send it on to the networking trees
+Deferred           patch needs to be reposted later, usually due to dependency
+                   or because it was posted for a closed tree
+Superseded         new version of the patch was posted, usually set by the
+                   pw-bot
+RFC                not to be applied, usually not in maintainer’s review queue,
+                   pw-bot can automatically set patches to this state based
+                   on subject tags
+================== =============================================================
+
+Patches are indexed by the ``Message-ID`` header of the emails
 which carried them so if you have trouble finding your patch append
 the value of ``Message-ID`` to the URL above.
 
-- 
2.41.0


