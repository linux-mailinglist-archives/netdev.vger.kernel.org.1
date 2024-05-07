Return-Path: <netdev+bounces-94040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D598BE008
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A656B1F2574F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0388158DDD;
	Tue,  7 May 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="PuYBL8O7"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8701156659;
	Tue,  7 May 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078690; cv=none; b=FL83Gg5/bowfWsCLLefp6GyAJb3vKXWDrUYqcfWAugzQNWtMwpkuH39H/XnxIXIsUqzyTcxJljRRio6TvE2x93yMRv7bluSDGfmJ1/YaL9VuFAPuPdkuw7hh+034roCnctG6bvOvxWW5HoA8sGvXN25tleOG2zy1IBSc/ngU1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078690; c=relaxed/simple;
	bh=TqqEncQeIs+s96w8FZhXyABuN/mKfbK8Vghx5jUdGiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odzMBDKUl5XNZY1npi+j4M/NpwoAJ1c35Nq5Mvr4xRKXfLr9Kk1AtA5TgFxp02dl5/BEOHRbDg3b3vhPmlc3jJjTUbP6lcfSfQ+XxkrzIpLnblakWqBFnPEiyVoYpT0sE3Ptqs9NLgGjpqoou3nJPpOxJjTE32Y+r89tkck6TDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=PuYBL8O7; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id ADAEF6017B;
	Tue,  7 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=TqqEncQeIs+s96w8FZhXyABuN/mKfbK8Vghx5jUdGiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PuYBL8O72Q0VHMn0O9KsL39Rgxm6MCpTeVNMudO/VAmkoVWHMuz2wnzfsYDegnUZk
	 DkwiCXM9hJCVsM7eGtvlNf9vTGPo4KAlnaGLPU6wxX4+KEZhUrmqgR+qShQtBIkTCq
	 +BVCpQKKZNGD7I1ew+NAcRNVbIE7JFo6c99JE8Vno5QoRgXAO3Ru7+YwNF2Rv4JleK
	 vydWuMspdH6yI3MDQZ3mVVHB7qlXCCOx7C7KGEaXQ/268+L5gW2efi0WanThgCVrR0
	 8LdugpaZUtNOUNrkv7gr+1NKS8IRnuOXag+FkbTSa4unjBnzz4CPvF7h5iPqFCBa/A
	 /mN0oMtRKp1rg==
Received: by x201s (Postfix, from userid 1000)
	id 5EDC7203B79; Tue, 07 May 2024 10:44:24 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 10/14] net: qede: add extack in qede_add_tc_flower_fltr()
Date: Tue,  7 May 2024 10:44:11 +0000
Message-ID: <20240507104421.1628139-11-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507104421.1628139-1-ast@fiberby.net>
References: <20240507104421.1628139-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define extack locally, to reduce line lengths and aid future users.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index de6b9a60d4cf..5b353a160d15 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1876,6 +1876,7 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 			    struct flow_cls_offload *f)
 {
+	struct netlink_ext_ack *extack = f->common.extack;
 	struct qede_arfs_fltr_node *n;
 	struct qede_arfs_tuple t;
 	int min_hlen, rc;
@@ -1903,7 +1904,7 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse tc actions and get the vf_id */
-	rc = qede_parse_actions(edev, &f->rule->action, f->common.extack);
+	rc = qede_parse_actions(edev, &f->rule->action, extack);
 	if (rc)
 		goto unlock;
 
-- 
2.43.0


