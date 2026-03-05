Return-Path: <netdev+bounces-264486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFmYGpy0qWkZCwEAu9opvQ
	(envelope-from <netdev+bounces-264486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:51:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD689215936
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85F03302D5C0
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0541F3C3BE2;
	Thu,  5 Mar 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR+mMdck"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436F334373
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729494; cv=none; b=VjGe9wtmpfvl/js1ownH3MuwfLwkjYwe5N69jm6d+Oe232JLDP2G5JcnRE2lN+IQx6Ux7KgIBIVDMfqodFNehjurCY1Kv1lDqBYUKnQQIHNp6ODi0/i2lFgIgs7q9pYragEw9DhLevvqiK1M4eGzvZdKf6GhOwheX34IogFPkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729494; c=relaxed/simple;
	bh=KrDhnq+ow1rufxWPAwRU7TgQoofZx9cfnzm70Bbt1+8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=oghSvfg+/cO0gQVNIKvVKsomgDi0qiPwtz2dhgYuO8yo3xp9nyx13OvlJ2g3+mdrVJKq4016OwbuKEHj0Y/r8pSfK022Es8gPg3ctxArHn0HIF3bvDHijHBzRkwzmUDgtjPNCYThvt2kDqDg8k0sZz6yBkMrD/nwftXiSFHcq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR+mMdck; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439c6fc2910so1605278f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 08:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772729492; x=1773334292; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7CByE5R15KUprMXFu1T4Ew2gptlb0CGRUb4c83w6Us=;
        b=SR+mMdckCLleJvyP47XlZpp8PcBTyEhuUHYV0NNMr3kG2nK0ugnhYUqPRY3bi4jkcl
         LGH+YQPgSgtAtRGpL9lNnfxNbH9cTvWskCEGGw10kYbbHH5xgBZC2KjzQyCtpxH9932i
         Sm3LF5t00TAiK0S7M+tAPr5RiyN3kmF/U9rRtnmjhsDOvTlRSk6Auh4qArBTpvBzz0sb
         CB5uXOGs3DfknucmNzRFSod7e916DTHosL3bKgdHgnXnNN6Qa7M4XFqEv/fDSMpfy6v+
         PEziygD5xOKzyYU97iOJEjl89O5cSAmzXZUcf1nx2uzd+L3VFGNdwGKtklgL/4QSDam+
         sXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729492; x=1773334292;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7CByE5R15KUprMXFu1T4Ew2gptlb0CGRUb4c83w6Us=;
        b=DOBBdZLoYAZU9er8HmfWF7m/RnCh84P/HJbarI12wXeBpOq+En28+ff00z2L+GG3YP
         2bgF04PRw565vWFfBW11QQK7aUTN0mBoSesct8Ij/yWNqEn5nxIQ4UcgUvMD7Y7bFqa6
         uaM3vJqEo5qew4hP/bz0VbfczuPlsqNvg6u1hez95BpbOuZFXKCNOF5pIKsTzkviEGnq
         ththrq6YhFZxv9VsR7w5k74MuGqLCvO3RGlX3FzMip9W2A8D5BlO31KFE2Gcpz8e3XvE
         GEfMQnAP+O8RnDn9Y6+Rbol4enw+k7StfeSpe/IiKdBQ+YrxtN42+nHhqp0bIispHqHd
         vmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX68KIBlSPmEKKyTxI0VynvPYIh1ReUyzwzZFi4gyrhtaxpnW17kCXGsWWPBO38M5CBkFrAIvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPtz9h1lwguw3+1xgyHiuZA/LK3kgFAwVdXxjQS3KTVdyTnXU
	pfscil4fnBmhae25zpQzG/akI6qN24YDYRFCs7XYiP5ktfLwIav0XwoHLXV2dw==
X-Gm-Gg: ATEYQzzP52TjTyhgJ2LZ/ypaO7o8fMyL76RzIBuCRz1DVi9KdqhvBoOAtsPbuJHIvwJ
	AWrYVSVsH16rh+rjq0b+FXFYhuIimgdIT8pKZJt8PZuKC8ROkdWj5169DfznKcnJYGq0FSkXLCw
	VyfM4xr/v47vQzG4aheb/QzQCvrOc5vXimaJno4iGYUu1Tvfc4eiyQPvwu6SQpJcehJ0H920uWx
	4srBeyG+W6CypUMEvoQwQevo+E4f1cW3kP0QdM4xf70KkLcnVt79/zYHa+lZsEiAk/p+lSY97Pl
	4UJqvpGY8fEEj8UdSxn8TYhfaebZQoWGe4m6Z1C/H565tbh6I4LIovI6l2FJMcbcR8O/dDbX/n6
	GOgrp9Ez/H/bmNwtP5nhXXWMFnZEfg9zYN4dAn3ry5/FfgrLelX3mr74UIiyS0xVNRrezFO0pEt
	Z7KKGhuA/koQifNTe9xnqoRAGf8x4lbtYcZIv496A88+XVZkDmbxcDZUuh2WXwEo6ht6CIi1X6D
	R2zdtjpuBmeZwub99plKpSJ83if29FXLZsJBHbFbHhIFbmJVM22QtbUMLQORVwhVw==
X-Received: by 2002:a5d:588e:0:b0:439:c4bf:d9cb with SMTP id ffacd0b85a97d-439d72595a5mr809734f8f.43.1772729491678;
        Thu, 05 Mar 2026 08:51:31 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:e300:f4ea:baa8:3194:fe01? (p200300ea8f26e300f4eabaa83194fe01.dip0.t-ipconnect.de. [2003:ea:8f26:e300:f4ea:baa8:3194:fe01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm35789558f8f.12.2026.03.05.08.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 08:51:31 -0800 (PST)
Message-ID: <9246ddb9-3f55-467d-b9fa-9239d9391020@gmail.com>
Date: Thu, 5 Mar 2026 17:51:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] Revert "net: phy: improve mdiobus_stats_acct"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AD689215936
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264486-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This reverts commit 1afccc5a201ec7c9023370958bae1312369b64da.

As reported by Marek the change causes a warning on non-PREEMPT_RT
32 bit systems.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/net/phy/mdio_bus.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index cf5ce1ed48c..00d0e4159e9 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -60,17 +60,22 @@ EXPORT_SYMBOL(mdiobus_is_registered_device);
 
 static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
 {
+	preempt_disable();
 	u64_stats_update_begin(&stats->syncp);
 
 	u64_stats_inc(&stats->transfers);
-	if (ret < 0)
+	if (ret < 0) {
 		u64_stats_inc(&stats->errors);
-	else if (op)
+		goto out;
+	}
+
+	if (op)
 		u64_stats_inc(&stats->reads);
 	else
 		u64_stats_inc(&stats->writes);
-
+out:
 	u64_stats_update_end(&stats->syncp);
+	preempt_enable();
 }
 
 /**
-- 
2.53.0


