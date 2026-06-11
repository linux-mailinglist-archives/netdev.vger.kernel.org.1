Return-Path: <netdev+bounces-297960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9+dER5WKmp1ngMAu9opvQ
	(envelope-from <netdev+bounces-297960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:30:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF266F092
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:30:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=tK2ojUVp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297960-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297960-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F4931D686E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE168360EFC;
	Thu, 11 Jun 2026 06:28:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0B361675
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:28:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159311; cv=none; b=SAuinw02kScfnUnjkT7W+hmct98YcSkGm6SL9iosEeCacy8gZ0xrkPetK+EjibVRxBadpGjj7wbnJ+Ixgz33d9Tub1mkttjQHj2wtwlm0V1hGYZGvKE4A68DYGsETzrALwGhNmNy5BfdHzNd/HGHUq6uKbmipP8oz6jibzIt+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159311; c=relaxed/simple;
	bh=+zokLVbOzGFitsw36alWayaKMRG+sHuntk6NcwDsdUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0m6ouVPmb9hbjJMcWduZnTsSXBnJPGnVM3AE2Dwn9IfuqceSOE2uPqNrb950ga5ygjqpCDb6Umo3m4UbojOVpliTWpvZ+UYs7bvywlDrsDbqTMbRELfmHAK1F+gE7RL4My5iVvVw2ppSA5DOrl9v+PDKj2iwiyQYrOW3lF8iTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tK2ojUVp; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso52445465ad.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159310; x=1781764110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KFSPxWAI+mIMkFyj/SFPC1tnivbSRId0vdj8dR7c/U=;
        b=tK2ojUVpDu4IRDIpbOYqs89e0tM1s3W4Hj1RyrBfP/LBVG5FVnsKRZYHL8A09qw04Z
         gLzfEnfrHc97Df2Vymfhgi5blvNNrp9X08fwl5u8zGyXzLEc4x2O7W1C+hYTc15p5EOa
         s2pVS7VzHNyvDuDyYhvNyBx2EiiFj8aAe2gaedMeKHtkLuYT7++eYfTU9iW+v666Qiae
         MmNd6Tq7mulTi4Ne8lmgp4VU0JNk8PT24UyHrxYcGEtsEDHDM8e69Ppxku9iM6PT1XTJ
         8QXuQ6Edeu3JxmiquALs/gbXNhFCpi3WP7FNOiQ6xRKCIYC1mWoavUBh3FGpMFTnF3mv
         hApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159310; x=1781764110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/KFSPxWAI+mIMkFyj/SFPC1tnivbSRId0vdj8dR7c/U=;
        b=Y+ze9GYhhUdf3JOYJykjaZn6kBDJZP46enmm9TMpPywgQss1MtChqiVpRSqoepBmjJ
         NJseYX1DJcXGQ2dhKZJlbhasMbibvkdMnxk0ElrK4XXYH83AY4y+3EU2TJzbSa8P9vol
         LJlO18f5MiUjrUT5CElrDq6+zJaXKusw6EzJTwTdCS9NmwcZOt5ANivE+gau9QCnMI3r
         hyKf1h3Zd6neESHYkNG5++odYEyC62BaDl+mvh6fGmRA9LxEPfY+lAJ80Q8c9wMSNkXT
         0aS1YSEoI4CuVao2xUEVs/Rm5sWeT0WjVPPwkECil71bx77nCzNuBTbaAQVrinPw++uv
         Igkw==
X-Forwarded-Encrypted: i=1; AFNElJ9frE4zKj1wewMb7jdHwvg6c4OGTEYHVHl4XDz97e9qIwdLacDqP5xmZWGVGvadiIWYOQx4P38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNX+m+Uj2u8WmbeGCUMuPBpq6diuj+s/x/1FAEalpmVCl+YFlL
	kYFOIwvLM6ryBaweuPVQehJixU4M9OSdS7JP4LUWMpUNkDIsaXiaqZV+
X-Gm-Gg: Acq92OFlDwgggyFqwg7dUbN/Te4DIQG0uT7eUg2AL496HgYrP66T9esYnuhP2uWh8WF
	OcakMBtS/jVdG6p7ZHMkDIpUi0PbGYIX9+OE7Oqmref25GRzwL6r5UxPWON2RacZwSC2hTRmxZj
	IUm0B+0nl3g/ZZrvMhVsLG1fWzgFwvRNVslk24JZfFr8L64IwcfmPoQcxz70QKmF8dfXljkAlc7
	teVfEwSZ1Tju4Q/lNBdSg+Wvz1nqk8PKHmccvP8ZpIX3yw/oQPLjfJmfw7QhrZhi5Ce02Gn7h31
	RAYqgembLdWrf1AsH+/+csAc2PtnhPu1yLWW4VOLYr3K0edWtx1pES8IXZPB1DAeCfXDG2eIOWM
	Snehi3TYRIbtjuDzZCAysTd6mpgzOTHObrRWhdTRuXoSm9k/3x57aDWabpQ7oP2i0/JAUrgFfOW
	NiEnPMrAuNaxMO5FTiSUgd01u3RdYPHEQXbtcSW/x1SllQtQANLH12CEKTn3E=
X-Received: by 2002:a17:903:2342:b0:2c2:bd0d:3cf0 with SMTP id d9443c01a7336-2c2f3c0376emr15193595ad.25.1781159309968;
        Wed, 10 Jun 2026 23:28:29 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:29 -0700 (PDT)
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
Subject: [PATCH net v5 3/7] net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:10 +0800
Message-Id: <20260611062814.2528793-4-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-297960-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92AF266F092

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
Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
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


