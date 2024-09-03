Return-Path: <netdev+bounces-124714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8BD96A860
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F036B1C213D5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F9F18E752;
	Tue,  3 Sep 2024 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NczIjC1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE6188917;
	Tue,  3 Sep 2024 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395703; cv=none; b=UMNImiuXds0s4B+UR7a0h4K7Uh9JhnPrPTSN7KeYPEJOXs8fUdf4nNeFcKGsqovF4pDtPTu2Ep0weLxLyao1mzGZrp4alY8KxyrWcbP7tqmT/HJgEaFWNCCulIEY7ll4r0Xi8YS6aMrM6/aBS/6HTahQkxiQFJ5HTMWtc/E7TZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395703; c=relaxed/simple;
	bh=MAmAHiJ2lPFXGCFefAyosDLm/poiQFtq6dXASoHwu6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YaIF2MbAweuvgSGqCCFWbTSdHNrr04A8VmERsxgoZiejNLQks7zvDjarA4Y63Pr2ddIVy0YLM5vRZPZnLgzcl20Fcw279T5dPqQtWqnQjcJBoiH/tGfmGyq2JrguCavLHpkEHh/BYzVTQTnEA6csbiLFUsbnb8aVrYvhpNDIm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NczIjC1o; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8679f534c3so624532966b.0;
        Tue, 03 Sep 2024 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725395700; x=1726000500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGy0xFHNBWQDbcWAbCXy4rIOuu807VwzF77LdkaCDmA=;
        b=NczIjC1o8p1OUB8cubZE29IPDxcclkJEOeyhmT4XPWlDqOa8fCrlJhOzrtkc4rISj6
         ATuCG+XtWNB2n9mnvL+T0P3uw5OeEJxNzU6xTK6Ec1r38gjid64XbFEVLt0DVTvubLNZ
         AbvT1TIkgW9cB8StiEjykdZpd2ZsYPr77WDs7+FJMweGyws4RkxTmjTa9j5dHtHEE7iO
         T01y5/Z69x5nzzJnHEDcjxqOxIVJUwoeXiBjkcqIwK22Z/Pg0gOGEbFNMYNg+LES25FO
         QsLEYR/PMoiavbI08IygnaNbO8aQ6V1JwLTYOivM3CexisxX71Op3iZiAUbDMgsE06Ss
         naRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725395700; x=1726000500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGy0xFHNBWQDbcWAbCXy4rIOuu807VwzF77LdkaCDmA=;
        b=Wf89ZtGrxXYbu9CWvquXTN7A0/EROliGL4I4z/WGuory7wOzhBcyFkY1+sMoKIfKo3
         gzs50fyIfV2zl0OACC1vAg364ayCmJ82yN/IsxmM/RTxry+Exx01CDRrI4Ghy9dnYmJ3
         OkqNgW6YUTXiqWLEeYkfqech7st5VEaByFck+hu/jTr3uiOw1qbGv5ZSI3cmf9CMRvXm
         GfBnUehKrRVZSIMMMyVOpNV/4eknA72/0HOeARiagXxrdFNUsR3TRy29C6Xbor6ZBPdn
         aZKmRr2ZSJZY53pg2eEDxACGbJER0NmOJim6+DoN5ZZR5X9+0M++4l+WaefVC6higxHy
         zDGA==
X-Forwarded-Encrypted: i=1; AJvYcCXItebHFCSm1oaifUOmn9pfvL8mU7yW2yFzusPz8/WdRHNWDuJPg/JjQl2tIFc76Iek5Qeuw79i1uzWfQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKkvFCoKk93hYle+GJ2m7fPVWo0abLzmyFov0GbxA3aZdlVAi
	aodzjXqTx0MwKGyWzvzz0bmrXmPBI+d/Bg9XnWupPjRaa+smlANuogqerobj
X-Google-Smtp-Source: AGHT+IHZZIEK6Gg8cXVDkKnecVuhezjDdEtmqF8AnRJEcdnEpI5oluHWWa+jd5WzO6H4vxWwd2cc4Q==
X-Received: by 2002:a17:906:f590:b0:a86:f960:411d with SMTP id a640c23a62f3a-a89d872464emr812018766b.2.1725395699031;
        Tue, 03 Sep 2024 13:34:59 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989233403sm720395566b.212.2024.09.03.13.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 13:34:58 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: vsc73xx: fix possible subblocks range of CAPT block
Date: Tue,  3 Sep 2024 22:33:41 +0200
Message-Id: <20240903203340.1518789-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAPT block (CPU Capture Buffer) have 7 sublocks: 0-3, 4, 6, 7.
Function 'vsc73xx_is_addr_valid' allows to use only block 0 at this
moment.

This patch fix it.

Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index e3f95d2cc2c1..212421e9d42e 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -36,7 +36,7 @@
 #define VSC73XX_BLOCK_ANALYZER	0x2 /* Only subblock 0 */
 #define VSC73XX_BLOCK_MII	0x3 /* Subblocks 0 and 1 */
 #define VSC73XX_BLOCK_MEMINIT	0x3 /* Only subblock 2 */
-#define VSC73XX_BLOCK_CAPTURE	0x4 /* Only subblock 2 */
+#define VSC73XX_BLOCK_CAPTURE	0x4 /* Subblocks 0-4, 6, 7 */
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
@@ -410,13 +410,19 @@ int vsc73xx_is_addr_valid(u8 block, u8 subblock)
 		break;
 
 	case VSC73XX_BLOCK_MII:
-	case VSC73XX_BLOCK_CAPTURE:
 	case VSC73XX_BLOCK_ARBITER:
 		switch (subblock) {
 		case 0 ... 1:
 			return 1;
 		}
 		break;
+	case VSC73XX_BLOCK_CAPTURE:
+		switch (subblock) {
+		case 0 ... 4:
+		case 6 ... 7:
+			return 1;
+		}
+		break;
 	}
 
 	return 0;
-- 
2.34.1


