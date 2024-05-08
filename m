Return-Path: <netdev+bounces-94620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E2A8C0010
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81951C233B5
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24E886AFC;
	Wed,  8 May 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="scwWq6c1"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E153716F;
	Wed,  8 May 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178878; cv=none; b=iE3NgeoZqXrED2PJqOW84D6l15vNgXY0T41NLdnSpirGFU9NcfktyN8a0pFjQ8mqENIc6AoPNJhDM+0+FqqUiTiUGvY2QT4aCwmKfPEBYp1GDs/1hp2NUXWVknXyVPMuWZY8BEkEdaq5/e51qB+QcBbUQ7xXNDi+NxvNCi5fALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178878; c=relaxed/simple;
	bh=L6tUtjjwEalXnyxEbR/SPQOiHRyaF0s5LZSjg+wvO3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpPK0MLLZfFGnF2mzvZY546dYhZMdvfnw2tVf9gwmE195alt0M7GI/4WO2DJrMDQPX4fG0TlAOWlFlBLLBSyeAmPt0hLwYaQSuH0pGiE4ZteXKwKqI0vIQ0dzTPGWwWtsUO84dxr4vddgfc5TaIX5okaXHdLrFzvxg+VGxaEJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=scwWq6c1; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 80DEF600B1;
	Wed,  8 May 2024 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178869;
	bh=L6tUtjjwEalXnyxEbR/SPQOiHRyaF0s5LZSjg+wvO3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scwWq6c1Pt2/kLdr9IQpdlcytjQsMaV0PJAHX/D8+pczUSCm/GfHJ6yLDcM+kxwJ4
	 5buAArHU6cA87JtuUekyq4DO8CMZQL/mjhvDqh6aqz1mlt03a00jPERhTtj/WdyfON
	 Qo5POi2mivtvgNIY2asomaEF7fK65OPb28zgQWhazsAybL2hq9sGUIxrmlYTFelEpo
	 g5mCflG0Ca3vygMEQ46rMgv0EYTD36vci6tZDBXIKq+a6CYxAaY4LMPmyTLNOwRuhZ
	 HBJqgUmMFsBHPXLp/NUyZ9t9ZF+ZMsJNephET094UhXvS1A+n7ZGELh235Lz/qzFlg
	 Mvix4WMeplRxA==
Received: by x201s (Postfix, from userid 1000)
	id 9E2FD203E4F; Wed, 08 May 2024 14:34:05 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 03/14] net: qede: use extack in qede_set_v4_tuple_to_profile()
Date: Wed,  8 May 2024 14:33:51 +0000
Message-ID: <20240508143404.95901-4-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508143404.95901-1-ast@fiberby.net>
References: <20240508143404.95901-1-ast@fiberby.net>
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
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 0f951d00b10e..6f4c4a5d6c77 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1520,8 +1520,8 @@ static int qede_flow_spec_validate_unused(struct qede_dev *edev,
 	return 0;
 }
 
-static int qede_set_v4_tuple_to_profile(struct qede_dev *edev,
-					struct qede_arfs_tuple *t)
+static int qede_set_v4_tuple_to_profile(struct qede_arfs_tuple *t,
+					struct netlink_ext_ack *extack)
 {
 	/* We must have Only 4-tuples/l4 port/src ip/dst ip
 	 * as an input.
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
+	return qede_set_v4_tuple_to_profile(t, NULL);
 }
 
 static int
-- 
2.43.0


