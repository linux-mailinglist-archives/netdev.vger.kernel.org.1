Return-Path: <netdev+bounces-148211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5B19E0DB6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB38282507
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22EB1DF278;
	Mon,  2 Dec 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik+NKr0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA181632E6;
	Mon,  2 Dec 2024 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174615; cv=none; b=i0c13o7F8Qa/Ls2m5gunpkCnnbbs5Q8koophqi6oWTje1yb37u+no9CUK3ROvv4zjYMLpPvjSxovm0s0izhDNDw+qQod4MwL8zAZWXM4wRIX1OAFD5vHignPBGRfUyXa8MjTDKnKAJ5/Lf8cwk46t7ekY4PYVylJa9NjnBR2E2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174615; c=relaxed/simple;
	bh=CS/KIHn4VDyhhxAdgYVub3wrc0akIjDyXKnQqlaqLZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDFJ7m+z98YdE8hfa88ZnIw3aL5/M0L5VjK2hvHUZu5GYXEKzpRudO2wIVYMc0zUtBd1W959QR58lYFVKx/+0kIyOP/e5qUQ5jjcYdi0Pep0wAhUUo17aoQx3VRMRJr4c8NbefyhVL4ygjoRkWuLweEldAuwWF8ctztKMAm5ZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik+NKr0A; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-215909152c5so14704765ad.3;
        Mon, 02 Dec 2024 13:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174613; x=1733779413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gxM5Fv776NBueFcLVXEfSooxEuCnJheRsp5wMbPesk=;
        b=Ik+NKr0Ah+AasYM7OsG6UqQmEuGEsDLRNGou8mSX25U/XMD0JkpSh6+BG7joEsRUeE
         /hnboNjNAOEQO8iBqe0iglkmGa4E8dEP+txVt7EnV6ZDOIXfbyf2pPNPhOz4qd5PxI4Z
         YFhIhbRseRStEsZaRN/Pt8a8leb06nuc31VoXrDRlV0PtFXAzhuHMDK9v31Fe/o170tq
         0DqHZT4gNi41QByr0fZRnGYUykATEaFqDNetXmCHNnaGBCaSmSffCIj/9XAF3kSg38cs
         UvcZYjbBws+w65lQh1VIzngm6ZcwCRf24b19/ACl9cO0b/h9XlTCZAB2SYpi7ny/RtKc
         5WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174613; x=1733779413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gxM5Fv776NBueFcLVXEfSooxEuCnJheRsp5wMbPesk=;
        b=AEQiLnYi+jY6PixqKBTfhv+LenD9Asf7jdVZg6D3r2kNf/ZyaENxhlAN6OtKz1DHN8
         WluOirKKGk+Hi7kCGyJF9V4zNuqJPHHLABhvEbIDOxHDmUcEdO2U4TnMKPhlldK7U12w
         +pbkeV2CEU7973E25kQGntEtLH6r+nUQ9cnuJreZzDHdpoN3SqzuF+OSHl+30udxdPYd
         L9YuM4TC4oiLus6EPuzHWnbr2YeeY2RJcs7S16xKpkeEuMw4YYb8DD5P/A7sJtA0flKF
         AFvHUrLFBRKqI6aPebdwejUhgw0CzAaeTvvsgMv4D6W5VsGukMsC1Uukv8lxlJwIpNQm
         M+eg==
X-Forwarded-Encrypted: i=1; AJvYcCU8EsN72pYW2c5b4itG1Jhm+L53rGn4XNGD/SBxtXHqTHxbVmayVCNykuHhv4p+BuvMmbtOn24XRViHWCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Zm2ClXXluL2bIS6zGBLrnYrhE7mPYHEjQYqJpiCp2QwYHV6F
	r43kaGHgv36T0thnsJYmJ1tz+MVZ3BomfndqqA4lRyOlN1MJJ5ETeXwcLHmO
X-Gm-Gg: ASbGncu0Blh5oFizmNseUiW7W4ah8ZoQXSxOiENTq9cctgZDISXIF9pz+tl3HqMkTO0
	dJqoZVNfSVu2jDRvX2DEslSlCQAsFLiuVeXSkqez6mM2GHqtyHMHgZ02e18HaORapmElrahl4m/
	EpdAjHbTWf65vD4THrtzjN/cL5ZsrH1pMxzxuDwdAyzNrUe6FF+beBssJ2haylesN28Dd+0nFaw
	egJPEtHib2Z2NLztREg4tR+xw==
X-Google-Smtp-Source: AGHT+IEzvLy5IysCCx69p7ZApQPDg+7EGuJ+dfzNxJvf/sDwkhZoxFdhtkXhdA/OpbpCz8imQUxhDA==
X-Received: by 2002:a17:902:f545:b0:210:f706:dc4b with SMTP id d9443c01a7336-215bd1c2a9fmr170245ad.13.1733174613285;
        Mon, 02 Dec 2024 13:23:33 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:32 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 00/11] gianfar and mdio: modernize
Date: Mon,  2 Dec 2024 13:23:20 -0800
Message-ID: <20241202212331.7238-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probe cleanups for gianfar and fsl_pq_mdio drivers

All were tested on a WatchGuard T10 device.

Rosen Penev (11):
  net: fsl_pq_mdio: use dev variable in _probe
  net: fsl_pq_mdio: use devm for mdiobus_alloc_size
  net: fsl_pq_mdio: use platform_get_resource
  net: fsl_pq_mdio: use devm for of_iomap
  net: fsl_pq_mdio: return directly in probe
  net: gianfar: use devm_alloc_etherdev_mqs
  net: gianfar: use devm for register_netdev
  net: gianfar: assign ofdev to priv struct
  net: gianfar: remove free_gfar_dev
  net: gianfar: alloc queues with devm
  net: gianfar: iomap with devm

 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 92 +++++++------------
 drivers/net/ethernet/freescale/gianfar.c     | 93 ++++----------------
 2 files changed, 50 insertions(+), 135 deletions(-)

-- 
2.47.0


