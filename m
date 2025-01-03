Return-Path: <netdev+bounces-155055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5454A00DA1
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31DC1642E4
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A1317D355;
	Fri,  3 Jan 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7r5AePo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308298F66
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929133; cv=none; b=UohmRU9XF1Zj5rPBmkb5IXRtUYcaIHCIgiXXS16KGjzO4SYwu/h22O+jSzEnob/lQw2ieo0wGNDdzhWm7wWM33RsUCqFZcX6nzn7kZ/AVnb9FpbIfgx/bsFoWPuOZGmMNPwaLoBqioRLMJ17Y4qAMdHd2R3aQneQBP4rzW8TMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929133; c=relaxed/simple;
	bh=C//Mnuodipd/S6BI6OwOb0cdNZbBYt0G6M0THW+6t+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6QWsWvyCLM+uJV0EdVcHfVxC+iKL59Rd83YWHyglZ/fulL6UW9LHJD2Z2Es+xsVVRfb73vP8TH1+9psKbkK1rVrNFpW3N6EtEvVWJocjrlUlzssNgA0sSl5Dhv/Uk8yiK8fzfhg3v4atTOHLCX1rxowCxuSmhBAHXkBd2U35Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7r5AePo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7519BC4CECE;
	Fri,  3 Jan 2025 18:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735929132;
	bh=C//Mnuodipd/S6BI6OwOb0cdNZbBYt0G6M0THW+6t+4=;
	h=From:To:Cc:Subject:Date:From;
	b=o7r5AePoAE61YaoIwwqw09szEKaWiqZoya7W1LLXJ2/bDi+YBkwrV6nW5BvJ3U2Ya
	 QHaXAX6o4tLp2kvh1XjMsyTEwnTT9n9Fkmz3GabGU+UN/K+rSkd3ELOFh+t7Sxkw6x
	 LOj4HLBcOaUhoW+NeZ2KO8bvHtEMILbd4IINrmOEOdNtzQob9+f3ONBxZcsufcoUpc
	 TjylIAyHI2kxG8nnk6XGktXf+ShS5bBvqUJmPGrC9I0dUAVg467VAEi1PY8QUHkBej
	 00elNv3P9i0lB2VWKkHGxtp8Iedt81yZj3qv6u4VtC0LBazOHXUGFBtkifDW+yA5JJ
	 RMijYgPACVgbg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jdamato@fastly.com,
	almasrymina@google.com,
	sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com
Subject: [PATCH net] net: don't dump Tx and uninitialized NAPIs
Date: Fri,  3 Jan 2025 10:32:07 -0800
Message-ID: <20250103183207.1216004-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use NAPI ID as the key for continuing dumps. We also depend
on the NAPIs being sorted by ID within the driver list. Tx NAPIs
(which don't have an ID assigned) break this expectation, it's
not currently possible to dump them reliably. Since Tx NAPIs
are relatively rare, and can't be used in doit (GET or SET)
hide them from the dump API as well.

Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jdamato@fastly.com
CC: almasrymina@google.com
CC: sridhar.samudrala@intel.com
CC: amritha.nambiar@intel.com
---
 net/core/netdev-genl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2d3ae0cd3ad2..319521f37f72 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -176,8 +176,7 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (!hdr)
 		return -EMSGSIZE;
 
-	if (napi->napi_id >= MIN_NAPI_ID &&
-	    nla_put_u32(rsp, NETDEV_A_NAPI_ID, napi->napi_id))
+	if (nla_put_u32(rsp, NETDEV_A_NAPI_ID, napi->napi_id))
 		goto nla_put_failure;
 
 	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
@@ -268,6 +267,8 @@ netdev_nl_napi_dump_one(struct net_device *netdev, struct sk_buff *rsp,
 		return err;
 
 	list_for_each_entry(napi, &netdev->napi_list, dev_list) {
+		if (napi->napi_id < MIN_NAPI_ID)
+			continue;
 		if (ctx->napi_id && napi->napi_id >= ctx->napi_id)
 			continue;
 
-- 
2.47.1


