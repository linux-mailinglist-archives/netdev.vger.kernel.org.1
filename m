Return-Path: <netdev+bounces-100982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFDB8FCE4B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DF128A4BE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B281BBBDE;
	Wed,  5 Jun 2024 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YzOtL8oh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C141BA89C
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590080; cv=none; b=atLFd4MQKakGfLOfmCj0r0IPqpqcAhVZ0yOvL9su6/6QrDr/ZD77lOJVd3Wp3bSg56GbeeZuA8vL3NbwnnvmZNXbzEYbr2W9zOVDWRxCPLsZzCE+UC+1OmiDGyVAlbPc0dSzvYcVNYeM5dnuJFbNPekxqYkvcPD1U0a/PHLWUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590080; c=relaxed/simple;
	bh=ZuXkpQMdBYPnSjpL44UGNK9p02wpao3earR10+aZjbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxUi0EtKRnHGK5yuPaYxUKU9IFA1IAruAGvPnW/AghkWuYxCcY4OQeNBlKUia5AqB+FZeNHwAeQlnA83Q8N8FCQKk9gjIMfgmZuASyF6JkQlsLHo1hXpIyMOahaX2f+sPGLRVuoLsuSVHy4PzBx8XxTZii1jRHsFviftODd7E1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YzOtL8oh; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e73359b979so67102421fa.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 05:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717590076; x=1718194876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Nvyhb30jMRTp5MAcBR0DPyo3QQwWDlaTstXDQ5DSE=;
        b=YzOtL8ohU59o5as1AIFitfb6w+U9dD6UIwIj/xhsHVtC41atF0tb/ptgG0yKeLsWif
         kVrN0AMc47QDp/69CjJTZjXMZPv4Y73bAWnhhuSI09q7rgpCEEXrPvfwFG0kUWqi6Y7I
         cy9qMISWyU/BfhcAZq8Uw6D6kktoIEHyL+yeVLo1cQqNo5ilFoMeSE3Rb9iUcB8vndFq
         +gj4eXTBbXm/PHabyx+L96a5uAlgYhdBnFmZyFgs+QdnPRdPBxftDnClvSa7Fz4ghH9v
         kUmexT5zF9+YwRMeFv0T3m0qbbEWDcKS8z7hFuxVyZ6bWcrwO4BDInimdt5M68e/BwAj
         zThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717590076; x=1718194876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+Nvyhb30jMRTp5MAcBR0DPyo3QQwWDlaTstXDQ5DSE=;
        b=G4yW/l3fUbL4R56pHlJWNAHYdy7F8NOAT5baEUAwrOVznQAvKec7NZhdBboPTy0oE4
         KHR4KOKT46E8sJP4dq9SG+du5Hr/Czg0+7kcSMeZwNEnwwogHpnlzpFtkqrswxW99PMA
         6E5ETWq5sbcftsN8zdm4YuKXwV6CIrnd4YpQBwERHOx7j3A32zEgd1SuT4i0RL0AxB2d
         n8avPS82Xdo/YbpQ/CuVWygsCEMEZ6q1GpPaRHO3fAPf2pSNZ4+XciwagPgndffitsZV
         wWiNHpGIACwnc2rE49Rwbme34DJr464mWBqxzBbGopFNG38+8wHXUyfQKF1MlUEzY4YB
         DAyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSQ0pSvUfJYvA7aO3tN2Io+O1j+RGVyb3tgk0M7ZPLcUxVQGc883kdqvOQ5YrXsH9FlZLRFnsV0rXsSsenXNm3FkRoY54v
X-Gm-Message-State: AOJu0YxwdJv0ebD9sy10VEQJLrJpYFUTuobKeBs7zKvsWam6Heuq8Zdl
	4uXFIWLcaHkhiHv+7ydR+wGfPPSDCja6bKvy/XfNG31fopoxfWMxazkJ29N62N8=
X-Google-Smtp-Source: AGHT+IE21RURyt0kYC+Jz489gsL7lhhTmR21aXYTlyuWI/0yvyEIMAOFWs8jF25IHJtn2FVRLjKUsQ==
X-Received: by 2002:a2e:7c0b:0:b0:2ea:772a:ddb4 with SMTP id 38308e7fff4ca-2eac7a526f0mr14280681fa.34.1717590075844;
        Wed, 05 Jun 2024 05:21:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:d3dd:423:e1eb:d88b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215813ce64sm19634485e9.44.2024.06.05.05.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:21:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath12k@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 0/2] dt-bindings: describe the ath1X modules on QCom BT/WLAN chipsets
Date: Wed,  5 Jun 2024 14:21:03 +0200
Message-ID: <20240605122106.23818-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are the two dt-binding patches from the power-sequencing series
targeting the wireless subsystem. To keep the cover-letter short, I
won't repeat all the details, they can be found in the cover-letter for
v8. Please consider picking them up into your tree, they were reviewed
by Krzysztof earlier.

Changelog:

Since v8:
- split out the wireless bindings into their own series
- Link to v8: https://lore.kernel.org/r/20240528-pwrseq-v8-0-d354d52b763c@linaro.org

Since v7:
- added DTS changes for sm8650-hdk
- added circular dependency detection for pwrseq units
- fixed a KASAN reported use-after-free error in remove path
- improve Kconfig descriptions
- fix typos in bindings and Kconfig
- fixed issues reported by smatch
- fix the unbind path in PCI pwrctl
- lots of minor improvements to the pwrseq core

Since v6:
- kernel doc fixes
- drop myself from the DT bindings maintainers list for ath12k
- wait until the PCI bridge device is fully added before creating the
  PCI pwrctl platform devices for its sub-nodes, otherwise we may see
  sysfs and procfs attribute failures (due to duplication, we're
  basically trying to probe the same device twice at the same time)
- I kept the regulators for QCA6390's ath11k as required as they only
  apply to this specific Qualcomm package

Since v5:
- unify the approach to modelling the WCN WLAN/BT chips by always exposing
  the PMU node on the device tree and making the WLAN and BT nodes become
  consumers of its power outputs; this includes a major rework of the DT
  sources, bindings and driver code; there's no more a separate PCI
  pwrctl driver for WCN7850, instead its power-up sequence was moved
  into the pwrseq driver common for all WCN chips
- don't set load_uA from new regulator consumers
- fix reported kerneldoc issues
- drop voltage ranges for PMU outputs from DT
- many minor tweaks and reworks

v1: Original RFC:

https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/

v2: First real patch series (should have been PATCH v2) adding what I
    referred to back then as PCI power sequencing:

https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/

v3: RFC for the DT representation of the PMU supplying the WLAN and BT
    modules inside the QCA6391 package (was largely separate from the
    series but probably should have been called PATCH or RFC v3):

https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/

v4: Second attempt at the full series with changed scope (introduction of
    the pwrseq subsystem, should have been RFC v4)

https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/

v5: Two different ways of handling QCA6390 and WCN7850:

https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/

Bartosz Golaszewski (2):
  dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on
    QCA6390
  dt-bindings: net: wireless: describe the ath12k PCI module

 .../net/wireless/qcom,ath11k-pci.yaml         | 46 +++++++++
 .../bindings/net/wireless/qcom,ath12k.yaml    | 99 +++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml

-- 
2.40.1


