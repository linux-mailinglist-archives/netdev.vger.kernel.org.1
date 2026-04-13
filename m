Return-Path: <netdev+bounces-277999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AYOFu+v3GldVQkAu9opvQ
	(envelope-from <netdev+bounces-277999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:57:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9503E96AE
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0F9E306956C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2BD3AE185;
	Mon, 13 Apr 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLSziWvz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C513AB29F
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070371; cv=none; b=UWy8qvjeW6jGEHBQGeo6zxiGfu0OfM0pMlFQFuJTJCxfiL4/CyRN1Pi0jUvWxXSB3kfuitmOKWjl/g358K/MZFztMMlwEWaRWt002C7tgVKJLnFKsX5snEf7ly/A3WMmH6R4NQQ+wSqOiTG/sLfXpIkxw5kbMjTBCBLxhP6vgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070371; c=relaxed/simple;
	bh=ySz5P+wlPyhaY70PHhxQKxeSIVtjr1v2Fj/L2qYf7PM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gxZmauwzi7lqEguSPTJrLfky95sJmLpmCzmL6No9ExmMF0gaWC/NSN7LPRaiziTf01eDB87bkAmqWhTz7dtE3vTASauyo5BSf4Rk7WPM+Iqy15n4JzbauLOvVKBVZLjn/pEPStmjEtvijPTWvYc3vKDHpSXIp6kdfPoAs/6MC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLSziWvz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso2203846a91.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070369; x=1776675169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElSs4wMb13GJejBcayUV7/ht9SI5xZcrBryD/SoMfc8=;
        b=MLSziWvzjFqeluU0g7d2UoBYYKs1EcZGtcjGFMBgDTqBxZSNbRJmn5O9ruf5lkvt7V
         oL3g/uTxBfb+Ul9fn2i7RaTSTPL7j91Vsbrvp97aBlv+kNZhzmCAy5jTjsEjS3xK5gIm
         yMl7m6Vf7VA8dvJnqcFmHSqwdy2Zxe0FJ3YfMy0l92rvphRY4xjs6SdvU+wJeXZvCVbd
         wEXjo2EPAoveaOquGWsFGEpaNokwqvmsirpSkhNxfqpyNwkR9Mx7JCDDxEI2im+BWMVV
         02cKlobeFmIchg8puCRlRrAvN4dMrwAy8pvUVoGKZGlqmVhqIf4znO9lgIwKdq9ei5gf
         aU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070369; x=1776675169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElSs4wMb13GJejBcayUV7/ht9SI5xZcrBryD/SoMfc8=;
        b=L1ojK1pyl5+FPVOJCNGQcrOO3ahl7Ykvzy1zi2bqbrlxLC/niWjfo58lLhFCz2DTTu
         CIxdoNTayZydf6LuHIgWSBzKua7zL4e1ngmGjcm5wdEFKWr7sBuMKiqUFHiGXsbtZ/lB
         czhYhK727i/1gY1F86lyPgZ17jfHkZHQoSFrrmOB8dPe/eq0X9rSfpW1k8XeTKb/dH0R
         M30OQ6VhYzjtMyuXOcdv6bca87qZkFONR8hgpSDvVLAHcBkZgYdRR5HMgIV2jioiJDPH
         olmBZtj1AiX20GfP7UKvuoLCF7K/0kATm4PPd1/eyGW27s/RoFOkWWgmp3oYoLZfC2uj
         k02Q==
X-Gm-Message-State: AOJu0YxSCkTssF/ysw+ABDR06V7o96+9BvNOoe0mGL31aNQc64X8B0uI
	8N5SgKptaWdqyPIhDDog6ZNeUOB4hA9qZCXzoWd7FMay3ZyFqzGI05SJ+7GvWw==
X-Gm-Gg: AeBDies7NQTARGUCNiDb1+fD+BwvFVQRCO4bwbwh2SfQghCtP2Nru2+csQOkUgCZQH9
	nS+ZEnFXLGOe7kYEPILK9tC8ztaKGi90Qmi+ka0TF9Tn/30HlprPlOZu2uVdOagC9N6x+ZsFz1G
	kP05d4h4VYwSLF6S0d4vBqqH/nGgX/TaaWN3oUChaCUaUlF+O+uzZjJSlZgTbG53fR+Z3cnOFf1
	zKa8mNccVSZSut5G/RPCJhZQB18QgY/Y6bE7ETxSeN6wQ4hru7CQ32OT/IEvacSSJJHoo31KIH3
	HLA6KSEnCz7+ExMmbu7jJJHZtNYjohyjLlHyvqaDqQaJZMayIiUgeqMKRY7YZhZb9eNhW81HcBX
	Bdt1SDel78385nT+g7laByio6kGhz9lYGzhDmBwNNGDsNYGUTDUcFtUcS8SObPacvKXkvFWq+5k
	7+R7X80R7Q0cM39nRWx+7xol+8Z5hLJMBC47r+I4G3XC5bythQK9LfntUU4r6WxAIj
X-Received: by 2002:a17:90b:3e50:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-35e4278b915mr12556353a91.4.1776070369278;
        Mon, 13 Apr 2026 01:52:49 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb87d0361sm1120992a91.0.2026.04.13.01.52.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:52:48 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] vsock/virtio: fix accept queue count leak on transport mismatch in recv_listen
Date: Mon, 13 Apr 2026 16:52:43 +0800
Message-Id: <20260413085243.73200-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-277999-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC9503E96AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

virtio_transport_recv_listen() calls sk_acceptq_added(sk) to increment
the listener's accept queue counter before calling
vsock_assign_transport(). When vsock_assign_transport() fails or selects
a different transport than the one that received the packet, the error
path returns without calling sk_acceptq_removed(sk), permanently
incrementing sk_ack_backlog.

A malicious VM peer can exploit this by sending repeated CONNECT
requests that trigger the transport mismatch condition. Each such
request permanently increments sk_ack_backlog. After approximately
backlog+1 such requests (default backlog ~128), sk_acceptq_is_full()
returns true, causing the listener to reject ALL new connections with
-ENOMEM. The only recovery is closing and re-creating the listener
socket.

Compare with vmci_transport.c and hyperv_transport.c which correctly
place sk_acceptq_added() AFTER the transport check, avoiding this
issue entirely.

Fix by moving sk_acceptq_added(sk) to after the transport validation
check, matching the pattern used by the other transports.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..29e1d9833be4 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1,3 +1,4 @@
+	sk_acceptq_added(sk);
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * common code for virtio vsock
@@ -1560,8 +1561,9 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		return -ENOMEM;
 	}
 
-	sk_acceptq_added(sk);
 
+
+	sk_acceptq_added(sk);
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
 	child->sk_state = TCP_ESTABLISHED;
-- 
2.39.3 (Apple Git-145)


