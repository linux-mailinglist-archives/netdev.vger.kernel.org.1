Return-Path: <netdev+bounces-94618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F648C000E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66EB1C23365
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D30486647;
	Wed,  8 May 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="QTCGbw4b"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61DC8625B;
	Wed,  8 May 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178878; cv=none; b=YdfvjXYaIm9aEvJBCh+xs6VjzLfKSBu+nIr+vrdCQp6ErbMimtLmKv0mIMjWL/b9FkzauAscKtkWfKIkZJjqNPNVpqckJ5Wh775YZbH/JyZJUeAkGv5F9+Kbhaw1HaiYrapiKJqIw5yxYwJ9KotwIIoOTG14yB7G0srcJUUStws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178878; c=relaxed/simple;
	bh=Mf879ORHeiN78yZ0qbPSxvvQFKSWRXMy6QgOVWZGZ/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SieUqlU6vcTg4s/9JYcBZkn8qLvAxcgZ3WCgLKuEiBkEkSpzRAbtkHIYIAbVzzeiZPRxOU3XsYGSikoLxacoSnjfv+NKcM1HJ7bx0jH+xUQ8zduz/nq2MPEluniSioofslR5/SvP4fSGFr5/n+5ibdrxYvtUBYJwsKOKsWSwvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=QTCGbw4b; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A436660136;
	Wed,  8 May 2024 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178869;
	bh=Mf879ORHeiN78yZ0qbPSxvvQFKSWRXMy6QgOVWZGZ/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTCGbw4bvuLg9MKqflYo3aHGsy2DeGhJ3t0g4pRplys3Mth9ORPabssqgjv1iAKyF
	 nqW9j/1XAVR+YaSy3eN6Hgs6dIpARAuPzaTDGXoT9qEQ6nKC4x2xWw/ch+r0uP0XcX
	 GARYYaTVP3OZa5MRy6f/OvOj//W2QrUjOyfws0xpHUc9v7DMUOe2FYe/KwUsEPHbWE
	 PyaMoblQWYSeLCIfOBWTdR1jvp9krSJCqButNpC04hNA4zlRvYAiLCIfOWjrbfXCrd
	 CwpKFKKVWjuK788o53s9sawCKYkNb0rqkqFGYX0H4llZYw/u4hmZ1ZQCHLo8mPGXeQ
	 skf8LEK9DPV7w==
Received: by x201s (Postfix, from userid 1000)
	id 6AA1C20912B; Wed, 08 May 2024 14:34:07 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 13/14] net: qede: propagate extack through qede_flow_spec_validate()
Date: Wed,  8 May 2024 14:34:01 +0000
Message-ID: <20240508143404.95901-14-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508143404.95901-1-ast@fiberby.net>
References: <20240508143404.95901-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Pass extack to qede_flow_spec_validate() when called in
qede_flow_spec_to_rule().

Pass extack to qede_parse_actions().

Not converting qede_flow_spec_validate() to use extack for
errors, as it's only called from qede_flow_spec_to_rule(),
where extack is faked into a DP_NOTICE anyway, so opting to
keep DP_VERBOSE/DP_NOTICE usage.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index b83432744a03..e616855d8891 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1953,7 +1953,8 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 static int qede_flow_spec_validate(struct qede_dev *edev,
 				   struct flow_action *flow_action,
 				   struct qede_arfs_tuple *t,
-				   __u32 location)
+				   __u32 location,
+				   struct netlink_ext_ack *extack)
 {
 	int err;
 
@@ -1977,7 +1978,7 @@ static int qede_flow_spec_validate(struct qede_dev *edev,
 		return -EINVAL;
 	}
 
-	err = qede_parse_actions(edev, flow_action, NULL);
+	err = qede_parse_actions(edev, flow_action, extack);
 	if (err)
 		return err;
 
@@ -2024,7 +2025,7 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 
 	/* Make sure location is valid and filter isn't already set */
 	err = qede_flow_spec_validate(edev, &flow->rule->action, t,
-				      fs->location);
+				      fs->location, &extack);
 err_out:
 	if (extack._msg)
 		DP_NOTICE(edev, "%s\n", extack._msg);
-- 
2.43.0


