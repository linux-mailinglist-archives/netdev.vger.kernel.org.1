Return-Path: <netdev+bounces-224709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63657B88A0B
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882123A1E02
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5724306D58;
	Fri, 19 Sep 2025 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF3RaxlN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6FC306B3E
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275089; cv=none; b=QAvERiiQ1hmL8Dpfw6aNHMf2w+H4KGEuLJElj+9TI3fBbZAS5xNtNYyV1vpbx3D1uOAON0Mo5h6/geOU2hSUoArR6+6rIxXI5hdQO/Jv0CH2Gj5/AJa67DUinYSTmjJjZe682TyZg9AHmCDOiqcf2oRgLesUefDTudn2xr3VPhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275089; c=relaxed/simple;
	bh=SAyUnJhCwMKSbhb7U5p01vudm4sy13VmR4oxIBmj0nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrM0BDE4bIo1Mjjux8FOEpWDz8AvfT34AxxJHoSyUcgxsbJcV44hYYrL9e1kqOC7tkQkMfYQRJdKFHFdBC2qcJvHzqfCR04e4/BcVJ+EDr7gPpG8ftMtck+E4EbK9V/PGCA+RpqbbSVUojjEAtZJ7Vi1PRLIm7rbUgmwYsYS2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF3RaxlN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so1804117a91.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 02:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758275087; x=1758879887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2cvRp1weqffRPvbmfOkQaVMZbMjAj/UHkPXTSQ25jI=;
        b=OF3RaxlNYhdEdilZvebjfRJ740SjX9RIh5eOhTwgLeEvUXmtI6ny+PZRnhfisxdPE0
         cn6/6+KpG7rE77nPsNF2MEeasA4YBliZ4yuK4a6tAKW5y48bu6680HMpu7GLpnkHnfDm
         OtueOhIDVhbZLGQ/sZ8RFy29TW1P/zmnQJpAz3scyd+f/hbEVA1LITcMijC+1PHynNhT
         anre/f9AaVx1iA0e6LBUic9l8jc9s1Eb1uQdrxe9yvud08ubknvHOPE+6AIiFeylOVf/
         t9uVIQQyw6NvGKa6LeIyNzHRRKbOdNsOdnn4nmC96AJ4B6ckNtrKkT1MyhpnIsQuJpCh
         fOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275087; x=1758879887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2cvRp1weqffRPvbmfOkQaVMZbMjAj/UHkPXTSQ25jI=;
        b=mcUjndN3Hc4l7zFTq3sAlMwvuva6NmFXRJqWAmdgbAFpBsOcgW2P42AV4vCB0cAQDi
         ok2/hn+0aviiQdBduWglCpY++tsMKL1coKYJHJuybDcs6RRdcyFWHAwaXOa9RVNVrP6d
         Kc+OVt6It2xaca6IaZWXojGbc/kQvJSVC+9uvjf9vrlpHDHn4X0qE9YAsJ2AQjt8m5r4
         uJiheWxZSGE9jBxispbFEnSU7/ug6QjZbKUmFynyig2w0suitBKWLG/PxKaz0WfMNgj6
         +No/yNHhlAwXk/6Zp6KP4MVxMfiYFMnYdiP81HVkm7YSkF6jMA5+cJXk4MIzK6J5yz2/
         ZlZw==
X-Gm-Message-State: AOJu0Yy/Y9TX54HQ4PtjJBhz+JfaVdRurXhvkYGlUjeFtc+ob1rKpn4x
	bh1rmJTyOCqZetWZQW3XQazqdyw0QOLuMFMe9hu3QPc97t97n+M0Miby2SZIZR9RqN0=
X-Gm-Gg: ASbGnctOJT590BXDxJKFnVOoUB+3iyoMxkXJ7KLtDpeRGYDsbnmJIHIUFYNWuCPrMsW
	zOwH0ppaDwFM8uwqj6/qT5AzNtcsy7u4upxSoX6sVRlrwYyOrekurO9b2vtN6jvEZdl8qccv58C
	ydI/hseprQ0T9DCa7HpMYZluXZnCIK0ahIFkKkptFY3Gg2xgVDjWtk55gRq7hhL501u68arOG0e
	gTuSBKCA3zYYHcdDcXhVjPidmTMTv5CZl+rvEW4mZFH2gn/Vej0fSAjtNHiowy1xadPKGCPEFlH
	4HWM0EbujLFf6ijH2jgd0r4h3BiW6tGpU14p2qHG9gfDBlVGoybLVYgKwWJxfaVSat0TvyaXakO
	NfL6FRWiEBVuM5AgjC0A5TZP2SyoAGA==
X-Google-Smtp-Source: AGHT+IF81ZCACHBm2iK8/kjiA+RR2MY+a6mu/h4nqyIa9OcgzApIqnCmwflrvu2zcpOjmU3UceR01A==
X-Received: by 2002:a17:90b:5107:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-3309834bf38mr3988965a91.17.1758275087266;
        Fri, 19 Sep 2025 02:44:47 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3304a1d22cfsm6221873a91.7.2025.09.19.02.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:44:46 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 1/5] dt-bindings: ethernet-phy: add reverse SGMII phy interface type
Date: Fri, 19 Sep 2025 17:42:26 +0800
Message-ID: <20250919094234.1491638-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919094234.1491638-1-mmyangfl@gmail.com>
References: <20250919094234.1491638-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reverse SGMII" protocol name is a personal invention, derived from
"reverse MII" and "reverse RMII", this means: "behave like an SGMII
PHY".

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 2c924d296a8f..8f190fe2208a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -42,6 +42,7 @@ properties:
       - mii-lite
       - gmii
       - sgmii
+      - rev-sgmii
       - psgmii
       - qsgmii
       - qusgmii
-- 
2.51.0


