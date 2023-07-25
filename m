Return-Path: <netdev+bounces-20991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C5876217C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174791C21011
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986D263B2;
	Tue, 25 Jul 2023 18:35:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C72416D;
	Tue, 25 Jul 2023 18:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7F5C43391;
	Tue, 25 Jul 2023 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690310099;
	bh=CeGxhrvZHThEsyTOEnPxSmGBdhmosALuz9k50d2C/S8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kvfz9Lp36y6TgtEnpT2UiDb2SVPbspS7uCWkLDYO4E+KJQxrTWqGIcXNBmQPivAWM
	 ziBT5ndTF+PXxGJ6xGn/A5R7909d5ZniwH7c2B2y06vvIBwo0SS4LtR9r5FqRR2Rrs
	 7q4LwCalSL0ts65kEPAgKyRR6lOv8MWevy5AbSYuo9g40G85HHbvcCP/BziFw7rHOe
	 lBqjRRWbJ9z53w3kvjIbAnDOPxnEaCyTkS9dILyAO09CSGzIPCnEqkIT41shFRPwQt
	 rjxg2ASmURXM4YPKcKZGX+tAPWtkX0s0pfqKgB056+fG9osNz9NX/mrKH4V9GzAcwh
	 uvWg1CkfBNMeQ==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 25 Jul 2023 11:34:56 -0700
Subject: [PATCH net 2/2] mptcp: more accurate NL event generation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-send-net-20230725-v1-2-6f60fe7137a9@kernel.org>
References: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
In-Reply-To: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geliang Tang <geliang.tang@suse.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

From: Paolo Abeni <pabeni@redhat.com>

Currently the mptcp code generate a "new listener" event even
if the actual listen() syscall fails. Address the issue moving
the event generation call under the successful branch.

Fixes: f8c9dfbd875b ("mptcp: add pm listener events")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3613489eb6e3..3317d1cca156 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3723,10 +3723,9 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	if (!err) {
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 		mptcp_copy_inaddrs(sk, ssock->sk);
+		mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
 	}
 
-	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
-
 unlock:
 	release_sock(sk);
 	return err;

-- 
2.41.0


