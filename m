Return-Path: <netdev+bounces-169267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71795A432C0
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C78F3ABADE
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5D112C544;
	Tue, 25 Feb 2025 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="f71w1cVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456C3FB9C
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449112; cv=none; b=QkJGy7RgvqKXeiYkdhfL+lQQ1GEDNd9tYM4XzThkJsRaZDLhcahw8arwQN/hbXIizLKK2aY5gGfx+8fnGA7ZWA9FnSTQOLVo6CGgmgYf42wSN55obWDCql21ELPmLPGYUg2XEiTJl8621Go/jocKJkwUQEZ81FYUhUowivrq//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449112; c=relaxed/simple;
	bh=kHOkHvRodwcD3NttIpuOtmg3zPEBcl94jQ+MNSiumRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvCo9aCbWvI0kS0/c6pvg4p1bsL+haU2AvGnaeK2/r1ESrraq+WWDJZDcqX2CO+yEe1iHF+PXJSyAwe8nNW60d3oo3AwtHWkUSHSeBZH0vtu4MKw8iLL99yF/n+gLo+///KBdYX2gCS5OPNef4wIdz6SANZu5Izx3GrAC03zdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=f71w1cVH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220ecbdb4c2so25551745ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449110; x=1741053910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrEz6DL7nanR7o+Md6nJONj+JBnYNeVaOFzve6JT0bE=;
        b=f71w1cVHG2A1vTGvGyni8RdEnNB8WIpar2RRQ8vbusQFylCgM8LFqB12lQGOviaUyx
         eLKYRhKn7PXR0chAQJ6z+aXCNvMMvwmO+XAn3dDLms5T3JtGADNhph+av0G4t7XANn7p
         n2ijiqYnGkGFFY7bEwUUkNDKNZESif8WOQhfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449110; x=1741053910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrEz6DL7nanR7o+Md6nJONj+JBnYNeVaOFzve6JT0bE=;
        b=EUJzuyA56qPwCliWWElceUG/UDzY0HXGCQTs9xNfxQHq7wFynQNuYGQRwL/lzJXyX3
         pOL0XgRZYgkLWPd1uph6iJrGTwuQxYM9sB6yulut5DWTh31koVDtaT4D2fxuAkljBh/G
         ZsOdqRtJ/drM8gn45zK+dzR/svDQGCfvIrpeVzKn1daK1SSRejKcj1lM8kiJ86CDzbmW
         hQ0EuEDJ4+U7fAprno3+bQxukGjEBdn0sj64WSLSVPo6sMSA32cKvCnSwjX2kcKkbyob
         cd3Votcxs3LxZnkWpOqisSPV1nxzs47ll+FbBmiesm0yyDKHNvRniVKWDc2BXau4MBiB
         VzbQ==
X-Gm-Message-State: AOJu0Yw/YzptZlmFcFZs+n7Yvy4/bCMzjGeCLNhXNY3pkcGop+KzmKfs
	bGmx3eQYLy+j7X0kzGE9ukHm630CqrpqHVHdM94RPPVVs9CCYlU66Rr3lw5UqonIY7Vx/qEWVk8
	VNlNnY5DWrHcbQhHn988YQDBWMVXiBHRu2P0xUDLjqdA4hfHDZGQaXyTF/RL0MOgTzuY38qie7F
	8/hH/vk411qYv3kQAS5WrnMJD3KZWU60WrGIpSVw==
X-Gm-Gg: ASbGnct3vRHJYEAOkYNs+o2TSs2AG86D3xMEGf2nlUZIgb1lQ28rBMXLs5HDyMosBMr
	5807Eg5vUHjwIHpFQoOc1Sotx58hQ4lWJo1IYG9FTp+/IjfVB17oJHbO4TlmBxhBWOHHb4eoImJ
	8aGDHqunYs/JsXFQGwgmMI6Nu6v2RM7POerz/W6pB2hlVKG4QYWYpHlXhMBAm6noXCL6mGUD8ll
	OPCxTbaDyxC1QlUdrObCMKR7Pa2WrDDdxDMU/uGvefFmBDrP9kjszw1vWym3lJhXJVM+pT8fdbG
	J0za0pzZRjyfgOJd3DJgLtj/xbtmSY7tOg==
X-Google-Smtp-Source: AGHT+IGWw8VZRuhBkwJIhpvAEi5veGPj66DpJjrWgGvII/XhNJTIzi7tYlWN7e+HTUnHvLTljSfU5Q==
X-Received: by 2002:a17:902:f712:b0:220:ef79:ac95 with SMTP id d9443c01a7336-221a1148b7bmr231152995ad.37.1740449109648;
        Mon, 24 Feb 2025 18:05:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
Subject: [PATCH net-next v4 0/4] virtio-net: Link queues to NAPIs
Date: Tue, 25 Feb 2025 02:04:47 +0000
Message-ID: <20250225020455.212895-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v4.

Jakub recently commented [1] that I should not hold this series on
virtio-net linking queues to NAPIs behind other important work that is
on-going and suggested I re-spin, so here we are :)

This is a significant refactor from the rfcv3 and as such I've dropped
almost all of the tags from reviewers except for patch 4 (sorry Gerhard
and Jason; the changes are significant so I think patches 1-3 need to be
re-reviewed).

As per the discussion on the v3 [2], now both RX and TX NAPIs use the
API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
correctly elides the TX-only NAPIs (instead of printing zero) when the
queues and NAPIs are linked.

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

v4:
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

[1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
[2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/

Joe Damato (4):
  virtio-net: Refactor napi_enable paths
  virtio-net: Refactor napi_disable paths
  virtio-net: Map NAPIs to queues
  virtio_net: Use persistent NAPI config

 drivers/net/virtio_net.c | 100 ++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 27 deletions(-)


base-commit: 7183877d6853801258b7a8d3b51b415982e5097e
-- 
2.45.2


