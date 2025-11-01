Return-Path: <netdev+bounces-234843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2498C27F61
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 14:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 366084ED1D8
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE6B2F83C2;
	Sat,  1 Nov 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QphTfCzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E92F60C1
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003698; cv=none; b=Lzf/486jaEJIKIDJjA6Y+dw/elmUEu8+JS5XC4TP1rqbTfaIHLxD2iOPX97igR2dN7QB3rbNKuQenCX8DfSS7n55ow56frPhmGFAXG/g8A4lAvu4F/3gJ8RJk8IQOhBO0Uuzkvkt+5gAXvxI5/Jwra7myga/2t/P6XBs6HyHdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003698; c=relaxed/simple;
	bh=p/JaJlQiawxX+qh5jQdUefNsfFmb3Jnk5eyI2KNhtQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYrY14GLsWoYrVSzubcPWZrCT1Pc93rcgq4ieIK07HiZT+lo0AJlCc1bvMLU4NZypYwxrUzO8HJUw5fWZNkRQeVq9PyMPT/e8rsUgrVWj5BuebGHcHsh5edXXvY+8CHs0cBK2qYMjoK7TtVGJVtFEPDS/XaT6Q9d5jYayfrJSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QphTfCzi; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so4584266a12.3
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 06:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762003695; x=1762608495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyUKEht0XIqrrj737jBfGR8saqpCsaWS6/0aBz7Ix5A=;
        b=QphTfCziKDbHio5XHJ1QIUEWQVLgknzt36XP84oKHudsQByD07qzLiXDgUcpM/yPVp
         x8/8OQ3XNVD9pVBOfYCVFbzchldcuyLa6Z8RTx3k0aGsurOChndjTYD9WlT68Z8RAnMc
         YDRYJeoplpMfk6W9F2oAbpRNL57nGJLdlW/xcrCanNcGlKW6qbg62WXR+v9L6EqQ+ZRA
         BCsSSdPuNqKD41Ob8cIyMmiSoHlG2wspBlWvGp26IHuir7nQLGSwDjELN7lZX5tB+JW+
         75LDHXreg4U8X020nEsG3TApYBYhEVuKiCvMgJnPSF9jydeM2/4tw1jWbaJ8ZwbkoaZ7
         nx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003695; x=1762608495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyUKEht0XIqrrj737jBfGR8saqpCsaWS6/0aBz7Ix5A=;
        b=vymUoMgxwFa55aoGWkTabI7ZJuXwUJIDcthI2hY6vvAGRz+llsTVTrl78m55hFy0km
         lKZ6i/4z9TnGvH6U2CH6je0NLj6YvQod5VQ4Tc0Vf+fR3eaLwnaPg9sqFlY1okkottyk
         LmCJ1BJVjC3U/pld2nf1LXvmVfbTxVXW21o5dVl6+OkFnKPMqq9kGFntLd2D3L0Y7Ttx
         XM3eNHM5H7NMW7CveN5Z4uco5gocTI+64xpamT9VKFh53a94XkSaJviAC1I+AjZBWIgW
         mjeRnqdzf7Vd8xQnlxNqny47woSXbs3h9YRz/eeNjxaLaDjfRvrDqGISRtqDwxjek0Xp
         Z/xA==
X-Forwarded-Encrypted: i=1; AJvYcCXAAkYc0Jy6GU+6Yqvuo2dSa7WL0EK2i5wGp+MZhkF2MQfTZSXtfqiaiJXTszsFK2906ugmOy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ3zG2cMFIRAlsXmEBqGozahbmVO7CXZzMKHxpykt1QCPpExHJ
	ZMlQEi8uOewrTHNgd7dXBKVCJl9xmbN/7q+Twhic3/aEDdswYr5u3BTR
X-Gm-Gg: ASbGncuEp50S8m1H19/BeldRUe5r147zVFjQ/Rw4p2//+dllAz+rmp26CHzJvJSVgKc
	++rFf0CmOXKcCUqHz7KBBiKsfTsmMqi9aLiShGbYFycZ/PPb2KVY2WDHDxcx4fvmU7oVxcmw9OJ
	lWhnGZqVWkddON5ICZvUViLjcjgtZFkJPsS51xz8MQHNxlS+NrFxeWb5JzILikxSXDXMehI4CiW
	fufan2HiDRh9+j3F3H0dUVf9U/+t1HTjrn4j/OTfZZR6Re6cDNzoMsqMKdyImNlD0X4FI5JnWP+
	j8e2MOkrLyhC4E70n3sAY6qv7/Vi2qIrv5GamwlMF8SJjeQbU+cuQWK+HEpR+cTFMNuIL2IWZgp
	cuW2mPRIONXWRWcnoktF0NghLFNmWxVyjDHmFpwx6C5M+ART5vVyH9PJ8E7Bj9YmeKgESiLlfDh
	VVwQOJbf+5H/HUEANg7WPam6hTmN3KMRMVGogpJYom/qgaJ7p6NEhgPoi/
X-Google-Smtp-Source: AGHT+IEEQTNiPubQPSJRq8duksf5867j4xSrXX+HY1Q9sgUvD7OFjRQ80gz9j/l/eCC8Aks6wfF77Q==
X-Received: by 2002:a05:6402:350d:b0:63c:4537:75a3 with SMTP id 4fb4d7f45d1cf-64076f751admr6576636a12.16.1762003694895;
        Sat, 01 Nov 2025 06:28:14 -0700 (PDT)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b390d71sm4264125a12.12.2025.11.01.06.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:28:13 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: dsa: b53: fix resetting speed and pause on forced link
Date: Sat,  1 Nov 2025 14:28:06 +0100
Message-ID: <20251101132807.50419-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101132807.50419-1-jonas.gorski@gmail.com>
References: <20251101132807.50419-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no guarantee that the port state override registers have their
default values, as not all switches support being reset via register or
have a reset GPIO.

So when forcing port config, we need to make sure to clear all fields,
which we currently do not do for the speed and flow control
configuration. This can cause flow control stay enabled, or in the case
of speed becoming an illegal value, e.g. configured for 1G (0x2), then
setting 100M (0x1), results in 0x3 which is invalid.

For PORT_OVERRIDE_SPEED_2000M we need to make sure to only clear it on
supported chips, as the bit can have different meanings on other chips,
e.g. for BCM5389 this controls scanning PHYs for link/speed
configuration.

Fixes: 5e004460f874 ("net: dsa: b53: Add helper to set link parameters")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2f846381d5a7..cb28256ef3cc 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1372,6 +1372,10 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 	else
 		reg &= ~PORT_OVERRIDE_FULL_DUPLEX;
 
+	reg &= ~(0x3 << GMII_PO_SPEED_S);
+	if (is5301x(dev) || is58xx(dev))
+		reg &= ~PORT_OVERRIDE_SPEED_2000M;
+
 	switch (speed) {
 	case 2000:
 		reg |= PORT_OVERRIDE_SPEED_2000M;
@@ -1390,6 +1394,11 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 		return;
 	}
 
+	if (is5325(dev))
+		reg &= ~PORT_OVERRIDE_LP_FLOW_25;
+	else
+		reg &= ~(PORT_OVERRIDE_RX_FLOW | PORT_OVERRIDE_TX_FLOW);
+
 	if (rx_pause) {
 		if (is5325(dev))
 			reg |= PORT_OVERRIDE_LP_FLOW_25;
-- 
2.43.0


