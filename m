Return-Path: <netdev+bounces-100981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10678FCE2C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3F287DDC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71911990A8;
	Wed,  5 Jun 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="DJ76Wr6w"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA135198E9C;
	Wed,  5 Jun 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589912; cv=none; b=FwAnR9BLrGKq2ZFpde+XY+5hjdlVVNA/XhkSuBF5SfYyKOxRvsHPBpKqw+nA7bq40IM+iBTedNCg/KjszzpIMIB64gVy3r3Wn/hyMdK1pLjR8zY49XLF142wO5oK6eHLS19DEzoYnspeZwYlv9ftPOnlLEERq3+5Os/X/JHZ7vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589912; c=relaxed/simple;
	bh=OEGFFgzorvoIISxO1ddymwwKh8N3kZGl60J2n1ay3Ts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLqQA6og6fXdZO+rh/jcEnSFkAThV1hgIg1A2yn6ikhOl7RgsMJhZZAkXG9XcBYpgvv8IbNj2YhsLl0AZzvy+Iprj0XxtjRny6tn2yxMPdm3Jw77zBJqT97TSAOI79kr2Agqj4mkryuDuZTLoIUmIFnBIUwC+7H9afwWrLCCIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=DJ76Wr6w; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9038FA0790;
	Wed,  5 Jun 2024 14:18:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=cWDTWe4febew1dygaNal
	dKWlPkHDtO7EmGo3QsqjVb4=; b=DJ76Wr6wPkWvQAC8oQQTC8I+SuamkIsqO5oq
	2eYoO1zlnIS2MiNtZowo0j6Xy46HcOmzUHrnXCcyLo3kZxiPjGvPgSbDzrhbPaRO
	F0jX7Nxv8m5xKLdEEuAndRDbOro7vCJM4WbFvLW+EONdi9K6WxRpk0IUoqgRPovB
	/z1WHwluBPLz5n1Ud14vtgH8uWujTZs2H8YMHg4kMRJFOGmQ/scseYMTpSxSN32l
	o4UHz9pMyE22xyuHAY5VKsdocVkIazE4F8DuflT1Ayh7p3gC+0yxHGNOj+vApKYt
	JxiSqVgzDVFktnw60iz/3uyx5KvoJ8YDWB6FUrf/tGsYboyq2kOxcvrrGUb8/NV7
	eC7kIhsRHarrtXoCIBxU/+q1H1Ickn3ukzLBOUF82c2RkNya0FxdG4SrjTj+X5WL
	AW5wZ1yGTu5wWoDwvL4Peup9ruq1+zyuaLV14y406PMvQUamWOTqhjYVrcWd/Tip
	58BglEe28ytLFUMBkfHQ0zA/i78mXerc3pdr+vjg29Yp+ik/roTjpfpmSqtsbkgI
	mkyJ7spjMMx7IIPUNoxOccP4RcBcY2YTnzBQUCFEJ+Z9sh1ouchu1Ecugcnwh3b6
	n+r7TFzhCgrthyjuemhX19S+QY0ySbs55qI5Do2mgB39VLN0ryqRL+eLmdZR7kzy
	55Tsgh4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	<trivial@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Subject: [RFC PATCH 2/2] net: include: mii: Refactor: Use BIT() for ADVERTISE_* bits
Date: Wed, 5 Jun 2024 14:16:49 +0200
Message-ID: <20240605121648.69779-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605121648.69779-1-csokas.bence@prolan.hu>
References: <20240605121648.69779-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1717589907;VERSION=7972;MC=372565145;ID=387151;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B54627663

Replace hex values with BIT() and GENMASK() for readability

Cc: trivial@kernel.org

Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
---
 include/uapi/linux/mii.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 33e1b0c717e4..f03ac3b35850 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -69,23 +69,23 @@
 #define BMSR_100BASE4		0x8000	/* Can do 100mbps, 4k packets  */
 
 /* Advertisement control register. */
-#define ADVERTISE_SLCT		0x001f	/* Selector bits               */
-#define ADVERTISE_CSMA		0x0001	/* Only selector supported     */
-#define ADVERTISE_10HALF	0x0020	/* Try for 10mbps half-duplex  */
-#define ADVERTISE_1000XFULL	0x0020	/* Try for 1000BASE-X full-duplex */
-#define ADVERTISE_10FULL	0x0040	/* Try for 10mbps full-duplex  */
-#define ADVERTISE_1000XHALF	0x0040	/* Try for 1000BASE-X half-duplex */
-#define ADVERTISE_100HALF	0x0080	/* Try for 100mbps half-duplex */
-#define ADVERTISE_1000XPAUSE	0x0080	/* Try for 1000BASE-X pause    */
-#define ADVERTISE_100FULL	0x0100	/* Try for 100mbps full-duplex */
-#define ADVERTISE_1000XPSE_ASYM	0x0100	/* Try for 1000BASE-X asym pause */
-#define ADVERTISE_100BASE4	0x0200	/* Try for 100mbps 4k packets  */
-#define ADVERTISE_PAUSE_CAP	0x0400	/* Try for pause               */
-#define ADVERTISE_PAUSE_ASYM	0x0800	/* Try for asymetric pause     */
-#define ADVERTISE_RESV		0x1000	/* Unused...                   */
-#define ADVERTISE_RFAULT	0x2000	/* Say we can detect faults    */
-#define ADVERTISE_LPACK		0x4000	/* Ack link partners response  */
-#define ADVERTISE_NPAGE		0x8000	/* Next page bit               */
+#define ADVERTISE_SLCT		GENMASK(4, 0)	/* Selector bits               */
+#define ADVERTISE_CSMA		BIT(0)	/* Only selector supported     */
+#define ADVERTISE_10HALF	BIT(5)	/* Try for 10mbps half-duplex  */
+#define ADVERTISE_1000XFULL	BIT(5)	/* Try for 1000BASE-X full-duplex */
+#define ADVERTISE_10FULL	BIT(6)	/* Try for 10mbps full-duplex  */
+#define ADVERTISE_1000XHALF	BIT(6)	/* Try for 1000BASE-X half-duplex */
+#define ADVERTISE_100HALF	BIT(7)	/* Try for 100mbps half-duplex */
+#define ADVERTISE_1000XPAUSE	BIT(7)	/* Try for 1000BASE-X pause    */
+#define ADVERTISE_100FULL	BIT(8)	/* Try for 100mbps full-duplex */
+#define ADVERTISE_1000XPSE_ASYM	BIT(8)	/* Try for 1000BASE-X asym pause */
+#define ADVERTISE_100BASE4	BIT(9)	/* Try for 100mbps 4k packets  */
+#define ADVERTISE_PAUSE_CAP	BIT(10)	/* Try for pause               */
+#define ADVERTISE_PAUSE_ASYM	BIT(11)	/* Try for asymmetric pause     */
+#define ADVERTISE_RESV		BIT(12)	/* Unused...                   */
+#define ADVERTISE_RFAULT	BIT(13)	/* Say we can detect faults    */
+#define ADVERTISE_LPACK		BIT(14)	/* Ack link partners response  */
+#define ADVERTISE_NPAGE		BIT(15)	/* Next page bit               */
 
 #define ADVERTISE_FULL		(ADVERTISE_100FULL | ADVERTISE_10FULL | \
 				  ADVERTISE_CSMA)
-- 
2.34.1



