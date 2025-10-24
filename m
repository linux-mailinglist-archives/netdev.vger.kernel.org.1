Return-Path: <netdev+bounces-232719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C37C0837E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 23:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F0724E270C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 21:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819D303C9B;
	Fri, 24 Oct 2025 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHabAFPR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA2261B92
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761343035; cv=none; b=ABPx7RjCuMDA9HJB4uSD5hi7VDWQzbPmWvZS6qNH9N0r6R4CnspTyay2KjyMJCsXFcpRp2HyPGKc0dJHDh1lESlaNlpyWrhZFSYV51WnzSUpbRIXGkmI+3kRbTthMfyq5NED60QCHwzKpirOsnSCUnFfRz8DVa/0i6l/jlVqP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761343035; c=relaxed/simple;
	bh=ca5JJ0GDzNtw0cMYe3ImgEh7xf5rzZMySmEHPef8VMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvDnqoLLlp9GAX4aFg7KnT/n0rHnGGugPJ+KXc3+f+UjFecBWeflUESE9puJK26x6enO/jRtm+HxfjDe6y51L8HeffyGq15K9EgC3joyuBZFCZ3x8hn0x/BTGxKmaGEw+91El0kxtUOPsjSVeuLj6fUaTLgj+j2P94B+ZHvoEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHabAFPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A3AC4CEF1;
	Fri, 24 Oct 2025 21:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761343034;
	bh=ca5JJ0GDzNtw0cMYe3ImgEh7xf5rzZMySmEHPef8VMk=;
	h=From:To:Cc:Subject:Date:From;
	b=qHabAFPRPGGw5+xp+786o4ohoRbKA2KGJ692cLQdiDgzeOGEsj75zPhgFcAoPH8wd
	 3SPxK1SVtrG7+1O/mIGg0ZpVejYKj+B4PAqbf5svGCpC2tQ5+UI5dALxo9EDiaMYqG
	 5bQDs47RaeYHZfRYmEUpbWUJr9hrLktedzzchM8Ljsot73GpQDZhHexHVRqSoOyh2U
	 AMheMT+6hxRg6coOM0BFfHuH+gfUB0t3l1dcOKZ5JlUj3MomiO4Ad2Ib8bc7KCsInL
	 VwKDV06lj5KP+Q6PVq2KVLZR5faSGSg4r4xsGqshApmXFgAVrgivC2iGXteWUYsm6Q
	 BQg5F9S/Is+hA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	ast@fiberby.net
Subject: [PATCH net-next] tools: ynl: rework the string representation of NlError
Date: Fri, 24 Oct 2025 14:57:13 -0700
Message-ID: <20251024215713.1250688-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In early days of YNL development dumping the NlMsg on errors
was quite useful, as the library itself could have been buggy.
These days increasingly the NlMsg is just taking up screen space
and means nothing to a typical user. Try to format the errors
more in line with how YNL C formats its errors strings.

Before:
  $ ynl --family ethtool  --do channels-set  --json '{}'
  Netlink error: Invalid argument
  nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
	error: -22
	extack: {'miss-type': 'header'}

  $ ynl --family ethtool  --do channels-set  --json '{..., "tx-count": 999}'
  Netlink error: Invalid argument
  nl_len = 88 (72) nl_flags = 0x300 nl_type = 2
	error: -22
	extack: {'msg': 'requested channel count exceeds maximum', 'bad-attr': '.tx-count'}

After:
  $ ynl --family ethtool  --do channels-set  --json '{}'
  Netlink error: Invalid argument {'miss-type': 'header'}

  $ ynl --family ethtool  --do channels-set  --json '{..., "tx-count": 999}'
  Netlink error: requested channel count exceeds maximum: Invalid argument {'bad-attr': '.tx-count'}

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: ast@fiberby.net
---
 tools/net/ynl/pyynl/lib/ynl.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 62383c70ebb9..bac9eb33ba89 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -105,7 +105,17 @@ from .nlspec import SpecFamily
     self.error = -nl_msg.error
 
   def __str__(self):
-    return f"Netlink error: {os.strerror(self.error)}\n{self.nl_msg}"
+    msg = "Netlink error: "
+
+    extack = self.nl_msg.extack.copy() if self.nl_msg.extack else {}
+    if extack:
+        if 'msg' in extack:
+            msg += extack['msg'] + ': '
+            del extack['msg']
+    msg += os.strerror(self.error)
+    if extack:
+        msg += ' ' + str(extack)
+    return msg
 
 
 class ConfigError(Exception):
-- 
2.51.0


