Return-Path: <netdev+bounces-262233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHHOKJ9po2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:18:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3EF1C96FB
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B6C300DDF5
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23001394460;
	Sat, 28 Feb 2026 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MR2IccoF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6B2EFDA1
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317085; cv=none; b=sBMAj7OV15cQO/eEtFIO80ASV4eweZu0th4TarE/HJ5rMxvfSLdiRH63Y2NoeY8AtsB5ia+4LoOmRGyBCdBvCdiSMDrD844i5OqoXIyl9ARMbFFrQR22qv+qtKj/qvz2MFQE9bUia8pA5cNCIArxQyMWdy8dijnebc78+j76bf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317085; c=relaxed/simple;
	bh=WlyI8z7ndEYwOJZOzkX7hBdQuuYDI6+GGTEdWz3+LdY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qbV2LPgs2oSxFtyylB0kERzk04YfZUPsPkPLJ7Le0W1Q3p3zMIv2HEq82YIZEtNR/vK5s5/yo/wej8tMC+H73cAu3/EGyePp+TGWzo/EMxGNuoll9hkN/JdbUbN/WEmTWY4erApnpTud060w9Ad/DCvvsE7mc7rnTqxGUOBvUIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MR2IccoF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2addefa321dso189252425ad.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317083; x=1772921883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e2FtRPfkAGfu5xJ16LAnDtxhnn8YtmTlTn+rPAZdp8g=;
        b=MR2IccoFOe54QtaAUikCVUnItr979fuMc0g5VtPx+Nkw8XWjeqQ2W0WvsDWFQvhb2w
         6iL41i/LLcjp9VhlCaAUAAbP1RvLj9vtGYriE2SHatHvn2X+bt2ewzmp4XzXgp7iFgFS
         ZEmAS5csX+NdNDu7XqBnBQD6WUlGfT5XAd7IIG+GDD+k3KTAAVlEcoYAU1zwtjqdoUJx
         ewkHknnavfncOjX79m2oXAgA+UTLIkckPZ4K4I2Hy7JRQfdNDPuix60leVQRRTQRgeNU
         39D3srQUqM49+dl9xmX9H/GelpaCfuSkTRCdR7b6xn0EWmfmihZE4G0ChXzbvtWuyvYh
         sBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317083; x=1772921883;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2FtRPfkAGfu5xJ16LAnDtxhnn8YtmTlTn+rPAZdp8g=;
        b=jb87LUqvBDhSB+wOBrrw4iTM1tJA2dEztvRQvMHAWRFfw9y8bJMw1shJi3C8FyU4gx
         YYz6OWsqxBK2UJiaiz+x33SIhseDQeiLjQ5Du0edhvr75ZAlct8EbTcl3LcsAf5T/zjU
         PZXY9IWSi8+z9UwaasPOVoSNUNTbXHi8jtRd7wPo/Cvu+YZ+9ujBJ90n9KYH2DxrF2ld
         Z4+gCHHvSxG5ifOHAHVo92lvZNoV065Ktuai8MOFsDlrGpYGB1Fgtw9V1sHitVxIJnLp
         J61+idaLIlIaMX6kqqtPx8ScXrBCawaezp3iK5FUvZe8evIqqmTeJqRJgEVyjI+4jWea
         iYSw==
X-Forwarded-Encrypted: i=1; AJvYcCVASqD7asgxi15lYKEuq3allDxkJLw33MFuUBoHO7U0sQasg7zhUDgtxPFNp6+AzedSygfrU9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bSQTAG9YIiTpUcG1NKlVCIZpGAuRFKBjifb7CVuUqBWI5SC7
	aMmcrqnZuq4KVw8M4RnGZNHGV03+b13WU4olgRgBF0KxKedvzr9l0DxoAzMSY5CVxhO0qt5N6in
	mgbcR1g==
X-Received: from pldy4.prod.google.com ([2002:a17:902:cac4:b0:2ab:b2e:5c27])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8f:b0:2ad:a9a9:4bde
 with SMTP id d9443c01a7336-2ae2e4b55f6mr73005755ad.40.1772317082981; Sat, 28
 Feb 2026 14:18:02 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 00/15] ipmr: No RTNL for RTNL_FAMILY_IPMR rtnetlink.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262233-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C3EF1C96FB
X-Rspamd-Action: no action

This series removes RTNL from ipmr rtnetlink handlers.

After this series, there are a few RTNL left in net/ipv4/ipmr.c
and such users will be converted to per-netns RTNL in another
series.

Patch 1 adds a selftest to exercise most? of the RTNL paths
 in net/ipv4/ipmr.c

Patch 2 - 6 converts RTM_GETLINK / RTM_GETROUTE handlers
 to RCU.

Patch 7 - 9 converts ->exit_batch() to ->exit_rtnl() to
 save one RTNL in cleanup_net().

Patch 10 - 11 removes unnecessary RTNL during setup_net()
 failure.

Patch 12 is a random cleanup.

Patch 13 - 15 drops RTNL for RTM_NEWROUTE and RTM_DELROUTE.


Changes:
  v3:
    Patch 1: Init @unused in nl_add_rtattr().
    Patch 2: Use READ_ONCE() for mrt->mroute_do_pim in ip_mr_forward()
              and pim_rcv_v1()

  v2: https://lore.kernel.org/netdev/20260227033903.3307272-1-kuniyu@google.com/
    Patch 1: Add ipmr to .gitignore
    Patch 3: Add READ_ONCE() for mrt->maxvif in ipmr_rtm_dumplink().
    Patch 10: Use a local list in ipmr_free_table()

  v1: https://lore.kernel.org/netdev/20260226023637.1335854-1-kuniyu@google.com/


Kuniyuki Iwashima (15):
  selftest: net: Add basic functionality tests for ipmr.
  ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
  ipmr: Convert ipmr_rtm_dumplink() to RCU.
  ipmr: Use MAXVIFS in mroute_msgsize().
  ipmr: Convert ipmr_rtm_getroute() to RCU.
  ipmr: Convert ipmr_rtm_dumproute() to RCU.
  ipmr: Move unregister_netdevice_many() out of mroute_clean_tables().
  ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
  ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
  ipmr: Remove RTNL in ipmr_rules_init() and ipmr_net_init().
  ipmr: Call fib_rules_unregister() without RTNL.
  ipmr: Define net->ipv4.{ipmr_notifier_ops,ipmr_seq} under
    CONFIG_IP_MROUTE.
  ipmr/ip6mr: Convert net->ipv[46].ipmr_seq to atomic_t.
  ipmr: Add dedicated mutex for mrt->{mfc_hash,mfc_cache_list}.
  ipmr: Don't hold RTNL for ipmr_rtm_route().

 include/linux/mroute_base.h                   |   9 +-
 include/net/netns/ipv4.h                      |   6 +-
 include/net/netns/ipv6.h                      |   2 +-
 net/ipv4/ipmr.c                               | 265 ++++++----
 net/ipv4/ipmr_base.c                          |   4 +-
 net/ipv6/ip6mr.c                              |   4 +-
 .../selftests/net/forwarding/.gitignore       |   1 +
 .../testing/selftests/net/forwarding/Makefile |   4 +
 tools/testing/selftests/net/forwarding/ipmr.c | 455 ++++++++++++++++++
 9 files changed, 636 insertions(+), 114 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/ipmr.c

-- 
2.53.0.473.g4a7958ca14-goog


