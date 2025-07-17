Return-Path: <netdev+bounces-207834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6051BB08C32
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B251A62A7C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D5B29CB45;
	Thu, 17 Jul 2025 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3UCuTgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4367329B792;
	Thu, 17 Jul 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753274; cv=none; b=oRe4kZ9/+3PDeKPaZDPhSxbuQ7h1sYUxPWM8PVgwq+KZKG/Rgeazi26i73t0wrJylTKBJPSvVMmJcmJmWfJ9TxpL9ctkF1Ce7fRrGn11Gpb7WhDBSCeaigWCSpGHCtJlQ4vkYmxT60PbrytxnwH5nHdtwG5JxT61Du9oMLhWolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753274; c=relaxed/simple;
	bh=bhzLo4ihIrn+GpsC5HFT8T0iXTZd7UtjgYIR68Jg3Lk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TRHxR/yjq7ZBIGkmAH1xcqonzbL0y0HM0thMpcJO2OYmQACBrtQP6KFRK2xRrMpRsinHcWdc7scrMbJBcd9ca9ZE4L6liVkG4k+tDkI0WfGP68Qd5R6OoXJCPPtr7n0umYcqBjJM+Yq0Htiic/KGKF/fgp73h/dwc1jySf6zMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3UCuTgM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-455b00339c8so6088775e9.3;
        Thu, 17 Jul 2025 04:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752753271; x=1753358071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OwaDpfJEcRxKOOTWf61oJRadA9tv/V4ej5hL/3XUn7k=;
        b=I3UCuTgM/4aC1BWqx4IqHCfCFwjEiSV8NqtIdIUX8pNvEccJuUh1N1uPv7UzPk22fW
         thRc48ykneH3qOCUKqnXDQsrentP3IbnMGauQMUmWgKJ6a6yvtoyPG+mbvhXegRt2C1e
         Gwcu7JKPkbh47jE6pHNNR2i0Kr+HEC3N7hb+GfHG57nRmLBq5faDdZa6qJZPpPlo4ZPe
         YktR/PfVi8eWM1xmkrh79EsUWnrEAJRZjdPM1Dw/yuDW4uJmSEzM5Do3sBMLW1ugwFvn
         KLTWDcc9peGBKuXgxClf9nNh0sCnarbiBAstCX7geVM4XJE20YIf7T3D5meMcUNDwZCQ
         HfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753271; x=1753358071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwaDpfJEcRxKOOTWf61oJRadA9tv/V4ej5hL/3XUn7k=;
        b=AvJvaPkTgmR/qxU09Glu+52BbESQF4LuDk6DtDC3FFs5MRCkBUBhJSLaxd9B6FGvd4
         Nfr0ihgmirXG3n7bKLsjcD2aRAL74R7A3mX2XUWaNPWUnhFsYAa9NMqFbEH3jl9DSYN4
         HEhiivxpyyRGGBE6m8bg732qETN1wJwyzxke9fmIfKrSlHIGDWCeoR5u3hqM+qFPERrA
         CemMSGG5eV4KpQSqu7eNxUPr1dei5xPBhD3BFoUkz9S/O8+R9ZX2uV2b6fKn6X+qwUwA
         8YMkPAk/Kmcdmd6q74PSM90K5DFzy1s3YF6ISpe0GPnOetps5//HxADTMCMO0YWAohHH
         9Dag==
X-Forwarded-Encrypted: i=1; AJvYcCVpJJvbmdoM0VZgKHGh3Y2RVYd5XZSrTVJONzcFrA9cp3+QvA2OmaeMMGFQxxqavy8w0no1YpLN@vger.kernel.org, AJvYcCXYdLEHepOa4T3EZ91OD7K93eXUb9agrZOpUrbRmnhstza8UtUPNPA7m192rW2AWs8GmvnFfgrcEm/C584=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgEQAKIzLpyU6PjujAoHiK2Tdq39+iYZzsz5g5zQkgTbl8iiVN
	IedVhVJwaRyuEanRtb7PksHw3GGTnjJm9NmRLQlIeYTTptGrijlbd4RZ
X-Gm-Gg: ASbGncurPEnLgdnR0qOzAcCE5CYAnBgEn1+Z2CtZbpe/iuMs/+81nYcDi7JBkbv0dOm
	MiI5OsF5t+FblhJ6Sd+713iqYMmC7yRmqN4IQtjDJM6aM87sjmeJfEBbLxFGe+Le9h6YF8ApUG+
	cs7Yfz4twSm8OTPgGMCrjmZj35aTRbjRF5ZKpuUWtDEBaUq4WORa2G9VVfFf0PfQnaEuCcl9bYx
	jhyFkRLW4S1O8XIsglvbH1SsJ6wj7DtNWFm5cTHMLfVY4j5eC1eS4vUIeNcrFGuJ5cCzrheaKg/
	Dw3HD3utNi7bw2tZdbdmxInSLq1+Pp37R3BzfozsyRMrxSz88bJMutHqSAkd+kS7FhhBf7iB7vg
	=
X-Google-Smtp-Source: AGHT+IHVMOHZH7SPDUNDR3pkPQsudYw75tZGdfYNLGoOhFNu8ZiQi/vIXhS79TTUHfepzvUDm/MRKw==
X-Received: by 2002:a05:600c:6295:b0:456:29ae:3dbe with SMTP id 5b1f17b1804b1-4562e37c2d8mr62361025e9.24.1752753271257;
        Thu, 17 Jul 2025 04:54:31 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e88476csm49434155e9.21.2025.07.17.04.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:54:31 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	richardbgobert@gmail.com,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/4] net: add local address bind support to vxlan and geneve
Date: Thu, 17 Jul 2025 13:54:08 +0200
Message-Id: <20250717115412.11424-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds local address bind support to both vxlan
and geneve sockets.

v3 -> v4:
  - Fix a problem where vxlan socket is bound before its outgoing interface is up
  - v3: https://lore.kernel.org/netdev/20240711131411.10439-1-richardbgobert@gmail.com/

v2 -> v3:
  - Fix typo and nit problem (Simon)
  - v2: https://lore.kernel.org/netdev/20240708111103.9742-1-richardbgobert@gmail.com/

v1 -> v2:
  - Change runtime checking of CONFIG_IPV6 to compile time in geneve
  - Change {geneve,vxlan}_find_sock to check listening address
  - Fix incorrect usage of IFLA_VXLAN_LOCAL6 in geneve
  - Use NLA_POLICY_EXACT_LEN instead of changing strict_start_type in geneve
  - v1: https://lore.kernel.org/netdev/df300a49-7811-4126-a56a-a77100c8841b@gmail.com/

Richard Gobert (4):
  net: udp: add freebind option to udp_sock_create
  net: vxlan: add netlink option to bind vxlan sockets to local
    addresses
  net: vxlan: bind vxlan sockets to their local address
  net: geneve: enable binding geneve sockets to local addresses

 drivers/net/geneve.c               | 80 ++++++++++++++++++++++++++---
 drivers/net/vxlan/vxlan_core.c     | 81 ++++++++++++++++++++++++------
 include/net/geneve.h               |  6 +++
 include/net/udp_tunnel.h           |  3 +-
 include/net/vxlan.h                |  1 +
 include/uapi/linux/if_link.h       |  3 ++
 net/ipv4/udp_tunnel_core.c         |  1 +
 net/ipv6/ip6_udp_tunnel.c          |  1 +
 tools/include/uapi/linux/if_link.h |  3 ++
 9 files changed, 156 insertions(+), 23 deletions(-)

-- 
2.36.1


