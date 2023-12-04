Return-Path: <netdev+bounces-53434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337C5802F9A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F941C209AD
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6A01EB3D;
	Mon,  4 Dec 2023 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="YqG31Ari"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5277D99
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 02:08:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf82f4409so643537e87.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 02:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701684502; x=1702289302; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lhb1kv6CX2Hv4FAK27GwxUBwb+ZZtbDT1S19zCxY+MQ=;
        b=YqG31ArihteFkmxYiWWSAKE2h+EAjiIpIbxGCpzjwONhHVPDQaeYS+xX67l9s90M0/
         fBRnUu6r7cJe3oULQvXRMz9Sh9AkxZBc2gNKiIgb5+/C9q3nVUPkOWfoX5ddvVISUJQO
         xOuEjWvtq3jKewkuZMiG/kGe9qLYFOauC6AGJWQPcKWxJ0Eg/2eYuhawFYaf2IAKY+Bl
         QnzxyuNgqaIn+HA5hrAiAPnbvTp4ibKGZzJJLZzuIASJFFBvb0EO/Uji4OtA917LlhR+
         O0TA5OFDnltBapfFzPlCHzMPAnjezmxC/n/tXPkx/SJO0Dtma2fBsuNe+37NR1jEVCa7
         kQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684502; x=1702289302;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lhb1kv6CX2Hv4FAK27GwxUBwb+ZZtbDT1S19zCxY+MQ=;
        b=miuYtky50CiSdjtLnpoOtZzx1+IXV0RGbl+oRVN3k/Vl7O1OhQmZs0uzzONEVQjBSq
         O+cFpGzIBMg6zNizZdJxhbZeTYFTZCQYAlQJQh48UMgr7z6jFpTOQ5Ltp0/OZyR89B/B
         5l7QCnrH0FWtKLR5lql+DB45InlhSnSWZitUe+96yKuuvAu+DDRYaclDW+vmSL/C3xhQ
         HnDZd9FuSuyY4eWi3oqIP1fIt3PXr3f6dzHnqnNME336abd9BP74OdNZtHjReICTQRGt
         PQ48d/otWdJ5fQ+PLIDCxAvMCF3OuK+PEuZNLiiWEfWWEHNXjxqNZ7Sg8NPJ1SRlsNPM
         4BSQ==
X-Gm-Message-State: AOJu0Yxx0Su21vuPaCaSkzvtH/aAJD2LnPdcMQbYgAbJrmxjHS1tu0Q1
	NinmoVH1MKj6n/yTQPEPnrxDGQ==
X-Google-Smtp-Source: AGHT+IHiVbex9/XIpROH3udXrRuVr8QHTU0KN+t5yVEX18e4tAosEdpZpUBPEesl5OaLdm7/CnPTCw==
X-Received: by 2002:a19:c203:0:b0:50b:f776:1d72 with SMTP id l3-20020a19c203000000b0050bf7761d72mr602703lfc.24.1701684502510;
        Mon, 04 Dec 2023 02:08:22 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id u29-20020a19791d000000b0050beead375bsm553643lfc.57.2023.12.04.02.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:08:21 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 0/3] net: mvmdio: Performance related improvements
Date: Mon,  4 Dec 2023 11:08:08 +0100
Message-Id: <20231204100811.2708884-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Observations of the XMDIO bus on a CN9130-based system during a
firmware download showed a very low bus utilization, which stemmed
from the 150us (10x the average access time) sleep which would take
place when the first poll did not succeed.

With this series in place, bus throughput increases by about 10x,
multiplied by whatever gain you are able to extract from running the
MDC at a higher frequency (hardware dependent).

I would really appreciate it if someone with access to hardware using
the IRQ driven path could test that out, since I have not been able to
figure out how to set this up on CN9130.

v1 -> v2:
- Remove dead code
- Simplify IRQ path, now that the polled path is separate.

Tobias Waldekranz (3):
  arm64: dts: marvell: cp11x: Provide clock names for MDIO controllers
  net: mvmdio: Avoid excessive sleeps in polled mode
  net: mvmdio: Support setting the MDC frequency on XSMI controllers

 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  4 +
 drivers/net/ethernet/marvell/mvmdio.c         | 97 ++++++++++++-------
 2 files changed, 64 insertions(+), 37 deletions(-)

-- 
2.34.1


