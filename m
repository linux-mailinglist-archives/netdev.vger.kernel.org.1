Return-Path: <netdev+bounces-157006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA558A08A71
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E5618885AD
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12C20B20B;
	Fri, 10 Jan 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiDlcvO9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A8208992
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498144; cv=none; b=cvzH0xYexSOW33ks+/BAjQ6mvMAru54Hz5FWtLNr0cPDmCUY/Ztpy3exR2+ty1ZzYSoPHkg2x3k64unSIVd+tIoMFte/Qe2cZJM3dZ/9JpFfVwkCKvHcEwCJlDtJPcU4JbC+Y/VEARDkdPmYGb922VQyY4tyrjuQLsAjvWw6NiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498144; c=relaxed/simple;
	bh=uPsduUWhdScehzIkWWVjxwh3m7xAtK9UHuNXKkdV3cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzymEtnorTlB5xM2MkQmVSZ2OrsikZP5QUEtpVGA98+jtpY1eXXBXc87knP/Mog3wWZ/ma/ht21F9/e7hQP5tsWiWShwoD73nBDSoCc4gmJAnpvBGdtvksRxsjC/5om7VBn6Ctd/k4awPdXzcfJFiGJ9BwkeF0CS49Q7E/9lG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiDlcvO9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/UxJFQhjZHiTLyDu6i94GmVxCXul14lCOVKyB1E+sY=;
	b=DiDlcvO9IgEb0K4qfV22eAtK/zYwSlh3sdREjZ3QDffZU2QsE+l0MCDXSH+hgDrDq+P+Gj
	wYaXIcwPhE5FkFHmjRBRU6q8uwMIuAt0NFY+XObs3yNCY0MvZYxjRPusBnav9yOmyBEsNn
	+ob0lRbnNsQdSV8AoT/2uotImAMA7GM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-fwDTZ_HFNKSXEmNIgEMSPw-1; Fri, 10 Jan 2025 03:35:40 -0500
X-MC-Unique: fwDTZ_HFNKSXEmNIgEMSPw-1
X-Mimecast-MFC-AGG-ID: fwDTZ_HFNKSXEmNIgEMSPw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso9524625e9.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 00:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498139; x=1737102939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/UxJFQhjZHiTLyDu6i94GmVxCXul14lCOVKyB1E+sY=;
        b=VSt906R9tpF9iPP4H8xUCOATBqaTizzc6fD08AYbEPIjN1BMeKo9cTMfk0xYayWuL7
         u1UCHYvc6LhJbbM02+OvN6jBnScOCnUfFXwwDWM/WK+HBJCBXYazc4/VsF+tNcDF4iNV
         AcPfr+JO0ddMjy8+Pb6mC+qKHBQHNrL2ZT9ZQcwvICa8w1WNksDCMIbeVPaDQmd2c9E0
         m52S6SMe1R+8RWdjUQQMw70K92b2nwvNI1PMe99iYiwSOGCj0AGruJn3xJG5XYKs25Dl
         zgKd17xluWZ5zHFuU51BpBdQYmdelvTVhMOSUnHet/f9bYjIf0eHwmZ2dgYgEhAZxfby
         ZdpQ==
X-Gm-Message-State: AOJu0YzVXd9suIuRGX96Vp3Q1n851fFDM/n+0iFoD8CB3t/E6ZjUSzdO
	XbNID9jGPpM90Ve7r1DGXf0VyuJfFIefgeXxo0ItY6WvICFWVWt15CXjUP94av4GUv86tJFnIkB
	y0GYTJzneEjcmXwgBYQFgY0km9Y0DG4jnEBF2kVPMHVFPvjuPXDmpKNI23fC/CgAdvB5zrLoVeH
	cRqXL+ohSCkO6VUHibPIESdCMhGFGIACx8/E52stx6
X-Gm-Gg: ASbGncu/jHDIdaXtkiIkAIEOzH4gQWch21rf0rK5zz6we6OisWy83gv3aF3w1RJRbtr
	EEiTqDFQ7MTxsqCwnGTrZ+Jzd/y9RmvdwZ8zQ85CRjVUI4gETvSyy4YoUssGiW5PkYNueqpdKrU
	QYw7Ins8vgE6gbtu8cct9NWkUV3RskJyLKWOifmJwd4blAjlx2Xbi7ekJNoOgQG9N/CmH26SOAY
	pihJBjK7yRpaCsKlDleNW0LRMjUTxFrtMc8mMz0HXqaxqI=
X-Received: by 2002:adf:ae59:0:b0:38a:88b8:97a9 with SMTP id ffacd0b85a97d-38a88b898b4mr6672322f8f.2.1736498138922;
        Fri, 10 Jan 2025 00:35:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0wfwdkUAlCHyAfjqywZwwjbDz7xJE+/6M4bU0+8jxnFXT/mEU5AdPqfdlVeWVXgoMTeKpvg==
X-Received: by 2002:adf:ae59:0:b0:38a:88b8:97a9 with SMTP id ffacd0b85a97d-38a88b898b4mr6672275f8f.2.1736498138249;
        Fri, 10 Jan 2025 00:35:38 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8214sm3895187f8f.78.2025.01.10.00.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:37 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hyunwoo Kim <v4bel@theori.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 4/5] vsock: reset socket state when de-assigning the transport
Date: Fri, 10 Jan 2025 09:35:10 +0100
Message-ID: <20250110083511.30419-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110083511.30419-1-sgarzare@redhat.com>
References: <20250110083511.30419-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Transport's release() and destruct() are called when de-assigning the
vsock transport. These callbacks can touch some socket state like
sock flags, sk_state, and peer_shutdown.

Since we are reassigning the socket to a new transport during
vsock_connect(), let's reset these fields to have a clean state with
the new transport.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5cf8109f672a..74d35a871644 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -491,6 +491,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		 */
 		vsk->transport->release(vsk);
 		vsock_deassign_transport(vsk);
+
+		/* transport's release() and destruct() can touch some socket
+		 * state, since we are reassigning the socket to a new transport
+		 * during vsock_connect(), let's reset these fields to have a
+		 * clean state.
+		 */
+		sock_reset_flag(sk, SOCK_DONE);
+		sk->sk_state = TCP_CLOSE;
+		vsk->peer_shutdown = 0;
 	}
 
 	/* We increase the module refcnt to prevent the transport unloading
-- 
2.47.1


