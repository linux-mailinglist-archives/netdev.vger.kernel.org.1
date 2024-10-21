Return-Path: <netdev+bounces-137430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC19A63FE
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CAE1C21FA4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24CC1F582A;
	Mon, 21 Oct 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emO6Lf7u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BA1F4FB1;
	Mon, 21 Oct 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507015; cv=none; b=nE8UznxGTwoKkT4+VGAkH7xIeeLrzigJFqanX5EIRHWb0scZ77SQ75SRUPBXERO3Hsi6fOFblWzComigasYzFfQmpLbR8ikpe+LWwKjnYQfbR5QTVntcU5NPO4ujBPvwsJNeEqpFJLRasf75oaPRnfVTAvS1QePiLKuEGb8O1Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507015; c=relaxed/simple;
	bh=f6Dima2Y36bgxCR9/TC5mO1Yg4VTmiBOuZ2X/k0C2Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMOMsdIS9AvsGCh7Fj23DB4BAAv+F0KQnjKCAnsYlinErNd6pJTrtBws9/bvENjTWp0BkGP1G5F5wOSJjHqZJCk/Bi8RELAOIYRCvimWoXSm7sdvOVI7Y9ZvJL8wjZCfv+QUjAiytJ18uoP2PSav705SngZvoeGt6z6/Ifw1RLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emO6Lf7u; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e7086c231so3234113b3a.0;
        Mon, 21 Oct 2024 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729507013; x=1730111813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObJWQqbamWQLgW3lRvM1Wb6QskCzdsvaBlS+OW3U2H4=;
        b=emO6Lf7uN1dNDvxcVV/OmfEfunBgglw2+qoV+GJ153UMvEEpKiDOqNIzjGGd5OQ6Oc
         DFrrtVACWEKxJEcqdZmXl/R+8O17CcOs/Hvyqeg6wqJYIx7tVBtLpmKuZN4sDyhiWyXL
         XSUOnrlbDqGtDRHhqbsdkQoDNyc4XXMVxPL2KWkh6N1rIrH+A2PoANrsj8Cewjmmpapc
         B+B6azCAKuhpML2mkKgn3VwZhbNUit9ndC9ZUCn02PciqnahjRUqtgDpCVgX8ON7vRIT
         QWtXcqr8ha0pBUg/lBXNcEdrNQIbYGEUCwQ7jT+1sS1gVIbxC370XKK9AW0/6ntMGmwP
         U3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507013; x=1730111813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObJWQqbamWQLgW3lRvM1Wb6QskCzdsvaBlS+OW3U2H4=;
        b=fat2feCv+IvGSbL+mEdVN/++UyhesbwF2B4wDznRNJlFanUCDawCrFJDzfXxPHXJkj
         2uM8id5pWr3c6xFBZFFlYfZKTbgFrv7Lknnhy57k6rpQ/rHCW5cgdGnBJWXY1Tvgc3Kt
         lQ7pQpHyoBC4tv5midQGNqD5ZfO5/nZCoOYna6KS+vaVt1f2fwAuZMnadtMhbqkw8PQR
         KbauiJTvYFn82BYsR9Eo1zD8F31kLkwmibkLMuRDdgbPwHHBYWf5Tf/29yyt86aPYZ2o
         57p9gwqlURfeut72hbutCqJXghepnTYmu/ly56awad2DuFVQYwjkkaTWNfEAZqN/RlgY
         4xrw==
X-Forwarded-Encrypted: i=1; AJvYcCVVqKRoMsqtC9W87mMM4dX4SERI8I5EuEqCBY7C+PlZtM6nP31Emkbh+pWFiSb2t3aySoebrwZH2G7S@vger.kernel.org, AJvYcCVuAckMpY0g4lbKtV9cANYKaKN8aHwYc47+YeWFez4PE566mr6GlqzvdKNWr+O6CE72ho52hvQs@vger.kernel.org, AJvYcCXLzLb3NL8KYxi2gmbRYFsTwEfC2b2beuPXknzQvp58xMn6eWiuWZe8vOdTZ4qlfiigduPCqTzM5f0epkW0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UOcIDyj46H2vISkPbZqNKclZn8zlWSgsDOdt+ZKGVz8hmapb
	zFAmx+jbq55qqkSH6xi4W5CpuUHSjiCJ+WSJkon87CLgjA89hn34
X-Google-Smtp-Source: AGHT+IH92yYXC4eqDoteqMVnaKaZwnewH6U4taRuuS75GAekpZY3rtWoFcqSB+3PqyFf4WP9/QcVHw==
X-Received: by 2002:a05:6a00:23d1:b0:71e:6f63:f076 with SMTP id d2e1a72fcca58-71ea31927d8mr16089602b3a.5.1729507013033;
        Mon, 21 Oct 2024 03:36:53 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffc3sm2556008b3a.62.2024.10.21.03.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:36:52 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 3/4] net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
Date: Mon, 21 Oct 2024 18:36:16 +0800
Message-ID: <20241021103617.653386-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021103617.653386-1-inochiama@gmail.com>
References: <20241021103617.653386-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "snps,dwmac-5.30a" compatible string for 5.30a version that can avoid
to define some platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index ad868e8d195d..3c4e78b10dd6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -555,7 +555,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	    of_device_is_compatible(np, "snps,dwmac-4.10a") ||
 	    of_device_is_compatible(np, "snps,dwmac-4.20a") ||
 	    of_device_is_compatible(np, "snps,dwmac-5.10a") ||
-	    of_device_is_compatible(np, "snps,dwmac-5.20")) {
+	    of_device_is_compatible(np, "snps,dwmac-5.20") ||
+	    of_device_is_compatible(np, "snps,dwmac-5.30a")) {
 		plat->has_gmac4 = 1;
 		plat->has_gmac = 0;
 		plat->pmt = 1;
-- 
2.47.0


