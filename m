Return-Path: <netdev+bounces-297964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sCiEKtdWKmqungMAu9opvQ
	(envelope-from <netdev+bounces-297964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:33:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EACFE66F0D2
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:33:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=m83IAv2U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297964-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297964-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE50C32A6EDD
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741D362138;
	Thu, 11 Jun 2026 06:28:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7A3612DB
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:28:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159325; cv=none; b=p4yunD+6iqkYIfd52kKHr7uU0R/lEiZMWx08kl+WctdAo2yYSekm/Y+8gZPuoDRyxPK4ur5H4ZnnADFa8sgar98rBiWYAPupXYLNpIHV6+fdquWukiS+kiIR+4KWv/dqc39sY8XAOkopC7EN5lVAbh2cRoqcs/SEjSMMjsQM5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159325; c=relaxed/simple;
	bh=OoelfBjirpw9i5/nYFRVXtU1s8vRlWtNC7c2OJ/Xcy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qt5yQqDZoslLyDkBy1kJtLBlZKiyYjCycwKaKxuquhbfNG/mT1ht13QM083kGsM+S9/KagCVG6dpfh6A2hO4EWVe7yV5f0HiX57Q7Zt5qyAjS+M0PnCTe8+8jNA7ixkYP8CO5wYqZTKoc/8oQjPu2Y57fSxWdWenyrmD0wgLPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m83IAv2U; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c379e8ffso52414015ad.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159324; x=1781764124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcjSCvdX7V7R5w3yb2h9bVTz3y2HJ7/ux+fWYyG6vVk=;
        b=m83IAv2Uy1PwbWpelTHT8+XCon/4hW2aB4XZJdCuoz2oYouMJME8fXgiaZqF5oWR0E
         IMe13KD9+PJU2juy49NiQx+YuedNAht5KQZineLefRA9Lageaa87d7WDXlZsJSxfVG3v
         V7xckKdkAWnyU0bh2gm4sBP6p4IXNX9X8xUkONp3NPwsZ7d58pqEljZ2hQOvFhgk7wif
         9gPznjd3N/Ccuwk+BCSCnRj4Tv7bqUn+9ZfAEftBBh1Z/9fzZGeUo1VR/4IXuuOW5uW3
         vEFaP3Dm6NtqQb66tGrO8yAdCaZohnsSwuMrw5ujlkWP4+YFkwfd959e3JehG7zlv3B1
         cb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159324; x=1781764124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RcjSCvdX7V7R5w3yb2h9bVTz3y2HJ7/ux+fWYyG6vVk=;
        b=ViLfefG8w5Ao6zxQzIu5rYbXx6uFSKH6CWjuLwRpk+JlEWhlTuPdNN5ohDqWjTJDXX
         2CTA0e86Fyest49aPNsSrPiWmrwnDmExwTUIrlH0Qkh9s9vB/CFxedc8pq7u1vM5RRqd
         ZXrk4EqgaVFnybrvwCO4lLRUPZ/7kIeVQHP4Wy4Mpoi98SRw9NU6RTn4IqGV9b8AyOQa
         /rXj7SLtENO0ze3h+HLdEZn0tn7KraPQ2B637lw5WnemTdotZMox4loRNEObCOxC6+rO
         gkwuyt/MTSqHwk81ECG1FadhL/QkjhfKeplI78CMblxpfY1rc8vd/w9uuXcJO34Inti1
         iYow==
X-Forwarded-Encrypted: i=1; AFNElJ8u3EsFQ6/fKfnT+LSiYzgY0inUKRwxzk7a+XykclTxaq78fKvC5FnPvW1nEDlHSvmC+PBqYVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYpQqN80aaR+ODSinWzmhx7RFtvqx95IEYTz29ttpbdzw0gGh7
	rFA0kUEPSbjSEnB8qNdik5rkDLaWtdoQlszmsKZvC8ZD8/hqffZfl20O
X-Gm-Gg: Acq92OHJwOh9DwZAf4v9EKYcUWNfY5ox/lsZgDRNnxtKjViech/ZBFepmvNs14ViKtO
	reoDb4j+I84PsOutzFKZ1mAiKca0BqQLvtyXBEh+EyCjxPV/WbN973cDZP3vqsjY9SaPW/hvNE+
	/QCXTSRBEfCSdh9qVLHfdzsZBWA2rMeLy6FFKixqErxEXWm3Q8rOHwxP9ZqQcluc7IQrfudUdk8
	gp0brqosGnaSkI4062r1BcmslysbbuzqiICY+7vHWpSr/wgGMNQHSmLvfEnoMA+Kv3n1XBEKsVa
	krvFsJaafiK2XPbw8l+fs1LkKhvY/JSikVoLet5VSK5KDPllpf7tvuweY3HBxxTnjggxlCina6t
	+mFuXTG8f7UGSSRSs3ZX+KboVv0ObeQw9LYhUZGI2i7t7B2WJ+4bCLt+KZeIv/60ds6uL+SRuts
	xUFyqh2kOk7kKHxQoh7wsKF4iYyKk3b3P9jqUwGaSWC6PRmLcVxOToSjoHAMw=
X-Received: by 2002:a17:903:3586:b0:2c0:c3ac:4af3 with SMTP id d9443c01a7336-2c2f229d856mr17512785ad.15.1781159323849;
        Wed, 10 Jun 2026 23:28:43 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:43 -0700 (PDT)
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
Subject: [PATCH net v5 7/7] xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:14 +0800
Message-Id: <20260611062814.2528793-8-maoyixie.tju@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-297964-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: EACFE66F0D2

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


