Return-Path: <netdev+bounces-186852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A47AA1C05
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5801C179C70
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91C27933A;
	Tue, 29 Apr 2025 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se10ligm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD325FA07;
	Tue, 29 Apr 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957864; cv=none; b=npqzaEa6mey6lcZ2QY5V2NlhMvXUFV6GwmZeqkT5b1XXl/XAknsWXFtbOnCRBjkgNMZQAWUEbClyKTfDC71g2mzUQqKK33D5nAJ0CNi90Cu0DsDjH0qLT0NHkSDlcPKzlaXeD29ZqXyZTMlcskjJuuFD1sJ9X6d80VSTR/F+8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957864; c=relaxed/simple;
	bh=tEKgoAhmzAz7RoqlYHi7jk1HqzHnEX108NgPQ8Yg+lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYHbPBrH/8XKJmCNDKpNXSYWJSQjfWeHnJs1oTZqx3eeyDgHeEGBYIa6Ywd1MxsHNW9l8BtT7LEkGq3vWQ3easPEgL97XL7Gk0OzQoOTn/ONLtxgvxxMkUEO9eNs1j5MTg5SDTN+xGh0d4L9QxdHnO4Lvk7iRK2fxIuN+Nnin00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se10ligm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb39c45b4eso1029701966b.1;
        Tue, 29 Apr 2025 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745957861; x=1746562661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXNwoUZ6hC22doJH7VQvPeDIdfTefCUIkaPi/UWgWfQ=;
        b=Se10ligmV8wluqeb5gCxGG3Xo9EhKgY6Xf6/ycJV9IqL+FZioKaKM5Eg7Ufsw/qUt6
         E0cNY4UcjkPpyo7M2xyl5uuIu6mNKz0Tk4ItfKXQWFkIDnlkcgMVHkmJsKhEs2FRtaej
         FuAr/TflttGV5pQ8f1KLSXb8HXWJTuvWlqbcd8073C1554WDPW2JDbzNZMVhsl+S5lzb
         K/gq/GVtUgfZMz4jzsbDGu2LO4s7t3JSrs2xhXOXUdLkslr5PnEvsRpY9+cfaKDmCqxg
         tbntAAtS6PZqUvEUGUTIyInTRueIfOSmtAgdMZMKt03ImrlFjFG2p/cv3L69xwxnqOW3
         BNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745957861; x=1746562661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXNwoUZ6hC22doJH7VQvPeDIdfTefCUIkaPi/UWgWfQ=;
        b=UJZKCOFp13gPyBo8PxWIIASgYVBG5ptOue2qJVzIlrvlCi5yIjCMPfkUFfJLrQHg8e
         pvMQbSOv+T2DQOOq7xPQLyjcjMReGRIZj8iRVSW3WXhVu0LMoBS3P2eMFaAVkEaX+P44
         w6zm43mCVurVjFcSeHs7+RmNzP9arrpoj53jcacJO+hj7W6aibuwuRcSdJX5DcgLsM6t
         p9suXE0LtcODLTYo+dRnADLXwnvb6f8Lm2h4QPEiwD74DaraLsSgCn//kS6IyS5j+1bY
         RWxYP0tY8+x8VhFtvwl+bHR1exUqQAv2YaEf/TPNLss7UyQ8yDbPobd3OzfrtMqiXl4Z
         TZDg==
X-Forwarded-Encrypted: i=1; AJvYcCV/hWLLy+JadttBfXYbyyLri7i9YIDsxicSB54ByyYj+q6mv9YVhrwNiUqVlUqJd72QTB8rd8PL@vger.kernel.org, AJvYcCXklyBxR5QxsnYY7bbhyoJYjVlYhuG6ND1zkHk484tpmrCPcuioXWDYk4wTxVyjhwUvaoBSuxoWjyKkyL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwN90WKovFnnchXaI8hiosN/JSWk/wE8yXhAcxLyfHmVh2Bh0m
	XNEjIcWnfnSSoyXiH1taYKWcsZHUQrgXpn/qReXRMsgdpRojEkWL
X-Gm-Gg: ASbGnctLpyHVeULxQ09ZJQ4hh/1hlfF+S/Ow+4+48Wj8smIyuNLl6xMAfxWZSEHA03o
	KvFJ6puUFqQ0ayCUHZ78xyRR6QCuAGYO7J7zO3cbekTJQ33XDN2BYVRi3XSVKybXa2rNn0zpuOw
	et7bLRg6PZIKWFilzQhe1ijyjnjVDtUct2Fo278NEhp6FBpNUQHtbCSWTmvE6BehafFd/AQOlNk
	AqYmXaIdR+3rp/E0ELfmsICi8pTYqXM4IUMx2C73eL3ez2MP2fRdq6Cc2gcup9wZe1OM52C7ZNk
	EID+K3bSZCWKUGUcmninrVRQ8HvFYLdbj86CUr/fubOGD52mMfhmnKy724uS2WReg/z4V9Wl7b2
	5SHt8UMbY8maEoe5l6jc=
X-Google-Smtp-Source: AGHT+IF6SoZiSBcqvJqtqnhcuPK8c4eYyjZcPtVja7HqyxdLlm55bR38u9H/rgAZEfd4XmNuMwCDlw==
X-Received: by 2002:a17:907:9693:b0:ac2:9ac:a062 with SMTP id a640c23a62f3a-acedc5f1cb2mr65273666b.23.1745957860707;
        Tue, 29 Apr 2025 13:17:40 -0700 (PDT)
Received: from localhost (dslb-002-205-023-067.002.205.pools.vodafone-ip.de. [2.205.23.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acecdbbc6easm136021566b.88.2025.04.29.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:17:40 -0700 (PDT)
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
Subject: [PATCH net 10/11] net: dsa: b53: fix learning on VLAN unaware bridges
Date: Tue, 29 Apr 2025 22:17:09 +0200
Message-ID: <20250429201710.330937-11-jonas.gorski@gmail.com>
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

When VLAN filtering is off, we configure the switch to forward, but not
learn on VLAN table misses. This effectively disables learning while not
filtering.

Fix this by switching to forward and learn. Setting the learning disable
register will still control whether learning actually happens.

Fixes: dad8d7c6452b ("net: dsa: b53: Properly account for VLAN filtering")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0a7749b416f7..a2c0b44fc6be 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -383,7 +383,7 @@ static void b53_enable_vlan(struct b53_device *dev, int port, bool enable,
 			vc4 |= VC4_ING_VID_VIO_DROP << VC4_ING_VID_CHECK_S;
 			vc5 |= VC5_DROP_VTABLE_MISS;
 		} else {
-			vc4 |= VC4_ING_VID_VIO_FWD << VC4_ING_VID_CHECK_S;
+			vc4 |= VC4_NO_ING_VID_CHK << VC4_ING_VID_CHECK_S;
 			vc5 &= ~VC5_DROP_VTABLE_MISS;
 		}
 
-- 
2.43.0


