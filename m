Return-Path: <netdev+bounces-274996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P8+HVmlz2mZyQYAu9opvQ
	(envelope-from <netdev+bounces-274996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:32:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E042C393B50
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A939030862D8
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C943B47C2;
	Fri,  3 Apr 2026 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6MxUSLV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B431F99D;
	Fri,  3 Apr 2026 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775215803; cv=none; b=marzpDzc6dqQF0TlB9hDcJYZ1bN2K5HM6rMCkUdLPMFjgbxo/TeoiSa3oF2odf9Go6lEiEgKISRLNCEFV37r/1rV6iocIOG6bm5TSCOq5wSKSfOfcVpPYnLyAv31zZ0q8r3FKNb7ad8MNJkYXe2PDoga9XS+m6q9YVwwpprmWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775215803; c=relaxed/simple;
	bh=Ws960Ue/zmcX7kdTuXX1aczhyesgjt82Y+UPAyP6JlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BF50ZMF9I6Rc619Mcd/9FxjoQbfwYVsIvsrgrgQsob07pHTgnEDi8PTp/HOhP/dLQpzxpfe1xmCC2/mGaULxswtmkYFK2orEYR2HBgoDa95MpEkGG/gVYfmB18xKkByIKj9rfvM33onVU4N7IqY+lABtfFpIvrCaq9F69fNz7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6MxUSLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D7DC19423;
	Fri,  3 Apr 2026 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215801;
	bh=Ws960Ue/zmcX7kdTuXX1aczhyesgjt82Y+UPAyP6JlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F6MxUSLVaHNC2iTujCJ4ovks4WNWj8lVvkO9gN3sVyix/qFypX8s89mFSfOrCkyLa
	 3ZYs4+53irOXCnX4PIuKVZnlmaahS/H08CJQA4NOt0M/DMvfndBQtrta0HDSei9AC1
	 XknKA73stIFQy5CLJzooP3FCElwg5QdlHKbd++j3k/M7R7Nkyn0dAmq9SonWA4zpFJ
	 iit15huOWEsKEA6AZSy+YL4Wt7y08H6f6tMpxkgLrD5aDzlh9uJyIWx+F3T1xp4h2c
	 1mqH443N9NVW/qCHgwrtO34G6jrFKvXKaUIsFnV+ckNeAKQoF2tfzQxA+npo3D7FRF
	 75Q3mNWci1Q1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 03 Apr 2026 13:29:30 +0200
Subject: [PATCH net-next 4/5] mptcp: pm: in-kernel: remove
 mptcp_pm_has_addr_attr_id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-net-next-mptcp-msg_eor-misc-v1-4-b0b33bea3fed@kernel.org>
References: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
In-Reply-To: <20260403-net-next-mptcp-msg_eor-misc-v1-0-b0b33bea3fed@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2965; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ws960Ue/zmcX7kdTuXX1aczhyesgjt82Y+UPAyP6JlQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPL1kjWTR17aT35/xKEg+9zFxy5vRnswfPZNbYbVrYM
 zFUdHccd0cpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBE1uUxMhxZfJXXp8lAXkja
 MCmaO7XTSuNEwNR4Qb+5ZXNUnzEWKzMyvPu1w2GmXPYW0/y6R5fktfcqazYfsZD6IGXGeehZqnw
 FLwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E042C393B50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is no need to call this helper: it will check if the address ID
attribute is set, but this attribute has already been parsed previously.

Indeed, the value has been set in 'entry->addr.id' if it was set and
positive, which is what we were looking at. Then only looking at this
already parsed value is enough, not need to re-extract all Netlink
attributes again.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 82e59f9c6dd9..0ebf43be9939 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -720,7 +720,7 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id, bool replace)
+					     bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	int ret = -EINVAL;
@@ -779,7 +779,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id && needs_id) {
+	if (!entry->addr.id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -790,7 +790,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id && needs_id)
+	if (!entry->addr.id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -923,7 +923,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 		return -ENOMEM;
 
 	entry->addr.port = 0;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -977,18 +977,6 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 	return 0;
 }
 
-static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
-				      struct genl_info *info)
-{
-	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
-
-	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					 mptcp_pm_address_nl_policy, info->extack) &&
-	    tb[MPTCP_PM_ADDR_ATTR_ID])
-		return true;
-	return false;
-}
-
 /* Add an MPTCP endpoint */
 int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
@@ -1037,9 +1025,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info),
-						true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;

-- 
2.53.0


