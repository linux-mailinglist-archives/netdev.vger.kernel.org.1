Return-Path: <netdev+bounces-94039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A984A8BE006
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B0328B201
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFD158A1C;
	Tue,  7 May 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="l3IOAuoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E69C152E15;
	Tue,  7 May 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078690; cv=none; b=Z47oYswcZysh+ivKX10udSVX3x/GSyt9/1T//nb2zk5W6lJ5AwxM/fS3BUxVIKnMLxjG3ycTR5ejwr00eFkOhdaRjiPSfhXOn+r6zhAPAFDspJVEiao0sPVCyW87NPirG95MiC2fnHwDvoMwxGFeE+K9nzniqKMoTn/qL5NEhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078690; c=relaxed/simple;
	bh=yKV+ra/o9RT6b8lN0TOrWt0cfArneZMIZQPZ6W8+EeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueclHdodDBH3mu+kdWpUgOZPI/KiVa0GmKdMuea0tXK3u0TOxWVtzoYayzDXfLyxlE/g3STEnDLXe2b+1ZCyr/akgbDGA0d36TNdDx/xrnF4cRECYC6XrmrVgVBdGLif4RzZXPFIBYP67jlF+EQagvosfPJb1jfVDsNvqjNQ8R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=l3IOAuoR; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 324CA600B6;
	Tue,  7 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=yKV+ra/o9RT6b8lN0TOrWt0cfArneZMIZQPZ6W8+EeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3IOAuoRpnw//T8YG3NOsMC5/VQ/ZleUrkU+FcyroZ9mBiaG73qyU7T5HZ5Ft0VHn
	 J+3X5CZ2kkBtyUo+7ata5hB7RrehlmSL9Iu4Z670P3gYOS8/FO4YSNQ0J1nFvB+r+8
	 axE0ezBSAc3GmF3y/YvGlzTrAan6Y6r0OHZ/5dhjknWCORmqtPXNx+G4bCMOEUu9AB
	 rUFIIGO7dl7Uozd7ty3pwTy59HPCbcejQeqnHgLwoX78bS84ZatUgDx6ZIVVs+RClK
	 F1nNRd8aMjnNm9H9Shps9hN0vL6wd/oKh9ZKpvMlW89VnB4W+lg1i2YSmn4sliosVS
	 Jqnkh3I2JLj+g==
Received: by x201s (Postfix, from userid 1000)
	id B679A2034AF; Tue, 07 May 2024 10:44:22 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 02/14] net: qede: use extack in qede_set_v6_tuple_to_profile()
Date: Tue,  7 May 2024 10:44:03 +0000
Message-ID: <20240507104421.1628139-3-ast@fiberby.net>
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

Convert qede_set_v6_tuple_to_profile() to take extack,
and drop the edev argument.

Convert DP_INFO call to use NL_SET_ERR_MSG_MOD instead.

In calls to qede_set_v6_tuple_to_profile(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 3995baa2daa6..19ffb0823d55 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1549,7 +1549,7 @@ static int qede_set_v4_tuple_to_profile(struct qede_dev *edev,
 	return 0;
 }
 
-static int qede_set_v6_tuple_to_profile(struct qede_dev *edev,
+static int qede_set_v6_tuple_to_profile(struct netlink_ext_ack *extack,
 					struct qede_arfs_tuple *t,
 					struct in6_addr *zaddr)
 {
@@ -1573,7 +1573,7 @@ static int qede_set_v6_tuple_to_profile(struct qede_dev *edev,
 		   !memcmp(&t->src_ipv6, zaddr, sizeof(struct in6_addr))) {
 		t->mode = QED_FILTER_CONFIG_MODE_IP_DEST;
 	} else {
-		DP_INFO(edev, "Invalid N-tuple\n");
+		NL_SET_ERR_MSG_MOD(extack, "Invalid N-tuple");
 		return -EOPNOTSUPP;
 	}
 
@@ -1752,7 +1752,7 @@ qede_flow_parse_v6_common(struct qede_dev *edev, struct flow_rule *rule,
 	if (err)
 		return err;
 
-	return qede_set_v6_tuple_to_profile(edev, t, &zero_addr);
+	return qede_set_v6_tuple_to_profile(NULL, t, &zero_addr);
 }
 
 static int
-- 
2.43.0


