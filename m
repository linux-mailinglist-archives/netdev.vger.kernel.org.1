Return-Path: <netdev+bounces-22291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC19C766F34
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3BA2827A8
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283BA13AF6;
	Fri, 28 Jul 2023 14:19:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43911CA9
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 14:19:29 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D459BA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:19:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so585329f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690553966; x=1691158766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YTVSMob3FDMab46cbnVnDKMK/PRpFt0HuCnjHfQcaWw=;
        b=wHyrzQdVElXhoJr8uK8VO+n/FM9GPZem9GjOlpCoUfk9cTOb9c8+RYh2sKlIaDG87y
         OV8SWMA2DZEK5rL+tN0gAPwlzbOZLK1Uix4TJ+qsSKmWYAMvHuCiEjFUKp5puqywHMar
         gS1XURihEw2SzuhNtbMytTfFV1vt/wavkFfr3/ZyXqRJ9k1srY61rxfDWjaKgflZjjIW
         zDaff3IvPitWBeVexc934MT3cSXgdcMrcPaU9MxJNbb537frZTp6BKZIWeo62mZgTOJg
         HbOZMQp58adLRSdo8q5o8vMECgRI7miWEyO98k9ygBKe5BsZ9+Yvh/QzLTzXCbTn39kL
         9cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553966; x=1691158766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTVSMob3FDMab46cbnVnDKMK/PRpFt0HuCnjHfQcaWw=;
        b=fTAVz1LaorY2lupYoJK+r4zYZdtrtTwZeSt8T/IMM2UeTUIk6+NAnOraPXlKF5tk4x
         RyJOKP8N3Q+gtmP5udYdX545BnDrl5PA4qAB+1vsn1YGykhGyZ/autAlAsA/UqUDFv03
         qw9DP4Vw0yZnQYOeXyPX1iCvpswv0kYnvre4palDuT24f25j3KFkSMKFcOCelBrMLGu/
         V0MbTCIvfNzfoZZ0npa8NEOBfMRO5pMBMEsFPof6dZpZ2lHu0osekq3YA8LJkoZVdD8z
         jaljGFTgjChc5oVdGYI5skbAv5z9Azik2Ey05jIx+HJ0SwelJMEWZKqbPqX1dAddbPwS
         v+VQ==
X-Gm-Message-State: ABy/qLZaHKCLOhFetTl5IdwUEkD6+LFfqzW4uQlOvvgnNzrZ/l0loQVF
	mnTFk9rACZ3KadS1JKZTSE2kZg==
X-Google-Smtp-Source: APBJJlH/5n3hWZN/lVJj2jgP01WGyfGFROcd6jGc8UsMj71KI1QyDFFk7wlghkfGSoy/SPpzHP50CA==
X-Received: by 2002:adf:f009:0:b0:306:2e62:8d2e with SMTP id j9-20020adff009000000b003062e628d2emr2210194wro.1.1690553966048;
        Fri, 28 Jul 2023 07:19:26 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a246:80e3:766f:be78:d79a:8686])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031416362e23sm5013681wrm.3.2023.07.28.07.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:19:25 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vivek Yadav <vivek.2311@samsung.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 0/6] can: tcan4x5x: Introduce tcan4552/4553
Date: Fri, 28 Jul 2023 16:19:17 +0200
Message-Id: <20230728141923.162477-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi everyone,

This series introduces two new chips tcan-4552 and tcan-4553. The
generic driver works in general but needs a few small changes. These are
caused by the removal of wake and state pins.

v4 updates the printks to use '%pe'.

Based on v6.5-rc1.

Best,
Markus

Changes in v4:
- Use printk("... %pe\n", ERR_PTR(ret)) for new printks

Changes in v3:
- Rebased to v6.5-rc1
- Removed devicetree compatible check in tcan driver. The device version
  is now unconditionally detected using the ID2 register

Changes in v2:
- Update the binding documentation to specify tcan4552 and tcan4553 with
  the tcan4x5x as fallback
- Update the driver to use auto detection as well. If compatible differs
  from the ID2 register, use the ID2 register and print a warning.
- Small style changes

Previous versions:
v3 - https://lore.kernel.org/lkml/20230721135009.1120562-1-msp@baylibre.com
v2 - https://lore.kernel.org/lkml/20230621093103.3134655-1-msp@baylibre.com
v1 - https://lore.kernel.org/lkml/20230314151201.2317134-1-msp@baylibre.com

Markus Schneider-Pargmann (6):
  dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
  can: tcan4x5x: Remove reserved register 0x814 from writable table
  can: tcan4x5x: Check size of mram configuration
  can: tcan4x5x: Rename ID registers to match datasheet
  can: tcan4x5x: Add support for tcan4552/4553
  can: tcan4x5x: Add error messages in probe

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  11 +-
 drivers/net/can/m_can/m_can.c                 |  16 ++
 drivers/net/can/m_can/m_can.h                 |   1 +
 drivers/net/can/m_can/tcan4x5x-core.c         | 142 +++++++++++++++---
 drivers/net/can/m_can/tcan4x5x-regmap.c       |   1 -
 5 files changed, 145 insertions(+), 26 deletions(-)


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.40.1


