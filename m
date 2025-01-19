Return-Path: <netdev+bounces-159605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA4A15FEB
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3831886C3E
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69DB2A1BA;
	Sun, 19 Jan 2025 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV7+2X4I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCC29CE7
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 02:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252322; cv=none; b=I6V1AWD4zjYufZYJwUFYPPXMFt2PiRhvzFz/snPvxZxLpk+WwC4ShF/xig50/Lfnpi+fe90bpQeyJCuHNk2G1pMHFUHdGIjVeHP+p/yis34W6UVUyDiA/Uvd81u8OIFPbqK71BM2s5GpC8j3LbdjvTrM2xQNIHrXVMvLp9SQyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252322; c=relaxed/simple;
	bh=yA1KwJiIOYKNcrFJ32zpsCwi3SpkpgvUBGg6qkDGA7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRY/o8vVIw748qCFa7qWfHcRVrAG/V+EJuZpoPos+d30/3o4FZjyJWI5roa+zk16/S9uJu7CsX9dnuzxIJKmgG4V0JJwe2ECP8AKXBiUOHwFcLTh8sZHOXQyJo7+sHdpLC/glNkxOaKwmoPrl/e32mXREw3Fk5qghKboCVmnz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV7+2X4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4DAC4CEE3;
	Sun, 19 Jan 2025 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252321;
	bh=yA1KwJiIOYKNcrFJ32zpsCwi3SpkpgvUBGg6qkDGA7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nV7+2X4IQFEkwf0HL3OWGxDl0zCRDZrt6EiGiJ+E4gypn8hR6uflWNeRSwa2GOqSX
	 NbS+ghePj/Go9NUOj4gjHKsnlBdfeaUFpwjBfHvMvR4LTmeikcIJ+lFESB+5L5M1hD
	 UrJih/UO9OqruJvLM7yY+nDTQuTIc/xd0LY564FXbOmbD/XwwJ3uykkQxItXjlO+ov
	 iSUH1SZLjmE46+BhDzp2xrCvMPWvqW7hOSHcQ1rHRqXQVjca5SAyruNOeNeFRTxYbA
	 FM+Y9r9Cdk9ZwFUhaQy1222QpMbFTFA9EtJ/ih4XiRkv2q9kgWza5vuUlfiTR2u5x8
	 uRolv+W2f79eA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/7] net: ethtool: store netdev in a temp variable in ethnl_default_set_doit()
Date: Sat, 18 Jan 2025 18:05:12 -0800
Message-ID: <20250119020518.1962249-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119020518.1962249-1-kuba@kernel.org>
References: <20250119020518.1962249-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ease of review of the next patch store the dev pointer
on the stack, instead of referring to req_info.dev every time.

No functional changes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/netlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 849c98e637c6..c17d8513d4c1 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -667,6 +667,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	const struct ethnl_request_ops *ops;
 	struct ethnl_req_info req_info = {};
 	const u8 cmd = info->genlhdr->cmd;
+	struct net_device *dev;
 	int ret;
 
 	ops = ethnl_default_requests[cmd];
@@ -688,19 +689,21 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_dev;
 	}
 
+	dev = req_info.dev;
+
 	rtnl_lock();
-	ret = ethnl_ops_begin(req_info.dev);
+	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		goto out_rtnl;
 
 	ret = ops->set(&req_info, info);
 	if (ret <= 0)
 		goto out_ops;
-	ethtool_notify(req_info.dev, ops->set_ntf_cmd, NULL);
+	ethtool_notify(dev, ops->set_ntf_cmd, NULL);
 
 	ret = 0;
 out_ops:
-	ethnl_ops_complete(req_info.dev);
+	ethnl_ops_complete(dev);
 out_rtnl:
 	rtnl_unlock();
 out_dev:
-- 
2.48.1


