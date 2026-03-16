Return-Path: <netdev+bounces-268160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCPDHjoDuGlpYAEAu9opvQ
	(envelope-from <netdev+bounces-268160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:18:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD0529A311
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 346A5300A30D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E78397695;
	Mon, 16 Mar 2026 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="bObVr/7V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF2396D0D
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667126; cv=none; b=laR28B9qKqgb2tafYiy1XXpN2jQy3377g0MHheoRMTNscLm8Maib+nSOz45S+/6UqJ19AHUTpEHc9sNxtAi599f/8D6Y8ZsJk0CuiYLz5s3vmdYWcZ0Aln+k55ZviMiSwbx/dC3R/b2FBhKHpT/NmqdI4ghh7EZnUm1NlYzbIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667126; c=relaxed/simple;
	bh=+tf1JPJeyN8SbZcLXy1ykiD0L7IeYd0uKycWAyMLIMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aYS7Atljt08RFIPjVJqRuShJEY48N6lPgChRf8KDHeD+55vL1w686TmRmK0cOEAUq4giaUSjR8vilO5ludZwxdujebatVIYoY3d1uCUYCut43ZPVkUGAEj+7DvAmgMZZJ0vWiry0drCsUpFhV5PqLZKDY6lMfSCKb/7sBDhKM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=bObVr/7V; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-b96f02b4329so815745566b.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773667123; x=1774271923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QRRKI3FlfPafjJhyC2SDAMS6ECIzUlLBuSZnvUNAEU=;
        b=bObVr/7V7yp7lLAbUGS80yB0j8Vz8SUfFvG1J4eu0kvkCpNlCkhzDQ5zY0faCrR1Bz
         tD/SVOKy3a3HgduEx8n9xNyBKfjp5iDHzmehi1bLxs0jRvaR48BtCz4RN4AM7vrN/W1b
         H3hbB4lD0+Sdu+BiGaV5AEzehEja9/c+rNBQrEBqAZO3pErWNlnbB64gXFshYcTNYaBM
         e+H6xFXW6xWwwEQdxUmjLo7j0rM5rwUol7d97nYXD6KeatVaFnm3nniDGllUJMfZgTpR
         /ZQ2BRe00RpsV7427MlIRCUqbcfJlWTkedE4JaurXPj7xi7MW1xSk4//L3Nf7gfqJPnw
         jXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667123; x=1774271923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QRRKI3FlfPafjJhyC2SDAMS6ECIzUlLBuSZnvUNAEU=;
        b=bGPwMImCIh1BaQabuWW6DBMf/QqmUiq8BAnsXi32qJisav/InFCXcq6jYBgg71aLx9
         ttwX/7skxWgVIsODPP0zoizkR8R0cY6pUrMJIb9TBhTtWT/OdhOrejIODboYLurtQW56
         ViFnLhlsBMXYRcUsm2coB9xtucPA1w4UNK4bPUEzPK6L7UJ1mJoXXGJB9DS2WK60CTKd
         BUDdvXrJyBRD4B1rV0/SEsaA0qbTy2gL9BMGFiRVmsIbUjEczOsXetGwjKjSXOA++9iG
         7qXDwe7R6bfOjeGK5EkmxuE/Z0ucDFjnwYAOw258DhLOZWbwNSl2+d2cdgZiCYi1NyKv
         DDiA==
X-Gm-Message-State: AOJu0Yy9STkd97PjIz0JF2BosEblWvlJlbN0aGH3voTEVG5tX9kl0itc
	BRNgTjFooeQR57ZT4dxal5CIlsACSKwxU/2/MByQdYz/d3shTUSHk/5CeM9t6CmSTXgmKKC5x//
	DmnyxoM5ZZB6n7zuowDQ5M6R+iU3YarecxNdz
X-Gm-Gg: ATEYQzwgh0m3RamhR5T2IkN9fRfn2FWC66ZyuyqdtHJNYUAWE/eJzCE5HVkFGO2cG4j
	l6Z8fHDf7o+muzFCQtYkG5mNoUpm1dUxXQOSkkAQebu18LPitmz4cami+L2M435C2KPUBGVPev4
	EAFFxu08qDPeKpjozyF4+MaMDddYN1/UC+dqfY9teA9IKQDrqgcV1wEEVuJ6MM+HELjsf6DBePX
	bI7Gkq9WNCrici9jvoI6ck4pP5xz8Bxch781fIdYm2U9weq0fhKWFue5+yikOfhe1K7Ldw12csD
	W5QIgWV78jlLt6RqXWYracSsvhumbFvUAqgtnC0bjPttPCWO10bJ2NyLVUoLRfGf386ncCo9bUT
	eVJmBm24r+AAOdy3aZckpJpYthaO7ApDxxainFR6oXYdyAAtIwIeI
X-Received: by 2002:a17:906:ef0a:b0:b8e:64e:1ed with SMTP id a640c23a62f3a-b9765427c2dmr828020666b.50.1773667123142;
        Mon, 16 Mar 2026 06:18:43 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b97b79b269esm27917966b.13.2026.03.16.06.18.43;
        Mon, 16 Mar 2026 06:18:43 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 0389319C59;
	Mon, 16 Mar 2026 14:18:43 +0100 (CET)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: jandrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net 0/2] bonding: 3ad: fix carrier state with no valid slaves
Date: Mon, 16 Mar 2026 14:18:36 +0100
Message-Id: <20260316131838.3257889-1-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268160-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[6wind.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1DD0529A311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi everyone,

This series addresses a blackholing issue and a subsequent link-flapping
issue in the 802.3ad bonding driver when dealing with inactive slaves
and the `min_links` parameter.

Currently, when an 802.3ad bond has no slaves in the collecting
/ distributing state, the bonding master still reports its carrier as up.
This causes upper-layer protocols to consider the interface operational,
resulting in silently dropped traffic. 

Patch 1 fixes the core issue by ensuring the carrier is only asserted when
at least `min_links` slaves are genuinely in a valid state (collecting/
distributing, or collecting only if coupled_control is disabled).

Patch 2 fixes a side effect of the first patch. Tightening the carrier 
logic exposes a state persistence bug: when a physical link goes down, 
the LACP collecting/distributing flags remain set. When the link returns, 
the interface briefly hallucinates that it is ready, bounces the carrier 
up, and then drops it again once LACP renegotiation starts. Unsetting the 
SELECTED flag when the link goes down forces the state machine through 
DETACHED, clearing the stale flags and preventing the flap.

Louis Scalbert (2):
  bonding: 3ad: fix carrier when no valid slaves
  bonding: 3ad: fix mux port state on oper down

 drivers/net/bonding/bond_3ad.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

-- 
2.39.2


