Return-Path: <netdev+bounces-265150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /+nhNW5SrGn5ogEAu9opvQ
	(envelope-from <netdev+bounces-265150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 17:29:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E0022CADD
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 17:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D426C30089A8
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251023A5E83;
	Sat,  7 Mar 2026 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfrqLUL6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A03A4F20
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772900971; cv=none; b=WSE6AD0ljzkW2K2yDvLoHMgMyvwl7Z8TopQybDOM4KPaB3pIxrXkpBUdF79USIz2lviF6EYyUD50eRE9r8tBJNSGzF+uEBqwHQvTydW2pI8tve3Yy7VCljKzTxLD4BOuAUxDPSgVcWjf1uSKGGEesMf0tFedGVfQDBuSusAuB9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772900971; c=relaxed/simple;
	bh=37SGt+eBfh1kSLaW277xvldv9vczb2ahUziRI+nee6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aCiFJLgxhcLRanUr50HvWWejAyfWflElHTjUjOvfA+5tA2V5sY5jNdSRVUjlYzwOANVvDj9MLA5jQDe1VcySWmDXpANwtZB143Lh2IEH5KGdt4LeLzSwYUq1XZ7hHiQsx1JnjLQw9MXO0Z5ZN8xV0HQpi9S1i0a/2uasAjGfdvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfrqLUL6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35691a231a7so6376292a91.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772900968; x=1773505768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPyS9N2iRa4FE/95ypLjDHbInx6Eup+NSwPVYHYpbqM=;
        b=RfrqLUL6ykiBCnKXXQVvefqMGx/kqeGJp7Dd4wRuF1oq6mUgR29Y0mOxKzT8q4+EF2
         t+vOTIeBuqupxJS1WUVN+ts9iLViZs4HGRar/iW635WJvfPKGc9Zr1qwNWVPbV22n4c1
         xp0qF5s35Td453PiqF3pfP9PQtSqwj8ErSEB72YpdEezAVnJg7JmV2K9Tgyv+GTiMPkh
         DeJyvnezBHWDBfWUlgSxOU0o5Em0q9FdYpQk1xHnZpdsdTTJNhCxDbBd1RXdbP1Whx40
         lMSRGj8Q+lizIjfg9hAyrJ0y8Lbhihxahnngobre1zksCeNkidUkF4fGe1P5r9C5wuEr
         2ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772900968; x=1773505768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPyS9N2iRa4FE/95ypLjDHbInx6Eup+NSwPVYHYpbqM=;
        b=sNlOFsbJsvHLk9yURPIU009RHuLoc+OuNPydkn4hIjCmqGBbM8wgASdRFcA8nIQeaC
         D6WVE90RvWgyMukFF9N/XS3iHQzPhqeTMv6KO6qTD5nOQ/VdXvb0mD6/4bc9/pI1qgMq
         1JNHUc8+kdFmU0nLq10aShtDO9yvp6HWb9fDkaM2Y3PlqDOfW1b84JvdWXu1TPxTYaea
         VoVJRdXO9gU9hoidgsjbMYeZH5FYN6m/tDo1L1VpEsdczwYw7x46s2FhWVQFO2kRXAg1
         VZ5h2zUv8CYJa73QNT3HdSUBocfJwa7i/8Mwg0/RLIqoXdopvMfJrXlHhNXSGrVFMShq
         NaEQ==
X-Gm-Message-State: AOJu0Yy3v38JsZMfnoKhqLZg5xbQvxzcFeVEsMoptE8b/Z2X8bwYv5T/
	54JwvIE4PyWjbib6A0iJG4x7QuFmIny2P5UHK7MOCQS3tPCbNzF1JjLL
X-Gm-Gg: ATEYQzwxJYF5VsXhPf6+eQ54eGr+P6cW6FTGYkjD155uXTM6+9QH//jgJH+iIBwz64g
	cPY+eKOoz0boCzMAbNLHT21XOn2x++P2tgNngTkqj3BUM7xUsB3oZyGSi8xmif3P7gKmNQ8+DAc
	mQaSE3/Cx7kOSI1F59Mg3/M/gVWYyxijGGify00zjR9xTJcbKa9OUMRMnuAzPn1ga+SlRbi82oA
	F94ny4NOcJ0dhAvUTSkbz+yX36BQjOnZaWZE/KXF4kgLTg1v4WCt5S45Me8Kd9UezT1CJVm/KNn
	tbom6rknxdTdqp+uP87Ja6+3YMK8DlcR+oBbf4dPkVJv9uEBKt/VL2PfndD7n5fTCgBy1bOnFoP
	k12+gEBu9jei1nvwf/BSwR5Ond70bmg/OHbcAGVQPJcMvY8mRslfDY0tdianeJ4bt83epkgvG8p
	qujuVNbOliXOAosbMyd8UxpbsquWdsDiExmR4HMIOidA==
X-Received: by 2002:a17:902:da91:b0:2ad:cede:3a1a with SMTP id d9443c01a7336-2ae8244f4b5mr66649205ad.39.1772900967904;
        Sat, 07 Mar 2026 08:29:27 -0800 (PST)
Received: from DellG15.localdomain ([112.51.242.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f7837bsm55022855ad.48.2026.03.07.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 08:29:27 -0800 (PST)
From: Guoyu Su <yss2813483011xxl@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com,
	Guoyu Su <yss2813483011xxl@gmail.com>
Subject: [PATCH net] net: clear mangleid_features for SKB_GSO_DODGY TCPv4
Date: Sun,  8 Mar 2026 00:29:05 +0800
Message-Id: <20260307162905.3697050-1-yss2813483011xxl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31E0022CADD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,googlegroups.com,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265150-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yss2813483011xxl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Syzbot reported a KMSAN uninit-value warning in netif_skb_features() [1], which originates from gso_features_check():

  BUG: KMSAN: uninit-value in gso_features_check net/core/dev.c:3804 [inline]
  BUG: KMSAN: uninit-value in netif_skb_features+0x6fb/0x1870 net/core/dev.c:3828
   gso_features_check net/core/dev.c:3804 [inline]
   netif_skb_features+0x6fb/0x1870 net/core/dev.c:3828
   validate_xmit_skb+0xb6/0x2400 net/core/dev.c:4003
   ...
   __dev_queue_xmit+0x3016/0x5a50 net/core/dev.c:4795
   packet_snd net/packet/af_packet.c:3077 [inline]
   packet_sendmsg+0x91d9/0xa320 net/packet/af_packet.c:3109

SKB_GSO_DODGY marks packets whose GSO-related header metadata should be treated as untrusted (for example, packets injected via AF_PACKET).

gso_features_check() checks IP_DF through iph->frag_off for SKB_GSO_TCPV4 packets. For DODGY packets with untrusted metadata, this may result in a KMSAN uninit-value report.

Handle such packets conservatively by clearing mangleid_features when SKB_GSO_DODGY is set, without relying on iph->frag_off.

[1] https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407

Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68e4b5d8.050a0220.256323.0018.GAE@google.com/T/
Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>
---
 net/core/dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 14a83f2035b9..9b19154b6f7f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3808,7 +3808,12 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 		struct iphdr *iph = skb->encapsulation ?
 				    inner_ip_hdr(skb) : ip_hdr(skb);
 
-		if (!(iph->frag_off & htons(IP_DF)))
+		/* SKB_GSO_DODGY packets carry untrusted L3/L4 header metadata.
+		 * Avoid dereferencing IPv4 header fields and conservatively
+		 * clear mangleid support in that case.
+		 */
+		if ((skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) ||
+		    !(iph->frag_off & htons(IP_DF)))
 			features &= ~dev->mangleid_features;
 	}
 
-- 
2.34.1


