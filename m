Return-Path: <netdev+bounces-233237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB032C0F14A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A874613D3
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB7630F542;
	Mon, 27 Oct 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VAs1RItZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678730E856
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579911; cv=none; b=TS3UqTwCMohqZ5OFOsCnzlP8igysbKmLKfpoIugX/9Q38bdO4Xxir+vl6pwQ2kzmAcg1Jw4XnShe6WTo+ILwTGLBPxCRaUdSVBsDwlGYtRpAPoetRs7Tk5o2geUqol8DFxZfxckdMagLhAeN0nt0RO7d8qW65TBZougEeO7q3xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579911; c=relaxed/simple;
	bh=Rsilddn5Sk/PNb9loA2m4U6LcOVffhba4b6v0fmItZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4FasQ12qjdYcaAm1enXCSKWBu39xH04rCZzOcNXpeJwpVXtpRZ9yJwpXtRTVBEq86ChSQYdmeMLqLqzkqckEafD80zMjVcCw8LvvWh5QLHSnkMM9FsILqYMeMljeAGXEMcEA/qiYiLLk2vl6c1nluG3RvtK2QrP8NB4rVFdXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VAs1RItZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47112a73785so30945975e9.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761579907; x=1762184707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBmZV3Vyg2J9mVCwrX0FEpMqEZn3TiFxaC6u7B4A1Dw=;
        b=VAs1RItZlhAN5Yi7DLju0yhgGx5itR+LbLkOaURUrlz3JI/EsULTlmfAwxndh2lbye
         HFiBDCjaWzg8/tpRai3pKt7e7KntzaNcJsaQVc6F/SO0ozI/U8W03t7CARUHYX8NsRZB
         lHJfjeYk2mEcSKs0tPr5LGdrF4m7/qF9DfAPRJQKBkNOVZ3wF0lHD6TA8NVK3bjkm2ic
         /AwEVMn4/of2CCUR5MT7TG8/5HZFS3vywfUvXmNCNj81eOVqUHJ5nAducpyhgnJy5jiF
         VbNwRM8B2afoI1dAWPx/mIMxpsXAlZ29yJ2zdukgV+QpCuoA7SFgU22z/V/dSoiLHdld
         SCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579907; x=1762184707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBmZV3Vyg2J9mVCwrX0FEpMqEZn3TiFxaC6u7B4A1Dw=;
        b=AkUS3BlXl61/dqQsuLP9dPZmViRknvYUgxu1XyFtxA80v80Ha6xGDkFv66zjMjpKtW
         GafPnk/PARRjbbRn02Qszjb54hvT4f5ItNmU/ACv2NtY73sxTiHO/hYE1mFqhUYWAYh4
         cvusj7WZyfy8BrUh/ITq9yb4Bs5Lp49oAYy/riucUdzL345mDDmMHZ8P3UCaJw6IZr1D
         PKmX0TBe/J0OicM0wsBgpGbk0NxNUdpkAu33DU+Xp+5GqJfHgvBeAMNrBU5DS20hYpHw
         Gam5WZ2gNS3D8ThkCbEQe9B8WMXSgRXSqJK9doxmIUxEX84DV1ptf9Ud6BKmnRVXIarJ
         4llw==
X-Forwarded-Encrypted: i=1; AJvYcCXx6pqv925c/BSA6BSuDZdhAirQxi9crAje6ObjrqAN8k0+3klhRYpDPUHfZ7rx0DJ2Xhb5iE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYsuI8A7gIEChmNbIUVCNH3ux0kku5LSfSZlfGFSMtQjiR/L23
	numkiTMOQYyk0BEyxnduaEitbVdzFCYTUsj8mj/L09EgBMJ6f2CDVuXl5cmVzZsRy20=
X-Gm-Gg: ASbGncsCbxg8U9P5jJeUSPS9ef5NT0yxjIUAbEmp040J0GPxPeHjnHwwusWi1Bbe4Ea
	U7CV+Py5xZdXP+rJi5iS2qlg+gpTpv2eRhtsDhR/73NOkvpYHGWBKrbk8ohbWfS+A8gO7mF+kxF
	za8/Od8HqouVZh0cIp1iq9Dfc39DnRnEpsqlyeAfBW3zSiXs4XAT8D2tBC+s/TTLjKrSbIFWGdg
	MwiWF13moWpT4xQirYws1/MsQv284SkKS6PwKREXRtYnH4JUtyPT3LY+gDO9IzgSZ5fg1/CevU9
	pSTWaqvADVnmgjpOTXdxTAwae8eQNT8Kfq26u03l51lAF+RY/wF39MdnSCCvd5c+h5Ua172Qkoe
	+bJydPXYzWiA1NRo+AXNuPVgU4ecgsc1+zMvH4pfAlk5xN+m7abnvY+ZOxp/UgabjNcbpJ3ewne
	AlGdcMnA==
X-Google-Smtp-Source: AGHT+IECWyoE3V6eNyQ+Ni8Ig1arWy6NtdUV/t1u+09OLLf2glJJDnd/F8BXPUeWLSqyq4r2HXl0iw==
X-Received: by 2002:a05:600c:3b1c:b0:471:1b25:fa00 with SMTP id 5b1f17b1804b1-47717e633acmr828955e9.36.1761579907219;
        Mon, 27 Oct 2025 08:45:07 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c1c6:7dde:fe94:6881])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd477d0esm138708045e9.0.2025.10.27.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:45:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 Oct 2025 16:44:51 +0100
Subject: [PATCH v3 3/8] net: stmmac: qcom-ethqos: improve typing in devres
 callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-qcom-sa8255p-emac-v3-3-75767b9230ab@linaro.org>
References: <20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org>
In-Reply-To: <20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org>
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
 bh=mTsLMd9S404QxSew2dDaObEMEcD+rURz88/DzU+Cui8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo/5N7EtUYevy0KNURGjAbWD3ayjri7A65CXIjY
 quz63CLKUGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaP+TewAKCRARpy6gFHHX
 cpbXD/4rW59U3OyLKQKSjyyGQZLRkkV8UI/gn6+DtitezsllRAWiFL5xVrZxt57QxejnFAXi8D2
 ES0aolYvT57xfwVmbnieVs//EfL4Nq2ufUvnOJRYovEMS8cCxZ0FdtbrDV55ZFA2xHFcRUbpeGT
 +kcbYMDKWwu7pmV+biu9VEX6h1ZsuN6inepunZO6CYaGeUQOFyxJgf7ZY+nVWGvFsttL39Yai+d
 47t+qO1FSkpLxuakyURveQR1OsD0K1NInybeUmT5ApMUTKH2qNvpINsML4eTdL8yQN1zDL4mJjO
 zvN7lHjuKVJzogJnKQ078cHKC4hZ37wTHXuLwlHMG6URPvJbZj5MC8vvsU+tYoAnlNa5og0EUSZ
 R6gp5VYDQjzuERZnenBkmnx1WxQWAELVzPGpjwiUZ4J+UjIsk924po+ncs6LLXVCzuZx2uVzOEF
 y3FOVDZJSxf+vY7AR+vS8gkmZX/d1ZK8IqdnG5pOqB0wClGIfY1ZHo0Fqi+HqYfAvQocNAD6Bds
 m11j2pa6BtW2jcLPAxKE0gGZK397ZfEijSV/fIFP+LU609n2HiR5LiLaZc5BfPjYZgBAezW96l3
 0WyQf+SCZ6+fviTWrnZYwhzrLPFBH/4e4GWB1aWkoTnrXpLB9ivxHseQnnGvlI6MPkZ5n2/WLxJ
 /yj4Q1OMbOUwjFg==
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
index b24134923fdff0de8b608c140dfb8ffaccd19303..ed799da4e4079b4da4b555dd119cce8c6591aa39 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -740,7 +740,9 @@ static int ethqos_clks_config(void *priv, bool enabled)
 
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


