Return-Path: <netdev+bounces-77797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF0873077
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5591F22E95
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9884A5DF13;
	Wed,  6 Mar 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8Xw7+SB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45895D8FE
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713016; cv=none; b=rEirKt3Vv8NVdRb1TGkElIzS80TRd6LssNfJQs3YUHKO+bFgX3f9LupJZVp89oE8Rh1ZHGpVDuZGnmvAH5jRFvZLIfQ2zdw5+5g8GeuayNDJXm28JpqTK/nUEA4KnPHj96hoQRW/ApQgWuQu5USZ1iC/sndDn/s58ot0lrIFopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713016; c=relaxed/simple;
	bh=IO0G01fjeFoKQavHxljn+OxdA/fMRHWzmgJlyEYmCss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPFqhBXpxrDTg1vahPTuKVQe3XXlsKalsSjF0U7CGK5gKiu3Ha5o1t7YMmLYMjaoejCMwE0xWJMfbskJgJ5pvQLkjUsS/0UD3zxS0IQK8Lv0YzBQociggvszN5hI+xq1c+bQjeUiNMYCl8oBxppgCiWZfC+224mMK0uh34kPzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V8Xw7+SB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51321e71673so621176e87.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 00:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709713013; x=1710317813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUMpyp+aBvT4jutLW9xk5zk3hii55n3wtwwHJLBpTrY=;
        b=V8Xw7+SB23pJyKpCdTZAeRVql212f62nSwBHuLQh3ydXJY7VxfHp2CLmcIBfSjJbrG
         bzSKA6PouLSg9mYQ1ccNbWABwOlYnvjLeVB2QkStlICts6r61j/ClorgUS764TrFVsN+
         dgpibjqM47ORFx7AU7auk575kgaWyw79KKoqxoY6+1jB1RmTpgk306ko8ewiQCAnvmO+
         bt0SMkEhwUbX6zZl2StvyJg+WnOfqGyc5quxq9nV4STDIRmWGy+JCf5kw2sODaOod0nf
         My9Lf3/4Mh3Rl2nxY3W7WOmqKz5nyp6bbnY8liuNKJ6QjIsJVreaigiT2qyq+IWi8Ey1
         6trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713013; x=1710317813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUMpyp+aBvT4jutLW9xk5zk3hii55n3wtwwHJLBpTrY=;
        b=nXqa8HHEc/twws8+8Cdmr77BfSti/LGnBHZlS9fxU2qzaEEqAeVr3aJrpTJSp4A6pD
         m8YYtPtcfa0HIgED1QgWKgiZjvXw7ALfvh2hNZ3cZHfBkWqOLo0dCmXZc/DJIdX93iJM
         Kxg9i+eehCwwI3DY5ClfxWeHNhQeYaywjom/5bcSoJThJHOyc3oj0FUYvYfkmdmguLS8
         gU5Bh2be14mir8BEZhWX4nD84YfGis46dRaM0iGT+Gew+asQpMAAop1UHxBeWHJwkiHD
         xU7ucsT+jSrodNtSzux4qC3rMtDDl/tSgWnXnKF9oeMUWEATpi9oMyTdEC2RnCSLFQfJ
         Ax3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWW1vfgbOck7c9KQHIskGdM0oxXmRyDq8wRoAoM5MDcorYS2ksHONflWJLGy+ELHxb6VaLDahPXSgImzQxtljWn/7veIb8c
X-Gm-Message-State: AOJu0YzU0La+joRwf2CVbTU4Lxfg2vERKeushpz7QL40l3a50ets4U73
	liTaMtYlg6kyZPqtjMkWpY8OVhk9dAb2bO5B06GBnmaoDqRkc/+Ax7CL2JfLOIw=
X-Google-Smtp-Source: AGHT+IHbn0SM7E/lVjSCZHRZwzRi0PDead5ffXoCFKJOGbm2VuIzaa+JgNKuc9Hp6zth2I1J6rcUHg==
X-Received: by 2002:ac2:5e64:0:b0:513:4b90:aeaa with SMTP id a4-20020ac25e64000000b005134b90aeaamr2501286lfr.51.1709713013133;
        Wed, 06 Mar 2024 00:16:53 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id s9-20020ac24649000000b00512dc23bedcsm2162366lfo.99.2024.03.06.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 00:16:52 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 06 Mar 2024 10:16:48 +0200
Subject: [PATCH RFC v2 4/4] arm64: dts: qcom: qrb4210-rb1: add
 firmware-name qualifier to WiFi node
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-wcn3990-firmware-path-v2-4-f89e98e71a57@linaro.org>
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
In-Reply-To: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=788;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=IO0G01fjeFoKQavHxljn+OxdA/fMRHWzmgJlyEYmCss=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBl6CZvOTjBZtoSgh4NQNDNl/WX7IZ1W1x6/faq7
 hbuBSPc+SqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZegmbwAKCRCLPIo+Aiko
 1Ym/B/9ldUzS41jpPNUz625gZyscZqqwqmBt0uegSJU0zgfAndVYwH6MtJnzQoIibGDzAZm2fIH
 tpv7wOX+cp/LpxjYrpgSGgzENGZGSpZCqt3mBNpyOP/ViRa6Sr/LtaiyFIw+0HuXRsTSr8BdtPE
 ZpM613MAZjUpi23Cy+nVIEzjIo7A5i9euFCcr2mYOte34axrup9IpqSR/3L4RRRNhbedY+jQIKA
 KSjMbF1IWUXXEvrxHCp513J/jI6oUqS+UrPM03AsvSCS0NrteHdt/RslRVRHZtscgW6sbrpWo4n
 W+ETw/zQGAvUBdCg3FrWC/RSBr+3wHuXUCJRrf7mQMsYG3GT
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add firmware-name property to the WiFi device tree node to specify
board-specific lookup directory.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 7c19f874fa71..cf1d8d6f1546 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -632,6 +632,7 @@ &wifi {
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l23a_3p3>;
 	qcom,ath10k-calibration-variant = "Thundercomm_RB2";
+	firmware-name = "qrb4210";
 
 	status = "okay";
 };

-- 
2.39.2


