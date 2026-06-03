Return-Path: <netdev+bounces-294923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KLtGL2SaIGq05gAAu9opvQ
	(envelope-from <netdev+bounces-294923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 23:19:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3D63B5CA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 23:19:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kUfQVHC0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294923-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294923-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4DA2302EEB4
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 21:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332634963B7;
	Wed,  3 Jun 2026 21:17:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E849552E
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 21:17:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521475; cv=none; b=fGd5/08mD74gRgRAMc2NEx2M5nwTelI9Qfo460iOm7bSO6riT32MQrI5vgG4/NTMrwcU7RLuPpNgY67NbmY0nbQmaK3n3+BzYN/kWUyzEX+juJbjdd1Hw2f+oOXcJXNe0KxUCtVgurOsWslnZg6FZBjKjIs7xpSrDrTbIDBmX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521475; c=relaxed/simple;
	bh=kSnVs3GU1f1orJvqpc5R32SF8xmTYRrRDsl/Zm8fdAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ox+SskyLYnWhiJepkyFRN5z3JfH+9/ZkQ4KokVc/cGDyBciiaBXxUGyRn0PBpWjnOlmSLFeBUVulbgTucx+3x0FBRhsU8eas39xjrONAzPP8wGAMdd6IQNPKbag2qSvPedaErsvcHL13Ua9k/OPFB8bplBwm+NMy8mt+I+hDmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUfQVHC0; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso5207109a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780521472; x=1781126272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7NhpR306DthBWL5Ac00AOL5THAOVS6A2OjkkWt587s=;
        b=kUfQVHC0CJ5zpb24VruZC1oA9JnJEhJnC273scNhGNlNz77QPoYCBeiEu4DHJVjV9A
         7I5ShPU42Vms7iySyroTDJAnzQ+xFhHWilCQufjvFugRvKE0a+VRRuLuR9vHH/BiwdEs
         Q36ROtyUxTEheIohk2NeJjNGotp+ZbngpD0jPF4hWIWnSMeB60K/zWgpJ9bH5uZuQbzE
         820dZjUStkRGQydMQ9TSTJNNlICE2aqk06Wdz4rwvTgn61bxt9G98XAt2gYUpZ9ovtf+
         PPnHcNwmxabiHSa0yJ+rWdSClZN/MDCe8KO6U0ygTlN0aruwGFYpMmFPRwxCnzSSlmJ2
         DsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780521472; x=1781126272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7NhpR306DthBWL5Ac00AOL5THAOVS6A2OjkkWt587s=;
        b=Ekwyn5lY9zCy3usN8Tp66WtZ6YP+lxPQkjcLvHgXz6o7h/EP/apX6ekoADXuZOiHpq
         SXSsQuxRynQ75TZhiK05PPg14QIfe/T1kK5A8qFKYSA7JP2UO89qTeVIplT9Q5jw9Vdi
         CTwtfek39ZYc4Mej6mfNLZw3kt9T3S1XgPfzLMZBTgsCMgWjzurZc8JHKGRI8TUblEpz
         evIlaqWc/0N34XpvXMbRsq2ZcKyY6UaNruZ1Oub9nuGeY9g5hxBvrm0G2VDo7Gy6iGbw
         kW5faOKJP7AdmcsBI04tWvL/CpPaS4AwHcTqzaN/K1nEtcOaUbWczezC2UrnhTckULZA
         Hk1g==
X-Gm-Message-State: AOJu0Yzl8ZDUL9DtckSmK3Y+wcbtU7iC/yWfZ/0SXbX0UAC96mGP0DIi
	PDYehhW8fkLn74dP9fTAFXqtluQTfTBZswvfIQ7yVDp53gr1p04OBKg8pmM4ETEm
X-Gm-Gg: Acq92OFtG/b13NZfbuSSW9HS/YJVw0cZksTde22SEf3XdBbGpKhp3+BHriwEySmgFis
	YNU4n5qwjfSgQx+J5VS7vBUplgSumviGbtpaMGfmmYyx9j3wD8qVT6YtdEzERqdODfqYOTRvMZN
	f5Q4EMbhxK5GjLTfBMhlWqemtJpsKv7iQAIpMCALawqdMfVVxWQc1xYnU6h7dcY6skxr9+6zNsl
	4aQ9mYamyePIa4/Q0mvNp5GE0+zmezJ8cFFttRrfvLVE4iT5xQBoE50u2cevlMkjD6obIlYxiYZ
	IEbM6ssRDQKdgdbPJWct9ppU9N11PvaLrbUs9+4dMOnp8GYBZfG4jrzbEfptIZvjZQNJIUdJZYb
	DjyBinw5LznKH90G7H/yZKv8banwShuy1PwHD/m2F/P3k7m3x4+qHv2eGRcNZ+KsGp/18v4afzy
	kcFLo0NZo0m1KVXCxr5ZRRbF3BTB8/E+k9WkBR6V4hkpJrxBaPdXOKC1QOEbQNNJjQnurMxuyeX
	lQqDWs8jFsx9nQo8cRNZBDPVuDA8P6iiRgzzM2HnrWIpVLDhuDY74D8
X-Received: by 2002:a17:90b:48ce:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-36e2fe831a5mr4943283a91.12.1780521472469;
        Wed, 03 Jun 2026 14:17:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d1fec67sm782670a91.11.2026.06.03.14.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 14:17:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net] net: ibm: emac: mal: fix unchecked platform_get_irq return values
Date: Wed,  3 Jun 2026 14:17:34 -0700
Message-ID: <20260603211734.30750-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294923-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rosenp@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BA3D63B5CA

platform_get_irq() returns a negative errno on failure.
Commit c4f5d0454cab5 moved the platform_get_irq() calls and explicitly
removed the error checks that were previously present, claiming
devm_request_irq() can handle it. However, a negative IRQ number
passed to devm_request_irq() fails with -EINVAL instead of
propagating the real error from platform_get_irq().

Restore the missing error checks with proper errno propagation.

Fixes: c4f5d0454cab5 ("net: ibm: emac: mal: move irq maps down")
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: remove error messages. platform_get_irq writes its own.
 drivers/net/ethernet/ibm/emac/mal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 7d70056e9008..83dd7f99d8d5 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -635,6 +635,11 @@ static int mal_probe(struct platform_device *ofdev)
 	mal->txeob_irq = platform_get_irq(ofdev, 0);
 	mal->rxeob_irq = platform_get_irq(ofdev, 1);
 	mal->serr_irq = platform_get_irq(ofdev, 2);
+	if (mal->txeob_irq < 0 || mal->rxeob_irq < 0 || mal->serr_irq < 0) {
+		err = mal->txeob_irq < 0 ? mal->txeob_irq :
+		      mal->rxeob_irq < 0 ? mal->rxeob_irq : mal->serr_irq;
+		goto fail2;
+	}

 	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
 		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
@@ -643,6 +648,10 @@ static int mal_probe(struct platform_device *ofdev)
 	} else {
 		mal->txde_irq = platform_get_irq(ofdev, 3);
 		mal->rxde_irq = platform_get_irq(ofdev, 4);
+		if (mal->txde_irq < 0 || mal->rxde_irq < 0) {
+			err = mal->txde_irq < 0 ? mal->txde_irq : mal->rxde_irq;
+			goto fail2;
+		}
 		irqflags = 0;
 		hdlr_serr = mal_serr;
 		hdlr_txde = mal_txde;
--
2.54.0


