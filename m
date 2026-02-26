Return-Path: <netdev+bounces-261252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHbGKA8OoGnbfQQAu9opvQ
	(envelope-from <netdev+bounces-261252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:10:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E89461A32E5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E09A30AC864
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC49039900E;
	Thu, 26 Feb 2026 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9jHG6mU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8239526D
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096302; cv=none; b=ulfp8SFRt1Ai+M1vCWZRbcAMBAC5YPNvWoe/wk7BVnEDyiF/GuouGNIZ+xwtu7NikPxq9+GNVuYVO0lULONuKFOWfOt0eZSnuzvRr73mxSZIlYpHSzNW2khvnd4wTr69TrflefzGknC6TY/U46+Z7fxrHOiXikvn+fT5nz4mtdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096302; c=relaxed/simple;
	bh=SlOHjbFT6bgglmBCcv8V5rdB3omMjR2vXC7pzkgZVik=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MVI6ehJVS+Q5UB+OdXxR0JAmH39y5EztmOV6EqOVk30p6PC9weSwEdsdkpqMvrjXI0h3KlZetwBQCbSQt+v6oQhj+lIv0gW0Xjk3/q7xjIfS+Jj2O5v/SjSV0CrnkqYT980XSpgFVHIiPFRAEba/dswuHAYboa0LHmjCVVrKCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9jHG6mU; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-503915b0a88so109436711cf.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 00:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772096298; x=1772701098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0wuPspiPv1csZE43cGiBpIC+UQAJFmaKX0o5kmlUK68=;
        b=n9jHG6mULKfDQlh4lWSJVn4TClmcBExfDhWyIgUW/K8fkb/spUSmqiYHO3cUqilygo
         DMRy/k1H2e2XjWiVEQewd0NCA2nN/JoBs72JBjM+LB/GWmoxmVoJHxHzGRR8NQ6UcWcA
         XcTR1lqQH5u+GoyX9A2/x7Za7KCHpyAxZ+U2rnCLqS50ZAlujmHj+8viI4ATDZY4Ez0W
         Z7qCbyRy94RY6fiV+wPwe1BQsbpdja6czLPYqXGRRPVkLzd4aRttujJGBx1LA3nu+oVn
         8CRqCsZOyWMIR4z+CSu0cpE22h+hBW8cyjDyWZTrzyH2b2WsZm7RzFQHcFwDcE/3jgEH
         l3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772096298; x=1772701098;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wuPspiPv1csZE43cGiBpIC+UQAJFmaKX0o5kmlUK68=;
        b=Ce/ArZwd4nKT8bUR4m8zis6wykYMNjO4srEkM5kkEvXQoo5qBnxfoZFi8UtNVKyeqO
         91bYLARO381pMB4/ru/yXfiwc6FmbRlKub8DnMV7JmkEjpo0wUF7GMVxJ1cOtBc5v019
         M2ndAud4oPlc+TEuwAaOjXAl0Ub37MqHIxqZvfp7VicmZBuYZqw5lRrPRtxm/X2KQ8Fg
         4bj1u1I6djcgfydLuomiM801XYr651bNxP9rDPagyynF4m/E1MG7TjQHRa97NZUBSLVr
         VNbd5q7d8cOGsDu198bt7ACshhhp9FdLpKJbxhd+g/8WSCua53wU77TQbL4H0PYJ9aHJ
         vUyw==
X-Gm-Message-State: AOJu0YxIcStNV3LZgEXu0xKP9bfvrT1ut5Ovz5gKcH7s5/TFxT08LhBe
	IyfKV87Oyv2mvLKoFQ7GDGzgc/gfeYUgfpsE3HadgnQXVMmktXgoqBZ0hiYmJ4jqmq2ODhq5fvb
	JLvf5KBAFtpB49w==
X-Received: from qtxn14.prod.google.com ([2002:a05:622a:40e:b0:506:5118:a54f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5d4a:0:b0:4ed:b441:d866 with SMTP id d75a77b69052e-50741fbd9ecmr46698241cf.65.1772096298187;
 Thu, 26 Feb 2026 00:58:18 -0800 (PST)
Date: Thu, 26 Feb 2026 08:58:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226085816.2272259-1-edumazet@google.com>
Subject: [PATCH nf-next] netfilter: nfnetlink_log: no longer acquire sk_callback_lock
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261252-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E89461A32E5
X-Rspamd-Action: no action

After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
from Sebastian Andrzej Siewior, apply the same logic in
__build_packet_message() to avoid touching sk->sk_callback_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netfilter/nfnetlink_log.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index bfcb9cd335bff59fa4d0d09eb52943566e4098e7..bef28e5230bb3b4d4b1ef4d5111909bac969b343 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -611,19 +611,26 @@ __build_packet_message(struct nfnl_log_net *log,
 	/* UID */
 	sk = skb->sk;
 	if (sk && sk_fullsock(sk)) {
-		read_lock_bh(&sk->sk_callback_lock);
-		if (sk->sk_socket && sk->sk_socket->file) {
-			struct file *file = sk->sk_socket->file;
+		const struct socket *sock;
+		const struct file *file;
+
+		/* The sk pointer remains valid as long as the skb is.
+		 * The sk_socket and file pointer may become NULL
+		 * if the socket is closed.
+		 * Both structures (including file->cred) are RCU freed
+		 * which means they can be accessed within a RCU read section.
+		 */
+		sock = READ_ONCE(sk->sk_socket);
+		file = sock ? READ_ONCE(sock->file) : NULL;
+		if (file) {
 			const struct cred *cred = file->f_cred;
 			struct user_namespace *user_ns = inst->peer_user_ns;
 			__be32 uid = htonl(from_kuid_munged(user_ns, cred->fsuid));
 			__be32 gid = htonl(from_kgid_munged(user_ns, cred->fsgid));
-			read_unlock_bh(&sk->sk_callback_lock);
 			if (nla_put_be32(inst->skb, NFULA_UID, uid) ||
 			    nla_put_be32(inst->skb, NFULA_GID, gid))
 				goto nla_put_failure;
-		} else
-			read_unlock_bh(&sk->sk_callback_lock);
+		}
 	}
 
 	/* local sequence number */
-- 
2.53.0.414.gf7e9f6c205-goog


