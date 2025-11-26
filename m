Return-Path: <netdev+bounces-242089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 599B2C8C290
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 117664E52B0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1333F8D9;
	Wed, 26 Nov 2025 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="stGyVsFn"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9233FE03
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194920; cv=none; b=aIakFRh3ssk2uZ1MHcv6ZBU3WlxbbzTRg96vgbd1J/e5J73DOE9EBAu9H3A2f4K6SKCkstBcATyDx3a37mPcjnQMBvDm4L5sG1mgx93imYFlnkmQgh0Wsu+lDkZfozm0GkkC7JEQZP738l3R4gJDw2+ArkvAsUBO0kaeRWMgkqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194920; c=relaxed/simple;
	bh=0IfWLNUcsz19oellpUkIA+gy1/IqfDvXxC4vSe6yuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qwpa938/lqB3FgsC4x7y6WANw3DFMUYUvbusTn5zylhOUrhh1Fyh5iqQwAimPIjP5AG+0eefunHuFHAL9LfLSyUBkKDBVYS9KytvJ8wkt59P2JAYDtWH1Sp5ynPlYILca+QxHFtPPkX4LreeSshMKYMwcvzRFrwaQDoKO6oru9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=stGyVsFn; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764194915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bwQ1V5HM+PRmRRY2kwdC1ABNayKu18UgYBDDHCXbeY0=;
	b=stGyVsFnqTrTlNzlpWnYjzruCr8UyRINPklF4UilrT/RKG/SGPp7CBDRHjeMPopXsvtXu2
	/FBcCYuvy6cQyUh3kxU0CfylaxMORzeLUOAmJLteWUVtudHFyvTQNX7aSPD4axqAbP6yHT
	CEU4FU1bFQzGTLk4OAuj8uhFUrNrNyc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: david laight <david.laight@runbox.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: ipconfig: Replace strncpy with strscpy in ic_proto_name
Date: Wed, 26 Nov 2025 23:08:05 +0100
Message-ID: <20251126220804.102160-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated [1] for NUL-terminated destination buffers
because it does not guarantee NUL termination. Replace it with strscpy()
to ensure the destination buffer is always NUL-terminated and to avoid
any additional NUL padding.

Although the identifier buffer has 252 usable bytes, strncpy() copied
only up to 251 bytes to the zero-initialized buffer, relying on the last
byte to act as an implicit NUL terminator. Switching to strscpy() avoids
this implicit behavior and does not use magic numbers.

The source string is also NUL-terminated and satisfies the
__must_be_cstr() requirement of strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use strscpy() to avoid unnecessary padding (David)
- Update patch title and description accordingly
- Link to v1: https://lore.kernel.org/lkml/20251126111358.64846-1-thorsten.blum@linux.dev/
---
 net/ipv4/ipconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 22a7889876c1..019408d3ca2c 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1690,7 +1690,8 @@ static int __init ic_proto_name(char *name)
 			*v = 0;
 			if (kstrtou8(client_id, 0, dhcp_client_identifier))
 				pr_debug("DHCP: Invalid client identifier type\n");
-			strncpy(dhcp_client_identifier + 1, v + 1, 251);
+			strscpy(dhcp_client_identifier + 1, v + 1,
+				sizeof(dhcp_client_identifier) - 1);
 			*v = ',';
 		}
 		return 1;
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


