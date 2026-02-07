Return-Path: <netdev+bounces-257776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBlaGLCjh2lSbAQAu9opvQ
	(envelope-from <netdev+bounces-257776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 21:42:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E907C10718E
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 21:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 639593004F0C
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 20:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357DE34EF17;
	Sat,  7 Feb 2026 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayrnHaB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28A34107F
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770496938; cv=none; b=WGhbe+NHQuqK0UQyWKRAgXh09oZPvNupJjCZ1lxWpJhjQnw6JT5nTx0hBvrjOXf3qgqPSWrwsgocfleR3PWuvft+mCNSP1TSb38mjIU1aY2uDhZBMPlWGKBM1dKbqpoi1Q5WvEzy4xe1YjpDoHovnzQcAdZvNUqt3zfnbGxVySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770496938; c=relaxed/simple;
	bh=M402rHWtYF2o2/AHtn14djiA9leDM7NWEWupdD1ZLUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+eay4F9UlBIGjCd6tWP1RgFxhAORwvQ+bUGtaWobuhx/mJwCxOlsmtdcjDTMvPuGNT0XEP6gIGqQaKZ6HJ5bKlYjh2lYfCuGgy/x9kpfIBbuWHGDRlyfzql2S+Et8HyLW4ZZ/GqIGFfUk4goTd8CuHpqqYo/sE89yKX8Kn52DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayrnHaB8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-480706554beso19181835e9.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 12:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770496936; x=1771101736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14GEL2PGdIEVxd35eZSj2nzdpJiicuQg6u5TFPsi6gU=;
        b=ayrnHaB8kZR/0J6vKLwhtF17zXL3fE9GXDFgqu2gL5omFJNlOINf6lo/rEA1KYFwFP
         5CLF98CIwFxnHppGTH/WbNQRJFk5gX+P28D2kGj1OQdJtzUBtUhkF8v2dQ5oSmyXgq/J
         o0mMGiombjZk/4/oBVOp0BOMHPPPuzzBaXBzJ1eulm9etetbR4cvrwu5Ik6NQNLtzKfd
         69GXZ3h1xY5g0Q8/jocjPfBVGE0fYZoVUzINXIMqvrg3GDZglQun0PwVnxBeNMHM3zDf
         fRQAyzetoTSB0Fourepy+Ejf7w3RN9M14sdMcGRMhXbjyBICRQSTtYabONld1u5HHNzN
         UajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770496936; x=1771101736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14GEL2PGdIEVxd35eZSj2nzdpJiicuQg6u5TFPsi6gU=;
        b=HSyIscvZugh15kMBV5tk2b8UfiKC7Yn6yjn2KvvSbYGgfXPuILMbbjgHqz+RtqBdOY
         TqlFtLnEhe8HRRw7wM+hEk5eTvx2cG4yBKdsajh/ZqK9ye/tjT6Z7HpK6OiWDkTs3siS
         Ti7X0GBov8HZXCVpRQ0xg1vPzXQwLID+JxhusgS1Ac0Ye4oP48zqyxjFjGL27Z3iBm/B
         LeNfwWR1tDeFA2CjUN5fpyTXphivLc8vfkGM3uRNyjacGBiSMRz9V464QEZMUHgFPd+Q
         cMAU/Ur6Hkphk/17Eecvut64A8QRJOQVHBZ8mvxNrfajjWQZDgWkvLVerNQMFjm8QUVy
         qb6g==
X-Gm-Message-State: AOJu0YzWaYdmRTe2uaG55ZfJPU76NnRGDkYyzNCME2hhnrVnbzusIzdd
	13y2GKLQkW4MSKUcfg5Cip7UPCNIDO5oUBN6ykPvlRcErjPOOlNkszYF
X-Gm-Gg: AZuq6aKHMinWixplUqUcQcCz4IptRGGRHdREyRad9Ysgjon1lMTIGuu24hvrQhfjuI9
	2m0ZbR670KYMvliCBevKtdbZUdUOOS3PSRSkaYcKa6PfjUklP+xDju7rXNfY4LTnqifo5iAVFZx
	sZrikUbAsCR39LfpvgzQEael2IMhKcQgXB2D5yTKR7OprM5m0JkhrF3OtcGIwPdn51eMhpMb7/t
	sazxeEoYzPrWIk/+KJ3g44bX1sFNwWrkgPXCiOhJAlWIHC+oeAmqYlf+Fc0jLiiOR/+p9uvRi+d
	wg0RNeFpguuRoqu+N9N4JYbT1qMIk5/9v3ot3tLLmiSCq1Cbu0rhXUTO1x/Kst7BIxXVV4KDsbA
	LCGd0nBombHr9mtzpirjeI1877WYadlCVNJeNAK9t6MQyHbekxp3CygBRzp1/4EdnLksrg0UOXB
	/h127QPnd0KcP5kGGDHFH01Hh0pKVDmw41eiaEEweF147UimxBkux2C2lpGYi0MuQ9WOSgw+RNR
	xVeAGbB1WINfei/2Y9kyOlDRmWiQRclVKlR0JwDW09cQoQcl7SffSW+Cs+X
X-Received: by 2002:a05:600c:4590:b0:47e:e20e:bbb2 with SMTP id 5b1f17b1804b1-483201dc5c5mr95238235e9.7.1770496935843;
        Sat, 07 Feb 2026 12:42:15 -0800 (PST)
Received: from localhost.localdomain (173.red-79-153-132.dynamicip.rima-tde.net. [79.153.132.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a924sm324540145e9.10.2026.02.07.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 12:42:15 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net-next v4 3/4] neigh: discard invalid lladdr (b/mcast poison)
Date: Sat,  7 Feb 2026 21:40:35 +0100
Message-ID: <5574f74adcd631751cf38421aa45eca160a8d58a.1770399836.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770399836.git.marcdevel@gmail.com>
References: <cover.1770399836.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257776-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: E907C10718E
X-Rspamd-Action: no action

Prior to this commit, the NDP implementation accepted NDP NS/NA with
the broadcast, multicast and null addresses as src/dst lladdr, and
updated the neighbour cache for that host.

Broadcast, multicast and null MAC addresses shall never be associated
with a unicast or a multicast IPv6 address (see RFC1812, section 3.3.2).

NDP poisioning with a broadcast MAC and certain multicast MAC addresses,
especially when poisoning a Gateway IP, have some undesired implications
compared to an NDP poisioning with a regular MAC (see ARP bcast poison
commit for more details).

Since these MACs should never be announced, discard/drop NDP with
lladdr={bcast, null}, which prevents the broadcast/multicast NDP
poisoning vector.

Signed-off-by: Marc Suñé <marcdevel@gmail.com>
---
 net/ipv6/ndisc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f6a5d8c73af9..8fe215505869 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -830,6 +830,14 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 			return reason;
 		}
 
+		/*
+		 * Broadcast/Multicast and zero MAC addresses should
+		 * never be announced and accepted as llsrc address (prevent
+		 * NDP B/MCAST MAC poisoning attack).
+		 */
+		if (dev->type == ARPHRD_ETHER && !is_valid_ether_addr(lladdr))
+			return reason;
+
 		/* RFC2461 7.1.1:
 		 *	If the IP source address is the unspecified address,
 		 *	there MUST NOT be source link-layer address option
@@ -1033,6 +1041,14 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 			net_dbg_ratelimited("NA: invalid link-layer address length\n");
 			return reason;
 		}
+
+		/*
+		 * Broadcast/Multicast and zero MAC addresses should
+		 * never be announced and accepted as lltgt address (prevent
+		 * NDP B/MCAST MAC poisoning attack).
+		 */
+		if (dev->type == ARPHRD_ETHER && !is_valid_ether_addr(lladdr))
+			return reason;
 	}
 	ifp = ipv6_get_ifaddr(dev_net(dev), &msg->target, dev, 1);
 	if (ifp) {
-- 
2.47.3


