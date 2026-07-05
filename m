Return-Path: <netdev+bounces-304767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FZPiJ9FBSmrLAAEAu9opvQ
	(envelope-from <netdev+bounces-304767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 13:36:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1815709D4C
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 13:36:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ct0Y3cFT;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304767-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304767-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E882F3003BC9
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 11:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38ED3783BE;
	Sun,  5 Jul 2026 11:36:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270C433E74
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 11:36:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783251402; cv=none; b=CovA1nRzw/fj3/CQUxjWg65NLlAt/DtlTSS5kU8EB/W4fKR8Ho7vopzsAulsy4ipBeq6uEywbt7ssOOQ2Uv8dnR0QHX0DwgKqw171P3W9ZW0yO03xVfPSDbDl4h9cWPxZmzIHyxO3QUIKCT6WQeUZ//qIhFKkSQOkBTOvPbz7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783251402; c=relaxed/simple;
	bh=bue3ZQS+aizj088Dq7mN65FaV07jnc8viFfDXWJsK+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELjGh75DB2kRHXBgS2K8R0B3+346MK50x736Q11oM4zmRIUgEdnlWbL3truR0R40WWUjv5EqXOqsBWxwVNYGFX9UBx2l7XGLPQ1whC25KzzJy5vG8QdsFEwlwQbzFxl8MLE1oX+Mv8RzHyZaEaheRmCzb0zA2pZ8QzSJz1JlGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct0Y3cFT; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c7cfa17fedso20542575ad.3
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783251398; x=1783856198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s8VIdU9IBO7hgfq4VBSOw6X3+441BJc4uvQfo52qhLE=;
        b=ct0Y3cFTcE1umFD6lW3qtil1AVDWfPiyFhnSUVy5DxVVKmU+sYqCWtWlgOq06ZXZ5C
         YxqhNBaLXQFsrDAY0CiRoRIOUgJNKWEm7UD6puPN2Bdf+QV5IZRbFnCWlLy0j94TJaO0
         YOug7xHMEiEqbPqeGjyNgcFH6Es+DLXkfgyH+gdWvRfKhZ0dA6uijXVoI2XSsji1kFxK
         Pp9vpKQy1FwVKAA8QxRCfrPgn12QatGVZqYE2VBRClDk6T1ufrFYXGU5WacaxH0a+lkb
         Q6dWxLwyHVsvxDy3W+w8T6kJ5zJzpnMAzWIqdN8O+Qrq1NgpyR2dWHGAviiKCJDrcc9r
         Tj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783251398; x=1783856198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8VIdU9IBO7hgfq4VBSOw6X3+441BJc4uvQfo52qhLE=;
        b=RAautQlgZmCVvUEQdKAQFkQvEDv9wRgkW2LVSx+0bTjJ5ONrxmGuO+ErwYGcsvXDsl
         H7OhB+y8qRDPanIDMS1J6L7Lj4sVHz/WlX4ET3E+spcbhY4bIxcHLkjh98K9sEduklRG
         YpL+iJKcbzNtI5dD1mltvMDA41ruVziNFe4fp9E5KImDW5fjk7LYAN7VOz9wFgGL2ayu
         r6oE9TzIL8P01jtsoiRDF0/MdhVIB/KQTbia3qZGOVddAGiafCop6QCrhnb/lIGbCrbw
         76J1H2yZ/uisKVL0iJ933Bos7eJeW76a3EY7l4Ekc6mnXixcMi70Vu4pGk31Qp17i18Y
         WMZA==
X-Forwarded-Encrypted: i=1; AHgh+Rpz4gWaadjjbKQy/fIYMUEuau7SD2zcjCOBp8wz7Uv2Q6UtBBVlkYgrPLNnZNAbFBPLtvyusfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjuKNmwXPtPOckdunJO3awqRyOIc2AzWC6Shd5rxdnf0Knu4Db
	9C17J0wLebL2GTtZ/5k+ExgO4wZ8UDrP9H/0G1R+/dkTivSXaiNfDh25
X-Gm-Gg: AfdE7cm90cQoGs78wuHaMbgDn7ONXhPGKkvrCga91SwP8MBAr4JJGmCnGIGW7310JwO
	vvbYgOddufh9DOgnMCybiXBtOxqLibQs10s+twEeL+/WvdZUATZpnPAY1z/fSpD8QIKJwQ78eBV
	4ECCwkUyZVxxO4oypAMB8tBPw5Gaqw4lRgMFguGaKILkhWOFUr7vwhLVxyWp4SiR+6XxHkbiWos
	HDhdQqmLo/ZHxPFQVISVvu37JcRypyI7gHHiIvJxM5Km3xDAdyqn7EDnx1tdo+KHimUTQFw2HEw
	YJRCwhaOZAW0C1ek1oU+UTShgkisPdQHHk05mp24MzhH29B8pBred6rpG5N/X/SLjoYZtsG1Ttw
	4NmElPwtf+AVuvRLWNobVj5+aSdqghF0coobobJ4Ar1G01n6PI03iOi6G9HqV7p5zMzyPwL7Q5Q
	S9UEOPMglrOayjQu0Rl2d17SIEopZXKhihiZN54w==
X-Received: by 2002:a17:902:dacf:b0:2c9:97a8:afe5 with SMTP id d9443c01a7336-2cbb9edf365mr59496035ad.40.1783251398363;
        Sun, 05 Jul 2026 04:36:38 -0700 (PDT)
Received: from JRT-PC.. (bb116-15-8-251.singnet.com.sg. [116.15.8.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad789e7ebsm32921335ad.81.2026.07.05.04.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 04:36:37 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: James Raphael Tiovalen <jamestiotio@gmail.com>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antoine Tenart <atenart@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] macsec: fix promiscuity refcount leak in macsec_dev_open()
Date: Sun,  5 Jul 2026 19:36:29 +0800
Message-ID: <20260705113629.187490-1-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304767-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:jamestiotio@gmail.com,m:stable@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:atenart@kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jamestiotio@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jamestiotio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1815709D4C

When a MACsec interface with IFF_PROMISC set is brought up on top of a
device that has hardware offload enabled, macsec_dev_open() first calls
dev_set_promiscuity(real_dev, 1) and then propagates the open to the
offload device. If that propagation fails, the error path jumps to the
clear_allmulti label, which only reverts allmulti and the unicast
address. The promiscuity taken on the lower device is never dropped, so
real_dev is left permanently stuck in promiscuous mode. Its promiscuity
count can no longer be balanced from software.

Add a clear_promisc label that drops the promiscuity reference and
route the two offload failure paths to it. The dev_set_promiscuity()
failure itself still jumps to clear_allmulti, since on that failure the
count was not incremented.

Fixes: 3cf3227a21d1 ("net: macsec: hardware offloading infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
 drivers/net/macsec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index fb009120a924..71e4676b1dd9 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3615,19 +3615,22 @@ static int macsec_dev_open(struct net_device *dev)
 		ops = macsec_get_ops(netdev_priv(dev), &ctx);
 		if (!ops) {
 			err = -EOPNOTSUPP;
-			goto clear_allmulti;
+			goto clear_promisc;
 		}
 
 		ctx.secy = &macsec->secy;
 		err = macsec_offload(ops->mdo_dev_open, &ctx);
 		if (err)
-			goto clear_allmulti;
+			goto clear_promisc;
 	}
 
 	if (netif_carrier_ok(real_dev))
 		netif_carrier_on(dev);
 
 	return 0;
+clear_promisc:
+	if (dev->flags & IFF_PROMISC)
+		dev_set_promiscuity(real_dev, -1);
 clear_allmulti:
 	if (dev->flags & IFF_ALLMULTI)
 		dev_set_allmulti(real_dev, -1);
-- 
2.43.0


