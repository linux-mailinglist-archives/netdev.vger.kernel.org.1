Return-Path: <netdev+bounces-67286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6023842995
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E36728C2B6
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7A41292D5;
	Tue, 30 Jan 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hU0aPY7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488967A06
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632724; cv=none; b=NlNxx9830dQUqWZtk+KvDB4MtSYYowMjcVe6Oppk2Ys+1Oebv5xerTki6wImfFCY1rAShvhTU9BnMJ3LVraWiMYb7ZSC6Cquvnp/YqYyv+763ag6SiHhckc/ERDFa/Sv70hjSi1UAP9jZEfoIRPiPCSp4+RltEla/AL+Rq5Pexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632724; c=relaxed/simple;
	bh=TEQ8jOOdW9C4N7DptJHsfbYzZqm7WAXOuWhzqtkfQ4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rV6zJWDKJh9ULJJJ3Kdh5JChWW0sitFaMozL9uucuee3yOT52vdlFMEHmboFWNIqVdE8zhLGANh36d5cIZUbkNnhn+9Wiq4605it4Sq3KQkzCMTl0C2V7e0T1q9A1kt0n7BOekVWCuMaLh7k1A+q/ENYQf0J7ODe0fLpcjsW9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hU0aPY7j; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf45305403so41626701fa.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706632720; x=1707237520; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VpyDXlK61hD1QI31oUeDnUsni8/0Ke03qUlHK7bR94Q=;
        b=hU0aPY7j4lbj6mYyKUIQkgUJ7zXygJBVbVkLh1lcF1ZiI/4xO1Tb5Kb/u8JybSgWXx
         h/8itLbULyZF6j+5taSlWW9N/4FTYuUmgK1TVUVZlvQhqmqDdLv8rNStmSvOq57Hcm9R
         fYgNWb8locDxxzVtgmcV+aQM4JJAr6FOFWSFzB1vnQ3Z9H0ltqr40JL5qX37j74Dpu73
         TmoYfrIZX3+GPDX+8bogUWQYMI2c2R8O+BGxU9pKESxYPfDK66if5k/m5e0vMw0halzQ
         sBCz1IB7k5H2jEdUpsf53PfMFRSgkfhyBmlodBjtmLUN8jJRzEjYLC9BRj9CnC+jPc0/
         c7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632720; x=1707237520;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpyDXlK61hD1QI31oUeDnUsni8/0Ke03qUlHK7bR94Q=;
        b=ce3+6DL7ZfBk4ETKWWGxuGMmtWjRS8VcOH4ZiZ5LFVMishg6E4YuMKJsV0p3k5CzyZ
         cEr/s06GnU1Q8j/K6i1uYSqEB2TAnIRkPSMDvugbvQYYQDft4tLDZjOGtTAgHw9Thlws
         7LrJpn/b2p1IwIuxtnr3WtUwoo1doaIbt983roS5v/7zGinmFN27pmtACCI0FUxdYlt3
         lZ9Z9/EHRWGSL4aX8r2cQx4XS2mb+Q41IZ6t0z1abl2geD+6vaaFrPXAFe7p7ET3CQ6S
         D6k+WKlMLK9RkkqtTxQ3rVzsWfecA9s5aHa63qeh3uqvc2i1zktL+k3NSmFhzwj8VweK
         Lc7Q==
X-Gm-Message-State: AOJu0YyM3gpO0fAgweE+as2Yi6JM3WDPhAFbNkYlCYShplki7RTadPo9
	QpPZiQt5Y4KcrxQkyetnDF2H3nakGzHn2ld24gS6YZD0TABENF82Kcap30zAzEoCTe16O3ekG71
	U
X-Google-Smtp-Source: AGHT+IE8RruwgdA0nx7lUTOLRYZAuNoIzluFUmMwW0/obCVYUN0QV9PJr1qGD1P3WX3+odbtu5oM2w==
X-Received: by 2002:a2e:a586:0:b0:2cc:6cbf:5cf7 with SMTP id m6-20020a2ea586000000b002cc6cbf5cf7mr7327900ljp.4.1706632720049;
        Tue, 30 Jan 2024 08:38:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVu+mK6Ryz5/VqZRcvSMYr+tdTDVltngYhKuEjayx8IE0yJlp96CDWvIysIgWkInligAuEZZmJA80SEY1XpDgIlrKmUVeGJWh5OTuOcn8qWiP+04deYtw+dytTTVr1NFhhTR2l9St0Gn1wkjisj61/tVbSlHJPmlhdqE3OaiVI7Wbh2m8P1VAeeA44eEoThQ9oMTR6sBYpuKePbaDrB0+IYFrQMP879UPNtLtmAYb0pHTMfIzZNYA3mG11o+uJ42uxGXgu2lLLd3t9kjtf8/hOs9S7wuGhUlt2jjOHbXHWK7Mhe5XrFl+W72TRShtOeWrl9ThE5sgMVbZJZR9s+DMhDqKbvGrJusN1v9qAffBp0uVYzIzpwtO9nIzMlWFF3bUElZrbo7M80X7hzp8JZxMbTzGPUYZ3RHlN4qQZvAp049aEnTHns32caVDfqsSdGzbRjtPBgI2Gx07Mm5qHPeZEiPjhuPXZE+WP74kuSTfRP/PHxm/swq1JdXKnZi1ji+vyhr/SYGAg=
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id y8-20020a2e9788000000b002d05e8bd84fsm219639lji.31.2024.01.30.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:38:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH RFC 0/4] wifi: ath10k: support board-specific firmware
 overrides
Date: Tue, 30 Jan 2024 18:38:36 +0200
Message-Id: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAwmuWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ2MD3fLkPGNLSwPdtMyi3PLEolTdgsSSDF3zRAPTRIPkNAtDA3MloN6
 CotS0zAqwudFKQW7OSrG1tQAINVu9bAAAAA==
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=TEQ8jOOdW9C4N7DptJHsfbYzZqm7WAXOuWhzqtkfQ4g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBluSYO7h0IJF2XRBtVVaNpejrj5YPDtGDzKL1ng
 gAQs3MfnwCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZbkmDgAKCRCLPIo+Aiko
 1RpTCACUEZvuDID4NMQkqH7mn816sf4Yr1B4k8eDltq6lnf/fTK35CVPNEjyL2Kyb+k0jk2AlFP
 50e3rEmqQW6MZtNR4Rw7b99V58k+O0PrFa9dU4KgxPNT9v3/GXCFmkAY14ACjOP4HVdosMbu4hI
 +3+Hrk9wMHO9TXI2lcjKmbw7gNw6nerBRT3pKtadBOr9A9BIKaINBzhQXqv9tZOpbA8vNDOPQ9T
 xB2sOQ9JWGTURgOdRfGFI7AITGnqFjghSBPB4f285X69iqsmwgfYdiZs0Vbwy67uTxGYD4/xJfO
 z5oo1v21xX/SbpkPRtqSKUFdeTtJk/NVUmqQtB04V4lJlJcP
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On WCN3990 platforms actual firmware, wlanmdsp.mbn, is sideloaded to the
modem DSP via the TQFTPserv. These MBN files are signed by the device
vendor, can only be used with the particular SoC or device.

Unfortunately different firmware versions come with different features.
For example firmware for SDM845 doesn't use single-chan-info-per-channel
feature, while firmware for QRB2210 / QRB4210 requires that feature.

Allow board DT files to override the subdir of the fw dir used to lookup
the firmware-N.bin file decribing corresponding WiFi firmware.
For example, adding firmware-name = "qrb4210" property will make the
driver look for the firmware-N.bin first in ath10k/WCN3990/hw1.0/qrb4210
directory and then fallback to the default ath10k/WCN3990/hw1.0 dir.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (4):
      dt-bindings: net: wireless: ath10k: describe firmware-name property
      wifi: ath10k: support board-specific firmware overrides
      arm64: dts: qcom: qrb2210-rb1: add firmware-name qualifier to WiFi node
      arm64: dts: qcom: qrb4210-rb1: add firmware-name qualifier to WiFi node

 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml         |  6 ++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts                      |  1 +
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts                      |  1 +
 drivers/net/wireless/ath/ath10k/core.c                        | 11 ++++++++++-
 drivers/net/wireless/ath/ath10k/core.h                        |  2 ++
 drivers/net/wireless/ath/ath10k/snoc.c                        |  3 +++
 6 files changed, 23 insertions(+), 1 deletion(-)
---
base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
change-id: 20240130-wcn3990-firmware-path-7a05a0cf8107

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


