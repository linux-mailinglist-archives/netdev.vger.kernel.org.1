Return-Path: <netdev+bounces-260185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKOtIiy4nGkqKAQAu9opvQ
	(envelope-from <netdev+bounces-260185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:27:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4D317CE5A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1FF3305E389
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E344377579;
	Mon, 23 Feb 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vxiua9he"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1BF3783A8;
	Mon, 23 Feb 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878421; cv=none; b=OWIku1DH7RavSumLCkZh2eaaU8zotWpvOd4NwbwSa3zg7183/mqb7P2GaVKlLpHmTvjpsPdBUUM8NEbwboLmOnYMbuWUC8uHRdZzB85bU84tFAGcJ4sz3QCXzGwsu12b/T95frVtwRtBt/EEMyIFxCqPckdbIHYJsVNVq7IsvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878421; c=relaxed/simple;
	bh=qhrvUQIXuQ3EiOxpErV29DBp8kk0rWHzOq3GmGAOSHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENsAcYlfMvE13e5Rhy7dCOJWmu1uVmtcTJ1WJNRdy8PCT7X/tQ5SXJ3gBl72zIejr2S/yvbmUe0ThlCYmtlqDi1W6s5XEdg4B7EnzANSje7Yj7Ehf//DiIMtQcbDSfx1vZVjeSNHgqw3mJ28BnuFrwFDiNH1LzD9DkOVGgXc/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vxiua9he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F080C19421;
	Mon, 23 Feb 2026 20:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771878421;
	bh=qhrvUQIXuQ3EiOxpErV29DBp8kk0rWHzOq3GmGAOSHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vxiua9heUg63yk9zSRqCNeE3YM5TRs1B2pxdyRMcl0OIgMdsgW89kPkiSh0vXqtsU
	 UodGhfwxXhXn9yQCPh9Iikq6qfG4OlKJ5R1iRn9EXuTDdnx8pt77ioucX6/LIw34L+
	 31pLKmzikcLVnpakIrKqqErEcc+IxaAdMp5BdNQ/uTeIJF9TOc+jRRGREZw+RM04Oj
	 5ysb1rPpeUT1dKPNqhfUEo/sv/GiKeNbnctG6cCQSSl9nWYzAAOI2xNKYo5yf1X5JM
	 GSL3uVqk0guc0c1Gsf19X4awMSPKJYb5Xj17gx7qzTRi4S24Mb7Ceqyi99pThSkn7K
	 jhIWPc9AjRtEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	petrm@nvidia.com,
	gal@nvidia.com,
	leitao@debian.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] selftests: net: py: use repr(cmd) for failure exceptions
Date: Mon, 23 Feb 2026 12:26:32 -0800
Message-ID: <20260223202633.4126087-3-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223202633.4126087-1-kuba@kernel.org>
References: <20260223202633.4126087-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-260185-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C4D317CE5A
X-Rspamd-Action: no action

Reuse repr(cmd) instead of manually formatting a similar string.

Before:
  # Exception| lib.py.utils.CmdExitFailure: Command failed: false
  # Exception| STDOUT: b''
  # Exception| STDERR: b''

After:
  # Exception| lib.py.utils.CmdExitFailure: Command failed
  # Exception| CMD: false
  # Exception|   EXIT: 1

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 8fa1c2fabfc2..52d98ca139ff 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -11,7 +11,7 @@ import time
 
 class CmdExitFailure(Exception):
     def __init__(self, msg, cmd_obj):
-        super().__init__(msg)
+        super().__init__(msg + "\n" + repr(cmd_obj))
         self.cmd = cmd_obj
 
 
@@ -98,8 +98,7 @@ import time
         if self.proc.returncode != 0 and fail:
             if len(stderr) > 0 and stderr[-1] == "\n":
                 stderr = stderr[:-1]
-            raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
-                                 (self.proc.args, stdout, stderr), self)
+            raise CmdExitFailure("Command failed", self)
 
     def __repr__(self):
         def str_fmt(name, s):
-- 
2.53.0


