Return-Path: <netdev+bounces-107233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493091A581
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E032AB22009
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42D14B083;
	Thu, 27 Jun 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FicONVYf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EADB149009
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488545; cv=none; b=DZOQOO1QiKMDZSC8Qdx+Fnu3iPbePvGMsL4vbRNGJTMBCT9GhSCQB++B9pQUy7PEURI0uOdhjzrmkedQzoHbQaCv1q8cwgrd1gx5iWAMH/XRl7MNtd6WrnOel5uL//KJZdgv9FEKrSq/A3Op3DrYCnCMW5ovz3hLPPHFigoW0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488545; c=relaxed/simple;
	bh=NHca19c/l4kAA3IjwkGK6+rAojDFVkD/A5ds19ZX/fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHd0zSHndepJNOLMTOwRNtKYxbXfBF8guxZwcyl/KwfqccqUxYnxO5/60PWReG7eFpPjKBqB96GJxOlgkorL8qxSpVZJ3GAsnlOTUltgVyYDZXs63AUIAOmHP3hhRkAawD99swAUH+cE0PlwrMHCWHW1bFpY2cbKA40p5yUkobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FicONVYf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-364a39824baso5406060f8f.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 04:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719488543; x=1720093343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kXXfXEFDzUC64T17Ry+QFiathD8Dc3ObuiaeMGthVI=;
        b=FicONVYfaWxls0Y4kVHl9m6c0e0TV558K8xRKvx97HqDc4zgw326iXjMvPY7R1x368
         4rsuphylhbwO8uiFty2SM0ps68tD5wRcxDdiHH8GXFFFZp+62XyLlju5FoGzG1n2v+Wy
         kNe509sPZXpnIkowWTPxxRX0tgOy+cewpPZIy6Tz0c9HQRVLt9/0vBIkmLvEAwaFxg8r
         cKVkuqbJvlr3hIa214tc5Mt7JBshRGvpe2rL7ykemiV4S8Vc4eJZk4EqLWzHgtjViMrF
         XUpoDbRNS0jIoy8gkFLu+wKt74/AXK4POteyy+UVhFX1WsIU5j6tnHke8Yy79n9wfq/o
         HkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719488543; x=1720093343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kXXfXEFDzUC64T17Ry+QFiathD8Dc3ObuiaeMGthVI=;
        b=i35aL1nGUvq3z2mIiyjGjQ/cujd6cmQUuRHkLov+HvDi+p0I8svKTa7+VjNN/rS2Qb
         Qvza4F3RQBAMjALVXHRGWfEEAmOiDO2VQewImsaFBP3fOHjLE8XWNPufNTYC59Jy+0Iw
         NmtT74eTBFluvDaMYFMpX2XJcOyXY4XfE3TUvKIGXmGkBPz9VoiurjbEZ4f/O3O418BL
         Y4IPZjlPcKhEcIeeqFOY43FRxQZB8+m1AoQOA2y8haCgJsCtBohl4Mtb00m01dzom/4F
         95gtYI1VL2DpmXXgJ8G31quhWjB/0y2DMqEp/+q+m4hzsHoJsRkLIdLNQMBBxDB4ccYF
         jNqg==
X-Forwarded-Encrypted: i=1; AJvYcCWrEGIAlyd93X9cC83pkhUAHvOTjO8ab3BYPfOyV4gjfJUxTrmFQ5j9iObJjCK2sSJWfiUztqPrPEh3V4kA3YAwHKT+p5p1
X-Gm-Message-State: AOJu0YzgTxn9EftmtLCIcNl1CQnyNJ9o6RI9ZyqaZhXbdOH38w0S/WR1
	qUQH//9u0dD72j/VSUJa0Mxb3oQLyDBMh8GehN9lPLfP6/Y8TBTBYjhWVZwRl60=
X-Google-Smtp-Source: AGHT+IHoxJdWlrADArRdG8DgzgAL9SZ6fx2OLKkXTk/rwvrre1ojW9RJIRkT5DyqzJfpREwn7bCXqg==
X-Received: by 2002:a5d:694c:0:b0:366:f323:f59b with SMTP id ffacd0b85a97d-366f323f70fmr6752481f8f.1.1719488542663;
        Thu, 27 Jun 2024 04:42:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743585276sm1554749f8f.62.2024.06.27.04.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:42:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 0/3] arm64: dts: qcom: sa8775p-ride: support both board variants
Date: Thu, 27 Jun 2024 13:42:09 +0200
Message-ID: <20240627114212.25400-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Split the current .dts into two: the existing one keeps the name and
supports revision 2 of the board while patch 2 adds a .dts for revision 3.

Changes since v2:
- use correct phy-mode for Rev3

Changes since v1:
- add a new compatible for Rev3

Bartosz Golaszewski (3):
  dt-bindings: arm: qcom: add sa8775p-ride Rev 3
  arm64: dts: qcom: move common parts for sa8775p-ride variants into a
    .dtsi
  arm64: dts: qcom: sa8775p-ride-r3: add new board file

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts  |  47 +
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     | 836 +-----------------
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi    | 814 +++++++++++++++++
 5 files changed, 885 insertions(+), 814 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi

-- 
2.43.0


