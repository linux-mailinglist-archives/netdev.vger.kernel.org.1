Return-Path: <netdev+bounces-240193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 634AAC71522
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3F4452FFF5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510BB32C309;
	Wed, 19 Nov 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="mF/O4SqD"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3532A3C2
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592164; cv=none; b=FDlWwJwnGbo505JQ/ydh/pu5+nvoJeRZWdCDijN8JFstElYan2C919/ksauccxF1Csb5CpdtWXKMD2bOb8bXkLO4QOczpyHu/swhKYVRWUE5WVk4Ct6zhAS2t31scX0WVIo4JtbN3925CDsqxEvKgZPMQYZa6mTAdnxJVikgmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592164; c=relaxed/simple;
	bh=OFaVoQDDWiVDx4c2WXlL8vnBK1/eYof2473GrDd+z20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h51h/ecF5PFOf0/qZrijqiJCw1L4vTIp7nHMVZT941JE5rpd/lv+b5+hkCCbvgAZGIDBFbTd6Xx5wsf+9RdRn7H5qqvfWncC2hDVu2w1MIc6Ei6KN7Zew2u5GtKrfX6mxl5Z+JgVqAMtaissuR0XKbrDVbVEfXYg9i/1V4Wr4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=mF/O4SqD; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsk-006yoN-Bt; Wed, 19 Nov 2025 23:42:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=ROLxgtuAVt/BzKpbOFcQBVPVvKjXAYO6Mvo+kOdOmhM=; b=mF/O4SqDl18pINjtwUQmsPxwog
	liVwA+IGYpf3a28aKbL6BjgyfeRcXGnt2zSfggukEe147xoFkC1NvTaRupwBJ62DV+pQitFnZGSE4
	pG6B0KjgYV6e1u/QX/xS9j5AgzUr0fqXZEqmVQCzoUqNg+NR3INRR2z9H2c3x75U5VI2haDmIN1gu
	cwDqdUAvWnPZ4lbd2CNY19vx52egwEvxLZ6MIEGqrlT13pQ96tkgA4X0hguJlcDYg7hji2X4s1QFg
	yERus/EPM+YSBDe+bA3uof3SQ82hOK6Zsp23Pu+0EiAPHhPWQerPMrjFORepRSVvALpeqRTPoN1HE
	Oh7ySs4w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsk-000051-2O; Wed, 19 Nov 2025 23:42:34 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsX-00Fos6-RO; Wed, 19 Nov 2025 23:42:21 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 08/44] net: ethtool: Use min3() instead of nested min_t(u16,...)
Date: Wed, 19 Nov 2025 22:41:04 +0000
Message-Id: <20251119224140.8616-9-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

In ethtool_cmis_cdb_execute_epl_cmd() change space_left and
bytes_to_write from u16 to u32.
Although the values may fit in 16 bits, 32bit variables will generate
better code.
Replace the nested min_t(u16, bytes_left, min_t(u16, space_left, x))
with a call to min3().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/ethtool/cmis_cdb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index 3057576bc81e..1406205e047e 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -573,12 +573,11 @@ ethtool_cmis_cdb_execute_epl_cmd(struct net_device *dev,
 		while (offset <= CMIS_CDB_EPL_FW_BLOCK_OFFSET_END &&
 		       bytes_written < epl_len) {
 			u32 bytes_left = epl_len - bytes_written;
-			u16 space_left, bytes_to_write;
+			u32 space_left, bytes_to_write;
 
 			space_left = CMIS_CDB_EPL_FW_BLOCK_OFFSET_END - offset + 1;
-			bytes_to_write = min_t(u16, bytes_left,
-					       min_t(u16, space_left,
-						     args->read_write_len_ext));
+			bytes_to_write = min3(bytes_left, space_left,
+					      args->read_write_len_ext);
 
 			err = __ethtool_cmis_cdb_execute_cmd(dev, page_data,
 							     page, offset,
-- 
2.39.5


