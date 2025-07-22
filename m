Return-Path: <netdev+bounces-209044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13A3B0E18E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3DF161B2F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C92527A909;
	Tue, 22 Jul 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxG48rwE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5427A103
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201183; cv=none; b=RhSsG9iOTlAi9q5jLBPxV0DDJoTlvOYIR8l44pp98gopoULHeXOMFd9HtONF7yyaVFsvxgTvo4iWj/lHaYSRNo6UMqAXsWQ4VCDiQl6Kipffg63jGPyatGQZkYE0FuWa+cAE7S1RfuwU9wOWPjgrIjIsHWOjF6kXkgh7zkLmCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201183; c=relaxed/simple;
	bh=ocKPL9tOhvGMi6/KaA8xoxCzKXvyBu7gG3FP4f7Wd+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pev5M0Ruq1vIeyZkIDaof/yAd1MBT856meTEcwJvcVLE4Y94bakCvN1Nv1sZTVexYMB/a9g8OYGVTFJM7rC/Bgyhlq9jQPccuzWQMnsBxMnzRnP9abzgzVNDsfV8E0jV/j0kalf+sBcghtnIxYiCQT01aqPGosQY8UxF4AUmRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxG48rwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74632C4CEF8;
	Tue, 22 Jul 2025 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201182;
	bh=ocKPL9tOhvGMi6/KaA8xoxCzKXvyBu7gG3FP4f7Wd+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxG48rwEdCq6HRDz5c3xB9I2+tOoXW3fsWDQfokBsn//MXCM5yg5glLzJk2xrJuM9
	 PCb5OW5Q1IJpV+FZHNxtDPUUflJBSj/rpLkcMYTgj5AZldppQOJ4qf3WOPXcGmKx2U
	 qUVgbecXu+XKOzzKPqRp4ipyusNziK339DK3qEp6SrkRq5Jc+7r0xxk7UDLtpgUGp/
	 1TO4VoLJHVA6Zq8JB5/MQ5FG9gXpoMqm149fLRcpzgdyDJZ2cETnS80sg8CJRuu1Sr
	 Q5STQGaoaWdluM+a2nN+uQDjoc9Q87HgeBZ6SAmS9OVd2cIUS3h8xlM7KyJP050Vhk
	 tElkLZbWpRuzg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	almasrymina@google.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] tools: ynl-gen: don't add suffix for pure types
Date: Tue, 22 Jul 2025 09:19:23 -0700
Message-ID: <20250722161927.3489203-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722161927.3489203-1-kuba@kernel.org>
References: <20250722161927.3489203-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't add _req to helper names for pure types. We don't currently
print those so it makes no difference to existing codegen.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 76032e01c2e7..1bdcc368e776 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1879,7 +1879,9 @@ _C_KW = {
 def op_prefix(ri, direction, deref=False):
     suffix = f"_{ri.type_name}"
 
-    if not ri.op_mode or ri.op_mode == 'do':
+    if not ri.op_mode:
+        pass
+    elif ri.op_mode == 'do':
         suffix += f"{direction_to_suffix[direction]}"
     else:
         if direction == 'request':
-- 
2.50.1


