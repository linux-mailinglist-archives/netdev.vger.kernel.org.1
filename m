Return-Path: <netdev+bounces-296959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A3xqFKPLJ2pv2QIAu9opvQ
	(envelope-from <netdev+bounces-296959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:15:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C724A65DA2F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:15:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rkDZ6UpX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296959-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296959-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03ED33032658
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694C3E834C;
	Tue,  9 Jun 2026 08:08:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911E3E3152
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:08:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992523; cv=none; b=pGRLkBBLNmvaxoezLwgX958tukMOPm0Iw/t2i9YPrtkge31+WqzKD3oncvVR2odl+G5mcMoq9gkYM0cooz/6psh2AH4+wNX/jghxgkCxFJ0gUOnlYKRmT6BC8HSAVEzACu70JCoXlOGSwS/w6x00LvsN3RDGfBZWfUm/HERe4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992523; c=relaxed/simple;
	bh=pxJancrlprJPSbrDHuqyEvslmg5VVxVNpuuTV/xkQ2I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S/pmDv2HQlOF2d8AId16jgxSolzglthvn3iusWNxakEHZQs3vVHbEMjKT97nGsGMTs4vJhBeDYSfFU9jZp3Tymnm/IbpWs6WApAApmBEmrj7OP+Jz+OUZUhfP4pyhPOjwaWGhShOCC5JbqZGq2eLPgi0dM3iayG0ec+/66SuDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkDZ6UpX; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8ccf3d72081so74574336d6.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780992521; x=1781597321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9nWYC3dSWvR4KZYalL4EM8yGWAZq3uLiB7bAZi4rY9k=;
        b=rkDZ6UpXrqlp/gqSxzwajLD4ZwqQBvohg1Wm0b+gnokpFFHR8JGclYx5QsjQ8NmuSU
         FZPpd3fvBzXgvB51N5FiNH+kULP5XOBHWnVkD941tJhY6ACXu2CbEhgMYLUt7WG44gKT
         G1aFyZ00082xeFfSOe1kT6Y2e0kSk0p8SmetJLbxYCwTe7aqPomsChw+UVxjdSYjPzbk
         yiokw4b5A4r4NeNaJRs6HUeJab1uKkjnMQatfznJeD4Np064p0G8U71fNxxATMYFV1mJ
         KlIgh8FKB2lANTxt5MoxTxuNreYBvjQCAfKd9+TqwUtYM4acLdDdCd1Vue3PVL5aV93x
         8hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992521; x=1781597321;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nWYC3dSWvR4KZYalL4EM8yGWAZq3uLiB7bAZi4rY9k=;
        b=dximIf7KYalz/nToJIms2plCTcbbl7VVYpI3SEgcMfMzmnYQZHKLLEkFLRRzCdbSIK
         s0oEKS5wcs7bJicT4L029HLP65qjLZEvUE4IuAkRZHJaVU8kG7NNmUi5Dvc4+1e8duuk
         4CmhS1NARt8M6mnvrcH/+5uGdpkr3+yc2j3/aIPDWIoISXdEaO+RAWDUnIVLEx4q0YqS
         kOn+hddyPVJ6SKcaUM6X8wz6Qt0ET3JBpLKAATVinROxlI3jxGhMOptLCmC9QfxF7Oim
         JHoSKYtOXtZ6FqhTkWWcMGEolR8pgQAjd8kgh8KEf1ggjqOgOQbOXOzkghVNC79Wg7kW
         aiHg==
X-Forwarded-Encrypted: i=1; AFNElJ/IshsfkpnF6lzQEmplCNJ56ryi4f7vtydPlCUNX738OA7DzXXWQ29Lzmdf0XtpJ6vFWxl/OGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqOSI3PF+vYMTQGtEL5nBdkvEwjb8gtOCWYo6/a6NrmoJsIzv
	kCTdABGWdLnebzFqsNXE4oAvoFMi3bI0pOROrCzA8MESgY+L1Ek5KqTEDzSBiezZzTDFscbrVho
	ThRWpN0y2i2yCRQ==
X-Received: from qtqq23-n1.prod.google.com ([2002:a05:622a:8417:10b0:517:bf3:3417])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:650:b0:50b:4a84:aa94 with SMTP id d75a77b69052e-517959d5610mr278674121cf.7.1780992521260;
 Tue, 09 Jun 2026 01:08:41 -0700 (PDT)
Date: Tue,  9 Jun 2026 08:08:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609080839.2506801-1-edumazet@google.com>
Subject: [PATCH net-next 0/5] net: bridge: take care of p->flags accesses
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-296959-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C724A65DA2F

(struct net_bridge_port)->flags can be read/written locklessly,
and thus can fire KCSAN warnings, or real bugs.

Prefer atomic operations (test_bit(), clear_bit(), set_bit())
and use READ_ONCE() for the remaining uses.

Eric Dumazet (5):
  bridge: use atomic ops to read/change p->flags in sysfs
  bridge: use atomic ops to read/change p->flags in br_netlink.c
  net: bridge: use atomic ops to read/change p->flags (I)
  net: bridge: use atomic ops to read/change p->flags (II)
  net: bridge: use atomic ops to read/change p->flags (III)

 net/bridge/br_arp_nd_proxy.c | 22 +++-----
 net/bridge/br_fdb.c          |  2 +-
 net/bridge/br_forward.c      | 15 +++---
 net/bridge/br_if.c           |  2 +-
 net/bridge/br_input.c        | 12 ++---
 net/bridge/br_mrp.c          | 20 ++++----
 net/bridge/br_mrp_netlink.c  |  8 +--
 net/bridge/br_multicast.c    |  5 +-
 net/bridge/br_netlink.c      | 99 +++++++++++++++++++-----------------
 net/bridge/br_stp.c          |  4 +-
 net/bridge/br_stp_bpdu.c     |  2 +-
 net/bridge/br_switchdev.c    |  8 +--
 net/bridge/br_sysfs_if.c     | 61 ++++++++++++----------
 net/bridge/br_vlan_options.c |  2 +-
 14 files changed, 134 insertions(+), 128 deletions(-)

-- 
2.54.0.1064.gd145956f57-goog


