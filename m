Return-Path: <netdev+bounces-231241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B483BF663A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BB719A346E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A3E32B9BD;
	Tue, 21 Oct 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VC9dQvNI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513842E7BDF
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049054; cv=none; b=ZpnYxXjHOqziVwDqLBBGn6oL0tdl/XRHKygJrm1s+TSXgwjCmg1YdfSy7MGIEdHVLo8sC9g+F/Dslh7U88+HeZkm3gytGvqBt4AjpPLu9e5EthlyonnHe3Wkqb+n0UKhyVp6d4KujDuK5D2Py9GN5y+emiaskmU4Ri19BVrLXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049054; c=relaxed/simple;
	bh=8jAVkUMH/+u3VOLZBfozegkzfmtTLIRMJxxRi5VQsQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zo9/JXHoq78PZUycXnGFPavknDKhSNPRcZpNi/8BTPcne7Fw2WjufnQKbaJhAr41C7zAB0JOkj5bm1WQUPKAmA9xEeJbenQOm3WqPl3Wf2ttzP2zYWY6mRsc3LkOUmjlf7DS4/F/tHpuELPySmI0Jg+5DdPASMkB9nXerLfmVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VC9dQvNI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bCWN2qWia5U/NhXPrwUuTQXMXPl3dg4yyzToKGFJy2Y=;
	b=VC9dQvNITFoAq7Wu4DbaxoQJ1w90sAb5q4Tcdp4VwSky1CkI2dr11L2rZR8lb4QmAP/R6a
	sxMqImck/mOpr5VT/OmS6Atgwexyb609q06c8fNUA+/KhJPurFpyDX1nZfDXEq5Eb8Hbct
	fbLPZQJ0wyhp9iX7jzETMvObzoAmVp0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-G-bWuvNVOuutbWtAhYPi1Q-1; Tue, 21 Oct 2025 08:17:28 -0400
X-MC-Unique: G-bWuvNVOuutbWtAhYPi1Q-1
X-Mimecast-MFC-AGG-ID: G-bWuvNVOuutbWtAhYPi1Q_1761049047
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so2883480f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 05:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049046; x=1761653846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCWN2qWia5U/NhXPrwUuTQXMXPl3dg4yyzToKGFJy2Y=;
        b=ctVeHeFh4UiN0b7/d6ZwA/HO/2kL7nn09RuE8yZ+BE30QzYx2ytaERtSaj5Dn3RLKI
         O0vr49x9antiCrl+4DeIF/nMr8ObHTgk/cdN9OVKqLKWST3SP8lEVGK+QD50brcgTn3g
         1K41N0FPfhWEMcYz7+mEik8glb6dSiKWcRkqm9CQQ5I3PNHVYHiyzAwy0P/FwlmX1+6R
         VY8Bk9U5pCLqkQBb16lLOjw/jHS8h49n44Y3alzdTh0ShfiL6oEZnsykrCAaqXS+oTmH
         vEJzATFOgIW8njZRcY78gBM/ZiWyYd8j8pBvE6pRYb9sOBaijmiPXwB4rJsHlWhPwNvo
         kS9w==
X-Gm-Message-State: AOJu0YyYHSAe48vPYo8Ca0ZwZyyYTEJU/WHsf7NTzxMSeCiMM6uPVvZu
	1QydMozyLRfK5xzUZMq2xccsBOurAYp2WD+vdQmm1QT6Q7TolJu5WESpxgLkeLwU15aVZlqMqev
	peFJU7ObcYgMXTyqTLE9XpFtop/Ug43POrL5ti86qb2xUdodRoc0LwdCbuLTM8QJ3swPX3CAhGk
	IGggDFIP0o/hakuZ70vD4ZH3MPV2FgAkrxqFpp0WhhyA==
X-Gm-Gg: ASbGncvAAdx+C5Bh70a924hfJM3tPdKE9d2ZC5Vt4b5WwW+/gEbKx05uM1YRB3Ekybp
	q/NVHObB+nvNlNl2SHmHh8iavzTwLiGL9M42MYZQoz3K6e5XHftXwmkYaTL3sYhqQvkmQwHCo2Z
	cM1K0dRt2h8+pYqYjlQuImT3WgDWoh+ynvTk5TqqlTOnmmKscdb4/ESb3WCQtWVbPJHvwfOjasW
	w0B21NkUmIKSnQ+Kn1ZdBWZJKGMnKNYiJ3sLDCWMc7Xaumomo0YBy837JP+hpEpTVdhk/uTNFeY
	unTFHDAAJEBBdl1pf0SG2l5cO0LW5j0KKpT2qWFaeNKgguxck61it5A1sbiIV3O4iRScqoFdHma
	1BYwqNMq5v1TpAdh2aKDRDLuM/wlEzz3ZkCy7mA6uSNx6OvL49rJc
X-Received: by 2002:a05:6000:1867:b0:427:6a4:93da with SMTP id ffacd0b85a97d-42706a496dcmr8994724f8f.49.1761049045938;
        Tue, 21 Oct 2025 05:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIDzVJ2UzNuMp+C3slOnSBweFytGxnRjkV0uaR+1r+JrGCQpAt/7Y9bGWU8thLnHIYoiPCxA==
X-Received: by 2002:a05:6000:1867:b0:427:6a4:93da with SMTP id ffacd0b85a97d-42706a496dcmr8994691f8f.49.1761049045378;
        Tue, 21 Oct 2025 05:17:25 -0700 (PDT)
Received: from stex1.redhat.com (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm194606535e9.9.2025.10.21.05.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:17:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev,
	Michal Luczaj <mhal@rbox.co>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] vsock: fix lock inversion in vsock_assign_transport()
Date: Tue, 21 Oct 2025 14:17:18 +0200
Message-ID: <20251021121718.137668-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

Syzbot reported a potential lock inversion deadlock between
vsock_register_mutex and sk_lock-AF_VSOCK when vsock_linger() is called.

The issue was introduced by commit 687aa0c5581b ("vsock: Fix
transport_* TOCTOU") which added vsock_register_mutex locking in
vsock_assign_transport() around the transport->release() call, that can
call vsock_linger(). vsock_assign_transport() can be called with sk_lock
held. vsock_linger() calls sk_wait_event() that temporarily releases and
re-acquires sk_lock. During this window, if another thread hold
vsock_register_mutex while trying to acquire sk_lock, a circular
dependency is created.

Fix this by releasing vsock_register_mutex before calling
transport->release() and vsock_deassign_transport(). This is safe
because we don't need to hold vsock_register_mutex while releasing the
old transport, and we ensure the new transport won't disappear by
obtaining a module reference first via try_module_get().

Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
Tested-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
Fixes: 687aa0c5581b ("vsock: Fix transport_* TOCTOU")
Cc: mhal@rbox.co
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4c2db6cca557..76763247a377 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,12 +487,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport) {
-		if (vsk->transport == new_transport) {
-			ret = 0;
-			goto err;
-		}
+	if (vsk->transport && vsk->transport == new_transport) {
+		ret = 0;
+		goto err;
+	}
 
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
+
+	if (vsk->transport) {
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
@@ -512,20 +526,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->peer_shutdown = 0;
 	}
 
-	/* We increase the module refcnt to prevent the transport unloading
-	 * while there are open sockets assigned to it.
-	 */
-	if (!new_transport || !try_module_get(new_transport->module)) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/* It's safe to release the mutex after a successful try_module_get().
-	 * Whichever transport `new_transport` points at, it won't go away until
-	 * the last module_put() below or in vsock_deassign_transport().
-	 */
-	mutex_unlock(&vsock_register_mutex);
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(remote_cid)) {
-- 
2.51.0


