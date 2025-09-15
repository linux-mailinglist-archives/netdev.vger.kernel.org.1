Return-Path: <netdev+bounces-223173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E651B5818D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F229E4C09F1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49382264A8E;
	Mon, 15 Sep 2025 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1BB0hQG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFA2586C2
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952215; cv=none; b=UQZmqqBUjY06cv+qcItWI3zzKNsPMUuGxVKTrYAbxQcKBTL0KGCYF+uZCChZfQTwAx4OVfkzQ3W4AYFDiV0R+V8nCnmFDWnyPLQHLJux1fhhm8GE66/+S0v9BGZo07Z9Kh5ffug6012Da5u635WKJ4+pujaaG2VBQAjOQmuo3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952215; c=relaxed/simple;
	bh=Td5X+XiMVh4U7xnk374qdTWdLYQJomqL2LvZMLkRmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMKaK24TZrZozYlqHjvhhmV+lECHzIyXPr4E2D0IqMD88TtjJrSHj6cRDlIkd3+9zUIc+U9Y8lMcB3zCi5ppwchBsLDxjH2iQtzJEM5QaJApt1OW4fmxOJrSKr2jNsvn0JNw9nMIp07Ef5O6B93SMc7NcHTnCfU01srBUZD1dJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1BB0hQG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SwVQfN4OpfJrsdY2VoqmkkTVqEBYDZduzuqg8McG+qs=;
	b=B1BB0hQG4FI76/qeRODjXBR8t1XvSExOfuw59KScH8zZoSMK0/Xf5iRDPG6pxXsS7xvqKZ
	sA4iWITlEv818JrI7ZbbDO/nQMevLcXf91ghvFtWHqE1vslJUUZoyZhBa+pOdcMTdg8vUL
	pFSA4DfnK46dLuSPcdhrTvSZOlJD7Wo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-hzlw9FG3PBmd340QpiBYeA-1; Mon, 15 Sep 2025 12:03:29 -0400
X-MC-Unique: hzlw9FG3PBmd340QpiBYeA-1
X-Mimecast-MFC-AGG-ID: hzlw9FG3PBmd340QpiBYeA_1757952208
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b04271cfc88so328557166b.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952208; x=1758557008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwVQfN4OpfJrsdY2VoqmkkTVqEBYDZduzuqg8McG+qs=;
        b=V14NeB7ouLQWb8Ju/xyCBQq3UHom5+phHLizsqYBD9y9jv6XnKMzeG/orIapk4vfFd
         L4QUiVqTV5aGZ85qDNlhoWaTHs+ttBb+F4hL2qRZVvphSEGcOLnhvGIi24DcPiYip7Dk
         YBmxqNmKqYLP+IcrpVd8SpO/auQKcxobPhhOoThFsisalrq7lC763XAI+HEwfLavb4qd
         xIwZQwmgumwNSBHPggmE4GGGDPFuPPAuouI+wljHduMXbH+XOEdw3OQCPGlo7d6EGLMO
         +yYjx6kr7Hj5kEEGSAq9ySmZB8gsOZs22tE62H82BW6e6kSScN+2V9cNnd5kf/wVpfLt
         gXcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpb+q2mXmay3UPH94ZJWd3GLFH5sxAq6wYD6jeZsWhFy681vF/HQlK7HziuQy6ySc/Tp6gaA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsUFz/85CffK+IaOsI8kTKHCrvMue58AsHThy0PS/NRHeQDWXV
	/ovfA1pFN31YRLNxkp4l2WOI8u8p7y0wicr2oEXRQL/lWSeVGcQl+0XYS+QQKhfq+NONlyUqh3D
	6u0DlTrN0lLvDDPc7Zs5eKjEFrLiCjMmrLGSfZV/lrOoqX1M6DdtCGGiOLA==
X-Gm-Gg: ASbGnctbd7tnfDkU1tKaonlWEjDGslptx45poTl8WuiWhgeOKnjBJi35y/J+SbVIZzE
	qr6UQuAU2asc+Elp6GdtSJA8tq5g+SZ+vi3QgTBcO8DIxCPKJqdFLbK+TiT12EWnfrBzSI7bBJM
	pNyKciWU+5+mlMnktW6FodIzpfsVYPOqzx6BcYqG4zersVCla5TEr7fObEul3w/hgsm2ChmrPEW
	oktD70G1UhaRKqiNZ2mqKKllfJ4ekvX7R5g7+Cb9kfpeI8hZ3z1GYVbjsLRhnNhb3P6rbbv8Bp8
	zvRnsEiETcOV/4fucX13aybzrdz0
X-Received: by 2002:a17:907:2d91:b0:b04:2252:7cb1 with SMTP id a640c23a62f3a-b07c353f091mr1403697366b.12.1757952207952;
        Mon, 15 Sep 2025 09:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHflQiZxxzDRLnw+SKuDwn0eon4gL/iAAz/hcWcH2BNBputbB1OvgE3pkj1W+m1ugIR7po3zQ==
X-Received: by 2002:a17:907:2d91:b0:b04:2252:7cb1 with SMTP id a640c23a62f3a-b07c353f091mr1403693066b.12.1757952207517;
        Mon, 15 Sep 2025 09:03:27 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f20dcsm963017266b.90.2025.09.15.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:27 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 2/3] Revert "vhost/net: Defer TX queue re-enable until
 after sendmsg"
Message-ID: <45c47a7a1c4790275763b2147c220923b9e59aba.1757952021.git.mst@redhat.com>
References: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
sendmsg") tries to defer the notification enabling by moving the logic
out of the loop after the vhost_tx_batch() when nothing new is
spotted. This will bring side effects as the new logic would be reused
for several other error conditions.

One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
might return -EAGAIN and exit the loop and see there's still available
buffers, so it will queue the tx work again until userspace feed the
IOTLB entry correctly. This will slowdown the tx processing and
trigger the TX watchdog in the guest as reported in
https://lkml.org/lkml/2025/9/10/1596.

To fix, revert the change. A follow up patch will being the performance
back in a safe way.

Link: https://lkml.org/lkml/2025/9/10/1596.
Reported-by: Jon Kohler <jon@nutanix.com>
Cc: stable@vger.kernel.org
Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 16e39f3ab956..57efd5c55f89 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 	int err;
 	int sent_pkts = 0;
 	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
-	bool busyloop_intr;
 	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
 
 	do {
-		busyloop_intr = false;
+		bool busyloop_intr = false;
+
 		if (nvq->done_idx == VHOST_NET_BATCH)
 			vhost_tx_batch(net, nvq, sock, &msg);
 
@@ -780,10 +780,13 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 			break;
 		/* Nothing new?  Wait for eventfd to tell us they refilled. */
 		if (head == vq->num) {
-			/* Kicks are disabled at this point, break loop and
-			 * process any remaining batched packets. Queue will
-			 * be re-enabled afterwards.
-			 */
+			if (unlikely(busyloop_intr)) {
+				vhost_poll_queue(&vq->poll);
+			} else if (unlikely(vhost_enable_notify(&net->dev,
+								vq))) {
+				vhost_disable_notify(&net->dev, vq);
+				continue;
+			}
 			break;
 		}
 
@@ -839,22 +842,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		++nvq->done_idx;
 	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
 
-	/* Kicks are still disabled, dispatch any remaining batched msgs. */
 	vhost_tx_batch(net, nvq, sock, &msg);
-
-	if (unlikely(busyloop_intr))
-		/* If interrupted while doing busy polling, requeue the
-		 * handler to be fair handle_rx as well as other tasks
-		 * waiting on cpu.
-		 */
-		vhost_poll_queue(&vq->poll);
-	else
-		/* All of our work has been completed; however, before
-		 * leaving the TX handler, do one last check for work,
-		 * and requeue handler if necessary. If there is no work,
-		 * queue will be reenabled.
-		 */
-		vhost_net_busy_poll_try_queue(net, vq);
 }
 
 static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
-- 
MST


