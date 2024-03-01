Return-Path: <netdev+bounces-76386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD8D86D8C8
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29EEB21639
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 01:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F273438DE8;
	Fri,  1 Mar 2024 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFXYmxRv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2638DD2
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256693; cv=none; b=YpIOyC+yUZJe7a0xgmVX7ncYCkV/bIcW3G7ig2uLJ6PYT1trIlNmZ08s+DdXCtA6gqxwzDeKTGLfChtkk2t/n50kupOOQMjkmHQCYcSNE+EPtm6hRkZU7MvaO3OuDYMjgJHbQd3FbVW+n9kXGCrwRF025MSNzGo3lGrfCR8srb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256693; c=relaxed/simple;
	bh=oKn4bPhEphu1JF5rSJz7CO+oWbhu/2FjrGzo1B8k604=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiWwpvLf3q5tgbRVIWrrKtBiuydMS9vqjN6dhytgVNEjed0vVDr86JBW7ThQEfA7s3XN0Ws7d4O8dEpbvLf49fZY9dnnfEXgodTGdQ9rCYaMZs02uI1BJqZ5HG0zvE/Qd6fUTLKo01n6VDS349pq3XM5c3Gcdsp+9aisVRZigRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFXYmxRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E85C43399;
	Fri,  1 Mar 2024 01:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709256693;
	bh=oKn4bPhEphu1JF5rSJz7CO+oWbhu/2FjrGzo1B8k604=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XFXYmxRvWhsaKXB8lAKIUIVgJkwohgm/9u6v3l8XKLa5+kkDOV2WMSAMZvfZgSxsj
	 Z/6xnuuueUOCv3VbB78sS23tsvlRtQNxzHO5O7kgg4XItreMuYCd210PtmxcHp6fi+
	 bFlZxGUtxtDm2ZQP+bQQXNfDtpqR2fPV+8OYstZE5oSE4+ZOUuzA4YqDJw44JkKUQb
	 yCD+QlibQ3oGSLF14cOaiFbJi36nCyEObUVGgDAVePUeKWE+1fG72wlB7FvA5DtDD9
	 1Vgf0xTo5qN3Ratt4vh0mH2zCNhCFUhcILe8tAbq4EteCameUMOkiYU3DbFwqf2tyo
	 4T5kcC7bZtZzA==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] genetlink: fit NLMSG_DONE into same read() as families
Date: Thu, 29 Feb 2024 17:28:45 -0800
Message-ID: <20240301012845.2951053-4-kuba@kernel.org>
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

Make sure ctrl_fill_info() returns sensible error codes and
propagate them out to netlink core. Let netlink core decide
when to return skb->len and when to treat the exit as an
error. Netlink core does better job at it, if we always
return skb->len the core doesn't know when we're done
dumping and NLMSG_DONE ends up in a separate read().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
---
 net/netlink/genetlink.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 50ec599a5cff..70379ecfb6ed 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1232,7 +1232,7 @@ static int ctrl_fill_info(const struct genl_family *family, u32 portid, u32 seq,
 
 	hdr = genlmsg_put(skb, portid, seq, &genl_ctrl, flags, cmd);
 	if (hdr == NULL)
-		return -1;
+		return -EMSGSIZE;
 
 	if (nla_put_string(skb, CTRL_ATTR_FAMILY_NAME, family->name) ||
 	    nla_put_u16(skb, CTRL_ATTR_FAMILY_ID, family->id) ||
@@ -1355,6 +1355,7 @@ static int ctrl_dumpfamily(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *net = sock_net(skb->sk);
 	int fams_to_skip = cb->args[0];
 	unsigned int id;
+	int err;
 
 	idr_for_each_entry(&genl_fam_idr, rt, id) {
 		if (!rt->netnsok && !net_eq(net, &init_net))
@@ -1363,16 +1364,17 @@ static int ctrl_dumpfamily(struct sk_buff *skb, struct netlink_callback *cb)
 		if (n++ < fams_to_skip)
 			continue;
 
-		if (ctrl_fill_info(rt, NETLINK_CB(cb->skb).portid,
-				   cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				   skb, CTRL_CMD_NEWFAMILY) < 0) {
+		err = ctrl_fill_info(rt, NETLINK_CB(cb->skb).portid,
+				     cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				     skb, CTRL_CMD_NEWFAMILY);
+		if (err) {
 			n--;
 			break;
 		}
 	}
 
 	cb->args[0] = n;
-	return skb->len;
+	return err;
 }
 
 static struct sk_buff *ctrl_build_family_msg(const struct genl_family *family,
-- 
2.43.2


