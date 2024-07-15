Return-Path: <netdev+bounces-111595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81068931B16
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 21:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375A01F22CD3
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DC2139D13;
	Mon, 15 Jul 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=patrick-wildt-de.20230601.gappssmtp.com header.i=@patrick-wildt-de.20230601.gappssmtp.com header.b="cXTiYOxj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA9131E38
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072300; cv=none; b=au2eLY143JMtb0S8FpVI/x0JPm6+BYhOvTrOGuPQclBO8+RJbZp3oO+fT8vxpd6SetdMn974tP5w9wkv9XzlDO86zv2ZzqVESyBQvBDzdQgQJTiUtKpCbSvOTznq9wWm9hK16sPk41layrkdYxONpjT7Ex4RgMsNbtB5EqPve30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072300; c=relaxed/simple;
	bh=cemq+9OuqeY3+ummp337Mvo5F4mXDIT79m4hgKaBI1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G+HQ7LMysUDZwAMOscCMLGr7LHlLK5JxZj5erlwxy1YFUaA7J/65p+nRLCw+v3ieKREEgpdAHtZKYeY1jNOnPr7kzYmMpLALD0bud6Wzv8f8e24KrM7zqv4VNIzeqrV4fIVq/UoHLSLG3qgAhY/L2Uo1d4qdSKK1tUhs5Ck5U8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueri.se; spf=pass smtp.mailfrom=blueri.se; dkim=pass (2048-bit key) header.d=patrick-wildt-de.20230601.gappssmtp.com header.i=@patrick-wildt-de.20230601.gappssmtp.com header.b=cXTiYOxj; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueri.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blueri.se
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-2ee91d9cb71so49195331fa.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=patrick-wildt-de.20230601.gappssmtp.com; s=20230601; t=1721072296; x=1721677096; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFsCI/nUGMHpQYBhPffSAiv0o4Z8VMEXV4FQksJuyUk=;
        b=cXTiYOxjsrz5BFWB5pXFPYwf5UusjMzd5o6+Kwrii5SuKh/2njn3BY9/edtzCLuxWn
         TRzSnXtUIkdwbyAxibs7EOTVlJEVmAxZdOiRsM71pRbF+eNhztMeijNDVSxe2SlziSxX
         EMAq3G5sVqhGIYC9cXO0/yxR9YQaPtRAZPt/RT5idM5vwS8Qj0Rb4Ztvx4wGIlOxE9Zm
         A9B8d2QaYZZ3XnEsbt+aYRGczVBra+jhfdbqUbt/osRgy2JofcSWdya490iHGSHts3us
         lEY5zUnHVMJE+KG82VozYh659abwJ7jmNvY0Jv9S93Ly3RTwKpLBDTkPGEqDFgMdjxm2
         zBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721072296; x=1721677096;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFsCI/nUGMHpQYBhPffSAiv0o4Z8VMEXV4FQksJuyUk=;
        b=Nod3Kumgj1lLB4CHyUdjqcoCq7LLiLVfPClP3zKDQvhFgHrjiWP1ex6roTD0ttZnNh
         +mC/MhoUHXlpVxR5TkvAPRnDfkVfcyj+JLOFJLNM6QYTihuWf0Ovs7Nv27eIYO2KBgII
         wVpC+COEXZKsMcLT2XhRphpDjTlWUnE/ip72FIPM/7Qbz91YLwX3Mc/M1zp9BN4YlVxT
         ofZWAT74PqUuVO9NBM4W+y9YAZZi2AHy8qsD/qwrdKD6gpikwIqcFzMeLGiYHfoszB61
         2bRwoNQ/FaLYYgfStf9dMkMdNlnKQW+uh5hbZL15qox7qREFqkYI7ZtqvUW7kVBufDdw
         C6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt6HdNjlm+iSpwzGuBKUQiP6dDFIlAKvGAjs3ukJR9q5UMc3dZF/eqQ/jtETLtSll6PnbU9uO8GJWzlTx15zptDyl16uoz
X-Gm-Message-State: AOJu0Yy/boTGMcli5QxDFm/zqOznOiAugWyvFULvfutD38J4pZxtRVeb
	gOQngPci0SzfwwAxVEZrhki/9WmfK2YhbBBNABk9+8ryRcDgpLK0I1zCs9rvXCeaHjfupZokMEM
	D2y98GLPkb2Jh/n1uP/rO/Nf0QhjVJ3Zo
X-Google-Smtp-Source: AGHT+IHjhs7lFn6xanLhyvwaA7PatZ3sOOeEdpx/Nn5lzGlDNwLD/+lV4ElphVBjqkaDIyu0IV9Qs/ersaIQ
X-Received: by 2002:a2e:91d3:0:b0:2ee:8eb6:ff61 with SMTP id 38308e7fff4ca-2eef4156be4mr722331fa.2.1721072295803;
        Mon, 15 Jul 2024 12:38:15 -0700 (PDT)
Received: from windev.fritz.box (p5b0ac4d1.dip0.t-ipconnect.de. [91.10.196.209])
        by smtp-relay.gmail.com with ESMTPS id 38308e7fff4ca-2eee1936872sm625101fa.64.2024.07.15.12.38.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jul 2024 12:38:15 -0700 (PDT)
X-Relaying-Domain: blueri.se
Date: Mon, 15 Jul 2024 21:38:11 +0200
From: Patrick Wildt <patrick@blueri.se>
To: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Steev Klimaszewski <steev@kali.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Patrick Wildt <patrick@blueri.se>
Subject: [PATCH 0/2] arm64: dts: qcom: x1e80100-yoga: add wifi calibration
 variant
Message-ID: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series adds the missing calibration variant devicetree property
which is needed to load the calibration data and use the ath12k wifi
on the Lenovo Yoga Slim 7x.

Patrick Wildt (2):
  dt-bindings: net: wireless: add ath12k pcie bindings
  arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant

 .../net/wireless/qcom,ath12k-pci.yaml         | 59 +++++++++++++++++++
 .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  9 +++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 10 ++++
 3 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml

-- 
2.45.2


