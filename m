Return-Path: <netdev+bounces-300331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uxnwH4mZM2ouEAYAu9opvQ
	(envelope-from <netdev+bounces-300331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:08:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D369DFAB
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:08:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DpfW2MfF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300331-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300331-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A399301653D
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7E3BF699;
	Thu, 18 Jun 2026 07:08:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C93C1081
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:08:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766507; cv=none; b=OoQSfLEQnqWigAOyDRI7ToWYpE5d0Fa9Ft2DGok+Dmxzxe6yHmP6unzojr5iwR8bT6uFxTV9f0zRB3zobJTXXKQoB3CbxWOPLhV49Yo7c3pKC+46CeMqB02vURQUXAYMOpJGDZPO9752Ybe78T5R/ImnYa7EXYAXDnD7Ot/rw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766507; c=relaxed/simple;
	bh=58uM3rtyTYGrJdql0JMPbfvW8pN6bRpzfwVAFqj/23A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qwTxxdkf2//h7HxBfwvkaDed2Qg8ieg+uZxWp1mX6xcxpvBFGb2eKCMSsn1XQhn83QX5hhvOvBZO657I59NFgjq3FpKLUKUNvEQ5fsCTm1dMiMsADtm2M/RNxbfyS8NP6v6CqIgEMu7U60YQO2ki5Z5cO55OcJniiLKYiA9sRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpfW2MfF; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84347ad88edso475956b3a.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781766503; x=1782371303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=py7sFiyEu3cLvtrXZwVU5OC7C9L/ey2Xp/3aJ9X4rBI=;
        b=DpfW2MfFsoKFQNj79hnZd/J2SbGupBFK/98C5qsLA7G9L+tpVqgDO/kVflyRVQAWEt
         2nq8CqXArnAC7Olk/t01L7PFEkT2VdLGeUlns9TUsTpTBDeLcFdIJH3Et8qdSDECKo9k
         VEpD75r1ZhsM0IRndNfas08hBDTVK+T3iRYh637JAfR4z/gNseyX30pLeFxQfcqeMtxf
         ZtJ6Aa/HYLUAdfImbfKVjeuWHOLWfajuGFI2E98XF/pBjC1qGAmqYMO5XZu+pLFC5Dat
         1dWDJ78OCv2Md80wR+T3IWCKYqNFuTaYLALbE/h4sgNLyccCcED8jwb9pmL3WfzB9se4
         Z02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781766503; x=1782371303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py7sFiyEu3cLvtrXZwVU5OC7C9L/ey2Xp/3aJ9X4rBI=;
        b=Y8E6HbSRCnraPrtHmEbAwp1CQt1cB7jOj7DzvdyAEcxPVKgX31VH2Ep8/XBF5Wal6L
         Aen6EnfzeSVzzuzYOjD2PL3DmaoV3YeZhqB6B7dITntBzikeT1vq/g1avr3ffcMtz8nK
         SB8MOI5h88ioD6X/uzXlVXSmdK/3iLC/nRaZBHqGOAb2sh+pjiTz7erJijxXKRys8rrx
         aShVEi8TmPYnjFKcjI9yborMlHK5khZyuGd3jLQcdntPbm4K1e7T9x/6ii1HMaBRjRR+
         dnCG5lCvppKzHyN3+Fx7Mgn/Che4CCuPuiJ7Wco9AgZlJF26Ybf4J+CI0EJitPnpEYji
         Um+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/TSJ9ZlA0/iYqrbIgCcZ7wouNewSkAdRO3o3DPpaQnU3CkKOiGFt1rHuEjO95vSPiHIhycsWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww4a6TAyN6Za+u0jKwAu5BJ7C1BnCD8lnQXQfUGmNJUUF71gxZ
	wPtmsYAp7Nqd8TebJNzhGRCI+4S89CkRSE/RK/D/rfhFdxtArCU5GyEZ
X-Gm-Gg: Acq92OHTQ6J4H2egNRAfq0zKoReuLj50EtBFo2CtDqgRqKAy1v+0OjPAIQypbD3lHTW
	GfJY0UH/avaNYidpvVP/Ep0YlDkLMQZLWx+UVs779AOqqWO54oE7isWopPGcPXTiiBeEJlFVuU+
	9uTeoLU9+cPi3heFtP8IrEYrY0J8UkELYvaaIWevAM3k/ZkjOaEyEyVkCRac42G2WG5mu4HQabK
	nMt9a3+5xdOIbaOeMlTVhUZVC1aCdAtL4G8MZcLHgJCn19/DgtLLHu1flWsKw+pKXaDL1TDtASW
	N2Dk2t61U1foS3mgqTWDewK8bqh5by41uky+cc/+MMwiLLJm6WXD8OCs7uj+FyXfu+757qitvYg
	m9DFjZwqupg16PEGVv+o0aHRqEJZTQNvkZEU6/021vgI2TBzyOQurKyFVitEtxkvaMCaRAM2VZ7
	M1eu5Dv+K+kusMTccwfu1YN9nHJyl8RmCzmn45jQ==
X-Received: by 2002:a05:6a00:298d:b0:82f:9407:d167 with SMTP id d2e1a72fcca58-8452457b4acmr7920016b3a.38.1781766503669;
        Thu, 18 Jun 2026 00:08:23 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84531dbbe7fsm3132263b3a.14.2026.06.18.00.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:08:22 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: sit: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 18 Jun 2026 15:08:17 +0800
Message-Id: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300331-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:nicolas.dichtel@6wind.com,m:kees@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,6wind.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D73D369DFAB

ipip6_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ipip6_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed. sit was the one tunnel type not covered
by the recent series that added this check to the other changelink()
handlers.

Fixes: 5e6700b3bf98 ("sit: add support of x-netns")
Link: https://lore.kernel.org/netdev/20260612085941.3158249-1-maoyixie.tju@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/sit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 64f0d1b..a38b24f 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1613,6 +1613,9 @@ static int ipip6_changelink(struct net_device *dev, struct nlattr *tb[],
 	__u32 fwmark = t->fwmark;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == sitn->fb_tunnel_dev)
 		return -EINVAL;
 
--
2.43.0

