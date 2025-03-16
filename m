Return-Path: <netdev+bounces-175123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAB0A6360D
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 15:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5A77A7189
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97CC1A9B46;
	Sun, 16 Mar 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZd3Q3Z+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6251F941;
	Sun, 16 Mar 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742134794; cv=none; b=YsaitslPwoof18h5UnAQ2PcWwYLQhFNF2ND43iM828gu+iwe+SazDp4EsWLWvK/GWODGV5tdaFqEPe+2cw10xwPSHALJgVnBCshHj/HmeMkNCB4evmrn6Gw/Bz6/k7u9JjwBtc7MlL+w2O7Jgo4LFsRAIrmP3UaUVcgbvs4mpmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742134794; c=relaxed/simple;
	bh=ye63Bywgn9YfCCvNohfZiaNzW5kJ0zlKOT4zBINkPYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VFuROco2SBILLs3vc9uw+/8p64cip0HTZ7abGWuK18zxobjhXNmf5g5fhl9r8tj6NQMEEr0GoP6d3SrSjbCLABLzyKidUNTh2oQjMIFJ/lCwyba/mhpRIyeRdfttg5up2aO4IvJEVZPSHAu8JE/N/vikUpv22f+JAoYtSgVwUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZd3Q3Z+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225df540edcso36178685ad.0;
        Sun, 16 Mar 2025 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742134792; x=1742739592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEZkI1Sjt2nCNeQ1kxcl7qReMGGjv6RMkaomdlrg8jg=;
        b=XZd3Q3Z+y6JqF8Dm+RVqv/Ebu59yUTafcjWG8zUHD56YB3rKfLIa/h7U2XZjipMns4
         RRFp9RoXlRe0NpafhNV+s7vyInz59KVLQ0vLML7bik4GLKLPDTpx8yoh4UiZUBHV5aH6
         mVMHuxYy5GPyYyAJ7x5cugTlqtBwznul9q4yvwt+k3BsRWwCrF9FG+rT7Igo7Bj2wZxK
         ROjBP3Oagb7u9C2buPAzT88sEpXMFuXb0MHZ98kTmaO5d8AFPXgPs8iZGhmFqDPczynt
         iub70B7HcQ0kSV8m3ak3bWWK8rx4KQHNEqkabAgP/W/sAFllEaDAj6Zty29njvLjcsa5
         6C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742134792; x=1742739592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEZkI1Sjt2nCNeQ1kxcl7qReMGGjv6RMkaomdlrg8jg=;
        b=kuafcdXpn0nOI5+N4hSi7phZGpO3aUZezRTqH5MD7ziJ1c9xCp4LehA9iyek4buMIm
         xax2jEF4CZra72drst4a30wjFgl0fXFzAoTxB2GKhRo4YStJok2mOXXuPZSESBG9QmGL
         +PAoR1SHaA3VhFdVdnBY6wppx6q/eDlP6K8Fu3P5DJAJ3NvBIiLWyAHW2/fAprdeVnFq
         wXWw7IkExA4TeNt0T0A+Kd8ssQnYggr0NV/0tW0/Vx6oPrVAnZWxCpjRDJUNUjEY1OZA
         MQcdpyeiGwivyRbQfzU8Iwm4jfNFbZTLwhX8AaDMer9smum7JgZPpsmpcCc3ecVir/Tf
         8wWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg8XIgg9K1OeSc17ZUF6NIN50IH7n6Jby+5ougcpvMGLufIoCwskrB7i/aRUABB3bX6lUcsiniR1isZKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6vNEzw9rTlOsYhUdlpTiBeUgCl12XhGDK7r1YQ0uzaDav/Ad
	z3c7Zv430QUkZJiGo4egQcLlPZBffynTkQoWKwTSDwb/+xpTyk0=
X-Gm-Gg: ASbGnctDBnZedby+7fILMK1zT2jr3MPIROS+ubAMaYO8wYgTooc1/rVOUb+I1//hA7Q
	4GWg7PNe4ZCam53qwiS96BuRWKYDy5ipUam2gEtSRC3QmLCseLhK2Vw5G6UQ+FRKXPcVPvP9jr5
	IdNVW+u4bM1PBCc3ryX9OJeKTvU5yK0PgcErYvNv64d+fZxWx7nrN698Gv/VrsBO1qgbjpahPvN
	L/44URkRbwja0B/SkqLjKaJAuv6QkJUcVXh3z4yIxHLvXOtNmfODzskMtC7mbn0mJpB8/zWswDE
	3DpcO+eRBkIZLpPMk546OZ2r+pggAMiC8SNlZGx9coVHlOb8vb8p1IJ9b5r6L7vwu2KIyMu1/6A
	P1GWMgNyJ2tuQccUUUrYfGRIxr5TUNpJ7trvZ6cddqaEpLOuD
X-Google-Smtp-Source: AGHT+IEX3Xl2MJysxm/uZGRyuyX2HuxuiJUSyvVo/4jGaT6/3lTf9Lm2xh0lFwWFY8E48UIodUcg7Q==
X-Received: by 2002:a05:6a00:cc6:b0:732:5875:eb95 with SMTP id d2e1a72fcca58-737106f4aaemr17977352b3a.4.1742134792413;
        Sun, 16 Mar 2025 07:19:52 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116954aasm6014734b3a.135.2025.03.16.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 07:19:51 -0700 (PDT)
From: "Lucien.Jheng" <lucienx123@gmail.com>
X-Google-Original-From: "Lucien.Jheng" <lucienX123@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	ericwouds@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com,
	wenshin.chung@airoha.com,
	"Lucien.Jheng" <lucienX123@gmail.com>
Subject: [PATCH v3 net-next 0/1 ] net: phy: air_en8811h: Add clk provider for CKO pin 
Date: Sun, 16 Mar 2025 22:18:59 +0800
Message-Id: <20250316141900.50991-1-lucienX123@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds clk provider for the CKO pin of the Airoha en8811h PHY.

Change in PATCH v3:
air_en8811h.c:
 * Add clk provider for CKO pin

Lucien.Jheng (1):
  net: phy: air_en8811h: Add clk provider for CKO pin

 drivers/net/phy/air_en8811h.c | 95 +++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

-- 
2.34.1


