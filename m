Return-Path: <netdev+bounces-102803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29209904D4B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD05D284EE3
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 07:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F10616C868;
	Wed, 12 Jun 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zWvqyePI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030E16C85B
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179152; cv=none; b=JPI7UqtOdkJCYieQU5AVncLny7G0LMpbQlwpAVbZNav+dejyOJmqRmdo8UBFchZyX11fP6/FiAh3WwCI7tfeOEzy/SLfJhV6qODpHTTtO83tLJyaiGmLvqleaDp1nRVi/cnE+saDbPZR3OddMnup5MxOiZvV4toQhZnEtQXQsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179152; c=relaxed/simple;
	bh=vwNJ897gwBvDgypF3Aq9mgPnj8YQo/CTPzx+egzni4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+2GH+O0XUKs0Bp6Z+QSInu0pu2GQjKJFuLL7GfboaNtoDOjcKFoSwzSKq9ERcd+WE96yxh9aflJQiy771KlkdP8txeu62uUavlqzB9kJtr7VRSpd/R22qIcHf54wq6GCsDI1iCgwXqukZ4ALJ49zgjDUulzgsZ7AB2sXrJ7gYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zWvqyePI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso5407573e87.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718179150; x=1718783950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9bGYOos+5ZAvSBq70WnnGsqeYl9M4GtIdifUxXDp6M=;
        b=zWvqyePIFpXkfXxDhnYeGltGSiPqWz4I0ZG6/nztCMDdYBSnx18fg0mTlQMUj8Hz3V
         90IgUsz1qtr/L41nWvRgmDIWbt4aZAwNEfhGZiiiZT7GBny7zjq764evOPLpFN/QMWbL
         RHcy5JwngJcwt8PdZmFBlGKvWs62ukDWcS39vM57F49mEjLW4NbHZMX4YiM9HgQemVKt
         tDNApbw4Mv6BUrUHzRGJv3g3BZ8ntqcDW35LcCCpRfxJHkrSn7W8CCqL8yr9q9Z5WA0d
         rekcySITRF32nUuFZjaAR2e5wq5u+Yn6UfKTTd1YTFYOTbTdlCPWOnjsU2mA8+jMdz26
         d/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179150; x=1718783950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9bGYOos+5ZAvSBq70WnnGsqeYl9M4GtIdifUxXDp6M=;
        b=H4YB4UvLQU9EuBC+Q17D2zPbdbGbPkhUmeMSGRbU1Rg+SWRUt3YvrC2pJtbj/Z09nY
         M2IOpgsv3AG89IHyLNc34vR8LGRx5j+ZwtvOVbOkBmNtupUaIf2NVoRYz390cAMu6luJ
         erL75VwySHb31ZEpCieZH2c5839jwVGoFnRreNR8EqQxONxohNol+pZQx/lJMoYzQ2rH
         CF9EEeSM5BKMKHGbWNg4YJ0Bc4Sl4hlLvxkdtFH1ps9f9T4wbu26mnl1xwmrj86No7XH
         4ZWokOEzjcEQFf9PND8r+CMnNHKCau6Z2ySo2aonXWKxaBFLqL84dqr/WTC/6SfNFu0R
         Yl1A==
X-Forwarded-Encrypted: i=1; AJvYcCUk/14OVNuzjByFKqi+ZeHIzWqIju+iBaM6R4ZTo4sYHeqt2h8HbxGEDfN1xf9jLqhMeGMwWm6xVPIuEJuXPK8dI6ky1Yif
X-Gm-Message-State: AOJu0YzXt+jihTfLafsBf6vcvjtXqF0sRRHZkJpjMGzw3fiqowTBtagr
	CvfLL71E91pD3/DKq1m/JACMnwjJSlFPq6czeU45Ygu4+6+ypzLbsRjggxsTzF3U5acb2eV4PFu
	U
X-Google-Smtp-Source: AGHT+IHW4NIxUvz4W89OLc8Yhve4W25GsEQm/AZgXDZVaD85P+vCuq8RK+JIPGo75+rm9H3KVgiVuA==
X-Received: by 2002:a05:6512:1243:b0:52b:bf8f:5690 with SMTP id 2adb3069b0e04-52c9a3fd437mr800598e87.52.1718179149308;
        Wed, 12 Jun 2024 00:59:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de607sm15312315e9.34.2024.06.12.00.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:59:09 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] Immutable tag between the Bluetooth and pwrseq branches for v6.11-rc1
Date: Wed, 12 Jun 2024 09:58:29 +0200
Message-ID: <20240612075829.18241-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hi Marcel, Luiz,

Please pull the following power sequencing changes into the Bluetooth tree
before applying the hci_qca patches I sent separately.

Link: https://lore.kernel.org/linux-kernel/20240605174713.GA767261@bhelgaas/T/

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-initial-for-v6.11

for you to fetch changes up to 2f1630f437dff20d02e4b3f07e836f42869128dd:

  power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets (2024-06-12 09:20:13 +0200)

----------------------------------------------------------------
Initial implementation of the power sequencing subsystem for linux v6.11

----------------------------------------------------------------
Bartosz Golaszewski (2):
      power: sequencing: implement the pwrseq core
      power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets

 MAINTAINERS                                |    8 +
 drivers/power/Kconfig                      |    1 +
 drivers/power/Makefile                     |    1 +
 drivers/power/sequencing/Kconfig           |   29 +
 drivers/power/sequencing/Makefile          |    6 +
 drivers/power/sequencing/core.c            | 1105 ++++++++++++++++++++++++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c |  336 +++++++++
 include/linux/pwrseq/consumer.h            |   56 ++
 include/linux/pwrseq/provider.h            |   75 ++
 9 files changed, 1617 insertions(+)
 create mode 100644 drivers/power/sequencing/Kconfig
 create mode 100644 drivers/power/sequencing/Makefile
 create mode 100644 drivers/power/sequencing/core.c
 create mode 100644 drivers/power/sequencing/pwrseq-qcom-wcn.c
 create mode 100644 include/linux/pwrseq/consumer.h
 create mode 100644 include/linux/pwrseq/provider.h

