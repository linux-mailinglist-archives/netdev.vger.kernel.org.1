Return-Path: <netdev+bounces-131918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDC098FF0D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC801C2323E
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4595B1487D1;
	Fri,  4 Oct 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLgNS2+I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F39145B11;
	Fri,  4 Oct 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031647; cv=none; b=H8LyhWiUFWyDjyyXJfd85+GOP+6JPrC+J5l+R5yxZdRsOI+RcQLp60jdHezwYc8hrkutqVBMvXH6QVxo52HF0p4AHs22Fiwmjj50l/S66dlcxxPgwoWGqIHLKwz/AY/somg8TiiYiZ59Jox8udYos3KbAmhBmOG4M9YjVoFXNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031647; c=relaxed/simple;
	bh=j7NqwbTnVxIUEVTmygyIBlIdF969CaRsDuZhjwQOqXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i68269rjop9/HOWWbdqIFluUF1rm1KSJHWoUC0pLIL5juT40T1uJsVFx2h0HIqJc6h69S5NyyaxlATjKBhGeXodQ9lyZo+y1Z2jun6kw0cTycf064wpUvOFHB9tKfyrD9XCVQTF2SVskFu5Fs4lsJIeFmxF3XyaXGVuXMcB+in4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLgNS2+I; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a910860e4dcso292369366b.3;
        Fri, 04 Oct 2024 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728031644; x=1728636444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=racJq7e+9AJGmfIQ1lL/nf+MMw3QEk3WLoauzMkQtwo=;
        b=MLgNS2+Io+aW4WQxEe4sOes/d1sPvoe+ixQyT3Altbdh//FO4YFWlGhFmxJ5QJbj42
         0W9M3LjIMw8mXRpfbycXiGhJOSSqpbCpli/tM9L638rVaWCui1AgLH3kU8RfCRMoOte5
         g0eVkt2k+uA5c+XcPqPY+XsRqFRnLhwT9K5R32NoSqhd75LK1BlblBYneYSy94S/C49f
         IYENrE2Y6VsLb0BpTBVo4utCp2L9CKA3A7gFLL0J5WT9q/TOFZuTINRQANs5oRBP0UXS
         zvuLnMamYRK820sx5+Tf4UOc5v5DARpdyXSVeeoa6px8infsqc0QiQEdHyiWwwz7Q7WW
         837Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728031644; x=1728636444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=racJq7e+9AJGmfIQ1lL/nf+MMw3QEk3WLoauzMkQtwo=;
        b=lrTnDyRMbs3sgmz0EGqO7+62//ge82FSBEbRG88JJUSL0XHeBH9/4+vDHnmjn2yvko
         DQZndHcOGiVkfwxtz/OHEcQEE1pAC16ywNP1Auz9ZUMADZonEcakbosNwTKPiRzbl1dT
         zD2v0Wf2Zuw7IPIR69Eb4ak19OSMVHgcn1rQ64xTO6k/nyXLI8X+jhzf/jzC5jB1LVpM
         3WPBaXLFyB/or4WMKVeaElufJ4PEsSWGxlFRhqn40dsQBWsoWTYXCY+Tdl4rlUxc0mMx
         lbZiuDgLtnzGY6Hqm2sLeGpR91hgEFPNvGZmfuFYq/khYpNulsmYJ536KuiVLImEyTf8
         LJqA==
X-Forwarded-Encrypted: i=1; AJvYcCV7kZDTzmqG6pmbCtzFkI1cXaQtDmseHt1AqjVbCtorF7T3vfbhntt90Wci+GWA7r3ffaShTXWbyMOTH0I=@vger.kernel.org, AJvYcCXPfm/lvtBbOTXmov01Y7KBOnRc3LSZfyZ2SEPJXjDmSm8SrsNyVO7M0EoUtH9sTLdGHmWxdcyi@vger.kernel.org
X-Gm-Message-State: AOJu0YzpPKemKn4g6zFepvfqWkepWRy+zXvjjxJVpZqRSUfDa3wlZsh9
	NcRax5tw4VxnoqnSM9Wgp3a/nvtcRaJAVlrKKSnqnaS79oyit89z
X-Google-Smtp-Source: AGHT+IH9OyhqyRF3bk4sckJbV+DGqsosIRPef0/ga6rlhmByHuEDY2cS319Nnvi/yOUZil35KPIcaQ==
X-Received: by 2002:a17:907:9281:b0:a7a:97ca:3056 with SMTP id a640c23a62f3a-a991bd0a833mr205072766b.16.1728031643748;
        Fri, 04 Oct 2024 01:47:23 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99102a998esm193869466b.94.2024.10.04.01.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:47:23 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 04 Oct 2024 10:47:20 +0200
Subject: [PATCH 4/5] net: dsa: b53: allow lower MTUs on BCM5325/5365
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-b53_jumbo_fixes-v1-4-ce1e54aa7b3c@gmail.com>
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

While BCM5325/5365 do not support jumbo frames, they do support slightly
oversized frames, so do not error out if requesting a supported MTU for
them.

Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index e8b20bfa8b83ea7ac643bd5d005e2983747bd478..5b83f9b6cdac3de6c5e6e2164c78146d694674cd 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2258,7 +2258,7 @@ static int b53_change_mtu(struct dsa_switch *ds, int port, int mtu)
 	bool allow_10_100;
 
 	if (is5325(dev) || is5365(dev))
-		return -EOPNOTSUPP;
+		return 0;
 
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;

-- 
2.43.0


