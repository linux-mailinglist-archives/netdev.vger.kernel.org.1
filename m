Return-Path: <netdev+bounces-240661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A98C776B0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A21A335EA40
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 05:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EAE2FBDE1;
	Fri, 21 Nov 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXufHc81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7202F6934
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703898; cv=none; b=eXs8PCra1BBjXWG+wg+nG6wj7sV189eDnqPBad7JSBzEycs2PUwJqW5TVp6PVlb02QNh1UziwVSOxN5ZbJ5QmUCc9DJZ3rAgTPTSEhvBGcJ5DwNer3aG1kFnaliNJMWdWfLZm4k0RSkKqK6IGCinA9BDWWkEulXjK8+sfPdMbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703898; c=relaxed/simple;
	bh=fsBBb11rRzR4Q5pi4KL2AyZQEMokJCJhZHnuBGJ1xhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhEJZ9h1OneHIobpDqfkuEaeEdGlgGqRi2EPaNeLhIO5xoefvnYFHaMDdm+/F4RWXQTh5FT/lUKc0qicT3rItLly/dAj9zV7exoR2U15qyItsVn6oiK67w7ovAbw3lRxyDxEi3VvWf0Bpdy5sU6aAZOr35MLBF1EMfNi7W8kwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXufHc81; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297dc3e299bso17335255ad.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 21:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703895; x=1764308695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eC15iyYiDR+Sm1hgPKilCqyF6DXQAH/mQRgGwIW2dVA=;
        b=MXufHc81htKDHR7hx8nYgiZlT38+9IgO7C4G60UdU10UUhHbf52nM8xsEDkWKCBpXb
         V64BVPkWwlazJqRjDdgCrTU5Y5azVDuXb5NKbB6xFYRJZyyN2KLWy4UwZq2x3m0vvZFv
         FkxAANDMxYd/cX+Ii9bZbVczvZu2mmuAPPk16ZcvuESlysO1/8c88waTD7HrFlX0VQvN
         wRriWddBaOh9akp8C3IIvbPsN/sZj7UxM4Hv+LD6y1fdDh8nc2OMMNvGZhS5JWCD7F01
         Y8wc7K51GjxvujTsz8tt9wFRdfOLeXo2Ga9k/fSrdt9SUkhb1BL64WmtDpvzHDps23VQ
         1L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703895; x=1764308695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eC15iyYiDR+Sm1hgPKilCqyF6DXQAH/mQRgGwIW2dVA=;
        b=eFh7Q4sP5fp+5LWw37Diqt69ZbUPlqPmUgtOICayMpo+2u//utRk9Ne1ybYnm/TrTk
         bxaU3UneSihkf0Dz16U3zm2cabAevsOsh0IDcf8xjJLbv/nUmv/uk9ERZ+DwuxNITaDl
         eCUVUxzEgDVJnv70Mo56+gJFuyx9QWKzqXKmgT2AAKyIgsFrL6+72FcSgbd4Jg5iU/W3
         7ScqhmH2MKxADVW9C0jD1XscP13cuoml2se3bB8wQyKjKa75pdEfDY+Bs+NN1aFU/dVy
         U8vXY6BW1QTrxPmMAVK8LEn7LO6Vq1rMnBjGPkOTEyfs4CjmmkYrz21ZpJsdb5hXCLUq
         BgYg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Wp8zP2/E3XzrNDgH4apPSSG9oSV0Xq4qOsTYaSY0NOupldN9zMp7bht+nijaTgoEivj3bWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHENuEsSiCm6/wuJAiwgtdhUwSdKwyWrI6ljHtBsFHHU2gIOB8
	BBwauRJU3QmVOf0RsTA8MDG2i/2zbH15gAJAeZ4RcBR+hZlnAKLJCtkC
X-Gm-Gg: ASbGnct8roeL9uItxTUJmrjcv+bb38JVIch4kxOIXYl5K/qcHxVFLVB9InW/XE6xq+d
	QiKbngFdZ8n9kIjh1F9p3uIVWwwi3f9vbo1aG0KaCfHXxK9MzXSjzj/3/yoDywGQfx+a5YZJq5T
	j+xSWXedduhuwqMYqwX7lc4RsZm2voHaI+y6nNQOPtZtoP98b54rIuXk0MKmgU7X28B7VG4RVYe
	P25lwsJtxglUcZi8DjATrBKy8cnp8DBuZ5IxtzwIGjtmbBaRVB3XT+L7obIJ5FgFaR4c6bOscZ4
	miSu77wDONL2Vini51aNbdsYIYn6J89hbVETWBl5fRIfbJHJiebh9MhMIag1HuLkefTt1y/loU2
	6kJrhcoLmkiMvwUi2AEXlpKDwq+ZBhAILwqOoISWhqzWQ8TkoIs131uD+wGWLJBBdr4xR0cS2mv
	Y0WjFhy16Q66Agk/kd
X-Google-Smtp-Source: AGHT+IGa+OjNw6ZNUabNVrbiRm1cN34zeqSyarDkZ/uyC1wiDWIlKAxvnZ18+6IgwXZkACrQhhBeIQ==
X-Received: by 2002:a17:903:2acc:b0:298:efa:511f with SMTP id d9443c01a7336-29b6bf3bc9emr17507735ad.39.1763703894492;
        Thu, 20 Nov 2025 21:44:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a870sm44383905ad.34.2025.11.20.21.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:54 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:36 -0800
Subject: [PATCH net-next v11 04/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-4-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
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
index dcc8a1d5851e..675eb9d83549 100644
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


