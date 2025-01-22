Return-Path: <netdev+bounces-160193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF0A18BCD
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 07:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAF7163330
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C66190674;
	Wed, 22 Jan 2025 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ai9mafA3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098FD15B546
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526589; cv=none; b=GFj4NEd4gs4/TaUwZP9AyyVWPdoFiMunf6gvaxJjF+/yLKdKvS44hdXKf0FoJ/Oe31+Oj+fc+MMo6rC72DEK+C1Cl9/7PtOXwuMZqTvG9P+GDk4s6jkweP5zzdqtC1jS19Q19n5GtSRw3jtJlMAUFKr3+LGeANztKrFbUiLCTIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526589; c=relaxed/simple;
	bh=5uxtqZMfHCev+JG6XrIgLTHL5fLil3E67cwwPRm0LA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjHeTWnvfReYd8Xuj+McSBTobS8h2+LUUVZIDokBd8igzTO0RhUEISxDd9oPbOmf1p2xAOhEuiy7eNlp53NE+mJX5b7G0VVMlZ6I2kNLpzWWrp+GYWazCW61QFVH4kMlZPtJGMli8vpu1IVJ6MpdbSsMaWC22CpKmZJTAm/PvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ai9mafA3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737526586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hr9kjAOl5Zo07A2Y7Yx2gYOn95HiryxvxLZNJycD00I=;
	b=Ai9mafA3r4XvszfxJVpmckvzA1routdekyO3ylF1KXsE7qamYHDGBHdjibKohfOOQLycCq
	vtP62lzhMwUvmeONO1jbb8yJq7CBqgxKpvEvDU51Jowq1ecbROnAfBEillZDhMxO45Qlqf
	+4kbvVXXCJpu7YMwuKThDSxizHdXe9g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-0wK6emrzNx-ouvt_v_isJQ-1; Wed,
 22 Jan 2025 01:16:21 -0500
X-MC-Unique: 0wK6emrzNx-ouvt_v_isJQ-1
X-Mimecast-MFC-AGG-ID: 0wK6emrzNx-ouvt_v_isJQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69BCA19560B8;
	Wed, 22 Jan 2025 06:16:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.209])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FAC3195608A;
	Wed, 22 Jan 2025 06:16:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next RFC 0/2] don't clean packets in start_xmit in TX NAPI mode
Date: Wed, 22 Jan 2025 14:15:58 +0800
Message-ID: <20250122061600.16781-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi all:

This is an RFC to try to speed up TX by avoid cleaning transmitted
packets in start_xmit() when TX NAPI mode is enabled. This increase
25%-62% PPS depending on the setups while keeping the TCP throughput.

More numbers could be seen in patch 2.

Thanks

Jason Wang (2):
  virtio-net: factor out logic for stopping TX
  virtio-net: free old xmit skbs only in NAPI

 drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 13 deletions(-)

-- 
2.34.1


