Return-Path: <netdev+bounces-83533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA66892D6F
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 22:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546691C20E09
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F2E4C629;
	Sat, 30 Mar 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmT1BZSV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA82AF13
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833031; cv=none; b=WrQhQxRo6DfULhTj6TsCGB6LofQfoBuxDCt2D/TtQew1L1J8171bWygFIKyOoQr7jolBlWGKRWWQL6Mm1ZSXEpIyNFS9d8CikM9Ato82v4bA52dusuXprGdxVA3QyM9KyQrsK9krR8oRQ18Etl+x9HAcK2/rNyWlmgujRB9Pkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833031; c=relaxed/simple;
	bh=lpW/z88igPmtu+dPk6Bg5/M6be2ELRWCA4fiw4xQTvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS1sar1YmDqu1EiUhLsWX/F2qG+ZSKSVVh+BSA+y2eCEt8wgmoH6EJ9zOexB4dWkyFhGQqTnvcW2fbygrJDhDG875bRm2eppfhSCtuoKGGjO06HGP0lMNqNrLmjauiG/vzXcvf4flhuFdNGGG2951cca1G1K2F1rrX2aoNYOPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmT1BZSV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33edbc5932bso2153952f8f.3
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833028; x=1712437828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=lmT1BZSVVSPKWGgHfiytoJ+Ofrl4SkHaGZqmtLrRr9Xtp6NWN1fSkkfDwoAbSdPKGU
         7iICPbSYSWkoUys1nOax8ZNlxpQfq4PQJQ4TymEVCw3PkJzQTsCq7v7Undarn/f2KJj9
         ZG4QV60NcMb/lSCxXyT6TtbE/T3KI3GB/GjHWCbpmLOwf1Xb6WgjMLkLJ88lBAMR3Vur
         CTO1dryBej7ge6pn6C0Ijq3VRNqgK7SDTIyRth+3AeL0ZiRSUM93anFDVLadFESufJPL
         bPQQDMAzZMQiOF9PaZz+2bEIT1afJiAv9xX20LWUpM+NNBMnbp5GWBAf9our8hpGlmtU
         k/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833028; x=1712437828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=Z3V/da6Xz3DRp1xb2kWJvS4XMbNXnBs3jNIiApzfHCED05rvbFlBzMG46PmYth9sgO
         +SvEIZGIjOMJ4yHJTqFIvf9K4xFIfssfD8Fq5Ib8PzmyN8ahKgBdVbDKrM8Gzi9Ujp8H
         Yj55CnL6Uc/WHdSnI2bDfW28ZKFHjMFpJH+aanyiUtxtzf9OkFvm9Sm6GbQNlJccCz9+
         Pe7IczzArNBu+gADF538Ynxg9IWJQIvizj/AsaOSVma2Hgr+nB4CKFQXS25GD9flxh/U
         xN474rnGNVBCjAfhQoLXjz5PHQrmKoLdmYYD0OrxhiGUPy3FVvYv4fz/go1DY9HuJsaF
         DBAA==
X-Forwarded-Encrypted: i=1; AJvYcCUOTrI+i6c4KpEmf2l6yQ2FBhPUFcqZKLVGzCKLZrjWBIbfBuFG2Pn9O2Q1s4+aZAxdvd0qmTRY2CJwUU9hbjJtoC4QlhNe
X-Gm-Message-State: AOJu0YyipnUvvoL4YBTQ3jANCs6RsHGG8mK0cx4Ss72Fj2Lhl6zkk2OV
	zQQain5LobUn1FL24TAHzy3J+rz3cROArg3/5CIXmctNs/UQ1R4czd/2Q27h+3o=
X-Google-Smtp-Source: AGHT+IG/PwnuOG9GW/J71lWsyeYoc0pzt0O0RZTv5vm8EGRV8pODCFgM8sdpdU3qeNoyycuNuSNCcw==
X-Received: by 2002:a05:6000:4009:b0:33d:6fd8:90d3 with SMTP id cp9-20020a056000400900b0033d6fd890d3mr5016445wrb.4.1711833028607;
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80ea66sm7288097wrf.82.2024.03.30.14.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [net-next PATCH 2/2] net: dsa: sja1105: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:23 +0100
Message-Id: <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6646f7fb0f90..fc262348a134 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3456,7 +3456,6 @@ MODULE_DEVICE_TABLE(spi, sja1105_spi_ids);
 static struct spi_driver sja1105_driver = {
 	.driver = {
 		.name  = "sja1105",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(sja1105_dt_ids),
 	},
 	.id_table = sja1105_spi_ids,
-- 
2.34.1


