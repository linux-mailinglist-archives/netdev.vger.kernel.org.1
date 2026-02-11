Return-Path: <netdev+bounces-258269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMdGHjVwjGlsoAAAu9opvQ
	(envelope-from <netdev+bounces-258269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:04:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AD912411D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53492302BE14
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C03D32E745;
	Wed, 11 Feb 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx36ENZ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733132D7C7;
	Wed, 11 Feb 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811428; cv=none; b=fwVm+vfoTAGLzrD01zoOSxs7bkg9iyVExThaGvtVqnTcYxGH5RE3EL0ZOLRrqHlQkTha7NdkiZJpLkMsJsyx8d/LZn7VgghPTzX7nBdY75vGuJAmapVnGfV2VlpxJLD7ju5o05qr2fcYZ+bLCshZ+3Da7528wK6xV5CiGlmkIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811428; c=relaxed/simple;
	bh=XDl4uyRI0O14eKBe7PPTMxxokEsPBzKMbnEDZzZSecA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4yBG0I+2K3wCByARpqh/X9zjXtTGFKnrX3YwwulkA6JuUS4ZjCFz2TP48g80ymcHwoSKVe7Lw9QdhKyw7LmoPUG612TPCd5ZeY6C34Q+JpOq9HdMtp9/YiOlRQHF2yng9t48pEKDLGpFOfvZMSnGlkDe7HHz7A7H2jiR9/hUKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx36ENZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47484C2BC86;
	Wed, 11 Feb 2026 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770811428;
	bh=XDl4uyRI0O14eKBe7PPTMxxokEsPBzKMbnEDZzZSecA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hx36ENZ5dv40votJVVk6WpEBg8btNcBVrvxMp8pL8xRME/D0cUkbobC5aL53Rs+JL
	 U5RzG8e8z+PmRlA1apIpy+HumvJTkogHi3Qhbm9HLcqlbFQ+WeXHvxnqbTYuGj0azo
	 6hYDSPqEIjLJma80L2PTUGpQeRHLA8yusMK6LAm0jrK26uefXrlwTp726Sq4A9T/5z
	 EsiRJEN/OqPAvyHlaKJh7zBc68OxeC/Rh+0DII3f3j9S2RcU56XwMBA7M6E5f5joWI
	 W81GOijnS2MMja85uDDYVo2w6w5lN/edcLEKbce3GrpmRqtEtkgzAfD5o9nE4kTATb
	 5otLlNGqrlFqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 11 Feb 2026 13:03:17 +0100
Subject: [PATCH iproute2 1/2] mptcp: monitor: also show iface name
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-mptcp-color-v1-1-01832777611d@kernel.org>
References: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
In-Reply-To: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XDl4uyRI0O14eKBe7PPTMxxokEsPBzKMbnEDZzZSecA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7ChRjP+zb7pj0Qr9tStd5v0WL9E4Z3K03vrRphvmn+
 0rGfav4O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYSU8rIcDL3io2qzuvYC0kb
 omt7Tq2u/Ji9SPL2JblK+Sd8i9PyahgZXv7fVXWbvSfZnUVb9gAz39Hmdq243I7SP0EVfo5h3Ar
 sAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258269-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0AD912411D
X-Rspamd-Action: no action

Previously, only the interface index was printed.

It is helpful to display the interface name, instead of letting the
reader doing the translation from the index to the name.

Because the index was already displayed before, keep it instead of
replacing it, just not to break some possible scripts parsing this
output.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index acd008f3..5f194aca 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -471,6 +471,17 @@ static void print_addr(const char *key, int af, struct rtattr *value)
 		printf(" %s=%s", key, str);
 }
 
+static void print_iface(int index)
+{
+	const char *ifname;
+
+	printf(" ifindex=%d", index);
+
+	ifname = index ? ll_index_to_name(index) : NULL;
+	if (ifname)
+		printf(" dev=%s", ifname);
+}
+
 static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 			     struct nlmsghdr *n, void *arg)
 {
@@ -530,7 +541,7 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 	if (tb[MPTCP_ATTR_TIMEOUT])
 		printf(" timeout=%u", rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
 	if (tb[MPTCP_ATTR_IF_IDX])
-		printf(" ifindex=%d", rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
+		print_iface(rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
 	if (tb[MPTCP_ATTR_RESET_REASON])
 		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
 	if (tb[MPTCP_ATTR_RESET_FLAGS])

-- 
2.51.0


