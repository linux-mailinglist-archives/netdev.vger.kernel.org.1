Return-Path: <netdev+bounces-53017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690FA8011D2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E522AB2112D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A024EB4A;
	Fri,  1 Dec 2023 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="ZnoZnPVL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E81B2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:36:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9c1e39defso30021921fa.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701452167; x=1702056967; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ts0y7v9D5+Y3Nd1r5fP5qnBJj2/1+gW2vNhSwpdDUro=;
        b=ZnoZnPVLPLW+f4KClR99QgZrK10tGfxP1iOnT87713vEZGFaTSADBmS+EZIBhCETeb
         pPt+QmzDOfYNTqUNn9ZcfQz8sJapTAlsXJDogi9aTWj5Gnv1WEsdsXE+exu/gszRBcJ5
         t8N7yVA0YtPxHvYhok0wvirJRvRjLfzUyVfkljWUDOMPj6M/0EKSSz/haDTCdhNYJit9
         bjKjRqgD1BMhM5kHyt4VkFK4udwz4iTMwvCd4DUTttiOPY64qc+pcjlg5FTvXrGyZYOD
         s7tsH9AH2BP8TGNAtGe478tbPwotoo3qp4Jf3QQhjIv5rlYDWaM2gAac/k4TMrkxyZkY
         nsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452167; x=1702056967;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts0y7v9D5+Y3Nd1r5fP5qnBJj2/1+gW2vNhSwpdDUro=;
        b=TAX6HwJJMPy5c7QcFTO7YSkIk0wc3ZnfwFMwZXBFAavP3VrXxCO+HAYVJs0xZSd4mR
         hfMqnGBjYVdM7YNZe4s6DdEAGZwzMhmMppZi96jyeJp0yuLj4y5vyMGq+m8tDYNGrBSY
         kOYlYYApd703Vf3yqb5ERgsLHwBrHdsm4i2kZ70ANgdCpmJ2bluBKdbEziZ/NhImup//
         S1WKjhhVnKHRkihvmmBrOEiaDn8mmvgxzCll+DAvg8/UXhu2h/hSyqTOyYQh68IaDKf1
         jzGU43rt66V9Q5BmAxIT7Dr80rtzNXzp7jx0aFMvj+M1w/Q2JDDnvLRl/n/o7GlMmH4y
         U+VQ==
X-Gm-Message-State: AOJu0YwJiYTWPlLQXhkb/NsWoFk7Z4atUe95bGllBaMuzx9e5/SG0tLd
	aSZr+7opFcbqrhgx/tPkGerrzQ==
X-Google-Smtp-Source: AGHT+IGwoBQzX8cZM6JHSNhXedeWKzYva1448hIkaxVJLC1hTCed94EifwIksdvOjtTu3e4d9M+Y7w==
X-Received: by 2002:a05:651c:210d:b0:2c9:d874:6f06 with SMTP id a13-20020a05651c210d00b002c9d8746f06mr1348045ljq.99.1701452167038;
        Fri, 01 Dec 2023 09:36:07 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-176-10-137-178.NA.cust.bahnhof.se. [176.10.137.178])
        by smtp.gmail.com with ESMTPSA id y9-20020a2eb009000000b002c120b99f8csm470327ljk.134.2023.12.01.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:36:06 -0800 (PST)
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
Subject: [PATCH net-next 0/3] net: mvmdio: Performance related improvements
Date: Fri,  1 Dec 2023 18:35:42 +0100
Message-Id: <20231201173545.1215940-1-tobias@waldekranz.com>
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

Tobias Waldekranz (3):
  arm64: dts: marvell: cp11x: Provide clock names for MDIO controllers
  net: mvmdio: Avoid excessive sleeps in polled mode
  net: mvmdio: Support setting the MDC frequency on XSMI controllers

 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  4 +
 drivers/net/ethernet/marvell/mvmdio.c         | 85 +++++++++++++------
 2 files changed, 64 insertions(+), 25 deletions(-)

-- 
2.34.1


