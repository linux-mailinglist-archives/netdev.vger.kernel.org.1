Return-Path: <netdev+bounces-223174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55EAB5818E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D3848759F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ABE26A1BE;
	Mon, 15 Sep 2025 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsB9wMXK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45EB263C7F
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952216; cv=none; b=aUGVi4rPMC1Lqpc38J+my5oEWtrzUDJYF0y/4TlbhRTGGDKrKv90xKjYrM5LgebOpbnzAlLpGXm31rbflr072vcIcDKFu/PDD+0Egl4fOAMjWYGKEvJhvTPhJnTi7oxNl2+e51BD9w9dQ+bPkp6S5RbJfqiCH7ToteqIYdI0oak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952216; c=relaxed/simple;
	bh=lz+21+pXWAdvl2nNDlkXW3ZFI2U/V3++gCtr1F/cu+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0NTYTLhpUJ+qnveFVY4+qfbzUyvxXa3pKkVb7z826eEleQu8ID3whEXKtKGSAS28DAIAVKD5UF2xpbxvmPVoP81UwSDQ1+OCMJyVG0U3JhrlsAwqO7MLL0nRJPcUtdoD2HXA4hNDl6r9oP0QAwx1FwYs06nzyAOfEOiabCNMnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsB9wMXK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyjSpWLvfqnwtpmHwJJOxa1B89j7LM2tZ53OHGLbRxs=;
	b=gsB9wMXK+0ghL3q7a/L5hYCT42ZoFaw016gabU6JxZMqPN4g/bZL0KvgGkQ+hr+g4s0Y7N
	uD69kk6iFdWwGesLC2YWzzeV1yRJ7CQ3uJJ2dzgMgJ0UGHexCoE8bBOnaGNILo7popICzv
	Av0mngneEKamVoZROGDHWRIk+J7gi+Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-1QmCskT0NNWY_2CrXpjbXQ-1; Mon, 15 Sep 2025 12:03:32 -0400
X-MC-Unique: 1QmCskT0NNWY_2CrXpjbXQ-1
X-Mimecast-MFC-AGG-ID: 1QmCskT0NNWY_2CrXpjbXQ_1757952211
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afcb72a8816so328123366b.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952211; x=1758557011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyjSpWLvfqnwtpmHwJJOxa1B89j7LM2tZ53OHGLbRxs=;
        b=saOWNssSHX0wxdX03xxuH0t6p7qLL1SVCmP/O4zNej4y+q2mKLtZeiKVej6bjkRcSK
         bzt93heXM5SZIM1pxg4nDBR7E/KO/VFxIfP6lNI9Kr58CabV1065toMSxe4Y56uQ3Etu
         8mOjyNlgS9FI8c+6JN+c5tYCeWawDUByV3c3eZHKLpka6LmFujkg11muY083SqlrvMhM
         olegzg/aS6X3kXSh0OAGSl8x53/Icnsf+pXq2zfnbzVyrtYGEjzC8dJKxDWjDmPLJrc3
         TPPSnku0mjBxX1Rwb9W3qxiEHyVhyvI2raHgdNmVpNyFEixIXFUY19z04QrCwJp+kjBn
         0iwA==
X-Forwarded-Encrypted: i=1; AJvYcCWY6sQnfWrKczDIYSHTABtsvooNeTTx+guf3+NGGzkMUotsi9cv45snbywXvC+iPNRBxHYOYm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMk69AVGB+rVqTdtzWAtFZGjXPa8aoSONLYpLxzipYlOaHMSbh
	x3PWGlmP4nbrW5BNLtKocwCFmzs3x0jjOjMBKQRz23V74VmLymEuYqkpfOCqUUsG8moBOdhKFnu
	RvPiZvPYbFZvkqUf8QsSZB6NjL6rAccAYApuurjhEPz5hWHMnsxt2EuSx/A==
X-Gm-Gg: ASbGncsfItZd2sKjby257mYiHKwZ3ch0e0ksZTbOnlqroVmAGNrhJZ83CoG/gZwGal7
	+Wul4Cp5nboRdym9aWthHzNppI0w7zRZqDp6qidGN9KK0/if48Ap7wfVLDXs2/zw3s9UWM7dJ+p
	oxIbKheW5quCAreETpXBLxyNRFoGjD0vB8H36Fo2QjPwu7vWeVOhYN4C4s70hIjsJtWYfpHF15v
	yUTiffYmcEYq5fyiUDvvp7w7oshRL2zvVENN8wacRI3reLJFpDDY7FWtRLhtC+RBZOyD6cp1sk9
	TtSls8NpGPDQbPNFNF8P6w4wPCH9
X-Received: by 2002:a17:907:d16:b0:b04:3402:3940 with SMTP id a640c23a62f3a-b07c35d4d02mr1305642866b.27.1757952211054;
        Mon, 15 Sep 2025 09:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNtSBH6QlKSIfQdtkhP6WbRqJLxZsgUpRv3jEYGQSqAMd7B74yXmlLS/60ot7X5iMC+KioIg==
X-Received: by 2002:a17:907:d16:b0:b04:3402:3940 with SMTP id a640c23a62f3a-b07c35d4d02mr1305636166b.27.1757952210298;
        Mon, 15 Sep 2025 09:03:30 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd413sm988048866b.71.2025.09.15.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 3/3] vhost-net: flush batched before enabling notifications
Message-ID: <7b0c9cf7c81e39a59897b3a76d159aa0580b2baa.1757952021.git.mst@redhat.com>
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
out of the loop after the vhost_tx_batch() when nothing new is spotted.
This caused unexpected side effects as the new logic is reused for
several other error conditions.

A previous patch reverted 8c2e6b26ffe2. Now, bring the performance
back up by flushing batched buffers before enabling notifications.

Link: https://lore.kernel.org/all/20250915024703.2206-2-jasowang@redhat.com
Reported-by: Jon Kohler <jon@nutanix.com>
Cc: stable@vger.kernel.org
Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 57efd5c55f89..72ecb8691275 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -782,11 +782,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		if (head == vq->num) {
 			if (unlikely(busyloop_intr)) {
 				vhost_poll_queue(&vq->poll);
-			} else if (unlikely(vhost_enable_notify(&net->dev,
-								vq))) {
-				vhost_disable_notify(&net->dev, vq);
-				continue;
-			}
+			} else {
+				/* Flush batched packets before enabling
+				 * virtqueue notifications to reduce
+				 * unnecessary virtqueue kicks.
+				 */
+				vhost_tx_batch(net, nvq, sock, &msg);
+
+				if (unlikely(vhost_enable_notify(&net->dev,
+								 vq))) {
+					vhost_disable_notify(&net->dev, vq);
+					continue;
+				}
 			break;
 		}
 
-- 
MST


