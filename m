Return-Path: <netdev+bounces-109047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76036926AB8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 099D3B26C3F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D345194A6D;
	Wed,  3 Jul 2024 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmN5KjQn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D419415A;
	Wed,  3 Jul 2024 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043213; cv=none; b=n4MED36h7vSIRm3mGQac/2Ln7j+Xgf/YnZBqjw3kzTjbPBuymw05DH1qADfDrDfVjj88Yfe2gfMyMAF2hhB9SJ7eQfoWkzKm8/FMaE3+BkbBUbnXrNjzSU1t3hKL33kDw2/95jyP+VcNjmMma6wcByxh+DgJDd5mTRFiZzm4Ryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043213; c=relaxed/simple;
	bh=3qSiq1DaY7T+lFjqMIVDhf9Y3/hYRCA9oeS+Mu/i9Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q81iwasajv7ASUXPpddcXz75EJHQtf+P4hjhmDhlZGKi3zEZQFT9N1DE7SU7OvPGznhPNud7AHbb8t8N7nsjIaf+pniDMLuofjwirl99yG08GL21lpxrYn1v0my9nO+WG0WOjmKwpZWm9ahV25ElVCrJ5os2whflbjVM6mMRR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmN5KjQn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42578fe58a6so33533485e9.3;
        Wed, 03 Jul 2024 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043210; x=1720648010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+IpGYidkZlq3jAxOL88W5QAkvSJT2mwGo6JiSVcess=;
        b=MmN5KjQnS8CHQeIDuU4uyLypXgKDzJoPnk8dBS2rfRFXWrG6zSm0BfhKaaxhShK2NX
         0CiSB1YZV8Z4kIxQPJuxM0kILp3/RJ26Pnailr4PK5T5kDQOGXw6buPmjrtogCc1/Nwn
         2l4aCJTWtqem2rHKMkpycp/MpljDCgojUh441Zu6m5VX+jd8b7SGyEyf26axc7zz1d6E
         4KJNe3SElSSbIsI09qVpHBda6Hbem8PX3Ih+Wv+R7vdRRVcXJiPDBCe+0jlJRvob5Xao
         1pKeG3I/A81PrPcKtUupo1lujzvqEiC/IQiQ+8vrGHt0pe5+jWonifM7uXkC0LmygdBH
         UP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043210; x=1720648010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+IpGYidkZlq3jAxOL88W5QAkvSJT2mwGo6JiSVcess=;
        b=anrEqvhlsBbWgwzuySpdOKJxE2FzoJnWWGT75xh7ccgaEF+w7tBHnYazwzN9aLbJl3
         QQHSSk6u0xvkJLeQ7X3XnUNEsjONpSuFATm63Hd6TWGzs5cpAnnLRnPiF/wZBv4h3Z0H
         U2jYBwMpp9ruMdzw3vlV87VIOVO5ywm3fbGefn2pV7vIELMIU6m8Ntb+cSGRK/ynA3AN
         l1Zj6l52sY90QY7dc1AlNZD+XryFPfqqFySkBekSFsRUplv2DF+XBzCMjVtWKyJnzV4y
         fXwuXLXtePpwzWeRkmkZDOKwALbBwo5aPoWLhMnNgIYSTil9a4JNQ/7eW4Ka1Z4FwzV+
         WHvw==
X-Forwarded-Encrypted: i=1; AJvYcCWwKxTZKMiz34Z4quodUwJ/3Y4YLDjuUGt8+rkCzVIxkls7SUR4BXOZaqYbZ84aeX+uv2BDxsOEg2MDOkuPrDWPZ0tntVSMbPHh2met
X-Gm-Message-State: AOJu0YzmdGKAg18ddTXfQWml/ki/1D4pebKRYvXu8HtdsS7gesTtCK+n
	s1irfSnRcr45Cju7vRJPemrrgYN0QItaNv2JqHQWZuujE3hkiqBX
X-Google-Smtp-Source: AGHT+IFn4mlgKdpXTQZPW+0TatzoyCu4MvGGu19gCwPaJb+tTApgMTn9wKixCs95v8aAfkLy2pjS9g==
X-Received: by 2002:adf:e40e:0:b0:367:892e:c69f with SMTP id ffacd0b85a97d-367892ec6ebmr4680415f8f.13.1720043210224;
        Wed, 03 Jul 2024 14:46:50 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678fbe89cdsm3628068f8f.61.2024.07.03.14.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:46:49 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:46:34 +0200
Subject: [PATCH 2/4] net: ti: icss-iep: constify struct regmap_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-net-const-regmap-v1-2-ff4aeceda02c@gmail.com>
References: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
In-Reply-To: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720043205; l=1174;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=3qSiq1DaY7T+lFjqMIVDhf9Y3/hYRCA9oeS+Mu/i9Tk=;
 b=+4LXKg/t/wCB3c1GvgokOKJFBSz0JMNxotHbWtPblRgakW91X82dhDJM57P8C2lhKPjQN/sDk
 7N3QW0Tvi1+CDL2ckGe7ZpeJ1JH8wbbXXBcqNbYKUKfQ7xc+ccjZwbM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`am654_icss_iep_regmap_config` is only assigned to a pointer that passes
the data as read-only.

Add the const modifier to the struct and pointer to move the data to a
read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 003668dee738..75c294ce6fb6 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -95,7 +95,7 @@ enum {
  * @flags: Flags to represent IEP properties
  */
 struct icss_iep_plat_data {
-	struct regmap_config *config;
+	const struct regmap_config *config;
 	u32 reg_offs[ICSS_IEP_MAX_REGS];
 	u32 flags;
 };
@@ -952,7 +952,7 @@ static int icss_iep_regmap_read(void *context, unsigned int reg,
 	return 0;
 }
 
-static struct regmap_config am654_icss_iep_regmap_config = {
+static const struct regmap_config am654_icss_iep_regmap_config = {
 	.name = "icss iep",
 	.reg_stride = 1,
 	.reg_write = icss_iep_regmap_write,

-- 
2.40.1


