Return-Path: <netdev+bounces-290558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPSMMII8D2rQIAYAu9opvQ
	(envelope-from <netdev+bounces-290558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:10:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F423A5A9ED1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 530E73358123
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE3637F00E;
	Thu, 21 May 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="mOT6rEaX"
X-Original-To: netdev@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3D379ED8;
	Thu, 21 May 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380845; cv=none; b=Go8c/s6JhrECSqewJkXi0tm2dcgy67QA3UiKuOsde3+3VIzJ4XjrCqHpujPfEaUbBJIb3W0vg1kmuHdyMlghJpVGgkEbMGS0hN8v+LW/2AhwQBMHdfMNjkrieeMZ/HHMQFzTcywRE42W5IC5bxZruqQJ3Fn/HGaj/Qa8u0ImQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380845; c=relaxed/simple;
	bh=/h2suqSmh1VRy0ZDF7M+hpAPAXzQc14eVg4ZcH/J93w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mslgteVw7XasQzRn/cD1K50S1S9U/4U29mMO/7TuRuwJDK5Wz4+/G+2HPpyCqqMrOrxa+F7shgWZr/X5XZ9paP2zAhLHQKEqYsYKGJ8WBHtOc58c2nUO2vFNcZZdISTSSQFu6GqcpeVH0/RE+e6UMOAe9mWwfuwIOU7puLfrJmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=mOT6rEaX; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c9f:0:640:5657:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 9368580C2E;
	Thu, 21 May 2026 19:27:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp) with ESMTPSA id ARWPO30gRuQ0-PRtRLhY9;
	Thu, 21 May 2026 19:27:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1779380831; bh=gEM7FQjpHaiA+zwiIQRtAFpWhBBRhsP6Tj3J5miCxNY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=mOT6rEaXu27R+d3Bnx8a7nYNDzFZ8nl9tbc3BVj1Rkiw4sjLuSEsVh2Do6uXgGS+/
	 hR8Zvyma2tjs35v8sM2ntdathbpxoQ6QHsL2n7Vxr4JOUnYw2QJJx0Y3cZQWjE8iqI
	 wVt05+oK+xa9qzKNnYu9IycE2TRYskKZPmA5Ud6E=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Subject: [PATCH] udp: fix use-after-free in __sk_msg_recvmsg()
Date: Thu, 21 May 2026 19:27:09 +0300
Message-ID: <20260521162709.578638-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,bytedance.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxtesting.org,yandex.ru,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290558-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dmantipov@yandex.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yandex.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,431f9a9e3f5227fbb904];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: F423A5A9ED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In 'udp_bpf_recvmsg()', 'sk_msg_recvmsg()' should be called
with socket locked. Otherwise two threads may peek the same
message, and one of the threads may dequeue and free that
message while it is still processed by another thread.

Reported-by: syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=431f9a9e3f5227fbb904
Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/ipv4/udp_bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 9f33b07b1481..ac628eaa7759 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -79,6 +79,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		goto out;
 	}
 
+	lock_sock(sk);
 msg_bytes_ready:
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	if (!copied) {
@@ -91,11 +92,13 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			if (psock_has_data(psock))
 				goto msg_bytes_ready;
 			ret = sk_udp_recvmsg(sk, msg, len, flags);
-			goto out;
+			goto unlock;
 		}
 		copied = -EAGAIN;
 	}
 	ret = copied;
+unlock:
+	release_sock(sk);
 out:
 	sk_psock_put(sk, psock);
 	return ret;
-- 
2.54.0


