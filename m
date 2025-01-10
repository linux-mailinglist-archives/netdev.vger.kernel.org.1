Return-Path: <netdev+bounces-157007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF77FA08A7A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BB03AA521
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF820B800;
	Fri, 10 Jan 2025 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWoQpmNj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA3209678
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498150; cv=none; b=TueU77isNiJ1x5QFVl8U4BktA/dIWh7qocC9irSGz9IMNdTAMdk/7CScP8s+AXgWkb5eoGgP8qspBvAluV/QlJ1feizQFd7fjRT4tDEowpQiovh4T2wxdUBQBMMoQ/KbN2uKAaqKZYqxrPeHBdSKqjrl7NQOgCEovIrjPqiT4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498150; c=relaxed/simple;
	bh=ZkTGYail/OHpw8whko7T8HSpEewACyZ6yzZNkHMM848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sW+o2mNE3tqQxNhUoE1buVML77NHMpNeeIEOU3/4CndFRkWhPA3kFeGbKRbrV2NGYQhVKjagtlGby6gEkQtz/h8br9+8WOnjPIZioRiBXPCmkdk7yRtpzkq9kHnJi8X5qKVSWp43Jxnkwp+JtEp8BfkDooX5XpGCSeTYyjuEnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWoQpmNj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5v5m4rv3lPn2u8LD9NON66qt3Pvib6QUvVJIVTGvfw=;
	b=hWoQpmNjaZ9KNQGE+LwN5kZc6fi0+Qe4Xqan99Z7WjYHMu+UEYtAoSAn28HHmH8jctwwj5
	CzY1UTuaeI0yq3w3/0spm8YOyYh+1hvtJ/fJFnsqffjajjQ59NpmKdZoDoldMu7GyNk1FN
	KZnyW2owg/BwZ26aPAJKZazANZ4trzg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-uTGcjW9iMRWCkIcbK4uGFw-1; Fri, 10 Jan 2025 03:35:46 -0500
X-MC-Unique: uTGcjW9iMRWCkIcbK4uGFw-1
X-Mimecast-MFC-AGG-ID: uTGcjW9iMRWCkIcbK4uGFw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43625ceae52so9655555e9.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 00:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498145; x=1737102945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5v5m4rv3lPn2u8LD9NON66qt3Pvib6QUvVJIVTGvfw=;
        b=YV417o2iOK6ufUUwJHjYc83TjyzTBzy3acOMWOH4f2Nmp2C3rLBpvBRpC48C3Ec4SP
         CHN0/gsylhCAleKHY/4nM3r1POenbRrxnVkPflLw0EoCDZvp0ZGktqdIRTzeXJSMLJqv
         hD72tQtZewMXBYA0UolwXTjzI+HBbVrn+fgVM1LEwZ3SWw2Xu6Uni9GCdDkZQ2Jx04LK
         t2fT4A/H5VmYZnq5UnDhfoZP0Za87TsppAm5l4XC14zBkLUQEJ7GN7bMECY39YG5HoHj
         W9yyhv4DrBH20nZuQGCuqh3Hz3fzHsDVehZsMy6I7nq2O5oPxu/0OQHzI2ZTgt5HlMm2
         iInQ==
X-Gm-Message-State: AOJu0YzazDyQomBtxpIWK7CLNiis7liQBXTzCs0ZDmCNnRYMjmOWtV8g
	TlR3KNbuaXHspDYb3Kw5GLOQSmeY/NAp5t6GHSDIvmu2E96J/89lediuL07CWbsdJZUTrLUxeAv
	9dIvJwRJVMga+eeTs0QTZavDuj8z+i1SV+zs8v+18n/Wx5vGeml2yvVib+Zd2TdpHOYtj4T3QNs
	GXLSqazuKexkqC7kkGiHWKqpUj4MI359mPgoEGWhWX
X-Gm-Gg: ASbGnctbCGE+9q1xZCG9TQQxcPcGXAmZk2/0d2ey7hO7+0l+WYaq0KceRgo8sXBYYtw
	YlplBDVp8CPUnrCmda5yOIG0nHNggnX78zHjWy1eBBr463WchUqieqHRHr6z/EqdrIku2JueUol
	znrBKrZxYcyMA/szbWO/iXd9BjVpBEZDFQ74t8qmqsgnI5kxYDFnqN3XE9Vs0tzBT4UHkP/ftr9
	F7Its1HStfonz6B81yPhay2JtwYv5RjhDCEdvgY6/pqZSE=
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-436e26803f4mr84610095e9.3.1736498145056;
        Fri, 10 Jan 2025 00:35:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpqRZ6c+WoEWD0O+MqMW8gszvq2OTzZ1nbLSdaSb4uThngbiKtv0ftXVfyIYyqEi2yR41t1A==
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-436e26803f4mr84609315e9.3.1736498144222;
        Fri, 10 Jan 2025 00:35:44 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92dc4sm78738505e9.39.2025.01.10.00.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:43 -0800 (PST)
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
Subject: [PATCH net v2 5/5] vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]
Date: Fri, 10 Jan 2025 09:35:11 +0100
Message-ID: <20250110083511.30419-6-sgarzare@redhat.com>
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

Recent reports have shown how we sometimes call vsock_*_has_data()
when a vsock socket has been de-assigned from a transport (see attached
links), but we shouldn't.

Previous commits should have solved the real problems, but we may have
more in the future, so to avoid null-ptr-deref, we can return 0
(no space, no data available) but with a warning.

This way the code should continue to run in a nearly consistent state
and have a warning that allows us to debug future problems.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/Z2K%2FI4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX/
Link: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
Link: https://lore.kernel.org/netdev/677f84a8.050a0220.25a300.01b3.GAE@google.com/
Co-developed-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Co-developed-by: Wongi Lee <qwerty@theori.io>
Signed-off-by: Wongi Lee <qwerty@theori.io>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 74d35a871644..fa9d1b49599b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -879,6 +879,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
 
 s64 vsock_stream_has_data(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_data(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_data);
@@ -887,6 +890,9 @@ s64 vsock_connectible_has_data(struct vsock_sock *vsk)
 {
 	struct sock *sk = sk_vsock(vsk);
 
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	if (sk->sk_type == SOCK_SEQPACKET)
 		return vsk->transport->seqpacket_has_data(vsk);
 	else
@@ -896,6 +902,9 @@ EXPORT_SYMBOL_GPL(vsock_connectible_has_data);
 
 s64 vsock_stream_has_space(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_space(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_space);
-- 
2.47.1


