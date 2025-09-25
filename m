Return-Path: <netdev+bounces-226164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F2AB9D223
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 04:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E7C426567
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6059D217723;
	Thu, 25 Sep 2025 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="un2QhBbi"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00888D2FB
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767149; cv=none; b=Sf/dpkAjzJVDf8xTFcg+KEOG2ZLuyWEMomQEwzTCxYCqQwwUhE3S8tgA4C1Vi1XozB4iwgpew2EW7NpEo08OwpqHUrHlQNi2QDqq/XIpxadOXNnqe0b+0F5LuctaebKvuz++5J93oeeuM/DCeLxm4skjSvI11C6XiPysDoxsHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767149; c=relaxed/simple;
	bh=oRDuhn7Y658oIujEOtFvXZcJwIQ0U9KoG6tl4a70K2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IYHZQ9Fb7F3P1LjFITalbTiwrbISuNLqACfsxiS68rqrC1GAYSECUAqdUA0efxN9NaOPT3MuTmHBkMuIhl0mwPyVikg8FLOOUeTTbKqVHfgtonoEG/ht06frhHQ4LteBwfcr+2HLuet03u5AB3M23ltVEPUvPgok4jIR8aiayIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=un2QhBbi; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758767138; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YQzqMdtynwLdblPLgkLi43biFCY7AG/K30UPXO5sBN0=;
	b=un2QhBbir1R6xTyrf8QNAoxPiPgrM3lO18rxlUco6zgUcU1/5tDz8IE01g37fcyArtXWvimV4MeT4NVejkS4JrdJIeNsdZycPmBljE/6y5gzgqYprnij3GRYWAey5XItn98mfOiyxxVnfKPN6HFggcDC9h+LyVqLiFPVCt91jws=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WolqhAj_1758767137 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 10:25:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net 0/2] fixes two virtio-net related bugs.
Date: Thu, 25 Sep 2025 10:25:35 +0800
Message-Id: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 833f31d30d57
Content-Transfer-Encoding: 8bit

As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
small amount of code duplication.

Commit #2 is new.

Xuan Zhuo (2):
  virtio-net: fix incorrect flags recording in big mode
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN

 drivers/net/virtio_net.c   | 16 +++++++++++-----
 include/linux/virtio_net.h | 19 ++++++++++++-------
 2 files changed, 23 insertions(+), 12 deletions(-)

--
2.32.0.3.g01195cf9f


