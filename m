Return-Path: <netdev+bounces-131915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7998FF04
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE49B282F32
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866013D61B;
	Fri,  4 Oct 2024 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5TLBgmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578A12D75C;
	Fri,  4 Oct 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031644; cv=none; b=miUIZFRk2Vcu6I1Eg7Ze67TFmM4N2yTTr4zHG9YG5UCnt5GcpXuuhNzwEPM6kh7oDPIXt4j1GAmBQj2SbQqEt48a5+dDkVr9Wit30rwd3BhsjaROxpk/BTBwmWs5+2usFJ1+Q0fe3RsYBSoQK/owZk7f+lANj9h9d8osTgpELG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031644; c=relaxed/simple;
	bh=j0XtbA1YPMsOZS43bikeDwYQnZjDGrbXyo6RiT0DM+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUHOxdQ6MEvFkdVMFBrljkTQ9M/nDQs03yn0ZKbcD53VXdjQrpBoqfVjR/atvJntpb/d7t7Xc4hEiGEujNeT5R7wbEIhcfJJS5W32hDpz4jI2g3sn3LIMb1mncYCBl/kXUHCU0IIVBdi51yz+H2Fxs9cOOCAg7ORzkcXiz5w6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5TLBgmZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9909dff33dso282358066b.2;
        Fri, 04 Oct 2024 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728031641; x=1728636441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+uHz6Z0oZxs3e/gFjzrIcQSJKe/mqrd8qVDDtx+4IY=;
        b=W5TLBgmZWeUSTSwqvaEttSt5wkpOei9wAQ21yVRc9MWDKgHPimCLmqCB9RsnIsYAej
         JYIV01mSrg3K4dvFsfot/pcTxGeUtUSJTbkUHdB5Wapiwb3vA3elT2PNci+434sLa+h4
         f6AEnz5vWV5y5wZBMGfrdSugq2fT4p/6/hC8VfHgVckfbsJzW0cMrZhnPbeqk604xR2c
         tL8z5r6Bsi5uG5FsJX8r0G/wM/dbCv+uz70+Bh6nF2KChFyGZktnj0/E1EEcormmIBve
         ArlHO3mao5+JbjQrw+UFE1O2SkHFEClOyTAgn/KLOYL3JmFB3LuFist66iyRrdxe66LE
         Mjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728031641; x=1728636441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+uHz6Z0oZxs3e/gFjzrIcQSJKe/mqrd8qVDDtx+4IY=;
        b=Y/yrOF3EoS3ZvhQuGE2xhko8fnnUkgJcQRburYciimd8QzBEeQsRAZoPAG7hFUuD4/
         m2CeLzyhhULNmuCvY1YDU966HgEvgxwPE/G0ypqlyz+D57QHBiqboAOH8oAP/lJ7DeQF
         U3NExpqlfLwjGSmUTuRIpqkinWKLA1nKfZS6YgLs8ZazRBW/dpGtLhTgd0UAnl38RtD1
         smhdSE/XpCzS0ikQG3rY/1Hwhq4nDcTrH/Pe27d3M+YAISgZnqYdg58oYZ/uqT96lNlE
         4eecuLsryT5Zop+iUF5hIo1tm+LUL/t9ECIBEKACFFTCb6rCStS0+hqh7CfobBmg88fZ
         p8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU/HS72tEJ5zPMm4c/Q5+VZems5XOKb4MvHXDtoBwZXyb3suVTPPV+bW7xm7jDzoU2t3krS6/G08VZhUB0=@vger.kernel.org, AJvYcCXtO2+vS5uOQurp/AzhULKrivrFsavKqTSjbM4oCwEDNtN44oLi+8aB8ebvdL6A9yscFMpivxfX@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcq1B3l/xxN4OpLU8caV3Gm0g3mXrdabEMXjmOlpCBHurYKXU
	4AhTfIlIl0RKh8gIFxkoAjck4+PupOGwHaFzST72ArGxsIvgAjXZ
X-Google-Smtp-Source: AGHT+IEl46L4EWrS8Bnqee5NjXf1xRSgBbnQtkszPPy2a+EUIAhdJea96nr4iYmvC8DoZjBnMmGhXA==
X-Received: by 2002:a17:906:bc11:b0:a8d:446a:ded8 with SMTP id a640c23a62f3a-a991bd0b7ffmr190330966b.22.1728031640619;
        Fri, 04 Oct 2024 01:47:20 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99100a3200sm197443266b.4.2024.10.04.01.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:47:20 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 04 Oct 2024 10:47:17 +0200
Subject: [PATCH 1/5] net: dsa: b53: fix jumbo frame mtu check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-b53_jumbo_fixes-v1-1-ce1e54aa7b3c@gmail.com>
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

JMS_MIN_SIZE is the full ethernet frame length, while mtu is just the
data payload size. Comparing these two meant that mtus between 1500 and
1518 did not trigger enabling jumbo frames.

So instead compare the set mtu ETH_DATA_LEN, which is equal to
JMS_MIN_SIZE - ETH_HLEN - ETH_FCS_LEN;

Also do a check that the requested mtu is actually greater than the
minimum length, else we do not need to enable jumbo frames.

In practice this only introduced a very small range of mtus that did not
work properly. Newer chips allow 2000 byte large frames by default, and
older chips allow 1536 bytes long, which is equivalent to an mtu of
1514. So effectivly only mtus of 1515~1517 were broken.

Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0783fc121bbbf979abe6c9985b10cf4379bf2a9b..57df00ad9dd4cedfe9e959ea779d48e3f8f36142 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2259,7 +2259,7 @@ static int b53_change_mtu(struct dsa_switch *ds, int port, int mtu)
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
 
-	enable_jumbo = (mtu >= JMS_MIN_SIZE);
+	enable_jumbo = (mtu > ETH_DATA_LEN);
 	allow_10_100 = (dev->chip_id == BCM583XX_DEVICE_ID);
 
 	return b53_set_jumbo(dev, enable_jumbo, allow_10_100);

-- 
2.43.0


