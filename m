Return-Path: <netdev+bounces-261336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJi6MKFCoGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:54:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699B1A5F43
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 456DA30AB0EF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453212DAFAA;
	Thu, 26 Feb 2026 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8FryCGa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879B2DA76A
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110435; cv=none; b=TgWLsI1G2KgV3KOoi1jaW4LwKvpt0pkNO/ELURAavehO5sbzDb6RJfhLk2T0AG60mIGMPqtHS+Fmepoj669lJqrr323BHe4EFp8IQJm0xyGrq6cjDXSL5YfYvWaPizv4rndnqeyPMD/MsKuF1xZQWnzFtlENsXCOnb2AyivEqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110435; c=relaxed/simple;
	bh=fFttaZMGeLdp3UAEasDbHujAJF5yaSFRST6gXJrpxk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYXhtGfRoJ/vOQbTSVCzb/+cYECo9Vy+slAQtTFo8cG6pxnOzMm2WApTKhM7Qu6luopvXOimO+LoR5tlupBti2aJFefRDKyrz88z7oobZXGeHTH2PWYbRPWYzVZGoTZ/l/Sr2gMD/pGgk5r58roWZ30ZPzvR3mxpK4LUF5FHKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8FryCGa; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c70f191313cso306045a12.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110433; x=1772715233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyD5MkH20QdTZJ8Vxn6Kuz/fsHPnaaXUSaeZ35cNF/E=;
        b=h8FryCGabceH9Uy/AtyN5Lz6GYCvlmmIf7UfGPYiuWu0iCZw2yIhli6nqTrYPByTXk
         n2jN/4pvIKrXTzq0bnXPhHgfW0Sfrg/op9I1LUkMuCjZ70rim2QeGZEvfGF/SYBQMSvc
         w+ZotR4ZQl5MRpI9hWpaAqHt4YIJhii9Vp5KS9/9oGYGBEVKxhFylDK/c9CSv+k5zTY8
         fVWoKcBzq30qkW+C+vUeG2LJs97YcPJ2qD3rkfnG4oxbu/KRLq6vMdYPwUVnpIVNyxnM
         c8Xak5sObzy/ZEZFahWvrCDkwJUbFcgwhCvJWq4uDkto89yzAZXnt1d5rCPCdhFu8GXE
         T21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110433; x=1772715233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cyD5MkH20QdTZJ8Vxn6Kuz/fsHPnaaXUSaeZ35cNF/E=;
        b=JafVJvbwL0F2yi2goZSjPQlzQZ+yl3igVc5aaHx8CKbahQ7EXEnR8LpK68m4wQnbhw
         jn6kYME2sffnyGsfjcCi4hwpu90B1ZodfqVj4eu4A/Eg7VPrFqXJfsHKDb3kjFCZwgPR
         FSOmJjvFi84lFpmyUzQXHa5VlEq0lbqA5XOZhqiGkGKVnHuHFGlmCuzKIc75p0kqF3Ye
         Uff1cpR3+p1RDDFaYEoAgrN7Yr2alhYF32/7V8VvGpxwNT7EH4r3EGhQTZjSf7tKlgPB
         KFCN45B2Qj6+ZRl7ObbhiiHsYtTMwkx9eipp5PQNdqg520CDzY6RY0uQs0f/ahoZe2IQ
         yv/w==
X-Gm-Message-State: AOJu0Yy7Ed7fPWyxrATRYt4XExjCO3NWLRLuAPmBr3YYpgivx2McZ1rC
	q4601JvrLAdpN0imOLI27qU+9BLyPzPiYunHtMJrb0/duu+vaPOC3dK5+SnB+Wjo9MU=
X-Gm-Gg: ATEYQzx3WqwpHhvZRCNOqwHvSB/ibGyJcmL+7K8oqtXKkP49keMEKi1c3yEQxSjevul
	Fui7Sk7cEXAsFNU5nJCu204e4LBBZQ5298gzN38oVqQzBhoA7uiht6JfQ9ndRUKnlBpWMsqWJ0H
	s1FgQE3P25KotCamted2pKJSTmQFpN/totnoYgvSex0/1JRi0O/dMXFqrvR/lrLa0EQ/F82tmci
	djWwMyZXLOXBq96sgPcgV5nU2tUobgDXpzNFjKj8tZd12lueoBruwT9jKFNcEThUaSdOUP3qSvW
	BY4UxERDdE94fLpA+BX5djtupqtGZ1sGI63yvUTZijwOOqTrEYRERxkCizkgaHgBJSvkAP9wS1o
	oYXMgkl5W1luNgDEDJkIwjNXyxg28g3pV4LfcvOT7L19qrxwWDPK3FDNo9lRfarz2Kf/wYaxEKy
	B0c4KM+hRu9zidUGxkDeMIMc1FHcM=
X-Received: by 2002:a17:902:ec81:b0:2aa:d29f:1444 with SMTP id d9443c01a7336-2ae02969668mr21350065ad.10.1772110433295;
        Thu, 26 Feb 2026 04:53:53 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb705b53sm25276715ad.92.2026.02.26.04.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:53:52 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 1/3] bonding: set AD_RX_PORT_DISABLED when disabling a port
Date: Thu, 26 Feb 2026 12:53:28 +0000
Message-ID: <20260226125331.28147-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226125331.28147-1-liuhangbin@gmail.com>
References: <20260226125331.28147-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-261336-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4699B1A5F43
X-Rspamd-Action: no action

When disabling a port’s collecting and distributing states, updating only
rx_disabled is not sufficient. We also need to set AD_RX_PORT_DISABLED
so that the rx_machine transitions into the AD_RX_EXPIRED state.

One example is in ad_agg_selection_logic(): when a new aggregator is
selected and old active aggregator is disabled, if AD_RX_PORT_DISABLED is
not set, the disabled port may remain stuck in AD_RX_CURRENT due to
continuing to receive partner LACP messages.

The __disable_port() called by ad_disable_collecting_distributing()
does not have this issue, since its caller also clears the
collecting/distributing bits.

The __disable_port() called by bond_3ad_bind_slave() should also be fine,
as the RX state machine is re-initialized to AD_RX_INITIALIZE.

Let's fix this only in ad_agg_selection_logic() to reduce the chances of
unintended side effects.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index af7f74cfdc08..c47f6a69fd2a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1932,6 +1932,7 @@ static void ad_agg_selection_logic(struct aggregator *agg,
 		if (active) {
 			for (port = active->lag_ports; port;
 			     port = port->next_port_in_aggregator) {
+				port->sm_rx_state = AD_RX_PORT_DISABLED;
 				__disable_port(port);
 			}
 		}
-- 
2.50.1


