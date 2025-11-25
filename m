Return-Path: <netdev+bounces-241424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1AC83CA9
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F783A7548
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6682D7804;
	Tue, 25 Nov 2025 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFZMa1TM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF529DB6C
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057126; cv=none; b=aFc2uZI4g6BreunH86Ll2XZTbLf06BaTcsSC9+20JnZi2dx+uaqGxplXb3Kv03k/M98WBm8M9/VLQc1Cus+mYR3tr+myfIwqCJqfiOK6kGdaDrcQWlUqLQvJvlLhToUscs2N5L9Ef/MlnGlIFqOiJMckCRyI1L3iJbJuI9gtbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057126; c=relaxed/simple;
	bh=QQ9ntuYhygUsjfxWjbJZY9/FX0sWkRHe9KfAHu92J2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2zXhnRR7aOZFUIk8oI/sBHp1YbRF95hwKhMVvTFVOWzg45V2LW9iURDnt08QHU+vpTI6xZSTVJtQs+08rqeL+j0Dx3GvWWhkc27BXXg3CtxmTVp1tUzyu7xA52c5hObGIgIN4O5alUlpuIf/z49bQldZChx5+QBkzpM/ukvJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFZMa1TM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735b89501fso583968566b.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764057123; x=1764661923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOFFbceL7ixCdLph1FgW62yHiAksNzDjiAkR6G7AzZY=;
        b=OFZMa1TM/jsJMeLCNNZoQwdtJUU8d40uxMmxWMJTTDKJ4Tv+fPgkbcigT49IJ7QU/0
         wnFtitz9JMa7ADHQFJCWj8qnEAHGdBUcfQTwntczCzP2wbbmruIkmzwZLQWL9MTvdyP6
         QLffg+9LeO/XmLVbThjbCh/lVZNA7RAlZZVe/bUZD8pId+HtyHbLXJ2TqdS1DJPgUlOy
         ECxD1UW0gFbp6dPrv5h8zJT3dGpUh1y9OK7FldBlrVv6yVFlBrBNzMW1sKq9deu+8D5N
         iXND0be1TbclvOSIRlRGwbASRDbC9w7lH9VsrHfVPfSFxkJCl4OTShp+nua1bzdVFStF
         iVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764057123; x=1764661923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOFFbceL7ixCdLph1FgW62yHiAksNzDjiAkR6G7AzZY=;
        b=tEuTxEJDORCJVPU8+2CzoAFLuCIpXWzjARIVxJLnV/Jd65J24EjaKfLClgu5IXEPIP
         SU8zRuanrznEaMzpOIF+cC+xbWDxQfxBabebiirl0Qa/RpFcj0H1SxSFmhw8yQCCUck2
         L+IIwWlP6nR6A92W1lUVii0VA/TnffubKSNW4jT0E20U62V0SudC4JRuyoO7PyyOXjac
         6s5p0rvTwaOZ1XTWv3aeloc8lXYnyqEQRnIKHDy9zp8t/LUizl3Ahl7za6xChYU0TOP2
         xxksO/UkputDKjjTJWug7fhQbigHCzvj73B60NN4RvNlbExMaQ5eryCv6cDuMMq4jg9+
         Grwg==
X-Forwarded-Encrypted: i=1; AJvYcCVLo01+FfA0ZjCyOefplUWQ6sVqHcVazcKrsMv8J/tHAIpyTqtUt5kegYQSq+CVJPPNJ5Sp3qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVRZKDMuHa7czT7rzPG++Sdjxzcvy+CkZ41xOMY/oG5zdhONq4
	H4c1KmASkoahxIiysa2RT67d3fue6KVzH4+715OaExYaCy8Y7nvbW3Zg
X-Gm-Gg: ASbGncueEVB/YDeMgNiVVRk9Rg4t4/cx3t8OtGf/eTNmYylrOG+r4DeY2R+BEUr7ZIu
	LENNq9tyfu2XYs3/CC8/HtKTmrhGcANexQqeBrxH4Vdyxs8tFqXxODGmqxTxALggTD16ZnYWs4/
	aOpSXV21JlruA+IjRJhnafkqnRYW0iYmfPmGRPQ3mLA9kIzMR9qRMr2G+5Ga/4ZncZfnDqrAPOa
	KZ4v2eyjXqgQzIIj5FFXS7yPxjdS8dgy5Z4HG6ZXWsGEAti2JgEAGf85QU6jnswxTlSiKNYaq9J
	HuHBsd8+wAU61NZy1/0hUXRrHXDogTaI7QFN11beY+GqXJDIDbLUL9AmMnGdQS2mbGjdY/r77OJ
	+2p8WhVJ+oLToSJ7xgBwCULEYl0xV52hM8YW7vBwqLSzQzghDQtTkiWI8orGdRHgYpmrUYWKaGu
	e6R/lyuO10qmzzaMTeOEscpTi17unvS60gWsbr4Ih1hVad+RGpEYsEGnuZzzfsGBF9C+dqD+bEf
	tZ5HA==
X-Google-Smtp-Source: AGHT+IHPFwvqG3ONIsm/AzjrLUIRNEbm0l92p/sdhNru/P9U5+Z4BpK4CrBOtHk9NZMM7UpCONTnkw==
X-Received: by 2002:a17:907:7f19:b0:b73:9b49:2dc7 with SMTP id a640c23a62f3a-b76c558f4b0mr157643366b.52.1764057123075;
        Mon, 24 Nov 2025 23:52:03 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7cb3bsm1536176766b.27.2025.11.24.23.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:52:02 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/7] net: dsa: b53: fix VLAN_ID_IDX write size for BCM5325/65
Date: Tue, 25 Nov 2025 08:51:44 +0100
Message-ID: <20251125075150.13879-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125075150.13879-1-jonas.gorski@gmail.com>
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since BCM5325 and BCM5365 only support up to 256 VLANs, the VLAN_ID_IDX
register is only 8 bit wide, not 16 bit, so use an appropriate accessor.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 72c85cd34a4e..7f24d2d8f938 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1966,8 +1966,12 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 
 	/* Perform a read for the given MAC and VID */
 	b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
-	if (!is5325m(dev))
-		b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	if (!is5325m(dev)) {
+		if (is5325(dev) || is5365(dev))
+			b53_write8(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+		else
+			b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	}
 
 	/* Issue a read operation for this MAC */
 	ret = b53_arl_rw_op(dev, 1);
-- 
2.43.0


