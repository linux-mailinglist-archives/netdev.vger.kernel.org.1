Return-Path: <netdev+bounces-181501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5DAA853F5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68007AD92B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD0227CCFB;
	Fri, 11 Apr 2025 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrNxE96D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794327CCE4;
	Fri, 11 Apr 2025 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351736; cv=none; b=BTNFPHuo7hmPEk0VBpmDtvjHzOTkgOZTIYIigDyhiqveEs85owaqUKKtHPAwYyHEupXLKp5C1aUqjAQV6N1i99FRaOdG2/kP+srQsLGVOKS3TO4GQGWzY/cyAFkC5OdOQhhgF+tO/xiLZmO8lw7RQViVBMJaU87KPb1OXApzoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351736; c=relaxed/simple;
	bh=WouuxWKXIXaHJdNjkcZzsFrXBb+9BPzw8tsW2/aQSNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lTcHrJrlN+FqawCqX8TJoE3A/MQfS/vAp0Ay07Sa1pdr+O3b+eM+fS54k0iS/GF4lgPq7jl71gKOtrAB2pUXEshf9LNHL4Fr2vHuRlU0Ns0rxIytdw/si8K46kz7xkSgojGF/ahCJS07fDoZR4XCGydVoPuhk971cDR8MGGOJsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrNxE96D; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376dd56eccso1782660b3a.0;
        Thu, 10 Apr 2025 23:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744351733; x=1744956533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=50hxH2EGQQWIvDNzL74QsMeOx3mDaobRYvxxKWb0q9Q=;
        b=lrNxE96Dl5eUCskhkwNLtSlN5/yQ9z3i6khD21hpZm+MetWk6qF+L1bFUioQFwZ5dH
         ceyuwsyAVT2fgUmg5u5wu/l1eegxNOp1/YbYjSt7E7wqvqSEtABiDjqA2RG6j6TLugiu
         tNeBCqGi9fGGfF136606uW5mi0Snbf3ahpqPhlRkodSDdhRUhF5nnZ3LknKWDwH5GKcs
         oRkP0dpQZbnw+5uEyHLNYVr3r7ndkZpXpKEzogpFGHQAVMA7iQFc5pzKj/lIgxASQwKD
         3bf1YyZCsXPp+N7Toq32hgIM+HKOReWnvPVtkuv2v4FBlS/7tE5HofFsaNcksnptoXVj
         o6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744351733; x=1744956533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50hxH2EGQQWIvDNzL74QsMeOx3mDaobRYvxxKWb0q9Q=;
        b=l35LO4uRkIkSc6oZQ659QT5Aq/JXeeOzpxWpZDZ4up6y0V0wpPKRWNQnflCAPCOOxE
         P4aXIXQjiy0rIO+7roVUMzgbfY11fPZZTND/xap0FidGCFW0Cv/JBTCcN4Nwg6l4TEwm
         37RM8Djr+hzy6UfAwV1EwOUQj2OV7jgZnuAdRIZLQwC6jReoXcRW5e8I/ZRy/4PRQrFl
         CAXSGj9S+SpRqwmeJoQ1wVd3vJ8f48rU+CjGk7Jy6XiNxfj9i/z+B/YmE/YFLYPSVEG9
         wiboeLAqjn8tUW9dUKWI6Nx7xnCxuH+TI50cYd1bhr36OQj/u/T+gAtMNaheS0Dgoogd
         oxDw==
X-Forwarded-Encrypted: i=1; AJvYcCW+xM3p2Jwu35QUpN7jmiCNoh6SwXOJH0M7JkWd+NNCbjkXua+ZhnEtXRe4cf5mVfUNx/s5R4/0@vger.kernel.org, AJvYcCXsdHk4ctVY6Js4mB5HCKkLcEYc2K+HLQxi5fWbwJ+ctW63nTgQU+JOo04rdt26+qEJQ2z8FkvQBi6RC1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEyDQxthUp0dnHz7LZ1ZggqUKap+0ElMwfWtutMEPAXNdoY1d
	s3XuPIaBALYkKFA2Fe257bSbIXHz1jZIWRVS2ft+Q0CM5NR/mUiQ
X-Gm-Gg: ASbGncuhxFA5cgpa5VHIRcyPWMDPY/Y4Qjk8edvZVim+wrZbhi7QolyX6Ygi9oJygdd
	eLjj1qdKUEcDfOQ3R4oSrfYzIdgfv9MGIHda/cCyYM+z+sL4NJ72a2yZimCBF/ILEkvKPF9o6Lq
	0HW3ZKXTyyYnhx0xlqzT5lgGr5sT7J3GMapUrcI4JsX6vi00wYqfniX8ukFcrkr5tjoBelgCMNv
	IlCDpJIxb6CEKw3om6nmjVxZIXTEtPIdvc1e+dcIDZkKUn5IkY+NTcQasNTpY/Wpb9wz7SxsRQW
	0iHi5pnRAgzOMuZD8t2Us+9HVfcM1g5YOk9qfu55soh4Ua9w6gpVlJ8s/hM=
X-Google-Smtp-Source: AGHT+IHHKmCThas9V8uvHhyBV40jdH5I/sNyIn7KwfblLgO395ERfwFGclBVoIOKeawjjUbdqv32+Q==
X-Received: by 2002:a05:6a00:b89:b0:736:562b:9a9c with SMTP id d2e1a72fcca58-73bd12b1a09mr2332868b3a.18.1744351732606;
        Thu, 10 Apr 2025 23:08:52 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:4fe1:c798:5bf3:ef7a:ab5:388f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21e0469sm647640b3a.79.2025.04.10.23.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 23:08:52 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	tung.quang.nguyen@est.tech
Cc: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
Subject: [PATCH net-next] Removing deprecated strncpy()
Date: Fri, 11 Apr 2025 11:37:54 +0530
Message-Id: <20250411060754.11955-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch suggests the replacement of strncpy with strscpy
as per Documentation/process/deprecated.
The strncpy() fails to guarantee NULL termination,
The function adds zero pads which isn't really convenient for short strings
as it may cause performance issues.

strscpy() is a preferred replacement because
it overcomes the limitations of strncpy mentioned above.

Compile Tested

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 net/tipc/link.c | 2 +-
 net/tipc/node.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 18be6ff4c3db..3ee44d731700 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -2228,7 +2228,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 			break;
 		if (msg_data_sz(hdr) < TIPC_MAX_IF_NAME)
 			break;
-		strncpy(if_name, data, TIPC_MAX_IF_NAME);
+		strscpy(if_name, data, TIPC_MAX_IF_NAME);
 
 		/* Update own tolerance if peer indicates a non-zero value */
 		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
diff --git a/net/tipc/node.c b/net/tipc/node.c
index ccf5e427f43e..cb43f2016a70 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1581,7 +1581,7 @@ int tipc_node_get_linkname(struct net *net, u32 bearer_id, u32 addr,
 	tipc_node_read_lock(node);
 	link = node->links[bearer_id].link;
 	if (link) {
-		strncpy(linkname, tipc_link_name(link), len);
+		strscpy(linkname, tipc_link_name(link), len);
 		err = 0;
 	}
 	tipc_node_read_unlock(node);
-- 
2.39.5


