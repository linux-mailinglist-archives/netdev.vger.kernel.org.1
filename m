Return-Path: <netdev+bounces-152932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE1B9F65DE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3687C1618F5
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7B19F111;
	Wed, 18 Dec 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="V9lkXr95"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694719CD01
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524715; cv=none; b=H8TfSUuQyhiAr47puNtNmF4lnzIgZYh4C/qXfXMMBHRXd7hCXR7jG8Jc5KJ5Hv7j/WvrkdOFEdLPasuV1EEcQ4By0VAuV/senxaAzv9+nKvCydLKJbmozou/gZd5rnszYkGd61DfngkzSZUND1PqIPGFf1itP90PapY2OFf/TKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524715; c=relaxed/simple;
	bh=WAdidfifqCck/K5RDR49Wzv02UWwY6ooFoZfvj2xh3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IXqF8IoS8Pa1u7kprnmiaNVIxUwqntPIdyM7RBPWxWcp6XYVEgeXdIwm44jXLacFMFDSUU87vzMfPuSbMLNRU/cl4Yo8MYlPe5OIGSs8EJ773mVX5SoGSaHtXbsTWnCM+3LhPyXGoS93b5VQA1Vor6menLkWVDHQ2kKzXQLMFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=V9lkXr95; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-801986033f9so3341473a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 04:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1734524713; x=1735129513; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ry1f8EH2vuZ78FOFS8afWTJPFj2kQaLGsja4DlOwPIU=;
        b=V9lkXr95iHDCgSMuj3NS/cO9Xm1I2xOD9Bs8dwlLzqz9+bNkN+hjdv3nDe7Og4sbnG
         qnVCpz4fxHK3ycWMpU4MbgybNrkDLqP2F+q2RzFSCxgFx9V3j57zxlGeJ9Ly7KIbAAEG
         GQHiyGIK0twM1AXOBzXAvXi3JKX1ffBCh+x0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524713; x=1735129513;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry1f8EH2vuZ78FOFS8afWTJPFj2kQaLGsja4DlOwPIU=;
        b=MTwsvgeU+3NJIePvpsijY323tl6HZPIdTUhxrRcgWCxbdZ8bN9qcaqplRMpbjWnhiv
         /aopWVivud7JSyY3pk+V7RWfugL2W2AYV8cO0dWTQGpp/peOZhjsiidUBt+Koc0vM0Xc
         t6r1OiQGWnunwCtLMKYk7AXxPZlAJS/IPb4C1EUo4VYxZbhay3RoQbkaHW6xGRPBDTYw
         JiNDkg4wA5BnlDy2ECbinAj8HPYurjKqKmPwXvrn7rLESBxZdsc6mhflUZP5XfLmO/6Z
         VaKTFDmF2NgIBYh4VhBUd9JggmSXvmynwprz0cT36dWkT3QKjaVABKIZTtX1a1gVtmEY
         HyUg==
X-Forwarded-Encrypted: i=1; AJvYcCVHve4MjJNeQuLohWGs/PSllYqYXzjbZ/OyJNxJG/C5lWDeCh3fi6+3WoY6Mz0POmMnpr6gPL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaorHzsljF7DxuSy+GX+PIvM3hFhKjoI4YwP6ubz4zwbG+pgTr
	9Lc+D57EPJTROinB5pK7T8/frt1G56VtCsbqe/shayZffkAj8AVdmUMCkaYldqI=
X-Gm-Gg: ASbGncu+jvcn3erVCKSjv8Zf4JfVDLeA0aK1mVu4n3F7KzUdvcdYwlsaYSVwRUEuv0e
	ZQBKWPIIx+tPfuStgyiW79uwKYrUaNsc6KAjzwlPq+KlEegssF1/2pOsj5tTmZvGPEHbxvZdXOK
	ckWmJwIWW5SPZjBki4pT1ayKanstqN3j8SwxNr8wkoiBScynzRB7vxX0r3EG43QnK0ytyam3I09
	/62JjyoJYvsTRR5aCgDz8HiyuxVK1FIUm5XB31MPxdxNEJlqMsn8y2ipwdxZ1/MNDXdIA==
X-Google-Smtp-Source: AGHT+IGiEpjydlEOeDKpnYMGuWBf7igzfRiDu6SwBhJlykAsoY8LX6DKzv9Bxwbl+1NeeAlcB8jGQg==
X-Received: by 2002:a17:90b:2742:b0:2ea:3f34:f18f with SMTP id 98e67ed59e1d1-2f2e9302d14mr3697071a91.19.1734524713119;
        Wed, 18 Dec 2024 04:25:13 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06dd46sm1386521a91.36.2024.12.18.04.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:25:12 -0800 (PST)
Date: Wed, 18 Dec 2024 07:25:07 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	qwerty@theori.io, v4bel@theori.io, imv4bel@gmail.com
Subject: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When calling connect to change the CID of a vsock, the loopback
worker for the VIRTIO_VSOCK_OP_RST command is invoked.
During this process, vsock_stream_has_data() calls
vsk->transport->stream_has_data().
However, a null-ptr-deref occurs because vsk->transport was set
to NULL in vsock_deassign_transport().

                     cpu0                                                      cpu1

                                                               socket(A)

                                                               bind(A, VMADDR_CID_LOCAL)
                                                                 vsock_bind()

                                                               listen(A)
                                                                 vsock_listen()
  socket(B)

  connect(B, VMADDR_CID_LOCAL)

  connect(B, VMADDR_CID_HYPERVISOR)
    vsock_connect(B)
      lock_sock(sk);
      vsock_assign_transport()
        virtio_transport_release()
          virtio_transport_close()
            virtio_transport_shutdown()
              virtio_transport_send_pkt_info()
                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
                  queue_work(vsock_loopback_work)
        vsock_deassign_transport()
          vsk->transport = NULL;
                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
                                                                   virtio_transport_recv_connected()
                                                                     virtio_transport_reset()
                                                                       virtio_transport_send_pkt_info()
                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
                                                                           queue_work(vsock_loopback_work)

                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
								   virtio_transport_recv_disconnecting()
								     virtio_transport_do_close()
								       vsock_stream_has_data()
								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref

To resolve this issue, add a check for vsk->transport, similar to
functions like vsock_send_shutdown().

Fixes: fe502c4a38d9 ("vsock: add 'transport' member in the struct vsock_sock")
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Wongi Lee <qwerty@theori.io>
---
 net/vmw_vsock/af_vsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5cf8109f672a..a0c008626798 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -870,6 +870,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
 
 s64 vsock_stream_has_data(struct vsock_sock *vsk)
 {
+	if (!vsk->transport)
+		return 0;
+
 	return vsk->transport->stream_has_data(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_data);
-- 
2.34.1


