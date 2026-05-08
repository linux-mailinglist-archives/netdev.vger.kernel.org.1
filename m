Return-Path: <netdev+bounces-285873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPk1EZn5/WlilQAAu9opvQ
	(envelope-from <netdev+bounces-285873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:56:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F294F82DC
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A69FC3083296
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CAA3FAE05;
	Fri,  8 May 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/PgGArx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA53F7AA3
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252042; cv=none; b=p5no7a/9rozbVXymLc1FycKLckkoJeSZtwUy46vULCxaF48Rc1CSxuqKxig/114WaHJ6cbrkoAAVKpw9G0XVUWQEQ6bmdb6nWIyobKNMh2R7Mg1OgjtTChzKxs8JG9x4nBy3gs/zO+MFX0cgoxX25wn5B75S3ghJdnj7rOUllo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252042; c=relaxed/simple;
	bh=Id8y3cDF8b1Tt5vK2dt0u5UkdzJtwzOfVSavA6SQ85A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LPKNC3RP5JusCduXwrlZx9kDvXMJBibAIs62vpK3YASAn/SIRJLCyOvJngb3H54iilkQRtKpwCwX2Ab2aCDS8FZsWXu6kObGpXRgLKtpcvhIA8dXA7ZkROuUa3EjlQrW94648irypi0471I5brCBD4eJyn54Eu5W/6SQwetujDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/PgGArx; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso1771505a34.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252040; x=1778856840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GeLFNXv42TuP6KRLLxjXq2DNl7n0yfqf6KcI9MFRQo=;
        b=W/PgGArx/Gpk0rxhJWwV9Nr+YCeyjqriEyTlggWQNPuyShZNSg8BzBOuFMtB9M4EYY
         90A1wJvCE+1QichTfTf9Q2Yte1RdQ5tGCNqM7j6n79ik9a/hvZRJ9Rr3EaggvIoA7t7T
         T7xsz3oh5xsLVbGBPmdRicqB+d/yZBKD8tYVv2ctZfkcGngV8tJYeUwokRAA57K1Fnbh
         927Ln4xh3ov/d0RNl2Lt2O7UvJ/eGJqMKORwGRgZncq9Ob8rV0ceESyu6ZWZ1ZPzvImI
         6RlqhDfPaWOzq3hq208w0m7Hsm6QhlKyHy8cEKipol34KmUCkyWcKe68HHTjwiQ3yK2Y
         1Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252040; x=1778856840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+GeLFNXv42TuP6KRLLxjXq2DNl7n0yfqf6KcI9MFRQo=;
        b=CypkKzDN5J82FkAJGW1/Frf4cjbxbRizZmS6bD1Yz1EBzVaAHu/49J837g5L1CTvxz
         9JBlynNXtYNmDHTGFX6dPOGWCYligw3LfU/0HgqsR9TKrSbm51cM5hveAb3NKTGs4Nr0
         +DRyf3VLQN9s6g8ehOGMNEh2cCoqvSm6ikJYn/u470upOsRm5Q/q/r00SmbCFB98wZpb
         kG1ec/XO6Oig81t2qRDtGu3RGw26QSP8jegZgFqzvTJXgi8r7rOw2ymD14s3vLZIeH0m
         ArW/sD0DEqUQhPTKteD4hDLiufRtkVwJQg17y1oAUv8RLUoWB6cnq0xnfFdGMHxRqs3U
         OQuw==
X-Gm-Message-State: AOJu0Yyo9EhI1jG9U3WiUGfyX8/9/o2Tgo5uhccm+8qsMklOuonMkGzo
	SVsxqhjMIqf9ClFVNMoIHoZqlsSKGr+Kw/vpRx/25/7mD2PJenI4Rehr4R9sqw==
X-Gm-Gg: AeBDiesbIgdx9buiEr4IOE9FuvGF5C8tsfKxbi4B+snaMgKbPwWVFnHMVJgzE/7lXe7
	3Tcz9pS8dpip2VSijMP5yrGSdwN9Wz31iSFzEV33UyNx3ShY0upFbC2O9Bz5X8LPVlfL2PwlMlB
	v/jpL4GDzuMtYy8/Gjp/QVfotxnmSyn/91eYyMcHUNxMGv1aqW4p1ocfOeU4glRicJN2x2PhZNu
	KR8ougyGoqfpu8MfZtcdKdj0j+IONSzuq+nzDEAzbx5vAPNAXgY9IsrOXy2WZsE7xHCoyIqmnPf
	cche0mzPvbS1sZ0Edr7zJ1nGgbueg2PbnbjskYaPvHIFXpu1RHDfERCoc2t4ymAvGNJQ96qnZRS
	sALYUDMLezthZChqujF3lXumkiS5HKnOOa/Q0u+uef2ENQ5iLRmTCPedVy66LoBYowMsDQ+2wRo
	bfYaTj8fWLfubjCrPMEcOPbIZgckA0kVoojtcCIAUwgf8eh2iedCQP
X-Received: by 2002:a05:6830:a90:b0:7dc:c92d:976d with SMTP id 46e09a7af769-7e1def3f15dmr8500919a34.10.1778252040158;
        Fri, 08 May 2026 07:54:00 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367be21f6sm1274509a34.2.2026.05.08.07.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:53:59 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 08 May 2026 07:53:45 -0700
Subject: [PATCH net-next 2/6] netdevsim: psp: remove unnecessary UDP
 checksum computation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-nsim-psp-crypto-v1-2-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: B7F294F82DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285873-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The PSP spec requires the implementations accept 0 checksum in psp-udp
header. Let's take advantage of that to trim netdevsim's psp code
down. psp_dev_encapsulate() already sets uh->check to 0.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/psp.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 5073bda60883..75740e2a731f 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/ip.h>
 #include <linux/skbuff.h>
-#include <net/ip6_checksum.h>
 #include <net/psp.h>
 #include <net/sock.h>
 
@@ -81,36 +79,6 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 			      skb->len - skb_inner_transport_offset(skb));
 		u64_stats_update_end(&ns->psp.syncp);
 	} else {
-		struct ipv6hdr *ip6h __maybe_unused;
-		struct iphdr *iph;
-		struct udphdr *uh;
-		__wsum csum;
-
-		/* Do not decapsulate. Receive the skb with the udp and psp
-		 * headers still there as if this is a normal udp packet.
-		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
-		 * provide a valid checksum here, so the skb isn't dropped.
-		 */
-		uh = udp_hdr(skb);
-		csum = skb_checksum(skb, skb_transport_offset(skb),
-				    ntohs(uh->len), 0);
-
-		switch (skb->protocol) {
-		case htons(ETH_P_IP):
-			iph = ip_hdr(skb);
-			uh->check = udp_v4_check(ntohs(uh->len), iph->saddr,
-						 iph->daddr, csum);
-			break;
-#if IS_ENABLED(CONFIG_IPV6)
-		case htons(ETH_P_IPV6):
-			ip6h = ipv6_hdr(skb);
-			uh->check = udp_v6_check(ntohs(uh->len), &ip6h->saddr,
-						 &ip6h->daddr, csum);
-			break;
-#endif
-		}
-
-		uh->check	= uh->check ?: CSUM_MANGLED_0;
 		skb->ip_summed	= CHECKSUM_NONE;
 	}
 

-- 
2.52.0


