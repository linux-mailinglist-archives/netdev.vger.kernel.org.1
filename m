Return-Path: <netdev+bounces-305312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CWAmGmKyTGpDoQEAu9opvQ
	(envelope-from <netdev+bounces-305312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:01:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A521718D05
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:01:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=F7RzPu18;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305312-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305312-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079753244325
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 07:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FA0390C95;
	Tue,  7 Jul 2026 07:38:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ECE13D53C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 07:38:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409919; cv=none; b=oVS654Bcm76/HX2uwVjB3X3V1M8J76ZWVW1ZOVPqAwWGlR+igEvm3JF0vmSzoCEbJaBNDU1JCdnVohp6Mtr6b/zNQcBrTQ2A5NQn8Zq81GEvwIcFA3yk+Ukn5Ilfks3vUBSXHdlJsEk2eU0aIDaCJeqHn0s26bQDpRKicsFhUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409919; c=relaxed/simple;
	bh=E01ZdDG+MmNeWLXiesCj4HkZnK0qVKySrCiWrXm370o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bw5tMu2ZofH9cm0yIJiSPfvu+oXQ5I/SZ/q/RejX1+PRJecPqPb/d/o6EQOb8WzO/vmojb86SO79AZgENQsmURR7Wepo2+iMu5S5FNJvHldaagPWKZe0vEPYNJt31QvEoMnghZ7N4irdkt2STOT1WuPpdEG12fweCsAqgCo7ZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7RzPu18; arc=none smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so5814439a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 00:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783409916; x=1784014716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qr1IGlrekLARy25R9WI1UDHgK1tJnna2f9/3DXKhVd8=;
        b=F7RzPu18hdIIDqnZX4C97Oy3O82W9WZZ5q15yj4RjRjRy1aTk0cFP1WpOy09HBub9X
         tw7MrBe3KCDfDSVCKSm53vo1RZqUHCy2U0FUwbs8NYuR5jm4AWWPdFhv1gfT9dk2BnIT
         1OQV7zgYb+1dRQbaljjhBMCkEmbq/6VlOtKlKRK/AcYoiLb9vTtIRsSXBJS7ji7qU4ed
         89mR+yReZGHLU0odLdzmk0cj9AoSe2AykGl9dxgrdLYSfgfHqVpsmPRklOhJmcTFZLVx
         +jKZOxF9GCnZCv24AW6p00MV1bLHqI3QCA2ft5E185WwPlnY9YORwp+4HTeuHlLLF8gd
         Epaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783409916; x=1784014716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr1IGlrekLARy25R9WI1UDHgK1tJnna2f9/3DXKhVd8=;
        b=spc8h0F2kuFcbaIMXa4vNmDLPMsgLwHBLGSTd9BwrLxnRh9OnHqILt2lpz09ePZYdK
         eDmEJje+3/Dpvm5eL4cT9pg5BF8PkgjURf/eIsB6RyjbK9xqub5Mbu57PA23k79TGB4+
         fCYHq5okdYZ1NQahIjGnb8lDBTBdCEXopkAnNonDqsy7LVGi59h7vJCZ9FAvGa+47FD5
         EsvAGOd8nNddVD3n/YWodm20EwD8M8i0ShE0krD8/U87qkRqc/85pIFt+taKxwCuMnsD
         zQOA5xOEBTFjmTrdODd1edoD/T6UOXf/5zHpcIfGPxI1J/MHQ6g611ftq2+n9VCJQWid
         g8aA==
X-Gm-Message-State: AOJu0Yy7v8YUpaotKNVMxIl6DFhPiMvNYdf+9JFgNHa/OH1BcKuPmuhh
	Ulwdl3s0knIAms9bTIJh6i9cMbUI3xhUzF3YTdwtSQ9BOzKvbfpLSJEi
X-Gm-Gg: AfdE7clcBC2JpBwzJo6n9pA1M/DxbvTllTLYSr7uESQPjHt483K6RFIUKdDlTJoOq3s
	y3/OQnrYWK0IWILxfAtor34JgZ61n9D4Oy+QQemES9huPT2tbT1uhtrSqL/5JDz1VCZV52/FI8c
	9qf5j9akzDswBLckBuxQQoMJrXt/bSg8vwJxpYuL1D+WTJvIiFTu75uW17l2lF6/UZX+WYnGE/7
	/epz/PQbMJZtHhnba1qZnXBLa7MU/TOyLnQ1/fbHKZB/JOgml+kzLIlPn0g/3ic+WMj96/4LjsH
	6A24q0C2IBhj9HZHxZ5UzbZmvKrfPba0C39InX7pIofAXGyS936wwk2rXXKFDgvRMlFS5HQZHcP
	ZT+270+8U1rzFgtpfd6InoOneIii6vR4alnrdWv0oWSQD6uI24irhHfXdxt5xTvxpD3OOEntP0F
	Y5yyJaMLpGnWi2wdtkJj36dIcudSp+oM7dtKDdz5GWuYRMoWfkPeyyQKvUob4HYMCViT5CMlUh4
	a8rIfMjvzttMjXIk9JSZPvDYIkN23bx3wVVovY4rjU0
X-Received: by 2002:a05:6402:120b:b0:699:f995:13a with SMTP id 4fb4d7f45d1cf-69a85c32c1dmr1602091a12.32.1783409916010;
        Tue, 07 Jul 2026 00:38:36 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d7a375sm5123969a12.15.2026.07.07.00.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:38:35 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Edward Parker <edward@topnotchit.com>
Cc: netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	coreteam@netfilter.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [RFC PATCH net v1] Revert "net: dsa: mt7530: untag VLAN-aware bridge PVID"
Date: Tue,  7 Jul 2026 09:38:26 +0200
Message-ID: <20260707073826.919541-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[arinc9.com,makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,topnotchit.com];
	FORGED_SENDER(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:edward@topnotchit.com,m:netdev@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:coreteam@netfilter.org,m:ericwouds@gmail.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,netfilter.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A521718D05

This reverts commit 4cb3cd670b2a29e52dd3cfd6463e44121674c9b8.

In the case of a userport of a switchdev attached to a vlan-aware bridge,
with untagged packets incoming, tagged at ingress of the bridge:

For all switchdev userports that support SWITCHDEV_OBJ_ID_PORT_VLAN,
which includes dsa-userports, the behaviour is that the tag is visible
in the ingress-hook. The commit mentioned above changes that, making
mt7530 deviate from this. Only on mt7530 the tag is not present in the
ingress-hook.

This, for one, is a problem for the software (forwarding) fastpath.
The flowtuple for this flow is created, with the tag included and marked
with the corresponding in_vlan_ingress bit.

Inside the ingress hook of the fastpath the incoming packet is tried to
match with the hash of this tuple, but is does not match any more.
The tag is missing. The packet does not follow the software-fastpath
in this direction.

Fixes: 4cb3cd670b2a ("net: dsa: mt7530: untag VLAN-aware bridge PVID")
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/dsa/mt7530.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 3c2a3029b10cf..752ba92b08517 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2447,7 +2447,6 @@ mt7530_setup(struct dsa_switch *ds)
 	}
 
 	ds->assisted_learning_on_cpu_port = true;
-	ds->untag_vlan_aware_bridge_pvid = true;
 	ds->mtu_enforcement_ingress = true;
 	ds->ageing_time_min = 2 * 1000;
 	ds->ageing_time_max = (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1) * 1000;
@@ -2639,7 +2638,6 @@ mt7531_setup_common(struct dsa_switch *ds)
 	int ret, i;
 
 	ds->assisted_learning_on_cpu_port = true;
-	ds->untag_vlan_aware_bridge_pvid = true;
 	ds->mtu_enforcement_ingress = true;
 	ds->ageing_time_min = 2 * 1000;
 	ds->ageing_time_max = (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1) * 1000;
-- 
2.53.0


