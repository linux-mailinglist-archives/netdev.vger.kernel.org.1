Return-Path: <netdev+bounces-286384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKo2NYncAGoXNwEAu9opvQ
	(envelope-from <netdev+bounces-286384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:29:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E6A505F7D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D69BA3008D13
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830E02DAFD7;
	Sun, 10 May 2026 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJKhpK6V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602281DE2AD;
	Sun, 10 May 2026 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441349; cv=none; b=RmXshD5TqhMWZjnpiH/FdShuN+aVMB6KFohzHyyxiR/RsQEXkqCJlJpjUgzLjSWdvcK7TAMBM/1w2ZIQcqBNvOC92TG7iBCsVHim11395kWzhEscQUZf/c5b070qgU9AOKWCb3fmNZ+1z2SRIYrZKyuZUvhbKP5JGjyHIQS+028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441349; c=relaxed/simple;
	bh=A27tSKTK/R156yAe8xbSCZ6AasQSLrBZjFHvuSsxZms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0GI3wgQYPG0qpCuVMj3NY9Q6XmKSX/abFVguT8mcmESNAr7M8muayQp2nbi+ypKXarepYhyL9eN9uei2WCCFICDeCvWp+C2wiwjoZFsxsiG4jthbDiozY5kpL2XMaE4uk8WTHR2L/1sdD5mXPugHjPN7TS9bDZzIWrOY+GEjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJKhpK6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ECFC2BCB8;
	Sun, 10 May 2026 19:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778441348;
	bh=A27tSKTK/R156yAe8xbSCZ6AasQSLrBZjFHvuSsxZms=;
	h=From:To:Cc:Subject:Date:From;
	b=oJKhpK6VjCcbmqoetq8rto6Yk1l81rL10XekObPzEs4iCrSoEUkQi2F5BC3CBMMLD
	 +hfYH40hAzJNwq8T/D8uhYBOhdV3Tb+oMI4y6TnXPOYWCLwZDr+cWHstmC2qmV+G1E
	 vuTExcBXMkNpFIJpmlYZGN6bp2RqqB/aFEvCHuiHIbLzc9y+3rX/Oy5m3cZ+lC3PBr
	 /GwHV/NF8nbBNSpwdBOc96OXmGNxnHZAJOFvainreyWrL2UtfSUQF8YBJF7fMwabdf
	 fCs4UqxvlV1Jo242yMNJ+2mtkYZb5kLotQsx6WazuR4zIOy+wVxvtXgFa8s6Ad31Q/
	 ga2Hs+TsBCBXw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 00/10] net: shaper: fix various minor bugs
Date: Sun, 10 May 2026 12:28:54 -0700
Message-ID: <20260510192904.3987113-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C2E6A505F7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286384-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Fix various minor bugs in the net shaper API.

First 2 patches deal with ordering issues around inserting
and publishing new shapers. Shapers are inserted "tentatively"
and marked valid only after HW op succeeded, this used to
be slightly racy.

Only other patch of note is patch 8. We want to add a Netlink
policy check on the handle ID. This necessitates patch 7.

The rest are simple and self-explanatory.

v2:
 - drop the first 2 patches - the corresponding changes will
   be sent later to net-next.
v1: https://lore.kernel.org/20260506000628.1501691-1-kuba@kernel.org

Jakub Kicinski (10):
  net: shaper: flip the polarity of the valid flag
  net: shaper: fix trivial ordering issue in net_shaper_commit()
  net: shaper: reject duplicate leaves in GROUP request
  selftests: drv-net: add shaper test for duplicate leaves
  net: shaper: set ret to -ENOMEM when genlmsg_new() fails in group_doit
  net: shaper: fix undersized reply skb allocation in GROUP command
  tools: ynl: add scope qualifier for definitions
  net: shaper: reject handle IDs exceeding internal bit-width
  net: shaper: enforce singleton NETDEV scope with id 0
  net: shaper: reject QUEUE scope handle with missing id

 Documentation/netlink/genetlink-c.yaml        |   9 ++
 Documentation/netlink/genetlink-legacy.yaml   |   9 ++
 Documentation/netlink/genetlink.yaml          |   9 ++
 Documentation/netlink/netlink-raw.yaml        |   9 ++
 Documentation/netlink/specs/net_shaper.yaml   |   7 +
 net/shaper/shaper_nl_gen.h                    |   2 +
 net/shaper/shaper.c                           | 136 +++++++++++++-----
 net/shaper/shaper_nl_gen.c                    |   7 +-
 tools/net/ynl/pyynl/ynl_gen_c.py              |  31 +++-
 tools/testing/selftests/drivers/net/shaper.py |  24 +++-
 10 files changed, 200 insertions(+), 43 deletions(-)

-- 
2.54.0


