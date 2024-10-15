Return-Path: <netdev+bounces-135744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C30499F0B7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FE31C2160A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02931CB9FF;
	Tue, 15 Oct 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9D4xRLc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DED1CB9E4;
	Tue, 15 Oct 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005050; cv=none; b=fa7CmM3wvQC8fK7YBxRySxrMRJl34nK5VA1ffoWz4zlaF50OTlomWB2SHKmvLdkPglcCpiYIAUKZHTnzGbQBN8FEsD3jdbnqYEmG/hvrnsscOekWJw56wDkQGJmOzXxpfYfxzpAXTUtw2p3ZVUS5TB2uPIV6LSch86D7FB24SyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005050; c=relaxed/simple;
	bh=8VFFvLazsustdz1TBciFvH0PiX8Ax+cVNvj1eLkfwrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u/vdTYaIBa8PzmZ5SXOQhsQoXv6rWCOqYt8K+PrSjUQKyqwGNNQeAMHEpWZxpzmfDdEJ5TlvIC/xFPO8byD3xByM53xj47ykZRgf3Mh4Qu+/ugu4UCWFiz70jjl+ypRI/NOZyL58nWw+BvA8HQPAijuYg+SxV2eEr+G5q8XXjYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9D4xRLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800A5C4CECD;
	Tue, 15 Oct 2024 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729005050;
	bh=8VFFvLazsustdz1TBciFvH0PiX8Ax+cVNvj1eLkfwrA=;
	h=From:To:Cc:Subject:Date:From;
	b=a9D4xRLcm0kgsLf9MvZfBKTAKO6d/kIfzM+tCQ3KEOnSwoKCplGig2+gdd+KjGDD/
	 DSZQZ8EFVElrSJ3oxeITMjzWzk+5j/QeBAv7bXJqPD/6lDWhTWv9vCsncf5U0XJfbj
	 l5GlYM2fbO6LGFlam3M/ODoxJViP5X7IHhu+3h6qQ7K9+jj0GXv+yApXSWSjLJZeJA
	 Df3EYDP6Cj3nyI8Ml5sRbaSsPvzmF9YlXrmIRWBYZr+LvfXwf8MW2JbbINuFDmBF1E
	 yPbE1KAFhW+mpKu74gHsZreTXpnCTR4afI0Wfx312Xm6H8DL+UcJD+dDSmWpCdtIvZ
	 GQMo+NCu0/31Q==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtnetlink: wire up rtnl_net_debug_exit
Date: Tue, 15 Oct 2024 15:10:36 +0000
Message-Id: <20241015151045.2353801-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The function is never called, but causes a build warning:

net/core/rtnl_net_debug.c:125:20: error: 'rtnl_net_debug_exit' defined but not used [-Werror=unused-function]
  125 | static void __exit rtnl_net_debug_exit(void)
      |                    ^~~~~~~~~~~~~~~~~~~
WARNING: modpost: vmlinux: section mismatch in reference: rtnl_net_debug_exit+0x1c (section: .exit.text) -> rtnl_net_debug_net_ops (section: .init.data)

Use this as the exitcall as was clearly intended and remove the __net_initdata
annotation on rtnl_net_debug_net_ops to ensure the structure remains there.

Fixes: 03fa53485659 ("rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/core/rtnl_net_debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnl_net_debug.c b/net/core/rtnl_net_debug.c
index e90a32242e22..efb8a5bc9ee4 100644
--- a/net/core/rtnl_net_debug.c
+++ b/net/core/rtnl_net_debug.c
@@ -96,7 +96,7 @@ static void __net_exit rtnl_net_debug_net_exit(struct net *net)
 	unregister_netdevice_notifier_net(net, nb);
 }
 
-static struct pernet_operations rtnl_net_debug_net_ops __net_initdata = {
+static struct pernet_operations rtnl_net_debug_net_ops = {
 	.init = rtnl_net_debug_net_init,
 	.exit = rtnl_net_debug_net_exit,
 	.id = &rtnl_net_debug_net_id,
@@ -121,11 +121,11 @@ static int __init rtnl_net_debug_init(void)
 
 	return ret;
 }
+subsys_initcall(rtnl_net_debug_init);
 
 static void __exit rtnl_net_debug_exit(void)
 {
 	unregister_netdevice_notifier(&rtnl_net_debug_block);
 	unregister_pernet_device(&rtnl_net_debug_net_ops);
 }
-
-subsys_initcall(rtnl_net_debug_init);
+module_exit(rtnl_net_debug_exit);
-- 
2.39.5


