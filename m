Return-Path: <netdev+bounces-185367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6FAA99EAD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FE919463AC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38571A5BA0;
	Thu, 24 Apr 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb0Zwv8Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71F19D09C
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460738; cv=none; b=X9y4bu2L+iJmfQBHzg4U7nIvBDjFH2KoWwLlfwMRsqmJ7sm4RPSx96fWDNp7QpMbA6yO0RWN1PGPa6YVbuyDdYTHw3kBFjta7nNnJMyCpud7EvqLjfDtZz2sUBGbywQ/Ut9VXFefHBsm02bdK6bsbfnhJfGOBqdUzE7cHG9tfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460738; c=relaxed/simple;
	bh=Xq8jSmmM82Vpu5ppX5Ta/IF8WhGPGVVcpSiJLesGPX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4Ip+DdNFzfbLILsi/bONC78FzkSHT+mvT7/mxPg98f5K5Su+g2Q6r3R7Ym8aG6iF3HRR1ZkRAk1DY+r1AgQ9hWHHpPuQOt5qfs40FNhMOiUC1WhxTW+l+vR1wOrxSJrN011m5hvdU0/Xrda0dMsjFSemKYk6NxvENvmMJbtTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb0Zwv8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46495C4CEE3;
	Thu, 24 Apr 2025 02:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460738;
	bh=Xq8jSmmM82Vpu5ppX5Ta/IF8WhGPGVVcpSiJLesGPX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cb0Zwv8QuIo2fY4d4cHyQlJGdSujAmyBvsRU3jYNG7XJsGvdIbcb9awXr1YZ/qAt7
	 DKLkeoMJj5Qu7kr/cSpcnymoXe8iIR5gIr6k3S/yASpeoE2VVQ08SggF7gTbyVpoCW
	 USJp+cVuV5MCqCYjsNeVfebhpdHbRidq3LT09y1fKG5K706HaWkBGkrvX/TAUCKXMn
	 jNjUlA2uCmUB++xtBidEBKSpEUWfdC1/RxXhZ5UI7h6VDHDNytcr5soz5UM4aS94t/
	 ZXJsqaPd1P/PrMXlw91Ab42Ar3hXmlm/MNe6VyASBlEcacaoZOJruiSAd6e48DE1cs
	 PWEJScaFeKkoQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/12] tools: ynl-gen: support CRUD-like notifications for classic Netlink
Date: Wed, 23 Apr 2025 19:12:01 -0700
Message-ID: <20250424021207.1167791-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424021207.1167791-1-kuba@kernel.org>
References: <20250424021207.1167791-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow CRUD-style notification where the notification is more
like the response to the request, which can optionally be
looped back onto the requesting socket. Since the notification
and request are different ops in the spec, for example:

    -
      name: delrule
      doc: Remove an existing FIB rule
      attribute-set: fib-rule-attrs
      do:
        request:
          value: 33
          attributes: *fib-rule-all
    -
      name: delrule-ntf
      doc: Notify a rule deletion
      value: 33
      notify: getrule

We need to find the request by ID. Ideally we'd detect this model
from the spec properties, rather than assume that its what all
classic netlink families do. But maybe that'd cause this model
to spread and its easy to get wrong. For now assume CRUD == classic.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2999a2953595..6e697d800875 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2789,7 +2789,11 @@ _C_KW = {
 
 
 def _render_user_ntf_entry(ri, op):
-    ri.cw.block_start(line=f"[{op.enum_name}] = ")
+    if not ri.family.is_classic():
+        ri.cw.block_start(line=f"[{op.enum_name}] = ")
+    else:
+        crud_op = ri.family.req_by_value[op.rsp_value]
+        ri.cw.block_start(line=f"[{crud_op.enum_name}] = ")
     ri.cw.p(f".alloc_sz\t= sizeof({type_name(ri, 'event')}),")
     ri.cw.p(f".cb\t\t= {op_prefix(ri, 'reply', deref=True)}_parse,")
     ri.cw.p(f".policy\t\t= &{ri.struct['reply'].render_name}_nest,")
-- 
2.49.0


