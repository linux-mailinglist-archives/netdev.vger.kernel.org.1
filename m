Return-Path: <netdev+bounces-94617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735198C000C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05CE2833DA
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3AC8662F;
	Wed,  8 May 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="aqfQgT43"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719E86257;
	Wed,  8 May 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178878; cv=none; b=MjZUBLq2Uy8DMZPLqpa7LbCb+utj+lYKwFOrult+fN/b6jckik2z+jMJNUgTGQrcQzirJYGnXYNKZhRL7Rpx+ZxojKM3sfWT6aav6C8pXeiyIFmnb2JAlwa7wKbbXxv1cya+Zeiibz/QLqefH+2hLWV3uGa3o9waXGU9uq36hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178878; c=relaxed/simple;
	bh=uSVPzv+OmAG08dwGOq8nQVutiO7NPZmEV+r3FDMWn0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0kMpYiRSErWU7lp6V/X2tkFuoTG0uLhO2vuJ/ylYXsSU5vHrKpgtmSIhgKB/l1cVJxW+WM460Kh7SNZ7mJcPwtSA+z8H+4kEUp/Jt4/63ik5t3BA/PMoIditqsKaeZxYhXBB/Z05a7z9UzuxIcx1rkF8qkNo1OcAyc93KRpvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=aqfQgT43; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 98A7E600E4;
	Wed,  8 May 2024 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178869;
	bh=uSVPzv+OmAG08dwGOq8nQVutiO7NPZmEV+r3FDMWn0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqfQgT43J3YA8SzXRMF4mYdKyKxBmT/phqWCswZJgRWPXnte34h+vQToj5p0apBNE
	 0fnSgAxSSyfMka18vwWCmZlEKuDL3QVKQBz8UyN7mr4BTWZmRt8gT/17O9j+GjbGWB
	 w0HsgESw0Zmw5VHzdvc1hHwz2kIC/oVk+1i5ACasgrv0fwp5JxiwOp9DrAhHyfGRAD
	 GsD2v0NSiEY64Dbe9DtlifDrv5Rd+ng4B67xFaAVitR6dPI785RcsKVK2G5dbvrD3F
	 kPtkJ9Lj6m5ZMZpWl7PPDBsn+cafdK2kIvYXZpDWk6Bkrwm1/TaqBooA0ORDolcZ5F
	 Wr7tiMcHc86YQ==
Received: by x201s (Postfix, from userid 1000)
	id 6239A2039CD; Wed, 08 May 2024 14:34:05 +0000 (UTC)
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
Subject: [PATCH net-next v2 02/14] net: qede: use extack in qede_set_v6_tuple_to_profile()
Date: Wed,  8 May 2024 14:33:50 +0000
Message-ID: <20240508143404.95901-3-ast@fiberby.net>
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

Convert qede_set_v6_tuple_to_profile() to take extack,
and drop the edev argument.

Convert DP_INFO call to use NL_SET_ERR_MSG_MOD instead.

In calls to qede_set_v6_tuple_to_profile(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 600b7dc7ad56..0f951d00b10e 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1549,9 +1549,9 @@ static int qede_set_v4_tuple_to_profile(struct qede_dev *edev,
 	return 0;
 }
 
-static int qede_set_v6_tuple_to_profile(struct qede_dev *edev,
-					struct qede_arfs_tuple *t,
-					struct in6_addr *zaddr)
+static int qede_set_v6_tuple_to_profile(struct qede_arfs_tuple *t,
+					struct in6_addr *zaddr,
+					struct netlink_ext_ack *extack)
 {
 	/* We must have Only 4-tuples/l4 port/src ip/dst ip
 	 * as an input.
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
+	return qede_set_v6_tuple_to_profile(t, &zero_addr, NULL);
 }
 
 static int
-- 
2.43.0


