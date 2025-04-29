Return-Path: <netdev+bounces-186843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C4AA1BF0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4709A5CD0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75007265628;
	Tue, 29 Apr 2025 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDtx6dYH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503E262813;
	Tue, 29 Apr 2025 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957853; cv=none; b=D5e7Knq81IDU7YqmyCNEdSujEiPQdkwK38HGae2a8objOshlmGcwZAuL/Rua0KZoZFZOx7Yx/gh/3Wr2SUvV41TpzCGY+PV4thUu1MzsXwarSXATj5j4eqYBq35qBwnxunx8pwEu9quHkPptURL0Usf+o4+J3u8cun3zpvvaoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957853; c=relaxed/simple;
	bh=nDXJMRI8RRGWu/sT7bwwt2Ds1ltVyY2w1KlKeqFxM3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvJllRTu0/6aT/BqOoQuC79e/LnPw3NieELjxiiq7+R3s82CR64U0lbXntBO3NOaRdFndDh1NDq2Fs6wduy0C7IJHYpnHGjfVHsWUMqIXAYNECbxnpx1Wt8pF38ew3g4I3HGRETpEXjOAGxT/H4jPUcfGI5GgT+V3DG9WxQtQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDtx6dYH; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54af20849adso221586e87.1;
        Tue, 29 Apr 2025 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957850; x=1746562650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvC51MQbZRhHiX+q/EfkjiAsnNDHuxTQtXPBubp72ME=;
        b=DDtx6dYHC0U9tp5jUUr+PEO8sf8QQAtCjGDUsSlxxU0S3oCtD9Fm8S6tCLjBsuMUV4
         7kS3WWc41HUcmSkyIfFT0YyxKCecTHUJVUKyjPLou8iE+DK5RSGto//PcFQd6+aGGYKB
         hbV68tAeUorViEnIU7BNRLPi/ob7Mc7zn/0RHlYOQli1vXQWTMD9RUGR0g8T+XKxwPE9
         hvuYVivhCJe/UqX1tcRxMoPAQ271KezoRIDa9ivEeyyfWBA62+WKC6/1mHQ7KPLL6tdO
         UEyBbBu4G+GwW/eWa1w4+D1/Z0IAHPMJQkCT4BWW/eEEYCTFQ85wWEGGyPVEa+cq2r9Q
         gF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957850; x=1746562650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvC51MQbZRhHiX+q/EfkjiAsnNDHuxTQtXPBubp72ME=;
        b=RbeD9I/Ryj67yzOH+F0h2K6+v+hKnV/nrhzcwfKUPOLgKwOpMAqtVngGihVPP62hcA
         y4WdFR8cDkD1XAaqtyeO0cEcSNDAKsLqKJUd8BFsLeNbMFqPBAkHUU9Irx+wOmxBHcIO
         u5R+umccSb1BiFVnNBfbE6gVdXO4PZP7Bgm9eHSIt9PlJ89VtyFSSueP8CIfo70nojtG
         NXJNzbsOGY7CXugF0YNWuHl2mYcJjOeTQz2USYNNzPsZJy+OETcADaPL6AaL7SL64hib
         0gr7U0tvVI4ip+x3gCIMvIsU/5uo/R7vNfFLQMReDY/MUbiysdCNqUGxTwA4Uc8OnaCP
         /kIA==
X-Forwarded-Encrypted: i=1; AJvYcCUqIpuvGnaKSvZT9Xbjjwt8rgbDtoJBLD+aoN5Lowx+WWYlCC7NZ1gPoxGET7/c5TCFBSvf9vr3Ol9aniM=@vger.kernel.org, AJvYcCWmDeUT2n+Rur1BT5YQjePpIqXxiHCzJmNXzyYkE8RNT4JftTX8qMwnJz0Dfo94EeXY1C81mg98@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMUc4Y3T6MLIJDXHqR2ObVPK3CeBShQJsNWiM2vwpFr49xBXd
	HkssR7BAQgPOk+bpvZQXokZwhgIh8wQuzmOgvLbzw643KSih72Oy
X-Gm-Gg: ASbGnctx3BIYpJNhux3SCrcjLTUnujKKKs8D8wU/FBpEls+ahzf7GVo5Ofu+pLzF9M3
	lCGjHBwe7w8eLCAUTqX+YvYLInXqA+Bicny81swtB6cmeNB0GumtQptJ8DMHWIYBNmivnh+p2zs
	j3Z+95BEdXT3u057BM68eJ7JT5/7ItkVucKz5MEOqouSd8gNbD8mBPdWzBhy890hmiTP31nf7Cz
	8N8CQjuqaH7vnZWUZXq+Yo5PdTdt5WDgd3QNWyo2+VfEo3LDAMva9pXVOv8NPkyrQpEQ2R9JQAe
	i4YWvnNwBPYk7qY/Qd7VIPT3U2LVSQrY3kC9MYOMOFa53dU5Z37VloVspCn8wVX+mtYywTol1KQ
	wMA7VDDlZmDTnZdNPeyg=
X-Google-Smtp-Source: AGHT+IHIFuMg7jyYSGFsgMUD8LxKFxpwMNtRJOSrhtWUD8EnDztxeTKPlXhm8J16TdWRJem+yP+ADw==
X-Received: by 2002:a05:6512:2206:b0:549:94c4:9f01 with SMTP id 2adb3069b0e04-54ea37d22cbmr80804e87.6.1745957849339;
        Tue, 29 Apr 2025 13:17:29 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f703831b5csm7863022a12.65.2025.04.29.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:27 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 01/11] net: dsa: b53: allow leaky reserved multicast
Date: Tue, 29 Apr 2025 22:17:00 +0200
Message-ID: <20250429201710.330937-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429201710.330937-1-jonas.gorski@gmail.com>
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow reserved multicast to ignore VLAN membership so STP and other
management protocols work without a PVID VLAN configured when using a
vlan aware bridge.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index e5ba71897906..62866165ad03 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -373,9 +373,11 @@ static void b53_enable_vlan(struct b53_device *dev, int port, bool enable,
 		b53_read8(dev, B53_VLAN_PAGE, B53_VLAN_CTRL5, &vc5);
 	}
 
+	vc1 &= ~VC1_RX_MCST_FWD_EN;
+
 	if (enable) {
 		vc0 |= VC0_VLAN_EN | VC0_VID_CHK_EN | VC0_VID_HASH_VID;
-		vc1 |= VC1_RX_MCST_UNTAG_EN | VC1_RX_MCST_FWD_EN;
+		vc1 |= VC1_RX_MCST_UNTAG_EN;
 		vc4 &= ~VC4_ING_VID_CHECK_MASK;
 		if (enable_filtering) {
 			vc4 |= VC4_ING_VID_VIO_DROP << VC4_ING_VID_CHECK_S;
@@ -393,7 +395,7 @@ static void b53_enable_vlan(struct b53_device *dev, int port, bool enable,
 
 	} else {
 		vc0 &= ~(VC0_VLAN_EN | VC0_VID_CHK_EN | VC0_VID_HASH_VID);
-		vc1 &= ~(VC1_RX_MCST_UNTAG_EN | VC1_RX_MCST_FWD_EN);
+		vc1 &= ~VC1_RX_MCST_UNTAG_EN;
 		vc4 &= ~VC4_ING_VID_CHECK_MASK;
 		vc5 &= ~VC5_DROP_VTABLE_MISS;
 
-- 
2.43.0


