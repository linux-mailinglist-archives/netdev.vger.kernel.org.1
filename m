Return-Path: <netdev+bounces-262088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILpRLgyXomn14AQAu9opvQ
	(envelope-from <netdev+bounces-262088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:19:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3DA1C0F1B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE73303DA84
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EEF364E8D;
	Sat, 28 Feb 2026 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQTBVLCZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08636495A
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262979; cv=none; b=Vp42VTPnRZ/IZdNbXUWfsG/6c1JGLhYMqG9rZ2HsKtH7sKMhPQhv1zSG0rjE5vedaMHtv3dBECGcIoz92k628CrTYhSrIw5ofGxnSp95o5aVW73yuaSmZGXhi8rJipAha4o0hBPKd4HueCamB8wmcK7he5wqrT5cZchGtMxiV60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262979; c=relaxed/simple;
	bh=tsmXhSYjLmgpDRPS50ph8Bcl+qptHNtwzbcyb/W7mCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtVIWKJWnXivUZWR5RYvs6ZCJhT1aaEiJY74Qhaqhyi8nfCyybk6vyA5svHo7i7dQln1xLihhogr9cx1ii/IkhkmuM4MDuCXradnToHlLg4WC7HqQfEL/bE9Do5yQ2qwm0/zpH6jDyGVXBlS7eF2nUb2rEfsEis9wuKio/Ki/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQTBVLCZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2addb31945aso21190815ad.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772262977; x=1772867777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe0K2hcCTdrZQJvsxYDudUKfsrBK0GJvioISkwHtwEU=;
        b=nQTBVLCZ94m7xy9zr0+M00lLKIzvKcRhU+rvek/Ntd68/7P9KmPaZkcnJn988bf9Li
         Bq1xaZ/LR8NgBVjx+td/7XM/n1P0iyYilK0YEpWOBM90BmochlzHBOFx7VzaMvQecvZW
         bwR5gih3RQW6pXEULNO7SMTRrG6MY0s5RR/eXnuWoscC4ioJm02/IQSvRXXrr6128vbD
         v0hXuag34QLKytnfJFDtCa59C31j3mtL6v2xjA8hDpiwuFYZFsi7TWvJlrj9wGU4w+38
         NRtGK3P3hyopMWZQsMgUmh7jlEdAj1jykT+BgcBKqlrtfPURDMuF6e+yLBUuYIX5LJXb
         ILtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262977; x=1772867777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qe0K2hcCTdrZQJvsxYDudUKfsrBK0GJvioISkwHtwEU=;
        b=uSCyRMgx0zvF5SjpAQ5fK+qVqFrBOBt5JZ2PEZpm+RxRNjXVqNcL9V6pR2VEf1Te7M
         XYy8HBZHe4bNLi1DRwLQbLrzVI3uoWzfEvPHwma+yEy5aVmF+Mo9c3k7OKgh1E3LxL5G
         0wSbEUX1WCDgsEzRSGO0vpu4LnFPxkkSHftKLqaVJdDf2nvYDo0nGwwFuwz/gkNu4uRp
         vyeARXw2Ih12hH3c2oXO4RYtmg1xffjgImKReXVjDkXdxlIJ33qIdO8hYWifFKt28G66
         LHls1g2JB4vRKLhBtVRGzJ6w/Lc4uoplUc90FaZg/vRN2LbjgA7GiWac7tFQz7PJuUfo
         pMXg==
X-Gm-Message-State: AOJu0Yzdrxql7fWcVeZeaatgWwPMMu6wyd58ve7INXD+tZoYc5KgG+s+
	S0wFGrTQKciX6CIO2vaG0HOPrksCv5zYb9+C3bRr66jgNhOVqIwp+r5C
X-Gm-Gg: ATEYQzxMji5vxXXTCwUuowm7sZZNTh5U73IKK4tl2pmdNUJadO5vWYWXTFwLGnOaJKh
	Uz3+mUaHYzLkSdRLXksrR/9khUKZSRHOUYIr1kbW/VNulB1JzJQ3rtgp2u0J0jLMKyOX6uUHh4B
	wrix7Bq6fCQikd3EdHw1Xup2TZFzcpykbS/TH6IJ5uV6n/5xhEUv8A3hvriiRq4cO+ZIxzVOMHi
	mFW+7Nwvcz1jHCDOacUASnR8AWk2KwvBTQPALCVy2m8I1BJUq87z5FWbkP+d+qPoR2R+GbT0UaA
	KBYJc9f+Gdyl1jNnXapha+1KiKYq1Sci5l4w83n31uGcyMDXhpAaToLsxnPcsWGvg8Q59ZByDyg
	Z5ALExkWtqYBr2Uc0yE6ES2V6Y354aYt/X7POxtGlPOOvzGu332Kzyg41K1ohcozadmtPXO4ERH
	K82YZfKq+BPxLFIrG9IdjRPNvukWOHY3HVFuES0i+/dPL0WCo=
X-Received: by 2002:a17:903:320b:b0:2ad:e02b:4611 with SMTP id d9443c01a7336-2ae2e3e72d5mr52324385ad.1.1772262977455;
        Fri, 27 Feb 2026 23:16:17 -0800 (PST)
Received: from localhost.localdomain ([183.96.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b4535sm72004075ad.17.2026.02.27.23.16.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Feb 2026 23:16:17 -0800 (PST)
From: Kibaek Yoo <psykibaek@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kibaek Yoo <psykibaek@gmail.com>
Subject: [PATCH v2 1/2] net: macvlan: support multicast rx for bridge ports with shared source MAC
Date: Sat, 28 Feb 2026 16:16:12 +0900
Message-ID: <20260228071613.4360-1-psykibaek@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225100024.38937-1-psykibaek@gmail.com>
References: <20260225100024.38937-1-psykibaek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262088-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[psykibaek@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2A3DA1C0F1B
X-Rspamd-Action: no action

Macvlan bridge mode currently does not handle the case where an
external source shares its MAC address with a local macvlan interface.
When such a frame arrives, macvlan_hash_lookup() matches the source
MAC to the local macvlan, and macvlan_multicast_rx() assumes bridge
ports already received the frame during local transmission. Since the
frame actually originated externally, bridge ports never saw it.

This situation arises with protocols like VRRP, where multiple hosts
use the same virtual MAC address.

Support this by passing NULL as the source device and including
MACVLAN_MODE_BRIDGE in the mode mask for the else branch of
macvlan_multicast_rx(). This ensures all VEPA and bridge mode macvlan
interfaces receive incoming multicast regardless of source MAC
matching. The trade-off is that looped-back locally-originated
multicasts may be delivered to bridge ports a second time, but
multicast consumers already handle duplicate frames.

Signed-off-by: Kibaek Yoo <psykibaek@gmail.com>
---
 drivers/net/macvlan.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index a71f058eceef0..ea22909cb09de 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -313,11 +313,15 @@ static void macvlan_multicast_rx(const struct macvlan_port *port,
 				  MACVLAN_MODE_BRIDGE);
 	else
 		/*
-		 * flood only to VEPA ports, bridge ports
-		 * already saw the frame on the way out.
+		 * Flood to VEPA and bridge ports. We cannot distinguish
+		 * a looped-back locally-originated multicast from one
+		 * sent by an external source sharing the same source MAC
+		 * (e.g., VRRP virtual MAC), so deliver to bridge ports
+		 * as well to ensure correct reception in all cases.
 		 */
-		macvlan_broadcast(skb, port, src->dev,
-				  MACVLAN_MODE_VEPA);
+		macvlan_broadcast(skb, port, NULL,
+				  MACVLAN_MODE_VEPA |
+				  MACVLAN_MODE_BRIDGE);
 }
 
 static void macvlan_process_broadcast(struct work_struct *w)
-- 
2.50.1 (Apple Git-155)


