Return-Path: <netdev+bounces-49286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7F7F1814
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF241C21242
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17651DDD1;
	Mon, 20 Nov 2023 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="Ypo+4VkI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF8B10F
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:03:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40839807e82so12026105e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700496206; x=1701101006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XA6mQ0Heysdt/s0uOB81NZYsQSV3L653pd5bRqGdzZY=;
        b=Ypo+4VkIFvVxqRvPxw9kYOf1j6KbIYcVACwj1wTYYqemSmehHfLqJShYrstIdaNqmk
         dDDc6ozt8qL9YEtLqJCjUJOInP9UAooLv8ZUig9EmscsobsFzZ/oopZOI8HrjhKbC2kg
         ONJEK+P2VT6n56eAVfc1I+2Xiewvd0J90TeIeAuq/KoFtf2wQHtpT3L5HhyqW5X9QEwm
         zJLAZXkLRIqJvWlbLkHf+P4ym9sENFsiexhwT1vkTUJVoyXyzLAPb7KxqHd1xvriOzBs
         w74Bw7lZHp2JaubIIh60obw+1OOXH+nk0mRfmTZhiwTsXlwOyAP07S2jh2b2Wjye+k81
         7IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700496206; x=1701101006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XA6mQ0Heysdt/s0uOB81NZYsQSV3L653pd5bRqGdzZY=;
        b=U6IvDkViPEbKZGzUBIeaYDXzBvAP0rzu0iwgIh5pxfiup9BpYRlCeUAFTayn58nN7J
         DEGdegO/RAEtQL6tr9X6wK30urSKz3zZFK1uwu0SjHcW4lozDLOTkszeYPLoR5viYBWu
         wVVgsTKf2eHlbdHbqrUoCuS1quVBiWSeP++6e3oLDDNgI0c1dJI0ZVF3L+BtnQy+ch2L
         Ki1eReWJEgaoAlChuEwtFhUalRfUfLs5tmq14lSnhgyho2w6YjA7XANuBtjQB2MtVDaZ
         UwyULTpCTjWxt1/w1SInhpC1n6VYsjbfzx39rq+LBs0G4sOE2insadm/x8Ues5lsjitD
         BMyg==
X-Gm-Message-State: AOJu0YzApyhErosdSsBVUQOIiABQzdWMzcoT1F3Ol+JGbQHMqFplQUD/
	pzxW14YRBZaGrPvegYvZi++0Fg==
X-Google-Smtp-Source: AGHT+IFp6EIoX/+fBggjSUuEeNmuwT8XdZsBgwUHT9n/J9oSUS1P8tlqt937kSAYnNU4ybAc9QvgeQ==
X-Received: by 2002:a7b:cd86:0:b0:405:3ab3:e640 with SMTP id y6-20020a7bcd86000000b004053ab3e640mr11048501wmj.20.1700496206005;
        Mon, 20 Nov 2023 08:03:26 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id m21-20020a7bce15000000b004080f0376a0sm13564631wmc.42.2023.11.20.08.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:03:25 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next v2 0/5] net: ethernet: renesas: rcar_gen4_ptp: Add V4H support
Date: Mon, 20 Nov 2023 17:01:13 +0100
Message-ID: <20231120160118.3524309-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This small series prepares the rcar_gen4_ptp to be useable both on both
R-Car S4 and V4H. The only in-tree driver that make use of this is
rswtich on S4. A new Ethernet (R-Car Ethernet TSN) driver for V4H is on
it's way that also will make use of rcar_gen4_ptp functionality.

Patch 1-2 are small improvements to the existing driver. While patch 3-4
adds V4H support. Finally patch 5 turns rcar_gen4_ptp into a separate 
module to allow the gPTP functionality to be shared between the two 
users without having to duplicate the code in each.

See each patch for changelog.

Niklas Söderlund (5):
  net: ethernet: renesas: rcar_gen4_ptp: Remove incorrect comment
  net: ethernet: renesas: rcar_gen4_ptp: Fail on unknown register layout
  net: ethernet: renesas: rcar_gen4_ptp: Prepare for shared register
    layout
  net: ethernet: renesas: rcar_gen4_ptp: Get clock increment from clock
    rate
  net: ethernet: renesas: rcar_gen4_ptp: Break out to module

 drivers/net/ethernet/renesas/Kconfig         | 10 +++++
 drivers/net/ethernet/renesas/Makefile        |  5 ++-
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c | 40 ++++++++++++++++----
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h |  9 ++---
 drivers/net/ethernet/renesas/rswitch.c       |  4 +-
 5 files changed, 50 insertions(+), 18 deletions(-)

-- 
2.42.1


