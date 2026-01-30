Return-Path: <netdev+bounces-255038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCtHBC5cfGkYMAIAu9opvQ
	(envelope-from <netdev+bounces-255038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:22:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A869FB7DE4
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 172953004DFA
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3720E2DF6E3;
	Fri, 30 Jan 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQwmQm6L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D841309F08
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757738; cv=none; b=W7oDsI9KbDaGro/qKX12nqPrukMxXe4Lif8jO+KNPj9RTNMuC9YR8H/ewu9XjcHLAxZ8mUF807Hiv+pvGanPdQE3p4pHMYqJsh007hlb2HhEFuvNIp7wlFN9ll/Bp6pzIx6x0kXFLEwkTkQK4HbWZNKUlcgDyXqra/zexDYN8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757738; c=relaxed/simple;
	bh=scpHbiU85fPKFr3iZ5a8B06uHXcjdSPXniUbJsWoh5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yk+vKc18tM/y+/p7Gxc9k/g4so3K+YVCxzoZ6blcHDgGr9OYXGahoiO6ioVPLGXXp5vFhVmGIyQvzDxQpF8XuaCyNQ2C6b3XgJZx75Rpr3h5SBjambrujP7uduD8CzDbxNCJo+ZCDxABGMKajPYQwwoWyVK2dGDEzj5xOtOzzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQwmQm6L; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b885e8c6727so341568066b.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 23:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769757735; x=1770362535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0lV1Eb14MHHXl34cLNbbdByp1XdnJD9vp/7a+55/aDk=;
        b=cQwmQm6LdQ1GoFYIID9LxpBt35vzfmqsXTxMsjgNifnTTB8MKJkO5cNjTlhfURddro
         i5N4Pc8XW/1UNczzgir44OOAqTbquBFnP4+jXujj5gwFwyteKtFIgWTgbmS5OjzsxmZ1
         cJBS5Xuc8cdpLglFNrwqc7n/1u20mejI+dfH1z7HOAz06ovruXlBfIuuKPJYiR/RerEy
         Oj25silYh+WS7PYNLwJLB2l4SsBajrO7bybZ9qvFeFrdjj+WFHFQ9HcLNFcMHUZZcMym
         tFEPpIzffyNFYjb4sOudbEqhum7T+yi1Yejpn+1NW6bSF1PF1WRYC4yeAnVLly3vmWku
         9mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769757735; x=1770362535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lV1Eb14MHHXl34cLNbbdByp1XdnJD9vp/7a+55/aDk=;
        b=Cw/Fw+MnyzmFU5lIE5difsWspDhcbVyIa8Itvkzsyayejq5bcQi0SBpeOXvFFDqhR+
         XAUDAE8ZlqX9QzvInssuLM/26AtJ4t4Mq6AOGc/L1Txfj7AcIM3w1R/6+c+rfW4vZNak
         K5NTdWx0Zwp+SIuJNLLbOHFNUiz+tB/ZUcyWi9LAnx/fJ8t2uvqPspZjjWC0wRFNPvt7
         fthI/pMDMRiOoTf1n6wXE7vGlrXCGLXoLy4sM4DS1S/g7nv7W0TrX1Z/bstcixJVfdd7
         DM+aQ89oOOwimAuPdSA46c2W/pgMn58QMzMyfpgjYt8pR0rVPL7Qa2ckWTq/j2ZkaZaj
         qyBA==
X-Forwarded-Encrypted: i=1; AJvYcCX+lPCMFjEiHaFEOk6QrvJnZC5DvYcsfHhN85B9YY6Jv30p8MtZXp+S3F48CcQh9n5/MJbJI9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFzhS61NXE3T9z7h2Xtegw6IIzaoR4ksyIMjZltF8cKOiwjgE
	meSdp7nTcUQ8cGhVtk15QgbjymOD999bwf/Ra78Mu89CquYFAIJr2H96n5bwBgPJthPtqg==
X-Gm-Gg: AZuq6aJh90bQ4nfpuIpt4PQavlhWsEpAhmf2AML3e3UPx9trl2/qhOB48FFBWOopx/1
	Y03LACadT5jNQuIHcDH789QGRBDqrfYYIjTWQpCWEI93pEeZCGEHjrhNwOqrdSOnH/0AipILLXq
	UxlhBFKb/YRpBnAb1ztqwn+4J+GgiIO/Cy1/kISctVqnLXzp+NLh+aQqQhWKIjAJi/+oqOC1GEB
	FlDLx7oIvBbAQK6DTTAsoEAftTnXRetOFzRJxvkwTShKGee8BSt4HK3vPy//emqM7oyH68Knd35
	bziQeJ3GoAWtKWqmCgCA70MRr2LwE8laZpl6u6Ii7OLckkazgS1T4jP86pokge8sAAMLw4BDJQk
	V69hzOl5o4Fs1NAbWPki3xSF/hWdovJe6qCpNiX6Of0QXSxYwYYhIaubTZoybdhg18R8=
X-Received: by 2002:a17:907:9805:b0:b87:7430:d5e2 with SMTP id a640c23a62f3a-b8ddf85c0a2mr331985166b.12.1769757734675;
        Thu, 29 Jan 2026 23:22:14 -0800 (PST)
Received: from gmail.com ([2a09:bac5:4e22:2e3c::49b:47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2f3e33sm379318466b.71.2026.01.29.23.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 23:22:14 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v2] netfilter: flowtable: dedicated slab for flow entry
Date: Fri, 30 Jan 2026 15:22:07 +0800
Message-ID: <20260130072208.108345-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-255038-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A869FB7DE4
X-Rspamd-Action: no action

The size of `struct flow_offload` has grown beyond 256 bytes on 64-bit
kernels (currently 280 bytes) because of the `flow_offload_tunnel`
member added recently. So kmalloc() allocates from the kmalloc-512 slab,
causing significant memory waste per entry.

Introduce a dedicated slab cache for flow entries to reduce memory
footprint. Results in a reduction from 512 bytes to 320 bytes per entry
on x86_64 kernels.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2: use KMEM_CACHE macro
  - https://lore.kernel.org/netfilter-devel/20260129101213.74557-1-dqfext@gmail.com/

 net/netfilter/nf_flow_table_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 06e8251a6644..2c4140e6f53c 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -16,6 +16,7 @@
 
 static DEFINE_MUTEX(flowtable_lock);
 static LIST_HEAD(flowtables);
+static __read_mostly struct kmem_cache *flow_offload_cachep;
 
 static void
 flow_offload_fill_dir(struct flow_offload *flow,
@@ -56,7 +57,7 @@ struct flow_offload *flow_offload_alloc(struct nf_conn *ct)
 	if (unlikely(nf_ct_is_dying(ct)))
 		return NULL;
 
-	flow = kzalloc(sizeof(*flow), GFP_ATOMIC);
+	flow = kmem_cache_zalloc(flow_offload_cachep, GFP_ATOMIC);
 	if (!flow)
 		return NULL;
 
@@ -812,9 +813,13 @@ static int __init nf_flow_table_module_init(void)
 {
 	int ret;
 
+	flow_offload_cachep = KMEM_CACHE(flow_offload, SLAB_HWCACHE_ALIGN);
+	if (!flow_offload_cachep)
+		return -ENOMEM;
+
 	ret = register_pernet_subsys(&nf_flow_table_net_ops);
 	if (ret < 0)
-		return ret;
+		goto out_pernet;
 
 	ret = nf_flow_table_offload_init();
 	if (ret)
@@ -830,6 +835,8 @@ static int __init nf_flow_table_module_init(void)
 	nf_flow_table_offload_exit();
 out_offload:
 	unregister_pernet_subsys(&nf_flow_table_net_ops);
+out_pernet:
+	kmem_cache_destroy(flow_offload_cachep);
 	return ret;
 }
 
@@ -837,6 +844,7 @@ static void __exit nf_flow_table_module_exit(void)
 {
 	nf_flow_table_offload_exit();
 	unregister_pernet_subsys(&nf_flow_table_net_ops);
+	kmem_cache_destroy(flow_offload_cachep);
 }
 
 module_init(nf_flow_table_module_init);
-- 
2.43.0


