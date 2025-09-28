Return-Path: <netdev+bounces-227013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EE7BA6E05
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 11:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F5717D23B
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C51C2D9ED0;
	Sun, 28 Sep 2025 09:41:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C162D9EFE
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759052483; cv=none; b=Cax5OKrGzsLCPFfxpOspKDZ7auE4fm7KRt3HwFWE7zC333BF6GijeKsHSxcSFqMNml2TgrFX0jbbRiE8mnRJNJo2+LYvaJhKt8Vk0PkYthFkuPIyjcC/ofb9aH0vGhPzE4IdDUSw2HypokILIzfFHMAdC70+HVAM0oSowbHlFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759052483; c=relaxed/simple;
	bh=UY7r4pvsQQZiuZWi1VNOgYBterjSoxTSbe9K4qOw2Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjtdCo3l0iY84YjL9nNKFMrMwKgwEvG1S+BuGF8fDgTlQxx3r4W7OHch0AhjexwEU2I9LbOmbWK5eiArYIWoxYwQNrkWd53GTE2CEPExLcXrwQyipEbniWOL4FwL4/85oG0PHAdDWw/2L6vGRqGi9rOA036Z87RV6EiudeS9pJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1759052373t245302ba
X-QQ-Originating-IP: JCkdoqmOyBziEXaBQ7AJ4xI1prm2JELfS57y0uSVzAM=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 17:39:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5898771607975799624
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 1/3] net: txgbe: expend SW-FW mailbox buffer size to identify QSFP module
Date: Sun, 28 Sep 2025 17:39:21 +0800
Message-Id: <20250928093923.30456-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250928093923.30456-1-jiawenwu@trustnetic.com>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MqpbfLd4w2KNuVBZXG/MthMvLdM/upgDVEdvawib+YXxSvb6FzGPDyGM
	G+Q54KCXjK29bBVDPNSNF8AR0uLh7Nu9nmVRtRVl29tteBwYcNcvUJd8ULB9I45MTKPrJkx
	sZ682+YJKPE0HC67b0e/XASRWZ0xQPXoVGq2uEYVEyh/0r29y9PCRJv73qvj2fNmTgY7koi
	VtIfcasP5II0Wl0PuotKCyQnhH8P75Mokt5aCdwwv8xILJA+EsV2nxQSanEsEdueuzktCRi
	OeyQWb76wjPI2f0AaepJMMKTTlb78JNsyh1VfxKSVFvsKd0ZxULzkmQ1ixnDfIQn2rEel7Q
	otEjibtR8vSVZTBz6ZxBX1nkmr4TRwW1LTTOy4gdxmW9PpuWi4fgd6WY3cqY8ywlfnOaquF
	Jlbo7MdMvKUZ4UMU1TC4BpMpXTUoS/bFu+yDcbi7zUp3I66XT7OxYmS5fW8tgqVXe6v4ZGH
	MzkWYTmL26iHwWlAXmRtH+aezjzrUHvZnSvh1xx6WUoCy41H0M/rzZex0dI5WWj8Yr7++HK
	Q5y/FLWFaslCiJDAwRg7eo3q4GDpZBd5WfVs9TiNHUHAf+MRWyCmNOPe6mcLajvsvQVPStr
	W1CnMZzHckan/aaRTs91uUpLnSRSiAnEvKPXIodRZBXuZFTZseiT2xcBTG13j1nhY8HDxYh
	PzH2shduXlFfh4KnI7Bv6a0sWzhcdhEIVvEIvQT2izlgBbI/g4IIotTOZDeXZXG67kEBqWS
	UuRmyKUipAnxshAZwWT7fkrt/msqPkdtIH+55Ia0iNNAOJkYkalBeZqJuvYOm2q8WRb8wJ9
	qfhPoDmH4RrlCYZXDiuBv5FJNmzrWgBi9hlujoLAZp4vzRRE92vDpBeX9rPfr3zhl9sT1c9
	1J3Q/k7JiyhhB1iKkmvY2/Y88CrjBGQ/SGhPRjL4B2X2v6Vul/tx9mDwEmUd3n4pPRrRw3k
	HG9yshYl/+oXTE4dV8U+vCaOOolNxxqAuhynxtY8zC0ZPx+Wuu/rJA2/wkgubrIeqRC2fVi
	YTIJHeZGqF/+Te15SD7eZGT1fYApaXR+UJLy9P3yCCr6NBxCbZq9OfwT0F1s4=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

In order to identify 40G and 100G QSFP modules, expend mailbox buffer
size to store more information read from the firmware.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 41915d7dd372..9d53c7413f7b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -352,7 +352,9 @@ struct txgbe_sfp_id {
 	u8 vendor_oui0;		/* A0H 0x25 */
 	u8 vendor_oui1;		/* A0H 0x26 */
 	u8 vendor_oui2;		/* A0H 0x27 */
-	u8 reserved[3];
+	u8 transceiver_type;	/* A0H 0x83 */
+	u8 sff_opt1;		/* A0H 0xC0 */
+	u8 reserved[5];
 };
 
 struct txgbe_hic_i2c_read {
-- 
2.48.1


