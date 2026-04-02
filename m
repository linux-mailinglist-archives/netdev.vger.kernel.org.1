Return-Path: <netdev+bounces-274691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIp9A3jWzmmGqgYAu9opvQ
	(envelope-from <netdev+bounces-274691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:50:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 624EB38E23C
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFF1D300D314
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B5315D53;
	Thu,  2 Apr 2026 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmENch9G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A103537D7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162995; cv=none; b=a/TqVTGcLiFaB9VTBRIQlt0hGGOKWm45xJ5cz9NLE5gFEWeDsDTt7PR7AM2WbPyw/ijllTRc8zdExlskdw0xid9Kw8+z1R+ZGxmp/o4LbTXVp06haNIaA2Ssy/FDMKlX0yjh873te+TKpBcvQStItWKJTQo+GkjmXQu2NAKddV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162995; c=relaxed/simple;
	bh=/NOWjdCDjnSGtjfZ0scHtF9gHAc7SZGxwt0BAwxtaiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhLDfWtvFJvpfDyYlrFw/+DLyclUjwguD3ObwvrpJOinnkfdrrYAaO6X16nMAd0xJfSLfMiYWzfNf4+qBYWm9KWd5e7iZp6Qrj5ZG5kudK0wHewjQuGbP4EBNMgyUFJb1w4Hzezp7TplUC5ZecPoYHaZMjdXpIpSnwLHKUnszgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmENch9G; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1597496eec.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775162993; x=1775767793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNWS0mYa+ildstE8KT3uWmZVAb+dtMF6/uKnjB13/tk=;
        b=WmENch9GfqskIqXVKLnP4o4inEiqBdYVov9v6fCOMn492L7WjFulQcy6HLLJEgOg3r
         bHON+SXP/lhATCq9Pz7y4PtspJsEH9vViZ6Mhu4bSE0a1oCXmVnb3vk5faAE2jNJomVc
         Fid2YrjVVldIr+ZMmqUGIzceC34DDeLbZlK8Esl9Z0IXC/vhi4uLDyCv7N9AXXVCswDT
         E/mz1VVcMtQGEWykaApzCaUsEyX6a423lUcn8mWGha+xXdOOmMlryT2MhskIZJmslsH+
         CQ0qtVyD64grOCM19Hj6yTuHmSs+zaDAtDRHPxRP0L2rXdJwR4M9tphF1jfbGAz7kQz4
         ASkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775162993; x=1775767793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNWS0mYa+ildstE8KT3uWmZVAb+dtMF6/uKnjB13/tk=;
        b=opzSRX2bW4OB1g0Qe4vHoFLZmBYU1ODLmA4edJXNY+P+Utf1qv+YKnjDEAJ2U6i986
         cR13+gWXkQLraJJCPXYbK4ojPA9nrPrraU4ukCJrsogQ0T/5cgUQrjLrmtvpQ4Eh8Kxs
         qI/qHPBYwWNAnXXpPXOF2pvb49bGkOm2rw+5d9vMRX4Ay2BeLDHe1qzoRvcS1dxyxEz1
         F3eZdRKTIY0rQODM8mw5fe2VY8uL+tTl7CQJLcwtdQX/TIKTA36X2uBTzSnMPUISlCjA
         urvpHUs3jOZL74JcVEnOZyOuB+ZL6xfoRWkw5Son8JtutN8wIS7Dm3qUt5A/TLL7mTqw
         aGaA==
X-Forwarded-Encrypted: i=1; AJvYcCXmq7M/edwEUvKf/EV502//FyALDUS1aKYTw4G8RK8SLZyPV31//kEfTf4cx4yAANYCVuQCsf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvpRcqzSsIzsUnZf64weIUVXrCfIWlXjleEVEFBn8ZpXbPxlZ
	QckZAb469eFeRpgEnS0w8l6fvBnY/emtdCofovwN1PIy4GOCv1w6Xyu+
X-Gm-Gg: AeBDieu10YUMgvtvd3CgVhpbHYzaWkSzHuTRB1136sfe3leA1aBE0tNeXZcpMoPo28L
	Z9p+K14h/tvbNKTpPiVYo4D6wTlUIeG/xMaJzr2INkyJv34Qj6BSXZorq6UUAYmX2+V83InuGpn
	IRRqDevV2JE/GJeO9Jm68v+vm56Tt8PZW/prAIDLXNUmiCtxQMH7gcPJ6w665sfYCkH35iGDKTI
	3qR7aj3F6cqbyTo+ibFiKeiqpp6f1Ml/25ueXNH85mlaf9PWhPfbxziUiyvk3y7TJZnhZXhKTfB
	N7GbmQ+E7f9UUQVmbxzKDJs5uO7mMVgzR0aV1ZokJd/pSOr+Jv3q9wppusbvAsvtlJPbMqDpYgB
	/yBuV2qIQ4igbfCqrnALWCeE/hnNeUesmfqY40FAPnN6oH247dtTxVqEm1VgzhzeqRgxjbMpeU2
	vmV3mw3zHCv1soBVwzhImWAC7zFeZHxshDPwViHc96AtZwJ5bf+tBGnY+tOk7v
X-Received: by 2002:a05:7300:bc86:b0:2cb:53f5:553e with SMTP id 5a478bee46e88-2cbf64ab2c5mr405861eec.0.1775162992583;
        Thu, 02 Apr 2026 13:49:52 -0700 (PDT)
Received: from elmini.. (c-98-42-127-152.hsd1.ca.comcast.net. [98.42.127.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c30asm3575737eec.15.2026.04.02.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:49:51 -0700 (PDT)
From: Laurence Rowe <laurencerowe@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Laurence Rowe <laurencerowe@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH net-next v2] vsock: avoid timeout for non-blocking accept() with empty backlog
Date: Thu,  2 Apr 2026 13:49:18 -0700
Message-ID: <20260402204918.130395-1-laurencerowe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,vger.kernel.org,gmail.com,meta.com];
	TAGGED_FROM(0.00)[bounces-274691-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurencerowe@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 624EB38E23C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A common pattern in epoll network servers is to eagerly accept all
pending connections from the non-blocking listening socket after
epoll_wait indicates the socket is ready by calling accept in a loop
until EAGAIN is returned indicating that the backlog is empty.

Scheduling a timeout for a non-blocking accept with an empty backlog
meant AF_VSOCK sockets used by epoll network servers incurred hundreds
of microseconds of additional latency per accept loop compared to
AF_INET or AF_UNIX sockets.

Signed-off-by: Laurence Rowe <laurencerowe@gmail.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
---

Patch v2 with feedback from Stefano Garzarella and Bobby Eshleman:

- Move prepare_to_wait before release_sock to match previous behaviour.

- Simplify not connected case.

This fixes the observed issue for me:

1. With loopback vsock on the host running Linux v6.19.10 built with
config-6.17.0-19-generic from Ubuntu 24.04 and make olddefconfig.

2. With Firecracker guests with current torvalds/master, v6.19.10, and
amazonlinux/microvm-kernel-6.1.166-24.303.amzn2023 used in Firecracker
CI and examples. (Firecracker guest vsocks are unix sockets on the host
side so this fix works there with just a fixed guest kernel.)

I struggled to build a generic 6.1.166 kernel that worked as a
Firecracker guest but the patch applies (conflict due to change of
`flags` to `arg->flags` in surrounding context) so I believe it should
work for generic v6.1.166 kernel.

Alternatively a minimal version of this fix is to just wrap the
`schedule_timeout` in an `if (timeout != 0)` but that leaves an
unnecessary additional `lock_sock` call.

There are ftrace's and reproduction tools at:
https://github.com/lrowe/linux-vsock-accept-timeout-investigation
---
 net/vmw_vsock/af_vsock.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index e4756604d5..b8794ea0f0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1864,10 +1864,10 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 	 * created upon connection establishment.
 	 */
 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
-	prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 
 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
-	       listener->sk_err == 0) {
+	       listener->sk_err == 0 && timeout != 0) {
+		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 		release_sock(listener);
 		timeout = schedule_timeout(timeout);
 		finish_wait(sk_sleep(listener), &wait);
@@ -1876,17 +1876,14 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		if (signal_pending(current)) {
 			err = sock_intr_errno(timeout);
 			goto out;
-		} else if (timeout == 0) {
-			err = -EAGAIN;
-			goto out;
 		}
-
-		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 	}
-	finish_wait(sk_sleep(listener), &wait);
 
-	if (listener->sk_err)
+	if (listener->sk_err) {
 		err = -listener->sk_err;
+	} else if (!connected) {
+		err = -EAGAIN;
+	}
 
 	if (connected) {
 		sk_acceptq_removed(listener);

base-commit: f35340f2d653f1003602878403c901396ab03c17
-- 
2.43.0


