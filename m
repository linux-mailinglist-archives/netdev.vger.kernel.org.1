Return-Path: <netdev+bounces-94033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3128BDFFB
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671CFB27907
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB21509AB;
	Tue,  7 May 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="LS130bTv"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD0614EC4D;
	Tue,  7 May 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078686; cv=none; b=aTMQ2tzPMmHaUp9yaGijB+gFjAe6cenfkbFXoQG8XSyj23rqpZ24t88vOx36TiB6VfMvBKxARLXcRNilyE5NZ/GTot3K3PYEw2dJsFpWfB2Evg14bmInMR7hpB1vqzfON8+rW/HJYx5fswdiNLt+ZA4hCUaxRfqmDH3g10ypMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078686; c=relaxed/simple;
	bh=Gwag9vXXeqdR/KFA9yZpAgXCO4O5UeNt+6Mvl0e8F8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tC7jud1Gchqxz8UAOeGMcFdHV2odF9BFDeVyhp6maaNsgcOqE3GJwMQqO99k5pEBobo6BTU1AlRjwYoBQbpwUw2DlhL/IgDrn7knkqhJtd9bNdjc9XXsCpiXsNwXJ8XAWzPhtBysG1QSRLrktXbffog2lC+ds1iFUmatUmMbfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=LS130bTv; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id CADD8600A2;
	Tue,  7 May 2024 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078674;
	bh=Gwag9vXXeqdR/KFA9yZpAgXCO4O5UeNt+6Mvl0e8F8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LS130bTvhWbU1xArtVuPbSmM6z2H5RnnbGvz+xt6SwnZPtxS3j5IRV3EpbhLoxkKS
	 ptegN7THeHEmXHcvZeIeixGnTewK3lWwlM2iX6J0Kv1uSObYST2yaVH1fe7LKvSH7x
	 ELXrvSDO9s6KnotITPmjXQzCjqMzfiiWDtWV7+lLKm0fTrtSvP4UhIQPg04oAQaNZL
	 0Kn4mhiGD0aCPGmEpujVM+K7aocs2XsiMu/J8YJ+ZWMZLPOIskEmtRSmDlRfsVqZFe
	 tVKilKk4jaLUdNVneBC5IBLJjyCvN4ptamf6+SZBwXNMWxVVNHj3QUpt6hQNDu6gW1
	 U9GjN4h2qn/GQ==
Received: by x201s (Postfix, from userid 1000)
	id 091382035F9; Tue, 07 May 2024 10:44:23 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 03/14] net: qede: use extack in qede_set_v4_tuple_to_profile()
Date: Tue,  7 May 2024 10:44:04 +0000
Message-ID: <20240507104421.1628139-4-ast@fiberby.net>
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

Convert qede_set_v4_tuple_to_profile() to take extack,
and drop the edev argument.

Convert DP_INFO call to use NL_SET_ERR_MSG_MOD instead.

In calls to qede_set_v4_tuple_to_profile(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 19ffb0823d55..0d429f5b9c57 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1520,7 +1520,7 @@ static int qede_flow_spec_validate_unused(struct qede_dev *edev,
 	return 0;
 }
 
-static int qede_set_v4_tuple_to_profile(struct qede_dev *edev,
+static int qede_set_v4_tuple_to_profile(struct netlink_ext_ack *extack,
 					struct qede_arfs_tuple *t)
 {
 	/* We must have Only 4-tuples/l4 port/src ip/dst ip
@@ -1538,7 +1538,7 @@ static int qede_set_v4_tuple_to_profile(struct qede_dev *edev,
 		   t->dst_ipv4 && !t->src_ipv4) {
 		t->mode = QED_FILTER_CONFIG_MODE_IP_DEST;
 	} else {
-		DP_INFO(edev, "Invalid N-tuple\n");
+		NL_SET_ERR_MSG_MOD(extack, "Invalid N-tuple");
 		return -EOPNOTSUPP;
 	}
 
@@ -1779,7 +1779,7 @@ qede_flow_parse_v4_common(struct qede_dev *edev, struct flow_rule *rule,
 	if (err)
 		return err;
 
-	return qede_set_v4_tuple_to_profile(edev, t);
+	return qede_set_v4_tuple_to_profile(NULL, t);
 }
 
 static int
-- 
2.43.0


