Return-Path: <netdev+bounces-233295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEFFC1121F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF14D56518F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6243203BB;
	Mon, 27 Oct 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnlXZJF8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669972DC769
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593405; cv=none; b=pC9tre57seJ2f8z4cjLBadsKhj3G4rmaOQmC5xe+ejFY5DWAXoAnUzqIJ6ct0frB7qpk6wipOpPMgU4yweOwa2SDMujtPS4VVEKV5fhdOG/6QHxEGzzBQe9Kj4UABZdLt0nYTkUfCCn6CrOSWWHsUgsHIoTcfFOe+QKdgIcKhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593405; c=relaxed/simple;
	bh=IYaB4JNIs0vAlAn5xUvZh09Adg+rSrIgI/zzHiuzBPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOqFZfX6F4hxTYI2sb9Yog+x27iuRcXomteO0aYjTnk/uOR2kp5usDK48W3qZ+9kBZ7aPwls4EFwXfVfmp5C+rLQwLVoGMzjEUYGfjJJSPJG/cYF5vKs3b98/z5Qg45DJoWyY3ZTd3Vj5K7iBKn1/kglLyAsK+TM1HnPn2PiIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnlXZJF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5CDC4CEFD;
	Mon, 27 Oct 2025 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593405;
	bh=IYaB4JNIs0vAlAn5xUvZh09Adg+rSrIgI/zzHiuzBPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnlXZJF8Dnn49xCorxzK09gHUW17t/bt+dChjlmM3s1rAdq9B/gAxJDalHfPAQaVr
	 WpaUSkv8Xm+F5tq/dznps9Gl+To0zD6NESmbBjUWJAMfgwUT42wssLgZ7A68pQtUb8
	 EObnXvMgM816G257KdyZRFM7az6DixRSh1M9R9PUuwRmlPkMAN445iy68WWChBEGsc
	 F6/sRI38c+xVpU3AeMqsHU3fwErCpTthTyR5SErk77Awt184DZEKnRiwWTAC38oDuC
	 IzrSTmUSrBalcT8/tVHIZ3uSvqM/1I4ydRQrmSxCfg60+nphTp8+HmHIinlut/gx1y
	 l0K0LWD++J41Q==
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
Subject: [PATCH net-next v2 2/2] tools: ynl: rework the string representation of NlError
Date: Mon, 27 Oct 2025 12:29:58 -0700
Message-ID: <20251027192958.2058340-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027192958.2058340-1-kuba@kernel.org>
References: <20251027192958.2058340-1-kuba@kernel.org>
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
v2:
 - remove an unnecessary condition
v1: https://lore.kernel.org/20251024215713.1250688-1-kuba@kernel.org

CC: donald.hunter@gmail.com
CC: ast@fiberby.net
---
 tools/net/ynl/pyynl/lib/ynl.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index bdcc4f031d39..225baad3c8f8 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -105,7 +105,16 @@ from .nlspec import SpecFamily
         self.error = -nl_msg.error
 
     def __str__(self):
-        return f"Netlink error: {os.strerror(self.error)}\n{self.nl_msg}"
+        msg = "Netlink error: "
+
+        extack = self.nl_msg.extack.copy() if self.nl_msg.extack else {}
+        if 'msg' in extack:
+            msg += extack['msg'] + ': '
+            del extack['msg']
+        msg += os.strerror(self.error)
+        if extack:
+            msg += ' ' + str(extack)
+        return msg
 
 
 class ConfigError(Exception):
-- 
2.51.0


