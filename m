Return-Path: <netdev+bounces-289547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJj3I6udDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:28:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4255830C6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DDC530589B8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C845D30C150;
	Tue, 19 May 2026 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL0a7HcA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559F26E718
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211602; cv=none; b=HTF3ijD52n6P8aJy9Y1BSEsgje8ruwb6vsF3QUqi45KcxvRlCwUo+7G47YT7bIPo7VqEaMPne9mWoJEuNYspRiYekqYJVAeHlohECRdJA/X0EY6i/HpkZVaH67wJIXp+UNUpG+N7lzXU/yZg19qaVmONNbjAQtlSEku4k2okTeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211602; c=relaxed/simple;
	bh=egYyu/i+xaZaoDb0v9SpMFsflxy9+neCAhZXc7GqhbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+0P6xv50bUmcQjUJJeDZudwJbpT3J0qN4Y431EKjLD6I2HDvhApCbt/IXYUfcB0kaU7u7hD7R3tm7v57t4jaY3YgFFW9qmDxsoGrxy/IE0+n19hV1Acsrlv5XbXGbTWgdebTN+ZWiWspCNMBIOIzAK7Mu3fMYNrlN7bzz6n+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL0a7HcA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490227b682cso648965e9.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779211599; x=1779816399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1jbRD0zuDAkT/iOMZCuQC1mbw0VTyeq/zm8Dbw1smrw=;
        b=OL0a7HcAqs1a/9RxYMErmtMmMwyloN3x4w5/kAYtSlD8uHq6WZF+y1rcgnGb1Ts1Pq
         mE6ftoLWjoCn+GJSJrzqFK+W1XdLmq6dcFOQmJCkXZKkZhfPGwKKZ/RaCfZ1sgw6NgCe
         3hhAGwIxJycZP9LHjdGrkkUWCF3xlp8BfHZsJzxysdWC1tud+/zXC4ZZoFip8mO6bDlv
         SP6cXoZ1HhUF3f7T6tbm+qYyQx5MtXgY80dENYTfH9wzFqg5SUUOOO1KobR8l8oZscy1
         aCjm9mGcp9NSJhQfkJE7wPgwQ2P8Z2CZeCkrrAmyKCLoOLulJfG0WNfANRRRhk2Uqk7+
         Letw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211599; x=1779816399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jbRD0zuDAkT/iOMZCuQC1mbw0VTyeq/zm8Dbw1smrw=;
        b=Io2Fz/rbBk8ZUJGXxZFFiCcYF4c+/aMp5uIUibN0LOVaygUryRz42IdBhYR3V7HhEd
         LC1zXONI1YwztVApFXJrfS71tqrdqdrKrKXPk09hs9gyn9pb/p4iOPczHmq+H/TrurkJ
         AxLnK7eOhY+tvEKaDsCnrXR4ULs1pOSrFtLb7Kq6BUFqGIvMYsFyJMZK1vIxM3rd3cbG
         IBiRZ7ptwzj8ruamEAwDhn56I4TucWPqcMjUX/V2+a9H2uGiT48BHto6SIcCb5dbW7UW
         NB21X8/x+owHp/LX9lvg3wB++2mKQ2+Ow8NHwADF1rjDATJ5pqoOCMQcX2igSAI5m9k3
         fFBw==
X-Forwarded-Encrypted: i=1; AFNElJ/gUCIotRJ+kX6+irLX6dAj2t7czTv3v+HEL3ro7/q2/vAOvN2Fh8o7ijEaxH/n/T81P176yHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWpU9f+NVJyN15gk/hLcwtnNcfsoS5/zEjr2F4Sox8QaiIdqj
	GARkBpe47VznXUpGgns16/LZlwTfWfoPxQ/teucNDACh8RaU3cAiQIXy
X-Gm-Gg: Acq92OEWfQif1zHRlc/eywDxYavt1XvdctHnI7hmdwDRmnbS1SPFZaDPyVpt3uvlcjr
	CysbRxXJYRddJTnZzkpiXmWmXknZbveK7LLp6iBIYfoCdzZMoytPKnM/hDRNkGVW8j6bE04lrpd
	nkfhXjDAyzvxS+ZFHFxMiLACgZ4c6tq4FE749gScqi0GzXYUBHptc7EmK8uaJYv+mFPEGkYnsSx
	sk9+xQz/ziKvSBg79pKoMOFoTufv/P0rhzUyqyfpirG2D7DbmT91WED18oXH4r3xW+KXvujw/yu
	Ays3x+BSN9aYc1CoMtjAC/81/TS33nGWgRuxQHsDrD6dY8oB9B6snFpbR31ShZVj15efEHn697h
	2dr6p1RJxDbECRGA2f4ixPbqJL0QMS7Bc6vLXgDyeThciyveLcfBZZPiPe40pvboux6U3dOipxD
	11cd+0AykwTUvhtX0jF2EHy2PwqKOMFJY1vizzMQLmO7lVDmrb2Ua5/vI1aOUQRPdIRtwM0sjdO
	dG6Tp8=
X-Received: by 2002:a05:600c:a48:b0:489:e696:127d with SMTP id 5b1f17b1804b1-48fe63022e8mr142076495e9.5.1779211599195;
        Tue, 19 May 2026 10:26:39 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feae166dasm128269335e9.9.2026.05.19.10.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:26:38 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: Remi Denis-Courmont <courmisch@gmail.com>
Cc: Zijing Yin <yzjaurora@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] phonet/pep: disable BH around forwarded sk_receive_skb()
Date: Tue, 19 May 2026 10:26:33 -0700
Message-ID: <20260519172635.86304-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289547-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,pastebin.com:url]
X-Rspamd-Queue-Id: 0A4255830C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The networking receive path is usually run from softirq context, but
protocols that take the socket lock may have packets stored in the
backlog and processed later from process context. In that case
release_sock() -> __release_sock() drops the slock with spin_unlock_bh()
and then calls sk->sk_backlog_rcv() with bottom halves enabled.

Typical sk_backlog_rcv handlers process the socket whose backlog is
being drained, so the BH state at entry is irrelevant for the slocks
they touch. pep_do_rcv() is different: when the inbound skb targets an
existing PEP pipe, it forwards the skb to a different *child* socket
via sk_receive_skb(). That helper takes the child slock with
bh_lock_sock_nested(), which is just spin_lock_nested() and assumes BH
is already off. The same child slock therefore ends up acquired with
BH on (process path) and with BH off (softirq path):

  process context                   softirq context
  ---------------                   ---------------
  release_sock(listener)            __netif_receive_skb()
   __release_sock()                  phonet_rcv()
    spin_unlock_bh()                  __sk_receive_skb(listener)
    [BH now ENABLED]                  [BH already disabled]
    sk_backlog_rcv:                   sk_backlog_rcv:
     pep_do_rcv()                      pep_do_rcv()
      sk_receive_skb(child)             sk_receive_skb(child)
       bh_lock_sock_nested(child)        bh_lock_sock_nested(child)
       => SOFTIRQ-ON-W                   => IN-SOFTIRQ-W

Lockdep flags this as inconsistent lock state, and it can become a real
self-deadlock if a softirq on the same CPU tries to receive to the same
child socket while its slock is held in the BH-enabled path:

  WARNING: inconsistent lock state
  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
   (slock-AF_PHONET/1){+.?.}-{3:3}, at: __sk_receive_skb+0x1cf/0x900
    __sk_receive_skb              net/core/sock.c:563
    sk_receive_skb                include/net/sock.h:2022 [inline]
    pep_do_rcv                    net/phonet/pep.c:675
    sk_backlog_rcv                include/net/sock.h:1190
    __release_sock                net/core/sock.c:3216
    release_sock                  net/core/sock.c:3815
    pep_sock_accept               net/phonet/pep.c:879

Wrap the forwarded sk_receive_skb() in local_bh_disable() /
local_bh_enable() so the child slock is always acquired with BH off.
local_bh_disable() nests safely on the softirq path.

Discovered via in-house syzkaller fuzzing; the same root cause also
on the linux-6.1.y syzbot dashboard as extid 44f0626dd6284f02663c.
Reproduced under KASAN + LOCKDEP + PROVE_LOCKING, reproducer:
https://pastebin.com/A3t8xzCR

Fixes: 9641458d3ec4 ("Phonet: Pipe End Point for Phonet Pipes protocol")
Link: https://syzkaller.appspot.com/bug?extid=44f0626dd6284f02663c
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
 net/phonet/pep.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 4dbf0914df7d..cc6226cc4343 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -671,8 +671,23 @@ static int pep_do_rcv(struct sock *sk, struct sk_buff *skb)
 
 	/* Look for an existing pipe handle */
 	sknode = pep_find_pipe(&pn->hlist, &dst, pipe_handle);
-	if (sknode)
-		return sk_receive_skb(sknode, skb, 1);
+	if (sknode) {
+		int rc;
+
+		/*
+		 * pep_do_rcv() runs from two contexts: from softirq via
+		 * phonet_rcv() -> __sk_receive_skb() with BH disabled, and from
+		 * process context via release_sock() -> __release_sock(), which
+		 * drops the listener slock with spin_unlock_bh() before draining
+		 * the backlog.  The child pipe slock is taken below via
+		 * bh_lock_sock_nested(), which does not itself disable BH, so
+		 * disable BH here to keep both acquire contexts consistent.
+		 */
+		local_bh_disable();
+		rc = sk_receive_skb(sknode, skb, 1);
+		local_bh_enable();
+		return rc;
+	}
 
 	switch (hdr->message_id) {
 	case PNS_PEP_CONNECT_REQ:

base-commit: edc502717be153674b0b3eefb8b40734c747c138
-- 
2.43.0


