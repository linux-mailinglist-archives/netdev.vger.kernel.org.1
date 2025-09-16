Return-Path: <netdev+bounces-223746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD51B5A439
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3362E320E67
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEDA323F41;
	Tue, 16 Sep 2025 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2WgWsU0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841531FEE4
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059289; cv=none; b=NEpyB8xAsMZ3hkAk2Ul3E5/oH8tM2wfgHio1DffQ0kCc+VT+fsSJj+UgzbwR6qhmtCjC1/1cxHuyY6khQwYJ0DfRZenAInGCn0smyrijC+dWzzKG/6+vrYDFHGYkcXR4LKziuj6zJaSYvpcNA1swXyQR4GDEqyb8GyFMFcdBksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059289; c=relaxed/simple;
	bh=bfazPXU5aGXGA+vINJ5XVGc8YfBcgv6bI2rK8pBENYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R28fx47jeRZnTyXFyXTKbtxZs3Ji6kzKZhcqDdzg+nJGv20U/LXrfSD/ybMim7XGnKi4lLafHmSi28DiV/3FHBG6FhACQ4CnzdMqSzMywgHtbSrhXt8rjbkFLkNRbFruP5I1juL26t2f5rr0EDOYo8ctVQGw7YhHn65/v/j1L4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2WgWsU0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445805d386so70724425ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758059287; x=1758664087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ8BGDB3DzKiBBjAb9xixlGbDHENKwcagDuuUYs84DY=;
        b=Q2WgWsU0iWNzjMlV2l04QtYAeevGU8N4ltUmDkuoj4IDNFLeiAzbwCvW4TwaHzPOIz
         8TPIAdrwpO7cT7CQBWofPOe0PdJ+m1RNXMJ8/k3Vw4fziHWXmFLEPqr1ZxJACE6PFHwh
         Es7x29BN3BPl1+GHyKe+4gaoAl0ZbIueemzuQrjXg9972YhWhFFwPgyJaALH7F5CEy/f
         m8gqszY8Iqp4TMsgtrdQU2eByOSdtUgnIchpijgn3RNslVxgWXeiWQfubye03zfsr684
         CHGiONJbbyvO2WAaDUnDzhPR2MlNO7N7/Li0bAzcrhq6hNNHb8NgV2X1NpjoQkZ166TX
         98dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059287; x=1758664087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ8BGDB3DzKiBBjAb9xixlGbDHENKwcagDuuUYs84DY=;
        b=oov28HawOPly5/DqyBq92vgd1Jm5CI7U0lcA831LTSdI9nsZvqlHR/worvdpdPwC4W
         5OYOtQz7j0dm8GCfF4uHlpaSSF80IZ31tbTKhp8WgVL1MqW8Y/gGw0yiOz2H2zJghx1M
         wC7YyLGdtKPWEtZNOGiX5AMi8kGbZkRroDGMlt60p17FhUOHTa+18D1X6W+L21uSQGeA
         iVUMYupzSF+xeZw/L7tndjoe7czj0EUQBXNaBN5rQJ9gTrwe02iYo9oXuC0zP65C0bB6
         xKayhpnvl71P3z4HgSvDrpJFEXq2lejIER6/E6zAui3X/yL1YZbvPR5MW46DZPgRWe+9
         VUow==
X-Forwarded-Encrypted: i=1; AJvYcCWd3wgzrmQUl4Onz6y4W51nSX3eEWyrjnqNABNtKEPHkfoXu6fLvpvfOSG7yfiOgJO3EoDUEUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kES9wbckaRyATA2EYol5bY8MI8azipUDGfsm/+eBagxeNKvL
	4aenn2KaVDOY/vbc90IMWLa3xZIcl8HhiOByXwdDpuFC5ql1hoDAFqi0ABn7R2/X9v1ZmVOlLJd
	ZwCxK4Q==
X-Google-Smtp-Source: AGHT+IHOMtYygvUGV2k6zs0tH0RyU02l4FUoSknqhTC/c+KAz185bQl3UuL/CHByLUmRLN9AlixhARfWks0=
X-Received: from plblc11.prod.google.com ([2002:a17:902:fa8b:b0:264:ab88:6768])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54f:b0:249:308:353
 with SMTP id d9443c01a7336-25d26d4ca85mr186922425ad.41.1758059287260; Tue, 16
 Sep 2025 14:48:07 -0700 (PDT)
Date: Tue, 16 Sep 2025 21:47:21 +0000
In-Reply-To: <20250916214758.650211-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916214758.650211-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 3/7] smc: Use __sk_dst_get() and dst_dev_rcu() in smc_clc_prfx_match().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

smc_clc_prfx_match() is called from smc_listen_work() and
not under RCU nor RTNL.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use __sk_dst_get() and dst_dev_rcu().

Note that the returned value of smc_clc_prfx_match() is not
used in the caller.

Fixes: a046d57da19f ("smc: CLC handshake (incl. preparation steps)")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Dust Li <dust.li@linux.alibaba.com>
Cc: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_clc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 976b2102bdfc..09745baa1017 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -657,26 +657,26 @@ static int smc_clc_prfx_match6_rcu(struct net_device *dev,
 int smc_clc_prfx_match(struct socket *clcsock,
 		       struct smc_clc_msg_proposal_prefix *prop)
 {
-	struct dst_entry *dst = sk_dst_get(clcsock->sk);
+	struct net_device *dev;
+	struct dst_entry *dst;
 	int rc;
 
-	if (!dst) {
-		rc = -ENOTCONN;
-		goto out;
-	}
-	if (!dst->dev) {
+	rcu_read_lock();
+
+	dst = __sk_dst_get(clcsock->sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	if (!dev) {
 		rc = -ENODEV;
-		goto out_rel;
+		goto out;
 	}
-	rcu_read_lock();
+
 	if (!prop->ipv6_prefixes_cnt)
-		rc = smc_clc_prfx_match4_rcu(dst->dev, prop);
+		rc = smc_clc_prfx_match4_rcu(dev, prop);
 	else
-		rc = smc_clc_prfx_match6_rcu(dst->dev, prop);
-	rcu_read_unlock();
-out_rel:
-	dst_release(dst);
+		rc = smc_clc_prfx_match6_rcu(dev, prop);
 out:
+	rcu_read_unlock();
+
 	return rc;
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


