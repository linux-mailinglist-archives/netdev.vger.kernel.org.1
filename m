Return-Path: <netdev+bounces-160119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2BA1857B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F31169668
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395361F7084;
	Tue, 21 Jan 2025 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KE+iFltD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B0E57D
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486669; cv=none; b=ckWFRafwmN1/7KDJ4nidBAG5lPFOJ95TbX5X35WcpY40E/nYv00VSAuysWCiqTBjxWuJMJVa+tiMc3F50NU5vN1WGsiBL0KFhnQFxRrZBLbONcVI6OwBx/vJI30/qyKdAMeeTP8/6sqgudYsRT/aQgg+IWryrxicCCbYzGq95Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486669; c=relaxed/simple;
	bh=+0FsmQUk4wwlNbG2Q/Gp0YW679krx30KK3RM+HGyF8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/KZP/37DjOIRsjUguOX6ogfQL1Rb4ONq7aSIXR+aqpWvi2ANXorrAcrmZZ/ELVR/9Oj86j3fyIAQOQh+KcH/fmceviXCZrmghN7X988TrzHRb55sWMy0mL3IJ+RrqNLCOJS4XirBJbpz4wZWJJcB4LCzN990UyXg52K3JliAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KE+iFltD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so142145a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 11:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737486665; x=1738091465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q3Sac5q4L1YHRHONzzVYH+nRWURN24ROJ0RWQrQ27i0=;
        b=KE+iFltD5m4xnOq/0rwt+0jIeDZ9Og5YNghAGyhrx3EQGoPfXtTjzd/0Ubdl0F5rpL
         BdwROMUN4quo17y7CrQCoOKBE1SE7TKK28DHutoyp1wtQwJFZS0O4OyreVNmcwk7G27Y
         AX5HQtj9GykHSJqE/U+o8jj3Zf1JeeCISppeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486665; x=1738091465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3Sac5q4L1YHRHONzzVYH+nRWURN24ROJ0RWQrQ27i0=;
        b=QG38Cih56i9ToLz/0o0ZSqqe71yfaBhlr5TB4V91C1xn9+df1rBYxftU4R9ZV7HFS+
         31sLGci5yIX+f6KRNWLKfZhxZ/aXbK/0YeQUiwWOA1W9Rtks8VsG93FUTM90F7aECLND
         HxGoBpaoHTTknyMrrtoGh+aBM8W1COlwiwEwparPP3JQTUDLWcBGOs8FP0Q2TMzzJ9EW
         VUQRopyPgvyZ0TWFmGaVtzKtuH1SnPI/8DAzrKiw+Mbe4uEPXAq9xXvmjdEAfKm2xXiK
         /PlpJSZX9SY87ReJyvJtGFefbc1wkdv+bF1gSFBi0XuScWzud3i4y6NxFulNV71NOTo7
         iyIA==
X-Gm-Message-State: AOJu0Ywmhy3vfN56ALxMLms/biHYY+UlyNLNDGR6Oif04APHFu4dFsZd
	PGmNZ2gGkv3P6cTsujKjLb1rU4tzWmgGGdw4n9r6m2pfmvUHQw6LTiUCo3Z6OWUiaivhooVM5wW
	wwBUYz3/Rt7FqWGcPDMyia5DByTej6F4P/Zcbv2M7aMFj2SoauyLrHA0/OxY4cPrLkrgZPh/EbE
	sA/a5h/kOW7Tt2srKaWzS04F/OA9tAl8EV1Tc=
X-Gm-Gg: ASbGnctCKK1mavq/BHvwb/jq4kMocXtP69zFHok1wt3764UeWMW39BwcSRxlEdabrLk
	KcOrogR7jwiCldcR0bDb+0ovrY1lQTGwg7u5sEMVu/sUJKV+DkZNnkbtTF59ti+FKQIBnIo3S4r
	osrBEJtNuJ0hVGWh+orzC8P6CV0adPaoXhDBYF/eLx3URePzcc3dNhfBiq7w141+zmYW4O5sDIe
	PNXrAwXrjmj4pEfRGWfQJ6cSyWnbfPneU4RfDYurGMU3DQcJlatk5u59wsQVmu6wh91L1308AiY
	Jg==
X-Google-Smtp-Source: AGHT+IESdTWYzrYdfrjHndy1A6eiSq6VjHZhj5JI29tgHseTks5JAkTBUNTjwpCAQiHydlbjVFpE3A==
X-Received: by 2002:a17:90b:53ce:b0:2ee:cbd0:4910 with SMTP id 98e67ed59e1d1-2f782beed8bmr27056092a91.1.1737486665211;
        Tue, 21 Jan 2025 11:11:05 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm1793440a91.26.2025.01.21.11.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:11:04 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-kernel@vger.kernel.org (open list),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
Subject: [RFC net-next v3 0/4] virtio_net: Link queues to NAPIs
Date: Tue, 21 Jan 2025 19:10:40 +0000
Message-Id: <20250121191047.269844-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to RFC v3, since net-next is closed. See changelog below.

Recently [1], Jakub mentioned that there were a few drivers that are not
yet mapping queues to NAPIs.

While I don't have any of the other hardware mentioned, I do happen to
have a virtio_net laying around ;)

I've attempted to link queues to NAPIs, using the new locking Jakub
introduced avoiding RTNL.

Note: It seems virtio_net uses TX-only NAPIs which do not have NAPI IDs.
As such, I've left the TX NAPIs unset (as opposed to setting them to 0).

As per the discussion on the v2 [2], all RX queues now have their NAPIs
linked.

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250109084301.2445a3e3@kernel.org/
[2]: https://lore.kernel.org/netdev/f8fe5618-af94-4f5b-8dbc-e8cae744aedf@engleder-embedded.com/

v3:
  - patch 3:
    - Removed the xdp checks completely, as Gerhard Engleder pointed
      out, they are likely not necessary.

  - patch 4:
    - Added Xuan Zhuo's Reviewed-by.

v2:
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

Jakub Kicinski (1):
  net: protect queue -> napi linking with netdev_lock()

Joe Damato (3):
  virtio_net: Prepare for NAPI to queue mapping
  virtio_net: Map NAPIs to queues
  virtio_net: Use persistent NAPI config

 drivers/net/virtio_net.c      | 38 +++++++++++++++++++++++++++--------
 include/linux/netdevice.h     |  9 +++++++--
 include/net/netdev_rx_queue.h |  2 +-
 net/core/dev.c                | 16 ++++++++++++---
 4 files changed, 51 insertions(+), 14 deletions(-)


base-commit: cf33d96f50903214226b379b3f10d1f262dae018
-- 
2.25.1


