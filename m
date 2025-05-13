Return-Path: <netdev+bounces-190265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B64AAB5F30
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDCB3A8BDD
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B45219E806;
	Tue, 13 May 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hstfxpL8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A2C41C7F
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174601; cv=none; b=unvihRhh7+6oX5baFsgwNF8RI8d8GahZyqiVrb3NRJEjFVqhnhiSg+w4ZHuUsW4yd40PSUJQzAUPcPDZrnlNKxMwvPpvnjyLnwHtGA6kHx+8dNibkm3zidKnUj89/+uycG/JUyAbfGLSIU8gmpVbtdjEKjZCME8HYEIHVmZ8ue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174601; c=relaxed/simple;
	bh=R9KrBFL4pcDpmcrFhMwY/yrz3VoZfkifOCHjPmrQ81A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EU2fQFUKiN90HS/YezpZOw/jNAcxQM6LEyQ/y7tjrp8Ta5Cu7cF0w5A3XNrTSw5lXMsANt8zyVacDKLVgelAsrs2QF/1Xq7dXca+TQQNvZ9JweKxriqVMY6bhIG5YjZt9Q6ly5Spha8MckaJL4mXLWFf5dWgS3ug/gWLm1hNm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hstfxpL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C741C4CEE4;
	Tue, 13 May 2025 22:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747174600;
	bh=R9KrBFL4pcDpmcrFhMwY/yrz3VoZfkifOCHjPmrQ81A=;
	h=From:To:Cc:Subject:Date:From;
	b=hstfxpL8f2l+wnKCl541A/c3YYW1BwQztd2q/EV+pPgJPwQAbD4R1pCnuJ9vfXtJV
	 7VVrP/0HBUNQeLM63ozRM9YHpBpk7u1boJSaB6qnJaAAat2N+aavYZsmuAoUzRxE/3
	 lTuegw24/MnoqFcLiLC7s+jB4vjKxJRKBELqb7iJk9NuoNSh7hUOQmUlnkhrpH8btv
	 hSW9VBkAEDBIU8JMNBCqVnDnmLM4lwb+rga7868kTowCBXeZXXx5Ty5Lo4u6VuUrLV
	 MpbVwSGIk4lLhjF893v7uxyv7U4koPCcsoucJ7FgVFABuxCsywnT2DllIT0mKTaSVD
	 0h72XlyZLGAdg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	jiri@resnulli.us
Subject: [PATCH net] netlink: specs: tc: all actions are indexed arrays
Date: Tue, 13 May 2025 15:16:38 -0700
Message-ID: <20250513221638.842532-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some TC filters have actions listed as indexed arrays of nests
and some as just nests. They are all indexed arrays, the handling
is common across filters.

Fixes: 2267672a6190 ("doc/netlink/specs: Update the tc spec")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
This is really borderline for net vs net-next decision IMO.
I'm posting it for net because repost will make it late for
net-next merge. But happy to go with net-next.

CC: donald.hunter@gmail.com
CC: ast@fiberby.net
CC: jiri@resnulli.us
---
 Documentation/netlink/specs/tc.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 5e1ff04f51f2..953aa837958b 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -2017,7 +2017,8 @@ protonum: 0
     attributes:
       -
         name: act
-        type: nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-act-attrs
       -
         name: police
@@ -2250,7 +2251,8 @@ protonum: 0
     attributes:
       -
         name: act
-        type: nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-act-attrs
       -
         name: police
-- 
2.49.0


