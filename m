Return-Path: <netdev+bounces-109803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBDA929F54
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D551C23295
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DD679949;
	Mon,  8 Jul 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dtz8Sp5I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75277103
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431587; cv=none; b=CGrhb/+I60OBs8VhFf7xChsX8n/Mfqpmi2sbiZZwdYsIOmMj5yWJKV6jucyd3v+0KQskBcaYNzGQhFBlti11Y0ep2Dw1pciQ5NtfLM2ditETF18GEOwo21hgjw75PqsXBWpIJGpQ5OoaDuyfyYnT3MxlcUUYc2dFFV4HyGVVeBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431587; c=relaxed/simple;
	bh=ZpEMlVZ4lz7kxOh8aB5yAX/5R2qrMqEaJCUro3Wh5Hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Id/exeGpp7nLUhN/JszIRgAvbHpmd3AkbYQUd1ucpqqqACKVfX14FzOdjPt17My0VwEI20b+gOHJP+YjXMB5dM47GuUYQXOManYExxzmCPKr+G1Ex3+G2z4HwjvhW8NNV5n8rux80nSDAdYNhC9Vw2niCvi/JWNXWg9LOaWxPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dtz8Sp5I; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36798779d75so3246832f8f.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720431584; x=1721036384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wMk/+AGyNt4bDxpLcLZIFlxLQBN4IY/9GGT45s9v7Q=;
        b=dtz8Sp5Iw0nqkHiWFrqt/9gcEvFcd2G55nyW/N5Bhjhixp1LU47ZPHeT2vSw2xS/xP
         XkGP0WQlS234aHIHiX41nVkAVoyJWDhcNvDhDPie+EJROCN+JdkcgGYYvarWTzfVDf/n
         YXKSKkvy5mNdWdhVEqAy8qoSW8nq2UiBOFzqed98PYKEEZoK+/k/i64MgOkPD+CkeBoO
         Idj9nXtQ4O7RN7rkeYn6dMf0Bc1sDhykCnQmy1dEPpLCWFUrvj12bKfZhkI6bJY3yreK
         oLI2UV3dIxoECwLdvFZP4163mIiJkdnSswVVMb2oi3bUK7Z8ezdayuMqNBwQMZXax/qb
         Povw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720431584; x=1721036384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wMk/+AGyNt4bDxpLcLZIFlxLQBN4IY/9GGT45s9v7Q=;
        b=GKaKYFHGGo3mtyz/3nWBPRxO3i1f9nNg5yrnxyMNplPoHm2p2sS9ArueIEsGmkercR
         GAfxdIOMpi1shxWSo5zTKJ+YdiJMErQONQPY+v6yRDksXQ6M0F8T4kNIS0JInF63UMRv
         Q/VmbUcQWL3/O+hjsLUBtY023M3UF/5XRZfg21yhzZdITP7mgHBS94ZKaVTT372ZacXe
         Y3JE55MGDM5ia102+qUgVOhe1OqGcLest6n1eL6o1LqVPpdT4JhEOaIMPetHVaLRSCt3
         yYEQFyYxY7n4aDckMwNEGuh93Isjz87miDSIAIm1fDYRPl7WVEoDz+4V/xmvbXIOjn2s
         PO5A==
X-Forwarded-Encrypted: i=1; AJvYcCXmfQc+v23PZUZJ8s8lVDY/9r42ry/j7D8qsLMsz7T+LpAYfcf85tjxTpR85aMWennTM/EWSyRvlnXvhzBiCglhc/Nx3edP
X-Gm-Message-State: AOJu0YwrpbnbaUDsc3c7jI9Iwhe/Mk2y/oEUpcGRY46a/2bLeURbcxlr
	6JIo06guDvoCYInWzZ+9cDnAh6kw2cF/q7+F9P4o62KsO6aAVBdhauN/w2e3rJ4=
X-Google-Smtp-Source: AGHT+IFcyUpprfbmsd5SYROkiNYBfnZ+6x0Sv34fVe2UaJqaxlr+YqcvmIOx8jSykFbG7IGRdR9Pbg==
X-Received: by 2002:a5d:4b0b:0:b0:367:8e68:4472 with SMTP id ffacd0b85a97d-3679dd3182bmr9827109f8f.34.1720431584099;
        Mon, 08 Jul 2024 02:39:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:a2a3:9ebc:2cb5:a86a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789fd7a0esm15457779f8f.104.2024.07.08.02.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:39:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 08 Jul 2024 11:39:26 +0200
Subject: [PATCH v2 3/6] Bluetooth: hci_qca: unduplicate calls to
 hci_uart_register_device()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-hci_qca_refactor-v2-3-b6e83b3d1ca5@linaro.org>
References: <20240708-hci_qca_refactor-v2-0-b6e83b3d1ca5@linaro.org>
In-Reply-To: <20240708-hci_qca_refactor-v2-0-b6e83b3d1ca5@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=52wmj4Bj2obnZ36+fvA6vsWMlR99Bm4H2IDTt7Bh4Aw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmi7PZzYUeTfB4CnDDPW26QWC+bYtdw//QtmPD7
 T2u7KLvnrOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZouz2QAKCRARpy6gFHHX
 ckWgD/4pDxMWHk08ljr00ikxuNLyLsxizZQccuDw+iM1mSLUIMKKDrrBFBxLdQg7ILxZt+p5oGp
 MLoNOwPremYIpMOh3BtarmOZrPiqNUcqSgymEUWxnXEP4B7Sl/BxGs56M/aPLH+ln76za8gm5F0
 sLSqHf3xTOG8ZEGYkG1of5Zv1CXWysfWJguzVbXjQ0k5jjLmq3iyTDdx0iPgvPXMfAHJylhis38
 wFo98KI6p6ik2vcXyTFHtyjh/HxjS6bivWISyVh6lCTHXDbUEzBSECUoyrjIw/82EsKQrOAPmu/
 kLKeHb4XCh5IaeWYwICAxNPp9JhaQUgHgX138mMwHBkmyRhfB61OL6RASplOjjmvf70eTe/1HaX
 YKXWC1UQPisiI9NpiGcJbJOQ0dVRgKojgoSxVZMZ9QNY1iWAKEwMD2iitQwi8Wq35idjKCG1wef
 fSrJWdO5es0HJmfDgIAULpPdVZKLT5fF97lLlZqG7zro0IU7PoE4WlDkOs2f0jbRsX+k2J7kNbY
 2RqH9Dqp69P36jiRv9PXxKCE4AewFYg7MWfEsO/tOoG+XGlxpoWn0woREU0ho5UKipwP/TiIuBi
 grRgh2Q/9viEQ68NKDbQaCGp3q562PyCGauMf8XynRGE+jPjQB8HWBsixhCKXIlJUMSpeMML721
 HaxSBHOUrqAjbuw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that all three branches of the switch end up doing the same thing,
we can move the call to hci_uart_register_device() past it and unify the
error message.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a34c663e337c..48e1b67577be 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2396,12 +2396,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			dev_err(&serdev->dev, "failed to acquire clk\n");
 			return PTR_ERR(qcadev->susclk);
 		}
-
-		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-		if (err) {
-			BT_ERR("wcn3990 serdev registration failed");
-			return err;
-		}
 		break;
 
 	case QCA_QCA6390:
@@ -2409,12 +2403,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 							   "bluetooth");
 		if (IS_ERR(qcadev->bt_power->pwrseq))
 			return PTR_ERR(qcadev->bt_power->pwrseq);
-
-		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-		if (err) {
-			BT_ERR("qca6390 serdev registration failed");
-			return err;
-		}
 		break;
 
 	default:
@@ -2447,11 +2435,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (err)
 			return err;
 
-		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-		if (err) {
-			BT_ERR("Rome serdev registration failed");
-			return err;
-		}
+	}
+	
+	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+	if (err) {
+		BT_ERR("serdev registration failed");
+		return err;
 	}
 
 	hdev = qcadev->serdev_hu.hdev;

-- 
2.43.0


