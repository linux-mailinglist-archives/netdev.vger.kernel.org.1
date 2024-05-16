Return-Path: <netdev+bounces-96803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D2A8C7E8E
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 00:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395DBB21BE8
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147BA19E;
	Thu, 16 May 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="BzltlsmX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F418635
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715898645; cv=none; b=mXSSFGQSK/ykwnF99TNs34YrpLRLFIkWIFCLgqCHgUXRBmI2E0PQW1Yo2LdlVDfcEqy/nOr4W83Y1AXfr0TfKiNpXmuNI7T213CUhj0nQB+9v42NTk+a9s+fxH5qc9FCtn/aFhTWFra8CbJQ3D1D5TtBJ6OqmCZyaM+hcq3OpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715898645; c=relaxed/simple;
	bh=ARToXvIE+HNxjlISN2Q5kpBnckBx7xHvzr6gl6pdKeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pu5Xkb3IQ7klS4ZyMsFSfuut5oD4Ekuf7ahiOvy/OLqXi5Pajc/W3zV93l/AJqYmKhuZfcGYS0TtuixdXfbKMjJbe3cI2He+NfmB/QV9cS6HUZHKFx1Dg9F7FA1sXIHQ04EPaw+H0YOUk+kLESLniVLgCMhu99WZNGIbbhTVTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=BzltlsmX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4202cea98daso7697285e9.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715898641; x=1716503441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/pJoZ2a5YCYk2F2tN9UoeXrlA20slErIO+lZsiZXcs=;
        b=BzltlsmXQ6vi8sVTUq5D2QrxlEpTZJSSdOUf6qHRvrz6CfzxoFH42DmY9HvamiNDuV
         m+zelLoJOt056nQ/K3sBW8NWSsEuIhwNmDukqJIZc5Nd2zjhhINCfPJNz/T4AMGYooT1
         L9Oy2K07gvPZBjRkzoZ6R03tQ87UN/7q0lGgR9gedBhN3csUFp9/mxLXwhyT1SxA4HFQ
         YinqO+67KXEOBI/Xuqds5KMmeU+qTuTQc2J8bSPXHxHJi1OcdPy+yapOZH2mWK7MVt50
         S1s20nbE7HYyLRJlIzrvYDrINclWWRwdKdi/p7T3HHflpdh3Hiz3Rto5K98QSJ/0FkPu
         1e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715898641; x=1716503441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/pJoZ2a5YCYk2F2tN9UoeXrlA20slErIO+lZsiZXcs=;
        b=PG2lrAp/pUESLNrJUwsww2agm69NNYaIL1uUHBii3arE+KM1xEAKH3NsjuBUeBXbQx
         27CkdW92BMms+bG927m7txk5bn0pTujcQjFDgGLckSkClnBfS9KamBDG0i9ZanAzdkqn
         On2b3BMnItZmx+0hknMyW+hCjtbRxX9ceNJg/34cD0XvlSeJjsf8qTTe1PdpNdEJZAV8
         CYQSAUEsZQPCf4VF3hHRht5eqawDvE8RM3nVwg1AYKxgeyS5Wkpb+Zr5z8D6VIX/Mvp9
         cfU8Xk5ffoQ0IZ5BxXCOtsoAigutLluPe/dz7rrKwQ/4YFKeD5vLMjo4nqHtcEsJMmrm
         zu5w==
X-Forwarded-Encrypted: i=1; AJvYcCWxv5eCn3rPZVPWJQPhigGQKFaTC0RcthqWgp9FQAOam4qXEtGp2kceQtIljqXgECm1W3uy4vNmHTvj53Qyec2QWY3Wg8qO
X-Gm-Message-State: AOJu0YzW6WdsCvMFcsuxaOU8bLWjzWtfLIonOOrVdxcL1Rp6yU5Gg6AS
	jW6bDL4B/wvE575n/EEki2VupS3PCcUidWXquM2T2LwtgM5c28eL8MMICRqxGY0=
X-Google-Smtp-Source: AGHT+IHbPX5/3T7ar9n1cgBRC/2xKml4wWUfAaWFjopc3F3/eOT++l7eIvrTF5/7vAE6QEhknFIdkw==
X-Received: by 2002:a1c:4c03:0:b0:41c:5eb:4f8f with SMTP id 5b1f17b1804b1-41feaa38a6bmr148836675e9.15.1715898640745;
        Thu, 16 May 2024 15:30:40 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4200f86ab7csm206682585e9.19.2024.05.16.15.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 15:30:40 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: andrew@lunn.ch
Cc: arnd@arndb.de,
	davem@davemloft.net,
	edumazet@google.com,
	glaubitz@physik.fu-berlin.de,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	netdev@vger.kernel.org,
	nico@fluxnic.net,
	pabeni@redhat.com,
	thorsten.blum@toblux.com
Subject: [PATCH v3] net: smc91x: Fix pointer types
Date: Fri, 17 May 2024 00:30:05 +0200
Message-ID: <20240516223004.350368-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
References: <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
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

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v2:
- Use lp->base instead of __ioaddr as suggested by Andrew Lunn. They are
 essentially the same, but using lp->base results in a smaller diff
- Remove whitespace only changes as suggested by Andrew Lunn
- Preserve Acked-by: Nicolas Pitre tag (please let me know if you
 somehow disagree with the changes in v2 or v3)

Changes in v3:
- Revert changing the macros as this is unnecessary. Neither the types
  nor the __iomem attributes get lost across macro boundaries
- Preserve Reviewed-by: Andrew Lunn tag (please let me know if you
  somehow disagree with the changes in v3)
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
2.45.0


