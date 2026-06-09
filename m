Return-Path: <netdev+bounces-296968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yx6MBXrNJ2oL2gIAu9opvQ
	(envelope-from <netdev+bounces-296968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:23:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF3B65DB97
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:23:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fudTXMYi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296968-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296968-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3617B30CAC70
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930A3EEACE;
	Tue,  9 Jun 2026 08:11:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710F3EDE63
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:11:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992689; cv=none; b=aIC7NX/BDK3c2lOjMaurYezSbLqAEEpplGp2wZYFzeWo0mxuUR2/zSIrw60G5+ndkQV95bAUyettr0kd30/jawVIHjJHh6uzZ5RnMA0rVAx0ExBj5VxYxDPDiCICUiDSVyCXJaGX2u3FwXa3hbZt5S4nQM3G13iiEzfpjjYjgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992689; c=relaxed/simple;
	bh=4hQPpl0d90ZZvVSCamul2WGAbYncBTkOCmKHo3zzSbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwDCrR+nMxZxuOxaNMhcyKxg+hUWqQRtXIRr7fJtjH6Ucd8he65DdwspSxKBeMj1G5+Qtp8/NSngySZn3ZGR19xC3JooVZlWV0Eo7HirM/ezLtS85NF6FHhbC6CQbai248akZYcWpemkqu7rRtaffe5ntKoLECGUlyZux03Lf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fudTXMYi; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c27fc587ebso7768885ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780992687; x=1781597487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kOW8cairnPNDZwhDetRU5XH5b7X0jV1m4mBKZLgJnc=;
        b=fudTXMYi3y+0XoEa0x+xexdssbS9PlWVxzYIiFTxsXGAK0UgkAHsbhxrQIUbjTg8kJ
         acfeEKB7ljPRD6jgHofow8k4Mm65qo3VHfDASIoLWNG2OubIf6RFQozSpJKmS+Sxu6Y2
         s5O6nFkOl1QKC4KmOl/ssC1+AsHet2vKs/bZMIWWE02zAnFsfp52xfgnSf86N96tNw16
         Xn4SGtSS9Tn65d53qgZPjnScE5qetChmlPEeQonAFVF5kTPqfUShz/edzGO2SgJYFwZ2
         gVQhEw06SaGug+PFq2N2kO9mZeHvkY2LChQjO/W/JsOcGABrR/u+5/fm4Rn3qto1K7ze
         qxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992687; x=1781597487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kOW8cairnPNDZwhDetRU5XH5b7X0jV1m4mBKZLgJnc=;
        b=nZSb2vmtMIjjIXHY4qsnDQ8pQ9HwxI0NdEzSE09c+YAEAsSPrSUVmgZ6dDqUlLMT2N
         pq1YN/qkk3e8d4SlrMxkEyibp8o+LjyXEpsgopD/+jg5GvsaR0hwA0HAPUSYi6YMWD/8
         Jf3+B8ahbJ4NMNupErSByqqWmFGqQ6Oc61McXFSyQ/Dg/JR5wZRcdLYhpfhtNKaXKyVG
         7p0dMTTeUUGD/Rap3Y8jWeCTFEhY4JUGzeyRZnxzYxZJUsIJDpE/QRl/4j96ewVnHLPD
         eu0pDUd4CgQlW4v9jyo2Eo7lKMIQwROEXzIssgKO3wDDv4FMVJFMqDMe6Y1kV7bMK2Dg
         /HOw==
X-Forwarded-Encrypted: i=1; AFNElJ92DQE0xDYvVWpD3pP5g1pqoQbH3t5mPc1bfa5GOiZGHVaSjxtA2gxtfGNzwjTS22E6OB8DCCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHMQitq5Wrh112tJReLz/Xtjs5ie7FpRe+u089xr0So0V9o6z
	qm3G+8t7l3so2zatj7XKaRy8IdVvWehf0Vhwejt9g4IEz6gjGUlIHrR5
X-Gm-Gg: Acq92OEzMIMvLL5SXWnPvmTB4DoYg7q2IBEuDbqimawc76rGxsa+X+468mF0vTNEXUZ
	iZiUL4d+wT8oT+XbjotH0Y2mp9O5Os4SBtNMWhda75WFnmGZszk3yl0Iewpf390eA3QlJbfQN01
	Mn35ieNG/HBVeISAtELgqpq/SeZHKpkwJtDu+EBhLygzqLiEI9I0msuW2cR2Y5f64Cz2ghPAXSl
	vG/PTaX9qotOByDteir2e7Qm9BE3MKgjsdU26gi5YbuTbaVNBF8ronI1cPwk3pMCdoxuFFK+0ac
	xhHfrOJY9pNwu5BSf7Lym4pLtBBhIAFxgIss883QhYs95RbcLsw2FPn91PQ5hYEO5dr5243VH7Z
	RPrD0/9dou65exEzVT3Hf4YHsvJ2rBLK2Vy7I37nYQF+fF8DV5IlY1+53vn6xlfjM65n5b7zZZF
	UsvmtkGty46Iwx+eIDdXNZnmAr0gSQ2iaRriZo6W6dhvOZz9QOt/FOtR32QpUG9Q==
X-Received: by 2002:a17:903:f8b:b0:2c1:566b:f907 with SMTP id d9443c01a7336-2c1e7f9199bmr232917195ad.20.1780992686632;
        Tue, 09 Jun 2026 01:11:26 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:2853:d025:c3b5:3342])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166391d53sm263000845ad.65.2026.06.09.01.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:11:25 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/2] ipv6: mcast: annotate igmp6 timer expiry race
Date: Tue,  9 Jun 2026 17:11:13 +0900
Message-ID: <20260609081113.7613-3-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609081113.7613-1-sigefriedhyy@gmail.com>
References: <20260609081113.7613-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-296968-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FF3B65DB97

/proc/net/igmp6 walks IPv6 multicast memberships under RCU and reads
mca_work.timer.expires to print the remaining multicast timer. The
delayed-work timer can be updated concurrently.

Annotate the intentional lockless procfs snapshot with READ_ONCE().

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv6/mcast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index bd3972730aa0..04b811b3be97 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2984,6 +2984,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
 	struct ifmcaddr6 *im = (struct ifmcaddr6 *)v;
 	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
 	unsigned int mca_flags = READ_ONCE(im->mca_flags);
+	unsigned long expires = READ_ONCE(im->mca_work.timer.expires);
 
 	seq_printf(seq,
 		   "%-4d %-15s %pi6 %5d %08X %ld\n",
@@ -2991,7 +2992,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
 		   &im->mca_addr,
 		   READ_ONCE(im->mca_users), mca_flags,
 		   (mca_flags & MAF_TIMER_RUNNING) ?
-		   jiffies_to_clock_t(im->mca_work.timer.expires - jiffies) : 0);
+		   jiffies_to_clock_t(expires - jiffies) : 0);
 	return 0;
 }
 
-- 
2.43.0


