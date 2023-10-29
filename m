Return-Path: <netdev+bounces-45117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A67DAF27
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1CAB20C53
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 22:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDB912E51;
	Sun, 29 Oct 2023 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av/wgg5h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E716B10A19
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 22:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B50C433AB;
	Sun, 29 Oct 2023 22:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620219;
	bh=SCtWr7+8UMHl8srmLn1eZameEahtVuQeGPynEFCLA1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Av/wgg5hH+lqDUrxgU8OE5Buk37gRRQC4QwPzYjTIWC8dfk+479h9pX2Ar7WnL4yV
	 6x82Et8vugyLkS3zTqgvfmPMybz1PjoXYvTcnnupZMPCKfVj25Ku1+enbURpXpiCdu
	 vN/Od+oIbQ7xShtwntCM/Epkd5IT5Ik0bewJnJFfLug4iiqqUVn2Jsyx0cXyM5qz7W
	 6dLYx+R39RaWpnB8LiLF3wHg6ZTKMf0P2WVmlHyP3lvsc/I500QAeDw42hFsaZv0o4
	 KM7YsSdL4KPKxZMiJyx8X4scjrrGNUXWkZ/PRoFTjdlFt3H5I8aoHUblhrotHl8JMW
	 PPoy5q8+S9+YA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phil Sutter <phil@nwl.cc>,
	Richard Guy Briggs <rgb@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 47/52] netfilter: nf_tables: audit log object reset once per table
Date: Sun, 29 Oct 2023 18:53:34 -0400
Message-ID: <20231029225441.789781-47-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 1baf0152f7707c6c7e4ea815dcc1f431c0e603f9 ]

When resetting multiple objects at once (via dump request), emit a log
message per table (or filled skb) and resurrect the 'entries' parameter
to contain the number of objects being logged for.

To test the skb exhaustion path, perform some bulk counter and quota
adds in the kselftest.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Acked-by: Paul Moore <paul@paul-moore.com> (Audit)
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c                 | 50 +++++++++++--------
 .../testing/selftests/netfilter/nft_audit.sh  | 46 +++++++++++++++++
 2 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index be5869366c7d3..bddf68f364fb5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7612,6 +7612,16 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 	return -1;
 }
 
+static void audit_log_obj_reset(const struct nft_table *table,
+				unsigned int base_seq, unsigned int nentries)
+{
+	char *buf = kasprintf(GFP_ATOMIC, "%s:%u", table->name, base_seq);
+
+	audit_log_nfcfg(buf, table->family, nentries,
+			AUDIT_NFT_OP_OBJ_RESET, GFP_ATOMIC);
+	kfree(buf);
+}
+
 struct nft_obj_filter {
 	char		*table;
 	u32		type;
@@ -7626,8 +7636,10 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
 	struct nftables_pernet *nft_net;
+	unsigned int entries = 0;
 	struct nft_object *obj;
 	bool reset = false;
+	int rc = 0;
 
 	if (NFNL_MSG_TYPE(cb->nlh->nlmsg_type) == NFT_MSG_GETOBJ_RESET)
 		reset = true;
@@ -7640,6 +7652,7 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 		if (family != NFPROTO_UNSPEC && family != table->family)
 			continue;
 
+		entries = 0;
 		list_for_each_entry_rcu(obj, &table->objects, list) {
 			if (!nft_is_active(net, obj))
 				goto cont;
@@ -7655,34 +7668,27 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 			    filter->type != NFT_OBJECT_UNSPEC &&
 			    obj->ops->type->type != filter->type)
 				goto cont;
-			if (reset) {
-				char *buf = kasprintf(GFP_ATOMIC,
-						      "%s:%u",
-						      table->name,
-						      nft_net->base_seq);
-
-				audit_log_nfcfg(buf,
-						family,
-						obj->handle,
-						AUDIT_NFT_OP_OBJ_RESET,
-						GFP_ATOMIC);
-				kfree(buf);
-			}
 
-			if (nf_tables_fill_obj_info(skb, net, NETLINK_CB(cb->skb).portid,
-						    cb->nlh->nlmsg_seq,
-						    NFT_MSG_NEWOBJ,
-						    NLM_F_MULTI | NLM_F_APPEND,
-						    table->family, table,
-						    obj, reset) < 0)
-				goto done;
+			rc = nf_tables_fill_obj_info(skb, net,
+						     NETLINK_CB(cb->skb).portid,
+						     cb->nlh->nlmsg_seq,
+						     NFT_MSG_NEWOBJ,
+						     NLM_F_MULTI | NLM_F_APPEND,
+						     table->family, table,
+						     obj, reset);
+			if (rc < 0)
+				break;
 
+			entries++;
 			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 cont:
 			idx++;
 		}
+		if (reset && entries)
+			audit_log_obj_reset(table, nft_net->base_seq, entries);
+		if (rc < 0)
+			break;
 	}
-done:
 	rcu_read_unlock();
 
 	cb->args[0] = idx;
@@ -7787,7 +7793,7 @@ static int nf_tables_getobj(struct sk_buff *skb, const struct nfnl_info *info,
 
 		audit_log_nfcfg(buf,
 				family,
-				obj->handle,
+				1,
 				AUDIT_NFT_OP_OBJ_RESET,
 				GFP_ATOMIC);
 		kfree(buf);
diff --git a/tools/testing/selftests/netfilter/nft_audit.sh b/tools/testing/selftests/netfilter/nft_audit.sh
index bb34329e02a7f..e94a80859bbdb 100755
--- a/tools/testing/selftests/netfilter/nft_audit.sh
+++ b/tools/testing/selftests/netfilter/nft_audit.sh
@@ -93,6 +93,12 @@ do_test 'nft add counter t1 c1' \
 do_test 'nft add counter t2 c1; add counter t2 c2' \
 'table=t2 family=2 entries=2 op=nft_register_obj'
 
+for ((i = 3; i <= 500; i++)); do
+	echo "add counter t2 c$i"
+done >$rulefile
+do_test "nft -f $rulefile" \
+'table=t2 family=2 entries=498 op=nft_register_obj'
+
 # adding/updating quotas
 
 do_test 'nft add quota t1 q1 { 10 bytes }' \
@@ -101,6 +107,12 @@ do_test 'nft add quota t1 q1 { 10 bytes }' \
 do_test 'nft add quota t2 q1 { 10 bytes }; add quota t2 q2 { 10 bytes }' \
 'table=t2 family=2 entries=2 op=nft_register_obj'
 
+for ((i = 3; i <= 500; i++)); do
+	echo "add quota t2 q$i { 10 bytes }"
+done >$rulefile
+do_test "nft -f $rulefile" \
+'table=t2 family=2 entries=498 op=nft_register_obj'
+
 # changing the quota value triggers obj update path
 do_test 'nft add quota t1 q1 { 20 bytes }' \
 'table=t1 family=2 entries=1 op=nft_register_obj'
@@ -150,6 +162,40 @@ done
 do_test 'nft reset set t1 s' \
 'table=t1 family=2 entries=3 op=nft_reset_setelem'
 
+# resetting counters
+
+do_test 'nft reset counter t1 c1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset counters t1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset counters t2' \
+'table=t2 family=2 entries=342 op=nft_reset_obj
+table=t2 family=2 entries=158 op=nft_reset_obj'
+
+do_test 'nft reset counters' \
+'table=t1 family=2 entries=1 op=nft_reset_obj
+table=t2 family=2 entries=341 op=nft_reset_obj
+table=t2 family=2 entries=159 op=nft_reset_obj'
+
+# resetting quotas
+
+do_test 'nft reset quota t1 q1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset quotas t1' \
+'table=t1 family=2 entries=1 op=nft_reset_obj'
+
+do_test 'nft reset quotas t2' \
+'table=t2 family=2 entries=315 op=nft_reset_obj
+table=t2 family=2 entries=185 op=nft_reset_obj'
+
+do_test 'nft reset quotas' \
+'table=t1 family=2 entries=1 op=nft_reset_obj
+table=t2 family=2 entries=314 op=nft_reset_obj
+table=t2 family=2 entries=186 op=nft_reset_obj'
+
 # deleting rules
 
 readarray -t handles < <(nft -a list chain t1 c1 | \
-- 
2.42.0


