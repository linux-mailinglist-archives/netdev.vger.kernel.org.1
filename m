Return-Path: <netdev+bounces-43570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B347D3EE4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E20B20E40
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B369219E3;
	Mon, 23 Oct 2023 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeFajfnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73A21365;
	Mon, 23 Oct 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585D4C433CC;
	Mon, 23 Oct 2023 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698085045;
	bh=WiITCf5zY6Hlzl3vukyuETjhw3O6d57u7Z1Kdb4hMoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GeFajfnNKnz+WgRLySiMk6CjfocT0wNirRs5ClcW5M6rFLOgLA+32YZrgzeicSGHr
	 tOiUl0udicQYuFXfuWAOVfyPA9l/tepnmruBU/2V5SJaR/brVK/phqXWhYRpoHxN5s
	 fM5oCrbARGkTIHBc2LZDlM5iOc8f/IKcHIodhw9trc9PpVMb+kDZkSCb8UN1ZpQGwu
	 4iyC6DrVDOX1dLpvpFfHEA8256cfDFu/NDWbYThanEHNRjze/tTYY5SOUG2ho/IQ7g
	 qfQ+at52aJhDXAlhw79CsC3f64ALmsjfHDjGE481QKKGOIJFiySB+0w4Go8lnRIIoE
	 P8/Q55S5ZDS6A==
From: Mat Martineau <martineau@kernel.org>
Date: Mon, 23 Oct 2023 11:17:06 -0700
Subject: [PATCH net-next v2 2/7] tools: ynl-gen: add support for exact-len
 validation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-send-net-next-20231023-1-v2-2-16b1f701f900@kernel.org>
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Simon Horman <horms@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.12.4

From: Davide Caratti <dcaratti@redhat.com>

add support for 'exact-len' validation on netlink attributes.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Acked-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 Documentation/netlink/genetlink-c.yaml      |  3 +++
 Documentation/netlink/genetlink-legacy.yaml |  3 +++
 Documentation/netlink/genetlink.yaml        |  3 +++
 Documentation/netlink/netlink-raw.yaml      |  3 +++
 tools/net/ynl/ynl-gen-c.py                  | 28 +++++++++++++++++-----------
 5 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index c72c8a428911..7ef2496d57c8 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -199,6 +199,9 @@ properties:
                   max-len:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  exact-len:
+                    description: Exact length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: &display-hint
                 description: |
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 05aa81dd6aba..0db4a6d49d6d 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -242,6 +242,9 @@ properties:
                   max-len:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  exact-len:
+                    description: Exact length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: *display-hint
               # Start genetlink-c
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 9ceb096b2df2..501ed2e6c8ef 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -172,6 +172,9 @@ properties:
                   max-len:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  exact-len:
+                    description: Exact length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: &display-hint
                 description: |
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index d976851b80f8..48db31f1d059 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -240,6 +240,9 @@ properties:
                   max-len:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  exact-len:
+                    description: Exact length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: *display-hint
               # Start genetlink-c
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index a9e8898c9386..454b7dea274d 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -410,10 +410,13 @@ class TypeString(Type):
         return f'.type = YNL_PT_NUL_STR, '
 
     def _attr_policy(self, policy):
-        mem = '{ .type = ' + policy
-        if 'max-len' in self.checks:
-            mem += ', .len = ' + str(self.get_limit('max-len'))
-        mem += ', }'
+        if 'exact-len' in self.checks:
+            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.checks['exact-len']) + ')'
+        else:
+            mem = '{ .type = ' + policy
+            if 'max-len' in self.checks:
+                mem += ', .len = ' + str(self.get_limit('max-len'))
+            mem += ', }'
         return mem
 
     def attr_policy(self, cw):
@@ -459,14 +462,17 @@ class TypeBinary(Type):
         return f'.type = YNL_PT_BINARY,'
 
     def _attr_policy(self, policy):
-        mem = '{ '
-        if len(self.checks) == 1 and 'min-len' in self.checks:
-            mem += '.len = ' + str(self.get_limit('min-len'))
-        elif len(self.checks) == 0:
-            mem += '.type = NLA_BINARY'
+        if 'exact-len' in self.checks:
+            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.checks['exact-len']) + ')'
         else:
-            raise Exception('One or more of binary type checks not implemented, yet')
-        mem += ', }'
+            mem = '{ '
+            if len(self.checks) == 1 and 'min-len' in self.checks:
+                mem += '.len = ' + str(self.get_limit('min-len'))
+            elif len(self.checks) == 0:
+                mem += '.type = NLA_BINARY'
+            else:
+                raise Exception('One or more of binary type checks not implemented, yet')
+            mem += ', }'
         return mem
 
     def attr_put(self, ri, var):

-- 
2.41.0


