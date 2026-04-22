Return-Path: <netdev+bounces-280290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK3XIjw46GkbHAIAu9opvQ
	(envelope-from <netdev+bounces-280290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:53:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D587441A29
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D03C53029C12
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70FC396D1C;
	Wed, 22 Apr 2026 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlCKI4rc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A13932CC
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826005; cv=none; b=rpZvfMjVNO+cq4D1HHQaM8mvUsRAAe7hMgrYqEbb5jnTOJbd9iYrygcWra4D7Vgiq6js0kzTV+5ayBsZjJ+hG5gbFo+iMPE0EDA7/4Rr6w0m4A0B5xLJqO8eB0LVDOzkHGiOi7YOLvYUjYLwLWLGleudv4/0w8zARUp8i6IFjlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826005; c=relaxed/simple;
	bh=54mdUmpSfgqjXDGwvG814qjfvfFiFaCFWzugdgFYZ/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7f0XYp1kFQ0/gi7/06ce6Kvi9fl2us7No2SCzvFd2dHXUttncGPmWU6Z/82Cy0YsAMy8CmZKpVT6txWzYIc3uciXHCKgipIT0JUkKEQlfzIP4OG1xN+rbZaFZsUy5d8JIvKef9cBussbji69ed2+I3N/FrGaN4x2RfXb37fpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlCKI4rc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70c112cb61so3285991a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776825992; x=1777430792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fcd+LZFK9AMyl2emRFE9iJQXg1L+/s8eBXtgz15uq2o=;
        b=HlCKI4rcIT6GzPAm1eX0Dxdabz54vsziUFvzkUy73YnLUgbD8Ia/n8B8aqzSiKj8s5
         aK9uYActb3pA6MwqlsO6lFSYkCpDap7nfZDhe0YKmHJmfpdt5+z5m7Kq0T+3Y4JafZHG
         gx2OgQ4yPXDOXSDFbn1IrabDS2Aa1OILkds2ImPDKvV3f3Q2glXQVLm6Tb/7DJbJU/S1
         AMojfLiJlwxw8y8w9ZEsDSlTJ6Wap6Jt4s1bPs/GUPGC5EB7D8peYKvzxJLTccbag96n
         Ne5tGr5DaymAMfBM/iVjMhVqk3H0hHj7XBM4MIhPkk1PJTgOF5dtrHjkGG8XJmxg3zsJ
         AJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776825992; x=1777430792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fcd+LZFK9AMyl2emRFE9iJQXg1L+/s8eBXtgz15uq2o=;
        b=k5hZ+bNxk0cOJAJ8lW4dySs7nfufBDvBjjzn+ekqxmWKid1Wkdf90CUjmmHdSDlQYZ
         SyJUyxN7ICeoA/rJQKNAS0UCh4hmkkCHxdm3kEXU1cFub8fI0aJ/KyH4lkEWYbrsY1fl
         X9L9KXYs83+imp/Ld7cPNWl/EMNfNjk1wXeIFagqbyqr8PY/OGK6pKn6yW9QmUS4MWLw
         sHkNq4iusedTcLcplrnWn475ZF9J5UDQwr/0FNeAxvdyLCRxqbwPKS1rJhIIYXshvg/g
         yZaMUsS0iJd6U6cHSOlTj6OyTBDODRoHrpdE1wEP3BnGcLxnDXtoDGnWhtKI9MZoUrmS
         hpXA==
X-Gm-Message-State: AOJu0Yz4iDiU8j0RS7BcR6fPe/FK+yKAbEkWLgo6lpz44yycBLswDzoX
	xPGh7vW437yVt6qv0yYbD0NIogdiFca7v4gCCCaw2qk93eT0GugIQL5Mku0aUukdOwR8cw==
X-Gm-Gg: AeBDieuGexItk0igi7CP9BsQhCCrUv9SRPY/sOVWIZCuQK8eeRVx5MIYny6fcjpcY6+
	ml2UVbYng228ncvpwT51VtNe+KNRalh2J/5ID6HwO2bQSLWOKMU5o236BH9YwdtRCnZfiTEDFLk
	YXypt070H1lobw0U8Vd3uj45z75v1jC2fvIUSxD/FoIOJN5o59tE9Abybc9hPihWS1b0dy/Wn95
	+kG+PfCWVvZgrXKrcY0Zyp8uynb6Hw9cFkDO0dHwZBuxU69fMvldRq1wpEL4WcSn/bvNBStaIrh
	CE0t2Z8YbwDLoluas5AIN8NnpNvmXP8/kJGb0Y867cLVojpSKTSRxGpBVasrAJ826F4qqNmWUeG
	w6DAgH7GL3bwSMT98X5evmhOVHwn+7oEMVekruqQbaG5jRHM6CZOWeRsJca3A6SNvKrf8Ud5Fwi
	9SLy72cmKfYKfcZ5nWPcwBPyr8Bsmv3zbeYNQtAe7gLympS+4tAxQVzcFqTgNz/Q==
X-Received: by 2002:a05:6a20:9187:b0:3a2:dd8a:5084 with SMTP id adf61e73a8af0-3a2dd8a5be1mr8799899637.37.1776825991972;
        Tue, 21 Apr 2026 19:46:31 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f92183sm10656632a12.3.2026.04.21.19.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 19:46:31 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	tamird@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhenzhong Wu <jt26wzz@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] tcp: call sk_data_ready() after listener migration
Date: Wed, 22 Apr 2026 10:45:53 +0800
Message-ID: <20260422024554.130346-2-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422024554.130346-1-jt26wzz@gmail.com>
References: <20260422024554.130346-1-jt26wzz@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-280290-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1D587441A29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When inet_csk_listen_stop() migrates an established child socket from
a closing listener to another socket in the same SO_REUSEPORT group,
the target listener gets a new accept-queue entry via
inet_csk_reqsk_queue_add(), but that path never notifies the target
listener's waiters. A nonblocking accept() still works because it
checks the queue directly, but poll()/epoll_wait() waiters and
blocking accept() callers can also remain asleep indefinitely.

Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
in inet_csk_listen_stop().

However, after inet_csk_reqsk_queue_add() succeeds, the ref acquired
in reuseport_migrate_sock() is effectively transferred to
nreq->rsk_listener. Another CPU can then dequeue nreq via accept()
or listener shutdown, hit reqsk_put(), and drop that listener ref.
Since listeners are SOCK_RCU_FREE, wrap the post-queue_add()
dereferences of nsk in rcu_read_lock()/rcu_read_unlock(), which also
covers the existing sock_net(nsk) access in that path.

The reqsk_timer_handler() path does not need the same changes for two
reasons: half-open requests become readable only after the final ACK,
where tcp_child_process() already wakes the listener; and once nreq is
visible via inet_ehash_insert(), the success path no longer touches
nsk directly.

Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets in accept queues.")
Cc: stable@vger.kernel.org
Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4ac3ae1bc..928654c34 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1479,16 +1479,19 @@ void inet_csk_listen_stop(struct sock *sk)
 			if (nreq) {
 				refcount_set(&nreq->rsk_refcnt, 1);
 
+				rcu_read_lock();
 				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQSUCCESS);
 					reqsk_migrate_reset(req);
+					READ_ONCE(nsk->sk_data_ready)(nsk);
 				} else {
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
 					reqsk_migrate_reset(nreq);
 					__reqsk_free(nreq);
 				}
+				rcu_read_unlock();
 
 				/* inet_csk_reqsk_queue_add() has already
 				 * called inet_child_forget() on failure case.
-- 
2.43.0

