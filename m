Return-Path: <netdev+bounces-177620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A6AA70C08
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259627A6A7E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7471266B41;
	Tue, 25 Mar 2025 21:31:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B12165F16
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938260; cv=none; b=kBKOCSOCHjb7udKKuroeSEl/VbTOOub06zpdU2JOnFppQ2HzTxZOa2B3GsA9weqwGONzRRs5wOokzvvyJwTYEVD8vqPfVWoS0KPp62E9hMuLhTcUst6U6zMscXlZvaudhQPu1+nzOLZiUh0ED8PN84qZNQpw8jQPau4o+tKIktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938260; c=relaxed/simple;
	bh=/LyDKT+UOWTBvftyhOtuuJJ6z5DeMMKefPYUHBNqpDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFzk2KEBNDIcrKKLFnGIRp8YzlGVgzPp4EGuFFKjFPQTAQWAyvWGQIIQw9h99A1FHsGCv9y6PUSy0u8oGFz3kWrckNxJpjeoGKuqqkksfA9EdN+QaAZYbxjAvtuRchsh9YPAznYDnm8FJbcI0dCAqKyZdoW0+aSI5FzjBFQrkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2254e0b4b79so117248765ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938258; x=1743543058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1l5pGjEx4+P+MuFHzHFXC6UFbSrD/fnVyhaMEPaOEOk=;
        b=RWVO2NR2i6uBiCTwBM1+Lv7WPW5bhPiVhFiXulM6g5FVlkgls6xo+/TwfQpaB5LhYj
         oq39pMwfkT5FoFesf1VqJh1cudU3SbnBwVgBeaseOkiO4gmcdGoAuKQof1dF2YVqN4qg
         PRmCW7uDbk/jGhCEWgcerLDyA9pTsk+dE7Ns42CmbZvKmPmYeqsDbRd+JElIyWOP0e/y
         OgCWFYK+d+cYaHxg48VIXC3ziXyMfUwcHOH54pX0bZW2es5MRZog8ORJAmDt0+JHBLBv
         XqKktJhmWjuc6+0IWWW+fWRFwVjbdN5CFW0TNYNnImgqv8bF2d4C+jMbakSqu+U76rDN
         Pc3w==
X-Gm-Message-State: AOJu0Yz5hjgLU6T/uETXPKUYGFWrurFJ4OEsqfdHbai+RXCrHgV8D53K
	FQuaRdvXGROYwBCiEZ9jiLeal7q/Dxuiwg97sEtDYf1MIktCwAGyAHLUEfgHjA==
X-Gm-Gg: ASbGncuhuAaPyUiM3FhDprucqDtmFIpQHn6ESXBlUmnJO79ge0mmyRzywdBmFicfMcT
	8IbU7a/7P7Vk2oC48Cb9TIBlCfYpc6/y0xdQbS/qwoqvTlFhJo1BKG6VctShsWA+rD22d9u1rBO
	9MjJKzzdNa4TrQPsfQCxJ4xaJ6BmbDzBFyRhiZM9mJuDF2YGeKbVFGomlTMps0TzgWuxWWoJsIz
	cUh7IRwNTFdwmgL4YT6Exj1ZRzccYLvPoIUMNRirjli5sy0Tqr1L/8aC9YspwMI2Nd6R69R4NUw
	JpuHjP8mkEsZu42yvZTJDHyhuirLwmQKQxjrC2CFiPOD
X-Google-Smtp-Source: AGHT+IERq86GLKiORscLBj7/ZTWymCd20f4O4AEevfwuUZaGp0hhapPbNEnsVCBfDnbZYylEKOJ14w==
X-Received: by 2002:a17:902:d549:b0:224:a96:e39 with SMTP id d9443c01a7336-22780c55343mr303972035ad.9.1742938257770;
        Tue, 25 Mar 2025 14:30:57 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227e452ec4asm18920425ad.194.2025.03.25.14.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:30:57 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 0/9] net: hold instance lock during NETDEV_UP/REGISTER/UNREGISTER
Date: Tue, 25 Mar 2025 14:30:47 -0700
Message-ID: <20250325213056.332902-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Solving the issue reported by Cosmin in [0] requires consistent
lock during NETDEV_UP/REGISTER/UNREGISTER notifiers. This series
addresses that (along with some other fixes in net/ipv4/devinet.c
and net/ipv6/addrconf.c) and appends the patches from Jakub
that were conditional on locked NETDEV_UNREGISTER.

0: https://lore.kernel.org/netdev/700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com/

Jakub Kicinski (3):
  net: designate XSK pool pointers in queues as "ops protected"
  netdev: add "ops compat locking" helpers
  netdev: don't hold rtnl_lock over nl queue info get when possible

Stanislav Fomichev (6):
  net: switch to netif_disable_lro in inetdev_init
  net: hold instance lock during NETDEV_REGISTER/UP/UNREGISTER
  net: use netif_disable_lro in ipv6_add_dev
  net: dummy: request ops lock
  net: release instance lock during NETDEV_UNREGISTER for bond/team
  docs: net: document netdev notifier expectations

 Documentation/networking/netdevices.rst |  18 ++++
 drivers/net/bonding/bond_main.c         |   2 +
 drivers/net/dummy.c                     |   1 +
 drivers/net/team/team_core.c            |   2 +
 include/linux/netdevice.h               |   2 +
 include/net/netdev_lock.h               |  16 ++++
 include/net/netdev_rx_queue.h           |   6 +-
 net/core/dev.c                          | 111 ++++++++++++++++++++----
 net/core/dev.h                          |  16 +++-
 net/core/netdev-genl.c                  |  18 ++--
 net/ipv4/devinet.c                      |   2 +-
 net/ipv6/addrconf.c                     |  17 +++-
 net/xdp/xsk_buff_pool.c                 |   7 +-
 13 files changed, 178 insertions(+), 40 deletions(-)

-- 
2.48.1


