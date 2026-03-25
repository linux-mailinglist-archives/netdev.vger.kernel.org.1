Return-Path: <netdev+bounces-271413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIHxFi2Dw2kPrQQAu9opvQ
	(envelope-from <netdev+bounces-271413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:39:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 138B1320409
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B06BD301A513
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE01359A65;
	Wed, 25 Mar 2026 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNyC3jlK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EEA35AC16
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420739; cv=none; b=udybo5iwdIyks9pu3ypWCoxak47MWyXJ0fPMoi2bEES6g27dRCucJTU0BRmkpSm8fjzaYha3C+Tx4y+KHx2+OEqz5VICj2xCeBrdfHBR9wjLS0j72YMU3i5RqYSDQqo7qYT3HBx97WR9afLHpcf1n8VwUHhqqQGnQOaisQ3MSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420739; c=relaxed/simple;
	bh=xSf4roTmD9ZMdpxhwYlICgfBMcunW+WN6mwr5Hlp4MY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FDDcJ7yaj5QUu42fXw+fUR1p421RJEgEdSUzzcPIkFYb7ZCgxq82GnTha3dJDkFoHWQhUyk6KdzpEjmR1mqstNLqXkWupErtDuTrkynlbicY3Ypousy4xOy756F+io2qFi/MyNbh/WKINfb9JMnysv9pdPea3G4MVPJm0Gan9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNyC3jlK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c714cb65eso339775b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 23:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420737; x=1775025537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5KS0AwVtElapM67R1okpaPmVE6Ykz6fWReVphg8duc=;
        b=UNyC3jlKsoguNisdsVx+HIxmH90c0kKfWQmT95i1ViovTqzuOfgj7Li0IoABkrTdZm
         vE3HNgquijw7aPaIbSUY5AHfuKZaQcZjgjuxLAjIoxJ8hnfODTJMV8ZemBcrfNv2dtNY
         DhsRDJtLxuyGhbd8fpAaYcxNqg9oiXyNk3WclV8InjH8hfEYVhlymvjrDylyhWRiZ7Le
         BScXjOpEPHwn5OdN3X5sRLRoFAj3M+akjLGQzT8A+zFnrD5E+dyo6TCCvMJ93QliiB3r
         OgEcJrLagxHNpkvJ8VywEoLv7WwAxKDuKeEdP+EGuKx1cdQVzFHFL4er0sjcX2y4rG+B
         zvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420737; x=1775025537;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5KS0AwVtElapM67R1okpaPmVE6Ykz6fWReVphg8duc=;
        b=cUZZPWi2juW13bZmgd6UzvHjGoz+MELQT2+nvKuboJgK63i6LkWjnPaSeK66fAS/UT
         khd7B0GJM4uJJCcdtVU2G1zL/40Ydf4bEJTZtKuZySpdNzkoENw1TtIbZRof4eK1Jy26
         4GHOsl1lMYN+quBefZEvz/tKSrUDUf5EsuNs5ECjDYKt5XciJy8E0JzDsGlr6hHdrljp
         G00cYR+wCcrq4jN/MPIxKALpQuv3XFDD6vxoX201pq+vDC+yZmwuVg38eboa9TBH6Ryl
         Lll2C6RUt2g7m+kBBOy36nhHPN13SW6Q/WsEvhuPMazj9fKH3BXcH5G8mCKZw6bK+PKz
         dkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSdmgD/GD262jJlIeV6QWRhZrIwKYiIZ67pz+d1eC6Iqlgk0s/uwyK12Oyx3fTOSEuxx/wjpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRBzGM2APRRYRc9IME7TeF/BSxES7jGMumtQJGnKtdUqCYKaq
	u/8Ccbx6gdPNger+JoxE99ge4Kgf00qD1TmcOdjNYHLCiFrSXCVNazEEAolPx7OqSJVPk9t8X/u
	P6P/O+g==
X-Received: from pfbmy7-n2.prod.google.com ([2002:a05:6a00:6d47:20b0:822:4e8c:2c9e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1acf:b0:7f7:2f82:9904
 with SMTP id d2e1a72fcca58-82c6de992dcmr2345147b3a.5.1774420736872; Tue, 24
 Mar 2026 23:38:56 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:24 +0000
In-Reply-To: <20260325063843.1790782-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325063843.1790782-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-4-kuniyu@google.com>
Subject: [PATCH 3/5] net: Introduce lock_sock_try().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271413-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,other.debian.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 138B1320409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot has reported 100+ possible deadlock splats involving NBD,
typically following this pattern:

  lock_sock(sk)
  -> GFP_KERNEL memory allocation
     -> fs reclaim
       -> lock_sock(sk) at NBD

Before calling sock_sendmsg() or sock_recvmsg(), NBD sets
sk->sk_allocation to GFP_NOIO to prevent fs reclaim from being
triggered during memory allocation for the backend socket.

However, even after a socket is passed to NBD, it remains
exposed to userspace and thus can exercise various slow paths
under lock_sock(), where GFP_KERNEL is used directly instead
of sk->sk_allocation, leading to the deadlock.

Some of those paths do not currently have a reference to struct
sock, and plumbing the sk pointer through the call chain just to
fix the allocation flags would be extremely cumbersome.

Even with that, lockdep would not be happy because such a path
could be exercised before passing the socket to NBD, and then
lockdep would learn that the path could trigger fs reclaim.

Additionally, since the socket is exposed to userspace, we
cannot change the lockdep key (even for sk->sk_lock.dep_map,
due to lock_sock_fast()).

We could spread memalloc_noio_{save,restore} over the networking
code, but we want to avoid that and solve it in the NBD layer,
which requires the trylock variant of lock_sock().

Let's introduce lock_sock_try() for that purpose.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 6c9a83016e95..69e4b8d17afb 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1710,6 +1710,37 @@ static inline void lock_sock(struct sock *sk)
 }
 
 void __lock_sock(struct sock *sk);
+
+/**
+ * lock_sock_try - trylock version of lock_sock
+ * @sk: socket
+ *
+ * Use of this function is strongly discouraged.
+ *
+ * It is primarily intended for NBD, where the driver must avoid
+ * deadlock during fs reclaim caused by the backend socket remaining
+ * exposed to userspace even after being handed over to NBD,
+ * which _is_ bad but too late to change.
+ *
+ * Return: true if the lock was acquired, false otherwise.
+ */
+static inline bool lock_sock_try(struct sock *sk)
+{
+	if (!spin_trylock_bh(&sk->sk_lock.slock))
+		return false;
+
+	if (sk->sk_lock.owned) {
+		spin_unlock_bh(&sk->sk_lock.slock);
+		return false;
+	}
+
+	sk->sk_lock.owned = 1;
+	spin_unlock_bh(&sk->sk_lock.slock);
+
+	mutex_acquire(&sk->sk_lock.dep_map, 0, 1, _RET_IP_);
+	return true;
+}
+
 void __release_sock(struct sock *sk);
 void release_sock(struct sock *sk);
 
-- 
2.53.0.1018.g2bb0e51243-goog


