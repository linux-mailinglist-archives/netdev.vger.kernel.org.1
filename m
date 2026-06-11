Return-Path: <netdev+bounces-297961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MDJIKEdWKmqGngMAu9opvQ
	(envelope-from <netdev+bounces-297961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:31:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AC966F09E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:31:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kFsqbGyW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297961-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297961-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 863073209A72
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408003624D4;
	Thu, 11 Jun 2026 06:28:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8173612DB
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:28:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159315; cv=none; b=K2sU6vCFrtVeTJ2/14kholvIZTxPZZxx59QlBXbYWeyLkQ77N78ZSI2ksahLWpBM8eq7rCuGABMSudPPEwFH5Mf2wqaYsbrI/dHkdcexV0bzDy4V0tiPyeOepUMn9D2LzmDRvwemwsu0L/1ASUrAeBYp48qsKftQXVg1xJ25kNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159315; c=relaxed/simple;
	bh=qq1AC8mmu8ksZN9y8lKno5QGVHkBTEEHkuTf+PQy6l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNRGK2CQer3RKIrDfytvynvYqyY6eB2sKFKwA8MHCa3p/zFf19cSnWb7IOLM1DABqW76Qk0Ouvc0ZIs1ufMYa6Peax3FnhcAAT+NP4yCdz1lzQDcOScQ8PIaz1BBt6TgwQkWBfD52bgagmXAdfsWO3T4RaBGM4JwRDsjxfNHsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFsqbGyW; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c35980fdso74692515ad.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159313; x=1781764113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiSEDdFXwp4wzfKRu/Jr/XvNkOP8+EYI4EAvAyk7TiQ=;
        b=kFsqbGyWUy/RvdRacJBJHxJ8FBnhw56U50nwFxBnSWyLiF7LC/XCB9nJtVYNkWzzIo
         +EZGsZNGSa5fRgj2JrgPCAul3QHuNJCZaUQJQCqQUIANdkKUmfU5AFcnZi+6OhuazLh/
         fLEQbQvjeo8yj4rs4kJeGyPh4p74ydB8wu23bIyA1AYXthjZjKlwFcDqJGO97S1Zumyh
         oOZG1KPnQEnHTRIG2tcYkih2A/mft0fynoLtwsHy4/+0bwhC7nQestCprEMm4Co9d+s2
         T7PcDmAbLBbI6eqLBbpA7laYr0CEsunWtdL5b53z87xDp4aoMemmYEnWT1Kppp5f9pu2
         xSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159313; x=1781764113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiSEDdFXwp4wzfKRu/Jr/XvNkOP8+EYI4EAvAyk7TiQ=;
        b=pedQXwbqOWej+7dOyAw+b5QutHblJR8irJDZjC7Q6QlVi9PWZxYHw0FZkF4ilRl87J
         3BrIno0cM+Ox1RqrTYZJQwiFlUdPoho/71ZWOLgbNuRL0xlKytzZDLBmi8pYVSwxtKh5
         TBgZ2LMKJbUJ5tYTplYBlIJoyvBAzf3pSr2QewWfWu/46BBCAgohU/eO1ZOummf+NS+5
         BAyBNcEKSg+odWcj7rp7Fj2STxrsypuDVFswdwfLhtoeayw/VKLuUbMoCIOBLO3bsKIy
         JZmC+wXCn3FTvDHuRplPD0XcJ9Pe4dWGvdXnRFf1AruXx4VMznrpj/6BzLNoOdoKAWYx
         38Ig==
X-Forwarded-Encrypted: i=1; AFNElJ+Nm6m/fbNPlP0HRQ6eu+xI1nZdAqGYrWDKmSxqZny20pv3fczOr7SKaPV6tOx2ggdmWI9kW2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVL3jwR2VA5Y+pMkmR3UTegwT/ydeGPpAu25Ab1SprFAcXMjY
	eNOzqgMd0z4rCh87wua0ICPLuq7ekhjSS29R2d8vtEGCan/rWr7dwEG3
X-Gm-Gg: Acq92OHy4njGpa2YJjq6o4wyY7w1B46aKb969Y0ICIHhRDrF5nWo7N7tPK80Ta1c3S7
	nMzjR/CGQjSnbhRLWZDvePd+CYyu8PG6v3RPw5podemocCxts+vHhIGmljC/3/TE5diDfgKZsp7
	nCLjiwW4AmxrjuaD4Xy12DgYIYl6Xgmu3IOIStCbfhpO6BAoNCpHaFzkOrkPywPECplEPD55B9X
	Pp1cO2oCj2a4lUrJUcErr05A7/v6KrPGTGnKLtNCZekh04LkxPuX4CWdDuFQ0MtcH1KJHkbmWKm
	8Ewq7Uc5VCp9nKYellO+NcigJu5BkT8LDUEMS3YTNPOx19n6QeOJuyfyrPUVaLFsFm+85WfQc/y
	Ndz/GmfRvX6tOc9waCTn8u8Ho2xa7jba2YP2t25+8t66x8Jr3HCdaCbRWToAR7R68HP0iHaqfem
	/kxdeJdOu+zioWmmxBKF4QESghXsGaKMJaBqFcZ2e57gHWfu45ie589O6okFI=
X-Received: by 2002:a17:903:189:b0:2c0:d097:51bb with SMTP id d9443c01a7336-2c2f005b33amr16117395ad.1.1781159313422;
        Wed, 10 Jun 2026 23:28:33 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:33 -0700 (PDT)
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
Subject: [PATCH net v5 4/7] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:11 +0800
Message-Id: <20260611062814.2528793-5-maoyixie.tju@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297961-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: E4AC966F09E

ip6_tnl_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ip6_tnl_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f..922b0feaddf9 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2102,6 +2102,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev) {
 		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
-- 
2.34.1


