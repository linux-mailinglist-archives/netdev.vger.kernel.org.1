Return-Path: <netdev+bounces-290897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEhpCtSVEGqBZwYAu9opvQ
	(envelope-from <netdev+bounces-290897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:43:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C305B8732
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DDCC3099489
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E614363C72;
	Fri, 22 May 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+OM0I3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC1357D07
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471010; cv=none; b=XtobKttvvRBP2QI5x3x1LkJFN5wEPiUCkwq96oI3Mww8pB9CG5i+sjeuQm+0igJaV4CY66YEQL2kfm1JsOIJ+nUIsA1Z4ZJTE4LziQHNkYWbHNGBLYjhDW/WgcMWuvLQUinKkGv4AaMSd2jX1Zu6mWXwiaR+pzDd/2sF55MD+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471010; c=relaxed/simple;
	bh=Fm6VNA3xzudmTAgja+duumR97nrJWZbAExcE4EzbtiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X539QvNt4WbssRdkD0/3fo9+AdM+PdYfsG29WGO3MxNVdVEe6WupSTB6BWcrRCE4+9qJltn4K14V6RFzNdJbgn0yWLzVQnlKXrSp1I4hzD7u5GUANcLNqqIChYP1/4fBHf82QcqjFmTpjJCCJdyLagi1A0fmNZfMUZMwEQ0G6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+OM0I3K; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50faf575af4so202198761cf.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779471008; x=1780075808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYdMnQmiPN41CnN+XQjD2+Uwgzy/HF3jAtG3QIC0KLE=;
        b=k+OM0I3K6yzt2tBUTfIe9TkVIushqlXtYht9Rj+0bXeY/t7paHT4pkhWzIfged5R7W
         nqSy2jhcgab0j0VixlUGtvwmEHgiC37fWDYjN+iL7iF4mtG4n+rloNyhjO+w2HQ+KWjG
         zcnG0cKfJgy/x8Ldpv/d6K8yq2kSZ8APvDUrs0QZQqwnJurbHRB45DP4wHkslCQ5PRZ+
         3CxW+9z5RvH1Kl/l4Z0e4Vs3Lc8KOyU76NqwgPEFf7QGQJZ38RgTMNPdJ0CIl8SExQMk
         PU7YjEQn0/QfASW9WN/rvuVWdChUmQR4xLaXrBzPUsz6blhQXTd0U7dayCftWl5AAioA
         PVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471008; x=1780075808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYdMnQmiPN41CnN+XQjD2+Uwgzy/HF3jAtG3QIC0KLE=;
        b=jv1Dr+oDSn0NDadRz2DX1wlOMq36H9Tyo1x1QFYCJYkA4rhfOJoZRpA+1t5sw4Qxbt
         cnao9t9vfJ0j28iR64vOi6zhm66fwA9B4eIoGyDg1FestYMGp7RChMvk5JI+T99CI/Jl
         Y2pBOzTx7GjVm2m05EHU7BQdoL42vV4eYgCyRa3flRwlBG80cyDsdJnIdyWQilAgrWQQ
         oPMZFTB6PeQSlJfF9GULBuo0WgJ9q+BKRGqE/G/OWMAXWGrQMwb8sZlbXXHvRaT7TNH8
         GvYmJDWKW1rhN1hmOyS1rAft/IiuilqQq03oNixO2KBEdCjzZp0XMPhFJDv9NHTskkvc
         A+LA==
X-Forwarded-Encrypted: i=1; AFNElJ8m2OK4kW+sj1Ac2BOepNPuWQ1F4R9an1LJOTKOQDrmEnCzS1XOzDJdxMr9htnQMOay9q08dDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/wELfQAuVe6GxJd33xcbFkRtlYkXUbKV1x627I/+oTFAONly
	IXv+SumV3reMvLDQtR8VWGZgMy91KOvslz8JW3/QcOygBn1vlMAd68vx8wxauZByfcjiAM3zxn4
	kldBZWNNQ37GIrw==
X-Received: from qtpa6.prod.google.com ([2002:ac8:7206:0:b0:50f:c295:b2be])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5e10:0:b0:50e:5cc3:6f42 with SMTP id d75a77b69052e-516d4685e53mr64887801cf.59.1779471007411;
 Fri, 22 May 2026 10:30:07 -0700 (PDT)
Date: Fri, 22 May 2026 17:29:59 +0000
In-Reply-To: <20260522173002.2181677-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522173002.2181677-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522173002.2181677-3-edumazet@google.com>
Subject: [PATCH v4 net-next 2/5] net: defer netdev_name_node_alt_flush() call
 to netdev_run_todo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290897-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.940];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 90C305B8732
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the following patch, we want to call rtnl_fill_prop_list() without
RTNL being held, but after a device reference was taken.

We need to free altnames in netdev_run_todo() instead of
unregister_netdevice_many_notify().

Freeing will only happen once all device references
have been released.

Note that dev->name_node serves as the anchor for altnames,
thus must be also freed in netdev_run_todo().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 26ac8eb9b259d489159c7ab5a2b206d425110b3b..2d795f3f569be00361809823fd3e59fb1871919c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11738,6 +11738,8 @@ void netdev_run_todo(void)
 		WARN_ON(rcu_access_pointer(dev->ip_ptr));
 		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
 
+		netdev_name_node_alt_flush(dev);
+		netdev_name_node_free(dev->name_node);
 		netdev_do_free_pcpu_stats(dev);
 		if (dev->priv_destructor)
 			dev->priv_destructor(dev);
@@ -12451,8 +12453,6 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		dev_uc_flush(dev);
 		dev_mc_flush(dev);
 
-		netdev_name_node_alt_flush(dev);
-		netdev_name_node_free(dev->name_node);
 
 		netdev_rss_contexts_free(dev);
 
-- 
2.54.0.746.g67dd491aae-goog


