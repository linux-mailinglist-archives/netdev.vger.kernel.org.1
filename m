Return-Path: <netdev+bounces-102805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC3904D6D
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 10:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16BA1C244E7
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 08:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D85816D313;
	Wed, 12 Jun 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MoeWCxca"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFD38382
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179340; cv=none; b=Dp+e1WXA1al8kmSEk5tuoURiHFdfO1+S4AF1cBa/T2QHtAmsZCX+WalsCYV/lhF91jhaQ+vPZO+VfyNKfdDMYz2DFaWDwxXk97XLjehjY3DqQTfU74vSVjo71yOwA9I5pJYVoYHGO/2O3nfV8lUJYmo6qywoT09T7WSL3078vsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179340; c=relaxed/simple;
	bh=s3mfIsukRZmgouUhCyn9Wd/i7okI8+3DBaijsAj2WU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onzVQXXQlji633bbp9qtqvmJ/wNFpx0mce6Ea5YV73ir1IdtVD6uJc0t4CMJi2IfBzX/1+AHmzkBwU82NHp5Ol10TmA7eQ0XEcfW0vhjRO0TGYKX9ks2iUCjBw75LKH+t9qnzPuWRptNE8jvAgHhgve4sy9mfSNRwpSOqTvLURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MoeWCxca; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f1a7386d5so3158185f8f.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718179337; x=1718784137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ksBSyA+j9QPSkEsVDee/zoG9hDnAPGUv/QuDtN8Vy0=;
        b=MoeWCxcaJfh4knync7Fc5ivflDbf+9FUEE4rB9Ur7qKbL8a94cOa+R9bXm5ThhCHJO
         gCCH9S+Z9MK+HaXEqOQ5yHiwlN1P6itZ/HCXwFWuZISe9hz8k2MYUE9NZbvOlxBvpFgk
         4hTdEom3Tts/IGl/qct4vm7zZyaeC2khtddA4LoOdDjRr2rIvkjd0rwHGALNTkO60e8D
         S7301X071GmGv2MQGLP8xMty8r4p/PadhvwT+J103O0s6gSHECateWf07JHyJqB4RZ0q
         wYhIk7ZL3cMCjYvZ/X/C58tEJA3Ndaa6/kFXlksEzBjgrxoEnfz3vmRyzYnySSHSf796
         1QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179337; x=1718784137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ksBSyA+j9QPSkEsVDee/zoG9hDnAPGUv/QuDtN8Vy0=;
        b=hyPIXVgBiucdDuq4f0lxo8t5szIcdzbm8loX9OFAMRMTxO3fniYxfMb3pbNqezud3r
         KhilRjfo5i+F4naFWumeAcGEzr+pPjzIynjzxKDD/7Lz5KM70oB1ZJ6yCqaHmb+UcRuK
         xH7XwejJQ3Sjcvrj9VtVRUayxGTZPYwFKm+HHsmGnBwYbYtqk0roeUiuAWz1mCf0QnIC
         CfqPyMq0vYmDlW9SkZmWndYY0y/Y0UNO0ST8l0h3p8GsW48Ere+47z9LQoET5kJrAxgl
         1KXIZMf7U9Tlt0KSxQ7Na4ux+Yyvf1KFQUr4/1/EE3WYPlyfjiGHKHgg0qxIbeO7KFcW
         CfRA==
X-Forwarded-Encrypted: i=1; AJvYcCXyJ1AlKguO/3SMU5ttp8NmyqbiTgHUlH6lHPXbhztokrEVXpfCQl0uKb4gBLkLGb2kMGipNQLTARg15u1qTP37QvUcNxje
X-Gm-Message-State: AOJu0Yxv6IA5uC3j6xTjc/z139nvQR92o1xAahxSYU7b71LxoSdfj6Vv
	A3Z/dExGk9ghKQAxYUbVMOgQ/t5Wm75Fus9LHHIMftY4rWpcbNyMe7HcXEc16Ww=
X-Google-Smtp-Source: AGHT+IFXYFUX0JPIwmj9Dya04E+MPasUBHNXYfyKZZbDpuWUHf5YESL4MGY5Xiz2kjIyRyPElOx9vw==
X-Received: by 2002:a5d:6a8c:0:b0:35f:1cbe:2e2f with SMTP id ffacd0b85a97d-35fe8917f56mr730173f8f.47.1718179336991;
        Wed, 12 Jun 2024 01:02:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f24c7a9c8sm7452585f8f.78.2024.06.12.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:02:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 0/2] Bluetooth: qca: use the power sequencing subsystem in hci_qca
Date: Wed, 12 Jun 2024 10:01:48 +0200
Message-ID: <20240612080150.18375-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are the dt-bindings and the hci_qca patches split out of the larger
power sequencing series. They target the Bluetooth subsystem but depend
on the following immutable tag:

    https://lore.kernel.org/lkml/20240612075829.18241-1-brgl@bgdev.pl/

Please consider picking them up into your tree, they were reviewed and
thoroughly tested.

Changelog:

Since v8:
- split out the Bluetooth patches into their own series
- Link to v8: https://lore.kernel.org/r/20240528-pwrseq-v8-0-d354d52b763c@linaro.org

Since v7:
- added DTS changes for sm8650-hdk
- added circular dependency detection for pwrseq units
- fixed a KASAN reported use-after-free error in remove path
- improve Kconfig descriptions
- fix typos in bindings and Kconfig
- fixed issues reported by smatch
- fix the unbind path in PCI pwrctl
- lots of minor improvements to the pwrseq core

Since v6:
- kernel doc fixes
- drop myself from the DT bindings maintainers list for ath12k
- wait until the PCI bridge device is fully added before creating the
  PCI pwrctl platform devices for its sub-nodes, otherwise we may see
  sysfs and procfs attribute failures (due to duplication, we're
  basically trying to probe the same device twice at the same time)
- I kept the regulators for QCA6390's ath11k as required as they only
  apply to this specific Qualcomm package

Since v5:
- unify the approach to modelling the WCN WLAN/BT chips by always exposing
  the PMU node on the device tree and making the WLAN and BT nodes become
  consumers of its power outputs; this includes a major rework of the DT
  sources, bindings and driver code; there's no more a separate PCI
  pwrctl driver for WCN7850, instead its power-up sequence was moved
  into the pwrseq driver common for all WCN chips
- don't set load_uA from new regulator consumers
- fix reported kerneldoc issues
- drop voltage ranges for PMU outputs from DT
- many minor tweaks and reworks

v1: Original RFC:

https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/

v2: First real patch series (should have been PATCH v2) adding what I
    referred to back then as PCI power sequencing:

https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/

v3: RFC for the DT representation of the PMU supplying the WLAN and BT
    modules inside the QCA6391 package (was largely separate from the
    series but probably should have been called PATCH or RFC v3):

https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/

v4: Second attempt at the full series with changed scope (introduction of
    the pwrseq subsystem, should have been RFC v4)

https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/

v5: Two different ways of handling QCA6390 and WCN7850:

https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/

Bartosz Golaszewski (2):
  dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
  Bluetooth: qca: use the power sequencer for QCA6390

 .../net/bluetooth/qualcomm-bluetooth.yaml     | 17 +++++
 drivers/bluetooth/hci_qca.c                   | 74 +++++++++++++++----
 2 files changed, 76 insertions(+), 15 deletions(-)

-- 
2.40.1


