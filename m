Return-Path: <netdev+bounces-286657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJqOIojgAWptlgEAu9opvQ
	(envelope-from <netdev+bounces-286657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:58:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347C50F7B4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F384306A553
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933A3F7874;
	Mon, 11 May 2026 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dw+kQApz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5593F2116
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507291; cv=none; b=JLSjMsi83ijsmsibQE0XVNhIEWpero410h2kKKyxJEHbFxmnwcORc6ng6ZxS6Mhm9+3ekKH7JwKZYcOONRYkcGTGPLoOcteTkK6ifgnYOpb8rMryApFnw4FeyUxP/m555dlskSJE7xrpEm3Kjd4BxzHpEwJheaMyiIYcvR0cXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507291; c=relaxed/simple;
	bh=mwbCUn08CWMwL0woqy177gkj8PZXx4Uk/KthAashRy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWP/oT/sMjC0SQuSsnX8T6q6wGmXvMOw8CSVwAoSTJY/5bhsYiVEOIlZwtYOLrhVtnSvLh6KOGZIrXkiKh2GYHCXwS0KQCDJFwi8OUUbdY40PRQwryO/ShTSz3IA/zxf7XhOQC1ZetWcuwQEu2sUxj71fusOdbn0VTB0jfXEOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dw+kQApz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48d102471a4so43197565e9.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778507288; x=1779112088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmJGUnALjoD0KZePhh+NZjTK3Hla1q67wmp2q20EKW8=;
        b=dw+kQApz6Plu6e2KvAy73Con9p5oCpwQnrP4pQ13yHwpy1T/8KAlt0meTVaZ/l9XsU
         PmhHfP0gRnRuCJiW2a3a4Z3vXw+pP0Wi4VU/kB6RICkauy1CewU3UEk2Z7KGV0Vqqry+
         7FwcwYCzydjUgZrd5wiIJgK8m2I+tVi/wTsIxRhbcUCwjLG6rlp+ZNfc/yQOHJyV74WG
         E17FTxkAnw4pnV3/+ZB7vFlWNXj8/1uDmrlUZGi2TLkatPxj7BjWm8GUUBs2Gd2TDOAl
         P41o/bAfUm+JERGbvA9AtbXFTg2Z1c04OjiB0C1spM0SruvoOeZXCQYbC5zEGOw5DmR4
         TXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507288; x=1779112088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OmJGUnALjoD0KZePhh+NZjTK3Hla1q67wmp2q20EKW8=;
        b=a1qZvEYp5hFBVjvYBHudDxCIBSwxOfbM0+KtI1fqVf+dkSIpgs0COkHQmwU9UvBnfO
         RueK4mkaCSviyIBtKE1pVwaxMK9ISsN5wocI6QCh8Xfj1azN+H1bnEi5vxs2X/ttQyha
         XZ28msOGTvdf9HzZtTMyu9768/tLI1Xmlp9jI4j9RAsVsRNp18ies53ycIz2F6HghZMK
         wlYvNXImnVSlGHsVKes3Meo8ydEyiGyAEh+aj5R92jjSQySwzweJvfBAET7tQD+tIrB9
         04UX5FmPsp/yn3uRHr7zzrfmUBpoz57Orna+gVintWXaZqemXX1xH934su0tT1RvGBZr
         NZDg==
X-Forwarded-Encrypted: i=1; AFNElJ8HT1MirtMu6p9uEO99aSUr4O/qPbEyME+hPrEGqkfZ3Nu986Ll4hOlMHpSP+dW3aywxeQ5weg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXwBhppUK0TSvuLbS1vzBq6TR/PGeA64se6ND2867h15clFTF
	XOqMoF6mvF5BiUdL3y6uwzKTsYmZJ8ADhBr1l7UNNOGu7I9NgMZnb1FnenvhvieV5AE=
X-Gm-Gg: Acq92OGDtxCSiP2/tpuwE7E+X76Zl6HS0+GXWF9UhTlRRtTaUzGUio9KH/lUucxn3/I
	+8Kg1eyMZpk2uD6CocKeHOk6YSJ3ql45kAzFjipdoTSZED04cU1PCa/EDUMDDizTK69mvZgcLsD
	hydeJS4LWy1ko8svVK3hWaE6xNQLWOlU5K5X16qfHUSnikp5HUNTA7oLL0aWDdybTt11sXleqU3
	Oam3/w3Eg4ljcw/0x5vSdvOMvwr4JuN6rK9yFz15nFRC83qOHAzjMRkDFgjJwLj+Lvdys8HP3KM
	+oBm/csObIiNEMilFQdHyMgkCw+fAXg4N2o6ZJapB/iZ21Kwgc2j7AhyAzy92LY41e/UvuAE0WR
	qVfGAp4yAB8n0LwO0TOyKG8LzvysoHUAjg8GS6jUNBbXtQKynuK161c17IA4/5k/4FqRyOIQLdm
	G4NEFA/mPtahamhuh5zQjanzyBlj2gISJejEe5fgTEsZKEQLU=
X-Received: by 2002:a05:600c:4703:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48e676ac055mr227158915e9.21.1778507288202;
        Mon, 11 May 2026 06:48:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e701e957asm188062665e9.6.2026.05.11.06.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:48:07 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 1/2] ipmr: Replace use of system_unbound_wq with system_dfl_wq
Date: Mon, 11 May 2026 15:47:36 +0200
Message-ID: <20260511134744.277032-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511134744.277032-1-marco.crivellari@suse.com>
References: <20260511134744.277032-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8347C50F7B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,google.com,davemloft.net,redhat.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-286657-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,suse.com:email,suse.com:mid,suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Cc: David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 net/ipv4/ipmr_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 3930d612c3de..867b24beded1 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -39,7 +39,7 @@ static void __mr_free_table(struct work_struct *work)
 
 void mr_table_free(struct mr_table *mrt)
 {
-	queue_rcu_work(system_unbound_wq, &mrt->work);
+	queue_rcu_work(system_dfl_wq, &mrt->work);
 }
 
 struct mr_table *
-- 
2.54.0


