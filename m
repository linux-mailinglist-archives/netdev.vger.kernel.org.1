Return-Path: <netdev+bounces-60614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D22820390
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 05:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6E928228C
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 04:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36F1A55;
	Sat, 30 Dec 2023 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2xQ0eUz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60AB651
	for <netdev@vger.kernel.org>; Sat, 30 Dec 2023 04:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ed1ca402so57152615ad.2;
        Fri, 29 Dec 2023 20:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703910870; x=1704515670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZiDP3ACvLtUqSs7Pgb3eo8FrHgRUMknvmQ1/AAsrmw=;
        b=L2xQ0eUz0KqIDHWocatSk2r+n4Miu5J0fnCwu2ej6/MrNBREsKKC/oERidAEsJosOQ
         WSb8eUd0bEhT7PGTsUjP+f+hwd/6jjk/YBRkzbd4l4gwQvjqK2Er+22QqL4VdarA4XHA
         b18+7ozovA36a/AS57Cv5QOo48KhUWYmOxW61XR2R3BpmRfNSni9OWMVuenKZ4TSzxgV
         WeUZwbMXcmRjIZNs+eJeh7t8eQVsWyD5AlVgcjcPqrJyrpeM+CpuFpKDBe4PvGIfr18s
         pXeUZgiHKYfRxJ3TVEQGMru5QmgAGEpIlL2NFeAnnkZsAu6C719jJHoMflyJ5JKz0/HD
         rRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703910870; x=1704515670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZiDP3ACvLtUqSs7Pgb3eo8FrHgRUMknvmQ1/AAsrmw=;
        b=pOuQGqFvZcfJoPsSLLDivkqX+ak+ufZPnNsQeHn5Kll73SUrGVlzVhety9BfIeCx2y
         cE1Bq4J8z99DIW9AFaqb/Sm8l7lqQLH1KTMPX9y3pVUvjUTSHbQe8XosGWyztc8SMYsW
         xm1rEyiRpbcn6LV7kbzVsaU1N63d883Fq4x12hmz1xEsEUdyT3G7RHPP2udMLIxrlN8k
         VT4+BJEOifSvm++L/it2DW5Y3DQhUkLaUH5APLp8XVP8Rg7CHR4e6ORvpvf87NSP4vVh
         6J/o3b9p7BRmy5nadDe14ffNeNmoRJJN8BoxqI7Q6XhwX+/3hIEiGPHq2CO1hP+qI1di
         pe2g==
X-Gm-Message-State: AOJu0YzIwGVmClRRFwzGZYHvp8yB0uNQ/xFBi0WNLInHEFIRyOh60ITK
	Ka8MweycZ032rEPemcBt0dlH9S6AlGz/QA==
X-Google-Smtp-Source: AGHT+IGuavAbJwLeIzYAkuNbnPKrmlmWGepSfVDpwQ5zcqyAVuBjCcKaHrWUS0uRdkYiDHxjhkNYLQ==
X-Received: by 2002:a17:902:e541:b0:1d3:ac23:b511 with SMTP id n1-20020a170902e54100b001d3ac23b511mr16723590plf.54.1703910870306;
        Fri, 29 Dec 2023 20:34:30 -0800 (PST)
Received: from xavier.lan ([2607:fa18:9ffd:1:7a77:c7ef:1ba:cce8])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902da8100b001cfc68aca48sm16374856plx.135.2023.12.29.20.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 20:34:29 -0800 (PST)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	dan@danm.net,
	bagasdotme@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-pabeni@redhat.com,
	jikos@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] Revert "net: ipv6/addrconf: clamp preferred_lft to the minimum required"
Date: Fri, 29 Dec 2023 21:32:44 -0700
Message-ID: <20231230043252.10530-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d2f328c6-b5b4-46d0-b087-c70e2460d28a@kernel.org>
References: <d2f328c6-b5b4-46d0-b087-c70e2460d28a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit had a bug and might not have been the right approach anyway.

Fixes: 629df6701c8a ("net: ipv6/addrconf: clamp preferred_lft to the minimum required")
Fixes: ec575f885e3e ("Documentation: networking: explain what happens if temp_prefered_lft is too small or too large")
Reported-by: Dan Moulding <dan@danm.net>
Closes: https://lore.kernel.org/netdev/20231221231115.12402-1-dan@danm.net/
Link: https://lore.kernel.org/netdev/CAMMLpeTdYhd=7hhPi2Y7pwdPCgnnW5JYh-bu3hSc7im39uxnEA@mail.gmail.com/
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst |  2 +-
 net/ipv6/addrconf.c                    | 18 +++++-------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 4dfe0d9a57bb..7afff42612e9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2511,7 +2511,7 @@ temp_valid_lft - INTEGER
 temp_prefered_lft - INTEGER
 	Preferred lifetime (in seconds) for temporary addresses. If
 	temp_prefered_lft is less than the minimum required lifetime (typically
-	5 seconds), the preferred lifetime is the minimum required. If
+	5 seconds), temporary addresses will not be created. If
 	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetime
 	is temp_valid_lft.
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 2692a7b24c40..733ace18806c 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1407,23 +1407,15 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	write_unlock_bh(&idev->lock);
 
-	/* From RFC 4941:
-	 *
-	 *     A temporary address is created only if this calculated Preferred
-	 *     Lifetime is greater than REGEN_ADVANCE time units.  In
-	 *     particular, an implementation must not create a temporary address
-	 *     with a zero Preferred Lifetime.
-	 *
-	 * Clamp the preferred lifetime to a minimum of regen_advance, unless
-	 * that would exceed valid_lft.
-	 *
+	/* A temporary address is created only if this calculated Preferred
+	 * Lifetime is greater than REGEN_ADVANCE time units.  In particular,
+	 * an implementation must not create a temporary address with a zero
+	 * Preferred Lifetime.
 	 * Use age calculation as in addrconf_verify to avoid unnecessary
 	 * temporary addresses being generated.
 	 */
 	age = (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
-	if (cfg.preferred_lft <= regen_advance + age)
-		cfg.preferred_lft = regen_advance + age + 1;
-	if (cfg.preferred_lft > cfg.valid_lft) {
+	if (cfg.preferred_lft <= regen_advance + age) {
 		in6_ifa_put(ifp);
 		in6_dev_put(idev);
 		ret = -1;
-- 
2.43.0


