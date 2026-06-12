Return-Path: <netdev+bounces-298535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JXCvJFvLK2qHFAQAu9opvQ
	(envelope-from <netdev+bounces-298535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:03:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EBC678081
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:03:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=B87sLIwZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298535-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298535-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E034B3449B09
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BAB379998;
	Fri, 12 Jun 2026 09:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9C37F73E
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:00:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254801; cv=none; b=Zy+GN8Y0TuzMBGAfmKfjDwi0pYlYny5DAydHqjB2rJExJTAcCZebQOnSFHb2KvJTi8+Jk5Oz7lA4ikbIWx0eDTe1y5XsOmKFAMUAHJ5s0kNsUlwlwO+cxmxNf5dwRrwBkInoa+Z4W0g2Fl8dDmQ3J5p/PtAqfqZGidaJyOXMiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254801; c=relaxed/simple;
	bh=jy1vx1jZE2D9hbRYBo6NShB0yB6/kvd5EH3YsBhiaKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWNjdgzdRHWSO74okG7mu59jak7G+JQdowh4MphUBa79cZ5LTcnEUm9OiHE8jsb1CpgK7y80lnw+sKCHRLOyc0p8gg6BkIIgeLG/P7eGo45Hn1ksfvlJ+X2ie9HLzpoX0ilDdC/3/nipIX5cNNz8WgNNYY/K3WtJj9rryDYoSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B87sLIwZ; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84230ab8857so401765b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254798; x=1781859598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrjKQOs/1vwJlEoW3BviCRwGf0Zqke/HPyqRXYkXM+U=;
        b=B87sLIwZxkIDd8OsdPk+FxxUU2FB5qIEX6ckCM0D2/KYaVsEOeqgYUVewODzZduYXi
         NGkOT2jw/vpBtWdJXb1l7ZUQRkQ0IMGnVD9fCArqGFgTAOwyWAFO2LiJIlJj4OhqOahl
         JI10MfIA231GW5bVHFMEEthHF2Zmc2YWp8Z4gRqCYVdLIPWs4BY2upfOmrpvvMdwDA/X
         2Pganai99bU+A5UnwjVpda1W84BE3Xx/w7KcuK2iXKpIkuqawY3jZgFS9wyzVfetv8Zl
         eUkkee6gPpPsgl4KPl+AlUQPVllcOnEAiZCpxCsvctZ+Tp+zGFMsvo1QE9Nej7IAzj0E
         ljfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254798; x=1781859598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GrjKQOs/1vwJlEoW3BviCRwGf0Zqke/HPyqRXYkXM+U=;
        b=A24OYuC6spPqtmOLFCpqzAWgWWtpk3P0etNQzdzEQI347xJvtYGkcbLuASFK18cyLI
         Q1kQliL2qB791Hi6DjyOZQVLf7t3yUCf1ez2fYbazMWxwXuxlNU2BI1kY52OfA5QapU9
         ODsJqUnrBJO0QnDb5afITPIwiPN7GpKWpN+NkupdSfvN/Jb9O4Dgt9sZcemeiLWOXt4O
         hzxHXSN/Q9W5ya0dfFITilpBuAOTw6anfoJ2yHhtvTFPs3uQ5Gv9mVANTJMcfWU1pOlb
         l2A7lKKQ08g7P/wOXbUT114/2W41QA6l6vbL8/d/ERAsw9DNvLjRAoYq5SD0UEOFh5a6
         GvVg==
X-Forwarded-Encrypted: i=1; AFNElJ+qkBU/HupzIP2GI748ArrBe7LMY7IOH3NCmD+2SuRW2M6IT3Truo9pxW9xKnavdZAN0uU9ip0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1afzH+kjh3PfhVEZG/kMexhSkvkbznC+ZmYPcocT4UQZKDbJ6
	C91hxtddmfGhbYfrWOOEiysnTMM6WDXKaooxeIQ8kgYXgjiKkueyFMC5
X-Gm-Gg: Acq92OFaID150IW0YXtJl66ZFJhLp0j2tnoOsAVmFASvZq/XrmmqFTsu8BPa1Lpzxi+
	kL/W0IXTJyR9FZsCfsNGJ5kqTpnhwvYkJqO/ll06682M4HqkW7EJMrNmPb7MpsCgmAQSR3Ls/tB
	rfoHMzcgy8Jfd42JwV+6JfAIZDX0ofayck5DFyN+EqxisvbeFVQjXk0fXEejUHdCBWt1vLtrmPO
	EEeTxHYavdWR36Z+noVfeMuq0niTP4c6GsZL+aJ2VZadem13gDeWwW3wroqAUmse0ZUxvls1LBM
	9KTswlfa2/zb36g9n2VWQ5hxmG20AzL09e2ntg0XYXybEUenVUZAbXFNZCnIrSrT1rOaNz10IyL
	aiF8vllJ7tOt4kwk3GtStx8YLII3IzlnhnJohTtjzGnzLBCoYBITs0pxtoj12pb0/uyfEq/baP+
	DwjYHCM/ZP3tqkcTxm28GTu4DTy9RJ1+78AC+ql8oLD2eRDYTn
X-Received: by 2002:a05:6a00:21c1:b0:837:e9cc:d465 with SMTP id d2e1a72fcca58-8434ce40744mr1961210b3a.20.1781254797743;
        Fri, 12 Jun 2026 01:59:57 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.01.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:59:57 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 3/7] net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:37 +0800
Message-Id: <20260612085941.3158249-4-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
References: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-298535-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixie.tju@gmail.com,m:shawleon@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,secunet.com,gondor.apana.org.au,google.com,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5EBC678081

vti_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate vti_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 895de9a3488a ("vti4: Enable namespace changing")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ip_vti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..3b80929994a0 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -596,6 +596,9 @@ static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	vti_netlink_parms(data, &p, &fwmark);
 	return ip_tunnel_changelink(dev, tb, &p, fwmark);
 }
-- 
2.34.1


