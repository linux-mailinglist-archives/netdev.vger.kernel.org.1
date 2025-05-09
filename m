Return-Path: <netdev+bounces-189386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F9AB1F10
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD463B8511
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893225FA0E;
	Fri,  9 May 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqvYpYP1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B8625F989
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826185; cv=none; b=kFJ6qI5UAJdtwuv265olwds/Cj7H9Nk6OpaNAsZ9XYupoehCV2RGXuRTbHtt3oCOjIZmEKpUBUcvqCF7acAywwCizk8EloAh2kstyXAuPkulkCJgA1gTdgCM+aX8gDH7NsZd3zaZe4Qut2i/GqypAhRdo2IrXrkhmdIGw6jh1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826185; c=relaxed/simple;
	bh=hGk93qLPvPkxQbsjTNmX+T+FLXvsJZ9aT1YFOAbKXjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fLYW0MLqFuNH0LpZEI7R7/Q2ifahOrZ6UtIS1IS2pxPXhW8HFn+fOHjuUlfbqYzi6juic/8HpgkRSafIHDGiwSsv/QNQOBfXobFhLASQHDeN7GpysihRDLVYKZ788257LURfHhC++YAv7uefsrRS4Vt1yVU+TBSTcYpDT7Bh2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqvYpYP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1596C4CEE4;
	Fri,  9 May 2025 21:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746826185;
	bh=hGk93qLPvPkxQbsjTNmX+T+FLXvsJZ9aT1YFOAbKXjQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MqvYpYP15p32+AmKNuRHrhZ8GFVQ0/z4OzKfVBfru70+9f6iAJ1cuj2j9lEjzJlBk
	 Tth44pBkzcKf4cKV70kWiTNdrEa8GKdLBU33U9NKRK4iN10V04dt8AU7fsRuMcBug7
	 FDWgwmdpmuT+LOWipQYPMLwrF3P0f8AnwyAXa5vCccmeXVUQXysGz4h21aHzjud4cT
	 6dj3lwH3zItV2oCyhoBbrq7hyzNHOK2ui7WlexJrnL8/giVuuAx86m8e5NrHDgKsxG
	 +r+35tfMaN0q6K/zg9FOUr4mg2j3uSn/9L7BWjZXRu4+wCzBDHbWXBNKHOY8u5F8Rr
	 w3+avppnMpB+g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+01eb26848144516e7f0a@syzkaller.appspotmail.com,
	jiri@resnulli.us,
	saeedm@nvidia.com
Subject: [PATCH net-next] netlink: fix policy dump for int with validation callback
Date: Fri,  9 May 2025 14:27:51 -0700
Message-ID: <20250509212751.1905149-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent devlink change added validation of an integer value
via NLA_POLICY_VALIDATE_FN, for sparse enums. Handle this
in policy dump. We can't extract any info out of the callback,
so report only the type.

Fixes: 429ac6211494 ("devlink: define enum for attr types of dynamic attributes")
Reported-by: syzbot+01eb26848144516e7f0a@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
CC: saeedm@nvidia.com
---
 include/net/netlink.h | 6 ++++++
 net/netlink/policy.c  | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 82e07e272290..90a560dc167a 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -321,7 +321,13 @@ enum nla_policy_validation {
  *    All other            Unused - but note that it's a union
  *
  * Meaning of `validate' field, use via NLA_POLICY_VALIDATE_FN:
+ *    NLA_U8, NLA_U16,
+ *    NLA_U32, NLA_U64,
+ *    NLA_S8, NLA_S16,
+ *    NLA_S32, NLA_S64,
+ *    NLA_MSECS,
  *    NLA_BINARY           Validation function called for the attribute.
+ *
  *    All other            Unused - but note that it's a union
  *
  * Example:
diff --git a/net/netlink/policy.c b/net/netlink/policy.c
index 1f8909c16f14..99458da6be32 100644
--- a/net/netlink/policy.c
+++ b/net/netlink/policy.c
@@ -311,6 +311,8 @@ __netlink_policy_dump_write_attr(struct netlink_policy_dump_state *state,
 					      NL_POLICY_TYPE_ATTR_PAD))
 				goto nla_put_failure;
 			break;
+		} else if (pt->validation_type == NLA_VALIDATE_FUNCTION) {
+			break;
 		}
 
 		nla_get_range_unsigned(pt, &range);
@@ -340,6 +342,9 @@ __netlink_policy_dump_write_attr(struct netlink_policy_dump_state *state,
 		else
 			type = NL_ATTR_TYPE_SINT;
 
+		if (pt->validation_type == NLA_VALIDATE_FUNCTION)
+			break;
+
 		nla_get_range_signed(pt, &range);
 
 		if (nla_put_s64(skb, NL_POLICY_TYPE_ATTR_MIN_VALUE_S,
-- 
2.49.0


