Return-Path: <netdev+bounces-263595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF4sK+vEp2mYjgAAu9opvQ
	(envelope-from <netdev+bounces-263595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:36:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CED1FAE2B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABE92303C393
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 05:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AB0378D7D;
	Wed,  4 Mar 2026 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgkmp1KD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BD37DEAC
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772602600; cv=none; b=LkWarBoSgjaPJNnIYiQBhmJj9uGhSXWAeo1uaTRPfQZAMOkBr/Mc3Za31qjTdTTolfwIAfdl1byMBgFyAOjvUvkziYaAfU27smZjnX5Ak9kN0pHixfbZlkrLw04AdDrlR+jb5xp0HD7bZXvCoLev252xZJInzRzPvD/vKL9O5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772602600; c=relaxed/simple;
	bh=Fh2w9GegkIjBGfvJYSj0dj5p+FWtLjoeXIvuAgbxRcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REp+Fh1/zrvNSS4QKwHCidQUPwRbXcOP1HIKOqflp+3Fa3X7wxST2gSYsZSyO2yLYq0ar11A1GzXvUG9yNQ0TM7vHNyuGUySsFlmyMLUmWaPIBdpEl7iK1tKm/H5PcHHM19BHLH5/HCbx34AtNmMHmo+JeN4eqrKYN3h9dBHABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bgkmp1KD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35984cd0335so1421509a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 21:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602599; x=1773207399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXXONp/ELYPAk8Ra1lPAUCJk3t+/mDBCyOGivtl5sfY=;
        b=Bgkmp1KDJuaQ07bo2dOHwHZOm2eu5vU1YzXn/9rL4JC/Sx4E981uMZi6kt8Exs+Rj/
         vSgYNagHqeOkH/P5UwaYgWJfgofpOHD2XI4Xy7noH/grWbYE1n6lehuA9He6JCDDJe/K
         R2N6yIQPUS4frlqnd3TvNkNyD6Cd9pQkECBOF9DaRGytMm4s8pSjrlh5h2TTcuFg6iY/
         rWEjmbc8jlW9pzyJQDkp135gF96rVhRcU5eBbjkxOyl/fXDIjaoecrI4YL4kTMvpcadk
         wmKTZp5JMb0OBvGKrOOaJ0PPloxD/DT1S7E0HOwUqlAKUuYuwyrtgqhMuROneIkLqVwn
         0XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602599; x=1773207399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXXONp/ELYPAk8Ra1lPAUCJk3t+/mDBCyOGivtl5sfY=;
        b=Udfm25Ef4wv+uiUI5OBj4sPO0rF0Fn//ZsexuwfXrjdXrbh/+Ek+W5EpXHL3BTvrfj
         P6RjCcDig8DTy7Z73bb3oN2AfvoIBSk3EIuIrxcWIbcmvB1H1xWfb4UPBuxrFUOw9LM6
         zQpz9lkAt6GP7CJXjBYak7BldsL9UgnNvkLHn8LfQUtQECrPPFwM5/KT7wf69Kc0XTBc
         YeL6ALnhVW2UyoeguQlFlXSzcBVQlLySKCqdeTfoZp51hLbAjVlTaQ2lIOxXOaaa5s1I
         l5lx3ewXrcHKY5hzQ9t1rjtk1XDNer0jSCDa6jBrTZW/aQyte0U6pMEBD430i9TNpTd3
         NekA==
X-Forwarded-Encrypted: i=1; AJvYcCULVBjzvS+DPyDp1vXH9bOxCKHua3B8SyQK3Cl1l5lnQtBVAHfgeAzwonpvcavKGqURc9NLtRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QFOF6vYBfyZAw82fYULdS32qF3bqYJybEfKD7w47DtZKOXHZ
	lNq+o3wVNV6HrXa7xJzPUosmnGTfgSXla+7VXgYWEHL3ZB2AVZ8Vze+I
X-Gm-Gg: ATEYQzyBG+zIH3dW4rq/bsrmnc4IySRAA9SdK4oQS6cpk/nbL4cyP3Zmt4PQbIvuG/Z
	X5ZaxzB77mB3DGVkp9sTbpzXPfMhNriFVcGIMVTPMAkDAy9WT3d2COkAgSG0RF/FhylyG28Rrgc
	gnFZ51wuyDgWFqYTlqDQVceWoYlYod4y/gC2AqyeUScZhDSRJo5VxYLEns4Cm/HRUqX6odXmmNL
	e9lAM5ZYGq1qt0l6O2Xr0zp6LmUtcjmOjqAzgRTpyamVvK0ujiPH/AtBAX8u+Gh3XMwjLUOddQy
	uVg4El5H/m5B1jruGPzNaN63pHAq+T0b+F22+K9a86vpFaPS+tEIvfarnaAgicTGZh27aXpe4fX
	cK0a/mJQ0Z9GpHepsCzzRzeZ7Ibj6lM5yDzXlwG8+KOqYYVvdBnUBe80LaM8qDdNuOHne8EvVt2
	WsXFbrbtuvGWTjhOg1WjM4ILXVAIB3xuLVrfMMJjD0dg==
X-Received: by 2002:a17:90a:ec87:b0:359:8a78:5696 with SMTP id 98e67ed59e1d1-359a6ce6a46mr960709a91.1.1772602599018;
        Tue, 03 Mar 2026 21:36:39 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c090bfdsm4020057a91.8.2026.03.03.21.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:36:38 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 2/5] net/handshake: Define handshake_req_keyupdate
Date: Wed,  4 Mar 2026 15:34:57 +1000
Message-ID: <20260304053500.590630-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304053500.590630-1-alistair.francis@wdc.com>
References: <20260304053500.590630-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40CED1FAE2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263595-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,suse.de,gmail.com,wdc.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alistair23@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,wdc.com:mid,wdc.com:email,suse.de:email]
X-Rspamd-Action: no action

From: Alistair Francis <alistair.francis@wdc.com>

Add a new handshake_req_keyupdate() function which is similar to the
existing handshake_req_submit().

The new handshake_req_keyupdate() does not add the request to the hash
table (unlike handshake_req_submit()) but instead uses the existing
request from the initial handshake.

During the initial handshake handshake_req_submit() will add the request
to the hash table. The request will not be removed from the hash table
unless the socket is closed (reference count hits zero).

After the initial handshake handshake_req_keyupdate() can be used to re-use
the existing request in the hash table to trigger a KeyUpdate with
userspace.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v7:
 - No change
v6:
 - New patch

 net/handshake/handshake.h |  2 +
 net/handshake/request.c   | 97 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..04feacd1e21d 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -84,6 +84,8 @@ void handshake_req_hash_destroy(void);
 void *handshake_req_private(struct handshake_req *req);
 struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class);
+int handshake_req_keyupdate(struct socket *sock, struct handshake_req *req,
+			 gfp_t flags);
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
 void handshake_complete(struct handshake_req *req, unsigned int status,
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 2829adbeb149..5653c8f69dce 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -196,6 +196,103 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_req_next);
 
+/**
+ * handshake_req_keyupdate - Submit a KeyUpdate request
+ * @sock: open socket on which to perform the handshake
+ * @req: handshake arguments, this must already be allocated and exist
+ * in the hash table, which happens as part of handshake_req_submit()
+ * @flags: memory allocation flags
+ *
+ * Return values:
+ *   %0: Request queued
+ *   %-EINVAL: Invalid argument
+ *   %-EBUSY: A handshake is already under way for this socket
+ *   %-ESRCH: No handshake agent is available
+ *   %-EFAULT: An initial handshake hasn't happened yet
+ *   %-EAGAIN: Too many pending handshake requests
+ *   %-ENOMEM: Failed to allocate memory
+ *   %-EMSGSIZE: Failed to construct notification message
+ *   %-EOPNOTSUPP: Handshake module not initialized
+ *
+ * A zero return value from handshake_req_submit() means that
+ * exactly one subsequent completion callback is guaranteed.
+ *
+ * A negative return value from handshake_req_submit() means that
+ * no completion callback will be done and that @req has been
+ * destroyed.
+ */
+int handshake_req_keyupdate(struct socket *sock, struct handshake_req *req,
+			    gfp_t flags)
+{
+	struct handshake_net *hn;
+	struct net *net;
+	struct handshake_req *req_lookup;
+	int ret;
+
+	if (!sock || !req || !sock->file) {
+		kfree(req);
+		return -EINVAL;
+	}
+
+	req->hr_sk = sock->sk;
+	if (!req->hr_sk) {
+		kfree(req);
+		return -EINVAL;
+	}
+	req->hr_odestruct = req->hr_sk->sk_destruct;
+	req->hr_sk->sk_destruct = handshake_sk_destruct;
+
+	ret = -EOPNOTSUPP;
+	net = sock_net(req->hr_sk);
+	hn = handshake_pernet(net);
+	if (!hn)
+		goto out_err;
+
+	ret = -EAGAIN;
+	if (READ_ONCE(hn->hn_pending) >= hn->hn_pending_max)
+		goto out_err;
+
+	spin_lock(&hn->hn_lock);
+	ret = -EOPNOTSUPP;
+	if (test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags))
+		goto out_unlock;
+
+	ret = -EFAULT;
+	req_lookup = handshake_req_hash_lookup(sock->sk);
+	if (!req_lookup)
+		goto out_unlock;
+
+	ret = -EBUSY;
+	if (req_lookup != req)
+		goto out_unlock;
+	if (!__add_pending_locked(hn, req))
+		goto out_unlock;
+	spin_unlock(&hn->hn_lock);
+
+	test_and_clear_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags);
+
+	ret = handshake_genl_notify(net, req->hr_proto, flags);
+	if (ret) {
+		trace_handshake_notify_err(net, req, req->hr_sk, ret);
+		if (remove_pending(hn, req))
+			goto out_err;
+	}
+
+	/* Prevent socket release while a handshake request is pending */
+	sock_hold(req->hr_sk);
+
+	trace_handshake_submit(net, req, req->hr_sk);
+	return 0;
+
+out_unlock:
+	spin_unlock(&hn->hn_lock);
+out_err:
+	trace_handshake_submit_err(net, req, req->hr_sk, ret);
+	handshake_req_destroy(req);
+	return ret;
+}
+EXPORT_SYMBOL(handshake_req_keyupdate);
+
 /**
  * handshake_req_submit - Submit a handshake request
  * @sock: open socket on which to perform the handshake
-- 
2.53.0


