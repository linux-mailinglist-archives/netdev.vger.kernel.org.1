Return-Path: <netdev+bounces-144629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5F89C7F73
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821E1282EAF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE802B65C;
	Thu, 14 Nov 2024 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY2gLPOc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF2290F;
	Thu, 14 Nov 2024 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545120; cv=none; b=poFVlaJUX2mUmwBQfQ9F1AB1PDOev+ZNUCbJM1Y2X+5Y8XkT76b1s2uUsMyCbHsqo5wPtaPXDqN78mxdJVwEchERJblRsbuDA1E/tiecCfB2gzfpkDREDmyIBaVqUuZ0v7c9DRRbOjNweXoTWVJ88awJu+WhLbn9f1ufWhVWmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545120; c=relaxed/simple;
	bh=V+XXfhEkvHfR6e89cFcF1vtYbOUwNwxHLg1uy1YL46w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AGSd9v/BLUSuqKJFemuMOKNZXLl22QNyECen0CEMGENKa0+WgSXlRmiALspkif8jqKbEGAPY+SNQdczrLI4PG93aSVCJPCpwSfXnizV6C8BJhYW2QC5bSdPu2xqI9jF+CBW/O12WNhFK2I/Vx1AAkSVLg9CmAxUwpPg4lR+EFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY2gLPOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2359AC4CECD;
	Thu, 14 Nov 2024 00:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731545120;
	bh=V+XXfhEkvHfR6e89cFcF1vtYbOUwNwxHLg1uy1YL46w=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZY2gLPOck9c6v4f1uALRq9nAl7hKtupr74YwzwGBnRiza1NqWvzixIqMHU/nrsN0g
	 0qbAY2PqsGi5EEDKM5pltT8MC1UF091TFn7P2RHF8igLRphWJWX/CWZuX9Lz1frYLg
	 6iKaAwx9ZT9ugCwrpeV/OHowYjr7NUDI9L/d3obz7zXvBN+hKiQha/JJgL4NlzN4CE
	 zUEvnmxobkiY+MyXlI4WlV3Z4WIfgZdOpmXX4n40oD84/3oK/DGz0/TXm9svNAdV9p
	 UvVL6CVzS9pLKPR933GlZAhSsFn/FZYmueLkQZ1BE2fzuDXZ2T2ATs4snyThOK7K9h
	 AjpqFjJ1BWojA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136CAD637CF;
	Thu, 14 Nov 2024 00:45:20 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Thu, 14 Nov 2024 06:15:15 +0530
Subject: [PATCH net v2] netlink: Add string check in netlink_ack_tlv_fill
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-fix-netlink_ack_tlv_fill-v2-1-affdfb5f4c6f@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIABpINWcC/4WNWwqDMBBFtyLz3UgnRq1+dR9FJM2jDoZYkhBax
 L03uIF+3te5O0QTyEQYqx2CyRRp80XwSwVqkf5lGOmigV+5QETBLH2YN8mRX2ep1jm5PFtyjqH
 Qz6bprG6xhTJ/B1O6J/oBZQFTMReKaQvf8y7jGf0nZ2TIRN8PN2mFVEN3J6Kka6lq8jAdx/ED+
 MjqGccAAAA=
X-Change-ID: 20241114-fix-netlink_ack_tlv_fill-14db336fd515
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com, 
 Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731545118; l=1451;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=NtyokQuE+L7LfwkDaBwq3Oyce2jW67JcMuZbTIVPJTg=;
 b=Aa9G7PxjtwSy3lJ8NJDyNdVyeYBEc1b4xSaFHymXyNF9Dk5P3D7APXdA6KEZxnrriq5Uosx+8
 n6w8FhIucjYCBapw5g//T8cnQMaV6Fyy0APxrS0kJW4wnLsXNuVEsKA
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

netlink_ack_tlv_fill crashes when in_skb->data is an empty string. This
adds a check to prevent it.

Reported-by: syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4373fa8042c06cefa84
Fixes: 652332e3f1d6 ("netlink: move extack writing helpers")
Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
Changes in v2:
- Add target tree and prefix in commit message
- Add Fixes tag
- Remove duplicate commit message from cover letter
- Link to v1: https://lore.kernel.org/r/20241114-fix-netlink_ack_tlv_fill-v1-1-47798af4ac96@iiitd.ac.in
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0a9287fadb47a2afaf0babe675738bc43051c5a7..ea205a4f81e9755a229d46a7e617ce0c090fe5e3 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2205,7 +2205,7 @@ netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
 	if (!err)
 		return;
 
-	if (extack->bad_attr &&
+	if (extack->bad_attr && strlen(in_skb->data) &&
 	    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
 		     (u8 *)extack->bad_attr >= in_skb->data + in_skb->len))
 		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,

---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241114-fix-netlink_ack_tlv_fill-14db336fd515

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>



