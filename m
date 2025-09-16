Return-Path: <netdev+bounces-223671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4CFB59EC0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5416816CDEE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52632D5DF;
	Tue, 16 Sep 2025 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj+TwxSB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89673285404
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042273; cv=none; b=Y5Tx13keIYOe3SThKwOcr9AMP4IKEUJ3d6XFEQlBPTbO4zXNaAT6La04zbzc22/6ZxpiZkiJLpSBCVrrO6B/qLNhPIXcYX3ck9WcjK4aMQMv1q6mKDP8CRFywwxLYzvbBCTa53hWmzEHAwFB/xy6bHThIpC2UGbNtptAiOH73nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042273; c=relaxed/simple;
	bh=8Sg8pwr3MNkCXQAkCXG+gPQWVgQaLi8u3K0fwwpf1zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BiyB6keB1Am29fUB6UeOo6a7TKKKC+GXG1aZxIvWA5X5AtV2rLWAe0Wo/dcubKvAZ1haKxn0e4o1aIAFX0Ds5oqax4D3ueJBnv6ScYRSOHhkX6N7HF1PvUYtNIQJy2WKRTeTlQz5GoUgtJDT3s4eE3DOUiKmneHT1XgcLuUgnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj+TwxSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97269C4CEF7;
	Tue, 16 Sep 2025 17:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758042273;
	bh=8Sg8pwr3MNkCXQAkCXG+gPQWVgQaLi8u3K0fwwpf1zg=;
	h=From:To:Cc:Subject:Date:From;
	b=mj+TwxSBP1lNfvu1rDsL6nXdPU37PZkTDVvQ9HG21Hy0xyv7wXNafgS4mo2EjOmiG
	 U/1NP8RggRG+4euDwWAB7JK7CfLSFv3op7IxUvrGEuaal/FFeQa8nCac/2371fASC/
	 rEuuJ8MjVa/LrRAhG2RBXW1K6CpW/32NdPNLd2aozDqc18Ebk8NXoJ04AbzUi4v+8n
	 czYiOPK5rVWyF3YndZPeB4FrIoJQap0XhdE7Qenu8HWlEpLbK8w5+Dr2doGOTA5iFs
	 BPgv9M9kyrLm6OJLNLFWHxI4h1w1+011lT+gFI335DoAyQdQJjXsoOMP5pJc6Yb1kG
	 N4fc5paDVwCKQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com
Subject: [PATCH net-next] tools: ynl-gen: support uint in multi-attr
Date: Tue, 16 Sep 2025 10:04:31 -0700
Message-ID: <20250916170431.1526726-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool FEC histogram series run into a build issue with
type: uint + multi-attr: True. Auto scalars use 64b types,
we need to convert them explicitly when rendering the types.

No current spec needs this, and the ethtool FEC histogram
doesn't need this either any more, so not posting as a fix.

Link: https://lore.kernel.org/8f52c5b8-bd8a-44b8-812c-4f30d50f63ff@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jacob.e.keller@intel.com
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 56c63022d702..58086b101057 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -720,7 +720,11 @@ from lib import SpecSubMessage
             return 'struct ynl_string *'
         elif self.attr['type'] in scalars:
             scalar_pfx = '__' if ri.ku_space == 'user' else ''
-            return scalar_pfx + self.attr['type']
+            if self.is_auto_scalar:
+                name = self.type[0] + '64'
+            else:
+                name = self.attr['type']
+            return scalar_pfx + name
         else:
             raise Exception(f"Sub-type {self.attr['type']} not supported yet")
 
-- 
2.51.0


