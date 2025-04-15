Return-Path: <netdev+bounces-182703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7BA89BDA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17FD57A3618
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7A1294A1F;
	Tue, 15 Apr 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Bk5dyTrD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97929291C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715854; cv=none; b=b7gzxw2wFPOGWPOmrqWwgOF1+moR8VsgxhqSFR5uLJV/MPKInUwTDffu+k8HefFtJA7QxUDiIts9EJyjLMQOCakader4KX8fDASlFN+JcqTy9FKWQStlSADeWeae7pmdZgfv4QAVcb+qGBbV6Z9gSZvE+/nZHar+XD4AIwcr6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715854; c=relaxed/simple;
	bh=7WU3xSRBMuXGHUG7i/5ocEV9C8YkxglpMrWb+0YdQF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSWVPYh52VFTFVFxpSEgdX/j+kuimbXH5C5LorYsHNXVHbtejcFgOmHMzON+kbQaf36lT029TGSnbLbhO49AdGeOHClHvrPH6eNUc0XQ/pvqE59v9GG2Fe5kP+rixwqoyy0pJITVZ5foDI1anA2xhROPH9N42o5QzpLjbokaV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Bk5dyTrD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso26978415e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715850; x=1745320650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7JYY+X3NkaUiB+MENoOw1C0gTVvLEJ/wcBfl0EfVo0=;
        b=Bk5dyTrD7eo2B+3skMZU4ZT7dabAVaBgS3rs64t2itOZZOpxQdmkUCTEDPxAq4rTak
         I3YWyB/LuTtofUihWa/Y9Wo5XhP290pfvpHMk7kcB/y9BuAZ/Wruk72mBnZVwd3oe8dX
         grzsT+Ur8h/KI9AwaFueir47zt6VcuDT/EQJ2Cl0+wz0uiOSdHaemWkMh7uq3PVQBMfn
         bzegGB8Z1ScOp8vs2OMyOTgNPGIm+u+0kJGHipLI4/9yKardzE+Nxv+2JwyDmAsj5OUc
         EA2UYXDDIUc4Eh3n0fbq9LED0YY7/ymalZ4Bs/vZqrQe1ELoZu/bKg1g6tfdmNkY7ujy
         Z5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715850; x=1745320650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7JYY+X3NkaUiB+MENoOw1C0gTVvLEJ/wcBfl0EfVo0=;
        b=tXCyiJ0Z6VeePYLVm4f0g6bfOsIhA5gkapIz1GnoPOxqAQG8iza5UX+EvbjsXUutMX
         Od0A7Q/dAReuFE4d3Td4wjRMyASHmpbcvzZ0F+vKNidJ/t+aOB6hp6KpDMCrDo8fjEfo
         jgQBtmfq2pKQshG8jt/TNzunmabk2i3FrDJ8s5IBZ4eY26SsQD/URqiRcPHBPSn8girq
         1HhWQRaumM6Ko8L/AlaRdgA6pQQlRyJ4pOdFBlMBn+GKAalYpJaqnIqSUS4KSOXRle56
         DNMCK1uMXQxnEYaumZdBAPqQYdO8knTx+qtuhhGGtwrY2HVEfT395rqaDfg8+hVD1WNg
         /Oag==
X-Gm-Message-State: AOJu0YzLjxu5bbNQMgH5k4l8F3vTmrZwrflHrHbUrB7n1kyB6Z1ossaK
	t3S3QYYTvTV07Z/fstuojn6Cev2KRhIurnvovCeK31hDE3XY1BIZIQ31TRQPBApb2nrRK8hCSdB
	aUR9r/h/5XpPHPHIFTXOU83P2yWEtZmAL4OHQEkDty4Gk92w=
X-Gm-Gg: ASbGncveKHd4jcxra57r7z+SZSyzvPw4a0I/2eh6/R14evyRmOat18ZGzNgrlTi+LUO
	K+kKKtbWl5AuBwGXA94brM6k5wPjVR3PfeRzYuXBjjmVUjVN/7N/f0fKG3X4fCCyLTzMFyborWk
	bKPtDFcf5z5EpgbhhtzxqbaaYtiuiYuy/DyjKI3g2DvEkbPjkaBKANPDQT0ARGRH38Sx9NGtmgI
	Lo1l+JIBt0EqhS+xVCMPrmCBDmdJQUtaXgKnNzICht7TndkjvBysnEaCH7X1jZkb9mdH9sKqL66
	j6uG2qg3wTfzgOCvWq3tf83Sw+esW5EeddpH2Q==
X-Google-Smtp-Source: AGHT+IHMLMYFjSVMa8HJnw6tCAUHHCX6kSks+Xt2LOtrqibKe56yD7cKGOKws0MTUTIYWYii15T8qg==
X-Received: by 2002:a05:600c:810b:b0:43c:f61e:6ea8 with SMTP id 5b1f17b1804b1-43f3a926c29mr138308855e9.2.1744715849679;
        Tue, 15 Apr 2025 04:17:29 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:29 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:21 +0200
Subject: [PATCH net-next v26 04/23] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-4-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=7WU3xSRBMuXGHUG7i/5ocEV9C8YkxglpMrWb+0YdQF8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBBifGDIvfJdm1s+alp1EiBkjhaP4U4WT4sy
 lHHyAsr6sCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQQAKCRALcOU6oDjV
 hzFYB/9+kmSw8/ryifu1DvtlDiB3y7rrrRvka0hGy7d8SQR1mvJy8Y1dMMnCsIHEyUq5Vpa4p6X
 8EHWQ7BvzMBaOMs6yK3H7D6OFjNMJLy3qqfvG2sCaUqkAju06lE0Z0Mrn8TiK6BqeuCr/MhXPuE
 iNuUcS/XFic6a3eDrXRgxjIMeUKQ+WZT6Wgc6h1+i5CH+bORRvdow0QbTN73gcwAC0Y1cHsHyki
 1PZVz/DfSaFvHoD4irLcBXCw8Q/GkLv3D7+rFCCNYz+IjXlTAEybCvuRH80Sv8vixCI7ton3mod
 veIo9bznHYc5pT1CYc8YrWTYojVDb2sQosIW7A/BuyCYA1Yq
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index ea7dad374c0088cab46282c61cd8fef65bab0d5c..fa1dd84be24060d6dc749dc9e097f166a7adea26 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -93,10 +93,18 @@ static int ovpn_newlink(struct net_device *dev,
 	ovpn->dev = dev;
 	ovpn->mode = mode;
 
-	/* turn carrier explicitly off after registration, this way state is
-	 * clearly defined
+	/* Set carrier explicitly after registration, this way state is
+	 * clearly defined.
+	 *
+	 * In case of MP interfaces we keep the carrier always on.
+	 *
+	 * Carrier for P2P interfaces is initially off and it is then
+	 * switched on and off when the remote peer is added or deleted.
 	 */
-	netif_carrier_off(dev);
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
+	else
+		netif_carrier_off(dev);
 
 	return register_netdevice(dev);
 }

-- 
2.49.0


