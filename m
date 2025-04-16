Return-Path: <netdev+bounces-183518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295B3A90E78
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5062C1903DD3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B5724888D;
	Wed, 16 Apr 2025 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="DZy4ur4X"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC723E337
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841574; cv=none; b=XG0uAxb1c1hq2z1yQ9WNWeRrGlYIjzvvEn7kwEDpMGS8duejEl7xX0DiyG4D51OktstqSw6bShAQKfB9mcKE2ymQ6wN8IBSEIqKcR3e49LtvzCGuTfS95vCQ3LQ6TQESfbrlQZosMyOAtr69Mkd7o1zMdLr0mW6RGWAME0WtUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841574; c=relaxed/simple;
	bh=qyZE63j0d2voV/G7WS3qaxVb9wlgL4RcIeSQSdW2Ax4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=On9AK/yI6GRYkNvQ2wC1JDsTJUogEIJV1z5d1ilkqNx2UOWo6J0kVmmyr+tG/+QA68+AVmNnKJgXL05v2UKVd7MYSpJRz31FD9wYHTiWfpxnOIQWum+qeamvv/KmmyN6v9IBnMY1h3Ze9I33mrUE4tIhimbvOsaoNYgN5scxY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=DZy4ur4X; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3771B2C030A;
	Thu, 17 Apr 2025 10:12:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1744841562;
	bh=zAjFq0x7xF/IjFaQL1u6DO3Ifg7t+tCKOWceVPvynI8=;
	h=From:To:Cc:Subject:Date:From;
	b=DZy4ur4XcsjoL13gV0HLq47lWFFRJR2LSWsZYrLX2MbIE/eZ9Hai5cIs0fOaNXmkn
	 hzJ1rJMyd1e2zmHTe0TtGgUWGxd6Y5E03opAVUPIl9I/SBZXikOtmnE0/KU0pFYBFk
	 78XM6lbEfYJ9mKhTg2f4pdmyqDOM0OYvokvyArKITlVFAPWpND1+UqKdMKrkzofPdF
	 Idzu9kTqjs/29bhc859kjn2SHOtH0grqyVQG+tRQFRfn/nz+jGqPKU/ywcZzS1PNcK
	 5+2kX+rOsSTXiCrlxbWUR9BTVmYr0kwbiLfZ+RFeKSOU63Uv47YxhCX5j4loN61dpx
	 9JZHlC+31tXhA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68002b5a0000>; Thu, 17 Apr 2025 10:12:42 +1200
Received: from rutgerk-dl.ws.atlnz.lc (rutgerk-dl.ws.atlnz.lc [10.33.23.32])
	by pat.atlnz.lc (Postfix) with ESMTP id 149AE13EDA9;
	Thu, 17 Apr 2025 10:12:42 +1200 (NZST)
Received: by rutgerk-dl.ws.atlnz.lc (Postfix, from userid 1868)
	id 093D33C0671; Thu, 17 Apr 2025 10:12:42 +1200 (NZST)
From: Rutger van Kruiningen <rutger.vankruiningen@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rutger van Kruiningen <rutger.vankruiningen@alliedtelesis.co.nz>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v0] net: ethtool: Only set supplied eee ethtool settings
Date: Thu, 17 Apr 2025 10:12:30 +1200
Message-ID: <20250416221230.1724319-1-rutger.vankruiningen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=W+WbVgWk c=1 sm=1 tr=0 ts=68002b5a a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=XR8D0OoHHMoA:10 a=hMUjD3Yoj6wRdRaDZV0A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Originally all ethtool eee setting updates were attempted even if the
settings were not supplied, causing a null pointer crash.

Add check for each eee setting and only update if it exists.

Signed-off-by: Rutger van Kruiningen <rutger.vankruiningen@alliedtelesis.=
co.nz>
---
 net/ethtool/eee.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index bf398973eb8a..1b4831ff9a75 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -137,17 +137,26 @@ ethnl_set_eee(struct ethnl_req_info *req_info, stru=
ct genl_info *info)
 	if (ret < 0)
 		return ret;
=20
-	ret =3D ethnl_update_bitset(eee.advertised,
-				  __ETHTOOL_LINK_MODE_MASK_NBITS,
-				  tb[ETHTOOL_A_EEE_MODES_OURS],
-				  link_mode_names, info->extack, &mod);
-	if (ret < 0)
-		return ret;
-	ethnl_update_bool(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
-	ethnl_update_bool(&eee.tx_lpi_enabled, tb[ETHTOOL_A_EEE_TX_LPI_ENABLED]=
,
-			  &mod);
-	ethnl_update_u32(&eee.tx_lpi_timer, tb[ETHTOOL_A_EEE_TX_LPI_TIMER],
-			 &mod);
+	if (tb[ETHTOOL_A_EEE_MODES_OURS]) {
+		ret =3D ethnl_update_bitset(eee.advertised,
+					  __ETHTOOL_LINK_MODE_MASK_NBITS,
+					  tb[ETHTOOL_A_EEE_MODES_OURS],
+					  link_mode_names, info->extack, &mod);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (tb[ETHTOOL_A_EEE_ENABLED])
+		ethnl_update_bool(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
+
+	if (tb[ETHTOOL_A_EEE_TX_LPI_ENABLED])
+		ethnl_update_bool(&eee.tx_lpi_enabled, tb[ETHTOOL_A_EEE_TX_LPI_ENABLED=
],
+				  &mod);
+
+	if (tb[ETHTOOL_A_EEE_TX_LPI_TIMER])
+		ethnl_update_u32(&eee.tx_lpi_timer, tb[ETHTOOL_A_EEE_TX_LPI_TIMER],
+				 &mod);
+
 	if (!mod)
 		return 0;
=20
--=20
2.49.0


