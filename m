Return-Path: <netdev+bounces-253020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rHOMMV1EdGlr4AAAu9opvQ
	(envelope-from <netdev+bounces-253020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 05:02:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1277C6E2
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 05:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FE763012255
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CE515746E;
	Sat, 24 Jan 2026 04:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKQBJOB9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399963B1BD
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 04:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769227353; cv=none; b=B/A1fki/fOOsvazmTiRz1HlHK8BWhyFDpWkAD64wlm8xptSXrZQTwP8IXIEZOIHJ7TUkwIkw8RKxxZyFwXidObQE9HuyAs4yLGR0j/VOREUwJ+9OZRXNAb854jjU7C2laY5f047DEYzkW8hMyGGo46ZyWqPXpie8T6BO4u3XjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769227353; c=relaxed/simple;
	bh=P9geLVe2oVR/Qa6smGpSjq/B5PdqKKd1wee8T0D5LfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pv1K/Au8b5+muP52VhTTeH/4Qgj7GhUEnhxDk9MO5qSdeZHaYTyfoLBHr1Tr8/DEkwc0XUE8LPgo9l6CLkqFpqOoS3J5wzROhKPJS1o+tOGyoYMyQnN4f4P2/+I66e529LBED8WrRGAffsx9wd6iuJlcwLel5kWlP4nxbCxJTVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKQBJOB9; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1233bc1117fso2488613c88.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 20:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769227351; x=1769832151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0OclSgaj9t5CvY0OtymbJspgBfc1tXWGj5iaVy0RbU=;
        b=ZKQBJOB9LDcghISbsiq0EimC+EQAB86PMkr/t8rcib1Pzx/pEfzI+oKh4ZVdCQTK3r
         pw9/AWyzPPeqbf+FSai3PYPXtXbc47rWWXfz/cGgTqMpTE75NxasxsfWWYkUN7MY6+gy
         SD+jrebcnpWItPl104SPfbCq+4IjP3AgwG9FuAI3I6L0phxV6QVs7h9mrPsfDSJv5tW/
         uX1k+1njs+94wHJ0seMvY2EuHpfzp4TnKj83+nowVtOZL6rjXsixEZ11H6zzXx/wL8P0
         b0YtrlO8XQ/yV4fsA14mWD8gipkn0hlB3BKhVVl4ST42JOJNqYEXTo/laugYmb53Le8M
         qqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769227351; x=1769832151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0OclSgaj9t5CvY0OtymbJspgBfc1tXWGj5iaVy0RbU=;
        b=MjhGKXEHetZkUTZj1wDB48ySyDdF3OEryQJYmDKTPX9umGc0y/bfFlnnAYGUUXjh0D
         +vDxli4xc86TxUXegvvcCChDIHOY4oqt6RxWwLJqsfxkC5eC1mA7sv8RZHcAVIaPzzzE
         LZb3QnFV1PLly/Wka61zh5fgkxSNZrhP6AtgKH9v/6YZnlPIDG0JbxgO/+p8anegrsm8
         wwhFn0TvpBCWljma6wWAinBaO7zeETNiYvae/gcqFZJ5dJexRJQdmdQ6ste44gahVgyS
         yAu/dgDjaDhU/g7NcXr/Exizk6uDrY+umttseMp2NRmlguYJnw12P2U1eEeZdbjfUcgv
         SfZw==
X-Gm-Message-State: AOJu0YyS3fuK9QiV18aM+6mcqpMj/4Lval6eFR5xv9gjhSzt2e92KKQU
	aXKv2nRp0NKAI/iNWreh++6pmtks5V741RSkcITSvDcgp3sNzzGdoCktRgGmZ7th
X-Gm-Gg: AZuq6aJYIH2+VLtl0LCDs+Ov/u9uZI7dkmFjJuo8Xr5FAgrAEVOQvi6GHHzrs36sOy1
	3vRRi5DfgQTYF7GwbVV8PYXeu+XwKtlPEtwgynKVBD9Cw8aDX51BcfH0AzwPcIig7QMjlO4IHvC
	ui6+TX6GkyggnaN96I5EgS/PDNVXSO1Ifbj8CNK1nBNG97dNhTeRvMPqgfGeblLmiHVf2HA2PoW
	ANlvy3V+tGSiIFb82usTKxos3Csv/4WasJzPHQYTQXTbXSMAjKQBxBJXVbSDCyYq98LkjkukCaM
	L7Ygn9ADlwXcM5FLU22XfCDe0j5ExeTJHR1zjT171RZ8BqNPAWoqVBYKjlw49yy8ENO9HsmIyD2
	wrFdvVBPNSosv7j8NLyB/2BqwFVPBNgu1rlqWNbV5DqZ0NFwkF39JG70OQZbgRC6v86/BWMMOCj
	uYUUI3127CG5qGSsvO8liG0eyDl6lzx7+WVruYB5RcV3ajCrTjIeDaPW+qm/HpIyDnGk9GbukST
	wadHsiDpSXUXbMLhyaHs/uBFSEt9/Ax/I+4odqFavHgQc1rPiOaqjD9WaCr4a+9GOKXdDbSWwAP
	4SeF
X-Received: by 2002:a05:693c:23c9:b0:2b6:aae8:6dc5 with SMTP id 5a478bee46e88-2b739830410mr2149484eec.19.1769227351249;
        Fri, 23 Jan 2026 20:02:31 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa08964sm5533779eec.28.2026.01.23.20.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 20:02:30 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: usb: sr9700: clarify code using BIT and GENMASK macros
Date: Fri, 23 Jan 2026 20:02:20 -0800
Message-ID: <20260124040226.34390-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253020-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A1277C6E2
X-Rspamd-Action: no action

The sr9700 driver contains many hardcoded bit shifts and masks. Make
the code clearer and adhere to the kernel code style by replacing them
with the equivalent BIT and GENMASK macros. Also take the opportunity
to align some indentation.

To avoid merge conflicts, code which is removed by other pending
patches is not modified.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/sr9700.h | 144 +++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/net/usb/sr9700.h b/drivers/net/usb/sr9700.h
index 3212859830dc..71a9d2335126 100644
--- a/drivers/net/usb/sr9700.h
+++ b/drivers/net/usb/sr9700.h
@@ -12,93 +12,93 @@
 
 /* Network Control Reg */
 #define	SR_NCR			0x00
-#define		NCR_RST			(1 << 0)
-#define		NCR_LBK			(3 << 1)
-#define		NCR_FDX			(1 << 3)
-#define		NCR_WAKEEN		(1 << 6)
+#define		NCR_RST			BIT(0)
+#define		NCR_LBK			GENMASK(2, 1)
+#define		NCR_FDX			BIT(3)
+#define		NCR_WAKEEN		BIT(6)
 /* Network Status Reg */
 #define	SR_NSR			0x01
-#define		NSR_RXRDY		(1 << 0)
-#define		NSR_RXOV		(1 << 1)
-#define		NSR_TX1END		(1 << 2)
-#define		NSR_TX2END		(1 << 3)
-#define		NSR_TXFULL		(1 << 4)
-#define		NSR_WAKEST		(1 << 5)
-#define		NSR_LINKST		(1 << 6)
-#define		NSR_SPEED		(1 << 7)
+#define		NSR_RXRDY		BIT(0)
+#define		NSR_RXOV		BIT(1)
+#define		NSR_TX1END		BIT(2)
+#define		NSR_TX2END		BIT(3)
+#define		NSR_TXFULL		BIT(4)
+#define		NSR_WAKEST		BIT(5)
+#define		NSR_LINKST		BIT(6)
+#define		NSR_SPEED		BIT(7)
 /* Tx Control Reg */
 #define	SR_TCR			0x02
-#define		TCR_CRC_DIS		(1 << 1)
-#define		TCR_PAD_DIS		(1 << 2)
-#define		TCR_LC_CARE		(1 << 3)
-#define		TCR_CRS_CARE	(1 << 4)
-#define		TCR_EXCECM		(1 << 5)
-#define		TCR_LF_EN		(1 << 6)
+#define		TCR_CRC_DIS		BIT(1)
+#define		TCR_PAD_DIS		BIT(2)
+#define		TCR_LC_CARE		BIT(3)
+#define		TCR_CRS_CARE		BIT(4)
+#define		TCR_EXCECM		BIT(5)
+#define		TCR_LF_EN		BIT(6)
 /* Tx Status Reg for Packet Index 1 */
 #define	SR_TSR1		0x03
-#define		TSR1_EC			(1 << 2)
-#define		TSR1_COL		(1 << 3)
-#define		TSR1_LC			(1 << 4)
-#define		TSR1_NC			(1 << 5)
-#define		TSR1_LOC		(1 << 6)
-#define		TSR1_TLF		(1 << 7)
+#define		TSR1_EC			BIT(2)
+#define		TSR1_COL		BIT(3)
+#define		TSR1_LC			BIT(4)
+#define		TSR1_NC			BIT(5)
+#define		TSR1_LOC		BIT(6)
+#define		TSR1_TLF		BIT(7)
 /* Tx Status Reg for Packet Index 2 */
 #define	SR_TSR2		0x04
-#define		TSR2_EC			(1 << 2)
-#define		TSR2_COL		(1 << 3)
-#define		TSR2_LC			(1 << 4)
-#define		TSR2_NC			(1 << 5)
-#define		TSR2_LOC		(1 << 6)
-#define		TSR2_TLF		(1 << 7)
+#define		TSR2_EC			BIT(2)
+#define		TSR2_COL		BIT(3)
+#define		TSR2_LC			BIT(4)
+#define		TSR2_NC			BIT(5)
+#define		TSR2_LOC		BIT(6)
+#define		TSR2_TLF		BIT(7)
 /* Rx Control Reg*/
 #define	SR_RCR			0x05
-#define		RCR_RXEN		(1 << 0)
-#define		RCR_PRMSC		(1 << 1)
-#define		RCR_RUNT		(1 << 2)
-#define		RCR_ALL			(1 << 3)
-#define		RCR_DIS_CRC		(1 << 4)
-#define		RCR_DIS_LONG	(1 << 5)
+#define		RCR_RXEN		BIT(0)
+#define		RCR_PRMSC		BIT(1)
+#define		RCR_RUNT		BIT(2)
+#define		RCR_ALL			BIT(3)
+#define		RCR_DIS_CRC		BIT(4)
+#define		RCR_DIS_LONG		BIT(5)
 /* Rx Status Reg */
 #define	SR_RSR			0x06
-#define		RSR_AE			(1 << 2)
-#define		RSR_MF			(1 << 6)
-#define		RSR_RF			(1 << 7)
+#define		RSR_AE			BIT(2)
+#define		RSR_MF			BIT(6)
+#define		RSR_RF			BIT(7)
 /* Rx Overflow Counter Reg */
-#define	SR_ROCR		0x07
-#define		ROCR_ROC		(0x7F << 0)
-#define		ROCR_RXFU		(1 << 7)
+#define	SR_ROCR			0x07
+#define		ROCR_ROC		GENMASK(6, 0)
+#define		ROCR_RXFU		BIT(7)
 /* Back Pressure Threshold Reg */
-#define	SR_BPTR		0x08
-#define		BPTR_JPT		(0x0F << 0)
-#define		BPTR_BPHW		(0x0F << 4)
+#define	SR_BPTR			0x08
+#define		BPTR_JPT		GENMASK(3, 0)
+#define		BPTR_BPHW		GENMASK(7, 4)
 /* Flow Control Threshold Reg */
-#define	SR_FCTR		0x09
-#define		FCTR_LWOT		(0x0F << 0)
-#define		FCTR_HWOT		(0x0F << 4)
+#define	SR_FCTR			0x09
+#define		FCTR_LWOT		GENMASK(3, 0)
+#define		FCTR_HWOT		GENMASK(7, 4)
 /* rx/tx Flow Control Reg */
 #define	SR_FCR			0x0A
-#define		FCR_FLCE		(1 << 0)
-#define		FCR_BKPA		(1 << 4)
-#define		FCR_TXPEN		(1 << 5)
-#define		FCR_TXPF		(1 << 6)
-#define		FCR_TXP0		(1 << 7)
+#define		FCR_FLCE		BIT(0)
+#define		FCR_BKPA		BIT(4)
+#define		FCR_TXPEN		BIT(5)
+#define		FCR_TXPF		BIT(6)
+#define		FCR_TXP0		BIT(7)
 /* Eeprom Control Reg */
-#define	SR_EPCR		0x0B
-#define		EPCR_ERRE		(1 << 0)
-#define		EPCR_ERPRW		(1 << 1)
-#define		EPCR_ERPRR		(1 << 2)
-#define		EPCR_WEP		(1 << 4)
+#define	SR_EPCR			0x0B
+#define		EPCR_ERRE		BIT(0)
+#define		EPCR_ERPRW		BIT(1)
+#define		EPCR_ERPRR		BIT(2)
+#define		EPCR_WEP		BIT(4)
 /* Eeprom Address Reg */
-#define	SR_EPAR		0x0C
-#define		EPAR_EROA		(0x3F << 0)
+#define	SR_EPAR			0x0C
+#define		EPAR_EROA		GENMASK(5, 0)
 /* Eeprom Data Reg */
 #define	SR_EPDR		0x0D	/* 0x0D ~ 0x0E for Data Reg Low & High */
 /* Wakeup Control Reg */
 #define	SR_WCR			0x0F
-#define		WCR_MAGICST		(1 << 0)
-#define		WCR_LINKST		(1 << 2)
-#define		WCR_MAGICEN		(1 << 3)
-#define		WCR_LINKEN		(1 << 5)
+#define		WCR_MAGICST		BIT(0)
+#define		WCR_LINKST		BIT(2)
+#define		WCR_MAGICEN		BIT(3)
+#define		WCR_LINKEN		BIT(5)
 /* Physical Address Reg */
 #define	SR_PAR			0x10	/* 0x10 ~ 0x15 6 bytes for PAR */
 /* Multicast Address Reg */
@@ -106,7 +106,7 @@
 /* 0x1e unused */
 /* Phy Reset Reg */
 #define	SR_PRR			0x1F
-#define		PRR_PHY_RST		(1 << 0)
+#define		PRR_PHY_RST		BIT(0)
 /* Tx sdram Write Pointer Address Low */
 #define	SR_TWPAL		0x20
 /* Tx sdram Write Pointer Address High */
@@ -132,17 +132,17 @@
 /* 0x2D --> 0xEF unused */
 /* USB Device Address */
 #define	SR_USBDA		0xF0
-#define		USBDA_USBFA		(0x7F << 0)
+#define		USBDA_USBFA		GENMASK(6, 0)
 /* RX packet Counter Reg */
 #define	SR_RXC			0xF1
 /* Tx packet Counter & USB Status Reg */
 #define	SR_TXC_USBS		0xF2
-#define		TXC_USBS_TXC0		(1 << 0)
-#define		TXC_USBS_TXC1		(1 << 1)
-#define		TXC_USBS_TXC2		(1 << 2)
-#define		TXC_USBS_EP1RDY		(1 << 5)
-#define		TXC_USBS_SUSFLAG	(1 << 6)
-#define		TXC_USBS_RXFAULT	(1 << 7)
+#define		TXC_USBS_TXC0		BIT(0)
+#define		TXC_USBS_TXC1		BIT(1)
+#define		TXC_USBS_TXC2		BIT(2)
+#define		TXC_USBS_EP1RDY		BIT(5)
+#define		TXC_USBS_SUSFLAG	BIT(6)
+#define		TXC_USBS_RXFAULT	BIT(7)
 /* USB Control register */
 #define	SR_USBC			0xF4
 #define		USBC_EP3NAK		(1 << 4)
-- 
2.43.0


