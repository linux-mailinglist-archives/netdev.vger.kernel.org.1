Return-Path: <netdev+bounces-36792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3997B1C6D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 602462813A5
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D7126E0A;
	Thu, 28 Sep 2023 12:30:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE038DE1
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 12:30:39 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B6D199;
	Thu, 28 Sep 2023 05:30:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c189dabcc3so33321561fa.1;
        Thu, 28 Sep 2023 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695904236; x=1696509036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Gm1ISeW+idItfKS/eOu6/qm0WSJn6LCWGU5CplrSsM=;
        b=Mcn7UZf45YydsOftHEbbCaznMR0zaIZ+HyxLUuexvSTQrdrBFL0sg9i1rxdLVD/MfH
         FFqwnNw4McXKT8x9m+jnM+DpEhec3TT9JWA0ZZb711cfFk4eKpGqTq88dFKQ2bbWaQYl
         YGa4PvHzrycDh5B/BvVVo9sJj3PpXJ1BPvLXxdyg24N6+aRbEvqX5jlc++qS7renb0kX
         2EJxl92ezjKY1iokT7DzBNaOKd0OhY9b2qFreixfSjiX4J8N9s9qpQdwtiTpUJghu6eM
         Uz9aWgJNbPDXw/2nep1ic261Jhz365BnYy7FvbBbdWdnb7SxPDdDkm/7g3wzP0ROv6dk
         B9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904236; x=1696509036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Gm1ISeW+idItfKS/eOu6/qm0WSJn6LCWGU5CplrSsM=;
        b=YagYAsY2peD+Ouvas8ju6FLyJs+er2HN1qC4EgTdJP/PF20aX3i1gA8U8b27+k/pux
         1Apoz9wBy6RotOnmF1FW5aTQLCM6i0u3XNuAMD/HqDX8HeNuS/wcdvqBC7QrCbaQRmzY
         1ItFG+m64xx4HLUjC7GePeVL5esHQ74fhupd2Lb3LxKfRHRWeNbRXgRPG2VWsAqOgDKk
         yT0C8/XXI66Y/z/FoZZHDj/RwvVUF0V2S4oEqYygfMXo3queFguCz8Oq5UHZqQXjw801
         j5ABbaHjH65jXgV8iUHJAt8hnyC2YOQoeaaARUr0HZKxabFDoqfPslB5jRILU56R5QBe
         v1kA==
X-Gm-Message-State: AOJu0YzxW8JnojEh/r/thSPhMvVfnxI5K8aWZGOM5hRd59pH6ag6Msud
	jFvqcpxggskm8cprA96ZIG0=
X-Google-Smtp-Source: AGHT+IELWBzD5+DshFb82aU+91c6MxU621XWEWP2vB5rQd9UYeEMJrPISaje63D4gQs+E+MgoEPD8w==
X-Received: by 2002:a2e:2c16:0:b0:2bf:ff17:811e with SMTP id s22-20020a2e2c16000000b002bfff17811emr1044718ljs.14.1695904235857;
        Thu, 28 Sep 2023 05:30:35 -0700 (PDT)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id x6-20020a2e9c86000000b002ba045496d0sm3588724lji.125.2023.09.28.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:30:35 -0700 (PDT)
From: Konstantin Aladyshev <aladyshev22@gmail.com>
To: 
Cc: minyard@acm.org,
	joel@jms.id.au,
	andrew@aj.id.au,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	aladyshev22@gmail.com,
	jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/3] Add MCTP-over-KCS transport binding
Date: Thu, 28 Sep 2023 15:30:06 +0300
Message-Id: <20230928123009.2913-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This change adds a MCTP KCS transport binding, as defined by the DMTF
specificiation DSP0254 - "MCTP KCS Transport Binding".
A MCTP protocol network device is created for each KCS channel found in
the system.
The interrupt code for the KCS state machine is based on the current
IPMI KCS driver.
Since the KCS subsystem code is now used both in IPMI and MCTP drivers
the separate patchsets move KCS subsystem includes to a common folder.

Tested:
PLDM communication between the HOST and BMC was tested with both
components implemented via open-source software:
- The HOST (UEFI firmware) part was based one the edk2 [1] and
edk2-platforms [2] code,
- The BMC part was based on the openbmc [3] distribution.

The testing process and all the necessary utilities are described in
the [4] repository.

[1]: https://github.com/tianocore/edk2
[2]: https://github.com/tianocore/edk2-platforms
[3]: https://github.com/openbmc/openbmc
[4]: https://github.com/Kostr/PLDM

Konstantin Aladyshev (3):
  ipmi: Move KCS headers to common include folder
  ipmi: Create header with KCS interface defines
  mctp: Add MCTP-over-KCS transport binding

 drivers/char/ipmi/kcs_bmc.c                   |   8 +-
 drivers/char/ipmi/kcs_bmc_aspeed.c            |   3 +-
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c         |  73 +-
 drivers/char/ipmi/kcs_bmc_npcm7xx.c           |   2 +-
 drivers/char/ipmi/kcs_bmc_serio.c             |   2 +-
 drivers/net/mctp/Kconfig                      |   8 +
 drivers/net/mctp/Makefile                     |   1 +
 drivers/net/mctp/mctp-kcs.c                   | 624 ++++++++++++++++++
 include/linux/ipmi_kcs.h                      |  80 +++
 .../char/ipmi => include/linux}/kcs_bmc.h     |   0
 .../ipmi => include/linux}/kcs_bmc_client.h   |   3 +-
 .../ipmi => include/linux}/kcs_bmc_device.h   |   3 +-
 12 files changed, 723 insertions(+), 84 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-kcs.c
 create mode 100644 include/linux/ipmi_kcs.h
 rename {drivers/char/ipmi => include/linux}/kcs_bmc.h (100%)
 rename {drivers/char/ipmi => include/linux}/kcs_bmc_client.h (97%)
 rename {drivers/char/ipmi => include/linux}/kcs_bmc_device.h (96%)

-- 
2.25.1


