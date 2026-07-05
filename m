Return-Path: <netdev+bounces-304805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FNVNCRygSmrOFAEAu9opvQ
	(envelope-from <netdev+bounces-304805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 20:19:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3C70ACAA
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 20:19:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=jj5OJFHQ;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304805-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304805-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A449F3010508
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 18:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2F239EF05;
	Sun,  5 Jul 2026 18:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EB34F492
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 18:18:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783275488; cv=none; b=Xw8u5rkfxr/8UPsjibBpk6B4eQ43wk/ECrxcFn55uI1vvWrXH7IucAFvWh/pM243/zSXOsoCjATKhx6wxvgPwZXjsZbgfyLgLOtucNfGywNqYGu+1oiSKAcRaLlInU7u5v9ifStVYPIGnGq2DgQTezCfF78KBhWuJAjjuSGKdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783275488; c=relaxed/simple;
	bh=Mp5nM8HbeXTyX1RasxpNHEl/27ckYE5zN7xcRf25MRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rbiLp5t70SKRiju5SSJ9Xbjl1zK9mBQ8IV0gKot+4wNABeqtdumCgCQ65ClVAKV6m0oh9ceINrKT6jWzoe3Od904gx0JS0Tzqc2QKCSYiDa2EA1NLzXLvm3GlBB5tZQt0QzlW+8IM36QKub+rnS1WRT46t41CiAXQi17tElYKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jj5OJFHQ; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-51bfe3fa93bso26526561cf.2
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 11:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783275486; x=1783880286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1rcvuOqxKDy1iKlxuOWerTQ9OgOb/qbWTlWxsoUA4I=;
        b=jj5OJFHQx7n5NZSAFhNK2T1laaF67tIp/9KDxJYlCTTZAEgFZ/f8L1q6E1c3+YOWpQ
         z46bbcozSVCuHlgDvpcoAz25shjRXZBhdqe3Xw9/NI/VwuxS/MdrPTsYag9hYQZhxVN9
         dI3Gk7iMhJxGx9gAdyBHShwWk0qnQP0i5x2iKVsvtvsEl8IamLwsQoqzOMlYF2SHQLsy
         28mNhwMHcDUYLxj/TQHJ9Wgc0AWm7VjcIQ0h0XNVyNWgc3067tSTzkdK87tzE8seg820
         Un3aERX93fSRjEM8J4w8hKnxhQR7pDpM6aNrrAMpkDYsAaoyImRGlRhP7hrHUE/jB/7V
         Ejwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783275486; x=1783880286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1rcvuOqxKDy1iKlxuOWerTQ9OgOb/qbWTlWxsoUA4I=;
        b=K/x0qWTxN231PHzHNec68UNSlmP3eCvEVKiwMN2L15pcKqnn5BMe/3kJ64ZmmJcPhz
         rFyhHmXdvp1tOE6Gi6LZHxx193H5wyil3ys1sqNp66FOVy2nPKqhIQsrisIccnGqsYNz
         GAcd8YTAR2hnHQJGB2GZUp5jGL0OneWIHspO/6igsrRDOoiGarqRD3323HfiOENu5ILm
         F7U2tECcvQfuXnIi4LnvSvo6Hs3WprCSH35Yau6PBdq7XeUJB7lyq57Qk7+y6hkn+sPr
         dJ9Nr3RgzfrHsAbzYF3h/ptlV4ddXfxZ05HpFHFbuirIHO/xkXu0y9BBT/qGgOXaXqQK
         rreQ==
X-Forwarded-Encrypted: i=1; AHgh+RqeJEaWbJyihmtpHXvbsB+dK8C4xEwf4bqdUxKmE243W0U8LkRUemUntuj16rO2sJHQGfQd2z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoIgzjSKS8LVhz3FWTZ9bhXZUSCu5A6vJZX43JewV0JuNuapU
	KzKWls+gpaC0+PTFnrOHsQOX7OCpac+uINM9fk+VKEe4kj9hU1cgJInhEDMZ06aQ4LXPWLNDXDA
	zarnPKWhUKxwJJA==
X-Received: from qtbie21.prod.google.com ([2002:a05:622a:6995:b0:51c:3cc:e861])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8cd:b0:517:906b:c043 with SMTP id d75a77b69052e-51c4c2be21dmr100129061cf.36.1783275485694;
 Sun, 05 Jul 2026 11:18:05 -0700 (PDT)
Date: Sun,  5 Jul 2026 18:17:56 +0000
In-Reply-To: <20260705181756.963063-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260705181756.963063-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260705181756.963063-4-edumazet@google.com>
Subject: [PATCH v2 net 3/3] ipv4: igmp: Fix potential memory leaks in
 igmp_mod_timer() and igmp_stop_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304805-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DD3C70ACAA

When a timer is deleted and not re-armed in igmp_mod_timer(), or stopped
in igmp_stop_timer(), the code currently decrements the reference counter
of the multicast list entry @im using refcount_dec(&im->refcnt).

However, both functions can be called from the RCU reader path:
- igmp_mod_timer() via igmp_heard_query() -> for_each_pmc_rcu()
- igmp_stop_timer() via igmp_rcv() -> igmp_heard_report()

If the group im was concurrently removed from the list by ip_mc_dec_group(),
its reference count might have already been decremented to 1.

In this case, timer_delete() succeeds, and refcount_dec() decrements
the refcount from 1 to 0. Since refcount_dec() does not free the object
when it hits 0 (unlike ip_ma_put()), the im structure is leaked.

Fix this by using ip_ma_put(im) instead of refcount_dec(&im->refcnt),
and deferring the put until after the spinlock is released.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/igmp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index f5f9763895641bf86bfcf9fd7fd7b06012fa4ece..957013e7f7a25f32d848822caab322147db3dc6e 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -217,13 +217,18 @@ static void ip_sf_list_clear_all(struct ip_sf_list *psf)
 
 static void igmp_stop_timer(struct ip_mc_list *im)
 {
+	bool put = false;
+
 	spin_lock_bh(&im->lock);
 	if (timer_delete(&im->timer))
-		refcount_dec(&im->refcnt);
+		put = true;
 	WRITE_ONCE(im->tm_running, 0);
 	WRITE_ONCE(im->reporter, 0);
 	im->unsolicit_count = 0;
 	spin_unlock_bh(&im->lock);
+
+	if (put)
+		ip_ma_put(im);
 }
 
 /* It must be called with locked im->lock */
@@ -266,6 +271,8 @@ static void igmp_ifc_start_timer(struct in_device *in_dev, int delay)
 
 static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
 {
+	bool put = false;
+
 	spin_lock_bh(&im->lock);
 	im->unsolicit_count = 0;
 	if (timer_delete(&im->timer)) {
@@ -275,10 +282,13 @@ static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
 			spin_unlock_bh(&im->lock);
 			return;
 		}
-		refcount_dec(&im->refcnt);
+		put = true;
 	}
 	igmp_start_timer(im, max_delay);
 	spin_unlock_bh(&im->lock);
+
+	if (put)
+		ip_ma_put(im);
 }
 
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


