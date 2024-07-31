Return-Path: <netdev+bounces-114663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72F9435E7
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858D9285A1C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94CA12CD8B;
	Wed, 31 Jul 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="eln/Ds5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B62B85956
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722452003; cv=none; b=PT41Bt0rch4G1OjQTObvKKn9ZDqESLv54slY4/PH2vbq+0RzXdeOJ+APQCB+NcNiH6PPIuvc2EctUzBL35HD7ZMwrrV1/K90mo/FECDNyart+0+7nz/SB3ywJBAOxyp1DbuglVtcFnmEaoLoUiJtXBr+CQCuWUVaCMSYZ45DAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722452003; c=relaxed/simple;
	bh=kPfCx03ybr3MIpJmR8pHHfQuNtULEfQX762YDGBxnKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBijqcAbWLnrWHoLe7RKLccpVO3l8IGk/kq2WKw7LSRF1/XYSmFwpXtiBaC3L1Xluxz7Zgra7obrl5tzJ+wrw6AUAkVsEE9+/+0zWHaETMz6QHLbNBLhCTanzKs9ZMkufmE6Rsuj+GSF+uPOCFM+9mPV74CnHzxfdJ8u5mP62+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=eln/Ds5Y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc4e010efdso2406745ad.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1722452001; x=1723056801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Q/3E3b2eo/TFXOq6VQUHvlRBXDZ59E7fsnrItLmpMw=;
        b=eln/Ds5Y/ogz+gtnVuAtt9SqjVE2EHSo0AW1LOcUWIuG6qz3HmZqf9Ezs+KpSSErpC
         kgCEXorehvcsjX06Wi4mHO6h/x8Gwn0S0AmkRZv0Wcecc0UqGCjYrP8+UZj49BgXdUuS
         1fbDyuy7JCyXxtC03GJReeXbjur/tRDJXMIOABWRYFtdzFRfE+TLuRCrd2GKEhxrpo1L
         k118fR3KAQnxqj9XB4ODkEia2gjciM2wQrZeWecMb1qWe0W32565aQS5ys+MO7kGGmN/
         XaOq9o6AaIc7MhWn6RV+VRxE1vS93DoFE4MYE1Dj3g8yj/y3VsxL+RGNJ4/t37DgCiaO
         DqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722452001; x=1723056801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Q/3E3b2eo/TFXOq6VQUHvlRBXDZ59E7fsnrItLmpMw=;
        b=n4Z0Xl4HPjE7+fw3g40VKbOEWBHSpE3p9rcpwNrrjjxnQSHTmVVXFMA99P6+amCNGl
         pnbkzc7nVYhsjSWc01dssTkrfZ3sEEWbTGAKXcpRd4L1r2ycRiht377G6F2QR9/fCxkO
         LG34NNyu0xjlIoNKV6S5oHa4/gbFGfv92xZU+vQZlZ8WhOXa2Ehuq+nlTxYdzXAzw+NB
         XD3puJ8YJTVctxOJn6X1vDFNWfZQ/CDypb6/xl97N6hscCyK7CboH/WU+12IU/qZajs4
         ijp2SGOZZN1RmV82w81O3kUCtBEeEROCT+zPU23Vxm08melUvBUZTMikpQhzomi+Qw2W
         lFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJRLQJ9hIXSXTX8JSUvYWAV0Jilti273AmC3SEQ0+OKv1qcaYLLO/3+/vP0b8Gv/yLT6g0jdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSIq6gUR7MRMbxtVEUCUH9ma+7Q/DkCN+mGw1a6JpV7tOxJ8w
	jR9yDYeIWfpQRXXBiKXir5ERMNlbg8ogbuuObPhsBr0q81gAiFTjtEtGvURV6g==
X-Google-Smtp-Source: AGHT+IF9e5nH0+houYf35o7HSbuUJwbUbuVuAZal2IMrlR7X8KHx7hsAAxE0bVJaQ0L7OkSUFPL55w==
X-Received: by 2002:a17:902:fa84:b0:1f7:1a37:d0b5 with SMTP id d9443c01a7336-1ff4d0f0395mr1556395ad.4.1722452001387;
        Wed, 31 Jul 2024 11:53:21 -0700 (PDT)
Received: from [172.16.118.4] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff3d64sm123182825ad.299.2024.07.31.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:53:21 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Thu, 01 Aug 2024 00:21:06 +0530
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-am625-beagleplay: Add
 bootloader-backdoor-gpios to cc1352p7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-beagleplay_fw_upgrade-v2-2-e36928b792db@beagleboard.org>
References: <20240801-beagleplay_fw_upgrade-v2-0-e36928b792db@beagleboard.org>
In-Reply-To: <20240801-beagleplay_fw_upgrade-v2-0-e36928b792db@beagleboard.org>
To: lorforlinux@beagleboard.org, jkridner@beagleboard.org, 
 robertcnelson@beagleboard.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=kPfCx03ybr3MIpJmR8pHHfQuNtULEfQX762YDGBxnKs=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmqogQIw+1kSBa5l0LPqEzMyulYyOyGwpLiDqAl
 +XMMMoQrviJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZqqIEAAKCRAFzvXHieVa
 dGsLEACnI9KpgROhjrZozoczEI/u+dRf5uh/LYSnTLW2PsdGjwsBfhmhQMq66oWyjLzpHwix1Fm
 0F6PQev4zZVxoCKwaPMSxVaQG5eXCqM6CQL9saBrCgxR7Loh1EdSKuvwh2LXqOsIoBzhSgbe+Rq
 FYcxHFNfTel8mwZIMXKlL2KFWKyW16GzrCWdIQGJjc11ZgLI7Bj3OcnnjsnuFwBoXm5keHYI7+2
 GB4/dHSbxr9NwzmYea3rnVUWKk1J32XaGvuCfVWgL65a5T638EIYLg/0dUZ8DhuJkWdVJizaWOU
 tHFKvYmmC6LWOwRwHeKnDlpelKyMb9rfzcXXRSAh4oRW41LdXX2/eIEnaACTN0d8XOII6hztQdE
 1BtyqUdBF64RcCNae6VHtrEsq+11n5oClFLBQfeFPrJUGy8H0ORrROp2rZtZpOUFy+emJ6irmi8
 CvUv9Z0mFVM6/LkNQYZ5dMbhJ/awOn0R7B9paKmAj1FZ/FMlXREUv9RjncR/e5o9PNZMN8uh/xF
 xCVOQJOj0zExhhMB7+sQ+j/6vW25brLoN5+/bzG/v9ICNe5xgCjUS03udutATd17Y39cNdse9fQ
 4y6c3Sr6EzVe2Dg0fyaqQxNgN8p3BuWpUicmgbeArXp5ZbrNU7lEK3UZ7CdUlM73oQA5QXdSxRM
 dpFIs3qKAAPNskw==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Add bootloader-backdoor-gpios which is required for enabling bootloader
backdoor for flashing firmware to cc1352p7.

Also fix the incorrect reset-gpio.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 70de288d728e..a1cd47d7f5e3 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -888,7 +888,8 @@ &main_uart6 {
 
 	mcu {
 		compatible = "ti,cc1352p7";
-		reset-gpios = <&main_gpio0 72 GPIO_ACTIVE_LOW>;
+		bootloader-backdoor-gpios = <&main_gpio0 13 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&main_gpio0 14 GPIO_ACTIVE_HIGH>;
 		vdds-supply = <&vdd_3v3>;
 	};
 };

-- 
2.45.2


