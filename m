Return-Path: <netdev+bounces-89774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A8D8AB8A6
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 04:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20901F2139D
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 02:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C413110F7;
	Sat, 20 Apr 2024 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N98u3hQo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A9A48
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713578916; cv=none; b=FfJVNUlN+r/mZ2Qh8lwqRCUBYYmNCJGwpFDmonhFCsowmFM74Oxg9sPEWLdxxLd0VGK3PKnqtrUBK318KBa+hqvZe2dPjc1SAPEO+bidVIn2QrXQzqq/Jfr1I0Gr78YWfcVB/tI/yf37LoJswGtqCDJ1gauYKVyODIKAt0S1+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713578916; c=relaxed/simple;
	bh=IzQ3AfrwSxwvtUtr1hjhZwQdlIBP3jo7zAL7blU1moI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8OfWsMYmdgpyswp1hkmtlg264rsDLqxSPHzWAhyYmoB2CQyMtIFLMBLRiPCIHQnjvcQTGMdSAzkm6mq9F0GtXfZBdh2/fR84JAWbWsJEY2ZEV8CgAEh8cylNDysuLkRVxQbY0z2gL+9UsgQ8XUb6pKdQpAq7oMsNop2z7rYgwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N98u3hQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C8FC072AA;
	Sat, 20 Apr 2024 02:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713578916;
	bh=IzQ3AfrwSxwvtUtr1hjhZwQdlIBP3jo7zAL7blU1moI=;
	h=From:To:Cc:Subject:Date:From;
	b=N98u3hQoPNJfnn2Xd/F20z5gHMx9GJs1+v5mNWjE+YEB+OQmXK1v5R2qTwUgG981v
	 ToZBi6d7SSbWuSzTkcUlG7rDORo3qj4+JwHo8NDA5Mr7KY6Tx5YXwmc3VHWdwzZVw0
	 oRL2nWCD7YVBT1GRILzCZEiOJvO7q8UjrxyTastirvZY4A/jQHVu6wZCVTwF24vtV9
	 7nDaCjzuQmv8QeUFjsSop/oSUuccM9wGXb4d+OQq7135UOHeKqu/LKNznOurv0b6Y3
	 sc5WgdIEeszc0p8SY4TqnFj6Mz44AXqF/LSTRsGCQbAfLJtj7GxGWQA36IVtnV2+lq
	 DychkcJ5LtQ1g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	sdf@google.com
Subject: [PATCH net] tools: ynl: don't ignore errors in NLMSG_DONE messages
Date: Fri, 19 Apr 2024 19:08:26 -0700
Message-ID: <20240420020827.3288615-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NLMSG_DONE contains an error code, it has to be extracted.
Prior to this change all dumps will end in success,
and in case of failure the result is silently truncated.

Fixes: e4b48ed460d3 ("tools: ynl: add a completely generic client")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
CC: sdf@google.com
---
 tools/net/ynl/lib/ynl.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index a67f7b6fef92..a9e4d588baf6 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -203,6 +203,7 @@ from .nlspec import SpecFamily
             self.done = 1
             extack_off = 20
         elif self.nl_type == Netlink.NLMSG_DONE:
+            self.error = struct.unpack("i", self.raw[0:4])[0]
             self.done = 1
             extack_off = 4
 
-- 
2.44.0


