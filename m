Return-Path: <netdev+bounces-76870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B684F86F3B3
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 06:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9326B230D0
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 05:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1479CC;
	Sun,  3 Mar 2024 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT4f5eCV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D4749C
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709443459; cv=none; b=XdYkrt7vfAyctKIo8q95tYxyWI1MKdKUnNCKHCPZzmSePENCgsGEY+OduZV5Fk5MQlpremozWVbOlugwQ0fFnOtm39af4dpNMwJCKDAkfJp4yVM7bn+e9LlvahiBlvYPNnja1OcXBmTURSnnNyFc5qYApUMAnqz+wwXYFSEz0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709443459; c=relaxed/simple;
	bh=HKnhDYflpFQSRl0hPluJ0n6u5DrST/DLWUBe0oiKsOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRKnmVAAsrTeEFXBwHQ00DjT37kekcha7cryEQXZ/3bCsRS6Saw4R8UxHu+GrdtDBzZazrSiqW6qvLhcIJvPdOVvbQyUS0OOuujJTH0tfNGMvaUwy1MXK+rx046Z1M4n1983P6kSbfjJtbeiIypKHwPKXx90npFTkW0bjOj5ARc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT4f5eCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96064C43390;
	Sun,  3 Mar 2024 05:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709443459;
	bh=HKnhDYflpFQSRl0hPluJ0n6u5DrST/DLWUBe0oiKsOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BT4f5eCVCA32CLBfY35FKpEeg5j8JDGmj12BLAkqpK707pm2+qCX4q9FOfZUS/7xv
	 p3wRRuK1GLJQWqE9GQsvV1ti1HwWmSpwR17kTaR+brt6yuj6XOaAwtnKHebC6cGM1n
	 BBdiM+kgDwi8RwPCJhjXxGVWAe5cflyFdQkwmnpCDOluqmqXVE0yASgvlvGcL1Eypt
	 Hd1/YWXzFpSWR9S3N9Ssj+NXdArNyFVtlA3fxrC+W2XlrqsdAaniWVz/v4HUgvGIhp
	 C2nrxqOo+oPgJ0IE4gzTkHkIRJzWuCJKMKntPDnUZstghXDAuBO4cC5wPPhfUxQxBu
	 LBFL9S6Oo4S4A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	idosch@idosch.org,
	johannes@sipsolutions.net,
	fw@strlen.de,
	pablo@netfilter.org,
	Jakub Kicinski <kuba@kernel.org>,
	kuniyu@amazon.com
Subject: [PATCH net-next v2 1/3] netlink: handle EMSGSIZE errors in the core
Date: Sat,  2 Mar 2024 21:24:06 -0800
Message-ID: <20240303052408.310064-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303052408.310064-1-kuba@kernel.org>
References: <20240303052408.310064-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eric points out that our current suggested way of handling
EMSGSIZE errors ((err == -EMSGSIZE) ? skb->len : err) will
break if we didn't fit even a single object into the buffer
provided by the user. This should not happen for well behaved
applications, but we can fix that, and free netlink families
from dealing with that completely by moving error handling
into the core.

Let's assume from now on that all EMSGSIZE errors in dumps are
because we run out of skb space. Families can now propagate
the error nla_put_*() etc generated and not worry about any
return value magic. If some family really wants to send EMSGSIZE
to user space, assuming it generates the same error on the next
dump iteration the skb->len should be 0, and user space should
still see the EMSGSIZE.

This should simplify families and prevent mistakes in return
values which lead to DONE being forced into a separate recv()
call as discovered by Ido some time ago.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: kuniyu@amazon.com
---
 net/netlink/af_netlink.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index ad7b645e3ae7..da846212fb9b 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2267,6 +2267,15 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 		if (extra_mutex)
 			mutex_unlock(extra_mutex);
 
+		/* EMSGSIZE plus something already in the skb means
+		 * that there's more to dump but current skb has filled up.
+		 * If the callback really wants to return EMSGSIZE to user space
+		 * it needs to do so again, on the next cb->dump() call,
+		 * without putting data in the skb.
+		 */
+		if (nlk->dump_done_errno == -EMSGSIZE && skb->len)
+			nlk->dump_done_errno = skb->len;
+
 		cb->extack = NULL;
 	}
 
-- 
2.44.0


