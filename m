Return-Path: <netdev+bounces-169432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F4CA43DB9
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD62C3B014E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D149A267B63;
	Tue, 25 Feb 2025 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXPSG3Rm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881A267B0E
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482952; cv=none; b=FFFEooWm/DtfICzx0TYeWpX6qNvnxiaLIBrZk+ws3EJ7nZhJKcUWbKBgX5WEfYIPAVriYnFAgROhBmjUSb9JT/Selx1KngoFzwLG2oDePxtwA7+j2Dqy7T36Eyvc4Q+YC1CbNmgriqYhD+74GuDPGT7+vhfng5pR9PQcz8t29DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482952; c=relaxed/simple;
	bh=4hG45/YxxUDAGf1kCmq/7SOok8aeW8YFCR9rk9+hyOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcVK42gmd/vldssyMVQkkoX/t4JLDsEcLqKpJmsmIdoiD75sqLYA4lHXd96s8PIAZ9eFJZmP5Mb5UDKW0nDEtbNVbwphu4XsJFQo2AnYS7NuJtd6V6NDhwJE/5oOpd6zCUTXitCvTvTmrnR3ckl6bA1j6wectv5rqULS8YK7Xgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXPSG3Rm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740482950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NSVvrnw9YXxB4JrmUbbeQ/j7AZVx0OggkSEwg3u9xAw=;
	b=OXPSG3RmVcon+QTGR/gnbvnNik3Rd0kP3dT2U9sLk//NjRk2/i0atOdCR0GcxH7lTld3PF
	EABC2mEAMMD8pTePwM/w/0ISAg2crt7qjWYMoeC2n+gqcGjKABl69pcfNwJ9ue8Mbu4TaH
	bEtN+0oCSlSnRlfmFH8alaN54Mc5Xtc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-dfUVcbLPO0ikpkhw1n8hug-1; Tue,
 25 Feb 2025 06:29:04 -0500
X-MC-Unique: dfUVcbLPO0ikpkhw1n8hug-1
X-Mimecast-MFC-AGG-ID: dfUVcbLPO0ikpkhw1n8hug_1740482943
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BADB1801A39;
	Tue, 25 Feb 2025 11:29:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.47.238.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E8DF300018D;
	Tue, 25 Feb 2025 11:29:00 +0000 (UTC)
From: Mohammad Heib <mheib@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net v3] net: Clear old fragment checksum value in napi_reuse_skb
Date: Tue, 25 Feb 2025 13:28:52 +0200
Message-ID: <20250225112852.2507709-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In certain cases, napi_get_frags() returns an skb that points to an old
received fragment, This skb may have its skb->ip_summed, csum, and other
fields set from previous fragment handling.

Some network drivers set skb->ip_summed to either CHECKSUM_COMPLETE or
CHECKSUM_UNNECESSARY when getting skb from napi_get_frags(), while
others only set skb->ip_summed when RX checksum offload is enabled on
the device, and do not set any value for skb->ip_summed when hardware
checksum offload is disabled, assuming that the skb->ip_summed
initiated to zero by napi_reuse_skb, ionic driver for example will
ignore/unset any value for the ip_summed filed if HW checksum offload is
disabled, and if we have a situation where the user disables the
checksum offload during a traffic that could lead to the following
errors shown in the kernel logs:
<IRQ>
dump_stack_lvl+0x34/0x48
 __skb_gro_checksum_complete+0x7e/0x90
tcp6_gro_receive+0xc6/0x190
ipv6_gro_receive+0x1ec/0x430
dev_gro_receive+0x188/0x360
? ionic_rx_clean+0x25a/0x460 [ionic]
napi_gro_frags+0x13c/0x300
? __pfx_ionic_rx_service+0x10/0x10 [ionic]
ionic_rx_service+0x67/0x80 [ionic]
ionic_cq_service+0x58/0x90 [ionic]
ionic_txrx_napi+0x64/0x1b0 [ionic]
 __napi_poll+0x27/0x170
net_rx_action+0x29c/0x370
handle_softirqs+0xce/0x270
__irq_exit_rcu+0xa3/0xc0
common_interrupt+0x80/0xa0
</IRQ>

This inconsistency sometimes leads to checksum validation issues in the
upper layers of the network stack.

To resolve this, this patch clears the skb->ip_summed value for each
reused skb in by napi_reuse_skb(), ensuring that the caller is responsible
for setting the correct checksum status. This eliminates potential
checksum validation issues caused by improper handling of
skb->ip_summed.

Fixes: 76620aafd66f ("gro: New frags interface to avoid copying shinfo")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 net/core/gro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 78b320b63174..0ad549b07e03 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -653,6 +653,7 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 	skb->pkt_type = PACKET_HOST;
 
 	skb->encapsulation = 0;
+	skb->ip_summed = CHECKSUM_NONE;
 	skb_shinfo(skb)->gso_type = 0;
 	skb_shinfo(skb)->gso_size = 0;
 	if (unlikely(skb->slow_gro)) {
-- 
2.48.1


