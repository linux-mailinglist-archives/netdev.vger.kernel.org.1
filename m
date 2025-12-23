Return-Path: <netdev+bounces-245782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193DCD77AB
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 01:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D94633015858
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 00:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3FF18AFD;
	Tue, 23 Dec 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNe8+ptv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79661367
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766448620; cv=none; b=LJjh6FktZCwgHFL9TSYin9kmJpOdh4sOlNraz0RRxlsDVOYNospfaZdZY6PvJPreVo2Zo8g5PPV7wvYmE1KfcPp1DHN9YgfOGJZv2IXogsStBCDY8C2hJ4ysfrZIie/kqlfYu3PAIRhLX1ouDXjoE23W27omW2NblYguGL2xPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766448620; c=relaxed/simple;
	bh=OoME8HiCOB2QSAwB6oNTCZhOVoVCLIefUmn/xAE5kFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3hvXQvycn+7f03kBOl0M7kndRkygK8TZk2lKfc0JLOVJ/5dqJJioduVcnw57sV9bicroPUnr/0RYFFaumYa53c7zBYeMakpOHe4agwGWvDnCsBU3dBuLGUatA9kPtfYcHrwogezc9kCxbCU0c/5ipSfCEPaMZG2XdKl9bZruh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNe8+ptv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0c20ee83dso56345245ad.2
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 16:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766448618; x=1767053418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6rg7xoTVJaIOPNc99KtvennzHNvfp2dvdfE5QIWA/J8=;
        b=kNe8+ptvbfEMKvQBP7xvIpS6AYDOlX172CjTebZBBAISK9CSKtoguPNnqgTb1VdMCC
         XGn4TAWCs7XXzeglGGQPrQnzqePdLrOrZgBSt5bvwSUp/r8cN74FtX8vwDANLVXe92FU
         2i8vQjIn2mf2gSS7Uyu1BPdglRD+4GdWoRCeH8l55kWa798mds1ZdB5MM1csvxvKLcYW
         Oc6tel+jp83S112yCwj4n4cJybwwEnGt2TM6fttIXAD8Mq7ickZEorD1Tw5caND211lO
         8FQoIIqalcTQAhjzPwFuagSTfhVqLzfcqgXLbQR5QmxBbCeH2zqvWekSVjq/xo/RDJFg
         HsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766448618; x=1767053418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rg7xoTVJaIOPNc99KtvennzHNvfp2dvdfE5QIWA/J8=;
        b=HF13iPbsF/WIkoATjDR4DTFRWyUneJs2MGhFLA6wwcd2ZXTMQVQnABEM2UhmzjOR1B
         dhHkeI6/9wns0IygeNg+vhAT1Cy9wFOkjAcMRSKbC+5gV/oGNwA5/9DKxTEHFa3Fk5uv
         IPDGAjz/LGPSz7bxL2dX165iHhaF3XntJWtk5r6QNSFJPyFrnbcU+khk0MCRgiaLBifg
         VEwm48alkYQOzQLd5YVMpABG9INbePiNV76C5K76GyuDgMHoSrRypWQVRMQ1EZ92BO3C
         CENp676RyX/U47mfZdog5SqhpJILms5CmS9x1AeJPidCIwgrtlxvf36etXMVRLcruGMJ
         o14Q==
X-Gm-Message-State: AOJu0Yxj9XGNtwczfYndE2zEloQyWWx0dLWyZCvdApGqTvR0k8AK3uES
	rrtZ0EDyjaM9osjxxEtss10LkU0PF+od5Ue8dql8HVcCi2AgVj+LTgij
X-Gm-Gg: AY/fxX4MLvZLcPg3Z4VUAFPxpIefQPT4rCEhSXMGRV2SS8bWRWqsX5KqC43AknKoi6T
	qaZCi4pSq9R0k7DIp5yZUw/eAH1uC/HyeF6qysFybKIR8Zec35KUQQ77pI8aNbJJXjRwFPeGBJx
	MGKqVKR2iIi+u1gfD06q1mGYqemoWrU4hNoLNe2OquZtZjHfG7+QUvCOUmOyJfNxXeveZ75/ukU
	jr+eo+KSDGRD82jv+wB+NeG+dYI0PcWas/s4afaiZFHk2luT5ynoB6REX1JNIJhPnkyGLOBMwUn
	Zdak6MyKkulx+BiHt0kZGDrhcouPWMdTJJnfyE+mUt8XdF3XmsF/F0hAzWR+vLaG/UGakMnh0JG
	Fo+XAFDTqaE1cd83ws0J0HpGeI7AE/S0sdT6wlCjzrG0TWA6TQ1tl88Vo/Bu9LdUs50nUT9JLhT
	tTBS0ROz/HaZ1eebh/Uik=
X-Google-Smtp-Source: AGHT+IEKGii1/n0GFocrwp24FZsJSynKEYdhUfonNSCQoPQjwvdqwur2opQDFyHVcrg6Wugb5nuaZw==
X-Received: by 2002:a17:902:fc4f:b0:2a0:d59e:ff67 with SMTP id d9443c01a7336-2a2f2a355e3mr138303165ad.38.1766448617900;
        Mon, 22 Dec 2025 16:10:17 -0800 (PST)
Received: from mythos-cloud ([61.82.116.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34eacbca905sm3884167a91.5.2025.12.22.16.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:10:17 -0800 (PST)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net] net: dlink: mask rx_coalesce/rx_timeout before writing RxDMAIntCtrl
Date: Tue, 23 Dec 2025 09:10:06 +0900
Message-ID: <20251223001006.17285-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RxDMAIntCtrl encodes rx_coalesce in the low 16 bits
and rx_timeout in the high 16 bits. If either value exceeds
the field width, the current code may truncate the value and/or
corrupt adjacent bits when programming the register.

Mask both values to 16 bits and cast to u32 before shifting
so only the intended fields are written.

Found by inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 846d58c769ea..f6ec0e4689f7 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -590,7 +590,8 @@ static void rio_hw_init(struct net_device *dev)
 
 	set_multicast (dev);
 	if (np->coalesce) {
-		dw32(RxDMAIntCtrl, np->rx_coalesce | np->rx_timeout << 16);
+		dw32(RxDMAIntCtrl, ((u32)np->rx_coalesce & 0x0000ffff) |
+				   (((u32)np->rx_timeout & 0x0000ffff) << 16));
 	}
 	/* Set RIO to poll every N*320nsec. */
 	dw8(RxDMAPollPeriod, 0x20);
-- 
2.52.0


