Return-Path: <netdev+bounces-270416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KqaLYv7wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:36:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0C22EE504
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C03513025A6B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4FF37FF5A;
	Mon, 23 Mar 2026 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="E/qGczRy"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BE3815FA
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254909; cv=none; b=Wedt5sZGQKu5H+666vlmls4f5ctNcqtKTBjUHq/ZqOw6ecf4hdxCGwGKg8EjdjpLuL3j214CXKc+Xets+ulPX9asfUFVFHtCOVVxTTSD2Z3jleoaZGZCIBbvpvAvuV1nuXI5ZG2QqbEya+KpU8stB4ddOFINYc+De7yHlNycGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254909; c=relaxed/simple;
	bh=1Dlt6mwXZ+iKFUGfdkFqZNOedfzL5EjaHyF8YMHIIPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L64UO6yJuWTsz/xzJ9bgVRad8g4HPlAW0DQvWcZDSf54/mm/ssEloDu+exfLETe5mPO3ImFTGCugCS455d246RYob5yyS6CmsnBmXg5e2wfpLlApejdS2vQE7DQjFpx0wGgbTZf4KRTn7ijTvePP70mS1vTBZTZfQbsOW0J6FMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=E/qGczRy; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 64CDA205ED;
	Mon, 23 Mar 2026 09:35:04 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 864M2bVvfIma; Mon, 23 Mar 2026 09:35:03 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id BF53D206DF;
	Mon, 23 Mar 2026 09:35:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com BF53D206DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254903;
	bh=VRZwnBAwA5keyVCNYD/0ySrBiwmGBZdlXOVDxJY2Qjo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=E/qGczRyNHUuyRb73J7Lq0kM8FoWVBKAmqPhRQR18vSsPkm8SVsfTSgjPpv0RvV1G
	 xWx71QsucbaLMHfr7EsG8uKdvhdtO1eAwN9FIbnAKA46dYRmk4kzzBdsiLfcsKe4Nz
	 WRNKctz1cSTEsjTiJ6d69fEhM8Bj/J99oQK30bN0aHrwTj1AuKCpoeKJAukoi9y/vT
	 T/bn4LwtHvALWbynLnRKhh5J+Oi9S2wvNQdF81jCcZh+GXcRNxvCB+L8OQwD9hP7CQ
	 3vdqmVLzuwei+bpPUfIh1OH8bOYnhU41fDbFy0DBufXvALq2aow8IOk9nkNlIfOWGU
	 leq1oGC5IG7ag==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:35:03 +0100
Received: (nullmailer pid 2741848 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 17/20] xfrm: Fix work re-schedule after cancel in xfrm_nat_keepalive_net_fini()
Date: Mon, 23 Mar 2026 09:33:58 +0100
Message-ID: <20260323083440.2741292-18-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323083440.2741292-1-steffen.klassert@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270416-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3F0C22EE504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hyunwoo Kim <imv4bel@gmail.com>

After cancel_delayed_work_sync() is called from
xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
states via __xfrm_state_delete(), which calls
xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_work.

The following is a simple race scenario:

           cpu0                             cpu1

cleanup_net() [Round 1]
  ops_undo_list()
    xfrm_net_exit()
      xfrm_nat_keepalive_net_fini()
        cancel_delayed_work_sync(nat_keepalive_work);
      xfrm_state_fini()
        xfrm_state_flush()
          xfrm_state_delete(x)
            __xfrm_state_delete(x)
              xfrm_nat_keepalive_state_updated(x)
                schedule_delayed_work(nat_keepalive_work);
  rcu_barrier();
  net_complete_free();
  net_passive_dec(net);
    llist_add(&net->defer_free_list, &defer_free_list);

cleanup_net() [Round 2]
  rcu_barrier();
  net_complete_free()
    kmem_cache_free(net_cachep, net);
                                     nat_keepalive_work()
                                       // on freed net

To prevent this, cancel_delayed_work_sync() is replaced with
disable_delayed_work_sync().

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_nat_keepalive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index ebf95d48e86c..1856beee0149 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -261,7 +261,7 @@ int __net_init xfrm_nat_keepalive_net_init(struct net *net)
 
 int xfrm_nat_keepalive_net_fini(struct net *net)
 {
-	cancel_delayed_work_sync(&net->xfrm.nat_keepalive_work);
+	disable_delayed_work_sync(&net->xfrm.nat_keepalive_work);
 	return 0;
 }
 
-- 
2.43.0


