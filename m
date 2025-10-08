Return-Path: <netdev+bounces-228173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7946FBC3CB2
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39775402590
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1737E2F5331;
	Wed,  8 Oct 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AKeRO9cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5BD2F49F7
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911491; cv=none; b=TpoHlQiCOC9/cVGn6CBdF1jbrBSM5keIq+2wAXHwUMyREAEeIRBixdxT+Dak9wL7R0eZ3F+Gy9hHx4/cuKA4y9MTYUT0a7ORVsGooWnOdQfj2WNrT6faXlkFjADyYqhJMlTqz+Vbt8rH4eDvlW1g7853ioS/RSqaD8KXDlseAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911491; c=relaxed/simple;
	bh=fwsfkO/edNU0K9G/U0ffbwq3ATl5oZ4mal9F1JcWMmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsnKFAap5vjGQDF0+DC1ILHNLdvTu3hBdG9kfk6P9tXZ6b9oGk+pg5o4C7W+39MtlJZutgemC3/a2cGLoB2ZUUu9s+HiaJvdcNO5RMo9Av04PwCnvVZSpJSOaze7kaD62Q/rNapAEyZLlfFYAgt04fYm9dG4YsDEkRBif8CSEk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AKeRO9cz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso61118385e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 01:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759911486; x=1760516286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pG70VB/2THcHEf1bbNlRsLCEdjUZ295qJspYMOYZW5c=;
        b=AKeRO9czjZv00Dn2+H0YSz8R5NTOJX9b1GgstI+U5Tls+1YkBSwmWjkJpjgNKKpq7J
         SK8J+kSC9NHeNZxYVDSRwSA5akgEUWvx8yoqfIdurubPD4vjFcZCa6gapcPX5iNFuDoI
         vzOQJYLDKyBvGqnL4nxDVmlzmfbOz0KUxebekf6MQwHhUCTig1wKbULIkcAvA+t+9U7e
         JLuPBW65qoN2ciELOuG5788WOr5/mRLYTVrpxsrAi9AYJuxqlSQsJDE2JBsOJslRs/PN
         uKCS1BiUVNhQFW/lSPaUlM94vy7buLAjGXlUsrpdlXpSKWUZqyXjO3mWp5Mk8RybHVfI
         qVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911486; x=1760516286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG70VB/2THcHEf1bbNlRsLCEdjUZ295qJspYMOYZW5c=;
        b=RV63+Fu6KQ/HnicWGjqupCuLOaF+yfCHQFo43TU1a3U+OQJlg8gLYsS04i6obDGsVa
         hsEmsQCfSfwlXIY2zd38u6/AJN20LGWpSBbMwWqALVUTlRv3H1C4JAABKaqwGGxbXEY+
         OzdWJHcPaEjyZSBd+StcGw9WOru051tzrvIeMXDuoaQITdbW1htD1Ky5kkG6F/m57e19
         FGAnpXK3tptSpT1cXOlItf3Jy7QOMMYUVKEIvGRP8kYwa9j7lTdfhzxYLcOrnqWOfwsH
         Veir+dH39Ud2quz04U87LahGrz0nApfWLjbYvWBuyTb3+KVwjfhm4dvwqVSlLV4bkzpl
         rMqw==
X-Forwarded-Encrypted: i=1; AJvYcCUZQ+ngN4Um+HjNtPL+DhNh/HBRVpIyJ5zcFmLQc7yiinO7EvpIKSfZV8yy1PeImt3x54WPC20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/eGxYnBsckV9rtX1LA8GdNmTT2pk/H3EMKdt0Z7dfgNYkl6tD
	CYhUI7ZQMDsbZ/oNc8/MUKu/52ecaI/8hnN336AGUIvGN+ZfxqwBtOqLrQvZW3TA9Tf3nrlM4tl
	jFRVGsGw=
X-Gm-Gg: ASbGncvtAWXsIMT+OQWLeZMwkJNawi0ptxM4XwLR8IMT88XPJLHoyOvip1+QwPAyOxm
	NEXwdDSbKcx/E+KuRTPzEvJmupiHRUnjnJ5ZWD9WhX4Lvnj2GNy7zOWmbneWy2lkkaGj1BeIPpf
	bpVvCbSWVa9nUk+ea7ePd6N+nq379JW3oAn9b9ZOmz0q1gQRxp8ou24aNVIUwyMYFd7QPPBlDHV
	UYjBhsxFCuJKPUxUA9Y8oytEvNbqPNwpa9blFNA04MgDqIAq08nplyrfCBQA0k6lCwpCfPUSqBP
	WpKNj1hMhrUuZJnbjoMrhkV8wD3gv2ZvZVl/xfA77AmBau1+6XuSp7x0T651vwYPAesL6BLwCOa
	IH9zt6P/k/mqbCQVfsghW2Qf2R92GH12noZV0rnEZfg==
X-Google-Smtp-Source: AGHT+IFZ5tJ74Dd8NfGzTg8vtMg1MllO17lT82vWUmOq7OQ3gG3+s+nr7vbc7H7XnZcyQC4U55uDjQ==
X-Received: by 2002:a05:6000:2c0b:b0:3ff:17ac:a347 with SMTP id ffacd0b85a97d-4266e7e11c4mr1568045f8f.27.1759911486432;
        Wed, 08 Oct 2025 01:18:06 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:286d:ff1d:8b7c:4328])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97f0sm28498943f8f.27.2025.10.08.01.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:18:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 08 Oct 2025 10:17:50 +0200
Subject: [PATCH v2 3/8] net: stmmac: qcom-ethqos: improve typing in devres
 callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-qcom-sa8255p-emac-v2-3-92bc29309fce@linaro.org>
References: <20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org>
In-Reply-To: <20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=XKd4Dvzw0ejsOil4omJOz8oD8d0/SZudynnYpUwSWG4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo5h415mstwMbaW7Pd+AMIYxCLrUK+0mL13oDMj
 r/Lo2JcBn6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOYeNQAKCRARpy6gFHHX
 ci4REAC4/wE7bcatuqkHrpg5e3HuhnTcns6CmyWz3AKa2/Puse4ECBVjst/2AarVW1uwOO54Y6w
 xuvwBtYsD5n/fFvMElHuDacPLVuUEKxPAGIvSa2rWXpQDz+/rDz02E618QKXcAOPAGP/udYMrGK
 pCNGnGHYbu3973QNtraN9l/qkIWonjrYC8j2DiHWxlmTG438f/ioYqBN8lGWNgB0gABdFc6nB4K
 8FAfZzZr12R3W/hHlSLye5wRbw86R8tPGuVI8fdB3hHo/EGTEZyhZf5VkYFIm0cVX3Dw+dkR9+G
 fZBw7gcfpi92uN9QetmOSiiFRvD13QpiD26EtbO74cinB72NGOXb6s3Fdnf5mvTa2Hwn87zUQme
 ftGnM2R2IZc8rxslO14U4tNEc5/bKHT/QX2nxSPQ+xA7riXel0xBu2VlP+oh+15E2H3jZ00CyN5
 zoBVnoXTTolGtT/AceoBTEsobWOnHMtodoxIBuwLDCQEn+URSm4esLLlTotDkCuD2dQVdY7MN7a
 dcpeDWTx6OCqZH2PLrk/Vl/mLsD6thI+Bw5BNhNO1pjh0g1zbI9+3Q/VvgEn4BCyowO1iS+6k59
 hoi68TOJV25dXJ73L0Os+xXL+7hQZDY2h5VBG0zeiFi1hNfB7oaUgC0GBMacCHqeveAb31UxRtI
 6gA8uKzLorgErgQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

It's bad practice to just directly pass void pointers to functions which
expect concrete types. Make it more clear what type ethqos_clks_config()
expects.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index aa4715bc0b3e7ebb8534f6456c29991d2ab3f917..0381026af0fd8baaefa767f7e0ef33efe41b0aa4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -742,7 +742,9 @@ static int ethqos_clks_config(void *priv, bool enabled)
 
 static void ethqos_clks_disable(void *data)
 {
-	ethqos_clks_config(data, false);
+	struct qcom_ethqos *ethqos = data;
+
+	ethqos_clks_config(ethqos, false);
 }
 
 static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)

-- 
2.48.1


