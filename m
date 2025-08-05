Return-Path: <netdev+bounces-211649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0B4B1AE22
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 08:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD19189AA89
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 06:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54EE21A420;
	Tue,  5 Aug 2025 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxSf78xU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D375186294;
	Tue,  5 Aug 2025 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374854; cv=none; b=aZPdpueIvnkeU5QGeiqtT/DoCbcsd4wKe8EcGmj4tLgvYxOQKpg2oYbVnIp+RXzou/Ik7EO/q/jN11VrQZl0A6Pr5xGXalyHTAIYSEYH5suzeMX1XFIoaCjSzWeQk2axoKOG9zwYKPegitzqzK/lpTxP1/Y88vPsxIe6rc5s8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374854; c=relaxed/simple;
	bh=HU3EoErcw718HgQs6DMndFnBksuEYx4Ps3O8g3pWdi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b73Qc+iAAanwqqdrq3vtpdbfg30KRgdnQXa4DZSLPMYrgO0XRLJh5aoDf+DwvdVTgj4IY98W7VZh1JYOXU8rWK0s4W301OkselCWX+mxTkrzxGkR3Y5pe2Bwb/lLcip2cjTdzpF9Rw0uQYRuwB33/h/oH8oluRV36lwEWJpZ6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxSf78xU; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so3779396a91.0;
        Mon, 04 Aug 2025 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754374852; x=1754979652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxXdvCPPZKEryeBHh/ilhPWl4SN2qoBiCBLYJe9cq58=;
        b=dxSf78xUTwDt/x9XmyL33jVkaXD9MmNEQtpmR2teXOSQAx6YzoT/g3Nm8zSyV+V6WF
         5P5QKCk2l9hB/EE9b7o3DVSDgDOdD/c9NIXtrCtOqNtjcZ99pL0obuV8EX3sta0c1F4e
         GrNlDD0RPyT+X/SnbIHzuqDjVy1nK4S3yjKiWmONTduLPACqUezwOPXNnc/jKPeKbt5g
         c99Fqgzj2VNzHRKoha9Fje0DevxNyAf7UQvjkNZ906Tt9tb0DpEAwYsVw49GTfFjHT6i
         0UzraqolW1t/SwmoZoT/gdot/njHxsgF4P4lNp1UpA1WrbiovJvizjIdvwn0XybePL/9
         8Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754374852; x=1754979652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxXdvCPPZKEryeBHh/ilhPWl4SN2qoBiCBLYJe9cq58=;
        b=q1JiBiPrGwwH/2lw6c4uudLPTRKXfAcLz4cLMY8zDA37oH84lWNo4MieAj5vDFmR1w
         4Be6Ba9XbMd+++7D/C9ncef9Nm+3LHSSxHVwuavgPZBaTGwuydaedeBEUWD6v8iVosI/
         8h9MmDf8RBnveIMAmTgg2xjz/J6pWXa+vYgDuyTZqtE35dtV6SypNklNGfNRdMaoCiJm
         iJt4SKu581SCR659KGd55n4ksn8MRzxscNpfKZ6d3+WxejQQoqPe1RbJmMLJ6lK+Q+B1
         Qj6d8ZRfjMc0OQlM4Y2OT76sX0hUrsQllDCjkE20NXy2q6krxYpSSUolDjsdjyIKNezF
         uJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsTHhJz7IQ7CqvVUd299TTSZHgTGuYabdqEkTEjTB1b5slmTzoYbq33AAMq2P6LqAy+bs/vww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/0cmACMSYhHALMV6BwbLe0xZTynizMtWqIElV+8CbZxPe33/
	DjpzGpgDM0y+9ca3Ib3z675UDC+FDE9/hXjscu91tF/FQcTcKhjDYn0Ve5VKtEcfE8c9Wg==
X-Gm-Gg: ASbGncu9HAqltTVijTERfZ9eMrTRo5vnT7VgWfRx+1IS8UX300ZdTSWVzqLBQZvNhNh
	C7qXnTmB7IMjn09oD7IV0N8GCnnCTx8sn5sFbajTu+ohQcv1WrtyImlVZUM3EuFCiEHq3lSBF+L
	nfBX7OncHTGWdCBft5clsCWE7Tqz+KVN/EsH1toC4kHk2CaGvoXUQbAUdiCn8+KtR8XrK9F1yFS
	mn9WHdig08NTVBAaXZ74i8FKle+LwnjGxooVq4QkHNTWysmqhvI1MqPwxXXbPz4PdoHmrdWK3++
	+InlP7u2r2kkUhxBGJelLq25ash20sWdd1bp7Nii/9e0UznZoEGnpp/Nka8XRng37xjE6yN1dWE
	J6VKNrxHvHvs8Te4NJaxwFBDV8vP4JlCt0S04czO0S2d+2kwvgpT9Zx6ZIfGp
X-Google-Smtp-Source: AGHT+IE6My9ExfIadYycYh55LtSyfalv/17oohhFtIWDUvu7/IXwtZ4gsI1N0BiWTm7Fcv5PWkWCUA==
X-Received: by 2002:a17:90b:4a11:b0:321:59e7:c5c5 with SMTP id 98e67ed59e1d1-32159e7c72fmr955459a91.27.1754374851535;
        Mon, 04 Aug 2025 23:20:51 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6e9asm13095030a91.18.2025.08.04.23.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:20:51 -0700 (PDT)
From: bsdhenrymartin@gmail.com
X-Google-Original-From: tcs_kernel@tencent.com
To: huntazhang@tencent.com,
	jitxie@tencent.com,
	landonsun@tencent.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	bsdhenrymartin@gmail.com,
	Henry Martin <bsdhenryma@tencent.com>,
	TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH v1] VSOCK: fix Out-of-Bounds Read in vmci_transport_dgram_dequeue()
Date: Tue,  5 Aug 2025 14:20:41 +0800
Message-ID: <20250805062041.1804857-1-tcs_kernel@tencent.com>
X-Mailer: git-send-email 2.41.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henry Martin <bsdhenryma@tencent.com>

vmci_transport_dgram_dequeue lack of buffer length validation before
accessing `vmci_datagram` header.

Trigger Path:
1. Attacker sends a datagram with length < sizeof(struct
   vmci_datagram).
2. `skb_recv_datagram()` returns the malformed sk_buff (skb->len <
   sizeof(struct vmci_datagram)).
3. Code casts skb->data to struct vmci_datagram *dg without verifying
   skb->len.
4. Accessing `dg->payload_size` (Line: `payload_len =
   dg->payload_size;`) reads out-of-bounds memory.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
---
 net/vmw_vsock/vmci_transport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708d66..0be605e19b2e 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1749,6 +1749,11 @@ static int vmci_transport_dgram_dequeue(struct vsock_sock *vsk,
 	if (!skb)
 		return err;
 
+	if (skb->len < sizeof(struct vmci_datagram)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	dg = (struct vmci_datagram *)skb->data;
 	if (!dg)
 		/* err is 0, meaning we read zero bytes. */
-- 
2.41.3


