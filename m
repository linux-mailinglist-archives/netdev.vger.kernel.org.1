Return-Path: <netdev+bounces-76756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E3086EC9F
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 00:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DF0288099
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7845EE83;
	Fri,  1 Mar 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZmN6IIp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3E5EE80
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334352; cv=none; b=tbuXsyZw4RxzYbrZMvS4ihgVInKN509b/dnwOAwIH71BrDc3EHNJ0hecNJcSFQFaiCCpno0faqGMU/vw3lFUlh4/YRbvhncRGser6ZmW6fsnD7klNrV29IH0QckHO88PS+jz8y+xrbd7mN+E2FRmJ980elfN5j8nmbLbt7E5RYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334352; c=relaxed/simple;
	bh=Pg8IKvu6C9U4914HAOepP2IYBPxebyo2cAjVTXugOP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7KSxbFi3D4qDe51h39sKJkYI2PbpwZ6NQLMkzkXO9F8jePl7XT5OZ3V5BdcCBp8Qz5iIKdjSkeuYVaYL7Mx/lTlBTuBJoTc5wPzTHrXbtUESw43vmEsQEfcFwqR7yvYpInm4HUzBcG/9PbHNzuvw4Q0sYvtIQAP2eIU5ADP5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZmN6IIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46A4C43390;
	Fri,  1 Mar 2024 23:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709334352;
	bh=Pg8IKvu6C9U4914HAOepP2IYBPxebyo2cAjVTXugOP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZmN6IIpo44YlMY7cNjViakLe8R/53FfdZqDTu22Abd7SM2OsanzcTfwzEPKuRDsO
	 J7K4XVfbKbRIwioKg2fOHeIeAD7NuPFW1rUfpnz8pk9w6K/hGSwcQgKd/ODFQlrDUm
	 elOGouFzpOh/ipbiAM8hEM1ugn8AacDiSil0eBqbFpBHBRBOBWieZYRSZ0+yIIShDe
	 4xBqqQs4SmkIQuJYKJ79T0dR5iNQF8vXu8Pd8SDFLLY2jpxskvx8L0boyKoLDQVSOq
	 Pu73SRGlt/pBK3d7KkCn+KK6ivFJMmblfgfDIOyGntDiDOW/R5fm82lkkO5EfhkwL8
	 qrJOpVzc6ZssQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/4] tools: ynl: move the new line in NlMsg __repr__
Date: Fri,  1 Mar 2024 15:05:39 -0800
Message-ID: <20240301230542.116823-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301230542.116823-1-kuba@kernel.org>
References: <20240301230542.116823-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We add the new line even if message has no error or extack,
which leads to print(nl_msg) ending with two new lines.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index ac55aa5a3083..92ade9105f31 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -213,11 +213,11 @@ from .nlspec import SpecFamily
         return self.nl_type
 
     def __repr__(self):
-        msg = f"nl_len = {self.nl_len} ({len(self.raw)}) nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}\n"
+        msg = f"nl_len = {self.nl_len} ({len(self.raw)}) nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}"
         if self.error:
-            msg += '\terror: ' + str(self.error)
+            msg += '\n\terror: ' + str(self.error)
         if self.extack:
-            msg += '\textack: ' + repr(self.extack)
+            msg += '\n\textack: ' + repr(self.extack)
         return msg
 
 
-- 
2.44.0


