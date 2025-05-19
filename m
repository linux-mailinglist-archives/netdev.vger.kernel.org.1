Return-Path: <netdev+bounces-191595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A91ABC5C6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46D83A50D0
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5A288C32;
	Mon, 19 May 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlK4iuRD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601FC27453;
	Mon, 19 May 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676783; cv=none; b=hOXzk41z2T0R87fct+1XaorrqJhbXSujmVxih7KGGyhynbwE6UuVL66jj4Oy9rXDp8Xic9u4kI054927rDPFMve5DlbmSZ6U/CRkphIJ9JneCxqpDnAq4O0hr/kUezN+EMTOYtk7KE9YPEwkrgssQjal9BPOo8/XJP+qaJyNW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676783; c=relaxed/simple;
	bh=q0AYkd4rGf074iXEnJ/QykPvc+gtxieVvJ0CM7zvddU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAokeaiQ6INJ6xEzM4Pstxt3FRsZt2dVQQWhdl0GKNifZbtiP19p9MfCPEoP5sBLR3+SgXQ6wuKQWV/B/qXgZRqps9TWlurjxh35l8DEY5lv4LHPVF+NDPEk8lHBpa3dT4sXK0uOPY1Lz3ElZwjy4/1ARbeOSI+o39oBumxWyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlK4iuRD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-601a5747638so3963081a12.3;
        Mon, 19 May 2025 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747676779; x=1748281579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seMvx2/HbYkcAE2ZuakaL1Z5/hGNc6djqCfoGNlK8Nc=;
        b=nlK4iuRDgd2wcQHSbKkr6uGSCpcyE70QuxWGHY2DZSbWirFNAxB6se/bblwDh5gn7j
         428LSicFF86+KBoe8b9UgWtWf54qvtaiJ1/EM+1C1BZLMSNU77gKrIEdRizDUIVZsBpH
         q15d+cwKr8wn2a6dtd/fssfzqN33S+FdTFCBWNbo6/VWSEsGwsWvw0gaB5smdmU6+VML
         hpnqTVEwKZHV8LwATO4c1KoDbrDWhKyA3pb+40Mq2xWijLQ6P3Pyj06ijB+8PcUJrHnd
         uvjFaGHiO/6zBudd+T5QsxfPV83k0faC2JKqhV+tPl8k8G5CWNs3uSwbpL0uz0b+Biss
         6LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676779; x=1748281579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seMvx2/HbYkcAE2ZuakaL1Z5/hGNc6djqCfoGNlK8Nc=;
        b=GotxmPNvLykfy4QntjdhGbmQa34EJktQeNEMfqBVGSL8apf42y6M4xma67looNiICu
         aQRL1SxXnCpR41LHQDUFJaiV4IYDo+FOYQUailAstCpC2mBcJLCjXCO4bVNZxBXb6cGa
         kpIS1MAcOmSNcuauHJYFpFF1z4osoLOzRmfVllLYZE0eXgPSipMGQDXDBnM8/sHQy6g3
         PP6o4dBdfvhjsEB+N7mWVP7THmKAELWxSzA6kqHDojxfZWqi/1eQQN+gryiay/9uTC8U
         GmGKrTx6+5qhQY/5sX69bgaFJBIKteJ3Z5IHR0qJfmLVsriSNhIq+uMbXp6cbzjll5nh
         oiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNz8mSl9aaBSd4FQWIfE7HjPS84AECdQu7tQh7XY/qgdoOytS38e/3CkEBh/RXujN5PyyZV59z@vger.kernel.org, AJvYcCWjOXOcnt+QZuwzsFTb5VxxcLsA4KnEESuIGh9ucJfZmk4+JtDixEVCeJUE7Pvbc/vRYiq49uQYqVvJayw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwufG491rZ17v8x8kIMRlvkgvKk9Ol57/eJRWQbQhxXgUYjWjru
	w48ylZHSEMvqOSGbsD561W0Ux+DpdhZYEdu51WX3vhte7mSv1OorOhVl
X-Gm-Gg: ASbGncvi0eL1KgNXxu1c4cZJsCYDK96rISO319NvfWJK/c58yuHqTpKqB8NECNbjYXp
	u6PWy5SuOpBJ05m9Gv3x6cSmLonvCkr4pHGhlHl+2Zt1Sfxliu+nGcvJbpmBK/XHRKoNfd2QwKQ
	J9wPfFymN6MwdvqHlv3JZ6wdw9RFHFCyi52/YECv8lJD53Vojo21UgLLrOPeEWueCOxBq/yAMji
	74wo0Bgvr1TEAJzelViijRv1pujdJP/wOFxxSpmipV5XH/eOpLylw0HbkJcCDumRWX/1QE83zIU
	iMBQY7bGHFepn1q7o5Kx32BTJBQfGwnuzNp8IkAavFQ9wLiF4y/nPiTeb03NX2P3+cWzoWkaZQ4
	hKOVjwl0YYmZVuHv6Bx2uA8MIZsBSnVY=
X-Google-Smtp-Source: AGHT+IELjEn5Rlp08nY8OrSEaAK7vJ5FeVhzbeUI79IxT37ccG1RxSir5CmWmniqRwKhAeMgPaeWvQ==
X-Received: by 2002:a17:907:7205:b0:ad2:409f:fe6f with SMTP id a640c23a62f3a-ad52d5d2fa4mr1536827966b.44.1747676779290;
        Mon, 19 May 2025 10:46:19 -0700 (PDT)
Received: from localhost (dslb-002-205-017-193.002.205.pools.vodafone-ip.de. [2.205.17.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4ea8aesm618980566b.179.2025.05.19.10.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:46:18 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: dsa: b53: do not enable EEE on bcm63xx
Date: Mon, 19 May 2025 19:45:48 +0200
Message-ID: <20250519174550.1486064-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519174550.1486064-1-jonas.gorski@gmail.com>
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCM63xx internal switches do not support EEE, but provide multiple RGMII
ports where external PHYs may be connected. If one of these PHYs are EEE
capable, we may try to enable EEE for the MACs, which then hangs the
system on access of the (non-existent) EEE registers.

Fix this by checking if the switch actually supports EEE before
attempting to configure it.

Fixes: 22256b0afb12 ("net: dsa: b53: Move EEE functions to b53")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 7216eb8f9493..a316f8c01d0a 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2348,6 +2348,9 @@ int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
 {
 	int ret;
 
+	if (!b53_support_eee(ds, port))
+		return 0;
+
 	ret = phy_init_eee(phy, false);
 	if (ret)
 		return 0;
@@ -2362,7 +2365,7 @@ bool b53_support_eee(struct dsa_switch *ds, int port)
 {
 	struct b53_device *dev = ds->priv;
 
-	return !is5325(dev) && !is5365(dev);
+	return !is5325(dev) && !is5365(dev) && !is63xx(dev);
 }
 EXPORT_SYMBOL(b53_support_eee);
 
-- 
2.43.0


