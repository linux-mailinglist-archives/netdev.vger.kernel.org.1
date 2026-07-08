Return-Path: <netdev+bounces-305778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U3NyHgQ3TmqZJAIAu9opvQ
	(envelope-from <netdev+bounces-305778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:39:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C7725F1C
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:39:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jLUVbib3;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305778-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305778-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A1713003BF4
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B651F432BDA;
	Wed,  8 Jul 2026 11:30:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39A432BC2
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 11:30:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783510232; cv=none; b=g78C+mg+oOpTAWpm/bMDnz/qVrCuIW1ue7fESdDLiAzA/8NQPRLLsqCp/JzSbcXD/QnQCxLSSSfEwW+zG67o/8mTpr5x8ozn2FfXcpurixROupNkhASy67pecdRlAJ1/CCIR7Ncn16SYrcfww64mfbjjq1e9orEsoXE6/d7MLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783510232; c=relaxed/simple;
	bh=Vrq9mBwQ+OgkDpO4vYLKiM2lqQLZT2sV8bYkbGoVBNs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tXZZ4FIaCN0FRqS6if1HjYtvm0zoe3vOn0CsUP7T+tyUSx4nTK7OOJ3DKB9X7YfFBdRzTrbqw4FryDgbPj9cvepig+JSLgavm8km8cO4SJMJerh97TaJm3nxGkgjoEbAiVB4jL2R53xDAJwNU8j61bWZLtNNFZmc1KplmtFI58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLUVbib3; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso7893415ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783510231; x=1784115031; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AsxOcajZ7gYxW17W0Pj55YOWQAyg0/24La7iNV21scc=;
        b=jLUVbib35bZfVqpGXmgkJqK6Pyvf1nswpJEJ+KnrhyWtoiHIE/TxH9os6KX3cYB7Kv
         nEtm5GRB9LmJ0klARM9/wiGzXM5UeNWj5OtpHtiT0qoZFeZbz73YRuyse8QxvW3GdjlV
         mU+9JbpYk0iAP+geYpmsapYyGFMMBCICQUzstLBYL/8rWGSZ1QF9/63BBrNYcs9s9cQe
         4HLvugRC/YUE5LvFOY2lebFDRL4EhZfkkb6iHQ044ep/zFPlQ8oW5hOI/JFBjgl4wn1S
         QkL/TQIRouZybSm6tu0PpVzj3E92+nTA2fgU8dggMRqFHzzNlDPjlRHHkF8KHOEftGtj
         gGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783510231; x=1784115031;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsxOcajZ7gYxW17W0Pj55YOWQAyg0/24La7iNV21scc=;
        b=LczYebvL6aJk6uwZn44j4Rv8PZucPknYGhc8p3saf/oz71ynm8BwV4bVIYC2ardbW1
         HLmiOYQE9BT2OhTYQDxLGpsASo4Zp6LxpMsir80XoOBBi2lbElJKomitx+CahXdu+BK0
         EvLrCJvq3tA7kNycQsGAQNcLrOMakeGkMHOFn3Pj+vVt/FnCALAVKhbflPut4rDh2C9e
         OfwIb5aONfpaKp8A50U/OJCXLhAY0RLXyVtJYc/p1WhFXR4gKUTona7NxkwC8o4LHNKW
         4b9Z5EwtUw2+DVKETSs8gH9AtdqH0e2hhGZvloYMgc2+ou7/h4Vb+yJoNQfP63EoSgql
         md9g==
X-Gm-Message-State: AOJu0YxAfeEIkrccf2HsLRe3xhwIvH2capHuqk4Uhsfarx4VNf9VniAs
	WiavVI0sw3a3lRu/5wwR12lRDq/BakXgsOIDsPU7p2nrtwBrw0R+5NWAxHoxnLmaq4w=
X-Gm-Gg: AfdE7cnSkNRnSswKms5dv7moUK0nb1fl02Up+RSbhb6t/MnvxHYvQMUAbbxpWxA7qw6
	5TIQDGPPAZw3Vuw08XZ+0Rgm+zf1QzY4H6DePkNLBWBK61fsjdU1T9BuOvMuKZ9Fb9KMqnvzAsh
	uRrx2iDrNwTejW1yweC9qqgltaBgFh8ymeEXnD28ZmJ3nkNIGF8zbVsgu5eMj8Oe/ZoXUxEZWVN
	dVJo4QZGJQeFyTkSAWX2k3uUkr+vUpZusiolquSRHch6hB6/9wHSkpQcybuBbNHossuPDF45Ril
	YTk5hf+DA50W8/3r49y/+Gtf4aHE0yuMXxDoIDMoEZhE2mwylV41YiXfD+rFgaoqSY5kEQSHDix
	A43zNmnb+71IdKZGbCZrO1GqlqIazc7woPMrhAV7TldBaeHp5umg/9hnpJdUR6hhcvHvRPOlSFO
	+rjFt/yg==
X-Received: by 2002:a17:903:1aae:b0:2ca:ecfa:1308 with SMTP id d9443c01a7336-2ccea396a45mr22556175ad.20.1783510230507;
        Wed, 08 Jul 2026 04:30:30 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb877sm26691105ad.14.2026.07.08.04.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:30:30 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: airoha: Fix potential use-after-free in airoha_ppe_deinit()
Date: Wed, 8 Jul 2026 19:16:16 +0800
Message-ID: <178351022574.97989.6880403520276841703@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-305778-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A3C7725F1C

airoha_ppe_deinit() replaces the NPU pointer with NULL via
rcu_replace_pointer() but does not wait for existing RCU readers
to exit before calling ppe_deinit() and airoha_npu_put(). This can
cause a use-after-free if a reader in an RCU read-side critical
section still holds a reference to the NPU when it is freed.

The init path (airoha_ppe_init) already calls synchronize_rcu()
after rcu_assign_pointer(), but the deinit path introduced in
commit 6abcf751bc08 ("net: airoha: Fix schedule while atomic in
airoha_ppe_deinit()") omitted the matching barrier when switching
from rcu_read_lock()/rcu_dereference() to rcu_replace_pointer().

Add synchronize_rcu() before ppe_deinit() to ensure all existing
RCU readers have completed before the NPU resources are released.

Fixes: 6abcf751bc084804a9e5b3051442e8a2ce67f48a ("net: airoha: Fix schedule while atomic in airoha_ppe_deinit()")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index e7c78293002a..f6396925722d 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1659,6 +1659,7 @@ void airoha_ppe_deinit(struct airoha_eth *eth)
 	npu = rcu_replace_pointer(eth->npu, NULL,
 				  lockdep_is_held(&flow_offload_mutex));
 	if (npu) {
+		synchronize_rcu();
 		npu->ops.ppe_deinit(npu);
 		airoha_npu_put(npu);
 	}
-- 
2.51.0



