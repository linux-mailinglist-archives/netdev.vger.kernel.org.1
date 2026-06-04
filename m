Return-Path: <netdev+bounces-294983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CH0aMQDEIGrZ7gAAu9opvQ
	(envelope-from <netdev+bounces-294983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:17:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB463C062
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:17:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sDgQZqx8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294983-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294983-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8B103016525
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C21199D8;
	Thu,  4 Jun 2026 00:09:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1322C2C181
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 00:09:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531748; cv=none; b=qKgxJtY77NCjzxSwbwujo+ayDShU2/Hut177HsHmCFHopzepC/yJbAII0O/TzPT+gs+0WBwjdnK/pc3QmE06OQHucURovx+S5UJjFRxfnDYb7iWHeeADFWBVESxoVmr9FUy/EgvS8Xfv3m+zQYeQSAh73eHp2Q0C9hMw4Ox5eN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531748; c=relaxed/simple;
	bh=84IYQMKG8viKCKRjmktbS7+OnIvgPuWpE6/gR4jV9OM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oSGIGjURe4/PQuPUWjlOMAGXsRqrUwcGnB42q873KM3i6uSg5omx7Kf6uVAC1fsWKy1+LZ8Z17wjeA3tXBwy48Uyn7v4ltuIv9Sw2n8OKzpol6WBRSnqULGCT1/7t3VMVsASixVswO5mWsJSGM5LbUYI3et9KZ2ZA9NqWhaIHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDgQZqx8; arc=none smtp.client-ip=74.125.82.178
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304cf518c9dso81361eec.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531746; x=1781136546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6h4FMlmT+v4RZFFdPUHJsy/yl90YP4Tu1Yv/uKfivvI=;
        b=sDgQZqx8sSzr+fNBCIZ0O5NYirzVn5utT7f4bnPWZzEqrV6CGnDn10VSg5QEAUMBrB
         aX4AeuDa8pcngStwfcelXS/HzbsnCYh9jFEs/xj+XsNuF+gwtvv3CzMlFZK+FpRr0QXM
         gVd7MEoOGDN4hYfQA1LbZ/tP6ssRd1RLnwLyp7ioFpuc8YlzmsoZCF9LdJDUTp/Ew1Ka
         IDF3IdHNsGnfAp/9Clprv3nZUOr5R65PlyNRX6YZJ7rw9a41oZS35JHrdYB0fOfH7TLt
         orevdyEvkF2WD+9kV7WBIX922mPf75zUHokE8ARkAMHnHK7iKeK/En8JRkySSjQzb90O
         fpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531746; x=1781136546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6h4FMlmT+v4RZFFdPUHJsy/yl90YP4Tu1Yv/uKfivvI=;
        b=XNFBX/UWRXgLt68nJIFlBvmR8zUMPYtKjmxNNknwldsCPIX0ilYVn8J/xFDqTDsNV+
         Lw6cvzzjl+w1FPnlhmWgoDsBeX1tror7KtgByv5At3AM3MX1lC8SwW4L1aZNl415Bd0X
         ONS7OQ2pPcE1Wtqm30NnISEQxoiD/81PbqPkkHC7fXpDkLwJLcYtGWLQUfLQwluVILPk
         bMiKcPvn1uS4xXJV6QJ+Pl/hSvhlmr4xKIEzk1aFfQu/nKTmyqWaiOSKO/y6QsgSp8Rt
         +LdoXxd7Zd7DQfkym6UM/62PvPjmp3VmwVECeCxp3N97APLrnovyDev9OuwtpXgSQiCo
         c+QA==
X-Gm-Message-State: AOJu0YzJf8ADn+GwhqhlSdJSao/p65dA1cIZGbv2vGy48/VPFtlNoiuy
	4igHQOx/kKsKaPa3+vsC96gDdnnkdtSiLesLSgQ0oSeNNcYogkbdAG/qSa4Y+gFJFkQ=
X-Gm-Gg: Acq92OHGKatVqW5OKwrjPhXsK4GSLSfW6JBnJM6mIvg/2yjgiG7BTTi/Tcmbj38k16K
	LnPrQYCyCebtdWq8zSmZNxi/dFAv8ayISfNXzcW3i75CqUXKSqN5eilMiZR/WhmK97+yeghbfVQ
	/INVDXo0RhQD35g2kLWyqd55lcp9ZYKuwzCZke6yEfH6l72g81BIrEYcCL1yM37dESZFCXDiJBs
	2ggugyys78S335e/5FtkqR1ErFg5OqUAzlX156QNhKLvwb82VpyLFlCq+O81z+0qZZ4GoAkDm4N
	TfQij9/n2AW3n+cmf2W017bJ77eN5sxTBVbb21xFprMQyvDlU1Hb74hcUbFPozb75M0n2n6CKbY
	JmGROVYkKY+4a6H5DDWfbIpgmNqY2pCjeebF0Jlz9k4c7JtatPq47XAeDOA7ePk5oEL2iEflsGc
	9VWjre5w8cvICtLUZSwHmtfdx1bQ9g42BN4pKZdQ==
X-Received: by 2002:a05:693c:25c5:b0:2ed:e14:7f5c with SMTP id 5a478bee46e88-3074fc2c6fcmr3041864eec.32.1780531746082;
        Wed, 03 Jun 2026 17:09:06 -0700 (PDT)
Received: from ubuntu.. ([149.88.30.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm3534373eec.24.2026.06.03.17.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 17:09:04 -0700 (PDT)
From: Santosh Kalluri <santosh.kalluri129@gmail.com>
To: netdev@vger.kernel.org
Cc: Remi Denis-Courmont <courmisch@gmail.com>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phonet: free phonet_device after RCU grace period
Date: Wed,  3 Jun 2026 17:08:43 -0700
Message-ID: <20260604000843.4028467-1-santosh.kalluri129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,remlab.net,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[santoshkalluri129@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:courmisch@gmail.com,m:remi@remlab.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[santoshkalluri129@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FFB463C062

phonet_device_destroy() removes a phonet_device from the per-net device
list with list_del_rcu(), but frees it immediately. RCU readers walking
the same list can still hold a pointer to the object after it has been
removed, leading to a slab-use-after-free.

Use kfree_rcu(), matching the lifetime rule already used by
phonet_address_del() for the same object type.

Fixes: eeb74a9d45f7 ("Phonet: convert devices list to RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
Acked-by: Rémi Denis-Courmont <remi@remlab.net>
---
 net/phonet/pn_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 86325b7fc1b6..ad44831d6745 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -108,7 +108,7 @@ static void phonet_device_destroy(struct net_device *dev)
 		for_each_set_bit(addr, pnd->addrs, 64)
 			phonet_address_notify(net, RTM_DELADDR, ifindex, addr);
 
-		kfree(pnd);
+		kfree_rcu(pnd, rcu);
 	}
 }
 

base-commit: f723ccaff2fb72b71ae8a9fd283f0dee4d9ae7a3
-- 
2.43.0


