Return-Path: <netdev+bounces-237579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21DFC4D5DA
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEDD3A1288
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FBD354AC3;
	Tue, 11 Nov 2025 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IDLQlboc"
X-Original-To: netdev@vger.kernel.org
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34773546F0
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859548; cv=none; b=N9Voib+ikyS5aQ+1+Z8jckbFnFhgcxjV8LQiB4BGTSrr8tJ1w0Lpr3Paj8jW+biq7svgk/OiFFQhmnkJIaxT/q47b8WJ/sx0JtHlXP2xJcXPWHEwMs3PvqVyHiXsAkP8UiahBTKRvb1gE8okgOz+Wrmvf/+XlwoJe7YonEPBlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859548; c=relaxed/simple;
	bh=M5ewjUi4yLus3HcD5leOqBCi/HqiKbKYJtq/GQSbD7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nu/EQrX3s2t+a4ZgCPG/BgBJ3JOQf09dNNTId00UsYH/ORVqjH53o2XZQlaBQXNHcYTqDM00dkB4oilFDXYIuTsK+5/GCG7z7LJr/AYLBvsHSVs9X6/pta75LmiuHVJipiHIZoIIbQ7VG3HzLtWN3g1IQxBKs80KMLQvfcatvM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IDLQlboc; arc=none smtp.client-ip=47.90.199.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762859534; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nVqpNz4zmQtnhgYeVe3TQQhFUL1KimGDuNjnX3WYQhU=;
	b=IDLQlbocVCEcy8ZFTi1+WswDWD4Shv0GMLqUB6RkoUSu+ApuS/+IEGTvVY1S2nr8pQ8+HdB5umzpZBIm9aA0AZC92iohQI0pd/BHdxnf9OydhpFBSmWeAynkpbNUJgxtyFoqodZCUoxXvBTjFkJXyGT9T0PiQsO7kxIlJP8MtPY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WsBONCA_1762859532 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 19:12:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH net v5 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
Date: Tue, 11 Nov 2025 19:12:10 +0800
Message-Id: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: feb36a32054d
Content-Transfer-Encoding: 8bit

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This path set fixes that issue.

As discussed in [0], this version checks the VIRTIO_NET_F_GUEST_HDRLEN is
negotiated.

[0]: http://lore.kernel.org/all/20251029030913.20423-1-xuanzhuo@linux.alibaba.com

Xuan Zhuo (2):
  virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
  virtio-net: correct hdr_len handling for tunnel gso

 arch/um/drivers/vector_transports.c |  1 +
 drivers/net/tun_vnet.h              |  4 +--
 drivers/net/virtio_net.c            |  9 +++++--
 include/linux/virtio_net.h          | 40 +++++++++++++++++++++++------
 net/packet/af_packet.c              |  5 ++--
 5 files changed, 45 insertions(+), 14 deletions(-)

--
2.32.0.3.g01195cf9f


