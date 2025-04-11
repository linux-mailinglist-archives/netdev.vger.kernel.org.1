Return-Path: <netdev+bounces-181491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA55A852DB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461767ABFC7
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC83327CCE6;
	Fri, 11 Apr 2025 05:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B621/crY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8B27CCD7;
	Fri, 11 Apr 2025 05:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744348005; cv=none; b=pdaTZnO89+9hkLatMH0faeKwReeqrT82KOUzOPlt7ZiqYbSh4DtkOEtwmOgWc3Hdzvo/8mrX8YcA/T6wc9mE4EgCfySjU06RmM7qNthvKELu7ysMrHH7bbF4OC/EXEsh+xSza3gAigrHmyN/IAuIPuzCXGZ3yZQBacyAquC74w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744348005; c=relaxed/simple;
	bh=ph9yxNJxjytif7MW6JGpN2VeP3cdtJrpIHatp3pjQx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lK0S9FWxRn+ujO5wvGc8hqoFSm21Xw88L+VT5YE++OKshlv7gLYAgY+tf4cq0AAaiSa5NKz2uiuGJg5+GG/wRY/F3AWobG02CVyr0Phr+UVKdEoZrqqsnkDO9c+Rbl6/zU9XnRCJokJQDtP6o1Q4DCrL/vbtFCu3OE5XFOX81T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B621/crY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7370a2d1981so1236500b3a.2;
        Thu, 10 Apr 2025 22:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744348003; x=1744952803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5UnJapsshMAFNTg0PJpSBNJuS/1ozPTcqpFD6vI6lxo=;
        b=B621/crYDeWP4HAetCsiXYcpu6+oOu1Y9mDyMskKgrOZCuOjrsExVTb4ozbUfG4IqJ
         i9F7xeHav0C3ASIN4jSMBIVbAcKNBXUYyNh/HbTxC24fyL+Mi80/l1VybDQripC+4PlT
         DLpsQYGlDcnrtbimuQlS8ZrJL828TljtMhdEB17+3WDM0FxI2gvwRbSQEK+NALpgbnXR
         5tqHGjr59vstvSaRDd26y9B4TYsnCeZt8v4AZtQEvHDe03d08XolomdCTEWKWtnGZUdB
         709rgkXqUs6R8Op184ntlEoiufxp1XNHXT5DiYeaxgaMqJA9eM3oZlQpXCoYkEFvRl2+
         brMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744348003; x=1744952803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UnJapsshMAFNTg0PJpSBNJuS/1ozPTcqpFD6vI6lxo=;
        b=XFqhnO56fc0xMlYCxQqdtA7d1KdIk4PdEARbKSbVREelOHQJs2Mt/c5Fp4YM1Um3QT
         JjHvZW86nLEyZ+VUl4O71rHskVjeZLZWHngwm52xlWqYkvcCIIbhqz+ccPjPgfOY/HnR
         gbI6fRaEPgFi4viEl3CT/NcZFNuXmlJFB05FwhIM/HVpdiq5C0vJpCbIF3Fkzv8QIQYn
         r3OwBZiL9NSelkB5PZDYQOMu2JxoFHQgfeeNVa2SnqBmSZwCQnCRY1piu2PwuIfsMxXI
         F81nzdbb/NLsMFeeuny8WiWPPyTQtlMJ/yyqSPGQYGHs96VnX/eA9+9PHKEvwOEJKBMA
         BU8A==
X-Forwarded-Encrypted: i=1; AJvYcCU+ms2j0LfyG456zhqIv6Cs7xfWDWU6bU3raA8mvGq/65XP6vsZ0JKGHRZzTrTNVXwcxsC37RcZ/xFbbeE=@vger.kernel.org, AJvYcCWghIuCVhwTNJo5lVRngaAdaylnt6ik8pjOwZkagxcL1T1cZGHH7cBfJ4tDh80bj5mXCTkQ3nlp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/UtTgbMkDXNmIzEd+TrG/D1W9Sg/hcHBUHI7p64PV4XQQN8c
	g/mz9+oC3RAdOI7PgkQT95VkVKYbMsKqVM7jNEB5dwjY1ueiK4ku7SDduZ15Q1k=
X-Gm-Gg: ASbGncvil4YGlfBIz6J11uN21FZNBE6lmOEVcGaMWYtXOfKjGYrRADah24MSniyVMGc
	ilPcVP+tuLaD2MrF9ZeWbA4u2l4mJliSXRbxq9aDFNb4hmndRzx9nyW9mjh6oxhXKpbL490vrZh
	GSLWU/ZCY7wS1RqDlle7jVYDMQ8UKysvwj5I7VLtsFvXAJc9xEwh2irUPI6aavoF6bbUpS0gwpA
	pQt6a2fIRda12wCkCyoECOdXD4jFcApwR4wIUyHtOxZB9RWvUpDSsh6oyX8u8rP9yHsIg9OQz0E
	QyDXEB2j6rSmNahC2XB0Llr6WacFEKlU7kEttF7sHvZRFHHe3YT5OVariaQ=
X-Google-Smtp-Source: AGHT+IGLIi/7HyMpkoEks+uXZ/UWMvLn9AKsYBa2512q1PEkAkv3NJRwEgNHcO1lAPn2wY8N9VWyfQ==
X-Received: by 2002:a05:6a00:a8e:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-73bd12a1937mr1899353b3a.21.1744348003106;
        Thu, 10 Apr 2025 22:06:43 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:4fe1:c798:5bf3:ef7a:ab5:388f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230da87sm525712b3a.127.2025.04.10.22.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 22:06:42 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: jmaloy@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	kevinpaul468@gmail.com
Subject: [PATCH] Removing deprecated strncpy()
Date: Fri, 11 Apr 2025 10:36:13 +0530
Message-Id: <20250411050613.10550-1-kevinpaul468@gmail.com>
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
The strncpy() fails to guarntee NULL termination,
The function adds zero pads which isn't really convenient for short strings
as it may cause performce issues

strscpy() is a preffered replacement because
it overcomes the limitations of strncpy mentioned above

Compile Tested

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 net/tipc/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


