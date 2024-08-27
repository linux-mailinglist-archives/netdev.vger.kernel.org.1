Return-Path: <netdev+bounces-122379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3771960E11
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665401F214C5
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830261C68A5;
	Tue, 27 Aug 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jw6N7h8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434541C6896
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769869; cv=none; b=VKbY4bLH0mB/GL25WRPbRmHbdaVBV9ohCDxgeJEtnlaZGdxho2aNBrIs8Xt9jN/68uuhRH8mXhwdv3ygwRo/d8TSAqMA3jIDnYJSOCsylm+vqgcfw0HCugdKr9qhVztmP2XyfiHrKlDHGNke31sNDECjW6dZh7oLzYlc7T82N0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769869; c=relaxed/simple;
	bh=P24Zjno0lEiUZy3KOIObRNy9ZX0P56rCaFJv5qSPwLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMnwmbB+JDZOclmyJMI/TzL9YbKUQPdyJ6kn85Egm89jBkXA9wTScsxg23X4TH6zRmELiJvcKZZ6sG1jWY3wc/yrZgwXm+AjOKMVCnVrwANoqurGDqdS1mKFsEK31TrKXwptcRBfnZtPRcwwrRu/nsY6ZUZvVZl5w0X1/k2D/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jw6N7h8v; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3719f3f87ffso145728f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724769866; x=1725374666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bebi9m448FlDGnXknO41FllDCndggnQkc3Jowr1RqbI=;
        b=jw6N7h8vanW6ejCEZ8BnDuwjNyjymLR0C1/GbyA9o+8e7F9RtU0grEw5XiOlIN9oB/
         oLPPG1aVSUcdJRWATeUGB21dUqI4L9SKWUVLgT9MQFXc63d09uVBpvlU85fSgxRP+IkK
         YrFxEjLF917v+AFmSQ3Sq2NpwCCuuwBCoSD4AO9KgaOkO0ST5+KpNWAMOBWDMmpbY1pM
         hm/Mh5PO4z6ejVjFcSlVXmgRWRdK8oLULfBMzljJ8yXiWJkkKzdtsiG/dtqDmIWNNqVj
         LdjOSG4KpboYMp4lCUgRumP5d7TTzQu45U+sxHjjSmMTnaNfvH/k7VmHFMKC5oStr8Kc
         uROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769866; x=1725374666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bebi9m448FlDGnXknO41FllDCndggnQkc3Jowr1RqbI=;
        b=pKG8p7Hrq7vMVsZg9BGYZaLTjO4Zi+xvYG+R9kFfz51/ZxuC72RjbR56wf597tZqjb
         myDQix/T7GDiNPc8tPFIjDurbqYzY953HHIrWbqDdKbINRer8VNdndMllNGsSHyVBVW+
         qUi4FeIhDRK+OID4lIPsUujRKumy9IJ54OulAer+nVrS5hIhsjVOVMajtMMLrqtugo8u
         rD7mCtB9wqLuyH/jHSrm4xUcAhXtItWiGTuvuHpD8MkBkG2mYgHhw791lLCDDXr/d7Pa
         RPGi+ZG4ZWVnTrrixKTks3JR3848r9HClmIruHJ41vfwxuKvxkoqrGnFSTaTEdN/pAVo
         FUBA==
X-Forwarded-Encrypted: i=1; AJvYcCVEWSrps3I9pQ5i7p18AZBGhyo39C4sSFNiXTClG3vh5hWdbutvPGLNgL4T/XwaX3lVKGzk8yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMDgfBG6yvXqIS8+wajSI8op6ApVxpDlORgcFOx2w8v3n0D/s1
	vS2XcmaRxkQR4akEQavb2WmP7SkuhNaamjZ6j1/xlHo4kh6CXiJmnirRRCXtw1Y=
X-Google-Smtp-Source: AGHT+IEq0H44geBxCfxgBX0OQx+lxldA1LAAM4/On2LXGODv2XzZmMe+Hr3f4HM8uBQkP4WYem7Mbw==
X-Received: by 2002:a5d:598d:0:b0:36d:1d66:5543 with SMTP id ffacd0b85a97d-373118ce8a5mr5003942f8f.6.1724769865571;
        Tue, 27 Aug 2024 07:44:25 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff654sm13270457f8f.75.2024.08.27.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:44:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next RESEND 0/3] net: hisilicon: minor fixes
Date: Tue, 27 Aug 2024 16:44:18 +0200
Message-ID: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor fixes for hisilicon ethernet driver which look too trivial to be
considered for current RC.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  net: hisilicon: hip04: fix OF node leak in probe()
  net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
  net: hisilicon: hns_mdio: fix OF node leak in probe()

 drivers/net/ethernet/hisilicon/hip04_eth.c        | 1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 1 +
 drivers/net/ethernet/hisilicon/hns_mdio.c         | 1 +
 3 files changed, 3 insertions(+)


