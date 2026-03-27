Return-Path: <netdev+bounces-272337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN/qBgTtxWlTDQUAu9opvQ
	(envelope-from <netdev+bounces-272337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:35:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B96A733E662
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25B2730D0378
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF3B30E82D;
	Fri, 27 Mar 2026 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeZCcFZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67693016E0
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774578315; cv=none; b=U3DB2ksfTOhP595Jt4xik+nfU68fWLerpXamttpIYFh4zxEWaPPmdt82NpZB7huaLGlZgmZo5p2iubducxehJL/0P/22xFoufS1uPObGPt5/wJBjnnt/8jhDJeMfFhE8h9TYZSk6aejgua/ESKMxN9WkN4YyCj0eAe8CkGvUjts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774578315; c=relaxed/simple;
	bh=GA9iJ3FHlrroqC2NNiJuu9RWhIYVniR+DEyF4ubqR/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TEmU03K4v6zaUsfchmfhlSAMcCYYqL4A/yrKwavYJoaCA+Kl9x3NmXb6G3hul8z598Kz5ZUqQf0nnj8iuNY7BoluNTd7Tr52doGvY2BHxP0cukJ2eucL1Y8wnzGKOA3yLFZMEE6i3a1kgxffJX4cw1SRSbyuf+QEXf7hj/VCVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeZCcFZK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so667812a12.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774578313; x=1775183113; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RgsriYW27LYcQzITLoiIl7pLc3IW/A/busdV44W1OJw=;
        b=MeZCcFZKlwi3rNFgQ5ayoTF+0SnE7Ehttu0O1M+2/9F5Tu20xyHa1GE/UhOsEDS5mi
         lUPW43+a68DUvrg3Vv2j2p5CHU5u355wz1D78QYuMlc4kRi93Fzd2Bafpvq5/rlzTNRP
         hGlGkFBGX6di/8lG+Kd7JYbySnIAz6ygRhpOnO9xrI5DjjXLsKuX39AYaUK/1xGRbQEW
         tYEZD8L0CoKL6HGM6EYsQ7a6weLcU4iTpsk0M+zuWH8VLterGLgISHGyN/tg+56NZaCM
         Bxr5e6IoAIGx6wbWNN48X7AfIQhqmgCtYSD31cZL6t/oFY1qJqFPW9DgNGSJCBrnX6k9
         LMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774578313; x=1775183113;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgsriYW27LYcQzITLoiIl7pLc3IW/A/busdV44W1OJw=;
        b=YSFxXv0lUM2uW8ErB4pYxdX9h6MsprHXyRWsEeRtzETI2rsgUSZXNoLxErNlZBAG2t
         Pe+rryttHC9CL1h5uIvMuoxjEbaxsTctdElKNs4capLnImlv6rkIyOWfhRncgEkrXmAx
         o9ysdeBWe1tkqE0J5ZovyOiYVvCr7MxG5wXjnRS1eHgjz7du9mxTTXbnn9ey2cw9IzRy
         n562szubQphf5AiBlIzFCWiUTXpolovYcsGg+Bbp0ld754V0rPjATKe5acFN65syYj7v
         EJYH2BFFyv8dj6WeFGswRFl9hOZtRElR0gqg2rQVi7V1SjPw23x2/RnJKCQSz7WlhR6f
         uMHw==
X-Forwarded-Encrypted: i=1; AJvYcCXeZvZiS0ZhgJvuk7SxKOp7GQcuCmEbMh9E2w58jxT3KcS/VkyRs6pf4754Pyn9Us+NoCTJt3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPwv7TlbL6ULDUKkzX73G36vsIpJrLbBnghq3RH24WijgXYJi+
	k9LQ+drbrukYM7wu9em4RATwO2C/Y+/GIekRXwMv2dkcfomzZMbVTtYg
X-Gm-Gg: ATEYQzwzC+58fsvLNbzvxfhp4kX8h+qP9kZK9C/lyC1LbFeXWz9WPBjDcGZ53SzNwue
	DgCZjwFz7XwDgt5aHEAVAvvi58DQtIBrARvT1JBf18SR0rin9v/bvCI+YeyXgxZosd09f+8Denz
	ktEyQdDk4xtd2EJ+PFwj5ue83X7dulr1ps99L8JNP7b/+0h2NudaAy/+7NeMdwnm+zeoxbjA9Me
	IyFweyiiNR3vSGA506Jga45HlMVf1aDo1iwQtkwGHMLWQzG+upM0PvPiTO2OZM0uyRjGTG6htTl
	nrjvp9TIfbr7t+sM/QQJAF45GygoutpPDpuqwy+u8hYPf7HXSy9Ej76sxEZeolrszYrnE3xXi2C
	AX6F6IbledwAGe5KhKmURnJrtFRdkXesvhbmTQloCiPD0aRm33z1LSeHIMcwyZpoBXpXt5Yc5l/
	ZvMMtVeuK0I7F87HhBGV5xbUolqm5XLUR2rEwVfo+OSkPMqhbmHjIZCxVAv0oiVo9YiYGpGSJD8
	+Z7pNA6NHOlScWnPIio/s9NdILDPebcQGEpOJQ4pp0dkfyPoji1
X-Received: by 2002:a17:903:37ce:b0:2b0:41bf:ca83 with SMTP id d9443c01a7336-2b0cdcc8106mr9033135ad.23.1774578312983;
        Thu, 26 Mar 2026 19:25:12 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:576a:8120:d1e2:12aa:7df5:2768])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0cb9ad55csm9423815ad.53.2026.03.26.19.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:25:12 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 27 Mar 2026 10:24:47 +0800
Subject: [PATCH net v2] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-b4-fib6_metric_set-kmemleak-v2-1-366b2c78b5c2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NWwqDMBBFtyLz3SkmWh/96j6KSJKOOmi0JEFax
 L03ZAX9POfCuQd4ckwe7tkBjnb2vK0R5CUDM6l1JORXZJC5rPJCVqhLHFhXvaXg2PSeAs6W7EJ
 qxlqpm2jrRjalglh4Oxr4k+pPWClAF+XEPmzumx53kaa/4rtAgaZpByN0IaTJH6NVvFzNZqE7z
 /MHHYTQ6csAAAA=
X-Change-ID: 20260326-b4-fib6_metric_set-kmemleak-7aa51978284a
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fei Liu <feliu@redhat.com>, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-272337-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B96A733E662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fib6_metric_set() may be called concurrently from softirq context without
holding the FIB table lock. A typical path is:

  ndisc_router_discovery()
    spin_unlock_bh(&table->tb6_lock)        <- lock released
    fib6_metric_set(rt, RTAX_HOPLIMIT, ...) <- lockless call

When two CPUs process Router Advertisement packets for the same router
simultaneously, they can both arrive at fib6_metric_set() with the same
fib6_info pointer whose fib6_metrics still points to dst_default_metrics.

  if (f6i->fib6_metrics == &dst_default_metrics) {   /* both CPUs: true */
      struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
      refcount_set(&p->refcnt, 1);
      f6i->fib6_metrics = p;   /* CPU1 overwrites CPU0's p -> p0 leaked */
  }

The dst_metrics allocated by the losing CPU has refcnt=1 but no pointer
to it anywhere in memory, producing a kmemleak report:

  unreferenced object 0xff1100025aca1400 (size 96):
    comm "softirq", pid 0, jiffies 4299271239
    backtrace:
      kmalloc_trace+0x28a/0x380
      fib6_metric_set+0xcd/0x180
      ndisc_router_discovery+0x12dc/0x24b0
      icmpv6_rcv+0xc16/0x1360

Fix this by:
 - Set val for p->metrics before published via cmpxchg() so the metrics
   value is ready before the pointer becomes visible to other CPUs.
 - Replace the plain pointer store with cmpxchg() and free the allocation
   safely when competition failed.
 - Add READ_ONCE()/WRITE_ONCE() for metrics[] setting in the non-default
   metrics path to prevent compiler-based data races.

Fixes: d4ead6b34b67 ("net/ipv6: move metrics from dst to rt6_info")
Reported-by: Fei Liu <feliu@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
Changes in v2:
- Set val for p->metrics before published via cmpxchg() (Eric Dumazet)
- Add READ_ONCE()/WRITE_ONCE() for metrics[] setting (Jiayuan Chen)
- Link to v1: https://lore.kernel.org/r/20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com
---
 net/ipv6/ip6_fib.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index dd26657b6a4a..2a7cc33fbcef 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -730,17 +730,24 @@ void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
 	if (!f6i)
 		return;
 
-	if (f6i->fib6_metrics == &dst_default_metrics) {
+	if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
+		struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
 		struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
 
 		if (!p)
 			return;
 
+		p->metrics[metric - 1] = val;
 		refcount_set(&p->refcnt, 1);
-		f6i->fib6_metrics = p;
+		if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
+			kfree(p);
+		else
+			return;
 	}
 
-	f6i->fib6_metrics->metrics[metric - 1] = val;
+	struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
+
+	WRITE_ONCE(m->metrics[metric - 1], val);
 }
 
 /*

---
base-commit: c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f
change-id: 20260326-b4-fib6_metric_set-kmemleak-7aa51978284a

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


