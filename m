Return-Path: <netdev+bounces-106549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28382916CC4
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78C4288EB3
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B517FAB4;
	Tue, 25 Jun 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rH46EZSo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94817C23D
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328487; cv=none; b=YKCQ4Ol0Z/LbwkdM29AIGJ7TVpcW1ciZKWd6dMtMdt1MNJi8PsXo0PN/2oiycnw/OX2+uMVHUu6WBdKGo8Mo8cCwyA46HRdpBrSdLlJKu8rrE2tqo1fXan00LWIhkLatJbR+GUEQeRm3vAOrQMEjQr3nxNq1ldyASFEw8or3pgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328487; c=relaxed/simple;
	bh=fBGFNFGzOFp1BU1QtxpruUaeE9znadLX8hjGv2/aaOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulw2kEHHJUAqLI8qki+LaT6ZH3BY/kcm2lh9r7Aoz4v5/6DOpv8clH1SlTfakvXOPBMY+e3U7jEKXlYaOrXCBGpRi0zHKNtFVpNAjr9Gr98NPgDfPXG3xdfpVg4jk3PLsxVYrhudvmsr7UB0UMj49188ii7M3KKZ/I0NRZZ+ddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rH46EZSo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-361785bfa71so4343435f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719328483; x=1719933283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fefG5PtJ43ubkDYTtVgklUHFM0U3auLPTAsbXvD1ii8=;
        b=rH46EZSoLSo2qv6pctjtGFmvcNeSsrXDPUJB29sLLBMHvmezMK3TTk4E147A+zzHdw
         +DRqUUI4TyWQIp+FFJYN4+4FwhsbwCYLRP4zaZ/y4pHlPYsOFHi66mz2f6Hep+t2ionA
         Kvd/aUIw+7mgXXNzsv2t4MMhu+DXJuoK6fXY3ooO1wplLTO3Ge5ljp727HXfM0wA7N1g
         T4mTa0dHlIFaQJ2RejpG0eMACaPady5XWu6QEu0Lc3zgYcRKuYsRKBy0ST1aHTJK3o43
         2nR9z2WrGayxpbjiF0chMOtkxN2FAbT+oWP86ycIH62ixRPE+bbwp025Rb5ckHucJ+AH
         7SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719328483; x=1719933283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fefG5PtJ43ubkDYTtVgklUHFM0U3auLPTAsbXvD1ii8=;
        b=ivmTXqInKPbPLWQxiYIhm5tAC2jptdapyGykOVCr9B3joeVZXAc8Hawr3e74FL94BY
         nQvssjxIuLbNNtGw/4QE6dyssoU07jzudjz42DNbrNyTIYNh7QMLnnfLEIgoeBNpHkk0
         VibLuP3A61F8NyPjGDY2utP0WueEtLREmxJUw7peNy2xMFSvgJ1z8O7BcEitFAudtHXK
         VwUIBpeiMR49bhgWbFk3EQ1ypXMXnVzxq4YOdzVTRZYRmy5rG0Bxoygnire3x0XP6Hv1
         ECa7zl3wa90pzw7hjVodpBLR1NOmFSZZz8Pmlh40j7UgPJcWzyo5XlTtbMJOjPdmAZBX
         jMpw==
X-Forwarded-Encrypted: i=1; AJvYcCX9gIH3zS7ReLVAU5SdKQJEJhlEFA7CUFtVWOeinLvj/OE47xGUBzaeksMGyS+xNp6nwlNotxkSspFkvkM0SZ/ARmFnaMa8
X-Gm-Message-State: AOJu0Yz9EA8PDyzwGyBHtMIT7a/lzaIF6STcFQ4CoP9+xokNSwyKP6yz
	U21dci2Lk+S6ijn9Tp0Y4IBU1vh663m1BQiA8rLDfHHN5eGqTymhnO6iCUaAjLo=
X-Google-Smtp-Source: AGHT+IHwIK+TnP19YVLo3AYj0eY9nbhZy4hT45GMiX5FEUDK7tG44lSiQtP13Ar8obdwea+Vgn2fOQ==
X-Received: by 2002:a5d:59a3:0:b0:366:e7ad:3ec6 with SMTP id ffacd0b85a97d-366e7ad3ef3mr7187328f8f.15.1719328482913;
        Tue, 25 Jun 2024 08:14:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2b2c:4971:1887:588b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f694asm13215884f8f.77.2024.06.25.08.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:14:42 -0700 (PDT)
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
Subject: [PATCH v2 0/3] arm64: dts: qcom: sa8775p-ride: support both board variants
Date: Tue, 25 Jun 2024 17:14:27 +0200
Message-ID: <20240625151430.34024-1-brgl@bgdev.pl>
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


