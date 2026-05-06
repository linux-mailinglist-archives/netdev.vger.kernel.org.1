Return-Path: <netdev+bounces-284888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJx+J9ZT+2n+ZQMAu9opvQ
	(envelope-from <netdev+bounces-284888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:44:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0584F4DC7A3
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE5A5309A04C
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E7548034F;
	Wed,  6 May 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7rs4Y4z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D347F2FA;
	Wed,  6 May 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077738; cv=none; b=JOl+DqzUibW3bB1hN+Jg7mQ5UgbsN9J6RM605+cQTmKilQ7khqxszdLCmk1ghEYbBB6G6ZDy+VQfly0zpanrmP87HRiJgSrkA/egC/mA730srvhSN3JwpaMPHAadgcTsixTwfti3kBsn3yGilKk50+uz5ZCHguJYiGKSGNL6q0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077738; c=relaxed/simple;
	bh=tlLa/cxGUfOgP/XWmgapLBcOqCG5atwBn4y/P+VjazM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0cpzGKHlirnNDyvS2naqwZBne1KCbcbiCSQpMUamQac1nGrv4QJUMNpoVKb86/3ESPoljedzs1Hn4z++kvIOfQt3CRCv5KolHwoFfUKJyMNZ68GK463mOdRyAywXTFcWHbhBqgejiGW0PsxQ/KDgvihgK38DCE+QVUqvzvLX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7rs4Y4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E04C2BCB0;
	Wed,  6 May 2026 14:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778077738;
	bh=tlLa/cxGUfOgP/XWmgapLBcOqCG5atwBn4y/P+VjazM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7rs4Y4z0OtJOw2ksbAOEAVsrLKw/xaWSlvknjBDx304G6r1mZ9H2o53DsxZR999N
	 8At6YZAPS/E26d59H7pxqjnRqgNUoP3oC4UgLuJdAJBCLZ2O0QKFLg7Sk5mSolV6aj
	 RcnsIndBoaxk8/EW9aaOEDTevYrjRn4hNpopRmdg4UQ/SAcxxCEr2tZvlcppMVDbuQ
	 /sFNqFwcWs3PrdWHQX1CJHC4wV7sCxOE5sQNRxOh/sSu0L+p0i6ktGb2zzcNs1RMzW
	 Hb0GfRSEiTAO6JENbC5zrx+tuqaW6DoWyHl1J35wbyA/L0R+70314EdHC3LC2RVuH3
	 mJ4DD4yK5vJcA==
From: Greg Ungerer <gerg@kernel.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	arnd@kernel.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	nico@fluxnic.net,
	netdev@vger.kernel.org
Subject: [RFC 2/4] net: smc91x: do not use readw()/writew() on ColdFire platforms
Date: Thu,  7 May 2026 00:26:44 +1000
Message-ID: <20260506142644.3234270-4-gerg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506142644.3234270-2-gerg@kernel.org>
References: <20260506142644.3234270-2-gerg@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0584F4DC7A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284888-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: Greg Ungerer <gerg@linux-m68k.org>

Modify the access macros and functions used to access the smsc hardware
registers when used on ColdFire SoC platforms so they do not use readw()
or writew(), or derived functions like ioread16be() and iowrite16be().

The current set of readX()/writeX() access methods for ColdFire have
historically been non-standard, in that they mostly access memory
big-endian instead of the expected little-endian. Before fixing the
ColdFire readX() and writeX() supporting code to properly work with
little-endian data existing driver uses need to be fixed. Convert the
smsc driver ColdFire uses of these to use the raw access macros - which
are well defined to be (native) big-endian on ColdFire. This change
requires some byte swapping at time of access to retain existing correct
behavior.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 drivers/net/ethernet/smsc/smc91x.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 38aa4374e813..1290335629c1 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -142,22 +142,26 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
 #define SMC_CAN_USE_32BIT	0
 #define SMC_NOWAIT		1
 
+/*
+ * Access SMSC device registers using raw IO access primitives. Byte
+ * swap as required for device registers, but not data.
+ */
 static inline void mcf_insw(void __iomem *a, unsigned char *p, int l)
 {
 	u16 *wp = (u16 *) p;
 	while (l-- > 0)
-		*wp++ = readw(a);
+		*wp++ = __raw_readw(a);
 }
 
 static inline void mcf_outsw(void __iomem *a, unsigned char *p, int l)
 {
 	u16 *wp = (u16 *) p;
 	while (l-- > 0)
-		writew(*wp++, a);
+		__raw_writew(*wp++, a);
 }
 
-#define SMC_inw(a, r)		ioread16be((a) + (r))
-#define SMC_outw(lp, v, a, r)	iowrite16be(v, (a) + (r))
+#define SMC_inw(a, r)		swab16(__raw_readw((a) + (r)))
+#define SMC_outw(lp, v, a, r)	__raw_writew(swab16(v), (a) + (r))
 #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)
 #define SMC_outsw(a, r, p, l)	mcf_outsw(a + r, p, l)
 
-- 
2.54.0


