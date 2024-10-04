Return-Path: <netdev+bounces-131917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD398FF0B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BE41F23480
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CE1146A68;
	Fri,  4 Oct 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf2rnmMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD05140E50;
	Fri,  4 Oct 2024 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031646; cv=none; b=Ry9JSXgddRhdq2Z9/Bo/CkDS1lbrI6syA39uI17SVs2XLBmfKjGe/i4SFTtIQhyTgMR746X4oDf2E3EUPAz5sNENqBpA07lshtC/Os3YQm4CwbwL66np9+gPKCGcOu1tQXGdwZiIl4DLi3Kkh8WWz0Q3DGBqkfqYcwa4OKrMmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031646; c=relaxed/simple;
	bh=P9wuLNQOG/5s+jwON9IQ6s1tR3bwQp/Iv2WmnheCJSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rn2BbuL27znfcq+CRc40blgyCARMcd+/mKG23j3CvJ9mQ5NfCvMCO/G0Ll3YTg+l5lj8Gr0D9ipnEqGGIE2GkWnBS2g6yDmzhvL23vqdZB5Z0r/MfudsO+OtwE59BT/hxPYbdwuDjZSGq2YycjUDp5YKf08B5KH96VmYqXyXYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf2rnmMG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d4979b843so242392266b.3;
        Fri, 04 Oct 2024 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728031643; x=1728636443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D38nqKoK1ux2JviUHAQPhRsrpRaAlCKK193uos3igZg=;
        b=mf2rnmMG0ORk8zO9CkgH3z7qIETXwCeerk5hTUeqvLn3uxayygWUvY92KAyHLvQOpd
         KsvD/np5mS8BE353i5tsAgItHlvrtSu6TezFok4md/Ftd8paQkhqmwnr0LHiP/rSRoPe
         EHGzFhzKcN6u8XE0OG8Pih1v8foXEnnFvpMYFHO++N9SwJNyzQyinqwh3eMaXmUhUlU0
         OASd7ZeGowass24+QBt+7UjWD0cZSIbhT+h9S29PSorezRs+ZCTFyWCaRShr9TerwBCL
         iS1dbnOOF/UhcdbwVipCZwjmv1PLzWxfNUwyGcLXRBZaE2UmTaRDvoNMuF5QA2N7d6UQ
         yO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728031643; x=1728636443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D38nqKoK1ux2JviUHAQPhRsrpRaAlCKK193uos3igZg=;
        b=eqj5nEWNrzeP6/nB5PrhlqHTz7DwoGeUQblbY8xiIeV+3HTTHHj4z+pERt07tp5Sz1
         nnLjKYM+twkBPa7zrsEIm4da1eorpaZz7uo7OWyG0lUOIMZA9WVMzHJWk441XJP2rgxH
         7tyWv7kkRUUj1S5i5hnD1gVpUfgVv+nNMsskSiMwq+mcOmyXCTHFlQcj2uDpTWHVy6KS
         s6CvLT8D6QaCTwZJOjPhBISWmZPUZaD+cuSCuNBupbrHVIwHytnh7IA48hlVgOhq4cHz
         Txi4VuBwYcTwnQhccOXHFdmLjy0SUukaJaHxFaj/r2SWKWOsqeEmBF/Z7IndzpTlR1vc
         wNbw==
X-Forwarded-Encrypted: i=1; AJvYcCUy7uDa3MOqtQbFIG/9xvTNEoV8kT+785CnUZQwqHW9ywr739vhwZRj00cBtKboZ6AjiEZdh96Aw+ZIaX0=@vger.kernel.org, AJvYcCVXDwR27jbuP0vCQ0BMbQqMPz1Jl1lGo5kRB04tbVPGAvLlHM+1QZWtU61L/DaqMXYV+Mkf3wpM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69/bXUgNh/Z+Sr461kUwkGLab7aenZdnl4kUIf7Isu4Jye/3D
	28LshZ5GDyCr0pxbTTVzQCuFvHZPjcZB2zKwpvQiEaLFZ1cTTt4M
X-Google-Smtp-Source: AGHT+IEyNFGFbaLkz8WwbwnKJiT7KOBXzOt3HDdVavFYWXhrrOvldv2qfc0R8oBSM1CGKfd5URrn5w==
X-Received: by 2002:a17:907:c8a6:b0:a8d:5e1a:8d80 with SMTP id a640c23a62f3a-a991bfd8735mr169546466b.40.1728031642694;
        Fri, 04 Oct 2024 01:47:22 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104d2e1esm192631566b.212.2024.10.04.01.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:47:22 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 04 Oct 2024 10:47:19 +0200
Subject: [PATCH 3/5] net: dsa: b53: fix max MTU for BCM5325/BCM5365
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-b53_jumbo_fixes-v1-3-ce1e54aa7b3c@gmail.com>
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

BCM5325/BCM5365 do not support jumbo frames, so we should not report a
jumbo frame mtu for them. But they do support so called "oversized"
frames up to 1536 bytes long by default, so report an appropriate MTU.

Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 6fed3eb15ad9b257c6fc3da20ce91b5e7129884c..e8b20bfa8b83ea7ac643bd5d005e2983747bd478 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -225,6 +225,7 @@ static const struct b53_mib_desc b53_mibs_58xx[] = {
 
 #define B53_MIBS_58XX_SIZE	ARRAY_SIZE(b53_mibs_58xx)
 
+#define B53_MAX_MTU_25		(1536 - ETH_HLEN - VLAN_HLEN - ETH_FCS_LEN)
 #define B53_MAX_MTU		(9720 - ETH_HLEN - VLAN_HLEN - ETH_FCS_LEN)
 
 static int b53_do_vlan_op(struct b53_device *dev, u8 op)
@@ -2270,6 +2271,11 @@ static int b53_change_mtu(struct dsa_switch *ds, int port, int mtu)
 
 static int b53_get_max_mtu(struct dsa_switch *ds, int port)
 {
+	struct b53_device *dev = ds->priv;
+
+	if (is5325(dev) || is5365(dev))
+		return B53_MAX_MTU_25;
+
 	return B53_MAX_MTU;
 }
 

-- 
2.43.0


