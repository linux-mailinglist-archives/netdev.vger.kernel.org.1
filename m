Return-Path: <netdev+bounces-191899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9B4ABDD0B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043FA7AB8AD
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE9242D92;
	Tue, 20 May 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNZ+pBif"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3ED24290D
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751149; cv=none; b=pWL2fE6AsOEKP2JnyWePnJy+iwICa7ynb3dgcx1x5aSFmvUrHPqKp6Pu36iS93dFotnGN/2fFFVYx/nRv48BxL75h1ygFXUGu6FGlSxzEjaOjL6X5IQfmOyX4wTZJ+j8AAFK/X33+SbaUGHDMWRud7T8/gDrqTkPi7GTW/7vZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751149; c=relaxed/simple;
	bh=lS9OWDi//f3vB7k3nDFQZ+474U5QwuKXEWwgoExcFA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nbt55SCQAMFDUIl6v/4uF57rppIOC15Nwi+ef2n5LYTU5jjnx5UQWByP7bq1M0sg/J2xGCHBH4EooAQfgs72pv8ACy6jUpMiTxgij80W5eyxahm/jHwlfWaFe20eFA3BHa97JkSY/rem2+jBySj0c5dRdR92LKh4YaRDJ8D0sZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNZ+pBif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47E4C4CEE9;
	Tue, 20 May 2025 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747751148;
	bh=lS9OWDi//f3vB7k3nDFQZ+474U5QwuKXEWwgoExcFA0=;
	h=From:Date:Subject:To:Cc:From;
	b=jNZ+pBifyT6QoV9RtWzM1qFe74jhN43YAvbTldmOnMyGK9iwHVvNo1EDzgSoaaGRl
	 coijngQGgY2Uu7lW1jPdm6Z8jLuC0W+Zphh8o/A0pkYy2rcHI6ioIOupwBB4c3Fdd8
	 c2uef9ojE3aUqo9GD2umS9oh+whSCGF+OSwJd+uVMv3pHhTeYWiVmrkvAU3H9ZtmmZ
	 3v90GOoDtDN9Ah1k3GcJhHMhQdmT5op/9ii4o44x3G7L8ZjPlxaWrEcSqgKvVUCur6
	 xMJGrcbyVB6M9RhwRIr08f03+/QdQXlZC9HOIB/etrLBkKS8zdSN5NpYqglEHduFEm
	 LsGuLPocVbirw==
From: Simon Horman <horms@kernel.org>
Date: Tue, 20 May 2025 15:25:41 +0100
Subject: [PATCH net-next] net: dlink: Correct endian treatment of t_SROM
 data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-dlink-endian-v1-1-63e420c7b935@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOSQLGgC/x3MQQqDMBBG4avIrB2IsRHxKsWFmn/aQZmWREQQ7
 97Q5bd476KMpMg0VBclHJr1YwVNXdHynuwF1lhM3vnggnccN7WVYVEn49DOAvEP6XqhknwTRM/
 /7kmGnQ3nTuN9/wBnW3nlaAAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.0

As it's name suggests, parse_eeprom() parses EEPROM data.

This is done by reading data, 16 bits at a time as follows:

  for (i = 0; i < 128; i++)
    ((__le16 *) sromdata)[i] = cpu_to_le16(read_eeprom(np, i));

sromdata is at the same memory location as psrom.
And the type of psrom is a pointer to struct t_SROM.

As can be seen in the loop above, data is stored in sromdata, and thus
psrom, as 16-bit little-endian values. However, the integer fields of
t_SROM are host byte order.

In the case of the led_mode field this results in a but which has been
addressed by commit e7e5ae71831c ("net: dlink: Correct endianness
handling of led_mode").

In the case of the remaining fields, which are updated by this patch,
I do not believe this does not result in any bugs. But it does seem
best to correctly annotate the endianness of integers.

Flagged by Sparse as:

  .../dl2k.c:344:35: warning: restricted __le32 degrades to integer

Compile tested only.
No run-time change intended.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/dlink/dl2k.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 56aff2f0bdbf..ba679025e866 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -329,18 +329,18 @@ enum _pcs_anlpar {
 };
 
 typedef struct t_SROM {
-	u16 config_param;	/* 0x00 */
-	u16 asic_ctrl;		/* 0x02 */
-	u16 sub_vendor_id;	/* 0x04 */
-	u16 sub_system_id;	/* 0x06 */
-	u16 pci_base_1;		/* 0x08 (IP1000A only) */
-	u16 pci_base_2;		/* 0x0a (IP1000A only) */
+	__le16 config_param;	/* 0x00 */
+	__le16 asic_ctrl;	/* 0x02 */
+	__le16 sub_vendor_id;	/* 0x04 */
+	__le16 sub_system_id;	/* 0x06 */
+	__le16 pci_base_1;	/* 0x08 (IP1000A only) */
+	__le16 pci_base_2;	/* 0x0a (IP1000A only) */
 	__le16 led_mode;	/* 0x0c (IP1000A only) */
-	u16 reserved1[9];	/* 0x0e-0x1f */
+	__le16 reserved1[9];	/* 0x0e-0x1f */
 	u8 mac_addr[6];		/* 0x20-0x25 */
 	u8 reserved2[10];	/* 0x26-0x2f */
 	u8 sib[204];		/* 0x30-0xfb */
-	u32 crc;		/* 0xfc-0xff */
+	__le32 crc;		/* 0xfc-0xff */
 } SROM_t, *PSROM_t;
 
 /* Ioctl custom data */


