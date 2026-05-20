Return-Path: <netdev+bounces-289881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFV2MqWODWoIzQUAu9opvQ
	(envelope-from <netdev+bounces-289881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:36:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0AC58BD6A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DF9D302B76D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6E2FA0C4;
	Wed, 20 May 2026 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CroOg7yJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C83D6CB8
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273157; cv=none; b=Eje89FSYpRS3WkQfP5lsSI/LpBPxxxirEGMrt81oEbuEZ3HkKp1BkPVEoG0SRWGAOm+tYnpVSPhcU2NdhsGVt7CfWOzlr5RgdutLrfiGVXLAvg+mYugU9O8I8ab7VQJv10jFQ7Y68cX6Ei7i8YxdBD2sX54W0wQEckoGtCXV71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273157; c=relaxed/simple;
	bh=5HZpXYL1+yx+u+fKQ46ckqwYmogZOOGUvG/G3+qky3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a2uGnSPId7+czIse9Iz0078ItOaeEqdj5ySe2QGmIMp5C3tYtdjyHMySZj1EG9LqUE9d91qv+kaAL04BFRVOxUiybrz1CNW8CORHfuvyf0wVic4fCYzzrcjiaFRE1Xnp0eZXkwqdq0aCEmT7MMuD3oksFtvIBI0++mIUBs5LkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CroOg7yJ; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-90f5248b209so1134170885a.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779273152; x=1779877952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=261eqtSWtiLXznZIOGkWswG8v9FjA7zFYu1Otxst4kU=;
        b=CroOg7yJEeJ415sqJx1ffBUSvWhFhHF7DNvGsjv//A/nA7fwhtITx0MFY8GvU1E/AY
         NdfXolyT9mFm0rBhBl5lIZn6o/8tkG7e4v44E2HXhtONKEG3ogE9ukZrg5vB7EnmG5t4
         0MaIBVbBWtjGNwwhUSVY8w5gZ8JyTZmSAB8YtxeZVcw8mOIujt1Kb1G2jBfzMZd8ZPxL
         li2ujdaNBKGKkqWvIi/OymE/Vx2HE2cyLRt1/GtX4zrRtstCKDqFJSDZvJK8M9ZAJ/hb
         HHX4Gx9DGT9SGAQDNLBRuobtw9yfgKHqV6/lVTUgiDpSBfKvRzI9kXWnRcuSY4E7YQzR
         NRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779273152; x=1779877952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=261eqtSWtiLXznZIOGkWswG8v9FjA7zFYu1Otxst4kU=;
        b=B44GZ51R9eVs203VCCqaVMj1uahdDo2aB4fNhTpmVU+WFCz8zYtuo8DjvQvAmavWve
         DBd2v45G9n/ddoRT+RRuaG/VDYEPV0xEZgQ6tqKgP7u1HWC+hqTOFAXP5QD20gmGXyJp
         t7w0BeSQ8PCSlVmA52gS1DFSE0awyvyHovF9r4HyhXlS4eAUYXKuYvAyUPx2i+dWmAXE
         J3bQghgFGsIbCSSz/YWYAu5c7izfQ7SZzJAgJ/aMMM5RxMJuUqMlAKd593y44bsbThd4
         r8FZ1mDqZb/h3TArZKgHZh7wb4uNlEXMsOO2NBLp66Z8oylR2aFOPrw+qYqvZaqRLzZv
         CQCA==
X-Forwarded-Encrypted: i=1; AFNElJ+vnknvFoTAaIsNQ3EaHqla5n0ofz9ON9v4rg0URe3POw0tlj1Yrj/Oe9ApW/iTPhPQWfiyLpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTqTimaqeqmdujkHQbcF1OER0Hi1brcCcAiBrzn3ib4EMFqC6
	/PBBxtX5BOqlCWSs6D7FxuCdzCkg9IbQbTwdicHfpxF5mobD+SmFIRQNZV3rB5zqNywuupOWXnm
	LvZsHNzDcZvNcgA==
X-Received: from qkhk26.prod.google.com ([2002:a05:620a:b9a:b0:911:449d:98da])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2950:b0:90f:9cde:9788 with SMTP id af79cd13be357-911cda50d4dmr3493215185a.5.1779273151575;
 Wed, 20 May 2026 03:32:31 -0700 (PDT)
Date: Wed, 20 May 2026 10:32:26 +0000
In-Reply-To: <20260520103227.1133277-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520103227.1133277-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520103227.1133277-3-edumazet@google.com>
Subject: [PATCH v3 net-next 2/3] net: defer netdev_name_node_alt_flush() call
 to netdev_run_todo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289881-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8C0AC58BD6A
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
Reported-by: Jakub Kicinski <kuba@kernel.org>
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
2.54.0.631.ge1b05301d1-goog


