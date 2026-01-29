Return-Path: <netdev+bounces-254684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPEBFo0ye2lJCQIAu9opvQ
	(envelope-from <netdev+bounces-254684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:12:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E9DAE6D2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB6813014109
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609443806DD;
	Thu, 29 Jan 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UufYWTe9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74133FE18
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681546; cv=none; b=Iaveh4aJFJuUNRnTuSux1WfSdTG6SV4uGnilcXzGTlx1nFNhDZMMoU7jcq1hodcO2qrEQNkXgLIw56dpSrcEbqifJiHePfU7R0FFEmwaWJ1H8kEF1+yi70uIASjP7n3EkzMiPjyktBq3hGzSeybv4KgPREBmKBKelplrGIcmKIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681546; c=relaxed/simple;
	bh=V4kEo+SZojVCtWgR2qpo3SKCTe5B0pPOMa6sCL8N57o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzlCudfviPfCySAdq5XfpLrrd6yeBUlnNukJtJo3rkuI/wkKPMyWExNYcFhfiqTxEmDhDmMEwzvfnOSkfY4VbcPFxoHxFEzdQdnUiG37QEX09IzpKc9z7Goy0wMnpIrPXxhX23y0hstm5Bs/klDwJaiyd4i2zjATKVfqLxODOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UufYWTe9; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-124a95e592fso218480c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 02:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769681544; x=1770286344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJa7eQGWZbzucfOY/PWCQHeENsvDVajhwi4B2jpBWQE=;
        b=UufYWTe9Z0lCWYsDAoxLx3wof5M0PhfmZve1QGXCGpPQ+uzAnpers4m478HMPzkQYD
         qYSRVUl3w05ik2EF5YM1zZtxJKZHxMx1SLCXc4Np7MvBlOkD+ksFf2HPngekXdTyQ+C7
         AO8kmw0MWfHJvqIgO6cUR/0QG7HO5wLqbIKIfyqbhLc0sqTnGFfRJboSd7wo/+qlvEIH
         uIiYfXJ0huF3Fsy4VtQlZt4F5rCLIsIPwHn4rPynHU4mhqHh2V9J4w3ZjyTlGECFZN2R
         eTJl46g9WqzKMubMpCfh5m2M1H2+GaQeS9IenLQ318WsiYYpF8L9sCqjp78qMi+Xizt0
         WxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681544; x=1770286344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJa7eQGWZbzucfOY/PWCQHeENsvDVajhwi4B2jpBWQE=;
        b=FwTsOJzFQxyXaQSeHcOjig5nmYFE84ZftYvKdLwnMluQU11SEYpyVwNv60oAEte/Pe
         IWpQusF4v3FW3bMO12+pYQRCl8BaqGIIHfTmbV5Ti3EwV8JP4ySpAd58mAfbgzSX4nbi
         z0cRbGwL7lGcFYGzAcHVMgjta4f1Cp5q+vjosU38geikYsNuvB7W8gJqRTKP9gbEb+zY
         1DJ5j0xNeaRBL/huhPFHa4QgZqWOGN+x7DQgasn83X+g5FXBrGXB1mGaLgD8RBHrdh3d
         HnnJchvJehq3m3kMDjgEVay7W7W5sbinJ7XWZtLlSudvcTSvOsP1yUehVdLIqhGw5jQf
         Ocbw==
X-Forwarded-Encrypted: i=1; AJvYcCW/nI7YJq/wuJa1uLLINC+cxqX/YSDHnwvqPn2REkpnabFmXF3cXOwZsgVq3HK87s+6ots8WOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1DQ0a1weNgm2Y51+BGcnSzz/aVbsW21yFfj2NTgS79TlkaTD
	Cb9linPckpqv4wEwBmgJPzJ4K0iycOdIDSp4jzb9cBsWNlgRRkxulp+W
X-Gm-Gg: AZuq6aLKVj93DNud++CEyJfLCo2Bw8LibQoVwyCLMkHxG3GSKGk0W3b0bqJ2xnwK/Yk
	MfBqRbEg/4O9jLFyCVnEXiC1s70tYGUG4LBEgB/hIJu16EUxefZ4aps5djOBGiEuaMf++TQG0t7
	PzYrcpwWjXaL6QxOVrwUNmyOlYdEhBGpoAIkkzvz8f/s6g8GQqByh8Vm2U0RCfQylbltcUDpoox
	K4ArHF3VCTg3pWbYxKOyBw/0s8czb9+BecljbYcfUwFAjrRx6VA7ZfREjxNet56A33PIQBUeXpJ
	47xon5cGLyJ50NHroq8jtiGpsY+amLYFs/DQBdJ+GSnbooUQUch4mRy6FmXhRkJwIhbWbZ7XAY+
	GZAje0ggp2kGsunMuaQ6MbsRzsqIKz9brt/BpUvll5minh4196xSe1f0V5qLexWg+10xk3ZF7yq
	M=
X-Received: by 2002:a05:7022:6889:b0:11e:3e9:3e8b with SMTP id a92af1059eb24-124a00e8a82mr4376360c88.50.1769681543633;
        Thu, 29 Jan 2026 02:12:23 -0800 (PST)
Received: from gmail.com ([2a09:bac5:4e24:c8::14:2b2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9debe5dsm6246054c88.11.2026.01.29.02.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:12:23 -0800 (PST)
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
Subject: [PATCH nf-next] netfilter: flowtable: dedicated slab for flow entry
Date: Thu, 29 Jan 2026 18:12:12 +0800
Message-ID: <20260129101213.74557-1-dqfext@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-254684-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1E9DAE6D2
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
 net/netfilter/nf_flow_table_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 06e8251a6644..e075dbf5b0ce 100644
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
 
@@ -812,9 +813,15 @@ static int __init nf_flow_table_module_init(void)
 {
 	int ret;
 
+	flow_offload_cachep = kmem_cache_create("nf_flow_offload",
+						sizeof(struct flow_offload),
+						NULL, SLAB_HWCACHE_ALIGN);
+	if (!flow_offload_cachep)
+		return -ENOMEM;
+
 	ret = register_pernet_subsys(&nf_flow_table_net_ops);
 	if (ret < 0)
-		return ret;
+		goto out_pernet;
 
 	ret = nf_flow_table_offload_init();
 	if (ret)
@@ -830,6 +837,8 @@ static int __init nf_flow_table_module_init(void)
 	nf_flow_table_offload_exit();
 out_offload:
 	unregister_pernet_subsys(&nf_flow_table_net_ops);
+out_pernet:
+	kmem_cache_destroy(flow_offload_cachep);
 	return ret;
 }
 
@@ -837,6 +846,7 @@ static void __exit nf_flow_table_module_exit(void)
 {
 	nf_flow_table_offload_exit();
 	unregister_pernet_subsys(&nf_flow_table_net_ops);
+	kmem_cache_destroy(flow_offload_cachep);
 }
 
 module_init(nf_flow_table_module_init);
-- 
2.43.0


