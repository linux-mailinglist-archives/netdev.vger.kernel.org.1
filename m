Return-Path: <netdev+bounces-257101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLHtIzpphGlK2wMAu9opvQ
	(envelope-from <netdev+bounces-257101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:56:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCFBF114B
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9C6F30028DB
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3AA3A4F2A;
	Thu,  5 Feb 2026 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wf9jhr3g"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F032D6409
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285364; cv=none; b=u8keuOi+MoXYKShfSDdkurfTaBDksjJKV54cD53Kx530PwNTf8P8vAUQ38APLOquh6X457V35sDTUbnH5KTe8rAbaSKZfRKMA2KYFtk4bn0Dt2emUC+7lAPISb5zm+ZEWHKZD4GGrsmCYysM5aFmPgL8G0OZLG34El5rrUse7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285364; c=relaxed/simple;
	bh=eqzjzo5DcQB9Qfn72slBQYIh86a4zuRQ0G7L5yogh98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TF+hNiXgVQGYkp1G2NiPnjZOZt+9FCZ0tvLmU3OfMGwuIV6h/b/EW1x9JY1s+IaxBjWzEyPc8Bz+PJCKQmNXs6HeSPVfOYUah4KZi+/L297f/MemV0SnqcUQZGPfb3e4r8d5aOEk3Z5S3/fSfwnGq6SM2TcaZSpnNsuxFQKYu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wf9jhr3g; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770285360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CBZal96/5iv98/D8Xx6j7hGaRbCwYff2dWUOOY7k/K8=;
	b=wf9jhr3gQDfQ9VQ58P2jFXGJmXOq2IRZynFuGLoJ5XiDUAMth4z3uPfQhmdxSxHZZKarZk
	FidUrVFPSqrilWOuFN3vYFqm5hm4wWn3Rw/Dgva022EFZi7KwPW9UiJ/VOmRk9XSqWdEnJ
	E0GyElP/AYWG6oGRtRGyIciB2d2nXMc=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] net: atm: fix crash due to unvalidated vcc pointer in sigd_send()
Date: Thu,  5 Feb 2026 17:54:51 +0800
Message-ID: <20260205095501.131890-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257101-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,1f22cb1769f249df9fa0];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,appspotmail.com:email]
X-Rspamd-Queue-Id: 7FCFBF114B
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Reproducer available at [1].

The ATM send path (sendmsg -> vcc_sendmsg -> sigd_send) reads the vcc
pointer from msg->vcc and uses it directly without any validation. This
pointer comes from userspace via sendmsg() and can be arbitrarily forged:

    int fd = socket(AF_ATMSVC, SOCK_DGRAM, 0);
    ioctl(fd, ATMSIGD_CTRL);  // become ATM signaling daemon
    struct msghdr msg = { .msg_iov = &iov, ... };
    *(unsigned long *)(buf + 4) = 0xdeadbeef;  // fake vcc pointer
    sendmsg(fd, &msg, 0);  // kernel dereferences 0xdeadbeef

In normal operation, the kernel sends the vcc pointer to the signaling
daemon via sigd_enq() when processing operations like connect(), bind(),
or listen(). The daemon is expected to return the same pointer when
responding. However, a malicious daemon can send arbitrary pointer values.

Fix this by introducing find_get_vcc() which validates the pointer by
searching through vcc_hash (similar to how sigd_close() iterates over
all VCCs), and acquires a reference via sock_hold() if found.

Since struct atm_vcc embeds struct sock as its first member, they share
the same lifetime. Therefore using sock_hold/sock_put is sufficient to
keep the vcc alive while it is being used.

Note that there may be a race with sigd_close() which could mark the vcc
with various flags (e.g., ATM_VF_RELEASED) after find_get_vcc() returns.
However, sock_hold() guarantees the memory remains valid, so this race
only affects the logical state, not memory safety.

[1]: https://gist.github.com/mrpre/1ba5949c45529c511152e2f4c755b0f3
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69039850.a70a0220.5b2ed.005d.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/atm/signaling.c | 56 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/net/atm/signaling.c b/net/atm/signaling.c
index e70ae2c113f9..358fbe5e4d1d 100644
--- a/net/atm/signaling.c
+++ b/net/atm/signaling.c
@@ -22,6 +22,36 @@
 
 struct atm_vcc *sigd = NULL;
 
+/*
+ * find_get_vcc - validate and get a reference to a vcc pointer
+ * @vcc: the vcc pointer to validate
+ *
+ * This function validates that @vcc points to a registered VCC in vcc_hash.
+ * If found, it increments the socket reference count and returns the vcc.
+ * The caller must call sock_put(sk_atm(vcc)) when done.
+ *
+ * Returns the vcc pointer if valid, NULL otherwise.
+ */
+static struct atm_vcc *find_get_vcc(struct atm_vcc *vcc)
+{
+	int i;
+
+	read_lock(&vcc_sklist_lock);
+	for (i = 0; i < VCC_HTABLE_SIZE; i++) {
+		struct sock *s;
+
+		sk_for_each(s, &vcc_hash[i]) {
+			if (atm_sk(s) == vcc) {
+				sock_hold(s);
+				read_unlock(&vcc_sklist_lock);
+				return vcc;
+			}
+		}
+	}
+	read_unlock(&vcc_sklist_lock);
+	return NULL;
+}
+
 static void sigd_put_skb(struct sk_buff *skb)
 {
 	if (!sigd) {
@@ -69,7 +99,14 @@ static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 
 	msg = (struct atmsvc_msg *) skb->data;
 	WARN_ON(refcount_sub_and_test(skb->truesize, &sk_atm(vcc)->sk_wmem_alloc));
-	vcc = *(struct atm_vcc **) &msg->vcc;
+
+	vcc = find_get_vcc(*(struct atm_vcc **)&msg->vcc);
+	if (!vcc) {
+		pr_debug("invalid vcc pointer in msg\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	pr_debug("%d (0x%lx)\n", (int)msg->type, (unsigned long)vcc);
 	sk = sk_atm(vcc);
 
@@ -100,7 +137,16 @@ static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 		clear_bit(ATM_VF_WAITING, &vcc->flags);
 		break;
 	case as_indicate:
-		vcc = *(struct atm_vcc **)&msg->listen_vcc;
+		/* Release the reference from msg->vcc, we'll use msg->listen_vcc instead */
+		sock_put(sk);
+
+		vcc = find_get_vcc(*(struct atm_vcc **)&msg->listen_vcc);
+		if (!vcc) {
+			pr_debug("invalid listen_vcc pointer in msg\n");
+			dev_kfree_skb(skb);
+			return -EINVAL;
+		}
+
 		sk = sk_atm(vcc);
 		pr_debug("as_indicate!!!\n");
 		lock_sock(sk);
@@ -115,6 +161,8 @@ static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 		sk->sk_state_change(sk);
 as_indicate_complete:
 		release_sock(sk);
+		/* Paired with find_get_vcc(msg->listen_vcc) above */
+		sock_put(sk);
 		return 0;
 	case as_close:
 		set_bit(ATM_VF_RELEASED, &vcc->flags);
@@ -131,11 +179,15 @@ static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 		break;
 	default:
 		pr_alert("bad message type %d\n", (int)msg->type);
+		/* Paired with find_get_vcc(msg->vcc) above */
+		sock_put(sk);
 		return -EINVAL;
 	}
 	sk->sk_state_change(sk);
 out:
 	dev_kfree_skb(skb);
+	/* Paired with find_get_vcc(msg->vcc) above */
+	sock_put(sk);
 	return 0;
 }
 
-- 
2.43.0


