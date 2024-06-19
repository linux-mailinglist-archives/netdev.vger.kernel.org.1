Return-Path: <netdev+bounces-104865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5123290EB69
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF481C20D9E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC9113E3EC;
	Wed, 19 Jun 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="k/Diwtyi"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110FFC1F;
	Wed, 19 Jun 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801321; cv=none; b=Pgp7feQpSz7ajhApiPGbhLJv33ua2/MHD7BjQY7aweUC3JqzG2zS+bhIdobxLm0gztmLycTKk3tTDSreISgYPQdv4F+ejBihYJsSGTGQxaCcQDxXA/1viEJkoa2M3BXYWTzsLl1ydN5vAzvjAvbDRC112ACy99OihV5BY6U2Oxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801321; c=relaxed/simple;
	bh=OHWOIOBjBCRQuNAj7n83ud8v2xOnjViAJG4kcJYodFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TwHZiz/BvX9sOfSye1RsjZCYkIIIrZTQ/yMXXhl39xHl/Wk/yufHYmlMBkGyKQEDmqonyIE9h7/PJOXfM0PHBakBvJ6VrcZnzTE1Gfm6hjoGZYMwkiYYh0+FvhoqzF4mqlR41Qg++T08j0TLp2HNqZimDEun7zuKpWe3scks7eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=k/Diwtyi; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BCF25A0A2C;
	Wed, 19 Jun 2024 14:48:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=vn9iUUr/8QwXG6yTcmlk+IU9py0tW4G8ZSAvItkMwdI=; b=
	k/DiwtyifUT2AY1Z1yow8AcFpF2Iq+hyYODzy2IwHY4JgJaVC3kuREIgCKqV+f45
	h/9ZGvqYTIL0G4Ir46OteKv9FnJPGy5qSP4txc9rFnTwhXzF0p/Nl1GtwVSZ2tpp
	JVudIeeAmPC3oqyueUnZcMIosJYLysgkwrYyG7JD6xskhgYpuXuruQLTU31nWGPD
	B9CqK6ASWM1ZIzJ1ZBLlLU49jaQ0ShMPuOctQ9EgzZU3BQ3LYZiuoWlTcFCZKOUk
	ru1SEhy82WSBH2Ua6yOxEXraBdzGjra+Wu+lkZFYSvNnyAxXuDN3AvAVuWJ9zrXp
	xUO3zp+2qnxdFtFgLzcDZeeEpfCZxkYPY+VrJgEhCFKG/lENQetmiKBAHzqw3WmC
	jb+oPySDLLicc3piivetT9jlky9+txAcbcYYZdagrgM2z9cXzq/JpqhR9TMV6LJE
	9/ExuilKmLRTPe7yc2F0GGZWrbMGPSGGuJfI8KqwjMpqvL8MImfmyoFAqk6PtKkF
	Kg9/8MqLo+gY3c1fJQ9n4eeHm1Qc24SvoNBVTOxTnxPa95ijU1YPU/qLr6eWk5Cp
	ae3JvLj3SYGVB3fx0vYNxSar+vg7C7WCL/Q9mVP+agudJh4X+NSB4io83HNB4j9c
	+l+NKJy4qGBsrWKnLFEqNEJhnRO3MhLiWwtDL0Fb6nE=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	"Vladimir Oltean" <olteanv@gmail.com>, <trivial@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
Subject: [PATCH v2 resub 1/2] net: include: mii: Refactor: Define LPA_* in terms of ADVERTISE_*
Date: Wed, 19 Jun 2024 14:46:22 +0200
Message-ID: <20240619124622.2798613-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1718801315;VERSION=7972;MC=3731793439;ID=564823;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A129576D7D61

Ethernet specification mandates that these bits will be equal.
To reduce the amount of magix hex'es in the code, just define
them in terms of each other.

Cc: trivial@kernel.org

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 include/uapi/linux/mii.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 39f7c44baf53..33e1b0c717e4 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -93,22 +93,22 @@
 				  ADVERTISE_100HALF | ADVERTISE_100FULL)
 
 /* Link partner ability register. */
-#define LPA_SLCT		0x001f	/* Same as advertise selector  */
-#define LPA_10HALF		0x0020	/* Can do 10mbps half-duplex   */
-#define LPA_1000XFULL		0x0020	/* Can do 1000BASE-X full-duplex */
-#define LPA_10FULL		0x0040	/* Can do 10mbps full-duplex   */
-#define LPA_1000XHALF		0x0040	/* Can do 1000BASE-X half-duplex */
-#define LPA_100HALF		0x0080	/* Can do 100mbps half-duplex  */
-#define LPA_1000XPAUSE		0x0080	/* Can do 1000BASE-X pause     */
-#define LPA_100FULL		0x0100	/* Can do 100mbps full-duplex  */
-#define LPA_1000XPAUSE_ASYM	0x0100	/* Can do 1000BASE-X pause asym*/
-#define LPA_100BASE4		0x0200	/* Can do 100mbps 4k packets   */
-#define LPA_PAUSE_CAP		0x0400	/* Can pause                   */
-#define LPA_PAUSE_ASYM		0x0800	/* Can pause asymetrically     */
-#define LPA_RESV		0x1000	/* Unused...                   */
-#define LPA_RFAULT		0x2000	/* Link partner faulted        */
-#define LPA_LPACK		0x4000	/* Link partner acked us       */
-#define LPA_NPAGE		0x8000	/* Next page bit               */
+#define LPA_SLCT		ADVERTISE_SLCT   /* Same as advertise selector */
+#define LPA_10HALF		ADVERTISE_10HALF
+#define LPA_1000XFULL		ADVERTISE_1000XFULL
+#define LPA_10FULL		ADVERTISE_10FULL
+#define LPA_1000XHALF		ADVERTISE_1000XHALF
+#define LPA_100HALF		ADVERTISE_100HALF
+#define LPA_1000XPAUSE		ADVERTISE_1000XPAUSE
+#define LPA_100FULL		ADVERTISE_100FULL
+#define LPA_1000XPAUSE_ASYM	ADVERTISE_1000XPSE_ASYM
+#define LPA_100BASE4		ADVERTISE_100BASE4
+#define LPA_PAUSE_CAP		ADVERTISE_PAUSE_CAP
+#define LPA_PAUSE_ASYM		ADVERTISE_PAUSE_ASYM
+#define LPA_RESV		ADVERTISE_RESV
+#define LPA_RFAULT		ADVERTISE_RFAULT /* Link partner faulted       */
+#define LPA_LPACK		ADVERTISE_LPACK  /* Link partner acked us      */
+#define LPA_NPAGE		ADVERTISE_NPAGE
 
 #define LPA_DUPLEX		(LPA_10FULL | LPA_100FULL)
 #define LPA_100			(LPA_100FULL | LPA_100HALF | LPA_100BASE4)
-- 
2.34.1



