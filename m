Return-Path: <netdev+bounces-35262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A60E7A834F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 15:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D47281934
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA937147;
	Wed, 20 Sep 2023 13:26:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621136AF3
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:26:27 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A342CA
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:26:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2764b04dc5cso2095379a91.3
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695216385; x=1695821185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7fATTHDXaSbrRIpLorovNCmSIYGeGmL1yYhxtiI0B0=;
        b=MSpk4amk80rD0H6FEEHwV4QPMuPeOBPlkYea6I3fwe10AW0UiEPWNXTkZxfon31eKj
         OlJtk8iPTmI+T8V9kUpURZ5lk1g9/kOTdomH1evIlcDRGqlljLBwZ05yrJQ8QYF8EHo3
         ogruTI+jw8/AuNQPSG3K57+FIiefCgvoRYijnwxL5btcp8ZYTtToTY2N9w6oxqIo7dyA
         TOr0Bq2/BiGQKlIEAzr3GtOTjYRdu+lAPSh3Y8Ew7XBsg8rf1lbcuX0lwkhKAzI63OPi
         IrqSfTXKSaEZOKYDqAD/pmFxFXPMPcSHG5cIVeJFHbHy/EEo8EKmwM2IsLGVTMo4rnFf
         fqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216385; x=1695821185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7fATTHDXaSbrRIpLorovNCmSIYGeGmL1yYhxtiI0B0=;
        b=WZz1h88EGBqvCVBLfVIGzqofBEquiJ94JFuffQNEXLwCWpf0TF/IGbtPKZ0sXnDv57
         +JUjCiKPGDTS3CoEZFTqvtW7KsZKai/wKfTPyNI0RLaHS9PzyV5LLzqF851fwzBg+Sqe
         mszfQlao+dfc+a7jrziFc/2qxMm3LFhKJwKiJVLV5qy6SpVB17d9nz2km/uBO2A/86z5
         xqnIC6Di2mQf5kWbwkGmHfexDj1BUc2oGKnR7y2chAU7ra/yNa8bbU1MO+314qltTqbX
         qTXUpnrlIUY2YXi6PgfCIvxK0fxbpo4q19ODFujTkZpjFyutnHCPA2QLzsu75ex5t2Xc
         mt7Q==
X-Gm-Message-State: AOJu0Yw7z3xezaoORULTr5XI44wqTtWlzUbNiPcjC4+RE2ztn5NIZPy1
	W14ycMyQ5imFlV3te40AHOyDyA==
X-Google-Smtp-Source: AGHT+IH7v4KQGYSssF5a4RuDaZXId9Eq3e5lpP2ba8bd//NMDSQFiu87b6arf46Rb3ZtsqzcjruT2A==
X-Received: by 2002:a17:90a:fa08:b0:273:e64c:f22e with SMTP id cm8-20020a17090afa0800b00273e64cf22emr2329685pjb.29.1695216385452;
        Wed, 20 Sep 2023 06:26:25 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id cl21-20020a17090af69500b002682392506bsm1333485pjb.50.2023.09.20.06.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:26:25 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Shakeel Butt <shakeelb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>
Cc: Glauber Costa <glommer@parallels.com>,
	Xin Long <lucien.xin@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] sock: Code cleanup on __sk_mem_raise_allocated()
Date: Wed, 20 Sep 2023 21:25:40 +0800
Message-Id: <20230920132545.56834-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Code cleanup for both better simplicity and readability.
No functional change intended.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 net/core/sock.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index a5995750c5c5..379eb8b65562 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3046,17 +3046,19 @@ EXPORT_SYMBOL(sk_wait_data);
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
-	bool memcg_charge = mem_cgroup_sockets_enabled && sk->sk_memcg;
+	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
 	struct proto *prot = sk->sk_prot;
-	bool charged = true;
+	bool charged = false;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
-	if (memcg_charge &&
-	    !(charged = mem_cgroup_charge_skmem(sk->sk_memcg, amt,
-						gfp_memcg_charge())))
-		goto suppress_allocation;
+
+	if (memcg) {
+		if (!mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge()))
+			goto suppress_allocation;
+		charged = true;
+	}
 
 	/* Under limit. */
 	if (allocated <= sk_prot_mem_limits(sk, 0)) {
@@ -3111,8 +3113,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		 */
 		if (sk->sk_wmem_queued + size >= sk->sk_sndbuf) {
 			/* Force charge with __GFP_NOFAIL */
-			if (memcg_charge && !charged) {
-				mem_cgroup_charge_skmem(sk->sk_memcg, amt,
+			if (memcg && !charged) {
+				mem_cgroup_charge_skmem(memcg, amt,
 					gfp_memcg_charge() | __GFP_NOFAIL);
 			}
 			return 1;
@@ -3124,8 +3126,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg_charge && charged)
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);
+	if (charged)
+		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
 }
-- 
2.37.3


