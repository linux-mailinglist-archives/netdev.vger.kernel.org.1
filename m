Return-Path: <netdev+bounces-76346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EFF86D59D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 22:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50133B2125F
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7B14565C;
	Thu, 29 Feb 2024 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="floC//zT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDE13F444
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240162; cv=none; b=Vf2TxuNB9ghKgIuHjowag06AB95rvVnXiaMK6G/QQ2RMwkaGVTsoG8+QadF7FXKPvS/Esl6FXcms7QU0vhfIR/z3fZe6ioWgIaiGYxZ5Q6/R+QjSbJ6NQtxBlLjzozBO6gifvAGoj1YD0RAXIODVGVrGzEnwsq0N3A8LRQpPsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240162; c=relaxed/simple;
	bh=CkoPh+10iHxKZkJwRU1etR8ewLdQSrZpBt//3BLiDzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gAdGVlqcQj2VwXVscmVpK+i9laSggVi1re0khNe01LynzLl5vK+PSyof+ZGSpSuqoXekwjsylcnlzVgxih5wLBSH/fOKN4wJmJC9NHraQczX6klnSueSMO+akue0S0k9RUGi1lG1ECOjUrAeML1tJLZIQFYptCf+BjfUYqvsddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=floC//zT; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36524116e30so5755905ab.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 12:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709240160; x=1709844960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXClQocKFU332MGv51HiVp3gBqp0PjGOnlHuqmYRRz8=;
        b=floC//zTAZLTBCKflTu7/hlDyrLS+d7K9VP895M9QkjkQ4OS+7uBKi+sn9o2+Fgs2c
         03TMN6Z65gm7ctHosI9mChf6Mdlu7syY55eeNH6SQoQkcHeR85mng387f+ZqxSoKdt/G
         6YrOapPRwrEs15LacMGxO7Njh/DHekDvA5GTY2P3PJHhw4Fd0wZEKL3OBTMirY1+i4Y5
         FRC865nqEnZhwA1yVlnFAhfr6qOu+QA5kfEe9C3GCjKPpoH3qoOgbCsPMsNRkIjuTect
         C1z4cRpgPv1jokZyvmhYR63jvOtU/kDrMGSOBnOT88fT1utfvbooloySjwrdIVqNooni
         NapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240160; x=1709844960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXClQocKFU332MGv51HiVp3gBqp0PjGOnlHuqmYRRz8=;
        b=fJ/cj47zDiIaRHWaf5muG/v5Rg+YY4gl3Yi6Ku6EdKlvnSkRA68CoY5oR0AesK9eEL
         nB/yJMOZ+Hik3YR8157yECm/I71WBskAQTbV4Eakd2z4ya31fMuDVacV5UmMU/9CVGGG
         ROoJgk75KG9UfGZy9jSX3W84jK56nSqZKDDVPA+LWI4Gohlvzb9AF3MHQPDDG0qJt6Q4
         1KKJXKV8hBhPGX1yWzSAteeJ5E7UCA5wUFfchB8U3bdDanXifn2P70H8JueEQV/GJcPw
         RfNz20sN50CYkI00dO8/eqAM515cQEvdwDw8/FMjcy/CAmEzXmYNhDhqjhgdGEB6G1X7
         HEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/kPEwOG9SufPXvi1kzfOSkhwwmcc6v4UIR5p9Pzaos/DpHV5mbKymT0VzJA4pnb+Tpj55PmDNWTZ8Fo1nvOBgKPZuT+Rq
X-Gm-Message-State: AOJu0Yxgiqn07E0WyrKReNd5HJxp9a9h+WJNrCd7dzs/HJ5anUxMKeTm
	Zo+Ad352PPaF9JQdYIKh5y2kpgPoT4BU2eEWMR02GqysyPjw3YHacBSyQdXbkio=
X-Google-Smtp-Source: AGHT+IGr8j7A4eJzdeDg1YbAuq05IYAeaK4iw27H6JuOSJwWBdiiJusM0wiRHF/FGAh/MsrObspcww==
X-Received: by 2002:a05:6e02:b43:b0:365:23fe:12fb with SMTP id f3-20020a056e020b4300b0036523fe12fbmr258132ilu.11.1709240160006;
        Thu, 29 Feb 2024 12:56:00 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id h14-20020a056e020d4e00b003658fbcf55dsm521551ilj.72.2024.02.29.12.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:55:59 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ipa: simplify device pointer access
Date: Thu, 29 Feb 2024 14:55:47 -0600
Message-Id: <20240229205554.86762-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Outside of initialization, all uses of the platform device pointer
stored in the IPA structure determine the address of device
structure embedded within the platform device structure.

By changing some of the initialization functions to take a platform
device as argument we can simplify getting at the device structure
address by storing it (instead of the platform device pointer) in
the IPA structure.

The first two patches split the interrupt initialization code into
two parts--one done earlier than before.  The next four patches
update some initialization functions to take a platform device
pointer as argument.  And the last patch replaces the platform
device pointer with a device pointer, and converts all remaining
references to the &ipa->pdev->dev to use ipa->dev.

					-Alex

Alex Elder (7):
  net: ipa: change ipa_interrupt_config() prototype
  net: ipa: introduce ipa_interrupt_init()
  net: ipa: pass a platform device to ipa_reg_init()
  net: ipa: pass a platform device to ipa_mem_init()
  net: ipa: pass a platform device to ipa_smp2p_irq_init()
  net: ipa: pass a platform device to ipa_smp2p_init()
  net: ipa: don't save the platform device

 drivers/net/ipa/ipa.h           |  5 ++-
 drivers/net/ipa/ipa_cmd.c       |  6 ++--
 drivers/net/ipa/ipa_endpoint.c  | 29 ++++++++-------
 drivers/net/ipa/ipa_interrupt.c | 64 +++++++++++++++++++++------------
 drivers/net/ipa/ipa_interrupt.h | 22 +++++++++---
 drivers/net/ipa/ipa_main.c      | 60 +++++++++++++++++++------------
 drivers/net/ipa/ipa_mem.c       | 37 ++++++++++---------
 drivers/net/ipa/ipa_mem.h       |  5 ++-
 drivers/net/ipa/ipa_modem.c     | 14 ++++----
 drivers/net/ipa/ipa_power.c     |  4 +--
 drivers/net/ipa/ipa_qmi.c       | 10 +++---
 drivers/net/ipa/ipa_reg.c       |  8 ++---
 drivers/net/ipa/ipa_reg.h       |  4 ++-
 drivers/net/ipa/ipa_smp2p.c     | 33 ++++++++---------
 drivers/net/ipa/ipa_smp2p.h     |  7 ++--
 drivers/net/ipa/ipa_table.c     | 18 +++++-----
 drivers/net/ipa/ipa_uc.c        |  9 +++--
 17 files changed, 193 insertions(+), 142 deletions(-)

-- 
2.40.1


