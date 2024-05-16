Return-Path: <netdev+bounces-96759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54548C7A02
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 18:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1960B1F22670
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E114D710;
	Thu, 16 May 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="mIsccNtB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0514D6FE
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875414; cv=none; b=rd/PTwxdqCh5JR4XobBgSqqP7WsGLZQZMkNfLGp62n1Y5jrjzGHUeadogLZELD1QHfLPj2hDXFM7suBhb8ormVfDjD+NjWi9fRoUwQoy+sWZn2EayvQeIJVW+ZsoGsaIhtHRK/YFJBg7GmtS6CtmdcDpYBF+xWxswMi3p/mJ0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875414; c=relaxed/simple;
	bh=w6Fg2JpsvdjRRkndeYWuK9Oga3yO+xojBx1QK7WwnvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0Ltb6ukKag0rHBoDbSovoigHsMm8zF87zA8XTtu/7hfZEljpuxT8L1zeYdr4Hludkf5du/Q7Ztdn5Eub1zpEK5fcDnHmXJ29y5JGD9brZg3FEpA0sne8D7CFmGGmT5tRr4Rkjm7AuG6erTaYIYf9/rU2O/8va11qqpVx3WjMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=mIsccNtB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5238cb1e3bbso1111450e87.3
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715875411; x=1716480211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAQn5ZJ029A4BYjWHjsUKX38oU4M2o9epOHX/AbRcWI=;
        b=mIsccNtB+LILRN5trg4ywr4p46ikEi760G/L0X4i6SQ6X9BvrcvaPogrHcJ5pQscrC
         j+thSgtyRqxvLo0LmjJr6OwkTt9Gg/ZjnyYl55wdTYeG+DoRoNMy3hgON45I5atOurcm
         pfrzowI8nUQtjZwH4xbSJZ4pwtxFRiV/OtXCjrEPs3eNLw15KKV8bB0esfTY+Seb9K/J
         MNj6ruKJzESBb0u3RB0DoFaHr033VzMMsGSBJfAG3BfluCku6IBN6zAUhLH5QtRoAWUW
         kEA3O85hJYMqo+w3UV4nGOkr+MUnlS1cJXXntfYmteIawAr0vWVumi/UAjbSo1OeVcU+
         ja7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715875411; x=1716480211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAQn5ZJ029A4BYjWHjsUKX38oU4M2o9epOHX/AbRcWI=;
        b=MnMwxA7fBbiH7wrWxTw6xdJ4W6Aqho1DBCuluCN9h97fC7ieqH5yOj9GY2hxS1M4Mi
         BgBiCEtqwiR2jFrvmTHJ1cFPAmTt2YG0o+08FPIf1vFb+VzF5mG87mOW8DM7WJU7zAXf
         CO6hLK05jbfjTV/4/81wdpCV3+weIXcUP1ZKGgK4APgY4zpb6jID3rp/qDv8WHIRsCco
         jSQ7Tc6lZuu4vfh2kyqpELIvNF4xw0ygu5rO0xUTd0yN6lzml3o7gJfTQRtpNjFmE5Ep
         zvTjt2AZ569Amw/SEDTwG/LRj3qgDe9z3wWgLLIutq3aXPe9GgISPaIyyE/y+jFu36Ae
         v+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXKpwmrNOvEcfMDl8exNnPpu56KEpaUpTWOFjQdx+axue41rJCj0T5NKSRgLGUvSUYrA82TMUoEWdYdoZrm/vg37WRzvpuH
X-Gm-Message-State: AOJu0YyZp5W1nJ92HAZA87upd9xjRYcIRG2sqvcpkGcWxh1q65GnIkYY
	Ytb285OrhxNYANz5njMpC5DBnuBwmGIGkPSMavIazWMdaLME8fNcVCkg+4+c0f0=
X-Google-Smtp-Source: AGHT+IEIrRIBOZMUkIkIqwr58hBnezl+CPbwEVWg81y2jWQugC79B8soRmnQGgNwxKLA+Ivy11jUBw==
X-Received: by 2002:a05:6512:3194:b0:523:b19a:25fe with SMTP id 2adb3069b0e04-523b19a28a8mr2745903e87.6.1715875410427;
        Thu, 16 May 2024 09:03:30 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc99sm19275156f8f.11.2024.05.16.09.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 09:03:30 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: andrew@lunn.ch,
	arnd@arndb.de,
	davem@davemloft.net,
	edumazet@google.com,
	glaubitz@physik.fu-berlin.de,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	netdev@vger.kernel.org,
	nico@fluxnic.net,
	pabeni@redhat.com
Subject: [PATCH v2] net: smc91x: Fix pointer types
Date: Thu, 16 May 2024 17:56:12 +0200
Message-ID: <20240516155610.191612-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <AEF82223-BB2B-4AF0-9732-0F2F605AAEC2@toblux.com>
References: <AEF82223-BB2B-4AF0-9732-0F2F605AAEC2@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use void __iomem pointers as parameters for mcf_insw() and mcf_outsw()
to align with the parameter types of readw() and writew().

Use lp->base instead of ioaddr when calling SMC_outsw(), SMC_outsb(),
SMC_insw(), and SMC_insb() to retain its type across macro boundaries
and to fix the following warnings reported by kernel test robot:

drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
drivers/net/ethernet/smsc/smc91x.c:483:17: sparse: warning: incorrect type in argument 1 (different address spaces)
drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    expected void *a
drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    got void [noderef] __iomem *

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---
Changes in v2:
- Use lp->base instead of __ioaddr as suggested by Andrew Lunn. They are
  essentially the same, but using lp->base results in a smaller diff
- Remove whitespace only changes as suggested by Andrew Lunn
- Preserve Acked-by: Nicolas Pitre tag (please let me know if you
  somehow disagree with the changes in v2)
---
 drivers/net/ethernet/smsc/smc91x.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 45ef5ac0788a..a1523fb503a3 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -142,14 +142,14 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
 #define SMC_CAN_USE_32BIT	0
 #define SMC_NOWAIT		1
 
-static inline void mcf_insw(void *a, unsigned char *p, int l)
+static inline void mcf_insw(void __iomem *a, unsigned char *p, int l)
 {
 	u16 *wp = (u16 *) p;
 	while (l-- > 0)
 		*wp++ = readw(a);
 }
 
-static inline void mcf_outsw(void *a, unsigned char *p, int l)
+static inline void mcf_outsw(void __iomem *a, unsigned char *p, int l)
 {
 	u16 *wp = (u16 *) p;
 	while (l-- > 0)
@@ -1034,7 +1034,7 @@ static const char * chip_ids[ 16 ] =  {
 			void __iomem *__ioaddr = ioaddr;		\
 			if (__len >= 2 && (unsigned long)__ptr & 2) {	\
 				__len -= 2;				\
-				SMC_outsw(ioaddr, DATA_REG(lp), __ptr, 1); \
+				SMC_outsw(lp->base, DATA_REG(lp), __ptr, 1); \
 				__ptr += 2;				\
 			}						\
 			if (SMC_CAN_USE_DATACS && lp->datacs)		\
@@ -1042,12 +1042,12 @@ static const char * chip_ids[ 16 ] =  {
 			SMC_outsl(__ioaddr, DATA_REG(lp), __ptr, __len>>2); \
 			if (__len & 2) {				\
 				__ptr += (__len & ~3);			\
-				SMC_outsw(ioaddr, DATA_REG(lp), __ptr, 1); \
+				SMC_outsw(lp->base, DATA_REG(lp), __ptr, 1); \
 			}						\
 		} else if (SMC_16BIT(lp))				\
-			SMC_outsw(ioaddr, DATA_REG(lp), p, (l) >> 1);	\
+			SMC_outsw(lp->base, DATA_REG(lp), p, (l) >> 1);	\
 		else if (SMC_8BIT(lp))				\
-			SMC_outsb(ioaddr, DATA_REG(lp), p, l);	\
+			SMC_outsb(lp->base, DATA_REG(lp), p, l);	\
 	} while (0)
 
 #define SMC_PULL_DATA(lp, p, l)					\
@@ -1080,9 +1080,9 @@ static const char * chip_ids[ 16 ] =  {
 			__len += 2;					\
 			SMC_insl(__ioaddr, DATA_REG(lp), __ptr, __len>>2); \
 		} else if (SMC_16BIT(lp))				\
-			SMC_insw(ioaddr, DATA_REG(lp), p, (l) >> 1);	\
+			SMC_insw(lp->base, DATA_REG(lp), p, (l) >> 1);	\
 		else if (SMC_8BIT(lp))				\
-			SMC_insb(ioaddr, DATA_REG(lp), p, l);		\
+			SMC_insb(lp->base, DATA_REG(lp), p, l);		\
 	} while (0)
 
 #endif  /* _SMC91X_H_ */
-- 
2.45.0


