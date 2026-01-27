Return-Path: <netdev+bounces-253748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJdzI7ZzeGnEpwEAu9opvQ
	(envelope-from <netdev+bounces-253748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:13:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C590F87
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B2BC300DE14
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB702285CBC;
	Tue, 27 Jan 2026 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iX0kQv+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA31F63CD
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501619; cv=none; b=E+PLk9EjeDhFMF6rd7L7vknNfqHcgVtXxyLDoPkpSu7X0G5XEh+zzSpGKE3OZh1Few1nzV9HtKKxWB8hRec6vJZ8GNh/rjrc0hBm2LZBotctgE6kRf44KhBZkGB/Wq32moTQXdEwt7W9YFhZWO7BxIdKem/PoA5YY70h6p6YjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501619; c=relaxed/simple;
	bh=Ox+UMaVUBYYLMXiEvZHF2Gn9wVcJ4jzKar6avXl4210=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a1J4CgF382iVpRew6zL5Mf/431BiWQ7iNJRl5n3VTjBbcYvYNAnSuRFnDOrxvGFo878TzRrfPZg4fumfvJ37eZdkZk8FS4Bau4gKPHzuUETcuiXXj5bMQQlIFKH4CuZzUQNvYABv9EVL6J5/yoTYecQQQt339D5PBlK7q7VClBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iX0kQv+N; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-823486f311bso1000719b3a.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769501618; x=1770106418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tC7pGhO4bAf1qIwfBEWjHWijVGevxhDxn3OWhSV6Cbk=;
        b=iX0kQv+NNj4JzATofxsiGdM8wCo8cha2k3546iforqXh9yciQ5us3E3nQMFHeXXKvd
         716ZICm8y+HrwqezQriQfMDzac2USDEh/1AaLKWNrWSbFokvraw03YUack+iFGrkvmGf
         77HqMvcPfS6Tl+RsQKcQo97ggVJcF23HK5kx4OkHCMGI6AJfzBpZcutI9+1H+woObGdd
         vds/eGmBoyDltG1tgsF7XzHpp+YLW9cxoDyDFhkooPNqhNCFP3Lp2W95lNgQ77lHQSyR
         /iL+mkA3jO9wzqcJgG0oahCABp6thnuBB97GkN7kPRkJtd4ksEqiUaFTsF6w7PeVXGhF
         QeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769501618; x=1770106418;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tC7pGhO4bAf1qIwfBEWjHWijVGevxhDxn3OWhSV6Cbk=;
        b=Wd8TucpHN/ZNhmruP0Hiuuitqev+iW+DUXXlOJe8YpwptyQ7vbRkmHhGPtx/5qsUiW
         FuLdwJI1qAw9+cQZm/DuOKXcw095gECd0AJiBJQUx2643y61oYaL3JvK2t1vJlfbrfn+
         rkltjFlWHNUFcsC0vBX4RtSF/Duo0jOInHjks9jmGMNZsnqoammOoswrXgTLcvUhEvAc
         MrheUUVXvvOl7aDadeA2Xmse6j68eQ51QY3ZwLihUUnIIv2EgRonddJO/60BGZ0rvdET
         BpOt8gyvl/EReQFKfoWCBIfk40mgjL1SDCV6sDVYaxTNsiJLjnaKuwoLYWxtPUU4mqKU
         6eSw==
X-Forwarded-Encrypted: i=1; AJvYcCU/mJy/D4foCulPGfTMAQMkEAsTSvVqNgSgbD3yIX6+ZWZf/TJNkYVzBm6QJkXmvPK/fq81rTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOnOmWqbm/eVMojRa9EjxGmdPpzz/hCpDstvr+8ZbuU5CDxpYx
	7n7bBsK3kjNzxvgjtvdXNkI73ri1tgKbNQdLGcZExM6uc3+fAxYc/ihZItF/kRn0xODspzZVe2p
	001KFkQ==
X-Received: from pfbkr11.prod.google.com ([2002:a05:6a00:4b4b:b0:7dd:8bba:63ae])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d0c:b0:81f:9f41:34bb
 with SMTP id d2e1a72fcca58-823692cf1eamr984482b3a.56.1769501617709; Tue, 27
 Jan 2026 00:13:37 -0800 (PST)
Date: Tue, 27 Jan 2026 08:13:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127081335.646666-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] ipv4: Use EXPORT_IPV6_MOD_GPL() for ip_fib_metrics_init().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253748-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC2C590F87
X-Rspamd-Action: no action

ip_fib_metrics_init() is only called from fib_create_info()
and ip6_route_info_create().

Let's use EXPORT_IPV6_MOD_GPL() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/metrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index 8ddac1f595ed..82cf8a9e5ded 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -88,4 +88,4 @@ struct dst_metrics *ip_fib_metrics_init(struct nlattr *fc_mx,
 
 	return fib_metrics;
 }
-EXPORT_SYMBOL_GPL(ip_fib_metrics_init);
+EXPORT_IPV6_MOD_GPL(ip_fib_metrics_init);
-- 
2.52.0.457.g6b5491de43-goog


