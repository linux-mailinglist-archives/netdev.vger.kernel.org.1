Return-Path: <netdev+bounces-291260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JgnLgsKFGrVJAcAu9opvQ
	(envelope-from <netdev+bounces-291260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:36:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 378445C7D74
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D666A3012BD2
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86D3E3C5B;
	Mon, 25 May 2026 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+tOoOx9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806073E3C48
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698149; cv=none; b=rEEqo9HfYCKVVvk/Snlkp4ZkcWWWj+uFcgZKeTEwqWuqrbC+so0HdGbOGbb9WR5kG5MIInS765lNJa07eIPlwQPHnCwGrSrbCvkr8uqCJT+geYHtMCTJaIG3CNgTtYlWcy6ER/1yMPxvJn8XEQXJlHCXRckEASvcXc8a9n2srCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698149; c=relaxed/simple;
	bh=Fm6VNA3xzudmTAgja+duumR97nrJWZbAExcE4EzbtiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oUiidLISPBIxw5syEX9KOBez/cAEvChabgf60XkauLrZk/Vzf3q6bb+QQY53xNH5GATCsmKV5VHqFo78uYIlwUQzLyw8gAwwkHKMQZEyTzRKajkuzl81O2NKwuT4GmV1oxrr4fGEYhSnKD0nOmNU8CPOOyvQIyO3VwbEjJLJNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+tOoOx9; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-516e0846095so38764191cf.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779698147; x=1780302947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYdMnQmiPN41CnN+XQjD2+Uwgzy/HF3jAtG3QIC0KLE=;
        b=q+tOoOx9pmpkPXXDD5QYygwczijYFvtpv7hzEXYeZ29PNTbazdHwWwpwRPXM1p/3j/
         uymSwTEdAlbSSvKDVDkyOoL09Mn89AHbPGx3znM7joQoOXTBiO3zA+XvcUbQ3mZrufMI
         2RBxvBx387W2dCaHgicjcIzWgl5ldvmMGdNVrWDvixaxXL48Xn1H76FN7XhgnTwoKui1
         615jpD2trakB1W0/1oyFyB4q6VfdeNhMcVCw1N9TmWkweUxJ0y9wQ07lEaFezlldQRB/
         ukLQR6Y1cJe8RYY0tDr0O9Y8L1a5ZZ8B5Q4GnVsZdmjHWazQit54i5LVA7qNH+ElHIof
         4IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698147; x=1780302947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYdMnQmiPN41CnN+XQjD2+Uwgzy/HF3jAtG3QIC0KLE=;
        b=TlRCeqUS3dl0S+kkyIht/0cUvZVtHjiFotrAs3o9lUVPjNKN3TpJr9O3gfA4hleXLR
         dYTXVdVvy5u++EpIQGzc70x6QzsGUV4lank+nKCr2PpVe2qhZT8d5tngwzMY4P9fEL7B
         wGahit3iqOoSrHXJQmTOZXs0kc/J/Zd+k0YreDQWSyJYq/hYTzK73K3xegC0rpXeOTmq
         Uy1g/nBt2L9yWsdVkzDiuJ45FUiNgN+beWSHB/WNnHK78ZaBkhvEz/50InwGgHruoVnN
         QaFiIhitjX0uQSf17A3e4j4+R0BP7f0sZbbvf5IHerqTHqpzvROcvqiFLB6ASn0cVO+0
         QEqw==
X-Forwarded-Encrypted: i=1; AFNElJ/MZw7JJn/iA38uHw+Ar5VUQGgcXjLSXLBXCIKdyO/lw8jgaTv4x/rsvLt22csMioKoSp7M01I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDpqoYlCIlNW5IR2MN5fXUTmI4d0nG/6Ax5Lm5hRNPZFEkZNO4
	C44SiRXrhp8Jm64nEI2yPDXSDpAM6b51MknjqcbCoLyVTxJY3U6wMD795Bcb5qoDMxWFhOMXRYe
	re4G0ZSkYZZ73gg==
X-Received: from qtpd5.prod.google.com ([2002:ac8:6685:0:b0:516:c9b1:8ef2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1441:b0:516:da58:35c with SMTP id d75a77b69052e-516da58061bmr160535021cf.24.1779698147272;
 Mon, 25 May 2026 01:35:47 -0700 (PDT)
Date: Mon, 25 May 2026 08:35:39 +0000
In-Reply-To: <20260525083542.1565964-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525083542.1565964-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525083542.1565964-3-edumazet@google.com>
Subject: [PATCH v5 net-next 2/5] net: defer netdev_name_node_alt_flush() call
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291260-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.947];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 378445C7D74
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


