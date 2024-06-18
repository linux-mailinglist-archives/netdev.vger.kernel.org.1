Return-Path: <netdev+bounces-104608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F8090D9AC
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF563B36CED
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6272313AD2B;
	Tue, 18 Jun 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPfuErCe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A134C630;
	Tue, 18 Jun 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727278; cv=none; b=JhA3RkETf8L+cTwY2CIaQxZ3eFPXQJEnO1zd70vDaUhNGDVVnowBo3gta67Oh4ZAayW0UXp7ZPhS8XZU5lX5iTJGXPaBMYrdSckt+paU1ESv7dfjF32omZx+yKbjnN1T4taBF6SQL5qEQKHdFFdezPqEVgg2FW0UX7yx9x0ZKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727278; c=relaxed/simple;
	bh=VrhlfkL4vj99ApDg+/GADXPwjig4yGt168ySmcbQx7w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q+YPNDL5gBugb2K1iiIUksRYuHwDv8IQzg0jrEVJUJKFi5iY0mSiSxfjwYxGYLkJ0fLrkAF7N1Lm5ItauogV63ru+WkI9OHbUE5PDU4JBjF2wLxnKRNUxNA40r6IMT1FTNS+0DftgC1Q59Dw5RrDh8lztbYI6bOfYtzBHvI96c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPfuErCe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f7720e6e8so316768366b.3;
        Tue, 18 Jun 2024 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718727275; x=1719332075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lXY2wNetGBX4+8SEarC8cQJ8+XvQEsopyU4osLmOcK0=;
        b=dPfuErCeDKuLUDknLOepGuV5iMob/M6k8Vd6zE2IdGP8iAtcXGstE2d3lOAjKiB2va
         A+BM94N7ef5D1GJEYJxz8ClSU9xQIgmPigo1/+MkLzLHPBRGxAsTcbMU6CXjQ99+GA6W
         Y3801TQR+2y2rcay705lGk0bNnT/q8V7X6bHEjf+ZmrzyeIMs8Vv6AhVir1nxuvwyIyP
         buo7RmYSVSV92cKjSSwdf3fljFwweEDG4TMtIWibgz/QHScH3J+TEeb1PtmZFtsSmmPQ
         9tWYmiQC+KDVjyxWScAHwMt8Eu3YQ+jEmANc74EkKYbQbKLhEiVs1OrQ8Z3Xoy2NjowL
         DGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718727275; x=1719332075;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXY2wNetGBX4+8SEarC8cQJ8+XvQEsopyU4osLmOcK0=;
        b=LmLPHN4eHB1enzhwzRncu/oNBHUK+WWVhLLpYvrWFJGseIYTl58+nSDlZm8Y2SDb+q
         5Raf28YSAIOhN3zxpvPekVtsUWR6ZkQDDxrL3xguv5xuvtWLvGu91Mb+KTxyWV10ol7k
         q7KYzd1R17z25wbSKWaPXSa/OalLlNFsQRufaUxEcfjJ2om487fRihozuf90BK3iOflj
         COpmmdwhqOkG5KkiixMysz8os/Et7wIOQ9LLFtZ2Vcv/XH4+NwJcqwmEg3hKa+uyJcX1
         165JkN+in/s2qbaDw2eQtPlZbtWHxzeBRbGkvmdST4hwv00RYUzPdYL5jGkP8OXGOBjH
         t+pg==
X-Forwarded-Encrypted: i=1; AJvYcCWa18wgEZayL30zqpsYMwOTc2v4GyNn2Lr149IlCiTLDzI6ITLakcEShdgYAV7q+i6sLnXfkR9YGC0SUm4PtqlXj4JPTFmGzA/U9Nnvmb8OEbxN6/B8iR59yNmL69njd6xUZGCCGr+RPbHa/LQ0Ooxa16h+CumP9UBpdQnchbQkvw==
X-Gm-Message-State: AOJu0YxK3VUqfuyJF+RVZdeoplb0AHOuZpJxKXNNdz7QAidIqwR330Z4
	5qp9tRNcfb6x7V3Rrw8KYm6P984InuXrldzvHO8FzBERSMfEuVOO
X-Google-Smtp-Source: AGHT+IFB+t722ELPdoX0iI8u6bwyvFZWAx3Dyl72/Psm768hxsjFKwtHjQqf3M69ACUYk4beBIapeA==
X-Received: by 2002:a17:906:b088:b0:a6e:5801:ed43 with SMTP id a640c23a62f3a-a6f60d38249mr1001596066b.30.1718727274772;
        Tue, 18 Jun 2024 09:14:34 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8a6e58bdsm207763166b.187.2024.06.18.09.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 09:14:34 -0700 (PDT)
Message-ID: <1a45f178-3ed4-49cc-9bb9-c1f9978356bb@gmail.com>
Date: Tue, 18 Jun 2024 18:14:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/3] dt-bindings: net: remove arc_emac.txt
To: heiko@sntech.de
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
Content-Language: en-US
In-Reply-To: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The last real user nSIM_700 of the "snps,arc-emac" compatible string in
a driver was removed in 2019. The use of this string in the combined DT of
rk3066a/rk3188 as place holder has also been replaced, so
remove arc_emac.txt

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

[PATCH 8/8] ARC: nSIM_700: remove unused network options
https://lore.kernel.org/all/20191023124417.5770-9-Eugeniy.Paltsev@synopsys.com/
---
 .../devicetree/bindings/net/arc_emac.txt      | 46 -------------------
 1 file changed, 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/arc_emac.txt

diff --git a/Documentation/devicetree/bindings/net/arc_emac.txt b/Documentation/devicetree/bindings/net/arc_emac.txt
deleted file mode 100644
index c73a0e9c625e..000000000000
--- a/Documentation/devicetree/bindings/net/arc_emac.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-* Synopsys ARC EMAC 10/100 Ethernet driver (EMAC)
-
-Required properties:
-- compatible: Should be "snps,arc-emac"
-- reg: Address and length of the register set for the device
-- interrupts: Should contain the EMAC interrupts
-- max-speed: see ethernet.txt file in the same directory.
-- phy: see ethernet.txt file in the same directory.
-
-Optional properties:
-- phy-reset-gpios : Should specify the gpio for phy reset
-- phy-reset-duration : Reset duration in milliseconds.  Should present
-  only if property "phy-reset-gpios" is available.  Missing the property
-  will have the duration be 1 millisecond.  Numbers greater than 1000 are
-  invalid and 1 millisecond will be used instead.
-
-Clock handling:
-The clock frequency is needed to calculate and set polling period of EMAC.
-It must be provided by one of:
-- clock-frequency: CPU frequency.
-- clocks: reference to the clock supplying the EMAC.
-
-Child nodes of the driver are the individual PHY devices connected to the
-MDIO bus. They must have a "reg" property given the PHY address on the MDIO bus.
-
-Examples:
-
-	ethernet@c0fc2000 {
-		compatible = "snps,arc-emac";
-		reg = <0xc0fc2000 0x3c>;
-		interrupts = <6>;
-		mac-address = [ 00 11 22 33 44 55 ];
-
-		clock-frequency = <80000000>;
-		/* or */
-		clocks = <&emac_clock>;
-
-		max-speed = <100>;
-		phy = <&phy0>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-		phy0: ethernet-phy@0 {
-			reg = <1>;
-		};
-	};
--
2.39.2


