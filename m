Return-Path: <netdev+bounces-241833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315EFC88F77
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520113B3244
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46612D879E;
	Wed, 26 Nov 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr+JBvAM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533C2D060E
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149597; cv=none; b=ZvSIfOhh7IF8/vC7hWHSoHUL50eKRCt4kpiAEOlgfWKZ8m2mk9svZ0t5oBZKs5DGoqmxhFrHLhpRM7A6gF2vpmlQ3IOkTwgIRNp2rPZXFwcatTlhF6SxFEfhB3D3Zul15Tw4inTQoJ37wRCAmXAxWUtMJ17hAWUH4T1lvNdcNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149597; c=relaxed/simple;
	bh=G3luL5h87FiYKVKYpGaCA9tTliaz3n2dn+ox3g2co80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyGDW7yLbr9HTwGbeqdrvENSUaJwWsFANsvDQpHxolm9K8NVHVgismFgHcJmMAphPdhpQjIEZw7hG+CGXct0s3gkw0mF5ISjrOdANYYadP2QInZkZRVUjugZt5KGPWuNbBwpPUNbkAj2f/igg2uB3yb4S7JtIMbR747S/dLnAes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr+JBvAM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29568d93e87so62097015ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 01:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764149595; x=1764754395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YuIJpaKzHke716l0VV4bsMLRdGznljskShXTq36gkmY=;
        b=Fr+JBvAMBbIrr6AHZ0UUFL0BJUy1CeoqXPHoOENjmCvbzrnHA6GJ+BaLSq5J1GIAg3
         4JTs8Kl7ZN3XDYssdpa9UldMG3wHcpvzYd6SPWP8owMnae+dFpIYi213LmBbg+V4Kwns
         2cV2wiN06HzVDTmdedY9QT7FNXFxGDRlhFrlEb+1YDFLIupHyIHTchPRDCxfDIsS+j4l
         /lBOLRS+Lt3magHE7BC/zPAShpIEGTcUq5fbIgwA/Q6pFqc8TCfj/g7pgKuw7oP1N1vM
         kncWfpg/hzjiBNahLN1RW/2U7eVHNUeltIgmhT+b/GY6pA+4vxv7qfAhUEX2wrZrJosS
         uqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764149595; x=1764754395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuIJpaKzHke716l0VV4bsMLRdGznljskShXTq36gkmY=;
        b=uQMevzKjCrl4NxPrddX7QaZLNFaV0pgaIiTLaTIdpkyjJFVjWt6eXEBHGoLCiS8WjF
         DMmofJ3TUpJwg3MbBJ4y0/l6NpUntI8eySWfpeZl0a49+SoJBZpvbd256qSwSSrn129o
         f7ZGclR2YiV8Fr98tezo4poNnoCi0drDCdp/Q+fhVNngsyqmXQMuItXZTiEgah2CU/Vz
         +zEeYjU8+SohW0ijDZH4Soh2DNnMkuiR3EK77qWB57kqynhM3ntxmmkxXWNo5SYlMG7Z
         8vrcVnsMqfkGJ6ptxjaZbQ1HLqVW3iCn7x0IoSwhNboUH+feQG8aiV5UDQJSjvo7KnrF
         rjcA==
X-Gm-Message-State: AOJu0Yw5cS1/ne7Jkz7QbYlXXhHVNc6bqV2KVAdVimlFanzH2wXPBOs3
	KI5cOBxPo5ngmgUNiFKbLceQDJcvx/Qbaj04UwfMkU7O9mhnHpBCK0JKgkOsKA==
X-Gm-Gg: ASbGnct10IsVSIIcp0fB+YWccVSbMDrtIewNdYncEaiCZCKce4FCtAVP6fM/r6+JgYF
	pk8JjLLieG6PnJ7Fw80SPY8sswVs64PbQAClonSKgJjIAJMemd9amXr9msET+TwODCbavRZlLmn
	Oqsex/54UB6RJi8B6RxkLmdOv3N9Z/kRt5uJEfviVjSBes91ZDFgfIJHIuPvIi1ZvEDdO1C1TyI
	QX/Dkt2wY8C06qf6qwQiMkzhBT5/zzOAmAgkqrfBa11f5gtMpwW1JQYLrwjj+T8N6SLnakSdm1j
	P7GMB2WySvgXQTURwHHmXle0UecLTTcOamQb66JsvVprsz+CYL1xH1eQC/2PCXJJvCJv8/HulMu
	726hbunjgYmWJTOvH0g0CkYZLRPykGymR6gfHm+oaPsLhSag19jp7KBa9F+5D9ngc9cZtfOfozF
	6kmes3tWp+5wjZk3kOqpM00g==
X-Google-Smtp-Source: AGHT+IFbR5NuGc24t20HwaBTiAstRFkxomeUZW6NL1qdrcY+NzTgLuuVseSgJQdWuUPT98wrs1YCDw==
X-Received: by 2002:a17:903:2a84:b0:25c:8745:4a58 with SMTP id d9443c01a7336-29baae4ed0cmr65115315ad.3.1764149595459;
        Wed, 26 Nov 2025 01:33:15 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b78740791sm132101735ad.56.2025.11.26.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:33:15 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/4] net: dsa: yt921x: Add STP/MST/HSR/LAG support
Date: Wed, 26 Nov 2025 17:32:33 +0800
Message-ID: <20251126093240.2853294-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for these features was deferred from the initial submission of the
driver.

v2: https://lore.kernel.org/r/20251025170606.1937327-1-mmyangfl@gmail.com
  - reverse christmas-tree
v1: https://lore.kernel.org/r/20251024033237.1336249-1-mmyangfl@gmail.com
  - use *_ULL bitfield macros for VLAN_CTRL

David Yang (4):
  net: dsa: yt921x: Use *_ULL bitfield macros for VLAN_CTRL
  net: dsa: yt921x: Add STP/MST support
  net: dsa: yt921x: Add HSR offloading support
  net: dsa: yt921x: Add LAG offloading support

 drivers/net/dsa/yt921x.c | 324 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  55 +++++--
 net/dsa/tag_yt921x.c     |   4 +
 3 files changed, 370 insertions(+), 13 deletions(-)

--
2.51.0


