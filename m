Return-Path: <netdev+bounces-297160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UV3oM8ZBKGqZBAMAu9opvQ
	(envelope-from <netdev+bounces-297160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:39:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE4E6627AD
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:39:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fveSsuS5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297160-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297160-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FBE43045E00
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1DE4014A5;
	Tue,  9 Jun 2026 16:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46AB3CDBB7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:31:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022680; cv=none; b=cRz4wR1GctMyu3iZZda0E/uWfFzddPTVnfjEM6iYYELwxxH/fV3qIUz+ogoS6cHA2iIkyHeWSJZpXLFjC/aTAUqmljL/Ltg/QT+zr3v/d7exFPiJ7Z6FdSL3SM9xIR9az4gKYsbGZYbVdaAlFaopwmWqXQxNFZbm2QG4pkCV8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022680; c=relaxed/simple;
	bh=lcw6o3LpcRWYiXzPRd7yr9iPF3eQBiSsCn+z9STO9yo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JhxxVLvcFED2jpSbdKv3HZMAHg50OnCFB0LkBqHhZeIuwyRQoxQ0//Lr2ObJj7x5eS0UMFSqIG+ATiJMll7GlRU2s7UUYLzBHbztsmTxvJ7yHRi+e+mmxIhtnVRcIgREMmlxfir/Zgg5KMSUfVkwIM3c9jLtY7TtPZ/9iRI8aZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fveSsuS5; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf125989f2so42618995ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022678; x=1781627478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gIZvWeafMBWMTEFvk0iicarP7tjLAo3+syklIyGGAE=;
        b=fveSsuS5bhu1JNVl5HVStxGcL6s7cRMlH6gNmSMGhr7DC5KvdmMlWuJmhkXr5cr5CC
         khKdXSk1iAhQ/mrKR2p9pS077ectn7dVBtY5GwWulYwtmIggouK+s+CNJbmnrP+4LgrY
         +As5Q5q/Xcls8H1iwZ69k7EtgxXAiSPjsZGefoY2n1OC92t0hN0dFMnaQzFFNrfrJcCn
         hTyzhDF9mDFvgscwRjxfRfLtIQKGhAP1UyOsks3Pujg5kILFqanoDdszUCdddKSv00ck
         pD2shozy7dYp5hrKzvHiPOkUbAIY5w27ZoakkUOOoQoVnZ+Yg+d32RhnnkA2GtBnXkkw
         gMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022678; x=1781627478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gIZvWeafMBWMTEFvk0iicarP7tjLAo3+syklIyGGAE=;
        b=X+6421ZVrQYCctcjKIwuOxHTJfhMH5fHq5qYpmG+9sC/sMnLvrL1Efd7q7UWBfBA2f
         zlevBrOTfDMyC39Pqn4HnFEIfl/ee/LsBSMNw05z4yAtn1riinu9AsyJXFgDFPSueXsG
         TT+MaGnFfYn1UYEhf7+edFpSDi8cnPd/hoJB/85JC0tCM2evUOnQiyBDYC76/ynOD7Cc
         FS8D1pwSML1Vkk798JjSa0/Pwyfx7tpVJB9/3S/pWlcikHGgRZURBYuSXL09tfb96te4
         1bc0ps2bCpS2xyPbuL2CinBabs6UONhEa0qUmcsU6Aqq4lBSeQ5zgty7LwhzhOVPGehM
         2B1w==
X-Forwarded-Encrypted: i=1; AFNElJ+X4obJqf7q63fv3XBOYI2ovni6l92FMIgFCC/zgp60qtUUMWLMr17KeO8NSH9nrqIvONf1Sfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84ACtpUNb/o11Mist2wtOl3AhurntwZcVSaYp4ymy14cnar4W
	fP54X5MflOwj1cxeyvEoK5EDvc+hn1iuoUlPxKtZ7GadrT8DL3e/y5KX
X-Gm-Gg: Acq92OFg//+dGfVHk3NuCcMHSrkIb5KvVY4NSXTyTMqbxOFdUMs9RLodR3efBt6VhZN
	CXdTe0SLDpgHQd0plJQOlwMFu1yssvpliKjxty76o3TmuaBBOi6y3uQLnkZC04tIAb0sRCYNfkn
	qAck3ArU79yO2G27ZTaQT+OQSBTajRSKJT+FExWQG75X/whzbSk3VIKyGKph4tPuXpbQRe0SzWH
	3LJ7bLxb6tle9NXnBABcrGneuNv//4n7+tCVcCCWl96eWt3STm82JeHK0/2sRB8k7qhvAqNiw7W
	DrVvXOneb4RMRkG1kU1RbSw1gF0MsDM2WHjVGO7DI9gVA11Iqn9XxifFe37GiufcYeq01A9gjd3
	SA6oN3HrNQlcHm6HcGC9mvddAzBkbhDiVOxA8jvKJl6oP8iVQ6+RtJ5faTl0bx2x2ZoSVYU3ZK2
	v8pfGRF7BMiBXSByLM2Mf4DOXVrhuc5ks4nEWfM6PgPrdFzLSsMvWDbtkpgb4=
X-Received: by 2002:a17:902:c947:b0:2c0:d2a1:70b9 with SMTP id d9443c01a7336-2c1e776ff40mr256666825ad.0.1781022677662;
        Tue, 09 Jun 2026 09:31:17 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:16 -0700 (PDT)
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
Subject: [PATCH net v4 0/7] net: require CAP_NET_ADMIN in the device netns for tunnel changelink
Date: Wed, 10 Jun 2026 00:31:03 +0800
Message-Id: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297160-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EE4E6627AD

A tunnel changelink rewrites the tunnel in its creation netns. After an
IFLA_NET_NS_FD migration that creation netns is not the caller's. The
rtnl changelink path only checks CAP_NET_ADMIN against the caller's
netns, so a caller with caps only in its current netns can rewrite a
tunnel that lives in the creation netns, and it picks the endpoint
addresses. Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
vti6_siocdevprivate().") added the same check on the ioctl path. This
series adds it on the RTM_NEWLINK path.

Each changelink is gated at the top of the op, before any attribute is
parsed, because the per-type parsers can update live tunnel fields first.
For example ipgre_netlink_parms() sets t->collect_md before
ip_tunnel_changelink() runs. The check is skipped when the creation netns
equals the device's current netns, where the rtnl path already checked
the cap.

This is the same fix as v3, restructured after Paolo's review:

 - Split into one patch per tunnel, each with its own Fixes tag.
 - Move the repeated check into a helper, net_admin_capable(), added in
   patch 1 and used by the rest of the series.

Tested on net/main. For every tunnel type in the series a migrated
fake-root changelink is rejected with EPERM. For vti6 SIOCGETTUNNEL
confirms the creation netns hash is left unchanged. Legit non-migrated
changelinks still succeed.

v3: https://lore.kernel.org/netdev/20260604125055.3254652-1-maoyixie.tju@gmail.com/
v2: https://lore.kernel.org/netdev/20260601034148.1272080-1-maoyixie.tju@gmail.com/
v1: https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@gmail.com/

Maoyi Xie (7):
  net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
  net: ipip: require CAP_NET_ADMIN in the device netns for changelink
  net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
  net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for
    changelink
  net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
  net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
  xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for
    changelink

 include/net/net_namespace.h    | 18 ++++++++++++++++++
 net/ipv4/ip_gre.c              |  6 ++++++
 net/ipv4/ip_vti.c              |  3 +++
 net/ipv4/ipip.c                |  3 +++
 net/ipv6/ip6_gre.c             |  6 ++++++
 net/ipv6/ip6_tunnel.c          |  3 +++
 net/ipv6/ip6_vti.c             |  3 +++
 net/xfrm/xfrm_interface_core.c |  3 +++
 8 files changed, 45 insertions(+)


base-commit: 0aa05daef7848a5ac11158949dc73cd741995dc1
-- 
2.34.1


