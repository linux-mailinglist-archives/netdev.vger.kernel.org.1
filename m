Return-Path: <netdev+bounces-253560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCe1LsWod2nrjwEAu9opvQ
	(envelope-from <netdev+bounces-253560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:47:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9544E8BA54
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C733830046A0
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7AD2356D9;
	Mon, 26 Jan 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MN/H6ZSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016D227BA4
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449656; cv=none; b=uo5AhbrVr5AAUq7917B+JbDSB1SOdVESxLdNYqZB5TOs9UqlZCE/KLZqqcguFSOwb8Aoo9tGsH79fcjq6dy0uZikXi4OwDUAYadSW//ORB8ZsNCcjcn+SG0oYiy/bn95NmWwILx9bf8I0SGgBFZEdMpavWHCBX8KDcXg6z2B+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449656; c=relaxed/simple;
	bh=ema1a2KpdOpyDo5YrebT6bq/B4CcTerMiAon2/OWrhI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=neV4pSZWIJ1xEDllClI5Pg5d1hUxVQijS8htB6qxQl7TDaJXnw5rz1wuCAZlsMWXv+eCUGD1vElE4OQ5ByK8A3ZCiulBbrFfsDSKMPJqafTbX4ty8QFpvwR5iJWtaUk7fVtQQMyX6tySg2+rSDuSl+htNoxAPu2tNdt/I7tbs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MN/H6ZSP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-793b9a4787cso65045537b3.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769449654; x=1770054454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=chdycGvo6W11ksxbIWHg35dhDO8ko+8sP9ia4DiczQo=;
        b=MN/H6ZSPZnXe8TipJlpPZMJZANpL0JdZgBryCbw0tvSm28YbphdrACBUA5NiDdyxi0
         J9kkjMQbJT55V1U2NEqsfiTvs2anZGiBgdDuM77W63Usz+nqc6FKglnsaeyzRO6kUxTB
         AcWfC0MNJVlWxK4aZYK6xeuGL4SDWCGZbOBfkFr+/Z0ghYp2m9tivYBptvTxRNMQ9U0i
         Fi6rxN+B5fQHIm52W/KYo9MoUJsBaZEpqtcvTaLy96MSrp78xsqZfHiy/jCCKK2kMILj
         JbQTVazn7zmkgQ11Q2SIVIVtUiRbISKA/JUAEWTI6kgjCSHQrTMqMlqqxpNvOnjqUj+C
         swaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449654; x=1770054454;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chdycGvo6W11ksxbIWHg35dhDO8ko+8sP9ia4DiczQo=;
        b=hfsQoal973+93sDbE5dAvfrVANG83JBFWozVK4RbbZTmLpwHqja34n/mmDNyx0vdnn
         gfDSGjVIXJCV/Cx1ICD0XfuhFk4W8VzY4MRxZgAHSRKz+6o285U1G9+hxqKACMu9otSA
         V/1oudnftFwpk3RVwVEQULlPxJruEqg1i4eowDiaPIZeKsmno+5umHM/wYwH33inm9Di
         0ZdEgk8/OJTJ2Ex9bBv8VzoBVZsztQ5tHadvVjiD//5Em64RzPfNKRqwKr81iV4sOKll
         I8M3LYUmnkGKJSnIyc9xFmvNCf8Kf2AW3U4c07isRs3kTYxABgla5LuvI0yVQDC0d6TS
         bDKg==
X-Forwarded-Encrypted: i=1; AJvYcCW4lbKVJ22qdhmWr4rzdRNOj5Hx/LiLnzTPRPQhk8cEwCWzLNBgGmFCMsScHUtM8PqgbvYOJNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJN8OeC3rjudAr5gjrlBq8p3qegDVUMhinc0aaPbdkhlW2RAJ
	P+1pUOfHoEN3id70XOEbi+GT2FvojZ6iKGG+GEDzjCbvWrOCSjqg+AGy9y5mrW1clJGG50PsZkr
	OBNv9Giuv209lYQ==
X-Received: from ywbho7.prod.google.com ([2002:a05:690c:6307:b0:793:a5e8:60ff])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:4d88:b0:794:31a4:1972 with SMTP id 00721157ae682-7945a9f1f83mr38315937b3.67.1769449653865;
 Mon, 26 Jan 2026 09:47:33 -0800 (PST)
Date: Mon, 26 Jan 2026 17:47:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126174731.2767372-1-edumazet@google.com>
Subject: [PATCH net-next] net: include <linux/hex.h> from sysctl_net_core.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253560-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9544E8BA54
X-Rspamd-Action: no action

Needed for hex_byte_pack().

x86_64 was already including it, but some arches were not.

Fixes: 37b0ea8fef56 ("net: expand NETDEV_RSS_KEY_LEN to 256 bytes")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/netdev/aXeka0KYBnrkwUcF@sirena.org.uk/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sysctl_net_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 0f761d4b9447..03aea10073f0 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/sched/isolation.h>
+#include <linux/hex.h>
 
 #include <net/ip.h>
 #include <net/sock.h>
-- 
2.52.0.457.g6b5491de43-goog


