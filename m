Return-Path: <netdev+bounces-109570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD99928E39
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 22:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5581C23B4A
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 20:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAA617BB1A;
	Fri,  5 Jul 2024 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="U6LU0pze"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B81791EB
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211236; cv=none; b=YdMH0OhtH3m5sKYQUCP4apLx/BMu0BnM9cO8wK8jWxLImGcfvzjVK5wlij8yrEZz+MJJ19VrAurV7Lhk7Y+Zesq8gsLI6rQu13xdgZDAFVqv1R9w+ZYvpPhSemmLa25Uod6zMHnSZ68Vlg+OpT0x/sA/9ZFqTImNlV5IoPwfIpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211236; c=relaxed/simple;
	bh=MfyFPRwbvLBOBealo7DEoGG4CJC2dVdGpjWbW5vZ97I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmbZ9PueZw9EQnaVK2FeaObXfuygrrdq2FUHpgDRufFNATUJ0ZzE8JYmwVi3G1PEtefU9ol9IBMd4R7QAAiDtrvtkxRRMxWLpjMd60DZpJFaLyjG+6bno5QZO6OJiKt8ziRAoH2Bl4FGOrEDxX0WRA6L/gKSNI+yxAczauC6W9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=U6LU0pze; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-425814992aeso13443215e9.1
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720211233; x=1720816033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hK4ceHZT7jTrfqEpMWg4p0dQ8CFa9mi8p0ES3UVrDg=;
        b=U6LU0pzez/hDYUF8+1mhu2uua0m5Q4LMsbqn678jBczJzUYk4yIXyJA4QVNKH7wxOL
         XaM1ANN+IvZ033WCFzrgtCh5SVFl3Hn3qi738htaED4r9S+y0lcR+BgfdJ9NW1TFLibH
         tKdSCefouTHRh0kuy7eotCvIJXBdH9W0kOUNfcwtFNh+MX7DyiteErOABH3trdtX3TF7
         FqXff3obeQchsC35dHd/lGaUTgQXjLmXXalZqEXHLDrvYBf/7ty9KTk/3GJd/JQTGnv4
         PbC58XrL8vobgyiVZdJrTtgbW9DUdqRYxr7Yzima7Rv6KmYH4wLbpBXT2dLTyTZ91Nnm
         kf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720211233; x=1720816033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hK4ceHZT7jTrfqEpMWg4p0dQ8CFa9mi8p0ES3UVrDg=;
        b=dwB1VSediqbIRapgMjhNSISQtGaIxYazeXr1zAjXmtDOl0QqP93yngANIRDu5UyigK
         kESXWhitAf99UkWIBaDbuz6lPBU2EG2nRXxQhTNvud+lW2FGzhntY4+MZP4xx2NC2TYi
         fOddPFtKXWPIDAtWf+QlPb2f0CpX+FP8XXGn35jj20W9J82JXfe53NalmYEuJVxteTb/
         gLaA1GLtsxJ/T/NIXwIrRSiCir2/4clxuxXtn93mhu7Xd+PwNSc5HrKxzPV4A1N9EJMz
         7MT2HgwrlnPP4tWbVU0fk3+5sEpU+ADM+4yfe4unMoohCfPzgU/Mkyfuze46otBxpcc+
         R8gg==
X-Forwarded-Encrypted: i=1; AJvYcCWSyfwzQpkGkwdf6uno0D1oDLH2oTx39r98y7J7A8fSlyt8WLhi+TnOzr4s7y5O9k6iUXmmVz9C8bWHa+dEXtmdp+NIC6Ph
X-Gm-Message-State: AOJu0YxLykr1tb/lgfadZ9UVP0jP3hxhULmeUJPh0ZRq4IgH/ZMMGZ3G
	ueX4wzWJuOtrA5m4/McsyK0+Vga38otmWf1MYvg2JyuYeI9ZMGOrSWzffAAteO4=
X-Google-Smtp-Source: AGHT+IEmZUyDPxiUiyglOFkHsmmvEyicgf9qzylCXGKW0OhVjN1/4hSXrDznx2x2xtSDMNLEjUOlBA==
X-Received: by 2002:a05:600c:6d4f:b0:421:7aa1:435 with SMTP id 5b1f17b1804b1-4264a3f60c7mr41730995e9.25.1720211233283;
        Fri, 05 Jul 2024 13:27:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c688:2842:8675:211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm74397625e9.10.2024.07.05.13.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 13:27:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 05 Jul 2024 22:26:39 +0200
Subject: [PATCH 5/6] Bluetooth: hci_qca: use the power sequencer for
 wcn7850 and wcn6855
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-hci_qca_refactor-v1-5-e2442121c13e@linaro.org>
References: <20240705-hci_qca_refactor-v1-0-e2442121c13e@linaro.org>
In-Reply-To: <20240705-hci_qca_refactor-v1-0-e2442121c13e@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ErJpORb/JKYC9WuXTmP94HnvACooMp37CDxDnihdy5I=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmiFcZRByP3tZueEfeEIQigZZPW17xKzHC6FKJd
 5DTzFPUM+mJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZohXGQAKCRARpy6gFHHX
 cmhjD/sEv7MnVR/G8TCh6kRHAZaNwE1g4gv+ovb1GPRwxXoKFTXULXRUUS0kWqpTSUiheXHRrnZ
 SCaLOUtFlVBkR3AtbI/HhXbF8jaGmHIsORD+Q9X163BGPhzNUMlHtO+Fb1JS0JOeO7qy/kjEDZB
 nY1PvlqismbKQxAVA3Mbpsv3eGU4CCnyAOhT9UQMvtoa7YXd0YJwfCvROZjCUr24nbmnnFLipuO
 Dbf8NVM8G7BldDlbxemtnzRezfzaOpTPTeLtkCCp1nd9s3RtPmJgwCM4lWudhRJmGZpz+WdXhMF
 byBfu7CRmvncraEFiw/zj5yqPTzJkOvNnE91wEPKX+K8x8LK3401Vdnv7oMrMI2PQWlWQtc2Wl9
 8AAJEXaG8PlDy4HX8Wm3rftaE4qiyvzN0d6nH0u5VgdaSvDpl1KxabAwXojfJZEnKIni4aFoQlI
 Ig6J2FsvQ9e4aAFemXWQ1MuOlkP8d1SuglPmBDWK8FNME7wk05Lmh1M7pes6DZefPOPwlrEOrPg
 7hBiA1XwiEIu5NzFsD1A1vZxU05tMLsDTTQfQzF/0vfJqzX33dvFJccB+B5XyyBDeMujDXxzs+h
 BllFfUCx60j0MsY34Asx2x3tmaa/3Js6gjS761d2Z6V9YydW+zOzxalSIjNF9ZCrHZp02H+l5iN
 GuZLOuTRBcDFZQQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In preparation for using the power sequencing subsystem on sm8650 boards
and X13s laptop let's make pwrseq the default for wcn7850 and wcn6855.

Both these models require an enable GPIO so we can safely assume that if
the property is not there, then we should try to get the power
sequencer. Due to how the pwrseq lookup works - checking the provider at
run-time - we cannot really do it the other way around as we'd get stuck
forever on -EPROBE_DEFER.

If the relevant OF node does have the 'enable-gpios' property, we
fallback to the existing code for backward compatibility with older DTs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f2dd37d01189..bcc6483074ff 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2354,13 +2354,28 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	}
 
 	switch (qcadev->btsoc_type) {
+	case QCA_WCN6855:
+	case QCA_WCN7850:
+		if (!device_property_present(&serdev->dev, "enable-gpios")) {
+			/*
+			 * Backward compatibility with old DT sources. If the
+			 * node doesn't have the 'enable-gpios' property then
+			 * let's use the power sequencer. Otherwise, let's
+			 * drive everything outselves.
+			 */
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
+								   "bluetooth");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+
+			break;
+		}
+		fallthrough;
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
 	case QCA_WCN6750:
-	case QCA_WCN6855:
-	case QCA_WCN7850:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);

-- 
2.43.0


