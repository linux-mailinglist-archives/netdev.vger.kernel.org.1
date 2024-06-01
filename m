Return-Path: <netdev+bounces-99932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1035C8D71F6
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867A32820B5
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C91A33CA;
	Sat,  1 Jun 2024 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIVUeGvn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A818026
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717277123; cv=none; b=gNN8n7bRODDOEk6V5F1L76relpWLi+dMHqKZxMYyjSR0onkW4s9rGTpqwV08+bjHzgQ3BK0rK/GEejgWDAeMMEp4Ob1OBChyJufxkYjuZsVOySlQBQtWSVriP6XBFJ8snr/8VTo+CZAGtrz8PlKMhc4Y+F9EHNKUHMWwt0lpibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717277123; c=relaxed/simple;
	bh=WJU1cD/YQhuFtgctqnXN6aaAwOyPi86CFLrtzD0fFZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWTEuAl2f5rDXgTdn2I6yZ1KiflErhiX5JLS5rgoxviHZeu9CraB6yGCkgX7RED51dKbsFg7BT51Q4pkg3CbeiJS8cqeC64gCWXPoJpl94BiI3shaA8G5WVfLKACTah5uzxoQc4jO31RZKqOq5Sq3P1Fq2HQZnYoY/7HZJUQDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIVUeGvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AB0C116B1;
	Sat,  1 Jun 2024 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717277123;
	bh=WJU1cD/YQhuFtgctqnXN6aaAwOyPi86CFLrtzD0fFZs=;
	h=From:To:Cc:Subject:Date:From;
	b=tIVUeGvnW5UaICp2EF91/NI17z7DqQC+PIShIAkdVs9E4a6NrwPbBEHs/lw0/5RK2
	 7v9kK2BF+HHR/xuAqwZqQNa3AC1z9tW7ZwVnF+UNtye9gnoO7R1TreHCa59+MHbU4m
	 mhN2ePrTA9wB4WdDm+NL7OzwWmQb8+dLOoEBuJeO7IS1Pqhq0TmPeo11VjJxGj70oq
	 uasLZaZnmQVBTsJduz0TpUv6EqaLb9hn0DSVOnYK3bjz4SJmef/d/EZCw9MihGEP55
	 UD40kcKrAvSP0Cc0dILJ1ekGHrA4c2okblu7rpaFn+OkTB/gWJqgKk4MN0v/F/pbxE
	 L5AFnf3cnhx2w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	dsahern@kernel.org
Subject: [PATCH net] inet: bring NLM_DONE out to a separate recv() in inet_dump_ifaddr()
Date: Sat,  1 Jun 2024 14:25:17 -0700
Message-ID: <20240601212517.644844-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jaroslav reports Dell's OMSA Systems Management Data Engine
expects NLM_DONE in a separate recvmsg(), so revert to the
old behavior.

This is the same kind of fix as we added in
commit 460b0d33cf10 ("inet: bring NLM_DONE out to a separate recv() again")
so wrap the logic into a helper, to make it easier to keep track
of which dump handles we know to require legacy handling
(and possibly one day let sockets opt into not doing this).

Tested:

  ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_addr.yaml \
           --dump getaddr --json '{"ifa-family": 2}'

  ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_route.yaml \
           --dump getroute --json '{"rtm-family": 2}'

Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_ifaddr()")
Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Link: https://lore.kernel.org/all/CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dsahern@kernel.org
---
 include/net/netlink.h   | 42 +++++++++++++++++++++++++++++++++++++++++
 net/ipv4/devinet.c      |  3 +++
 net/ipv4/fib_frontend.c |  5 +----
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index e78ce008e07c..8369aca32443 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1198,6 +1198,48 @@ nl_dump_check_consistent(struct netlink_callback *cb,
 	cb->prev_seq = cb->seq;
 }
 
+/**
+ * nl_dump_legacy_retval - get legacy return code for netlink dumps
+ * @err: error encountered during dump, negative errno or zero
+ * @skb: skb with the dump results
+ *
+ * Netlink dump callbacks get called multiple times per dump, because
+ * all the objects may not fit into a single skb. Whether another iteration
+ * is necessary gets decided based on the return value of the callback
+ * (with 0 meaning "end reached").
+ *
+ * The semantics used to be more complicated, with positive return values
+ * meaning "continue" and negative meaning "end with an error". A lot of
+ * handlers simplified this to return skb->len ? : -errno. Meaning that zero
+ * would only be returned when skb was empty, requiring another recvmsg()
+ * syscall just to get the NLM_DONE message.
+ *
+ * The current semantics allow handlers to also return -EMSGSIZE to continue.
+ *
+ * Unfortunately, some user space has started to depend on the NLM_DONE
+ * message being returned individually, in a separate recvmsg(). Select
+ * netlink dumps must preserve those semantics.
+ *
+ * This helper wraps the "legacy logic" and serves as an annotation for
+ * dumps which are known to require legacy handling.
+ *
+ * When used in combination with for_each_netdev_dump() - make sure to
+ * invalidate the ifindex when iteration is done. for_each_netdev_dump()
+ * does not move the iterator index "after" the last valid entry.
+ *
+ * NOTE: Do not use this helper for dumps without known legacy users!
+ *       Most families are accessed only using well-written libraries
+ *       so starting to coalesce NLM_DONE is perfectly fine, and more efficient.
+ *
+ * Return: return code to use for a dump handler
+ */
+static inline int nl_dump_legacy_retval(int err, const struct sk_buff *skb)
+{
+	if (err < 0 && err != -EMSGSIZE)
+		return err;
+	return skb->len;
+}
+
 /**************************************************************************
  * Netlink Attributes
  **************************************************************************/
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 96accde527da..6d0e5cbd95b4 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1911,7 +1911,10 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 		if (err < 0)
 			goto done;
 	}
+	ctx->ifindex = ULONG_MAX;
 done:
+	err = nl_dump_legacy_retval(err, skb);
+
 	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
 	rcu_read_unlock();
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index c484b1c0fc00..100d77eafe35 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1051,10 +1051,7 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 		}
 	}
 
-	/* Don't let NLM_DONE coalesce into a message, even if it could.
-	 * Some user space expects NLM_DONE in a separate recv().
-	 */
-	err = skb->len;
+	err = nl_dump_legacy_retval(err, skb);
 out:
 
 	cb->args[1] = e;
-- 
2.45.1


