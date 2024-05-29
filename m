Return-Path: <netdev+bounces-99070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853F28D3988
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACA3288B23
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C215AAC2;
	Wed, 29 May 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="O32m8Npt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C48159901
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993784; cv=none; b=XLnLRHtudIM8CcfPHSJ8gMytf+HdP4/4z7uiwJPuiB1dyN92DhrBE5kEd+saSXHEQlsK0mq5j1wTDLwhtTdhkV4IJuBe+gQoKLQgVLnJS5Uh+mKHFILVk2wFsipkfdtwFV7HHcffJSdWIiEzAHhdKY2umi4hJDeKSvv4WSaf1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993784; c=relaxed/simple;
	bh=DYNP86csXlVe1mEXFQLBRJdCoowpQyBb1vDWFXaPUSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAFHgXue+aP8Jd4r93thmwiG4cjwWEWtdeOvaTa33OGbSYk5MjauFpSUqPNVqa5d6SFsl5tJbELH4HoKaoSsEA3Lvlpq54BrKx75AZDnJj9j9sn0E7vlaSxUEfaG6n8WkSqOU8FJD5hrC5qsRTM4J7/m+NLh1J1lfxX+jPYx62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=O32m8Npt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso204080766b.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716993780; x=1717598580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fftQnVeDno68x9iBUrR4R3cYGCa/SUe5rcprLn8zMNE=;
        b=O32m8Nptt83No2H09HJCtf3TSobcontBxIYoXtXd07Ay0DcTzev2Wp4J2b9A/zmMcw
         X2JXvW6UBWmaU33CPMDeZ2HRMXpIFk4JBwn7HcnXdnyFhnTR6Ycb3/HX6ZFMgI6X0/os
         WXD3uimLzpKUohNBHON1k8Jyfj+meZLDJLoFfKghSVSKdK8aUJa78NJI/uCc7VHokwfP
         zaEqBuB++d2rLM+Yr2+gE/GYK5byKi1k5PGYDiJlE+caijd6qnSJLD3ELfi0e0XIqhUV
         77QO4oNfiW/A0klMknBBuiraaEs+YN+gmq8FHEfQ+RtgIoOjFBR7Ld6Yy63aCBsIBo/L
         1H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993780; x=1717598580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fftQnVeDno68x9iBUrR4R3cYGCa/SUe5rcprLn8zMNE=;
        b=kT8NrjMGa1KB3A+VDXRZoHiRqpL5dtsP4o4gRKxfOnhRY/Wn7duQ9A9/juc0TfZcWG
         x1XvtzKusIroIxhAInAle9hgHAyiQRcV4AW2iNym2VWhvZpGDol9TFCTTwlCRE4LO+Z0
         K+QHKv4njY7wDXkSH8w6KRaun+Q0WDH6C4/SaMowOx0zMRBSW93mkFiHwmA40DkSXTIW
         Hhpt8e8JLSVS5lXzzf13R8gz3DpbQ8DQ3Q+I9fzoRb8LwyZb6fmM9N6A4Cye0WCX4C/X
         AnnTjfLdIMwfDKiItgSdsvaAZk/xaSnGE6vuIVVxEqmKn3G8O5D1LmzpMqmkd11ib4Tx
         ojQw==
X-Gm-Message-State: AOJu0Yw8HEwcRdxSolv8kr99bSNAqQR3seH6XT7RrG6CXx65LqldSNPc
	ifOndnLMl5KlBamLfiW5exB3o+/1I84sjDUSaNazTVCSm5WYzd4kVNHDjbVoklE=
X-Google-Smtp-Source: AGHT+IGs+6p/AwUfHoW7Gr/BlZoD5lAEX4gy83IcLlvRpoJh+8M7OUqis8V1yDYCyOK+GQIIT4AhrQ==
X-Received: by 2002:a17:906:f748:b0:a61:4224:c998 with SMTP id a640c23a62f3a-a6264f12995mr966600466b.54.1716993779804;
        Wed, 29 May 2024 07:42:59 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda48e6sm719337466b.203.2024.05.29.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:42:59 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	kernel test robot <lkp@intel.com>
Subject: [RESEND PATCH net-next v3] net: smc91x: Fix pointer types
Date: Wed, 29 May 2024 16:39:02 +0200
Message-ID: <20240529143859.108201-4-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use void __iomem pointers as parameters for mcf_insw() and mcf_outsw()
to align with the parameter types of readw() and writew() to fix the
following warnings reported by kernel test robot:

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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use lp->base instead of __ioaddr as suggested by Andrew Lunn. They are
 essentially the same, but using lp->base results in a smaller diff
- Remove whitespace only changes as suggested by Andrew Lunn
- Preserve Acked-by: Nicolas Pitre tag
- Link to v1: https://lore.kernel.org/linux-kernel/20240516121142.181934-3-thorsten.blum@toblux.com/

Changes in v3:
- Revert changing the macros as this is unnecessary. Neither the types
  nor the __iomem attributes get lost across macro boundaries
- Preserve Reviewed-by: Andrew Lunn tag
- Link to v2: https://lore.kernel.org/linux-kernel/20240516155610.191612-3-thorsten.blum@toblux.com/
---
 drivers/net/ethernet/smsc/smc91x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 45ef5ac0788a..38aa4374e813 100644
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
-- 
2.45.1


