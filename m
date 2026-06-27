Return-Path: <netdev+bounces-302301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wRKXFgk9P2qoQAkAu9opvQ
	(envelope-from <netdev+bounces-302301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 05:01:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0416D0D1C
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 05:01:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oPjbC9W7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302301-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302301-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 668C5301303D
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8D5282F17;
	Sat, 27 Jun 2026 03:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A53346FD2
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 03:01:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782529285; cv=none; b=KKs9HfcUj1WfqtF2CENZ1Je9aEAtx3f79MXD6ywqDilCUxBhcUI61ZNUL/UlVeY0Bm6fYaCCPdzXV8GiJkh8nTs65v/9Eu2eNLvvIlxPErpJC7aH8+4AgE40d4eqGK+ZCfzfti4sqElpeBOKSERMnMmSZCg+DuGS5UnY4u1Sw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782529285; c=relaxed/simple;
	bh=WX5NcTl/9RBDR6AzG4X1n8YOSJSYMAN+nKoH8UztRLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tU94KYbo+YEVH7XtcKSGTYnYqc7nUjWCBoU3fJdjTMat4OjVSLtFVqZzpCl9R+aBf0/4iBXcS6O6LmPc7lMT1CvKbZ1VJ6bfGlx6pp6q7dE4MkUsETiEeyFJC0o0L3iSPH8gXzoJfUWZu/FNPIfhIUXtB0PZAdYyP0OlwtyY1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPjbC9W7; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37fb434c547so264751a91.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 20:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782529283; x=1783134083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rs5EJEI2WbsVC5eIkeTHDPXpdMkMH/2jOxIbFQ16Lbg=;
        b=oPjbC9W7adxXJgU3xlb7GX48Ng++srypTwva+vHObthmEStrsOCbe7BFXXRoCDbQ/l
         VChu4aenMtsQ7/YerUoBdb/tchxDnwdWF6IqQz7eUmA8kzRcZQ4oVsG76+r50o0m+QFb
         CJEmB6Bfp/MJTzP66oQhlFQPjCM1bN4b4xi19elAv6bJdmqRnNT/9Lf6+vzboqRS2Z+Z
         +iyYrluWVidXEkDqD3Sn47vHaMG1hOxTJQlzCHPhD3pY9EGTKTwUO3byktF3HaHKs2lf
         Df/m6et82Ja7pWjn3tyWCQg67bIc1es65ZOQiKvQWWVv/sdHUv5j0isMGsg/ozshIe3k
         qKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782529283; x=1783134083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs5EJEI2WbsVC5eIkeTHDPXpdMkMH/2jOxIbFQ16Lbg=;
        b=KLpVW3BaTz4LO3V18glQHe8Sp4bm56QvcjbLv7D17PzXVqFix8UNYV8EAev8OFvz/b
         D+7h2bMH24Rl05YobtzNbitS40JumwDZKGi7N7a3oD/t7QHJwtvhKtLxLg8PEMYrD1Gb
         pMe5kew2GaU02LhlFd4Jib5ZYP24BgvO+LuM+es6pOSRz0MH5RsK+nSueVa68PC880F8
         eMVFc1oAJ2rrilksDuc+4dFr4AiGHt6QKpkMIck3ieBnxn4XP0WZsKIUv3DAct8WH66F
         FZRiZ3e2JsW4p+oZb1Z0vD3btxbymLrecpePKO33RyD+LepNDyzY+cKFzli22Jl8fkfV
         T/Pw==
X-Gm-Message-State: AOJu0YzsjNCnNrcnjHN3MA1Mqn3iUMRxR4+gp1wlTLlzfIoBt2otkWtd
	6rhai2N7D/y6wdffx1sVs6ek5J3Y+gS9s5AQ/0Iqz2HsIOwou1d1UJ9W
X-Gm-Gg: AfdE7clf+X7yqElsKyIalZc+m3e4Hvg12FksnOyNRDvA8X6URcv4edKof5BFTSdCz4q
	gYm+NKpkQYKEvgeh1t+VKrMjTeDp33Io4141oBoASYZQ1PcMtlTpiFdW+/SQOwQPIJsWe0t2xDs
	NCJZhmIpPuF4ZYmA9Dbb7majocqZir0YUYTsPRjF7Ce1QVucZz7svzE+IWA6ggepfI0AoCnbbT+
	5ZiQW+jEYrx2qgDfVViL53pnZL20jx4IaHGxOgmXte1lRzaVBXgwPa7GQqFdJQm7vGz6nyZ1+1j
	YCNxveKsYb+uj8LTG2B0SLXkIN79x6FIP6c1qev7gJ8o45b35ipMuuOYisc9ZvoPDnOt5kmyqQ/
	qr4N/LDx1i/0FqZJOMrixLvxBJFrO6Cc6BXzrL9XMBOgAYTfqtZP04jsWjP3bqc/iO7qRp1hhtI
	SsM1VQiXs=
X-Received: by 2002:a17:90b:17c2:b0:36d:633a:e7e5 with SMTP id 98e67ed59e1d1-37df9f3821dmr8605574a91.3.1782529283442;
        Fri, 26 Jun 2026 20:01:23 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df39dc6fcsm4905708a91.4.2026.06.26.20.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 20:01:23 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Hopps <chopps@labn.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] xfrm: clear mode callbacks after failed mode setup
Date: Sat, 27 Jun 2026 11:01:17 +0800
Message-Id: <20260627030117.2614741-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-302301-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:chopps@labn.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED0416D0D1C

xfrm_state_gc_task can run long after a failed IPTFS state setup. In the
reproduced case, __xfrm_init_state() cached x->mode_cbs, IPTFS setup
returned -ENOMEM before publishing mode_data, and the temporary module
reference from xfrm_get_mode_cbs() was dropped immediately. The dead state
then kept x->mode_cbs until deferred GC ran after xfrm_iptfs had been
unloaded.

Clear x->mode_cbs when mode init or clone fails before publishing
mode_data. Those states never installed mode-specific state or the
long-term IPTFS module pin, so deferred GC has nothing mode-specific to
destroy and must not retain a callback table pointer past the temporary
lookup reference.

The buggy scenario involves two paths, with each column showing the order
within that path:

failed setup path:
1. cache x->mode_cbs
2. mode setup fails before mode_data
3. drop the temporary module ref
4. dead state keeps x->mode_cbs cached

GC/unload path:
1. xfrm_state_put() queues GC work
2. xfrm_iptfs unloads later
3. xfrm_state_gc_task runs
4. GC dereferences stale x->mode_cbs

This also covers the failed clone path where clone_state() returns before
publishing mode_data.

Validation reproduced this kernel report:
Kernel panic - not syncing: Fatal exception
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
failslab_stacktrace_filter matched xfrm_iptfs frames
ack_error=-12
FAULT_INJECTION: forcing a failure
BUG: unable to handle page fault
Workqueue: events xfrm_state_gc_task
RIP: xfrm_state_gc_task+0x142/0x650
Modules linked in: esp4_offload xfrm_user [last unloaded: xfrm_iptfs]
Kernel panic - not syncing: Fatal exception

Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/xfrm/xfrm_state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c58cd024e3c6..4d95b2720894 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2071,8 +2071,11 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 
 	x->mode_cbs = orig->mode_cbs;
 	if (x->mode_cbs && x->mode_cbs->clone_state) {
-		if (x->mode_cbs->clone_state(x, orig))
+		if (x->mode_cbs->clone_state(x, orig)) {
+			if (!x->mode_data)
+				x->mode_cbs = NULL;
 			goto error;
+		}
 	}
 
 	x->props.reqid = m->new_reqid;
@@ -3291,6 +3294,8 @@ int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 		if (x->mode_cbs->init_state)
 			err = x->mode_cbs->init_state(x);
 		module_put(x->mode_cbs->owner);
+		if (err && !x->mode_data)
+			x->mode_cbs = NULL;
 	}
 error:
 	return err;
-- 
2.43.0


