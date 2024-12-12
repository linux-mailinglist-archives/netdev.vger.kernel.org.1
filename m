Return-Path: <netdev+bounces-151443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FED9EF0C9
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A934A29C4C7
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E846242EF7;
	Thu, 12 Dec 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mguentner.de header.i=@mguentner.de header.b="vH0yHTTT"
X-Original-To: netdev@vger.kernel.org
Received: from mail.transformierende.org (mail.transformierende.org [116.203.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BAD235C44
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.43.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020382; cv=none; b=ua5cuFbUnX0KBkcUOU2+ake7p5+Zrow9mcAAUqtoMxG9DwUx+oQu/Xb3ruzw36YAwRf6/nwRBSOayr/g0mXlzz97GR8jaxdKAcNTBBfqossu8TLAD43ng18MWvRy8XlkiyplLrqgsJ7GgZcp2lIt+5kjK4N+JAiGAz0B7u8Xx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020382; c=relaxed/simple;
	bh=SSZNEqgCyQaxVi5bgdt8h6NjIKfN3mwKR2Wp89D139s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fEHJT4CdNGeRtZ7/fWBbCXSbf+unUBTgPcxDbIc1aAguPmHA15dHTD7mTxWo3qLy/UuG9K8Klv6aiwOx/qZ96B+e3xdFQBY2DkfKbDurZee1cIYDBsRY1tYoXSmX5LxlWNdxxUibB7o7NDBztX/3d2bPWNN7zg/VsHd+S8DmDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mguentner.de; spf=pass smtp.mailfrom=mguentner.de; dkim=pass (1024-bit key) header.d=mguentner.de header.i=@mguentner.de header.b=vH0yHTTT; arc=none smtp.client-ip=116.203.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mguentner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mguentner.de
From: =?UTF-8?q?Maximilian=20G=C3=BCntner?= <code@mguentner.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mguentner.de;
	s=mail; t=1734020375;
	bh=lQE+4+q1H0866N2a/bMZsIdgNZ1b7euphOxbX9tBYDw=;
	h=From:To:Cc:Subject:Date;
	b=vH0yHTTTBaIV00EwAcPQlBLI7uOe7jzgb8hPj1OONU8WDE6Ij2zZSBagFDj8dj2fa
	 isThzWEzAnh3WMLBynV3VVriQtuiGxG7Vg6lEK0Z6yVMT0Hu5+/rHe5uiq95LTIsEY
	 GSaHviv+kqKISLaNZTaa+oFsXLk0UgGB+DUnUiNA=
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Maximilian=20G=C3=BCntner?= <code@mguentner.de>
Subject: [PATCH] ipv4: output metric as unsigned int
Date: Thu, 12 Dec 2024 17:19:11 +0100
Message-ID: <20241212161911.51598-1-code@mguentner.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

adding a route metric greater than 0x7fff_ffff leads to an
unintended wrap when printing the underlying u32 as an
unsigned int (`%d`) thus incorrectly rendering the metric
as negative.  Formatting using `%u` corrects the issue.

Signed-off-by: Maximilian Güntner <code@mguentner.de>
---
 net/ipv4/fib_trie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 161f5526b86c..d6411ac81096 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2999,7 +2999,7 @@ static int fib_route_seq_show(struct seq_file *seq, void *v)
 
 			seq_printf(seq,
 				   "%s\t%08X\t%08X\t%04X\t%d\t%u\t"
-				   "%d\t%08X\t%d\t%u\t%u",
+				   "%u\t%08X\t%d\t%u\t%u",
 				   nhc->nhc_dev ? nhc->nhc_dev->name : "*",
 				   prefix, gw, flags, 0, 0,
 				   fi->fib_priority,
@@ -3011,7 +3011,7 @@ static int fib_route_seq_show(struct seq_file *seq, void *v)
 		} else {
 			seq_printf(seq,
 				   "*\t%08X\t%08X\t%04X\t%d\t%u\t"
-				   "%d\t%08X\t%d\t%u\t%u",
+				   "%u\t%08X\t%d\t%u\t%u",
 				   prefix, 0, flags, 0, 0, 0,
 				   mask, 0, 0, 0);
 		}
-- 
2.47.0


