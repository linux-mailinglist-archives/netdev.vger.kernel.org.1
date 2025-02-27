Return-Path: <netdev+bounces-170398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4836FA4883C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CFF16DC47
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C850726E176;
	Thu, 27 Feb 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gGxxcLWA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1D26D5B7
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682244; cv=none; b=eMUY9tRYn7tqPTslVaXODSGZfBaJoRSPhWTuQ0f1iBwlAmuTQHkOhQFe3m0Ozku+k522tYTZshnOA4xxllpaJW9DpuvN7iMVHFp2LTLdq6mckZ7IUlaQhoQENxHrFuzjomLVUbWKLmiy5YqWQn9n+ysHEEL/PUoj81hN4GZY/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682244; c=relaxed/simple;
	bh=JVrLUQPdhierVvVB9T39WHViYQpGOg8iWAODC6R6k+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5or5iAOTtdy5/TNd2I2INTNym7p1mHRfim0ffAXx14wF6e/IsmtPTuTL/Ifi6Ts+puGLM7m22X6NN76raiobsVKHNNo6DJ/dKW9nYrxSr4Vs5oZK7vtax12yOXLlAQUUYlyUdgheSRIHrRSIkaqOGxwn5zwS0JhKTFyvq3wGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gGxxcLWA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e83d65e5so24977645ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682240; x=1741287040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DooASBqDq2Su1Kjlyvffy6QfBZOl14ihxJCQdnbxEeA=;
        b=gGxxcLWAmZIeoFkDDobLo7IW7coKQZyLvDksPGpine7sgAU30GRRMh/tldAtfYoY82
         R30AtGtY6WoERneexwCWmRuoayVDBEFDabzGQfz7R0MjYC2f5+uzkNO0rxq88K2S611T
         1E/padxbqJ7Wsw9uDmEAt9IfD7cywysEaUzX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682240; x=1741287040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DooASBqDq2Su1Kjlyvffy6QfBZOl14ihxJCQdnbxEeA=;
        b=cOBNA8KixG5HLSLHQA11S7Yyc3F7B+Kf0X/qsCM/mEXk217z0Y73OUsAJX6OcwTK9l
         kMZx6Ui9gG7F+1IPoJY+Dfg3pZPkX+BfwsCTuBS2ef21Pau3zc28zjfa7BoKFrA6xkrs
         jlgyePkCp9NW6KDo/19Klpa5Z5sBwy96XTZ3UxuWwnggzRAsz/DJnfB7ebfB+NY9dVIS
         HCCId7TDYVBMzxFgY2hpCM5R+X9WDUID03lD7XsoxEecRS8m25B1rTrnveMNcO2iMAdH
         BYpQfP+VYsK3F2qcZJpVKLZZs53UcIzNnl7jdz5a1t7stlyouEBd0bxckl9zflgoI2S1
         9ZQA==
X-Gm-Message-State: AOJu0Yx3wzpuXYs16Ol5K04UFv4RH7AFFejqi7t4LSDUm0XVpHROiWqx
	l4hGYll/x/FkOkh/mTi/YVBmXZxZOC1piGJsFdjLAvyE1GN6FXX7jX19g6WWIQbc/S2t4ULYfMk
	cqiFWpDbMvSBt/+b2DRMI6DQh1s5bvfpFw4fWHY+aAwG1JG/NQvjqfaxWie5z56uO3dB8p/Tc7t
	gdQ04tddC4TblBw7a9kMBvmFV1LQdVyiT8HtHmeQ==
X-Gm-Gg: ASbGncsZHMkA8HF7byoRuEXUwkmS7jXCUSmH8T3Dhg97roeGfI6cImk5IFKQgYNFXj8
	jUjtgHSbaHNl0qhu328imo+5WSGGDCZAgpZsoA8b5i5RlYFn3pr26YKaEupZwWo1/z/p27vRpm1
	4AZui8v5P64PFe/SPBpJ11ZFxg/j737Ok4Kv0voDAZP8xAyNMNwJYRl2Okzsl9pMHn6pFmr+U49
	Dy6ElXMBdMmBH0suD0aGNaz2ka/aFGp3hW7/49Y376PPT4WRg0WWFmzWU/q6SoK7ofRH1wD33bK
	fKrGFNtpuUiIPtQkkcGjNbUQ8LgONMGhtg==
X-Google-Smtp-Source: AGHT+IFA0MRx4/wAs809zakde3f4qVOiG47vG98z/6mWwQFds5bqMOu206vyHM1cjUG7RCAYoliRcg==
X-Received: by 2002:a17:902:d510:b0:220:f140:f7be with SMTP id d9443c01a7336-2236924e3f6mr3183985ad.41.1740682240355;
        Thu, 27 Feb 2025 10:50:40 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:39 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
Subject: [PATCH net-next v5 0/4] virtio-net: Link queues to NAPIs
Date: Thu, 27 Feb 2025 18:50:10 +0000
Message-ID: <20250227185017.206785-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v5. Patches 1, 2, and 4 have no functional changes only
updated tags. Patch 3 was refactored as requested by Jason. See the
changelog below and the commit message for details.

Jakub recently commented [1] that I should not hold this series on
virtio-net linking queues to NAPIs behind other important work that is
on-going and suggested I re-spin, so here we are :)

As per the discussion on the v3 [2], now both RX and TX NAPIs use the
API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
correctly elides the TX-only NAPIs (instead of printing zero) when the
queues and NAPIs are linked.

As per the discussion on the v4 [3], patch 3 has been refactored to hold
RTNL only in the specific locations which need it as Jason requested.

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
[2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
[3]: https://lore.kernel.org/netdev/CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com/

v5:
  - Patch 1 added Acked-by's from Michael and Jason. Added Tested-by
    from Lei. No functional changes.
  - Patch 2 added Acked-by's from Michael and Jason. Added Tested-by
    from Lei. No functional changes.
  - Patch 3:
    - Refactored as Jason requested, eliminating the
      virtnet_queue_set_napi helper entirely, and explicitly holding
      RTNL in the 3 locations where needed (refill_work, freeze, and
      restore).
    - Commit message updated to outline the known paths at the time the
      commit was written.
  - Patch 4 added Acked-by from Michael. Added Tested-by from Lei. No
    functional changes.

v4: https://lore.kernel.org/lkml/20250225020455.212895-1-jdamato@fastly.com/
  - Dropped Jakub's patch (previously patch 1).
  - Significant refactor from v3 affecting patches 1-3.
  - Patch 4 added tags from Jason and Gerhard.

rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fastly.com/
  - patch 3:
    - Removed the xdp checks completely, as Gerhard Engleder pointed
      out, they are likely not necessary.

  - patch 4:
    - Added Xuan Zhuo's Reviewed-by.

v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.com/
  - patch 1:
    - New in the v2 from Jakub.

  - patch 2:
    - Previously patch 1, unchanged from v1.
    - Added Gerhard Engleder's Reviewed-by.
    - Added Lei Yang's Tested-by.

  - patch 3:
    - Introduced virtnet_napi_disable to eliminate duplicated code
      in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
      refill_work as suggested by Jason Wang.
    - As a result of the above refactor, dropped Reviewed-by and
      Tested-by from patch 3.

  - patch 4:
    - New in v2. Adds persistent NAPI configuration. See commit message
      for more details.

v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly.com/

Joe Damato (4):
  virtio-net: Refactor napi_enable paths
  virtio-net: Refactor napi_disable paths
  virtio-net: Map NAPIs to queues
  virtio_net: Use persistent NAPI config

 drivers/net/virtio_net.c | 95 ++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 28 deletions(-)


base-commit: 7fe0353606d77a32c4c7f2814833dd1c043ebdd2
-- 
2.45.2


