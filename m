Return-Path: <netdev+bounces-250655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C1ED38852
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 22:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4E14300899E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B3430B51E;
	Fri, 16 Jan 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqwvUnlN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DEE3064AF
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598947; cv=none; b=r/ryw7w9XQkSqwUO8Exhup7BuIOZzJVmnlqZApf9iuoCzbG9JHlaAO++zb/jE5r+rX3vs+9PSMLRrzeLT8ez6IYrS3uQ6EZLgKE48Op9Ypl1oHzHKY/MOFGHxzxbjQbCSpPnTVUa6ZUm0sAnk7QJeEDCyH8nRqrYbfNGq8caePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598947; c=relaxed/simple;
	bh=vD964Lj1wPSOw/16ssWykcRPX0KDwrhlz4wvw7+NTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lP3gcQ3dUmsbHFzfSL01ZmuODQz9DylhY690dSD2DwgdaFy/RzwXtyMcvUlsP4Im2MM8Z/HyZMhkXiumcLJh2+Ch3I7YmArJjcSWtaJbKBVH7HwBiAduoCtpGb4CtNBja6Vi3Cvz7uWbqKZUdRwcgRAN2zi2pNEj/n5dWZ8aGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqwvUnlN; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7927261a3acso24616157b3.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598944; x=1769203744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=BqwvUnlNPCKikTxYdL+5w8XOT82LgQ0+ssDXjKCFsQOiOEKeiqpdAFz8/CE93RQl5v
         /GVKF15nii0G6eKA5oQ8s22PMA7hztwgG5qgQDLIW3i5knksl747rL2nTy6hhVXHGHFy
         vQNhM17LwHRwZEtAqwkm6d5i5P1xIbrGPD8eDjNZCCEMNSMK8p6XUwSj1NxI0l7Ym5ZV
         S3Lxo/tw3O96guydkObG3nLyxKn7r9U0oaRjAvCLmJ8qQ1uCYYurSraB70Sj03AnAvXI
         WkOkTK0q3z508sBiWTyQ8VqmEyUTD1pndtwVGYmkBN5icbbVkvQOfNR9KCBiKYMzS1wK
         NxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598944; x=1769203744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0yb8kb1LkqAc5YpKYa8ha5gJygHDPK65XDs8oEX3qw=;
        b=Sx5m0KLr0FcHg7UMVvvu22EbWbTZu6Vnrm2BJEOibHdvKoapKxirb/m5ak8K0G9d+z
         /xogAk/j8kiw9bUfwJvcdA5swyxIhYnUBWoNQC4s44wWJpVR0Hu06qHdLBOiGv09tgIU
         7y8OerE8QU/lDLY3XpcWTC0TlDFwwF3tUkQJtbEDkNxXIkXmkVjKnhszs6lTh55Mj5zS
         1IZryaUjmgTFQY6oio7vORUwJ7KJaaLQu4ZzB8ZdClJsDQ2Qd16UqCaZkNHVxOw2pexn
         eP4u6EQHdc69gVXn2gg+AY30xNx+ZKZepckCse7Z21D3KSg/G7gtTHa6E7DRXd1inlZ0
         6KDg==
X-Forwarded-Encrypted: i=1; AJvYcCWPrO4rwOYcoCmXOfIUHhZ1evZlRKM170phYVTLpXM1fuA4CZDNuKWsAIF+NemVUAC47ySpKTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCU05oowpK5hy7p35qK1dCwN+LrVeci5zbKj9WtUPLcjEUa3+6
	13RYSMIwmHR7MjQMX4Eczrc99HWk0aTL0S65ViB3rKeQYvARCHjgqi1k
X-Gm-Gg: AY/fxX5I7VeWYSByC8TP+XGeFULJJeFHOww06D1//hrQIJpCp2V5H8Qn0fHO+gdJRqQ
	rsSn2AG+sSOnx/F4lXLgIZmt68nhZzqHfwu/P0V+ueG7syU+XEBTwWkFxg4pXtLjvpfYOJu5N9f
	uONeCv7S0XqkenzbYloZEy0byydS4qhFAW2XWrYRiwVKHtNqUH4axkPFIm711jiCrDPlIoOS+wB
	AATO+m6RnfYncS10PKMZCMGJ+mAs7p0E2cFjfs2U5ADUv7TmpP6DoUKWRVmWDKx4orUrqAwgfFG
	l71r2K53C6NBwP0l+yJMJrLhyigsHj8VszRnD6CLHrmGzJ+rnBhYaTHYDlbhtHnEnT6Ysc4whGo
	+aX9xR3pQMIF+3lcazOLnj8M8b9Mt1jzEy3iSahXTJbf5ppN3NTW8LonHLqoWTOjHfcI2M0M+80
	x2jLESXJmqRQ==
X-Received: by 2002:a05:690c:39d:b0:78c:2916:3f0a with SMTP id 00721157ae682-793c66b8eb1mr33268517b3.7.1768598944439;
        Fri, 16 Jan 2026 13:29:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c729fsm13186297b3.12.2026.01.16.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:42 -0800
Subject: [PATCH net-next v15 02/12] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-2-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
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
index fdb8f5b3fa60..718be9f33274 100644
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


