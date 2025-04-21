Return-Path: <netdev+bounces-184450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0941A9595A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC947A3A29
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB60E223704;
	Mon, 21 Apr 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZgQiGL+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AE82222CA
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274515; cv=none; b=N7qvfuKHOvDu2rA2Dzso2n2Ts0e2X1dz5uxifDZysw1CqJ47XE7vR3FT9zGOZaHW9cn/bkjgq/YRWo8Yb1Sk6jpW/gBejlfvFYbL/uK3UE52FQn4g9QLpKCglXI4Kwm3EbXOJzk3d+zuDUW0Ej1nUFcHbB5MhdY3P1XOsN3Izv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274515; c=relaxed/simple;
	bh=T4fleFadU9HUdchSN5jF1GlhLbSMoFcXuQqhjZTDfcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeTfSMce4mDXjFUC08n+jxf7VjmtlK63yV/ThAmZFSWQC8nxsIoA1BsITZ6k05Lz2fl+SrhB48+bwJZU4Exe7ppMSqzVnUJfhctIFOFcPYfwaKddQ11EwV/JhG1fg5pb596RnSzGA6Im+0BpA0bCWEMZ+9fHJy1o07cQb2q4XkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZgQiGL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF7DC4CEEE;
	Mon, 21 Apr 2025 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274515;
	bh=T4fleFadU9HUdchSN5jF1GlhLbSMoFcXuQqhjZTDfcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZgQiGL+epgP1/nbeQXMPMjPp27OYV9Tdbd+9LDPi5qswLab+6x6SCxuqWDJz3Ib7
	 I86qe49WjgPEBJGwWRRJRNlMp1n1u6KQeIbXjxNO3ZnBrOSuYIUkXe1Zjtrf/WfqtD
	 0640Zj3tPhzek/CszYBDp5x1poej/scplGA+Q365Fw2uTcusjzHewcar4wY42HcGir
	 ZXUeOPtCaepnwZiiffkzn9DnOXDY+ExVoQ1/88l7St1a85hV7u064IOTDKOKyqWuIb
	 eY5nYWe76PSIO3GqT2YZ257vW8yWx4bG31CCffw8zXacfXK3g6TSmA6sojl17mSGZQ
	 FR51Jc70QpLJg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 01/22] docs: ethtool: document that rx_buf_len must control payload lengths
Date: Mon, 21 Apr 2025 15:28:06 -0700
Message-ID: <20250421222827.283737-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the semantics of the rx_buf_len ethtool ring param.
Clarify its meaning in case of HDS, where driver may have
two separate buffer pools.

The various zero-copy TCP Rx schemes we have suffer from memory
management overhead. Specifically applications aren't too impressed
with the number of 4kB buffers they have to juggle. Zero-copy
TCP makes most sense with larger memory transfers so using
16kB or 32kB buffers (with the help of HW-GRO) feels more
natural.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/ethtool-netlink.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b6e9af4d0f1b..eaa9c17a3cb1 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -957,7 +957,6 @@ Kernel checks that requested ring sizes do not exceed limits reported by
 driver. Driver may impose additional constraints and may not support all
 attributes.
 
-
 ``ETHTOOL_A_RINGS_CQE_SIZE`` specifies the completion queue event size.
 Completion queue events (CQE) are the events posted by NIC to indicate the
 completion status of a packet when the packet is sent (like send success or
@@ -971,6 +970,11 @@ completion queue size can be adjusted in the driver if CQE size is modified.
 header / data split feature. If a received packet size is larger than this
 threshold value, header and data will be split.
 
+``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffer chunks driver
+uses to receive packets. If the device uses different memory polls for headers
+and payload this setting may control the size of the header buffers but must
+control the size of the payload buffers.
+
 CHANNELS_GET
 ============
 
-- 
2.49.0


