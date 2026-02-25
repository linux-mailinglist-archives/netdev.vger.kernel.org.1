Return-Path: <netdev+bounces-260853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD5nBEPInmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:00:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4301956A8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFC34300E298
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942F3101CE;
	Wed, 25 Feb 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw5PYJ0C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5912E0938
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013632; cv=none; b=j4c3TLmENnm+PAu615/KHA20tNzN+Bk2/p0czaZWsM+vRVptr2OUEDDk4jUOiBZs/fgcA6gzwjoqwekcQdTLihmBvS2lWY9nu8tqfwE4jI4+MK8dSeAKuAq4KWs3I7Jm3eLLMYwckkVS4CgZ8tuJ/8BMbkNtDczpUAf5w8hOMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013632; c=relaxed/simple;
	bh=vkE5Ptfh8XqWofdz/fULhpBiTtYfPIvN8IrqcrvlObg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ptr5KQV/rM5i75NT4mPcrDmq0yEQelw645CZsePYGsAsK+UCpyicdKvNJbtJncMlV9W1VyYcHgpLoYVbh0Tuw/r5Mrd4Ej4q8gkQ/t9vKo+MEUkWsr1HDJFMlIfEsiP+T7k91D7p0GJPdufpt/3at8w8GzEvucEmv0bbtANZWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw5PYJ0C; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-827307b12dfso6598b3a.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772013629; x=1772618429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=byNHBdeiFuWhQTNwN2X3XtwxEIQfrl7XP2ei/RflPc4=;
        b=aw5PYJ0CgZuYCHSITfTU/MZE1jk+9enHkbjDPrhC1aD2jj+SRVHcYG9/50CihuWIJa
         owrKQ30xYGq62XTppUc+mei0fcvJZIJgFgRa8udxidpvOHSSzDOWLC63j/eukSR3kMRS
         TDV/fTQ6Ts1RyXe6gsxIWLHepH6XmwSCZ952fSypD16Nm3kadxZpaTO9NSYpdppWwkEu
         6O6y5JQznhkhj9DQJeT+dxWeqGlERzLYeEA82TMGAul8LwD5hfvJUUelNqMafvE+Rb6C
         kVvXfj6FaDVBm/df2n24HC7cyT35rTuPY781FUbBSEgDpTgLUAFbcl5WkEctXSCsJlw/
         V1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772013629; x=1772618429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byNHBdeiFuWhQTNwN2X3XtwxEIQfrl7XP2ei/RflPc4=;
        b=cIgAT9nIjO7EgqwZNAyPnki55hy+J+S5vvG14IzndLALqls02qRB4r715KivwM7tTo
         bsKCNolq3RTd8PtCFxrToXo19je78voq25/A50qwcQH0h3ZrjZtr42W3A8z6rlm0/Uzq
         Rk0CKkrEqhOD33uopbAMXVl0+XzrNZERX6IYhm1+WPUXi5v7Z85l0L92aFqDHXFtKOm7
         ic0Go+h7rAnYCO/+7Mhp1E4m4pstuBvaL/EE8DpA+fRLb8GwpRO/xrUrMIcqLl3ub68O
         4Kvlwk6WYfiqlvrE5nsNrLRRzmcFMNBrmQZgnlZu6APQLxuF88jJr0ioD7T5mco/IgE9
         r5VA==
X-Gm-Message-State: AOJu0YxY7198w4OYfvYJMOhTFn0t6bFGcAAv4MOL6cEbqYPq+xyydC3K
	xc9z9b/1FK7Fck8lICWUOwrNjlHeNh2iT/jr/hn4aCFbgh80UPQ6+bK6
X-Gm-Gg: ATEYQzzx5Ifxp6BKS7Qr7+33Pwn804u+xNckTbtRS1d5A8RSyNWueMYzAFQhQdiOV5x
	0OsGr7e63iwPACndXDaXqRnGShvRG/uNHXoM/rfpenul6Ha6FQsNiXE7MGF/2SgcWpiNG1rAvDn
	D3WgGdMNj0zy57GSIaKw3/aNv/52DwUbC1QtjtAfiIGPWoeCuFgbYeRzNiekQjbAw5gVpsBmQPr
	tKmtnMKuhOzbcBOas6NVFMiYpUIJm9Lvg1B+kIM80jkH8vR0quQee5tDka8Eil+lIkVYtLl5odd
	H13V7D0i4eb0Gi1uXdrDDelG5Djv/QKOy9Ko6d2R1fenYnFWuvjLbhO5FOZLqI1mn6bWgu4xMrR
	jGv9pifBWBM8JUfNwB03H9NYv8+qjvRxXNWKXM3ojYFg//PETpVFOt0rM3bes95fC+YaOKJQUQX
	GHPRJRS/OYDiTWJ45Cx5vZWqNfYrPCcAviUPwFp2JDM6SrQL4=
X-Received: by 2002:a05:6a00:28cd:b0:80f:4667:a94a with SMTP id d2e1a72fcca58-82720f81710mr2384242b3a.10.1772013628680;
        Wed, 25 Feb 2026 02:00:28 -0800 (PST)
Received: from localhost.localdomain ([183.96.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd690f19sm13134052b3a.22.2026.02.25.02.00.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 02:00:28 -0800 (PST)
From: Kibaek Yoo <psykibaek@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kibaek Yoo <psykibaek@gmail.com>
Subject: [PATCH] net: macvlan: fix multicast delivery to bridge ports with shared source MAC
Date: Wed, 25 Feb 2026 19:00:24 +0900
Message-ID: <20260225100024.38937-1-psykibaek@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260853-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[psykibaek@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA4301956A8
X-Rspamd-Action: no action

When a macvlan interface in bridge mode shares its MAC address with an
external source (e.g., VRRP virtual MAC), incoming multicast frames
from that external source are incorrectly identified as locally
originated. macvlan_hash_lookup() matches the source MAC to a local
macvlan, causing macvlan_multicast_rx() to skip delivery to bridge
ports under the assumption they already received the frame during
transmission.

This assumption fails for protocols like VRRP where multiple hosts
legitimately share the same virtual MAC address. The local macvlan
never transmitted the frame, so bridge ports never saw it, yet the
multicast is not delivered to them.

Fix this by passing NULL as the source device and including
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
index a71f058ec..ea22909cb 100644
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


