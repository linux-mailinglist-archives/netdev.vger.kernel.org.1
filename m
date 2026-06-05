Return-Path: <netdev+bounces-295850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4TWlEFflImq3ewEAu9opvQ
	(envelope-from <netdev+bounces-295850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:03:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A0764919C
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:03:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UAwJwzYZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295850-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295850-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CCF53054C1A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F43F0772;
	Fri,  5 Jun 2026 14:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB813FDBEA
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 14:58:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671494; cv=none; b=tutK9hdfaJhOH1TSeQo3BqnnqEyEZL7qZqqqj0dgJbj6eFcyY3+e76if+gCvq4McJLPwoSzSYtVcCebkzBujHt7ff8DCqYP8RJeODqtPXkIKO9s9/9x89W9YKsxV7vDkshTSUna433LnTAK/GoUfrcIJLGhFCS2AB4aTRdB+FQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671494; c=relaxed/simple;
	bh=g/Vf5S/ImH9NFAJ8TFesAonWYxBfyXfhedQepyu5x4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCEPSd/O+BXU04H7Muq3/cBNIIgi7XOfNee71gwLEPLvxGHu5RlJGisaxC78PYdjPCo2q6VCQrG/SL0g2j3GTZsd18/Li8Y3NtGY7bDoEG9DqfoNMFTEOZ+sGBwZyWp0uB+LDk64qwkKNf3AH+2XLVZCjHQpuWkooZzvknyk9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAwJwzYZ; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36da8439078so1792635a91.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780671492; x=1781276292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6llRc9O739ZmXHdXtpVluJELJf01erqJYXeZGoa0Iw=;
        b=UAwJwzYZ0v2xgArabsiWgErFmQVFXuEB+E9QobILKvEx2eZMBuV+A3LJBzjzXsRoyL
         8odLsqgTRVPfhY8ZIbQdJRZtaa2lGo06dCRZhLxV3NhJTFlUIltJzLcZyzIFb5GOjyY9
         RKsD86MUyMRHQkMhpP+lI4CtSXHbomDfMOWpALtC4p3ZcclhoEawcBdg20CcZ/6w94cn
         aEn9JQt6Z+xQxWeRc+m43867nDbX9WwjQAsFx3XY3D/fp/l1DzQZb/wNwwYQOUI8Yg98
         byGrgyFgECXcKt5sx0Kbq8zkYNd88lZy1yXwCk6HdOLWUlRyypYIzYWmiezJN76mWBO1
         JXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780671492; x=1781276292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6llRc9O739ZmXHdXtpVluJELJf01erqJYXeZGoa0Iw=;
        b=WA33tDdsuu46ePInftcdXBPjMbXxBt9GSgujloMJsEPZ5RYP8Mafg4iQ8+DCOm1J3/
         VdxSeUGpzb2zuYPYi+NyR1FBMpyMYcU/7F1fcZYDC+qRUVq2xdxQMtm1kyGTtrvudXPM
         eDPHr+Ifz+qPpF2ylKS5g8xp78VkVkcZgrsBJaCV4s881tqAltgeGCMfHlQketYb6ua+
         ulYe/1sealVmokyOOXDR5tagZ57tJh+/ZWgzwqEqHLTR9yzckfsXhd1e0BenKY0TJ47L
         NXrGOcpqiVU5o8XjWEvlJjXHJyb71+6QXgGi6hNVK6gHheqIIlhARkV++wDSkEqz9lEG
         WOng==
X-Forwarded-Encrypted: i=1; AFNElJ90uc/lgh1h+xnJ2QexRDpT+PExhzfuXa1dTOFbaXAZ7HGeajxvu0899A2YgRVjZBPqwRYF1HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxARq6CcciWVyjvQJ/X7+nxow2yFSz7FsBk+Ob/Y485xR4FkwXv
	JPNW6nzdoMPx8sg2+Fkeif7IPqMMeNLz55EjaZWxQyuaxKC/rZtT2p3q
X-Gm-Gg: Acq92OHT9h2ssWROArINzTyMN00s4jNOILd95an44NdRoY83JbUBI1X30cgGpW2/uMN
	rGqRdO5rp1ooxiz+QLFitF+6Yok2aTHJ/n/NeG7pdkIkvfZWTACLQxtx9X3nV78Fw0sj4P+YkD3
	Z2S11TrYfbcDjySXSfm4jn2fjcB/30tDh4StmZGxDVHcqdT8RcQljEjNWgu+0me/ZUm6Zcd3ZtK
	5tLHsr+bWor0WLv03xYr642PuRZHnXcSlNVZxk0x36DOTUke/mFFRK7GyC5qLH1a8v33CupGBLT
	qqCxAqqf5Jm6eg95B0RxkGDn34fvrA+ICGoxvYNbfKSHnnRCXik0LxG8XJHAPSZQr7aqbCjzyzz
	pAvJRItkJgDtfoOKOR1ukW64i4do7aIfvCkvMQcVLv2Ah2pvueYYPcj8wd4ndim/FWr7onRol4G
	PNeSyfnlRneThLJD2aF0G9RxOiHswDxbnzHZNOwe38BFhVf/dQYJsmKFl4bCoXljTqmkUAF0rht
	UI=
X-Received: by 2002:a17:90b:5827:b0:36b:a0fa:ff96 with SMTP id 98e67ed59e1d1-370ef1f2cdemr4307027a91.12.1780671492081;
        Fri, 05 Jun 2026 07:58:12 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:1cda:ba68:a654:c3cf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a28c0esm7058231a91.12.2026.06.05.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:58:11 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] ipv6: mcast: annotate igmp6 timer expiry race
Date: Fri,  5 Jun 2026 23:57:59 +0900
Message-ID: <20260605145759.59639-3-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605145759.59639-1-sigefriedhyy@gmail.com>
References: <20260605145759.59639-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-295850-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06A0764919C

/proc/net/igmp6 walks IPv6 multicast memberships under RCU and reads
mca_work.timer.expires to print the remaining multicast timer. The
delayed-work timer can be updated concurrently.

Annotate the intentional lockless procfs snapshot with READ_ONCE().

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv6/mcast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index bd3972730aa0..184e57469086 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2983,6 +2983,7 @@ static int igmp6_mc_seq_show(struct seq_file *seq, void *v)
 {
 	struct ifmcaddr6 *im = (struct ifmcaddr6 *)v;
 	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
+	unsigned long expires = READ_ONCE(im->mca_work.timer.expires);
 	unsigned int mca_flags = READ_ONCE(im->mca_flags);
 
 	seq_printf(seq,
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


