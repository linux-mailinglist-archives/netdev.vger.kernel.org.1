Return-Path: <netdev+bounces-76384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B971186D8C6
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B1C1C203BC
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF42CCA4;
	Fri,  1 Mar 2024 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMXSe3Fe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B61381B9
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256693; cv=none; b=lkY/QYB49UtOA4lw5BTEF42DAl12Gwtlwi7FEftW6R+R+Skp6rqHGY4kAlkKcMqHi2dR9H/GhL4ne2+kuUz1jHfizk3FUkAzKhHnWZhwmPtJWFmZprqWgWPEmvrNFtc8VY4Yj1l+8J5D/AyAd7/HX4NqbDJYGqapWPJwrDSeB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256693; c=relaxed/simple;
	bh=bW/QVUMBf2pmWVa3nHFpfrvYovxTopYIJ3df/9Vv1Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubjdhmSVOniOusdgfQSl7/OqzJlo9GcDJsNqHa88X7Fxb8vUCHLXVTxPp1k1NAVzgRsp78HxZ/p558cguvFqKUXk7YXs4ifA7NOvmbMXgILQ72hsQXudoZbFF8yqaRMj8aobfzJ4kjMJVVkmjzqp+LCAL6My5ykw67SkupI3egM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMXSe3Fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACDAC433A6;
	Fri,  1 Mar 2024 01:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709256691;
	bh=bW/QVUMBf2pmWVa3nHFpfrvYovxTopYIJ3df/9Vv1Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SMXSe3Fe/d3PRjOxPSG8OpJrB+pS98hXONtDIpBzjbQ1ZulmtpkpzvIP0nfE13Ur7
	 56uQOjUpp2hBQakbt9n63yE6OELiU0+uIpOBq5BasCC9Bx63khgy+e+LiBH0EdnoQk
	 X50SAZ326Tc6D4QplY2NKLJ71ovBT5d0hiu/DlzgdAlDFMyMU18nE4BrDfjB3Wqma8
	 npLYEi8giCwfVMvybLY9fFPg18eVSqp2sHXRRLfuO9EsFVO74DSCjrepG11qirkUIz
	 cTCO9GNwjUk5JXyAsEvjorwB19ICzy9jTVc6dw8Q+6oI5pEoAwdZg7MPfpoJ/ila6d
	 9ObO+oUgoiYzA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes@sipsolutions.net,
	fw@strlen.de,
	pablo@netfilter.org,
	idosch@nvidia.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>,
	kuniyu@amazon.com
Subject: [PATCH net-next 1/3] netlink: handle EMSGSIZE errors in the core
Date: Thu, 29 Feb 2024 17:28:43 -0800
Message-ID: <20240301012845.2951053-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301012845.2951053-1-kuba@kernel.org>
References: <20240301012845.2951053-1-kuba@kernel.org>
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
2.43.2


