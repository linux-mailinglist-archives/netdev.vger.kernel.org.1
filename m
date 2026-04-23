Return-Path: <netdev+bounces-280877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MDxNSaP6mn10gIAu9opvQ
	(envelope-from <netdev+bounces-280877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:29:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 149AE457E03
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 752D43004607
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33083BFE2F;
	Thu, 23 Apr 2026 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pE+/QREI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32FE3B2FDA
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979737; cv=none; b=TKhWuew48NPzNEgnFUPLUSUbbjxBzuT/MdvhbCME3oGnSLFzi6/wpGyFWlSAbO3F3l9igHLnGlaXyhVEvCwW1+PQc+jPDWSBlLxkWmbnnXuYfO3+vsNpGG6nlQUREfpGmCT9gDDQVraGz/he5cenvg0/RbnFOsIztIhw3PU+8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979737; c=relaxed/simple;
	bh=X+NK3AFVIn/vWQzi6BpYF9kMYkg9/BSUDVGl2a73Sh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbdZelZewDDjQiWLg7bwtp5JJQ3UiDqHj+E5UG7KLoKLTEWMnGE6/4q9yB+vIRYtrPuIpHImwkpK5bX8Zkav9ftTnsHI58JHLv5SmWQAegw4RtH0p08X3wC0zJAn51DsaD3SxSDSt3z0NhApCjmk/qi5yvT0c2nzZ3IhFYrP1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pE+/QREI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso46552601cf.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776979734; x=1777584534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFIEG8o2ocGEtq1F3O8VdMnxSWGZYL4bOI/0BGP9nvk=;
        b=pE+/QREIvhD8LUhznixHWWp8lZ9N49BbF++qWI0Y7KmJSRUm/6i3BPgNASvQN+DZ9/
         KpZKGdTyoQVMtYS3JUIvaDHxWjHKiF+WT7gDPpWXK/Dl2tHfRmHndgzys31nO1XYVZLZ
         nQM9vSkvcHn052bTthJi2/v21TKZWnJFjxplvr6D4BUX2KjPGK7A83/MJdBx9Z5bS/wd
         YCFWqxWBDgdFLIG2ORcxypUxfObm3TLmEgAqXgisNQvt7Ll/WwUkJwCgOgQGej8PCDe+
         xtMbuOYQP5AsFZkPwGRG3xK8I6315OrhQCpMhcDONnLjlbyqVOSwZ5/E61MGVgn9Y4t8
         6pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979734; x=1777584534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFIEG8o2ocGEtq1F3O8VdMnxSWGZYL4bOI/0BGP9nvk=;
        b=c8x9HJ+BnTHWD312luPK2Vrzc10VTkni6B4noXOeSYh/UP0JwfmImPtC8YWfeIfPhU
         4gUxW2whDa7+uyKcwuGLfOgtQ8cks4OJKdIJ09srNcBWh4JZSRJgDGzl+EYGiujuxb6l
         mEZPZ/z0k3PIzmtW6gakY2aFUzFsPpuQ0DpvE6u/VGDRG4gavOACo6p8CoXcm0Ok0EAS
         R0TplsZzV4J2fxIxuWgzfQPYhwYh2jP2eC6OiAUJptlE5CVPa5qZ/Bud2anGFKAXt8oN
         DdY2+zfgptEANwYBqNRtVqkAazQg7T1ES/i1TlX95x86E/9jSmOe9Jejg+Xk5KteXVZg
         CLBw==
X-Forwarded-Encrypted: i=1; AFNElJ+10Wj1RD2etzJNolYqfw7eTN7lXZg7PWigs+R7xpWrqUExm+s9DMyC0e4N/8S6B12rxIBz5Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznUhaIPjRJyhYPyOyZee21J2V8g4rCZmIHzwkCtm69GIweUSrh
	lEhpV4rtOPJCc6RK0QYuGuGmtwHNYbzo84q/JZCxbUyhah2IJ8ZU+Sd8
X-Gm-Gg: AeBDiesferidC2NS5VB6bYsGQqlHtt9t+4uWvZG0Lyf/nrhqXikTVwdjaWHObl5fkrt
	Y14m57BrKvoqBKUPeWysqUNz5iiWd6rSyknrs0LCiZQkFL31i1wgb4iIppTYx4MeR7Sni6F26ZA
	VUCXhtUBPqy7uR25j/qH/a5ghSdBs70MLLSmlqBQtJy7VYCnDBJfDHVFvHImWmGqDBciXLh04Ur
	+rcb5qZcKeoEkGMHG9vnAPI4qeSF5J66Dq3nMxIlUg6aTqftnWK3QCbYqV4HYY8Gb97p3QBkKFd
	lZ7IJrwTSsCrSPv4kN2LYPnx3aB4msdMYyfaRIe8FcEiZ/MItY33yFnUgYEx1XefoJTAU9kMyjA
	4D4hnY3SLIdRKyWdmdLZz6FUeWBMdohov2sgFba9InXzKeUwJAQjYuKbQNkGOZjhQ6GM+HiXc+X
	073ByEilJ0I55iu7G1O51K7UNwMuW5bqH6HRYfw89bQ/cMcVTu4w5GenSnzBr0ebRlNsYj1zkAO
	tpkRkAEogvFNotj+5GrpNqFYrP3njU=
X-Received: by 2002:ac8:5a02:0:b0:50d:9033:f2ec with SMTP id d75a77b69052e-50e36c768bdmr425669421cf.50.1776979733840;
        Thu, 23 Apr 2026 14:28:53 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c300sm165696546d6.26.2026.04.23.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 14:28:53 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH net-next v2] netlink: clean up failed initial dump-start state
Date: Thu, 23 Apr 2026 17:28:27 -0400
Message-ID: <20260423212827.1177552-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420162734.854587-1-michael.bommarito@gmail.com>
References: <20260420162734.854587-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280877-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,kylinos.cn,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 149AE457E03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__netlink_dump_start() installs cb->skb, takes the module reference,
and sets cb_running before calling netlink_dump(sk, true). If that
first call returns via errout_skb the callback state is left behind:
cb_running stays set, module_put() and consume_skb(cb->skb) are
deferred until recvmsg() drives the dump back through the success
path, or netlink_release() on close runs the catch-all cleanup. On
sustained alloc failure neither fires.

Factor the teardown into netlink_dump_cleanup(nlk, drop) shared by
the dump success path, the lock_taken=true errout_skb path, and
netlink_release(). The @drop flag preserves the existing split:
consume_skb() on normal completion, kfree_skb() on abort.

Validation on a UML guest: an unprivileged task opens NETLINK_ROUTE,
preloads sk_rmem_alloc, then issues RTM_GETLINK | NLM_F_DUMP. Stock
kernel leaves cb_running stuck at 1 until recvmsg() or close()
drives it. Patched kernel clears cb_running immediately on the
lock_taken=true failure; the recvmsg continuation path is unchanged.

At scale: 3500 wedged sockets in a 256M guest show about 3.8-3.9
MiB of extra unreclaimable slab (~1.1 KiB/sock) on stock vs zero on
patched. RLIMIT_NOFILE bounds the test before OOM, so this is a
local availability cleanup rather than an exhaustion primitive.

Fixes: 16b304f3404f ("netlink: Eliminate kmalloc in netlink dump operation.")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2 (per Jakub's review <20260420103715.347fbd4a@kernel.org>):
  * commit message names both paths that do clear the state
    (recvmsg-driven retry on drain, netlink_release() on close)
    and notes that neither fires on sustained alloc failure
  * moved the UML validation into the commit message
  * extracted netlink_dump_cleanup(nlk, bool drop); shared with
    netlink_release() and the success path. The bool preserves
    the existing kfree_skb / consume_skb split.

v1: https://lore.kernel.org/netdev/20260420162734.854587-1-michael.bommarito@gmail.com/

 net/netlink/af_netlink.c | 47 ++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4d609d5cf406..ab21a6218631 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -131,6 +131,7 @@ static const char *const nlk_cb_mutex_key_strings[MAX_LINKS + 1] = {
 };
 
 static int netlink_dump(struct sock *sk, bool lock_taken);
+static void netlink_dump_cleanup(struct netlink_sock *nlk, bool drop);
 
 /* nl_table locking explained:
  * Lookup and traversal are protected with an RCU read-side lock. Insertion
@@ -763,13 +764,8 @@ static int netlink_release(struct socket *sock)
 	}
 
 	/* Terminate any outstanding dump */
-	if (nlk->cb_running) {
-		if (nlk->cb.done)
-			nlk->cb.done(&nlk->cb);
-		module_put(nlk->cb.module);
-		kfree_skb(nlk->cb.skb);
-		WRITE_ONCE(nlk->cb_running, false);
-	}
+	if (nlk->cb_running)
+		netlink_dump_cleanup(nlk, true);
 
 	module_put(nlk->module);
 
@@ -2250,6 +2246,26 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	return 0;
 }
 
+/* Must be called with nl_cb_mutex NOT held. @drop=true frees the skb
+ * via kfree_skb() so drop-monitor sees the teardown; @drop=false uses
+ * consume_skb() for the normal-completion path.
+ */
+static void netlink_dump_cleanup(struct netlink_sock *nlk, bool drop)
+{
+	struct module *module = nlk->cb.module;
+	struct sk_buff *skb = nlk->cb.skb;
+
+	if (nlk->cb.done)
+		nlk->cb.done(&nlk->cb);
+
+	WRITE_ONCE(nlk->cb_running, false);
+	module_put(module);
+	if (drop)
+		kfree_skb(skb);
+	else
+		consume_skb(skb);
+}
+
 static int netlink_dump(struct sock *sk, bool lock_taken)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
@@ -2258,7 +2274,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	struct sk_buff *skb = NULL;
 	unsigned int rmem, rcvbuf;
 	size_t max_recvmsg_len;
-	struct module *module;
 	int err = -ENOBUFS;
 	int alloc_min_size;
 	int alloc_size;
@@ -2366,19 +2381,19 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	else
 		__netlink_sendskb(sk, skb);
 
-	if (cb->done)
-		cb->done(cb);
-
-	WRITE_ONCE(nlk->cb_running, false);
-	module = cb->module;
-	skb = cb->skb;
 	mutex_unlock(&nlk->nl_cb_mutex);
-	module_put(module);
-	consume_skb(skb);
+	netlink_dump_cleanup(nlk, false);
 	return 0;
 
 errout_skb:
 	mutex_unlock(&nlk->nl_cb_mutex);
+	/* The recvmsg() retry path (lock_taken=false) keeps cb_running so
+	 * the next recvmsg() can drive the dump forward once receive room
+	 * is available; only the initial __netlink_dump_start() failure
+	 * owns the teardown.
+	 */
+	if (lock_taken)
+		netlink_dump_cleanup(nlk, true);
 	kfree_skb(skb);
 	return err;
 }
-- 
2.53.0


