Return-Path: <netdev+bounces-164010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3437A2C46C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA49188EA33
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DC5213E61;
	Fri,  7 Feb 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In7LmL10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C4227593;
	Fri,  7 Feb 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936777; cv=none; b=XKmZKWH5uBSaUoW8ScUdpOE7/unDX3IPd7szv7NQlhcEi5C8cbm/IC2JoEQluQj7LrTSGFSJPYKaekEI2MFTtGadSB1sVeAeYkG/pooBCTZdt9AWxGsz0ByLMo/W0SyJRF48QujKclq1WY5NlNdSr1wkYimjotPjfin7Mb+dHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936777; c=relaxed/simple;
	bh=ywVqaLMcTnS7/LX0E47JY1rOXoObiNL+nHvd4fAztMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9y26VNY64C3z0P63rqeYFChTXugiG33NiosszsRzjhbuXbyVa2u4R14vyKbxnHcq/CwyBsWKZ168qIy+jhmrAbj17alDssqECVEct8VzcwgQm8xSlSItSUiUJnHPh2Fe+rBayOnke2S+99PtLTyndd+uG6afaxW24ya5Ve23oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In7LmL10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2B1C4CEE2;
	Fri,  7 Feb 2025 13:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936776;
	bh=ywVqaLMcTnS7/LX0E47JY1rOXoObiNL+nHvd4fAztMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=In7LmL10dF0ZgRD6Web/OedmjiuO3oi4UIJQLixMT5qtB6+LS9tydlo5BM1EbJVSF
	 77TD/OHAZLFN6DKx2bsuZOdh5ws8Yshr0eL3ymndY7TKPBSfBTm9SfVsXHSvloXaXH
	 FOOkqcACI3MP+xIKFgRnaE1yVJMusM8oq69MUiBoD9X5/0KA+pYRhOtANDARPhkXys
	 Oy1yjv9NGRo2M9BPBidgjPswQMk439mHwMIyrJ5rp65d/PYVQhyVBGBfSBftdl9sSA
	 iGCnFljztqBF8ZYtdgckTmtfhdb9+9HYaeyzC2cpr2NOr+Ae3xoHBYFKRn+zIR8t+p
	 MV82pFqQCv67g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:21 +0100
Subject: [PATCH net-next v3 03/15] mptcp: pm: more precise error messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-3-71753ed957de@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ywVqaLMcTnS7/LX0E47JY1rOXoObiNL+nHvd4fAztMw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG9Bf+x5kGwIOUPZFFikes5EMXj9cyiRuBDD
 JwhBDTITliJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 c3UtEACGAy7f/gp+Xsp+W8WN6khikmHxUXc40kQgM+R5NqdTL2V3O7C4UOyn24aiD9t1Yy3i33a
 lE2cbu7U3OuVWZp4YWC9lkQZTpB5IoCFdXRgpacxKU4ZGPbtLiyCt0qtp0lr/XTlQM7yLEJSU4y
 V9y1kR5tLJvVmrHHB665os9BfHY1zyR4SJewt1ReQQUy2U/EmP1uj5w3hfqYhgrLBZyrGZpu56r
 q74WmQD74F3G8Ze39VYXHbFQRHJUqmTUQyShLlUc1PoQHyylqh/SEqsXy3u+G2ioPnuQv4LKa/j
 Sz4Jok42hLfQ6BkEj53uBbqtMqfJRXV0C7o8zQGrbQ5rkMQ66C1NOtDI/kNOBTEKzcmyG8EuUOi
 vApWPjB6VuEWo+TIK8sZExmahvTn9m4C9AOAydl458XHdfZNERLSI4U5Qlp/tzSD27DpTgaww0H
 LTQekz+yWECGatzVvI2CepxCWXLL8V25SO1xH0sGK+PMtVQKfVR+48lWV55ViXoIRf7a1bEOkmW
 r0+AgfpeDWP5LqEVX4LLI3KqvFfd5QxRYgdVFbpoRyEi2Ir9+h4JqBVJj7RorjeZHU4fXakVpbF
 SYPOOJXF4v5v4kNC5Lu2/uGv/aaMhQvyVJhvMRa9DuHNcBmRylFHTZGIij+cfKe0xcx7c/GOtjo
 xV2oml9D6/toZLQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some errors reported by the userspace PM were vague: "this or that is
invalid".

It is easier for the userspace to know which part is wrong, instead of
having to guess that.

While at it, in mptcp_userspace_pm_set_flags() move the parsing after
the check linked to the local attribute.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b6cf8ea1161ddc7f0f1662320aebfe720f55e722..cdc83fabb7c2c45bc3d7c954a824c8f27bb85718 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -223,8 +223,14 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
+	if (addr_val.addr.id == 0) {
+		GENL_SET_ERR_MSG(info, "invalid addr id");
+		err = -EINVAL;
+		goto announce_err;
+	}
+
+	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		err = -EINVAL;
 		goto announce_err;
 	}
@@ -531,8 +537,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
-	if (!addr_l.addr.port || !addr_r.port) {
-		GENL_SET_ERR_MSG(info, "missing local or remote port");
+	if (!addr_l.addr.port) {
+		GENL_SET_ERR_MSG(info, "missing local port");
+		err = -EINVAL;
+		goto destroy_err;
+	}
+
+	if (!addr_r.port) {
+		GENL_SET_ERR_MSG(info, "missing remote port");
 		err = -EINVAL;
 		goto destroy_err;
 	}
@@ -580,13 +592,18 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
+	if (loc.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "invalid local address family");
+		ret = -EINVAL;
+		goto set_flags_err;
+	}
+
 	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid address families");
+	if (rem.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "invalid remote address family");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}

-- 
2.47.1


