Return-Path: <netdev+bounces-223172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D10B5817B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B685B2047E8
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CE24A06A;
	Mon, 15 Sep 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgrCjP5F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9923FC49
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952211; cv=none; b=ufdcXx0XLYteL/E+OGnEdwTLgcPztbGHWSdONpKtGZ22BJB7DubSXucggmFrjL196D/RlRq/bt458n3LDiG6lUn5vPT5ONk2B+8SWZDoK75Tu/wL1VLTn7Mj+Mx4wAOk+tqXb5WiPsGJ4PfnLGi9E7RyfWswP12Ta7uyvoHmoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952211; c=relaxed/simple;
	bh=BAS0GBMKCDtwydPahpuw2HyfF0E/Y0qQ4Zq/+5p3ac8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1LOtCVGYOZiog9Q2CClC4TKX1m/NDEmCV8IWAmYTAtG9XKqxtPckdGe7zM1VImTb+xnxH9JG5wTTSuKTFa3r28zFnhJ8W/NEPzrndYYQNu5Zn7DYbiTQWEHF6rKV9C/7kG+Pt4oQnYBac6POj1rjVbKxe8qcielobkfp6tNx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgrCjP5F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eMxsZvyoTV3G/hm1yNnpqqa9WqA68QAPsx4b+ZiU9Ys=;
	b=JgrCjP5FIRnDZmRBEzRCAS45ljjKhhL/ykRg7IVvCFXJNQo6IglMnv4u81RHHyBqpr4kR2
	PXHW+R0mvCmJS78TJiPn/HcYhlfAL9LMSsfjKAIsbScblntbIGgSl5PRaW7nw4okGA4ecF
	5izbNlLm5lav5Zf3cMNOiG/8YDhTGQI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-lgybPU6uMkCfmlL-vgi0hA-1; Mon, 15 Sep 2025 12:03:27 -0400
X-MC-Unique: lgybPU6uMkCfmlL-vgi0hA-1
X-Mimecast-MFC-AGG-ID: lgybPU6uMkCfmlL-vgi0hA_1757952206
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b07d13a7752so406068366b.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952205; x=1758557005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMxsZvyoTV3G/hm1yNnpqqa9WqA68QAPsx4b+ZiU9Ys=;
        b=o7+c29+w594M20GoNH+VxYq2CIzN/nPM32JmmxX66u9LzNhw8UO2uENxts02tdvLG4
         8QTb8aN0Y6pn2orER3DINtvJrtoLriok7uk6uzbi+5tQSr/fqJuochWAIpFycicFlSXV
         D7ufWpyTf9FXCmB/gsOoj6kx+BpKf7U5+XgNLnncWophDWcts85HAjeTRQLiJs/mjELc
         z8DuRZumeWQoI3QM8w84318Y0nP9ndcqNlzDoiCCowJfvgfIlQOWpLJJzpcTL6c7tgCh
         u9r1VFJ1XVcPTtmjLn8VP58V+SyBMhxI33b4HPxZoQMk1K+vR7FRH3ds2eUofAsveucQ
         C9+A==
X-Forwarded-Encrypted: i=1; AJvYcCUIshzCchjbIQXRO8M7dtmU968hD7PqnxXd+yj8lP+REkARRrzpjihRGUHxruX8FOy0g14vzWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzSTzJ8vh3psmBHV2C4WratQBDa7Txie+K76hILM8W4jdjhOYs
	MbxdcwfKzmEjCzehxktVpU9TCCC2pK00aa6yX3N0n0q1tk5hRwNhdPSxA00Qs+TFU3HUMcQHduJ
	ECqzCSr0ejCWlOw3NkSpzTt0agt1wcqInlSRStJfZB7uqcNmKZPgtupmDcA==
X-Gm-Gg: ASbGncsq4moLrJM3X43tgsjJXUBlgaF5RaiR8egWRJrdKc6pWk89UVju7Igeo8ZQAFc
	jX50pMSo60epl95SUZe+oqpiP3PyCFEarBCntGjhjVUSxRRd1hRRxEOzUFVe59mD1S6+x7LmdLK
	opAI23tChfKMLZeGYbKrofgar4ETA9qBf2S6ARP0BsTmjo/hbCg6/Zed9w5yrNv3BWIcX/gtuIJ
	/78wIQXvNqBlrXEtOMvIN69ygUP2K6WGul6x1BG2R9Egplrfc+ba8cVPFsLrVdYuzK5V2H+wUuE
	UPAwFLiG+FUSIqMq01hWF6Af7sWX
X-Received: by 2002:a17:907:9408:b0:b04:97df:d741 with SMTP id a640c23a62f3a-b07c3867766mr1173786166b.44.1757952205421;
        Mon, 15 Sep 2025 09:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMAUdK5dLnmNqeaAzIQ4sLNIVdJ/bLJv6BqI8ieVrFaCmiktbN+iyKUpr58pZivx2Iqu/CNg==
X-Received: by 2002:a17:907:9408:b0:b04:97df:d741 with SMTP id a640c23a62f3a-b07c3867766mr1173783066b.44.1757952204919;
        Mon, 15 Sep 2025 09:03:24 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b2e7a35dsm1001013466b.0.2025.09.15.09.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, stable@vger.kernel.org,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jonah Palmer <jonah.palmer@oracle.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 1/3] vhost-net: unbreak busy polling
Message-ID: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
References: <cover.1757951612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757951612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

From: Jason Wang <jasowang@redhat.com>

Commit 67a873df0c41 ("vhost: basic in order support") pass the number
of used elem to vhost_net_rx_peek_head_len() to make sure it can
signal the used correctly before trying to do busy polling. But it
forgets to clear the count, this would cause the count run out of sync
with handle_rx() and break the busy polling.

Fixing this by passing the pointer of the count and clearing it after
the signaling the used.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 67a873df0c41 ("vhost: basic in order support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20250915024703.2206-1-jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6508fe0d5c8..16e39f3ab956 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
 }
 
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
-				      bool *busyloop_intr, unsigned int count)
+				      bool *busyloop_intr, unsigned int *count)
 {
 	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
@@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 
 	if (!len && rvq->busyloop_timeout) {
 		/* Flush batched heads first */
-		vhost_net_signal_used(rnvq, count);
+		vhost_net_signal_used(rnvq, *count);
+		*count = 0;
 		/* Both tx vq and rx socket were polled here */
 		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
 
@@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
 
 	do {
 		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
-						      &busyloop_intr, count);
+						      &busyloop_intr, &count);
 		if (!sock_len)
 			break;
 		sock_len += sock_hlen;
-- 
MST


