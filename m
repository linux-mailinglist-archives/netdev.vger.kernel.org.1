Return-Path: <netdev+bounces-291729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INfgBHS3FWrKYQcAu9opvQ
	(envelope-from <netdev+bounces-291729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:08:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C75D8568
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C0E030E8986
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B67405C37;
	Tue, 26 May 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PW86hKXO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649354028E3
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807337; cv=none; b=BO4yukkWx8UjTr2pNftu3JTNZ2hb3NEwsZ8xwy9iegDtuLAILNM8cPmP5WxmhHQ7THO9Pk7K4CG+UUfRzzzOI8T8EuRqvarNhsBuTCEaSFbZd8DHxiWllU7R2xnvTNEx7P404oy1/QEfiEchRqvIN/4AaEiyWJgTDbSIi0vGV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807337; c=relaxed/simple;
	bh=mmeTvKTRuNUZZwda5bHZRtranFRCdLoVLq1by0rEvHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kJDcINa8Fya3cczJtbpOqurXYwo2ba5GnYOS95KWuze87BWgakH8PaUbkW94A4YG7tQScOm4VsRZ2EH1kGqipn+2oDhNvNrDrxR4QpfDN4/Wd6SK2U+KdJbww0W1Z/BQDvG1wVGbVVU2kCq1cqCyzYl0CmCmGOzaCaDSVCAL70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PW86hKXO; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-910304978f3so2086613985a.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779807333; x=1780412133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bQj5LQ5F4X2kAMQs4cOF77TR07C4F7m54wtgO4eJAo=;
        b=PW86hKXOIeQad04riKjWNNDvuvSi8uKyxS8i4iNmclGQHFhRQ1bfV83r789fy74Zvb
         3bVavRoGYaWCUYyyGE4GVK+63ymvE+wvOxNITqCZ9mzUBn9tc+OfC3yVuDjY15P1XQJk
         NYXAiRX3JBxI3OAMSiIN9R+peMG2U9MkDziDwe+Qkob8L5DT77Wbe+Z1wUiiasek16Ih
         fG7aEva0bL2EDZypZnMjagq+n7WGH6iMfumYAkdSVnUWruPgzoASzJWVB/JhHsIwO3bG
         QVGbgl0oFqzL5hYHGM1onmnK80+E5Nc5oMleZCvGWFcqAUBlUji5JHO7WcW9LF5XG9t9
         1EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779807333; x=1780412133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bQj5LQ5F4X2kAMQs4cOF77TR07C4F7m54wtgO4eJAo=;
        b=YdWUUBrXD7FEhI0eM/ou+XqjZco3ZllVrkctLh7nb5aJ8xKksi6Lnanztc/ZYx1wwO
         FjW9duapu/hg5H/nf1wfnir7GoN4O/yg+keXgYwhNoJ/ZTPpfDA4mR8LggWwPY7ux9JB
         coOWdHPjFZfSDW5IqgPBb6hAPQEbbY0PNyO9JXySDIPIX8wnaWlOhpm31w4L3vHwPRX7
         d9eI9K9kYyin8jTRuNqACsNbBCLGbRpLFxdyLx1NopcIFF3C+8TO2f0hyGzcNohL7nc+
         5dW7ema7xFQw3nJQ/vrY5SILqv2Al4t5CqxjNgTsynZuHxaY5Betbm2Jdqc0Eo8IFQoJ
         8xLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dqh6WCRrtayzaObECI73iL2Wi5MQRxoJ4MgWbM4RSnREVwvqJxwIceOBDTVZpPWxuZaxbmW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTcgUvcaQcRtYJIabjyND0wH32JJGR/IiFf1Ehx96OvfidggV
	JaLDwBCU0jP6KQy4pICzoE8OoIfxzBh6XjZKJgl/qALTNnwke8hXAFvjqXcPiSPXBdhecpROlmt
	NDon24oOoSgRVaw==
X-Received: from qknwj15.prod.google.com ([2002:a05:620a:574f:b0:913:e44:7bac])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:47ae:b0:914:a824:6695 with SMTP id af79cd13be357-914a8246d0bmr1952554385a.37.1779807332701;
 Tue, 26 May 2026 07:55:32 -0700 (PDT)
Date: Tue, 26 May 2026 14:55:28 +0000
In-Reply-To: <20260526145529.3587126-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526145529.3587126-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526145529.3587126-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/2] ipv6: guard against possible NULL deref in __in6_dev_stats_get()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Stephen Suryaputra <ssuryaextr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291729-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.941];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 685C75D8568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dev_get_by_index_rcu() could return NULL if the original physical
device is unregistered.

Found by Sashiko.

Fixes: e1ae5c2ea478 ("vrf: Increment Icmp6InMsgs on the original netdev")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
---
 include/net/addrconf.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 9e96776945e5f67f2bf2293c24975e6d6064aeda..539bbbe54b14e8108ff7304d7a08bc605655cc31 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -369,8 +369,11 @@ static inline struct inet6_dev *__in6_dev_get_rtnl_net(const struct net_device *
 static inline struct inet6_dev *__in6_dev_stats_get(const struct net_device *dev,
 						    const struct sk_buff *skb)
 {
-	if (netif_is_l3_master(dev))
+	if (netif_is_l3_master(dev)) {
 		dev = dev_get_by_index_rcu(dev_net(dev), inet6_iif(skb));
+		if (!dev)
+			return NULL;
+	}
 	return __in6_dev_get(dev);
 }
 
-- 
2.54.0.746.g67dd491aae-goog


