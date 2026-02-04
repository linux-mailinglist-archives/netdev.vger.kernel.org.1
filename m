Return-Path: <netdev+bounces-256837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPwFKJHEg2ncuAMAu9opvQ
	(envelope-from <netdev+bounces-256837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:13:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04018ECF26
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16039302A046
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4612436997D;
	Wed,  4 Feb 2026 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKB9DZ0S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E9733CE86
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243144; cv=none; b=MPk6P/Iv6qbhP5it0aNNWPkChYZ43HvHrfSDoh40pi5kYiHLdZSlRnLHKjeANDGXVJ4r8cpGpyteA8j+ffgVakm/GBC8Mtsw0qvJrr9EZw0HM019epyrYBfnjAYMMfKBnUKemdwSYN5wxcLHGaBLRRRmBCJ6FmVi+N9jJ6Wgkig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243144; c=relaxed/simple;
	bh=M402rHWtYF2o2/AHtn14djiA9leDM7NWEWupdD1ZLUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXIFFSIWPviGQ0sZ+H5gdIrQon9Aov4NNlGqygxtaC/7lTyDKOHbRzUTS+YCtvg3rj3KWFClCNlSu6IxUCTlW+VM5XoVuW1U2vPrfqX8tbk/Z3XBd15Omodjk8an4rm6P8zMBiEkp66oxH+U6CyN5ZU0ljTz/acusevw5ZAkcAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKB9DZ0S; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432d2670932so153846f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770243142; x=1770847942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14GEL2PGdIEVxd35eZSj2nzdpJiicuQg6u5TFPsi6gU=;
        b=YKB9DZ0SOo+Trhby9qgvDpmFKQwkXiI2uxN8zUKo3/+89esk1v796pT4qc3z6PXUAl
         gtD2hzoffLag9C2oXAvVczJPeuSfeDCNzDFSutb729+uMcaAZ8Usk9U7S7uxZuEBeH4N
         9jjJiRtLYtfBE8CF/AguC/IaN7CF7D6ux5hsFa1ulMriJg97QQz7hyPxjvpozbrrk7xt
         lNz4gcYBROzhVeV5EeZCApnVn1OXZ0z8yUPGGag5tKx02WUCmUYXXDnN5i2H2nyivT+/
         v9R7bW6qhk2+E9F7umly8zSau7TjMSylJ4nyZ1coNb5CL/a+D3uHJQ1TS/+qKw1/xcg4
         /09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770243142; x=1770847942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14GEL2PGdIEVxd35eZSj2nzdpJiicuQg6u5TFPsi6gU=;
        b=u4NFec1rzDCOyUZLqud6iWlVrBCM+9U0sglirLUisShJMamiBdHQizUvdE311PC0yR
         m0Q3D6XTreVY8XCvM4gkJPb2wRbR2vpCeXobwWrC+fW7jXPDVGF52dPqh0sSNdYgd6fv
         oJ0zVt8WavrMFmLQhZJ8q8oYTxX2Pq1MX4NZx8QUuXy0rXvhDqwOWFSqiPsu/Q9R2bup
         CIsm05GRhWHePP5h8+5Mf0EIyx7FAWs3mNwPB0ocMKrDjL+8p8wFtFBtnqDnM00mSPXN
         +NmelwTMQPTbFalnwPmCAk9B7wEpt+NFk6R0pj4VIkzUV5wQC1/JRH4MW7d9macHUPlz
         zrXg==
X-Gm-Message-State: AOJu0YxbLcsBZqks+xeH0JsjDXlZos6Oi55/ttrmcPlROvItrLXcTv0v
	3WmEiDUGJywoSiV1aqccHxrqB0Roo+Vz0plP0oguW60BlYb76JWsbmA9
X-Gm-Gg: AZuq6aKLP77LNs9wb/Stqvr5h0JZBE+U96bKCuFmKwumRt5imn4VmXpSoEhMNU6Ww/G
	FCmPmx1mG2cqOgWk4ZAmya2jMiXnQBOdCdNs9hcDOBP++HyqwjGTfgB43qtfieivY+6cxjmx1cP
	0vnkgsfmBRnnXKr1GDhJM/mYTKth7OqeDDOj2qOgbanFhkYgcW0cXBEFD820FVs5W1gyc9zT9BM
	PoSxdfWJG0JeSvJTJ9As0oSvHghZ2IXm60ZjfqPNA6KqKKVlPFk+SiWYIHmVYS0ksVrth+lzK3V
	2e49Msh60KdkocnCG8vCk2v/zWdVfKeLfB95BQZ7WtCJlrlg/Gl1WTg4AaQ/o2nUDT6PmOueZFa
	L7ECboOltaPEKDQHMcU2wkekRstkdusnfNMgJ0i1rI8/XqsCxfzGK25uUvd27tbxE4uPGsF5cf7
	Ytzo/9Lzu6foY+wHchJP9n3IS66hN6am75O0ET8Afb9uUufIlxbjh6GJKYl3GZYe1uau+dOQEOe
	8NaqEPMpGgYbKM3LRabIxbeMbHTTzXf62iYP5qOdhUsLQrBQkEqUmIP9W1J
X-Received: by 2002:a05:6000:438a:b0:431:c73:48a8 with SMTP id ffacd0b85a97d-436180539afmr6709365f8f.29.1770243142245;
        Wed, 04 Feb 2026 14:12:22 -0800 (PST)
Received: from localhost.localdomain (173.red-79-153-132.dynamicip.rima-tde.net. [79.153.132.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d47sm8327099f8f.5.2026.02.04.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:12:21 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net-next v3 3/4] neigh: discard invalid lladdr (b/mcast poison)
Date: Wed,  4 Feb 2026 23:12:00 +0100
Message-ID: <7559e1e37cdf24c31bb2e0ab22bd18c3cfbbf545.1770241104.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770241104.git.marcdevel@gmail.com>
References: <cover.1770241104.git.marcdevel@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-256837-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04018ECF26
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


