Return-Path: <netdev+bounces-291492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEL+Cc/9FGqESAcAu9opvQ
	(envelope-from <netdev+bounces-291492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:56:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 615915CF975
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29D433021E42
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 01:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F612C11E1;
	Tue, 26 May 2026 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzCiVpPH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2E2BE7DC
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760315; cv=none; b=lAEnvT9cw4vqiAseH26LY3/qKEA4rMBonmpFsDG4PMna//gQTHoU2GKzAOMUcNW0uX8O/35vOsn3Eb5MZ952+wMY6tdOX3ekMmIOmopf2vRGhBClmSro/DYhS1HH4dkdRV3oUvyx9N8BfdgIERTYSVwFBaxiLghfMgSetjsciUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760315; c=relaxed/simple;
	bh=t/xHBOm+odfHXHEERNhK3SdLXtOx3pVYbi0PtKr/3Ok=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bwcb1Rn/OvUTWy4jLgJKh2yKr9TXZTQxMG+Ot+z8+AI2/AjvKTRH3skN5DQrYqcZqin3rev08Rs1LlZDLIILfbXgAOpAwIOzuIbfAg060lzPGJkfDxq/sDBZwr6jdaqHS+k9okXZ8udmizIeoFF7CBGtrbTVPByRWfAf1ld2KAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BzCiVpPH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba6fe41283so107714065ad.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779760314; x=1780365114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/LroaxzbJz+0NoyWqpnaYzYRO9c6iNgBebt6kT9XWV4=;
        b=BzCiVpPHgz8oGbd/RmxBA5AFbKiKX3XXb62umspbZ0MXSvBM4MRtQvXQ5fnQZ4piFq
         QWsA1m6wz9yFFQbPPWP1fKX8+ycbsSvUqitar1iowyWWI5358bQOTz294O/5LyjUnJCJ
         L5ZE135cBdmgsTPlNyFHy9inE5b6uHvOwpchZn/tBr7+FST+TUl6YezvWvazvAArvouz
         tpCbTm2xYRPDX7hrF7DizApBUlWWOhFOH9dp8PeEsG2t2dvFeSlSIWnuKdMDKfApmkax
         dfGzVvW2Yl8TbgtLiZVtJucfJIhnNdTxiWt9o8Iy0LIVdcFBOCNtmyP1WjsMCrVsWldn
         Yhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779760314; x=1780365114;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LroaxzbJz+0NoyWqpnaYzYRO9c6iNgBebt6kT9XWV4=;
        b=pMCcN6qv60qrZ29Q+xsSWBBgoSQhX765rbtKcXvvuCA0OKr2jtz0qYcksiarg1CYHf
         uh/7hjpwdbeubZir3lE9pDm5FCGzHAOPQqe36WIPNpOY/NsNZ6Shde294TSTqOGROvFK
         FHEg7Sp9DUkYDCjuFaOneQPnZf3QDSGgKH3we8s6qopl7zzWobqlEqTOInL1oOgr5rGZ
         M0BtXnOkJMX6HOighN76JopeELBqQhpgSjPT40vpqIqCerb7AEo0t0GzBH1Hj8Sg6Qea
         ZwI6Eizl6ZSbQrApyBThzZoYdHyJtnW/ogfyoJzxhG9b9y3dbHShaF/bVHTakOEFmXy0
         sWKA==
X-Forwarded-Encrypted: i=1; AFNElJ+kXi+LilsRaZmQviQ1zk/HP4pT81MK990UH8ar1iZrqW6H2da8mwvGhWMbSpZji6KsOQeE0sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX03ZPvpfPKX9oD8+UuOauCRU0Zh0Qmq7VFZbyXBporOJEb56y
	gt4Jazk5nplYv6+fROH1K3W2ihT3s8Lp59QOKhZr0rpSEIX2Q2pK8mCSWt9jq0FVngKP6l+IQOf
	rBDGUAQ==
X-Received: from plbo8.prod.google.com ([2002:a17:903:c48:b0:2bd:9a1:9a05])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1208:b0:2b0:b290:f2f4
 with SMTP id d9443c01a7336-2beb06730ffmr178660365ad.32.1779760313449; Mon, 25
 May 2026 18:51:53 -0700 (PDT)
Date: Tue, 26 May 2026 01:51:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526015152.2409183-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 0/5] geneve: Allow binding UDP socket to a
 specific address.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291492-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 615915CF975
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

By default, a GENEVE device bind()s its underlying UDP socket(s) to
the IPv4 or IPv6 wildcard address because there is no way to specify
a specific local IP address to bind() to.

This prevents deploying multiple GENEVE devices on a multi-homed host
where each device should be isolated and bound to a different local IP
address on the same UDP port.

This series introduces two options to specify local IPv4 or IPv6
addresses for a GENEVE device.

The corresponding iproute2 patch is here:
https://lore.kernel.org/netdev/20260523061102.2762452-1-kuniyu@google.com/


Changes:
  v3:
    * Patch 5 : Use NLA_POLICY_EXACT_LEN() for IFLA_GENEVE_LOCAL6.
                Mention source address in error messages in geneve_configure().

  v2: https://lore.kernel.org/netdev/20260525001745.1251640-1-kuniyu@google.com/
    * Patch 1 : Move addr_type to if-block for CONFIG_IPV6=n
    * Patch 4 : Don't set cfg->dualstack for IFLA_GENEVE_REMOTE6?
    * Patch 5 : Validate saddr in geneve_xmit_skb() and geneve6_xmit_skb().

  v1: https://lore.kernel.org/netdev/20260523061654.2767060-1-kuniyu@google.com/


Kuniyuki Iwashima (5):
  geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
  geneve: Pass struct geneve_dev to geneve_create_sock().
  geneve: Pass struct geneve_dev to geneve_find_sock().
  geneve: Add dualstack flag to struct geneve_config.
  geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.

 drivers/net/geneve.c         | 242 ++++++++++++++++++++++++++++-------
 include/uapi/linux/if_link.h |   2 +
 2 files changed, 198 insertions(+), 46 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog


