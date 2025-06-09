Return-Path: <netdev+bounces-195865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC442AD2870
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22747A3957
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624C9224896;
	Mon,  9 Jun 2025 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyHu7krb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BEC223DC7;
	Mon,  9 Jun 2025 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749503310; cv=none; b=PhmSuaimOgokPJlXXwIril6kCURbr/ydyG07PS2e5zPGYF/55TuQreAsuqcP8+PX6THLgLTEwb96hr/EpPfmv0eUUvUsBZlzvgQtc0seR1osawHCsNpTzqjhqGFEcueAhnS4gW8pfOLGJajOZkw5+KgLUnMsFZeob/DZ/nvzEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749503310; c=relaxed/simple;
	bh=R5txiWduQ1MLb/7Ofzb1I1KmObx5d/2qHesoSZIUDnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ixitql89nqyVFBqQmBYfSAX3DTx/NDxHAV10NJswqf5mVRXwm/L2q54EMyxeUvDqeZ0AO9apnya6FL8OSl7fsEbEqdizBTFtYywp1B4IhRlSCrIF2dKkmEKNCYeervOKBddGD2cymCiMZw5hrZVAePbyKbnKR3TsV0BTZBt9TDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyHu7krb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad88d77314bso891739266b.1;
        Mon, 09 Jun 2025 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749503307; x=1750108107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+ejMMbHq5PYDlrAJtCac52TZKigbKKjKjZOjD2zAkU=;
        b=kyHu7krbBQWh4JJJdu1a7bnI7IPKrZ/pohySGnw18VfoGO/OqmyLuHX9K5/y9pxjpe
         oqZzqauJ8R7mgB+4nhlDTIcehJwBlS2VzgzX7c+PLKGmAFUjNUba+pW00NWUvG0Sz7KZ
         pBrngFxZiQz3wPZhBxo8oJBx7LN7A3eQAZu+MKVaxjQ7+nGLfhv9HfavrurtRnnQ7/f0
         T6XYJJx/OLFCbvpMgJVNQ8EM9IfUYXXHzURkBmObEYOafStRjukjiiBXLuYwW4oZnpLA
         DqdfUCMGYg5Es2Nw4TV5geNV29ie7R6aPNi/DKxeVDCKMa80QfnWhylziMK5Fx5Ci6lc
         21Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749503307; x=1750108107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+ejMMbHq5PYDlrAJtCac52TZKigbKKjKjZOjD2zAkU=;
        b=UZlbKNSMCEDT8+hDVUjT+/DiC1g82lukx/FElK01mtti/BML6ZPM1582QuOTfVzYdw
         MY9B1xQGyDbePhU7mFk6PcI+0ZF9J+GKn6dbSujUtsYt/yKxhNrzxPSLNStmvXSJFnZC
         1VeqgkyX2jknCCkM6jTmM2kUkaLJbitrJc/etQ+pwezkksf9BQlalyEySjLmtw82uXi3
         /7pfS4bvgvYA71/RNiRjpda7sFJiRJF2/8XVuh1s2FoxH+Asm/S6tGTyR8+GoVoEdJCE
         BeaAMd6SYsm56RZIVlfFGiqC41wjswYa8WbCqpunwiR9EhP8/eecYub0Bvtn2QxI6vA+
         gm6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLwiEztxlY+3cgEW3P1+FcGs/83K96tm0S6W/QLASH612+JgNN0GRZdv1NIdgf2kTtps4LFXIn@vger.kernel.org, AJvYcCXxJddLIVZagnJwSVG8y+uFUUSPlG3JeZ2QhtMmvbSIASkXrNmkwmtozdZ+YdW0+a1hifPuLsKPrIfqG2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbLwPL5HdJoJR2qtoftd4JXKC1BVaWBq9rKNDN8lryLM7lgat0
	8ExbCavRP+I7ekphMIYgFPlDILK9vFPcwkx36Tvs+QpchQ+02fpGJjbz
X-Gm-Gg: ASbGncuf1FNWFDaOp5H9DJGVD0G3tdnUWTqlW37HzSDqIH6rKQQ2NyULoFG44Vr3p3K
	/QwWQ9TsJPNFLKA3udvfJTZcI7/lEJEKV/rrD5wSzUUA0wolNouwVPlrkfUN6Eevz/KRapes5fJ
	kSQl68+5UTyTOO4XqT2hBps8GpsBntSBwiNcqPAOOdMLozdWHoQgHuDPkW7F0Stvo5R5venriGm
	dtQhOLxrXgSUTuDwNYylhVZzsSdhtFYYShnS3idXcXyX5eskvwBXsDOpK7ymTLggXHmoG7ju4BR
	bH9oaP+u77imQN7bQFXrJA8R+bxmFXFHU7SugmniafhLhXtS5sdOEeT5HsmnCInHUFaKya55
X-Google-Smtp-Source: AGHT+IFs6pWFDchlGAYQbAfzSey//l01J4bVVh1jx84lu/dDM6vfN333xLffOwWloudzTuKhEhqitw==
X-Received: by 2002:a17:907:6d28:b0:ad8:9909:20ac with SMTP id a640c23a62f3a-ade7ad0d89emr7718566b.50.1749503306793;
        Mon, 09 Jun 2025 14:08:26 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c57fsm609733366b.100.2025.06.09.14.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 14:08:26 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH v1 2/2] net: bcmgenet: enable GRO software interrupt coalescing by default
Date: Mon,  9 Jun 2025 22:08:09 +0100
Message-Id: <20250609210809.1006-3-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609210809.1006-1-zakkemble@gmail.com>
References: <20250609210809.1006-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply conservative defaults.

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index cc9bdd244..4f40f6afe 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3986,6 +3986,8 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
 
+	netdev_sw_irq_coalesce_default_on(dev);
+
 	/* Request the WOL interrupt and advertise suspend if available */
 	priv->wol_irq_disabled = true;
 	if (priv->wol_irq > 0) {
-- 
2.39.5


