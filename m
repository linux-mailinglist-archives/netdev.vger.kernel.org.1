Return-Path: <netdev+bounces-186777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8683AA10DA
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E61D5A03E9
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE523DE80;
	Tue, 29 Apr 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHIG9gu+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF223D2AA
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941632; cv=none; b=aE6ciNAP4BTAhFBJX8dCjv5iizmFuEs7n/XjiyksxjNHg6wNxkp1rPG+EW8fpJxnh+v6vruMVam2efNS+BaQsUWyNvveTVTK+beedjFjRCsZRpYE3KKryzRgZvbVf6vNnPGw4OSpqD0oDsYiUHmvubh8gbuhhBoBOA/D3uB5Bdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941632; c=relaxed/simple;
	bh=qpgTmVYSM/v9JlUdPTJfNH6WciRpZ+NADEKnuaEW+3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIVgHWY/9sPv5648SI2Mq7q53W4VD6UyT3Xix0Mq948CqeBip4gIrJbhp28+eAMyScK9xzHomFB50XIm/4C+GzK66IZfPf25hp2Ea0/b+dBik9b/3uDyaZ3J936gBGZQUZnAJVHFzUGVYObnTudr2CkRdEg2kkuQy3l631dgHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHIG9gu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452B6C4CEE9;
	Tue, 29 Apr 2025 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941631;
	bh=qpgTmVYSM/v9JlUdPTJfNH6WciRpZ+NADEKnuaEW+3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHIG9gu+NtrodGw+9Mnj4UKNQU5jFnOJLMoTwGGV6LCLkABSQ/rs+8iuptF1+m27x
	 xS6pvaZFd5FhdyffQO//ceM9fgaixuuRzfCg12hgSuHyf3rgmnRDLfFnMTUyvdarKn
	 oaPXSI55Qorm8kapeKguhMWxoenOu+Q6v3hW/NHkFeknYPOH6L+X3mUaqMQdjUZbfp
	 DBuVk55p6tlTh3BpnLkfLg/la2Sz+ulYe0pm6UNhlb5z2UzkZRH/vIbASEO/sTUawR
	 6PvB6rLY0v6kEoNWUQwP7qJyaqzrBG6hbkZhRWsHKYOwZJ0XPfp/NW2T1mbVDiW/JW
	 v3/DwEN8RVqLA==
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
	jdamato@fastly.com,
	nicolas.dichtel@6wind.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 01/12] tools: ynl-gen: fix comment about nested struct dict
Date: Tue, 29 Apr 2025 08:46:53 -0700
Message-ID: <20250429154704.2613851-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429154704.2613851-1-kuba@kernel.org>
References: <20250429154704.2613851-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dict stores struct objects (of class Struct), not just
a trivial set with directions.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 9613a6135003..077aacd5f33a 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1015,7 +1015,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         # dict space-name -> 'request': set(attrs), 'reply': set(attrs)
         self.root_sets = dict()
-        # dict space-name -> set('request', 'reply')
+        # dict space-name -> Struct
         self.pure_nested_structs = dict()
 
         self._mark_notify()
-- 
2.49.0


