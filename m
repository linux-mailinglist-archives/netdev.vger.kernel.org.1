Return-Path: <netdev+bounces-271830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIZoKZ+0xGn02gQAu9opvQ
	(envelope-from <netdev+bounces-271830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:22:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD5A32EFC7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E15953041145
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67CF3932EF;
	Thu, 26 Mar 2026 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVMggC/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219D378812
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 04:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774498971; cv=none; b=jgPHBAMZqdg7wvGOAfEgnOZqQUgSfyF+R9W8ftw5TneHzLeHF6Vm/61ew4LZM/oA3U+GDZgwcAfguXfiV+vdbCmE+5pXZv92aoJ/bspbZExI1/6k73BXeKS0HR33gB0w+HPs0+OvZd9OMWv9KupReBHiLpWU2OaYeP3OhiGjljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774498971; c=relaxed/simple;
	bh=cRppzSHikrIjd5DKqLgnxFDpstZwjo2Khr5eln6dihI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cwJhJJ2cyY8mzHnCTXIpVcAJHT2MF1vAvg6EoJRH8M/UZgCH201nGXUqk7gmSfoKdiH8gZ5RnU5LTU6JhlnKaReZm/MGBiZz178XjK3xwyKHCpxr2DdZOY805Em+wFopH8cVAYIZjaDCZQAH97zhtbl8dDxXVr6Vrxhrb867tRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVMggC/u; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c7412b07f22so749686a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 21:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774498970; x=1775103770; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOZKvxdWHrHJ4CjWSAnlKTTjSu/T1OR0HIhD8gZwcXw=;
        b=CVMggC/ueIDse/y+xsjQaR4WwD9SbzG/PqNu4YVVHIoEmO8gBoY9bp52cG7qS2VPVN
         zemA848xUTDu9bxoYNiSEA+gmX34+CfBSRBk2mOhET88Hb1xmNGdBk+uvSqbE/De+OCc
         DhvKGWnBuwX0Mxr0XGMqJ2zCBkFWZpjpSEecDCdeT84/zdgdxrrjYE1eRV746FjemBjt
         CSIOguxTtcxiACOTMTj3QTUAE74/IdPx4eEbY8S44BkRi8s2TAeTeTjM1hnjwFaIc6OM
         7eIrGSXHONK1rHckxedwnecJYv4N3J3WN7Ls85yjp+LDi6ltaAbzuJ+ghK0xcvCmZQTi
         zz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774498970; x=1775103770;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOZKvxdWHrHJ4CjWSAnlKTTjSu/T1OR0HIhD8gZwcXw=;
        b=CsWO6gRzgIP3m2xm90y63B8foh2OoIREzl3xbWiiWJb+pfxYIl2J1eJ6amCMWs++RG
         OpvqNi+USPz4PhvZCizLtP+IqdhcNYV6F6ElxUZckCAUdLPgUYQ/ATS/jbGrMBnyZUjV
         VMauR8HDjFltj4+/m8tzUZjiLVDK79Qn1alJI32ni0ClbXRLJrmjKsC7mfyUGrybkGEB
         nUqcwRbgnZGXMx/73SCvJbnq7PWWv/FRQBt1IPxG18py4dgs/TTr4WpXLa/PCY+duSg/
         d59weq1iJ77UFhvrUxoR4WFT7ifunm5P8yWkFH6QDKEolpCYQM0+w//XlNkb25aNaJCh
         6A8g==
X-Forwarded-Encrypted: i=1; AJvYcCVl/ecmIStqb3kHiesT7hH09du6MvHQnaNJp78qteI/kDbem+LkG5JvulC0+MfTu+4RRitFSxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEr9COfWJmIoJbq5lExg3cTn5xE9nf+S5FkCMhSCy+0UvSIlyq
	Q4pXACdM34K+IWNPmUqxeC3Ian4HKiOyyomHbPZIs4u/5oftIwPZSxdb
X-Gm-Gg: ATEYQzzaZ5HEqu6u38IgnQS4C0LuH24vFH5YFd7jcIhJjOttS112sWM1ukkgBPP8SzT
	TTnl+am6fMiMwuiq9AK8T/R+JIHjGcQ1W6cgkaK6RfZJ5666Yx69/Cj6WHM66O/NvAk2lxmN8id
	zsYGxdR7WJkkNaJwXBUAYzCzyDDGSSMjPd0EelpeVWqxU+5KpC6oDw3Ml0v1RpNlaPx6hsWQVwG
	eUDaztNXzGLvfQlI7db9MTbxrw3ilKRBq8Jo2/Ade06ttReH/5I1trieVyKA44EAQcOuvBxNRf7
	YVPZk8VTpVTfgqriCI5Ehv4xAYOgFHNv/hlGQLtzcnKEbnP+W5/U0xz8DVLbJ7dd49Kjrzc4pHu
	+EitLtmj0AHW6OU7JWgOR6bhe8VkZxYojOS6LdOYthL/8hTrMRM0c7j3+75iy96iG3LO6ED9mUG
	KRhS8WUgt3qOQPVT5v/wmv/zFBKlMdZPS4zQMS8Mlf7WwHR7dV6dMCiC6msqlRmDL0wmDOCC7iC
	C8qlfF7YP4aGFqCv466hhsgxHIe3IA5UxEWhOO/951W1Fgnb0FVn6RAmm7PtA==
X-Received: by 2002:a05:6a20:5483:b0:398:8caa:bc93 with SMTP id adf61e73a8af0-39c7357d570mr178631637.15.1774498969684;
        Wed, 25 Mar 2026 21:22:49 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:576a:8120:24cb:c7d9:bd46:8af])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673978668sm911369a12.27.2026.03.25.21.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 21:22:48 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Thu, 26 Mar 2026 12:22:20 +0800
Subject: [PATCH net] ipv6: fix data race in fib6_metric_set() using cmpxchg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBAF0KvIrDugqUbbq5Qio351sIklCaUg3
 r2hy7d5B0UERaR7cVDAR6PuPqO6FDSu4hewTtlkSmPLq7E81DzrYHuHFHTsIxJvDu4F2bgVaap
 b25muFsrDO2DW739/kEei53n+AB/sg01yAAAA
X-Change-ID: 20260326-b4-fib6_metric_set-kmemleak-7aa51978284a
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fei Liu <feliu@redhat.com>, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271830-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 1FD5A32EFC7
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

Fix this by replacing the plain pointer store with cmpxchg() and free
the allocation safely when competition failed.

Fixes: d4ead6b34b67 ("net/ipv6: move metrics from dst to rt6_info")
Reported-by: Fei Liu <feliu@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv6/ip6_fib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index dd26657b6a4a..64de761f40d5 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -730,14 +730,16 @@ void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
 	if (!f6i)
 		return;
 
-	if (f6i->fib6_metrics == &dst_default_metrics) {
+	if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
+		struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
 		struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
 
 		if (!p)
 			return;
 
 		refcount_set(&p->refcnt, 1);
-		f6i->fib6_metrics = p;
+		if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
+			kfree(p);
 	}
 
 	f6i->fib6_metrics->metrics[metric - 1] = val;

---
base-commit: c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f
change-id: 20260326-b4-fib6_metric_set-kmemleak-7aa51978284a

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


