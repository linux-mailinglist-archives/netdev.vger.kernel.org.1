Return-Path: <netdev+bounces-285564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CPhJh8r/WkJYgAAu9opvQ
	(envelope-from <netdev+bounces-285564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 02:15:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA46B4F0701
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 02:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8679930075D4
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 00:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104F118EFD1;
	Fri,  8 May 2026 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9qgO/B4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696213D539
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199325; cv=none; b=ppDS87wM1jf/ecY5csvUvqp/IOQxYgPlQeGhlIgCbh7uZIweKFSH6Vx+wJgYDZlMzdK2GGmrgDkQd+8gGUIUBRHIvZK/wqFMJX6cJP9VErVa9acRyxJKmWqj5mDqiG+aFOkGBlPmmYmyO7jf0yaGkKeQoZ9mhSOdwkQ4nwHnicc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199325; c=relaxed/simple;
	bh=SKEeViFbp1uXUSYeHb372Uw+KJNAO1yOkAXwhXCVyQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0akM+iXWZcoQCMptsS7O82NuPd2wtSHzg5liHy8SPBygRj/kx/ljzOsR5pL9gzYyz07oxXZ95Ww7mBjoDlX33Z2EAZ/J3AMBs2wdGEXsJ0+Awvm0QJ+jWnPYx0JDc84v/iD8CxHfRWazOP0r9h5P6xCKSz4r27BO2Cxvmlir+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9qgO/B4; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so882743eec.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 17:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778199323; x=1778804123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7LQCxTjl/7QlKwFcwi4/FESx78z4DYB8yBxbbODWZwc=;
        b=n9qgO/B4xR/jX45b67IAoPWeP6O8vPd3ZC3fn0rtRW/Cn4hailsG1MIWMeDH32+cqV
         VvDB/4WQBRHVQl7YmuiQNa9pI9033C7Ax4n4vxO1RD3YNwejSFZcRLtGLHDBz23k1zM8
         6bGjewXsaYPUeT/P6CwDZC4GnNn2heEZWAyGhFlKTm4EZcGRtYSIrRdzirI4jrlg6ij7
         SXNPKahH7sykQmgYsL3Yau0DTEznYS+pH/V4TqZZp846h5pljX29MCBqP+2Ut1D8kGTv
         Vm0cjK5GLZtUj7ef8/kKp1i0oDXa5v7CU/Jsx4nadhNJEin1j7JRgopiFxfiiY1EQA7e
         OSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778199323; x=1778804123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LQCxTjl/7QlKwFcwi4/FESx78z4DYB8yBxbbODWZwc=;
        b=hUFvr6gxbj5Z81C7w45N4VWs9PnGx1cD7LLRd820JKwTOraqlLpHfEGrEVGC1+OUvM
         VCT4uEhW0kV1thqmcHbIYlVxIK3c9+OLGTgtENBNdN4l2OcdaueN9/HH0KCMc8g8g5Nv
         mUHixqzJGs9RzjJMNWtoYYsSB/SWzu+jnvANieV38SYdFJRZMyJ0iV6YBy3vvGnpGX5O
         yb/DxeViIngsrJNoPD7zvpQsxW2Od6z3q9ZmfAU1+SFBpH/iJgRwFVUN57t4BP16A5D3
         Ys6Yv60N8vOVbejYTDkfrtYLkxnWIgrRXtFNK7eJPEtpBm4ckKU0jcSB99ymN1xYnpfR
         5Pwg==
X-Forwarded-Encrypted: i=1; AFNElJ/OWOEYpiCqd9thCoQYOJ6CHKYwFr37BtXoBIpzjiari7n+UYP4bgUfp/vrq+ew2y3HaXlKKIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/I+AkYXEDNrl4C0oDO0L3mPQ2YONH1+/17i6LV7auQysP5WZ
	gS16KF4J1qF7qrHFg/0n9AR5mp92TfsL1WUi5ZgW8fTSR9ak/BYPo/do
X-Gm-Gg: Acq92OFz1rb5D9JhOUNXI6fW3ExaR3wyKWdEjhHBzn1Y7A3SYlZx3BRbxzQv87/2KxX
	wEMMTzGQBySTCMxM4burnb5Yge0jpIKtMSofSMBlgg1v8KqwLySEgZotS2M2YCYJ0cAOCvK5ml9
	1folS2CDnt203L4m9nRMUJ3XiereE1iZYcAdSUE8y6hMY7lA3AhVzvax4yIGonxWAJG6kk9DWx0
	MQE79SdY2GhFN2mKr/+I6oMaPOcvkwXEGL7M8A4IosSwu0q7d8TYsd2Q3rH74tWCMcImgUwfjq7
	sDZRnTs6N1A4QVnCBRoxGZnibaUvT2IB85hnZPevOarlvo7qYt1/PLpwSnmzKcKUA90efm0iWGA
	cB+O7GJ1YLE9rnEJX+MN67ehLJHwv+mz8vekeuUEqAHVjmPzH8ERZtXLRweJLKflfR/uc8Po95K
	MQSizpi5dPbLoa89sC3bo5dv433G/jAUMdq65SDi4Et1UvTU/F
X-Received: by 2002:a05:7300:e82b:b0:2ca:7eb4:3e0f with SMTP id 5a478bee46e88-2f54b897f52mr5070659eec.5.1778199322328;
        Thu, 07 May 2026 17:15:22 -0700 (PDT)
Received: from bmorris-M3Y3522M42 ([136.24.56.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafc2sm103309eec.4.2026.05.07.17.15.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 May 2026 17:15:21 -0700 (PDT)
From: joycathacker@gmail.com
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Ben Morris <bmorris@anthropic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL
Date: Thu,  7 May 2026 17:14:55 -0700
Message-ID: <20260508001455.3137-1-joycathacker@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA46B4F0701
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285564-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joycathacker@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anthropic.com:email]
X-Rspamd-Action: no action

From: Ben Morris <bmorris@anthropic.com>

The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
list_for_each_entry_safe(), which caches the next entry in @tmp before
the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
drop the socket lock inside sctp_wait_for_sndbuf().

While the lock is dropped, another thread can SCTP_SOCKOPT_PEELOFF the
association cached in @tmp, migrating it to a new endpoint via
sctp_sock_migrate() (list_del_init() + list_add_tail() to
newep->asocs), and optionally close the new socket which frees the
association via kfree_rcu().  The cached @tmp can also be freed by a
network ABORT for that association, processed in softirq while the
lock is dropped.

sctp_wait_for_sndbuf() revalidates @asoc (the current entry) on re-lock
via the "sk != asoc->base.sk" and "asoc->base.dead" checks, but nothing
revalidates @tmp.  After a successful return, the iterator advances to
the stale @tmp, yielding either a use-after-free (if the peeled socket
was closed) or a list-walk onto the new endpoint's list head (type
confusion of &newep->asocs as a struct sctp_association *).

Both are reachable from CapEff=0; the type-confusion path gives
controlled indirect call via the outqueue.sched->init_sid pointer.

Fix by re-deriving @tmp from @asoc after sctp_sendmsg_to_asoc()
returns.  @asoc is known to still be on ep->asocs at that point: the
only callers that list_del an association from ep->asocs are
sctp_association_free() (which sets asoc->base.dead) and
sctp_assoc_migrate() (which changes asoc->base.sk), and
sctp_wait_for_sndbuf() checks both under the lock before any
successful return; a tripped check propagates as err < 0 and the loop
bails before the re-derive.

The SCTP_ABORT path in sctp_sendmsg_check_sflags() returns 0 and the
loop hits 'continue' before sctp_sendmsg_to_asoc() is ever called, so
the @tmp cached by list_for_each_entry_safe() still covers the
lock-held free that ba59fb027307 ("sctp: walk the list of asoc
safely") was added for.

Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL process in sendmsg")
Cc: stable@vger.kernel.org
Assisted-by: claude:mythos
Signed-off-by: Ben Morris <bmorris@anthropic.com>
---
 net/sctp/socket.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 58d0d9747f0b..1d2568bb6bc2 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1986,6 +1986,15 @@ static int sctp_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_len)
 				goto out_unlock;

 			iov_iter_revert(&msg->msg_iter, err);
+
+			/* sctp_sendmsg_to_asoc() may have released the socket
+			 * lock (sctp_wait_for_sndbuf), during which other
+			 * associations on ep->asocs could have been peeled
+			 * off or freed.  @asoc itself is revalidated by the
+			 * base.dead and base.sk checks in sctp_wait_for_sndbuf,
+			 * so re-derive the cached cursor from it.
+			 */
+			tmp = list_next_entry(asoc, asocs);
 		}

 		goto out_unlock;
--
2.43.0

