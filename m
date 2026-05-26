Return-Path: <netdev+bounces-291956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF8YCAYaFmqEhgcAu9opvQ
	(envelope-from <netdev+bounces-291956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:09:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9425E5DD18A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82E7F301300F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4393C3C5DA1;
	Tue, 26 May 2026 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="CsGe4Tt1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648B29A32D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833346; cv=none; b=kWHF/om72bg0GGVJgqirEfiAGrp0i0TO2+X5+4ynpCTDF/Cq/F52kc+jbNPqGApam/JuSTS6AnJ2AU5pPq2gOwXMkWGSBvdn9aDVkq5dSfN5kpANLIC3HiaQVWVvxWpqEPzyrGzBJ7CpYY2k4xcYh4mzdCMnxb/CvA8T+JeaTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833346; c=relaxed/simple;
	bh=v1fNEW1CUkenypQxcpfx96PucSNIlS2ovv28XZSpsfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtqI/pgdET3QfpY/0uJNGEN+wOUodjfKHs5jJKMgM+yovgqhE/eGoYc08wvV2JOnb1pTIsIIwqXzCNYePVMHmqMLNLnQFQjAaTXWrhLiqv4JDYIoWDNwMDKGCgx8Dr/XdE0SDCHvzErK7Fn9pU1L1vLjOgBUAQrmSNDzWALuIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=CsGe4Tt1; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso199389776d6.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1779833342; x=1780438142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo4q5u1cngoVL2GKQJNtjQ/o4VaVPhWtqVFE1iLulo0=;
        b=CsGe4Tt19knjquAlUz9cGgLK7Jz+LZNKb6Yug/HsXvxt4VqKnA/44AHQou6/ASDbJz
         QEVhTKEXZ2BNgJENu248N0WC3V8Y5guRyoxWEIBOrPlAZCpkWwSRAhiYaKsrbYbgHNJH
         gAI4r4SKlBlQiB+RSDcyqCFc4mtd2a6h5WLrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833342; x=1780438142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo4q5u1cngoVL2GKQJNtjQ/o4VaVPhWtqVFE1iLulo0=;
        b=Xlo5wZdIuh80Ypu2p45qXPZXOkh+UKcZ2iuMyOI2tkO5SpRFqVBU/0FdbXStRZrlnv
         YcF7fEfFJKj/wOEvRmg/kzlRK9a2RkFVNIEeO4LqsHcekVl3FHtStk7o23wXJ8JCzkJ6
         xT3oteeA8yioAP4rwk6ldqZV1QfnXIZLQfoOJYq7MzaJEseaUCOVywpItmDs0KMUsnaM
         As++10t5kA4pbFaMGquxx6/pFAKpLB/E4JZ6AiWAMiCI9WgNlg7OicO4PyhE+Do8pFvZ
         +5AWFj8GiYOt3BQ/1Wr7w2rMgqE0sttQUGbaMu8XgrvXKKlPFwzuUg3NTEWZmeIHj7z8
         14gw==
X-Forwarded-Encrypted: i=1; AFNElJ9xXwho6bhdex8d3QVxJkP+NPdyjlpa0OzLlJxNoxjk0WzVIOm/+GSa/JWslPQ57M30sZDEjvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYyx+HycSFmLCSDWg4knLvqQmkVxIzkR2PyV/lN9MWnbcvpz3r
	kaai1em7tqdaMsRlizQGh6E1W1X4G75AdYYPsnY6v9QRGKyLFicZ8DvidVXQ9tIZCfo=
X-Gm-Gg: Acq92OGEAPGIV78xAd05tTODPVk3WuPMAZC7qs2EAof7ln0C5y8lbM2uLe0JKQhzzfI
	YiN0gzOKMuiOIRylTXLDnkJPrQkhKKSetMyxfivsLyZAPtwWhpBCBP8kox2MbUc6/OjCF86EGAW
	5WJ5b80Xag7FhF4XzhHIBuf/ekWcOCTXcXJUIq7KddcHn6/POoo0q6N40xyZh99KuqBWjCre2Gr
	4fCUznthL2SSfZN6DYcpQ2ffORrH5xLMFzJpBeIbvqun0HXE2Gy+roGPnphXIbvZVrUjvcdhIQl
	AN/z/ftZJriFU74D0u/noiP02JPupy5oD5r3VjIuCYS0wficIO2Ih1bEJ5tSS26daNCa60oEYhp
	Mt4ZduS/23paAOFqF64AYszziLgZTLskUALqSMsXnbFVwYSffquPOJwb6yNhrtzGF3mdNFsOHnS
	KMCw3MhDD6eGauK0YQON4kDxAm5pwGXcvde0ztEU5Q39xdzRAF1y60/MiEkVM97hXLS4rzMpY1R
	ARATPqsuar4f9/QizEIkMRRT8rYHR8LMKnLDfRAQFrWgDaHmJzNMkzi
X-Received: by 2002:a05:6214:3c89:b0:8cc:611f:197f with SMTP id 6a1803df08f44-8cc7b69fb91mr349610706d6.44.1779833342560;
        Tue, 26 May 2026 15:09:02 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd43dsm152500136d6.3.2026.05.26.15.09.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 15:09:02 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Buslov <vladbu@nvidia.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net] net/sched: act_api: use mutex in tcf_idr_check_alloc
Date: Tue, 26 May 2026 15:08:47 -0700
Message-ID: <20260526220847.28365-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291956-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openai.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9425E5DD18A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the NEWTFILTER path uses RCU to guard action idr accesses while
the DELTFILTER path uses mutex to guard action accesses. This
inconsistency leads to a race condition scenario, which can lead to
erroneous operations on refcount, eventually leading to use-after-free
situation.
In this patch, we revert the introduction of RCU back to mutex in the
NEWFILTER path, which is consistent with the DELFILTER path, avoiding
the race condition.

Fixes: 4b55e86736d5 ("net/sched: act_api: rely on rcu in tcf_idr_check_alloc")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/sched/act_api.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 332fd9695e54..63841c3e4310 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -874,36 +874,34 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 	u32 max;
 
 	if (*index) {
-		rcu_read_lock();
+		mutex_lock(&idrinfo->lock);
 		p = idr_find(&idrinfo->action_idr, *index);
 
 		if (IS_ERR(p)) {
 			/* This means that another process allocated
 			 * index but did not assign the pointer yet.
 			 */
-			rcu_read_unlock();
+			mutex_unlock(&idrinfo->lock);
 			return -EAGAIN;
 		}
 
 		if (!p) {
 			/* Empty slot, try to allocate it */
 			max = *index;
-			rcu_read_unlock();
+			mutex_unlock(&idrinfo->lock);
 			goto new;
 		}
 
 		if (!refcount_inc_not_zero(&p->tcfa_refcnt)) {
 			/* Action was deleted in parallel */
-			rcu_read_unlock();
+			mutex_unlock(&idrinfo->lock);
 			return -EAGAIN;
 		}
 
 		if (bind)
 			atomic_inc(&p->tcfa_bindcnt);
 		*a = p;
-
-		rcu_read_unlock();
-
+		mutex_unlock(&idrinfo->lock);
 		return 1;
 	} else {
 		/* Find a slot */
-- 
2.54.0


