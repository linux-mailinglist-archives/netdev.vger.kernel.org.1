Return-Path: <netdev+bounces-211646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F588B1AD14
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 06:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB7918A0AC1
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 04:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542520F09C;
	Tue,  5 Aug 2025 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juNqLYsH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFAD1EF0B9;
	Tue,  5 Aug 2025 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754367481; cv=none; b=D1y2gBBIhc2B7uL0aC0hlwPbxQPcC9XHcJlb5P3b+l1FedgGktQDyVIbEv4PrLCIyPZRFzx/4qAHaK4RsH8y9S8c3nLF+QVlCUEHmFrfmJpXS7NKVMkcf56zzZKpZKM1uvq3zp7/eh86oD2ALteeogoyN0lc6RNDQQ31dOYBDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754367481; c=relaxed/simple;
	bh=YESv702JDbfuSthWoc91HVirrnAcbw2WvyWffAxBVLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dX6t91k6wxcmD9Isie5luNwoYrCpHaY8CFIylT8/qDmF1uJzoDdiBoyKyQ9HwswtBY994OwA8fcvWkUbfN7axvmJy6DHpYSf0XnE+TFwozqFsM3GtzeBJXhTR43Sf9poj/5LPnEJ1kZALqFlEDxSKkFL0TRP85xRS6pSeE4vEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juNqLYsH; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76bc61152d8so4211327b3a.2;
        Mon, 04 Aug 2025 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754367479; x=1754972279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0wU102dcRZfX7qHNlGDp27YpvbTW8OMK3j2nigPqDs=;
        b=juNqLYsHplLlxea4SdlMsQ5w1QL4diedOKqDgLZr6I8/Kj7XzR04tNr+xYGh7NnRl/
         AySV2dwACiuqBoTB8y4GUrspXj3jNtcKUleDxHsvb9jjSowF8dEGgPsJ3tiA1+dmNS8y
         UlpWY1h2cZOabW3Tu2q7oAyigPTIt8IlAXE/8RvZoHR7tBWNfJClWWL6475Ky76+xw1W
         6fhgHW7PsZaqPhRb2dkrW4kUBJwCyifQSGywI0STQ9y8cWdw9r9rLa1z7n/FeOALia5K
         hZjqiIyex4NgInhi7BzR7Q+iTUIcMb6v/MN6lWh3m/bRwoTt8pVq667RHgrGywQAeH0P
         XyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754367479; x=1754972279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0wU102dcRZfX7qHNlGDp27YpvbTW8OMK3j2nigPqDs=;
        b=iqyTco603drwAAOh8o3FHSzZ6cVQA5ZW/UxNgpNFxaGaerwQoXxNzuMuEIvNNTvbkQ
         hwYqihVZOQK3n1Hd9oht0yaLnKPLkvRxnFryD65CUUhpm8Ik/R27ethxONbrjKIiMzt2
         7YVgHt3IkwdFvF/kzEnBt8Qkqo+IjdhhAxAiMmpA+3KQVSH5xpi984U28MYNnmIaMg3a
         XU4WazAYx0a8rHj0lHilzeOHYg6ruNhtOj0Ed03Dje1+JhzEtVSLrsV6CDIJgMBORRIw
         STdViISfeAQ3ifkCchkM4+yXePqfjdFiugVuBR7ddepEbLPP+rmmANw8Cedb3tLhoFyp
         Yhyw==
X-Forwarded-Encrypted: i=1; AJvYcCVLrhPEe9df5eVLvQQdadV2JnvaqdOzNB4XM/8Gf1N2e0VGmKMQbADx1K4MKOhvPyFVz2M9y+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB37Bm7vTv72OdysS7g2+e7EFSgSqjd6FsxFAR/SlX7742x9Jt
	ScWVlM/iTf4L+lk5drR3nyxBWg6Um+1ehB4W5aXgnoVWDLA6FrVCsPd1
X-Gm-Gg: ASbGncuKJQbz3A7cVoML1qIzMivRtt1m0wQIaDWGqmnrAexV2WCv0T/piQvC/3j5zc7
	1mcxt7FAcBo0w3lUKaH6FSDKC6eVZ+PFCwFf2QWr022xQfyqTqBbwkQhC1xrS3v3tguO7HL9gxH
	1+2NmpO33lmwSUFc462ZD8Lki5Qr750rT/S7s7IxDFJ3IuNh2gq+u2EJ+0vWLDDB7HXXsOw7Zpy
	zQ9AoNXKZHuC4W5KMrvLsGysVs9DzhYh2K00EKDPCoBjBvsq1QAXCv+rOsJQ9MXAvMTs8fa5ImF
	kKPZGRME8tONSnwEqMj1sTL58Bw0Evps079f3Z9AUutic9VsVLNCIYegrKk6dRD7SZ6zCVmPvXj
	WurQlrJUb1iLOay39DHTJybM4eF5kjcMVo2iZIdTR+a5ba52yY7QTYzbO5ZZo
X-Google-Smtp-Source: AGHT+IHoPmZlrFSS3ycNX4xvQ7lUBJMXu1HMxEtJCBju7H0F4ElNjmffdcrUE0pi5UqPODbv2+Z6vA==
X-Received: by 2002:a05:6a00:a21:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-76bec311399mr16066330b3a.4.1754367479074;
        Mon, 04 Aug 2025 21:17:59 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe3199sm11680521b3a.115.2025.08.04.21.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 21:17:58 -0700 (PDT)
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
	Henry Martin <bsdhenryma@tencent.com>,
	TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH] VSOCK: fix Integer Overflow in vmci_transport_recv_dgram_cb()
Date: Tue,  5 Aug 2025 12:17:48 +0800
Message-ID: <20250805041748.1728098-1-tcs_kernel@tencent.com>
X-Mailer: git-send-email 2.41.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henry Martin <bsdhenryma@tencent.com>

The vulnerability is triggered when processing a malicious VMCI datagram
with an extremely large `payload_size` value. The attack path is:

1. Attacker crafts a malicious `vmci_datagram` with `payload_size` set
   to a value near `SIZE_MAX` (e.g., `SIZE_MAX - offsetof(struct
   vmci_datagram, payload) + 1`)
2. The function calculates: `size = VMCI_DG_SIZE(dg)` Where
   `VMCI_DG_SIZE(dg)` expands to `offsetof(struct vmci_datagram,
   payload) + dg->payload_size`
3. Integer overflow occurs during this addition, making `size` smaller
   than the actual datagram size

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
---
 net/vmw_vsock/vmci_transport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 7eccd6708d66..07079669dd09 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -630,6 +630,10 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
 		return VMCI_ERROR_NO_ACCESS;
 
+	/* Validate payload size to prevent integer overflow */
+	if (dg->payload_size > SIZE_MAX - offsetof(struct vmci_datagram, payload))
+		return VMCI_ERROR_INVALID_ARGS;
+
 	size = VMCI_DG_SIZE(dg);
 
 	/* Attach the packet to the socket's receive queue as an sk_buff. */
-- 
2.41.3


