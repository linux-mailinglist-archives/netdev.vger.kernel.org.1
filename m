Return-Path: <netdev+bounces-37816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4607B745E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 00:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id EEB891C203AB
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 22:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8873E498;
	Tue,  3 Oct 2023 22:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0743E496
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 22:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324A7C433C8;
	Tue,  3 Oct 2023 22:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696373858;
	bh=0Zqd4MB3GLO7Pi3VXPABkWFdqbFcpxf0VqNzVfzZlRo=;
	h=From:To:Cc:Subject:Date:From;
	b=Ai5t+0TbWRNmOzjj0WQMCMQTc45vrT0pcTCMxLFigeStxY04Tf8SpwElWDayEJZuw
	 MKYKY62t8J8CAcFap4BRYR5HQKyEXGCl43HK+JwmHYM/CoCXpssukJ+UiJBUMZpnC3
	 fCy5gsQIuxQ8S9ZVwLaYGz8FMB8hv92uXeMwIbPRlEYVkuai4EVgqeEo1+inEu0xVb
	 SwykywV9wfQ+pPD41Dij5Ea2bDnfTJyyHaPEhDfKprXpZLZ/9yeKMcog25w8c1rinm
	 YIWCT+vueLENDVz3KbaU2Oa2VcVwPdXfWgYTzR8RQZx3R8sk6YyrYQUBZIk1G9KJqo
	 rk4YYFotUHfnA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH net-next] tools: ynl-gen: use uapi header name for the header guard
Date: Tue,  3 Oct 2023 15:57:35 -0700
Message-ID: <20231003225735.2659459-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chuck points out that we should use the uapi-header property
when generating the guard. Otherwise we may generate the same
guard as another file in the tree.

Tested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 897af958cee8..168fe612b029 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -805,6 +805,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.uapi_header = self.yaml['uapi-header']
         else:
             self.uapi_header = f"linux/{self.name}.h"
+        if self.uapi_header.startswith("linux/") and self.uapi_header.endswith('.h'):
+            self.uapi_header_name = self.uapi_header[6:-2]
+        else:
+            self.uapi_header_name = self.name
 
     def resolve(self):
         self.resolve_up(super())
@@ -2124,7 +2128,7 @@ _C_KW = {
 
 
 def render_uapi(family, cw):
-    hdr_prot = f"_UAPI_LINUX_{family.name.upper()}_H"
+    hdr_prot = f"_UAPI_LINUX_{c_upper(family.uapi_header_name)}_H"
     cw.p('#ifndef ' + hdr_prot)
     cw.p('#define ' + hdr_prot)
     cw.nl()
-- 
2.41.0


