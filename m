Return-Path: <netdev+bounces-305886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xlO3Flp6Tmo+NgIAu9opvQ
	(envelope-from <netdev+bounces-305886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:27:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2BB728AF8
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:27:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=j1Ja+wTM;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305886-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305886-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A852316DEAE
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6118A35C1B4;
	Wed,  8 Jul 2026 16:04:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9237378D94
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:04:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526665; cv=none; b=EUATTy0uLfQXjdNLRGvJI5TdrB6k1/sZdZhH+jtGCNlw/sxUNH8QCqlSmG5B1vmRoSf+njfbSexVk5+GCCidR7JQZc2javBtBYpidzzd/8+lyZb3Kv+xbY+gDEIcDa/mJUzTgswtXUxRPFUcxC7aAk/yhDT14GeNUkSgmIInkW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526665; c=relaxed/simple;
	bh=sPpumqycK6C5b0QbNl0zyT/Ydsdvft2xFHFKa01eEy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ob3ixylYSRv5PLCRz9bnhI61EEfb+/uCwPx+LKUE9itzA+jBRUOBM4D/4HT2HoMkZIcVXH/7xH2FGQSUJfzsc8wRdV/WRCdTfDUFq2tEup36jTOvlF7/FYsFwiRUigj3uvlvaZsOSYRD2KVhX3aByE7ns0Zj26DxfJZXzoHE06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j1Ja+wTM; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8dc607c8a54so19013046d6.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783526663; x=1784131463; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5n84h4/tfrEEXaIfawWAsqMIVqhACZo1MG+eJjLBhwg=;
        b=j1Ja+wTMl20EsiN7ySOGsotlkQepFw9qcewoc2jH+mZJW6ZrwUsuqE66jixZDfc+SH
         E5kIqqTnXybS81y6wwwXkvq5z+q9BRvZfomrUiZ6JvUoY0sezfyT36Wn5MG+lNWDGUsI
         lVBLSoH+B7qQgf8xUBWfcFN5s8m2cfY0IcVtGm53V9P56Gtx5Jbz1mnJapVAh8sMnLAf
         YNO3StKZ5T4Y+gGgOPl5V9iGDDvK6JAClLwY6Wj7km+uWOS3dAT90+tdUCxI+1lkcDGH
         qjvCaz5BzcYtTOeDWuR5ChKWF8qg5M7mgaBVZpzBJAkkdWJCMmaqgs9iAebFerbSaQ9o
         25nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526663; x=1784131463;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5n84h4/tfrEEXaIfawWAsqMIVqhACZo1MG+eJjLBhwg=;
        b=EbNDH/EA2B0NofdaY8LUyqwRWbaUggoob+E05x3esPR9oVzqZAb5sb/92eUErbIKe3
         acw+CDb+VebhWKzOo9M0f+TW4vy0xySMCxsDlXYxce+TF7fjpecI8qQmM7eelVadpNYB
         L377bBRK0SJxnhUGcIel05Vv/fAqOvHY+R/Z9fUE3E5+xnAUcBVIvxIWsdyWi4ItBY9i
         LqILaD/kDHz3aS8UvWrZXj8OaoDKh/L0sZfzBgqQ9XvetiBpPEpsJr9UQWsce98u6onH
         N3G0zeSVrrXwO6F76GE4f33Qc1p7l8oAAwTVcO6/aXNk+tboev7CJdWx6I8toq+CjnWH
         XRmA==
X-Forwarded-Encrypted: i=1; AHgh+Rq370+8aVLpwe3o7KA78K6mdWPTUUzqyzNyKzkm32Qih5aW7zKjAoqfjAiWpWdmV+YtATViNss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxEb118xD3cqMzePYF3+pwsRbAfkGvxBoDlyXJzk2n47LWi+ys
	7jmQS5ARxaqO0gzg84Dr0veJQZ0HWcZ53wvymRRvbuZP4xSei6MghO9XeQW7FmbwxrR5FKNfdep
	SL51pt7PJIx201g==
X-Received: from qvns14.prod.google.com ([2002:a0c:f78e:0:b0:8dc:e799:c94f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5c04:b0:8f3:1770:f731 with SMTP id 6a1803df08f44-8fec0ac42afmr33236476d6.15.1783526662641;
 Wed, 08 Jul 2026 09:04:22 -0700 (PDT)
Date: Wed,  8 Jul 2026 16:04:11 +0000
In-Reply-To: <20260708160411.1355008-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708160411.1355008-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708160411.1355008-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] vxlan: no longer rely on RTNL in vxlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305886-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,lunn.ch,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD2BB728AF8

Now that vxlan->cfg is RCU-protected, we can update vxlan_fill_info()
to run under RCU read lock instead of relying on RTNL.

This completes the transition to RTNL-less link info dumping for VXLAN.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 96ac74fb1eb064d4e280af8ffa68cff37aacbca7..86b853d7739639b93b6468bc64a217c562b4804c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4674,10 +4674,16 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
 	const struct vxlan_rdst *dst;
+	int err = 0;
 
 	dst = &vxlan->default_dst;
 
-	cfg = rtnl_dereference(vxlan->cfg);
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
+	if (!cfg) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	ports.low = htons(cfg->port_min);
 	ports.high = htons(cfg->port_max);
@@ -4777,9 +4783,12 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		    &cfg->reserved_bits))
 		goto nla_put_failure;
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return err;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.795.g602f6c329a-goog


