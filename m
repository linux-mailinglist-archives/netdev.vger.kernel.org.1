Return-Path: <netdev+bounces-100029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44A18D786D
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 23:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B952814CD
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 21:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189D482ED;
	Sun,  2 Jun 2024 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhf9LWSr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBA210E6
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717365354; cv=none; b=TO7BbFrBwX0EEekwyZmeRcVthMOwAWgDfXQ5P68i4cSC6F4gZp//PfK0jD1UKynxC3wBDumfXzml9WelADBueM+Rxk57IPCDKZ4mo+oMO68Godt8sJ3zEbuAy6EDlW3XUFkF2LStx728um2S+I8VURRcNs2JNoJWk/7TkoozlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717365354; c=relaxed/simple;
	bh=kzb6HGYfa/xyMnxpTCJD7vhgo4XxOdARoMkXYpJ240E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svXJWUt7sXOuMyhBiy1FIbcoVsuHOHO/EhN2vOlaxrx0SSpmpDF7YcDVYrKPNOynxnGGN8KN/hh1XvDNibEzVHcthvAlI0idda5kBMYa1MLgm8txyfxlJ/4jtVtS3k45DRE1b3IIdFhU6qYu+PoellTqWzyu5lo6apoUaJeanUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhf9LWSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08009C32789;
	Sun,  2 Jun 2024 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717365354;
	bh=kzb6HGYfa/xyMnxpTCJD7vhgo4XxOdARoMkXYpJ240E=;
	h=From:To:Cc:Subject:Date:From;
	b=uhf9LWSreKdq0DZXAiWkbsOEtUDXuGY0yB6LDzUV/AFAf+LtFyXgXzti6n532aR9t
	 VED8SGaN1vD1/5XgIOOKXSuYY7oR0wsRF53QmSpuew8u8PpL/8iaIceYbQO3Yr1K/J
	 ruzwrwX+kaDcnwu+KmfcZNIlPQJ1F2o+C1oX5F8hqs/w3hW1IItaBpufKM5rNc2WBx
	 sLk/YCotsvN9Fr+EKFoUA+K/rA/hMA594A5SGpKAn5IuuCfHwObLHbfT44/KUnmbU/
	 NePPg6ERNu99LYTOIsefB/cQOvm142PerARU05Y+RQ/Ds/kFxPuuSOmi3J+f6giJ+U
	 emBK7GTqJgKeA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	dsahern@kernel.org
Subject: [PATCH net v2] inet: bring NLM_DONE out to a separate recv() in inet_dump_ifaddr()
Date: Sun,  2 Jun 2024 14:55:52 -0700
Message-ID: <20240602215552.807150-1-kuba@kernel.org>
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

  ./cli.py --dbg-small-recv 4096 --spec netlink/specs/rt_link.yaml \
           --dump getlink

Fixes: 3e41af90767d ("rtnetlink: use xarray iterator to implement rtnl_dump_ifinfo()")
Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_ifaddr()")
Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Link: https://lore.kernel.org/all/CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - adjust the comment in the kdoc
 - add getlink

CC: dsahern@kernel.org
---
 include/net/netlink.h   | 40 ++++++++++++++++++++++++++++++++++++++++
 net/core/rtnetlink.c    |  5 ++++-
 net/ipv4/devinet.c      |  3 +++
 net/ipv4/fib_frontend.c |  5 +----
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index e78ce008e07c..e41069edaea1 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1198,6 +1198,46 @@ nl_dump_check_consistent(struct netlink_callback *cb,
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
+ * NOTE: Do not use this helper in new code or dumps without legacy users!
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
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b86b0a87367d..522bbd70c205 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2284,8 +2284,11 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 				       ext_filter_mask, 0, NULL, 0,
 				       netnsid, GFP_KERNEL);
 		if (err < 0)
-			break;
+			goto done;
 	}
+	ctx->ifindex = INT_MAX;
+done:
+	err = nl_dump_legacy_retval(err, skb);
 	cb->seq = tgt_net->dev_base_seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 	if (netnsid >= 0)
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 96accde527da..4666e1ee2c14 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1911,7 +1911,10 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 		if (err < 0)
 			goto done;
 	}
+	ctx->ifindex = INT_MAX;
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


