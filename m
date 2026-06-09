Return-Path: <netdev+bounces-297162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bs88JYRGKGrbBQMAu9opvQ
	(envelope-from <netdev+bounces-297162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:59:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C20662B43
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:59:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="IRi/wk1B";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297162-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297162-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E850830D1DF1
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C12F47ECE6;
	Tue,  9 Jun 2026 16:31:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00CE438FFB
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:31:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022688; cv=none; b=l6VCl3+iNeMTllb+FeqVr6LD+fFk2AWwN3x0D63oxKeh/wTbJF5MBrZz4Toh0BOxTHCAjF2tEF2cXbrKCvwluCgnAW99VePw0sk+ci/vlq1GisorJsumyTlhHvyXRHUIiwX+DeJLUCaTLYH+z/QmJAIQUp32sWO7K9MrmZRtSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022688; c=relaxed/simple;
	bh=FRg9Eu9QhiI3/I6NgMvgK88AoQP9jiLCzpjsRaCrM1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mv+Gs5wWTzC4SKcKERE8BQCLRl1krvQUyH4UopAVyZEc5UYdOSyMgV1bQSoveFm3dbrjHhyuGIYq77cVrHlSPqV1lcZkHc4ElpnbGf6x/FGjLyUwCQ7zLD8mlIfDYcJE12xcFoUfHTUUEKp+ckOTpt61tT0VwCZcmBmuZ9YtVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRi/wk1B; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c35980fdso58275065ad.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022685; x=1781627485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcMeU35QKR/m7p0ys0S4K0EvNKBoe36L4mK1QCkh7IA=;
        b=IRi/wk1BdcqaWByMeEt9Bxy7LMhrl9XIeNjeGyZAbrZxW+9XYUQxo+HZW9X8BJ1nAp
         W7eT62eBbGavrGblFHUcIqOZDSo3W36IjSnE/4o76RC9rTkKzgXMUZftnoUMZdc0v8vy
         xhtugYKCRiBerZ8HxvtH4lQSuCYwtKgDUtiMqXSzxh7sksTfBhvvsqZBfOrbOL1pT7Dc
         rz3zLVcB0Xub2xdMuYNNF1zf3SLoADyiavt+E3mCL6+sRC3Gof5ABENV80uAdZ14DVsg
         2arlVligUZV/xhKFoZKRFiYIIs1LF04ejjli/2MRPHP+4hAzNMD7q6ivbmJAOY9yKLrE
         /f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022685; x=1781627485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcMeU35QKR/m7p0ys0S4K0EvNKBoe36L4mK1QCkh7IA=;
        b=GjGgAAP0uAa5eQf6RUGhtJ0uUsrAYmBD/458c2P3u1JN/uvVmb3Odb6OpbE99aTCQ8
         MupKv2Ltc6ZO5WhR/LrOdOs1AtlXdM0tVN1EMd0Uu1rop5cmHjuxODGgMnvUn/kABtQZ
         NeRkQaMYRdAZ25Ki1Ddkgi1WjYxQTcPASqpPJiDQ/J2tYcd+UrNXlR+bYtRc2v04Nvlr
         mLWo+dIRbw+f7tHHtGw33SrR87H/JcBWNt88Vg5vUyqGQTy1b10Db+xqtC6vNMAuwQHl
         Dqohj2uRXBjmZEybFB7+uH3+LW9hO1nOZi5Kneh7NHV0RrPcXykht3mOdROptplmUYgq
         yWGw==
X-Forwarded-Encrypted: i=1; AFNElJ+WmtM2I47YUyWzLIpJbOd/eI7W6Es62aeBvDiOcQOCmVAoEi+eO+0wuEHzBK0ZqVVe8gMMH54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQRuKpM3vegM5koLH/6qQsM87s4qHRwbUUHr4F5Gz4EpC21vIL
	bUBH1VZXuIT6Z1/SqWRrrcYuy/K/sqLRWLHjliO2PbsNmuqFMqzFQQvw
X-Gm-Gg: Acq92OE7ghih9RbfhOSvmwcnu9axLjDPtfIYKImSnqLL+Iv4gj5ATNtirlmQL+Kxf5t
	znVpxvUAfJ9LSJMmCHTeD0Ar86fyj+/MOGI7N4Hyi1XLt5z3G2gzioU9PSZ91UL+IoRCR6QyB7b
	jhe1Lx//2FUm+5TUAYmBGUweKCCGCDgtSnIrKXWbNQ7tRFrDmVhXpHGeu4MOsZALX4eNu/YbHgN
	iM4vD226CJ2xyjUD94gYIKwHXShB8+U8YFRN8KwPutbQ+ivSxRr+WwK8O0KLpYvUAQzAg1eqvNT
	lz85tKbHdLlE48mJd4vkjDlH8drO3YzffaJ056pIMBnSNem/gl7My5j0pGpamNwlcC6OWQiSlLa
	OTelq/tWv6R3CEDknWzMz4G+PQZN0OfmOm3i01gWrEpd5dW/jWHN+y/N1wS8yRrT42A+YAzdDtR
	RzQHRfNKb97ozmzubmJ0Z4O+pn4xzNEcoeQBH0wt821r8b5gDyPq+R0/uM34IgQGCd2I2m3Q==
X-Received: by 2002:a17:903:1247:b0:2c0:b35d:ed54 with SMTP id d9443c01a7336-2c1e85e04c7mr245030845ad.35.1781022685002;
        Tue, 09 Jun 2026 09:31:25 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:24 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/7] net: ipip: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:05 +0800
Message-Id: <20260609163110.1717419-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
References: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297162-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13C20662B43

ipip_changelink() rewrites the tunnel in its creation netns. After an
IFLA_NET_NS_FD migration that netns is not the caller's, but the rtnl
changelink path only checks CAP_NET_ADMIN against the caller's netns. A
caller with caps only in its current netns can then rewrite a tunnel in
another netns and pick its endpoint addresses.

Gate the op on net_admin_capable() at its top, before any attribute is
parsed. The check is skipped when the tunnel netns is the device's
current netns, where the rtnl path already checked the cap.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv4/ipip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ff95b1b9908e..1813f6026e49 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -494,6 +494,9 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
+	if (!net_admin_capable(t->net, dev_net(dev)))
+		return -EPERM;
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
-- 
2.34.1


