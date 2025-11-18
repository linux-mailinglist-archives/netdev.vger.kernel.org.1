Return-Path: <netdev+bounces-239327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E941C66EBC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BB9A358069
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AE2328B79;
	Tue, 18 Nov 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvGyitWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A6319862
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431239; cv=none; b=murUQbq1YW0ZDfqVRkvKjXccaEi+PUiuIAym6T5pjg/DjKSmos/o1u0cUq+tY6ayUXvtMt9l7FrPp+EEnoPcfkv7BIVV4X/1UaX8eh2bBGR3XyVe2sZe0ns4hS0FbLoyZ6Q9RIVtW2qIzKcF/hOA8XfkeRhiDIa+tVVNyG6lHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431239; c=relaxed/simple;
	bh=uOW23oUD888uPdfswggyv7h4B3njoPEFvMHwF6iAAmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGiWzrjUEUw7V0/cdwZdhI9eEHyIcYdqYut/z4AhzX/Jh+hI2UF7VnYVqHbKEJeyTZSS+8EDaLlUEHNmEnyidD5I2pJmMs+wKs8QdsWr4KMy0vxvw3nhRiOyF3ANgLlWIHKGUOmh6oXQ3GE+3UKPd7cufVZtefwfjslIG1r5iTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvGyitWm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so6142485a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431235; x=1764036035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhLUPvGLtyJcQ25GpVmgIbln5JiS+qaXLLDnH3A077U=;
        b=YvGyitWm5HtOLWDkacHtkEzVwBo6bLmw5bjRI5KahdU6vYZpie2LhsE7QRjfFmqpvV
         S1sg5FIzB3hunXYdxg+hCYhSEAgUXsIPtpwJXINmLFPJAPlzURuGMtG+a0TwuueynZtg
         NgPJIs2To4xQ0lc2YFdM5/Q8mC4H3KHf0wcgy5MSkk6oC9EynLVuPp38TwDBx2i1J4ZS
         30Xj+vjwRrDyfDdXluTBYdaZFK6rukvRYbcBdh6aIkVPcAYWOYKrHvrD6XC34IACdZ9d
         Q0kQllovX2O+ohhUwjZj+ldw2jfhzUrMKxBGUwYVoG4jQIeihUvdopAKjJsrsz59WBi7
         izwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431235; x=1764036035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mhLUPvGLtyJcQ25GpVmgIbln5JiS+qaXLLDnH3A077U=;
        b=OGTkQzRt8A7bRX8QBLn6IiL1oQrycytqet8iF5hMMiVHBf3KrzhGGgyaRYiQaf2DMA
         EIWu33AkXPcw7/8gEcW4X81/k7BuOxHrQ4yJdDEnjBzi34HuD9SDZfrdXZL/M18GRAZc
         bsJivLzHFGLR/RBQbcm+47WejKav7HwTH9PENWEGD+IOykVyFWnICLAj5nm2xXjePH2i
         WMOMC+rHiRp8IPHjeMm5LUy3AblCTOhCmEQdmZJv2yMeuAv8cwXS02gCidFLGqUivaqR
         zW+d3bZmNt1bJaZLCs2y8+zyyTaa3+xWywcbdPTaQWsiWzs4/hx8yNa+zp+ZOxPY8hme
         ZtBg==
X-Forwarded-Encrypted: i=1; AJvYcCVX0vmy+lsNJfWBT9uEFJwp0WlqaAHUmCXeRgW1eptXEDrAFTeudzImbn2NPOUflxT5cSpu7+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcUlVaZWyo9gqba5PqAIOYjI0OtQJQm3GPzZEmn2oeIUXC121I
	n3cPtGh3O0vb+/XQvVoksDE93RtfiSQdxrMpsXA86D7HP3MMBS4Y0D1x
X-Gm-Gg: ASbGncvnLIBh12GJOqQk3elxyRE+bjJubRa3EaTm3NXYUiI0kG0U0Z9MExyLG9ArW+s
	vIgQtYdU/bkNX4XoFBJX9N1le+Jz+4zs48XpzM5OKpIx2ZcbjANXweTcyVKhludE80Bs/Hnt5ZA
	8H5JuYxeGeKbmx+ggmgSsIZrFvWFXhWltifPsQcE1+1cPQdYfiykzwTBb1o0e88Y0sEfOHVvESv
	QPgq2fuYwskGbZGy7nPONzs/NO0u6wDISzk7tgEyr0umBm+C4gXPOAeZnFgK9SObFQO+How/dnc
	RjEAbZ7pqtphyKgO3jrxqJmSRGgHMrK78OIjEwq+VhPueY42w5pIx/6iYoxu+wlUz0zKfJdB/ZH
	MTJnbqLjdPKQza9ZfwXkOg2+nhkkHCFvV7w7reV4eILVto7mqCA7YALxc73teVmwGA/OKI/ZCUT
	VESrqkbuZgaULbmQFRBV+o/j6f76hfmQ==
X-Google-Smtp-Source: AGHT+IHLky6hFd2s4o/LoM/Lst3F8klAMSAkgSuH9Ql0+UHi5g9wFfThPyUZnxKhdSO4j0xQMtxpww==
X-Received: by 2002:a17:90b:2d05:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-343fa6326e0mr15954772a91.21.1763431234714;
        Mon, 17 Nov 2025 18:00:34 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm20082011a91.1.2025.11.17.18.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:34 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:28 -0800
Subject: [PATCH net-next v10 05/11] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
In-Reply-To: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
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
 linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v10:
- break this out into its own patch for easy revert (Stefano)
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 168e7517a3f0..5bb498caa19e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1181,6 +1181,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
 
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
+
 		/* net or net_mode are not defined here because we pass
 		 * net and net_mode directly to t->send_pkt(), instead of
 		 * relying on virtio_transport_send_pkt_info() to pass them to

-- 
2.47.3


