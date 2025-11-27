Return-Path: <netdev+bounces-242183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D02C8D33D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5191934C220
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5831E10C;
	Thu, 27 Nov 2025 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg2d4qYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05385320A32
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229671; cv=none; b=qDl6IPAaIn0k2Wkxul9WoX5cYQd0OfayLWlEkkQ39MFIN9JjxOns67WoKjjpHXhv0aox3XOXxcvZcgvtsPvmW9DhBMIPtIl/ROapW1B/NYDQWycqYkp/5YRh8Q2ZDzw/gzaafNgC6goqNHMsmdsmlUXXF+MqYSiVsg57K5DtqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229671; c=relaxed/simple;
	bh=ngrprkAcK9o71FbUOC3NZ7RyRN7JcMdikXQcWlHlTQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFHermBE0ytaY7hrST80AfEaKCqqL/6/yWGM2dw6AUyJsPkuz66MWirQhQKdMztjLDdBiMY05Q3WB9TzRYXdYHV8vd9PjFsPs3ADCcr3gSwjGy9S2SiKXbgsPblVte50d5Uf9VpPUUxjp9pM2Fs/Eqyfzn2qBH5nGpYsaYgkWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg2d4qYg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297e264528aso6608085ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229666; x=1764834466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdjtlHAU46wbJRJNPh2vrdaHOqMf+PZ2xHKsN6+qWOY=;
        b=Bg2d4qYgk4kfYwNa7AycPQ6XdzG0m+Xy8oyitG4OwTE2NwZagya760K7hY5R5Vjg1/
         hX/n1f2olMhz5cuBDb42gdnShH8CO2PV9XvRebWO9AMBwHzLdjtfcHIorRG0LDAfRCjx
         oU7aX0NG8YyNTjvPot7GzMPNLgRrLkLLOaQ2a8i+dDodGHFfB9OFmwJtLNZUUtFJkX72
         6/NgTYo/cSOgFsHQDlLua0/zQ/6VLsy1K0xV5kk0Ws+YKX0ossqfIoenB5GTiL0j9Oyg
         vL6MATcuUT+gRp5TLbDWx2czYqlNAXYfqCYmRjbMBEBBfkSANgix/QB5VMZdIKK7/dwX
         qhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229666; x=1764834466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wdjtlHAU46wbJRJNPh2vrdaHOqMf+PZ2xHKsN6+qWOY=;
        b=xDJvgnRKZfHJnygIdBCdj5SjssEYwamHOfVf1caH3QwV0dllkjXwObas3S4Ct/6sc/
         zHSFL7Jo4F7GAxRxvxI/TLSm834MGwyeTJcpJRr9Wo0rf5hDKpLQHV72CnPjwwkcwpBV
         /vWuTMPxP/fapMzXILNcYhCXGq0f8nbDHaIoBAXxLmkPQltId125NP3vlrc2Q95+6G71
         lXvW+eWskrME754SxSAYZA9W893dYffrL/imRNCsrHeHn200BDoMHEjBTQSQ8Tqp9jEo
         Nr9e9wXil295oh5R4zIYcLIZg+fxvS1ev4FjfVkNLfaziDMD9hKWci3wLIDGB3Kv1Ei+
         YcYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7eRNIWsniwq7F9W7x3Qbd7X2jRUJHg77MiQn9DHUIrMNhGeiI9EAg6PGvANEj7yAIidLnSfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nDaP1FBNAud41BZRYjJrIEIHZpcCjABFY26lu1FAgVUgKcQt
	hFR7hude7iq1Igt9hLBXn++dTu9uUC2RFSDziUBCrjC1X0DdJi/CwUDy
X-Gm-Gg: ASbGnctd8BLLEv5wHl6jOd9zwOSCsAwbCK0BhlTJ99qBoyatzg0KyjTUNvR+Q6GaSYy
	b8ozb1HYCikWP8VlETzt05bH4rUqJ+TCcneEwepQdKTdDYq1ed9//M0OJf3TX6kUVQyzr5t715N
	R5igvqMQm4UolOWu7URTZyVoohzeXyd6R1G0vCGAvhv4wLReor3aW8u0QjsYI5f5RVfHvBfKxxM
	0EpXqyReXrLidQwA7n6i8zXsUJa7LAwn1jdEDRIxc4RpHAZlNxDyaxjmrmdvaUliW7apH3LoCKr
	bxI9WKsJ88wNolrNivNSQRuvW09zsmgNAY6jKuyZ4i7DjraLEFyKVUzAbWKJz+rsQWT/iW4Jgkt
	PKKji4qe6N4ZJ7KvOq9awODiBIi1pcRa0zW7bANP5Fs6ASlcyrQAtq12Cfd0EV9kW0BKc5gmJSs
	bROwbUhfh1VdHKfbCfCoU=
X-Google-Smtp-Source: AGHT+IFYvO1UtpbFl//by/z1SxVW3RV5sMUL/B4xccNDs4++DXCvOjc0LlmnAs3s4Ij/sBDaAEebvg==
X-Received: by 2002:a17:902:da82:b0:269:82a5:f9e9 with SMTP id d9443c01a7336-29bab148972mr111949915ad.29.1764229665894;
        Wed, 26 Nov 2025 23:47:45 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b1cbd8csm965410a91.1.2025.11.26.23.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:45 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:32 -0800
Subject: [PATCH net-next v12 03/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-3-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Associate reply packets with the sending socket. When vsock must reply
with an RST packet and there exists a sending socket (e.g., for
loopback), setting the skb owner to the socket correctly handles
reference counting between the skb and sk (i.e., the sk stays alive
until the skb is freed).

This allows the net namespace to be used for socket lookups for the
duration of the reply skb's lifetime, preventing race conditions between
the namespace lifecycle and vsock socket search using the namespace
pointer.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- move before adding to netns support (Stefano)

Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e6391eb7cc1b..de71e2b3f77e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
 	};
 	struct sk_buff *reply;
 

-- 
2.47.3


