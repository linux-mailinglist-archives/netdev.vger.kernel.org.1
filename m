Return-Path: <netdev+bounces-206797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96377B0463C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 19:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6560189AC7E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BA9257422;
	Mon, 14 Jul 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ir2Z9P8f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264B635942
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513187; cv=none; b=NcJ4T3NnmJbRs89lVmtn5LDl+CaeGRUFDgwDslLfT+DDbaYafidKKRgHzaPoqDGvqMZB6VT/S/fdbXHjYG0+WZ63Hw1tnC3HEvxFN/1K6Y2KBh4YZ+dLX81YHpN6RLjU/j0lcwtSdHkLNQx20UW75cci9PJ90GdGTAqkd9PbplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513187; c=relaxed/simple;
	bh=5yDEmifGkMqaVMC1duBRf+OCzDdy9L+jepzfvMyLRF8=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=OFmUFeSPLAHxPzOaIbUDoBPoRs0Vjj2VYeqJDCWX5Ow5i/Hjlr7Pbi+iCGL50IBQNm2RqP1t1vegCTxZefU+4dWBLGK+UIUcaFm1cCS53xxZZA+qk+F/HmwV6uSPKNyjlNucJKbGTV62SRca/KcDgVFXhUd0xyDj+UAbIe+P6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ir2Z9P8f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752513183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DSP3Fzcx4Wu10HLkpqSVUIAj+VuZ78bxyEPiBAJqfJw=;
	b=Ir2Z9P8fY5O6+8bRCnxfMUuHckvX8QMut2MxYsFPeQifiVuhrtPvv0j1opej0vfWq+oBg9
	VB1DBIAq3xc54LikhYfvSDNmdrfQLNSqtunsYcnnpqXFwIyr8hPdl+zXp+GICe1aD4QlTA
	tech7YB/ogcN8S6LoQ7SVpo8cHvcd2k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-bIeWGtZpOAa0k2af-YIQDA-1; Mon,
 14 Jul 2025 13:12:58 -0400
X-MC-Unique: bIeWGtZpOAa0k2af-YIQDA-1
X-Mimecast-MFC-AGG-ID: bIeWGtZpOAa0k2af-YIQDA_1752513177
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A292518089B7;
	Mon, 14 Jul 2025 17:12:56 +0000 (UTC)
Received: from [10.22.80.10] (unknown [10.22.80.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92FD318002B1;
	Mon, 14 Jul 2025 17:12:54 +0000 (UTC)
Date: Mon, 14 Jul 2025 19:12:48 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Sultan Alsawaf <sultan@kerneltoast.com>, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>, 
    "David S. Miller" <davem@davemloft.net>
cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org
Subject: [PATCH] wireguard: omit need_resched() before cond_resched()
Message-ID: <5da9fced-67f4-3e32-76ca-b8a5be3b962a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

There's no need to call need_resched() because cond_resched() will do
nothing if need_resched() returns false.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/net/wireguard/receive.c |    3 +--
 drivers/net/wireguard/send.c    |    6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/net/wireguard/receive.c
===================================================================
--- linux-2.6.orig/drivers/net/wireguard/receive.c	2024-03-30 20:07:03.000000000 +0100
+++ linux-2.6/drivers/net/wireguard/receive.c	2025-07-14 19:09:52.000000000 +0200
@@ -501,8 +501,7 @@ void wg_packet_decrypt_worker(struct wor
 			likely(decrypt_packet(skb, PACKET_CB(skb)->keypair)) ?
 				PACKET_STATE_CRYPTED : PACKET_STATE_DEAD;
 		wg_queue_enqueue_per_peer_rx(skb, state);
-		if (need_resched())
-			cond_resched();
+		cond_resched();
 	}
 }
 
Index: linux-2.6/drivers/net/wireguard/send.c
===================================================================
--- linux-2.6.orig/drivers/net/wireguard/send.c	2024-07-21 17:40:39.000000000 +0200
+++ linux-2.6/drivers/net/wireguard/send.c	2025-07-14 19:10:03.000000000 +0200
@@ -279,8 +279,7 @@ void wg_packet_tx_worker(struct work_str
 
 		wg_noise_keypair_put(keypair, false);
 		wg_peer_put(peer);
-		if (need_resched())
-			cond_resched();
+		cond_resched();
 	}
 }
 
@@ -303,8 +302,7 @@ void wg_packet_encrypt_worker(struct wor
 			}
 		}
 		wg_queue_enqueue_per_peer_tx(first, state);
-		if (need_resched())
-			cond_resched();
+		cond_resched();
 	}
 }
 


