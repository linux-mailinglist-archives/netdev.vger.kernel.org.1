Return-Path: <netdev+bounces-293834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C95EgizHWqkdAkAu9opvQ
	(envelope-from <netdev+bounces-293834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:27:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBBC6228B7
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1BA93001027
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AAB2EC08C;
	Mon,  1 Jun 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f+jso21f"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7C280331
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331188; cv=none; b=in391PzcI139qcCQQqS1RYgBAJ7kBErLw4V+kn4mktaxJRNx0iCT2MvL7Aiabnpbp4ZArYOuzoaxscbmKGILGym3GCyutUSBEIQKHXK9vz9BK0UyYfD++aWzISiK7D6QsG1EWtb3qBAlCFELc+zp24+AQuSE4aWuAEGQMLibmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331188; c=relaxed/simple;
	bh=xsTBy9U1GybjZPG4cm3YPotGskbmsGY9gHkMd+Xx3NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=jKCqBE4cXuD73BfmIVLEpGxDgNBkVvZfCSy88/lQzz5RHKFQENPQQq2UlC82wJ4tl/q+hd+FYWiP7OCWFIwajdtkVIP23FeYQODJYqOensLFbmXQ8Rne5BcdfPXbtzi0C6HqfbaHOs9Mnd8p/eRQVHb+p1t/AhufSP48OMTUX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=f+jso21f; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260601162619euoutp02523bb23af0b7f62d95273cdc0b9d018e~1AcaJ_MBu0606406064euoutp02g
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:26:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260601162619euoutp02523bb23af0b7f62d95273cdc0b9d018e~1AcaJ_MBu0606406064euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780331179;
	bh=NMTtZn1kNcWdm7VFVhS6xxDGyT+h+Mk+iRWar4DVUXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+jso21fnvE2cFntzgS/HRC1tCf0ExcEV1cbHLYRiHE6iKeo6CLvisnbWKQ8Lvejx
	 ahcDaZ4TlfdQZIAwF6AXszHR1phDe9OmO2Hsq2goIpBPleW7ALGfv+GbLik7I1TN/B
	 Xgi5LYCbvAwdCGH42SAAMW6ze1HgMsCaBgEErpgQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260601162619eucas1p19788338440838a1c071367c1b8772726~1AcZyt_Kr2164121641eucas1p13;
	Mon,  1 Jun 2026 16:26:19 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260601162618eusmtip13229bbb4c8e599a4e432205b9d669510~1AcZLGaXU1059310593eusmtip1X;
	Mon,  1 Jun 2026 16:26:18 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com,
	Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net-next v2 3/3] include/stmmac: Increase max DMA/MTL
 channel count from 8 to 16
Date: Mon,  1 Jun 2026 18:25:37 +0200
Message-Id: <20260601162537.553512-4-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601162537.553512-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260601162619eucas1p19788338440838a1c071367c1b8772726
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260601162619eucas1p19788338440838a1c071367c1b8772726
X-EPHeader: CA
X-CMS-RootMailID: 20260601162619eucas1p19788338440838a1c071367c1b8772726
References: <20260601162537.553512-1-j.raczynski@samsung.com>
	<CGME20260601162619eucas1p19788338440838a1c071367c1b8772726@eucas1p1.samsung.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,samsung.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293834-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,samsung.com:email,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Queue-Id: DBBBC6228B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Newer XGMAC hardware does support up to 16 DMA/MTL queues.
Add support for these after previous modifications of driver to accommodate
for that.

Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 include/linux/stmmac.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 4430b967abde..a9d19e2c388c 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -15,9 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/phylink.h>
 
-#define MTL_MAX_RX_QUEUES	8
-#define MTL_MAX_TX_QUEUES	8
-#define STMMAC_CH_MAX		8
+#define MTL_MAX_RX_QUEUES	16
+#define MTL_MAX_TX_QUEUES	16
+#define STMMAC_CH_MAX		16
 
 #define STMMAC_RX_COE_NONE	0
 #define STMMAC_RX_COE_TYPE1	1
-- 
2.34.1


