Return-Path: <netdev+bounces-233838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E65AC18FE0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AA41CC45E3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED03164D6;
	Wed, 29 Oct 2025 08:07:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.garderos.com (mail.garderos.com [213.61.82.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5F3164BC;
	Wed, 29 Oct 2025 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.61.82.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725256; cv=none; b=GMCv7wDHW0gFjae3Dqz7tj/tdGdWp8KUxfaMct46qyT7Nj72gm8BnHaz6blt+5n398EL3zQRl/nUh9phcxbQFHBi6eyOwxrclqwQrKH1vQo1lqDE8Jq+vCsDW6uxg+M32xTgd+eXyp82Kd+EHmYNGpCwB6unuNP/tg4ipIO1FXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725256; c=relaxed/simple;
	bh=efbL4jKzMvs2zzBcpTkVLy/R+EysAlOh+9tcvxIqlRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CH0MQLlokRqcMm48oJlltMYhCPwgoqpCnxhb0EKNVwVrkkB2DZFWQhO2XqcY50z7j62e7ofwASwSGVFoBaxfZ6qpc0RP8wxjuU3SIcvWdgu7bx1cbapH4FQbH4bRj/RYQCec1PHIBy9hKEInBnAbCJ40GfU6ZuAL7Nz9vh9/Ivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garderos.com; spf=pass smtp.mailfrom=garderos.com; arc=none smtp.client-ip=213.61.82.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garderos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garderos.com
Received: from pc-067.dc.garderos.com (unknown [IPv6:2001:920:18d3:402::175])
	by mail.garderos.com (Postfix) with ESMTPSA id 617B91C01CD3C;
	Wed, 29 Oct 2025 08:57:57 +0100 (CET)
From: qendrim.maxhuni@garderos.com
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn@mork.no,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Qendrim Maxhuni <qendrim.maxhuni@garderos.com>
Subject: [PATCH] net: usb: qmi_wwan: initialize MAC header offset in qmimux_rx_fixup
Date: Wed, 29 Oct 2025 08:57:44 +0100
Message-ID: <20251029075744.105113-1-qendrim.maxhuni@garderos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qendrim Maxhuni <qendrim.maxhuni@garderos.com>

Raw IP packets have no MAC header, leaving skb->mac_header uninitialized.
This can trigger kernel panics on ARM64 when xfrm or other subsystems
access the offset due to strict alignment checks.

Initialize the MAC header to prevent such crashes.

This can trigger kernel panics on ARM when running IPsec over the
qmimux0 interface.

Example trace:

[  276.268068] Internal error: Oops: 000000009600004f [#1] SMP
[  276.313631] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.34-gbe78e49cb433 #1
[  276.321491] Hardware name: LS1028A RDB Board (DT)
[  276.326207] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  276.333194] pc : xfrm_input+0xde8/0x1318
[  276.337134] lr : xfrm_input+0x61c/0x1318
[  276.341068] sp : ffff800080003b20
[  276.416041] Call trace:
[  276.418489]  xfrm_input+0xde8/0x1318
[  276.422074]  xfrm6_rcv+0x38/0x44
[  276.425314]  xfrm6_esp_rcv+0x48/0xa8
[  276.428898]  ip6_protocol_deliver_rcu+0x94/0x4b0
[  276.433530]  ip6_input_finish+0x44/0x70
[  276.437376]  ip6_input+0x44/0xc0
[  276.440612]  ipv6_rcv+0x6c/0x114
[  276.443848]  __netif_receive_skb_one_core+0x5c/0x8c
[  276.448743]  __netif_receive_skb+0x18/0x60
[  276.452851]  process_backlog+0x78/0x17c
[  276.456697]  __napi_poll+0x38/0x180
[  276.460194]  net_rx_action+0x168/0x2f0

Signed-off-by: Qendrim Maxhuni <qendrim.maxhuni@garderos.com>
---
 drivers/net/usb/qmi_wwan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 11352d85475a..3a4985b582cb 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -192,6 +192,12 @@ static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		if (!skbn)
 			return 0;
 
+	       /* Raw IP packets don't have a MAC header, but other subsystems
+		* (like xfrm) may still access MAC header offsets, so they must
+		* be initialized.
+		*/
+		skb_reset_mac_header(skbn);
+
 		switch (skb->data[offset + qmimux_hdr_sz] & 0xf0) {
 		case 0x40:
 			skbn->protocol = htons(ETH_P_IP);
-- 
2.43.0


