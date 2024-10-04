Return-Path: <netdev+bounces-131916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BB98FF07
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40122836B2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74917145341;
	Fri,  4 Oct 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA8MXLSK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAD13A3F3;
	Fri,  4 Oct 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031645; cv=none; b=dOhxvBcK5/qep4HatLKxG/+FF9FUt7ob4/F7yWCsRBjDiyeSC50osFlp1IiYWx/0TraFhoKLgHGMFEp47rhxAh8DDTHKRVbvhQqC1CMQzFJZ4+9YsBZgsKF7YHP6yASIXL+Wpex0qloQirxTtLSTJ0Hfk21KLRSRGVXz4Rp/kXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031645; c=relaxed/simple;
	bh=jTh66IgRLQjsX7hB4c9hKpfNe7DSjLUfWjG3OR911dA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RcNGoY9ELYPcX9k/3T6rjEPbDy9VjRr60P0uWZzgG8hRHncTL9iN8CEgI6x1kMd7e2hv3Fraj1+DrsmK93d69npBzqkaeMIRgHdylXQAWpxKjg1PuXkemkM5LXwF1heqsAy9/VABsvlIJ8E+UpoZ7RTeFGFMMX66sranbqSktJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA8MXLSK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a98f6f777f1so237600666b.2;
        Fri, 04 Oct 2024 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728031642; x=1728636442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWy1HOelWucrwLU1FdOaTSEr5fQCIepHI+fqfpA56Vk=;
        b=GA8MXLSKDrswRyXbXL0QyK9EjzJN0BeolmEWrFb7Zaqr0GmGh65ap3gMVsyJWQ/ZpV
         iuA7Wl+whsOWUWfQzBzJ2Dw+WUBIecU9ZhOgz0sYHerB5DhR5vqAC0htHZOxSFPiqR42
         DyaIaJhu2ho349+729TCznGHBS6W3jZAF1vVdo6FDc3y7J7HuUYIA5Ebflo8smjGFgyz
         oK95HJWoN4Ht4RP1w8mEEEu2k9kRM9m1U73bx4tej9QnF9NruQmC5FcUgpAR3iIN6Tfb
         gUJ7kHZ+6sf+/GyvmFHdPTPl0HaFFerYu466Cb2t8E1zWSzmTrpxcx0M68J2o+k2rZUP
         I5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728031642; x=1728636442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWy1HOelWucrwLU1FdOaTSEr5fQCIepHI+fqfpA56Vk=;
        b=Pv69gKbuWCKuR4sCWWxt8/zwfG1SndW8vygkAMVh99+lTZ8aCGY3qwNvxwYknhaBF0
         ir9exFRm239D+VMApdC9EBVxJZBfw/8YpaDC7LBeCzgfLoDVphLQuYX5BTxacyDYjeOB
         VMbYklo0hBNNtaABvb0T4uDwS/CcegFci3vrnVb7DVN2ShsOY2eMZVYRS2hA88U34pY5
         aqc6EvWiPQPw+b68KSsYvmV3mMw/z2E7hd8AlgQbBGg7CwzC0mq03lRQHINWIxOpTH9C
         vIwkuVCVKryTMYkfUMZKojtjTLWf7Ix+sWl8byAhZNsnSNTjNCGtTyZl7zbkF3CAnBto
         wV4w==
X-Forwarded-Encrypted: i=1; AJvYcCUutgtEuFc4vXTXLHJt1peaTX2Z/s70YDF9ekZWIyEI7tzyk+tQbz9CxZ19k3yB0ZQTEQpygVGO@vger.kernel.org, AJvYcCWe+KdlTzWXvzl961F1sFfHUISMx91VCYGAwaoSMeqhi7tzZAwe4bNu9tZ7UKKXjEQTDwwRKqVXnV4pjZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7KeLRV2/uNJrzyVSn0SfO4gcDH+H9lMd2+gNNy5R7/d/OPMp
	WoDZmuVwZ6cWVlPpfJW4a9KMGJsN+5zBI18vlkvZ6WP+r22lVN+2
X-Google-Smtp-Source: AGHT+IF+aP8ZBwo7hXQaad4Bg37iehaODpZwoGcfC4cTbdS3RPR7MjSunrxUvCNnYsxZqvYMe7dNRA==
X-Received: by 2002:a17:907:7d87:b0:a8a:792c:4116 with SMTP id a640c23a62f3a-a991c031850mr167621066b.40.1728031641675;
        Fri, 04 Oct 2024 01:47:21 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910472452sm195062766b.160.2024.10.04.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:47:21 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 04 Oct 2024 10:47:18 +0200
Subject: [PATCH 2/5] net: dsa: b53: fix max MTU for 1g switches
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-b53_jumbo_fixes-v1-2-ce1e54aa7b3c@gmail.com>
References: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
In-Reply-To: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Murali Krishna Policharla <murali.policharla@broadcom.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

JMS_MAX_SIZE is the ethernet frame length, not the MTU, which is payload
without ethernet headers.

According to the datasheets maximum supported frame length for most
gigabyte swithes is 9720 bytes, so convert that to the expected MTU when
using VLAN tagged frames.

Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 57df00ad9dd4cedfe9e959ea779d48e3f8f36142..6fed3eb15ad9b257c6fc3da20ce91b5e7129884c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -27,6 +27,7 @@
 #include <linux/phylink.h>
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <net/dsa.h>
 
 #include "b53_regs.h"
@@ -224,6 +225,8 @@ static const struct b53_mib_desc b53_mibs_58xx[] = {
 
 #define B53_MIBS_58XX_SIZE	ARRAY_SIZE(b53_mibs_58xx)
 
+#define B53_MAX_MTU		(9720 - ETH_HLEN - VLAN_HLEN - ETH_FCS_LEN)
+
 static int b53_do_vlan_op(struct b53_device *dev, u8 op)
 {
 	unsigned int i;
@@ -2267,7 +2270,7 @@ static int b53_change_mtu(struct dsa_switch *ds, int port, int mtu)
 
 static int b53_get_max_mtu(struct dsa_switch *ds, int port)
 {
-	return JMS_MAX_SIZE;
+	return B53_MAX_MTU;
 }
 
 static const struct phylink_mac_ops b53_phylink_mac_ops = {

-- 
2.43.0


