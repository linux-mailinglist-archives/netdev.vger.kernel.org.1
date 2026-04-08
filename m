Return-Path: <netdev+bounces-276597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GZpMPFz1mkWFggAu9opvQ
	(envelope-from <netdev+bounces-276597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:27:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDB13BE2E0
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8177F3096127
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D062B3D6CC5;
	Wed,  8 Apr 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="cDdXN9+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f100.google.com (mail-ed1-f100.google.com [209.85.208.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF93CE4AD
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661841; cv=none; b=sK5rzZMq/V/2Lbu7CUr4kEotwZcwjip/TXLT+20TmNT9Ch2cdP9FEz7+5kZh/5HqbScAAMwMwypKA0uTg2lzebZ83+ztJbff0+PQSG4QwaumXMpuwNwagTMHk1zt3+wZnFGDZeR3KvcNlJy65yP+Unv8Qkxx3W/rI1E3WOaJXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661841; c=relaxed/simple;
	bh=30OvjWsNCA4kEn6IQCw1xbygL0FmnukdjrMNb2ZwLpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crCqlT6KIIXC6IoyQHk3LZzo0HYFu3mJBdhISrwWw1Njoh0nEckiSw4bVIurSeuFv2n4OOzyGWSBeuUSW39/6C0FB8159EkyjiZqIEYmoVFHFedEQL3kVcQwx3AKUJJSf6zwZ7Cs3/2cciw1om4krBnEdRApTmfs9H+tA5FY4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=cDdXN9+9; arc=none smtp.client-ip=209.85.208.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f100.google.com with SMTP id 4fb4d7f45d1cf-66bd4f7b2d3so7627913a12.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1775661837; x=1776266637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xU+L+O7h8OUEui4yRIoAOnKuRGwhBznyLcr7vPwWTQ=;
        b=cDdXN9+96xsKzT9GG8Lp+B55Czq3otwEnK3UNNEGVYxfA7Qh7UDWgNX34T4YGHkuCW
         RYPJGby38yoFFQWmPPnVihXPJ4pGs9gKFUvwhpkYrXfDLhpI5CiGdjcFYMjTVutNXt7i
         TBMZJ1v+Nh748Y700Su+5C15cMRK5tiZEWANt5+ZJZg36i1e46Cn+Id6C0FUQzlK0fMJ
         ZnhDBQUKefpOZfYs+enh5mZnEO1BA2Mthx7Jw3irknjea3E9hbkZfF1OwguDcYyzKA7V
         sCzdTuZR38qxvZmtIxcAE7t/MZLWbI9mmBjr9YQ6rPoJc1OuSGWTJfHdlVVVppEq6I+6
         WMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661837; x=1776266637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xU+L+O7h8OUEui4yRIoAOnKuRGwhBznyLcr7vPwWTQ=;
        b=ACbqaSkRD2j1aHmdZYcjMJUvZm1L+bU4BSHQ4AGASdn0L3xgz0cSux8JSqbnesRAtR
         yX3iLPNzy8KUsJWgmpgPJcVHJD5c9DjJAEZ6e+SXkPa6r0yC0ef+7NcuzhOovpfXXxcE
         pw/2qY5QQeZkH0EWMhdH6Z/gM1ElFwOXQwuKYmF7qrWqtSbU95oImwfEW2OcJNn6xYo4
         hJU+3oTEaqS23xKEZmO89mk9UGuBVjsczJJa583efqC/hndIjKqH8cwwsMLFewzcb+z3
         COgVeaYbRUbG191UqwwwGB8b/Et37zamRuKuidz3wYe+982aI0bj/JdA5twsMx7mFqyg
         FrHQ==
X-Gm-Message-State: AOJu0YyUgvOmzDahwRRiZ9rUkQlvQBex2U08nIWSnp9KDJgMPIJOKLIK
	TfclLhuhoqWVYkcafhT2r+iRO+127c0w7bwQ2qXJJbBFMnO6qZBA5jdyHnYNMPpSWi6u1s5/Wa+
	pgPdNVkl0Dm9jvHUTZNe/5o6VjHuCcBG1xA8W
X-Gm-Gg: AeBDiev1ArLmez8J6u4MQONxR3YDZGQTsTSqIPuJz7g523fH7WQ87hKkj7ma8tok0iw
	fyiQ9ZmNXqrXJanmk+qq+rL9pMkHw76IfcnnGnNkuOaCQ0fl127hJYsx67Rf9mrPN+3YPaYOicD
	3Z34wX3Ec2z/kiLPRPhRmfuUAM38koGOf4uROmaOEWMIf37B1/S2jWXLWNgWY7xoqz3Wuv0fvsM
	CVzaPKQLCWBPDPcGQ5VbTy4b6HGMCt/nBRP/05e+qJutqdav7nKoRoJM4D57PqOnKf7TYNNyl9t
	XZsxnc31gyayLT6H/PesjGTH5CcYhyWrsNbbZuQ1UY/8kv3+KN6Yr/YJ37QGqF88eTZsgJ/YItb
	8nWygQuQdOThYykdBYCGU+EC+cmcHHcokJBC+OHnIfwaWAXUezJc8
X-Received: by 2002:a05:6402:50ce:b0:66c:17d5:c18f with SMTP id 4fb4d7f45d1cf-66e3f86ed59mr10366361a12.21.1775661836948;
        Wed, 08 Apr 2026 08:23:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 4fb4d7f45d1cf-66e02d31c16sm905970a12.2.2026.04.08.08.23.56;
        Wed, 08 Apr 2026 08:23:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id C246327055;
	Wed,  8 Apr 2026 17:23:56 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v3 4/5] bonding: 3ad: fix stuck negotiation on recovery
Date: Wed,  8 Apr 2026 17:23:52 +0200
Message-Id: <20260408152353.276204-5-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260408152353.276204-1-louis.scalbert@6wind.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276597-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: 2BDB13BE2E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The previous commit introduced a side effect caused by clearing the
SELECTED flag on disabled ports. After all ports in an aggregator go
down, if only a subset of ports comes back up, those ports can no
longer renegotiate LACP unless all aggregator ports come back up.

1. All aggregator ports go down
  - The SELECTED flag is cleared on all of them.
2. One port comes back up
  - Its SELECTED flag is set again.
  - It enters the WAITING state and gets its READY_N flag.
  - The remaining ports stay UNSELECTED. Because of that, they cannot
  enter the WAITING state and therefore never get READY_N.
  - __agg_ports_are_ready() returns 0 because it finds a port without
  READY_N.
  - As a result, __set_agg_ports_ready() keeps the READY flag cleared on
  all ports.
  - The port that came back up is therefore not marked READY and cannot
  transition to ATTACHED.
  - LACP negotiation becomes stuck, and the port cannot be used.
3. All aggregator ports come back up
  - They all regain SELECTED and READY_N.
  - __agg_ports_are_ready() now returns 1.
  - __set_agg_ports_ready() sets READY on all ports.
  - They can then transition to ATTACHED.
  - Negotiation resumes and the aggregator becomes operational again.

Consider only ports currently in the WAITING mux state for READY_N in
order to avoid __agg_ports_are_ready() to return 0 because of a disabled
port. That matches 802.3ad, which states: "The Selection Logic asserts
Ready TRUE when the values of Ready_N for all ports that are waiting to
attach to a given Aggregator are TRUE.".

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 3a94fbcbf721..3f56d892b101 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -700,7 +700,8 @@ static void __update_ntt(struct lacpdu *lacpdu, struct port *port)
 }
 
 /**
- * __agg_ports_are_ready - check if all ports in an aggregator are ready
+ * __agg_ports_are_ready - check if all ports in an aggregator that are in
+ * the WAITING state are ready
  * @aggregator: the aggregator we're looking at
  *
  */
@@ -716,6 +717,8 @@ static int __agg_ports_are_ready(struct aggregator *aggregator)
 		for (port = aggregator->lag_ports;
 		     port;
 		     port = port->next_port_in_aggregator) {
+			if (port->sm_mux_state != AD_MUX_WAITING)
+				continue;
 			if (!(port->sm_vars & AD_PORT_READY_N)) {
 				retval = 0;
 				break;
-- 
2.39.2


