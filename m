Return-Path: <netdev+bounces-32617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA2798C63
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B87E280DE9
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892B114A9C;
	Fri,  8 Sep 2023 18:14:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523E14F62
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB19C116A8;
	Fri,  8 Sep 2023 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694196854;
	bh=QXXPdGa/Mfp8PMKnT6sIReUyTRkewtRVNgYn3VanRYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7cwEgpWbXcaOkbSaNZf1FWI7zSQl4DeR9rOJ6cejy/QQ+BiA7ktquKnZHAgeCLVo
	 NLmJdhZOimQNuClxLNpkGLfi0u//4dH15As++BsIy6RB0SIAa6TcoVhOmHQwFoixdD
	 BTx+e8gkB9lhWpjCgsWtrimIJEfWOnxkJiDtYi0eFVZg1TzbCXGwMnEWcQqGYaYVzr
	 32zZ5erUIRZmTAYzrltCoux9zeJ/ubu9iJjoXrXOsshuzgDNX32UZOMR/JIIvzk+IX
	 8RZDd2SWcfWqAmdqIandiUEQbZfXspfG/4iPf9QYssVHYHbPYZQqWj2cpg/ADqECNh
	 CQjxgxBkzN9nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexander@mihalicyn.com,
	leitao@debian.org,
	lucien.xin@gmail.com,
	dhowells@redhat.com,
	kernelxing@tencent.com,
	andriy.shevchenko@linux.intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 15/45] net: Use sockaddr_storage for getsockopt(SO_PEERNAME).
Date: Fri,  8 Sep 2023 14:12:56 -0400
Message-Id: <20230908181327.3459042-15-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 8936bf53a091ad6a34b480c22002f1cb2422ab38 ]

Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") started
applying strict rules to standard string functions.

It does not work well with conventional socket code around each protocol-
specific sockaddr_XXX struct, which is cast from sockaddr_storage and has
a bigger size than fortified functions expect.  See these commits:

 commit 06d4c8a80836 ("af_unix: Fix fortify_panic() in unix_bind_bsd().")
 commit ecb4534b6a1c ("af_unix: Terminate sun_path when bind()ing pathname socket.")
 commit a0ade8404c3b ("af_packet: Fix warning of fortified memcpy() in packet_getname().")

We must cast the protocol-specific address back to sockaddr_storage
to call such functions.

However, in the case of getsockaddr(SO_PEERNAME), the rationale is a bit
unclear as the buffer is defined by char[128] which is the same size as
sockaddr_storage.

Let's use sockaddr_storage explicitly.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index c9cffb7acbeae..a80b6b8633edc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1823,14 +1823,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_PEERNAME:
 	{
-		char address[128];
+		struct sockaddr_storage address;
 
-		lv = sock->ops->getname(sock, (struct sockaddr *)address, 2);
+		lv = sock->ops->getname(sock, (struct sockaddr *)&address, 2);
 		if (lv < 0)
 			return -ENOTCONN;
 		if (lv < len)
 			return -EINVAL;
-		if (copy_to_sockptr(optval, address, len))
+		if (copy_to_sockptr(optval, &address, len))
 			return -EFAULT;
 		goto lenout;
 	}
-- 
2.40.1


