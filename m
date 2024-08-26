Return-Path: <netdev+bounces-121789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4159995EB36
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 10:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9F3B22A9A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F52A143726;
	Mon, 26 Aug 2024 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kcrnipcX"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D4813EFF3;
	Mon, 26 Aug 2024 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658839; cv=none; b=HpxE+pImZeQ4R2uol0XBBaje2HiAVNhCCzX7XYsN/AeED553J1g3i4vCxG+uJ0Ns7UyZeMt3ZEr/ixIZJI6QEXvWnp6Z+s859IaGPXhO8CD/4Cpk2tTM5k1Prd0uiApipuUloUDnEm4qMdMxwOpKAvAi8URjS4OsZyBOs1cogRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658839; c=relaxed/simple;
	bh=/upxQZ7Sx8UT5zkENbL8iXck0iH/AKtTxcQdjNMMuxs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UNrTEOsyvqapH1XFV9oSeVEtBgtsutPjo/Uz3Y9sZvaAIaJrXyITWkBnianfrY/dDO9y7E0kKaTGc+xxuy7RQOlBuwcWZVSv4/bOFpqOnUgu6R/1Y52VwgabpqtzVRNWgSUL4Q99DN+VlnwnnruDl857sTJk1jIgt8ImCdjEpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kcrnipcX; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724658834; bh=oCAK+AeRh+UjThNu95QJgjgOIPjcluclamZIa6pai4o=;
	h=From:To:Cc:Subject:Date;
	b=kcrnipcX4ZCC0+OlfaazIvO4NSALB6mGr5SaljwhW72ElfNocCKWaGHhiIkjsBYZP
	 2Anv4Z/B7u7FvbJf6rOkPQb+nK5FHNQ3ulT8pJyQc7Yu8NgmEV2xKKWJHtc7QzDjFn
	 wnRD3RQ+L4a5kD1YOfbJwJbMyVoYE2Va1AOp12qk=
Received: from localhost.localdomain ([112.64.14.141])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 8FA126AE; Mon, 26 Aug 2024 15:35:58 +0800
X-QQ-mid: xmsmtpt1724657758txumro6zf
Message-ID: <tencent_155F5603C098FE823F48F8918122C3783107@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GhqgeDlXWbzugTdURPWbmQLWpGhtZoceyG/DPYJABgOhjVL5BRs
	 NWW33nwbEa5uJ1huxF/3MrYdsB79DzwSWNZUf1kTzD4O7AwFoVhlXjsIjkt8Re4y4ghVs5iBNQuI
	 J5GsSFCAELHghpXKXuUBmfOBqo2zBdI0TUJ6VaSkxwZzPh/56i3mZ3r7Taky+KJPYvMzhKVB/FYA
	 drbyFfCxG9VPc1f+wnpUPdPxCgGnMKMJxnMkblJ7/YzDnff3BsGs4NTc+KdHb6x96MjDT4BxBtIU
	 ob+eUFlKTW6NF/DNHp9f78rzub/JBVltOkwYHzW3GnVihd6PingYNFAmFD+1KkIS41Y2E2Purce2
	 pQTzd8SzWQcw2I+Gv+AJWGTVpbQ8MpZFW3DmuS9iTfOxGIBwiqX/LvSc4lkdHnexeD9V3G4WnYJT
	 ef7kwYAVLfkFodrerU8OhVjxAgZesYsInGmz/q743NC0U4ejSdL66mbtUqgssFiY6DXS7M4Cxk1z
	 AyUzjfEdTrso8nXq5mLzQPNtIKcclFJl2BOynvDuqdT3fO1k2dGLi2HxZDW2dagn3dv0dK7ZAOBB
	 Vo5kYtYZgo+UOlLM07jnkoeZ0N7zm70NucijyH86Gn/3Wu5bxkAukHj4jGFFMCSOVVav41ynewjn
	 RWbLx7jeDNz8CZsircQnG95LDY9KsxyKKq2i9TiiwShMBDMhCVEdT/dBd6IQwbbKEvqz+8P9Caac
	 ATBnQTMEjlHau6f4OJzFIE/sw3Ixcv48Rs7/j/8i8IOH3V0kbHXVz8dHB8Bs5xc2ztnUVJg3IbeN
	 wQmrZfjPI97J2ceMFEpIasQdcDjkyZ3MFaCotQcn35MZFiCzyLPHLxut/9s/RmF7llrqxqyfWXFy
	 VanrdLuqAkr32pPFfWAofuS0MQdlINKBXeq9Vnre3KUmqU5ThpGWDqGlN5IVNzIiBckFhuoaKxz0
	 EyPCJoqEvUAe1+ceaUP+reFYxsmpAWl/GGIIrHLdaDCc2mvkXblDAlFLsdPANe
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: jiping huang <huangjiping95@qq.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiping huang <huangjiping95@qq.com>
Subject: [PATCH] net: Remove a local variable with the same name as the parameter.
Date: Mon, 26 Aug 2024 15:35:51 +0800
X-OQ-MSGID: <20240826073551.2212-1-huangjiping95@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to use an additional local avariable to get rtmsg.flags,
and this variable has the same name as the function argument.

Signed-off-by: jiping huang <huangjiping95@qq.com>

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f669da98d11d..0d69267c9971 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1830,12 +1830,10 @@ int fib_dump_info(struct sk_buff *skb, u32 portid, u32 seq, int event,
 
 	if (nhs == 1) {
 		const struct fib_nh_common *nhc = fib_info_nhc(fi, 0);
-		unsigned char flags = 0;
 
-		if (fib_nexthop_info(skb, nhc, AF_INET, &flags, false) < 0)
+		if (fib_nexthop_info(skb, nhc, AF_INET, &rtm->rtm_flags, false) < 0)
 			goto nla_put_failure;
 
-		rtm->rtm_flags = flags;
 #ifdef CONFIG_IP_ROUTE_CLASSID
 		if (nhc->nhc_family == AF_INET) {
 			struct fib_nh *nh;
-- 
2.34.1


