Return-Path: <netdev+bounces-76872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508786F3B5
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 06:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6380A1C20DA0
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 05:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074C9455;
	Sun,  3 Mar 2024 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koiAoZXS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02068F5D
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709443461; cv=none; b=YmxCIf2pzYCp4WkCaV3r0YFQwcPg66ZcBmPl7oNuEtccZ9/fY7kuAgc4sPRI4sJZBnVXGmbYq+rzQk1je3+YIuR8q+FubroES6EjXX9swvgkIEJjyjLLGEKr3ifZDtNXDcMKGeBaRNPnevLwe8+Ed++/kRWFc/UTYG6fKWI5Ehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709443461; c=relaxed/simple;
	bh=erMYHEtKWk5YhkMUaQk9snyW7OqcL8kOFfm6TWUKMnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsP6wVFTxnsdFY/bAI8Gaq55Rsid0v+5bPmTjI8g6bx+fzBTy60+Gr8JQM5H8dukQWZpUztEiL73AXp+MvFkaJOd0zpM71KbgVbkaG6opDIV84U/UUTTpD9L+il228gBtWJfVMpFf/YzKuzi1y4OlOEi+vBpf7TCIeUISBVYLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koiAoZXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1410DC433B2;
	Sun,  3 Mar 2024 05:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709443460;
	bh=erMYHEtKWk5YhkMUaQk9snyW7OqcL8kOFfm6TWUKMnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koiAoZXSvUpEuZv4YHS1omz5gC2z2WF26azKq6Ot77Zm20Lg7EyLT8uuyLP0uL0Tb
	 MDCLHA1/p7mhfHeQ2vMHaBLpkbedzI4kV9nHxdy/JaN8F4jmm0W5Jf/6979gxAhsFQ
	 VMR8CAou2qZqgnvzs25dcy+k+42t+L9MyEhHxKC3zzqACR+gXbtTzlqgmKJjVgzrj0
	 xoy/rjMXIxlPeEBAkqJW6iN834ajVuJMi2Ip8MBjKPjU5sxz6ukyCuXfW5tKiCpSTC
	 DqCR70RPmkleR6EFwAkGAKe7G7z6LkOYQeyegtXYrQpnBThOFRIFY6UmQNE5I6GIG7
	 ReLeVffjl1DYA==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same read() as families
Date: Sat,  2 Mar 2024 21:24:08 -0800
Message-ID: <20240303052408.310064-4-kuba@kernel.org>
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

Make sure ctrl_fill_info() returns sensible error codes and
propagate them out to netlink core. Let netlink core decide
when to return skb->len and when to treat the exit as an
error. Netlink core does better job at it, if we always
return skb->len the core doesn't know when we're done
dumping and NLMSG_DONE ends up in a separate read().

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
---
 net/netlink/genetlink.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 50ec599a5cff..3b7666944b11 100644
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
+	int err = 0;
 
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
2.44.0


