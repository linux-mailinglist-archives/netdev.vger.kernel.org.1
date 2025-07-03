Return-Path: <netdev+bounces-203770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D11AF71FD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6774E6F32
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4EE2E2F01;
	Thu,  3 Jul 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKexfU+F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DE29B789
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541823; cv=none; b=Xbwtg1EJYahUZx0X2oGl6RODeMNcx2LM0mUdbl22TxUzbBlJN4gzy2R5Q0S3F/vAlBZQm9PWzKNV7qQ6yzXwu5/d+sT+fMpphuwoAaSd4UkQ59dYkPDmVv1E0SLvZAYnR9NWXK50naqLVvDMNfZku6RwWFX8synt/ANm7GNPQ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541823; c=relaxed/simple;
	bh=qCJ/Od0uSXuN2KvuQPi0q2CGVCbCbEn3umxbnY7hirA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IDGNGSTQrgDRIkOJ9ZzlQ05RZpz1j0rceD48yB8enNSxGgiltFQBKN0itBa7Rbzf/sAx0ghIz9BVDqee+Hmgw5qcNYa1XeuDO9l16Jp5GVGkxjzAdBxvHuKCfOAx16hFJIGYM1/ggtyz/FAOJmwcuef7jU0aqp1sfwCHnumFIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKexfU+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751541820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PIJzNJK0FfXDsC5luatCe5NaXC4y6NbBybHk8bPHUtM=;
	b=KKexfU+FW+9h2sGa7N8ik5ezQIioJoxzCLldT6PoXgjQujmiqJ5gZmpgGJByUC91+Cizhs
	ZILVL+/mw3gzwpnd5t+mpJSXrPllhKC+tT8dQ7heDByzV+BcGrDtQuHOVPwRKe5n/kAitP
	PeQTfZdrtUe1qrT7YbqSdPGg4V0N+jA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-MYBewudCMKaJ4d79p-UqwA-1; Thu, 03 Jul 2025 07:23:39 -0400
X-MC-Unique: MYBewudCMKaJ4d79p-UqwA-1
X-Mimecast-MFC-AGG-ID: MYBewudCMKaJ4d79p-UqwA_1751541818
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5bb68b386so2168791685a.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 04:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751541818; x=1752146618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIJzNJK0FfXDsC5luatCe5NaXC4y6NbBybHk8bPHUtM=;
        b=XkFgM4jmqvekd6GEJk3bnlpLjy8hv97iRDkVihH241rlpORLm/9csFg3l61F42qh0u
         /q/Aqu9W54yMuGs8dMw0qdOSGQiIJRL+0+GRj9vVocbS79QZi6htnYn+92ZZsixdnJn7
         mHtoe7093+qfa2wq1oON3mJ+xHB09yQXczI0D7eDg5oxKhoXRbvam7IkCNFjb8G1Wr8o
         VjRbPXLPpeBm2vrxgTLHKFRLdoYWrecOXquii81vqqL8g3Iv8ki6+n4xDemMHMsYAWvH
         YwbDoqOi3sw68dq7TFABIGrS0mk8H/TDxdzLqR6Uy//KFIZNuzJyTDTeMhQWB2zhJFb2
         CTbQ==
X-Gm-Message-State: AOJu0Yw6+C7jAqdiLoNfaDJGKF53DbsBFlOTARJIEKcNytOqRqJ+41vs
	TEWy2AiC9CJtHPEczwgHLFrQ6tWvftHhiWC4kKJsHp7CXVb20IikSDUdELEGC4JGyimorDCI60M
	Eh9CkBUrOSIJva4Fb6AaDa/sh/1tZxaAm740v/Urs02oJ1KH0SM3b7rUx33ZWMyEHtllDowFN8q
	LgLsZsfLiZ3WyCFa9uBSsoD00JntrW9fM+w9WuYUdCcQ==
X-Gm-Gg: ASbGncsP9r6FGHvXApR471FZt6WU9fH3C8iLzCMKvyivd5yM4WYUhnUs+wN1/wdnwwK
	QX7s6PfIhfSnB/qeAqXSFSyB0Q0RBahsaHPc2u6M/k66YsKdGZJj6MEKUKEg7sYtosPtEZi0Oi7
	0w27S8czodTHxUBqqo5mBYqjut+n/hyAcCkxVCgcBhkHy+6573o4cxuzeLW9y94U6Ye+6pbJn36
	m8hN4W8PGgd9Xo3FgZi+H3nmyFRXOnRyI+38LweTL/8Y1qzTWR5Kik5cHttYaxcKfjJTDbKU1qy
	G9F/aWbY1yRtDSIbW5Dt1xOShPdTlg==
X-Received: by 2002:a05:620a:8389:b0:7d4:3ac2:4c4 with SMTP id af79cd13be357-7d5d14909e9mr501465685a.50.1751541817727;
        Thu, 03 Jul 2025 04:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIhjpqSJkjkr7yySi+zSYYPuX82fx+PYQJJ7PyIEcTrA1s0zbfEWG0IS+SDm5LkMQyKv6eIg==
X-Received: by 2002:a05:620a:8389:b0:7d4:3ac2:4c4 with SMTP id af79cd13be357-7d5d14909e9mr501460785a.50.1751541817217;
        Thu, 03 Jul 2025 04:23:37 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.161.238])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44313925dsm1088725885a.24.2025.07.03.04.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:23:36 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] vsock: fix `vsock_proto` declaration
Date: Thu,  3 Jul 2025 13:23:29 +0200
Message-ID: <20250703112329.28365-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

From commit 634f1a7110b4 ("vsock: support sockmap"), `struct proto
vsock_proto`, defined in af_vsock.c, is not static anymore, since it's
used by vsock_bpf.c.

If CONFIG_BPF_SYSCALL is not defined, `make C=2` will print a warning:
    $ make O=build C=2 W=1 net/vmw_vsock/
      ...
      CC [M]  net/vmw_vsock/af_vsock.o
      CHECK   ../net/vmw_vsock/af_vsock.c
    ../net/vmw_vsock/af_vsock.c:123:14: warning: symbol 'vsock_proto' was not declared. Should it be static?

Declare `vsock_proto` regardless of CONFIG_BPF_SYSCALL, since it's defined
in af_vsock.c, which is built regardless of CONFIG_BPF_SYSCALL.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/net/af_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d56e6e135158..d40e978126e3 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -243,8 +243,8 @@ int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 			size_t len, int flags);
 
-#ifdef CONFIG_BPF_SYSCALL
 extern struct proto vsock_proto;
+#ifdef CONFIG_BPF_SYSCALL
 int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void __init vsock_bpf_build_proto(void);
 #else
-- 
2.50.0


