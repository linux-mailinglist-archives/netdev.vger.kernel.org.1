Return-Path: <netdev+bounces-100323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFDC8D88DC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C481F241A3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C14137902;
	Mon,  3 Jun 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2DPZzvA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B22BB0D
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440509; cv=none; b=HIyAOKfxYL2ljjpRTYlTMdvWyJ7doELa0PQO5CySNDDgSTf01SMbJm0O+uS8MrKZ2ai/Q+1MBnz7sbImFKGSl3O2Mm3WjHqI+Ekkd0GjPClSJXMmj69N0+amNl1baAhSCK2LaJcRkFB6Kwcqo1DybkDtwl85KfvgtBBS32HU5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440509; c=relaxed/simple;
	bh=iCOKnytsiLTemfGmbHg8+XtPSrbSdnzR6MK3eMGpq3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfdK+tLV++R91bnSZB5+kFnURI21a/lv/QzjadkO4tYMRdmeH9GjblutqcD57Z3+IRTF+BcrC+m1gygpao2yDHEGEMyYW+c4oEVkOCuO16HBSyP9ReTg2ibe7XMMgKUHUgit+pAJ9h8tpYUlNiBafX9cdl5T+hayGkL+SAcECK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2DPZzvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DF1C2BD10;
	Mon,  3 Jun 2024 18:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717440509;
	bh=iCOKnytsiLTemfGmbHg8+XtPSrbSdnzR6MK3eMGpq3o=;
	h=From:To:Cc:Subject:Date:From;
	b=r2DPZzvASwhxWkNBYZGSo7mEEVjvNzb6eAAF+Cats9Es/21zvvJ5yuvrWtQZx+mln
	 Q8ypegj8nuV5gWBBzg/0nLdguv/hJe3Xt3LkZvgmjjLSyCzS/uN2PAI4pi9Emzazna
	 8NnlTqGh+9CaDkNr2VWt+52wnIqxfS1j2huFRWFWVhyaVzO0edupfg98mtEB2Cql/3
	 BAQhgzcUwRDXRC/cNuxZGXg2zRr2asQHN/kIe4EtqmV5V55lz1m/2rL8DmEAf6o/5k
	 MocZFK63pB4y9baRgWa2IHnjolAJTMTS9LFJsrHzG9EQYp2WDTmmwgwDKfem3CQWj4
	 cM5UbhQ7X6uvA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	dsahern@kernel.org
Subject: [PATCH net v3] rtnetlink: make the "split" NLM_DONE handling generic
Date: Mon,  3 Jun 2024 11:48:26 -0700
Message-ID: <20240603184826.1087245-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jaroslav reports Dell's OMSA Systems Management Data Engine
expects NLM_DONE in a separate recvmsg(), both for rtnl_dump_ifinfo()
and inet_dump_ifaddr(). We already added a similar fix previously in
commit 460b0d33cf10 ("inet: bring NLM_DONE out to a separate recv() again")

Instead of modifying all the dump handlers, and making them look
different than modern for_each_netdev_dump()-based dump handlers -
put the workaround in rtnetlink code. This will also help us move
the custom rtnl-locking from af_netlink in the future (in net-next).

Note that this change is not touching rtnl_dump_all(). rtnl_dump_all()
is different kettle of fish and a potential problem. We now mix families
in a single recvmsg(), but NLM_DONE is not coalesced.

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
v3:
 - change the approach to centralized handling + flag
v2:
 - adjust the comment in the kdoc
 - add getlink

CC: dsahern@kernel.org
---
 include/net/rtnetlink.h |  1 +
 net/core/rtnetlink.c    | 44 +++++++++++++++++++++++++++++++++++++++--
 net/ipv4/devinet.c      |  2 +-
 net/ipv4/fib_frontend.c |  7 +------
 4 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 3bfb80bad173..b45d57b5968a 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -13,6 +13,7 @@ enum rtnl_link_flags {
 	RTNL_FLAG_DOIT_UNLOCKED		= BIT(0),
 	RTNL_FLAG_BULK_DEL_SUPPORTED	= BIT(1),
 	RTNL_FLAG_DUMP_UNLOCKED		= BIT(2),
+	RTNL_FLAG_DUMP_SPLIT_NLM_DONE	= BIT(3),	/* legacy behavior */
 };
 
 enum rtnl_kinds {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b86b0a87367d..4668d6718040 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6484,6 +6484,46 @@ static int rtnl_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 /* Process one rtnetlink message. */
 
+static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	rtnl_dumpit_func dumpit = cb->data;
+	int err;
+
+	/* Previous iteration have already finished, avoid calling->dumpit()
+	 * again, it may not expect to be called after it reached the end.
+	 */
+	if (!dumpit)
+		return 0;
+
+	err = dumpit(skb, cb);
+
+	/* Old dump handlers used to send NLM_DONE as in a separate recvmsg().
+	 * Some applications which parse netlink manually depend on this.
+	 */
+	if (cb->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE) {
+		if (err < 0 && err != -EMSGSIZE)
+			return err;
+		if (!err)
+			cb->data = NULL;
+
+		return skb->len;
+	}
+	return err;
+}
+
+static int rtnetlink_dump_start(struct sock *ssk, struct sk_buff *skb,
+				const struct nlmsghdr *nlh,
+				struct netlink_dump_control *control)
+{
+	if (control->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE) {
+		WARN_ON(control->data);
+		control->data = control->dump;
+		control->dump = rtnl_dumpit;
+	}
+
+	return netlink_dump_start(ssk, skb, nlh, control);
+}
+
 static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
@@ -6548,7 +6588,7 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 				.module		= owner,
 				.flags		= flags,
 			};
-			err = netlink_dump_start(rtnl, skb, nlh, &c);
+			err = rtnetlink_dump_start(rtnl, skb, nlh, &c);
 			/* netlink_dump_start() will keep a reference on
 			 * module if dump is still in progress.
 			 */
@@ -6694,7 +6734,7 @@ void __init rtnetlink_init(void)
 	register_netdevice_notifier(&rtnetlink_dev_notifier);
 
 	rtnl_register(PF_UNSPEC, RTM_GETLINK, rtnl_getlink,
-		      rtnl_dump_ifinfo, 0);
+		      rtnl_dump_ifinfo, RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
 	rtnl_register(PF_UNSPEC, RTM_SETLINK, rtnl_setlink, NULL, 0);
 	rtnl_register(PF_UNSPEC, RTM_NEWLINK, rtnl_newlink, NULL, 0);
 	rtnl_register(PF_UNSPEC, RTM_DELLINK, rtnl_dellink, NULL, 0);
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index f3892ee9dfb3..d09f557eaa77 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2805,7 +2805,7 @@ void __init devinet_init(void)
 	rtnl_register(PF_INET, RTM_NEWADDR, inet_rtm_newaddr, NULL, 0);
 	rtnl_register(PF_INET, RTM_DELADDR, inet_rtm_deladdr, NULL, 0);
 	rtnl_register(PF_INET, RTM_GETADDR, NULL, inet_dump_ifaddr,
-		      RTNL_FLAG_DUMP_UNLOCKED);
+		      RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
 	rtnl_register(PF_INET, RTM_GETNETCONF, inet_netconf_get_devconf,
 		      inet_netconf_dump_devconf,
 		      RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED);
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index c484b1c0fc00..7ad2cafb9276 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1050,11 +1050,6 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 			e++;
 		}
 	}
-
-	/* Don't let NLM_DONE coalesce into a message, even if it could.
-	 * Some user space expects NLM_DONE in a separate recv().
-	 */
-	err = skb->len;
 out:
 
 	cb->args[1] = e;
@@ -1665,5 +1660,5 @@ void __init ip_fib_init(void)
 	rtnl_register(PF_INET, RTM_NEWROUTE, inet_rtm_newroute, NULL, 0);
 	rtnl_register(PF_INET, RTM_DELROUTE, inet_rtm_delroute, NULL, 0);
 	rtnl_register(PF_INET, RTM_GETROUTE, NULL, inet_dump_fib,
-		      RTNL_FLAG_DUMP_UNLOCKED);
+		      RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
 }
-- 
2.45.1


