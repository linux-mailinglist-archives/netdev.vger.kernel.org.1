Return-Path: <netdev+bounces-228434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85558BCACE1
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 22:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 465634EA414
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF272701B1;
	Thu,  9 Oct 2025 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="PvV0gsQX"
X-Original-To: netdev@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2D27056B
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.0.186.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041747; cv=none; b=N7VUBdHVZKzK07RXQI//20tEwXS4wX5uMz7p53y8KTn4B+AR1+mhQh3sWivGQrLAE927+5OIlCZY4/ZQEpf5NxdChZ+YK8mc91445I82OC+6L2Y8W2I90MZ4v5GvYZK+ur/QzB1Z36m2hoPEUhwIuXfC+Pys6m2esB28ay/Uou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041747; c=relaxed/simple;
	bh=BqmL8qSCaK+MZ1CoMJtzzo3fv2sANfeQJJcqeOfYyUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxZp0CHX7wZ9h7kAz7RWyuF79iJKTURWkUh8W4OQ+G1zm390awU0NvGhjYZgtBunOuWaJi+57I99WyZS5ECPwWINoyZPboxURecHLKEeAU8kUuQc+ewTbTcPe2vxaGZ2lqtFGvmsvpwVAJls0TxcioK073VlxW7RLTlnJr3tKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=PvV0gsQX; arc=none smtp.client-ip=142.0.186.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email-od.com
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1760041746; x=1762633746;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=fNeFEOfUOZVVJm8zrFxKc3lRrfCO7pVZbIyZXfxTnGs=;
	b=PvV0gsQXItFqJ8GBDdHcpKX+FEvzKaPLbEv2TcBEyIIeiIixSUQmeWBPkk7qed5KhcfixBK5oou4MVVaS0arXcuRE3gwujYl1O4Oekkdj7YgNCIoXfez7Eif23MD63AaBhHvSU6wXfTRgYqJNklPodUHwXqZBAt2/N2DxfkfLyY=
X-Thread-Info: NDUwNC4xMi5hNjBiZjAwMDBhZmJhY2YubmV0ZGV2PXZnZXIua2VybmVsLm9yZw==
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from nalramli-fst-tp.. (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPSA id E79E42CE000D;
	Thu,  9 Oct 2025 15:28:40 -0400 (EDT)
From: "Nabil S. Alramli" <dev@nalramli.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	lishujin@kuaishou.com,
	xingwanli@kuaishou.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	team-kernel@fastly.com,
	khubert@fastly.com,
	nalramli@fastly.com,
	dev@nalramli.com
Subject: [RFC ixgbe 0/2] ixgbe: Implement support for ndo_xdp_xmit in skb mode and fix CPU to ring assignment
Date: Thu,  9 Oct 2025 15:28:29 -0400
Message-ID: <20251009192831.3333763-1-dev@nalramli.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Kyle,

Please take a look at this patch that I plan to submit upstream, let me
know if you agree.

Hello ixgbe maintainers,

This patch is a RFC to add the ability to transmit packets using
BPF_F_TEST_XDP_LIVE_FRAMES in skb mode to the ixgbe driver. Today this
functionality does not exist because the ndo_xdp_xmit operation handler,
ixgbe_xdp_xmit, expects a native XDP program in adapter->xdp_prog. This
results in a no-op essentially. To add this support, I use the tx_ring
instead of the xdp_ring and allocate a skb based on the xdpf, and then us=
e
dev_direct_xmit to queue the xdp for tansmission.

May I get feedback on the idea and the approach in this patch?

Thank you.

Nabil S. Alramli (2):
  ixgbe: Implement support for ndo_xdp_xmit in skb mode
  ixgbe: Fix CPU to ring assignment

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 16 +++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 43 +++++++++++++++++--
 2 files changed, 47 insertions(+), 12 deletions(-)

--=20
2.43.0


