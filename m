Return-Path: <netdev+bounces-298539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yku/LvnLK2q8FAQAu9opvQ
	(envelope-from <netdev+bounces-298539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:06:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C76780E2
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:06:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DOKCHOg5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298539-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298539-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FE0034C9F5C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054AE392C48;
	Fri, 12 Jun 2026 09:00:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D77376BEF
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:00:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254814; cv=none; b=g0PhleTT693HFKRxcWY2Su2H3ODKoPbH0Nddc/sK0kLyiD7h77AoCpWvkIpTAADTwlBUVFzC5hkgbGEBVXq5It61ph/qNAL3cRYjC0vhWps8Ew8V3gvE62Z+DdCtJctwHOoMCufTNYGd7un3qU655ppMr7JSD3gsEsGhZRnXxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254814; c=relaxed/simple;
	bh=b1Ef7m01SlvbqYksVxxjRq3JiNuZbQ9XJSkONcITG2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXkoUKfRR1p4y9nxBAVd5d9/Q2vMEYgtzPFq68+HqrVh8T3I/wM38yLj0sp9oa7Ex2FgkDebrmuC2E6+Ie9q49ho0OgO/wf9w3kFN+DCfc2SkWmPMnsoUqmtMflgjufMv4ciEF6b5klYoJecMn6QcrPnsh26DqxlopFzbHm+yqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOKCHOg5; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8434840cea8so371318b3a.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254813; x=1781859613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am9un3Mpyi4zgWESM9WSZJ/9n4NAc/vveWguadq2LnY=;
        b=DOKCHOg5I7armjSnAbMpt8BK47Rv2yrBNxl2tYtPPS1cOKZ+gG/uQZFsX6jnKQ4ax9
         sR87uv5Eecy3T7PNrBW1SvoeL0JWomXRiJVu+w6EqjpxrgTtCD2GTJU0Ybw+JFYzC1ja
         KFVuph7gMWhm0Q2XtiRW0uHGDK4cUKYDhDGUWqNIp2mN/5YheTVdo/QiPxHiFNVO0kEh
         +NlsCnfSwiIt068dSgex178uFWku7jKmYckhZ5rGU0EoGKQ9ZQ+HrRhxNUTRhbxggDY8
         9OkxuSrXDAHKAeCmm//1KYCOlIY3IHJycLUVlHiBJZLoabGtvbrhS4vUzz9M6FoQEjFP
         n3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254813; x=1781859613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=am9un3Mpyi4zgWESM9WSZJ/9n4NAc/vveWguadq2LnY=;
        b=ssSF14uf9l3kYA+BrOTopbbGENI6dG7ECOQnu5B35d89ZWaHMCvj7Awfmgwwvinkle
         Gu74u+Ab45Soc6FLzTyJtDuegTcpYLMeTCcAnSWG+BZ+whCJBzmiBIQg+pp2gTZ/R173
         n71XyZqa8n5qi8QGC9qCoKflwI/Y91VQUKKnaC2w4L0tP6G9hejvpUsv9kCRRLqzacrK
         EQByIUt5nrLEEv+MmtsTqd/SERuLXrXsf64xBOwTpmE1U5AowvTVILr/QNK09PbVrP1W
         9Cua69yq95azeJKVOWq02yo/inknI2pZenU/EbRV95iZ9DISSO4umCVoYAAqAqVysP9a
         lleQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HJACWyz6+PeXExvee7Qm9+3raPpwpnAG2E5uSaeo1oTEod7ihFDTXu4mqk64HC9hQYwT8s1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/RwJX5NxAG2ODtaF1VRWqj3TJ5zp7EuDfQPCzdXfLPaL/2C8J
	TAGVDkLZlGCQWa+JZ8c7BR1FfvdkxZp+Qz4LtOBFL+VsJCoivtIEnimm
X-Gm-Gg: Acq92OG8J1nV1VgxbeX6QVcAMYl3L/GZ/TBWChMEeHPNIhR3yq7dcYwVDCiakznsOfr
	KlqfUprvyemu4r4e+CVXNxECSjPPLu5RmeKKI/cAkRXxkQwzTv656+6rF5RdoBDIPugGQUkxXgm
	v/NV6NUD3uB0/F9DrX32CD5hBRRmiG02XXDWNNTOCj2gKnvgdQl/EzuRA+h8Df5oHdIZJ2NWjdf
	5Bs0YbI2t9TumDumqTFM8Np6Sosm3bERkYFJei9wDSWm4mpHpzs2jrkLLoC/1tcOKZf1LtdEQ8E
	kjh6oMuFLtPdAmowYSoAiiRECZVVBP00+QLDz/biT74xOOMoNtJyuY+jZGPT8QcTCJrelAtcGOg
	Onhsqgd6/+pkX7aFbOy1lss789mMBdqwetaMi4e58+234N4EkPRhu74qEZe+XXjh+ne+4yNwBwg
	R4UpCzRZE03MkEigyVQzyftsLgUqqW4fTMBlerrIzJwHHNnhSah5Nn86i7PG4=
X-Received: by 2002:a05:6a00:2354:b0:835:3f51:730e with SMTP id d2e1a72fcca58-8434cd24381mr2048514b3a.13.1781254812154;
        Fri, 12 Jun 2026 02:00:12 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.02.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:00:11 -0700 (PDT)
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
Subject: [PATCH net v6 7/7] xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:41 +0800
Message-Id: <20260612085941.3158249-8-maoyixie.tju@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-298539-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 173C76780E2

xfrmi_changelink() operates on at most two netns, dev_net(dev) and the
interface link netns xi->net. They differ once the device is created in
or moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in xi->net can rewrite an interface that
lives in xi->net.

Gate xfrmi_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/xfrm/xfrm_interface_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..688306bf62c5 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -869,6 +869,9 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net *net = xi->net;
 	struct xfrm_if_parms p = {};
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	xfrmi_netlink_parms(data, &p);
 	if (!p.if_id) {
 		NL_SET_ERR_MSG(extack, "if_id must be non zero");
-- 
2.34.1


