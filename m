Return-Path: <netdev+bounces-306966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MOFUNBToU2pugAMAu9opvQ
	(envelope-from <netdev+bounces-306966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:16:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 393C3745B56
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 21:16:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nkG6TpMY;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306966-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306966-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47BDE300C83D
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 19:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7F358378;
	Sun, 12 Jul 2026 19:16:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E93090CD
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 19:16:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783883793; cv=none; b=GsWGpqgZG3034tofbSZ22OlW7O3eluD/79Eq0CfbE2+aNK9LVK0QLdH4puY93J74kp0qk0PbJn+PyEmjXELjW/06SBj4mlE3YvYY/Nih99dCAL3KlnaDS81zWiCU+4tF4XZlNwtEQ5vaFnXMYnQ9uiiVhry1jUwq6rNq1VI0KmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783883793; c=relaxed/simple;
	bh=DJBwYwVsgPOCiwKIL01/cm5VStqL4G3HoUtXiwz6cU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qemj5BDwjBd1ZwtRTCngA0hyVJ3J1yxwPRJPQIAVjzbVnTe02wTXHH6t4jzffZr7r7Xy1uYkVgkHCS4wqEhPqw0mhXJ2PLSRnUfmQhopFTq4ueBXVaSot2D3mXknCXwRx4oEMPdT3HT+wX+khyob2yVcvb0PFNgZZdnUWLHlwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkG6TpMY; arc=none smtp.client-ip=209.85.215.182
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca88130e09aso1670532a12.3
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783883791; x=1784488591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BoTRrCxFYKoh3zbhLA1zriCt6azN6tlIA/01b51ap1g=;
        b=nkG6TpMY07QNHuIvuj0q4UwtABK+Igie10MFBDXmM1I/8XiVk0oYFGlT5fXxmsELtM
         oqmBoeVvShqTNkDVQDtWRcaBaKgmKm94jc2eWWd6WvDCs6qmMxdKALElZLEyvuXhF5NJ
         kJWHFK4BuFYexJgFL/CoIVx3WmoIoT5vfjx9WKOq2TRAogAWZ1XdwYJRRCWTF8gYibR4
         Sf4XSz9u/0d5ewc9daWgIdRRQXoB7nFZWvp0OhtLfjO0+zIuYMU7eWTcP9gsxZIQ4ivf
         UBb+aZFQQGLm5clHWZFIWACTwCZf0zIOqVqb8f/JzTCIBorn07rDwrrNRwrUllRQ9Hq6
         XWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783883791; x=1784488591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BoTRrCxFYKoh3zbhLA1zriCt6azN6tlIA/01b51ap1g=;
        b=Vqp7v6mL/eMk8YxJ0Yg63J6c73WpMP1XGa7c8yA7ZBoX7fY3WlahfWGbUnIqLZ4cpq
         FX0CP0QPvv8bAjz1K8kUF1a6Zt/7zQ3uXkNBWXdBcCntg6u97smqMCGcLvPMdPQfNHRZ
         azVx6/qsRHyV5WskcjL4dPmV3/X/yOVx5sxu2Y07x8IrotMMR+HRPMmwZWaq0EBGwEO2
         TeQAJ552KUBXa3hhii+vIJBk4oMmTvn1aDIMoKOHMQmN7EI0bxOAeLcMtkKd+hRfR2MX
         AQjx2EMRB/6JIkiAACi/91rgud/S3MkrlagdDZwSNGUonWFE+auAxiztfkuE+m6F3tHm
         5lZg==
X-Gm-Message-State: AOJu0YzLdRRJWYXsJvTcgad6Rz6PGNUVrduwA/OHEQ6Tqy+VrB8pkpk1
	2TcKRTjRVmdyHwCLysmq0h0r7cLPOTWTAXooQR8az7/2DztwEwoscBNHH5sHVAgv
X-Gm-Gg: AfdE7cle3nNJ21nkdwfymwx7TJxujWLvREF/xTWtpjRCTWUvQuMco9jQKDFNGrWjuJs
	T2V+QRA3LgPjg3ykRkMwMkWmDaz7nRRKNcALJtjmJ0Gv2QDhuMTPaAvf/7FhTnnzswwdZVxZfHF
	/hY2wIm9Ua/9wVaJ6NRIsygCGIOJvv0D2lwDG5oN4i4b9vT54eCMImPataBtYROS+RpdPn6mxAi
	8BZyIIzPfYMglYOfiqgKV12QkjMEI6wypCnCvjlgta1qeiWlLlXuli/KkAZPV7hN+sLSjuSKIxE
	Bp/Jn19yjlYYbn8nxKngV0FabDB6S9akiAUQd0ULMiezrEAf93rLUxotUfDeMcUr4wMzgdX96B6
	MHhPXqijoV+Sz1vEYi2tKIOM5gvpQu2FeoUz2iL1cI2DdihSUNEttNEvvwF9E2TclIs5z2w27Om
	HyCh4Gws1uE2Q7A0CZ+D1pzk6tA7zObV3nSjl7dlnEEzzfeo0ghpsZFXUd
X-Received: by 2002:a05:6a00:4605:b0:845:e440:d0ca with SMTP id d2e1a72fcca58-8488963a140mr6089737b3a.8.1783883791030;
        Sun, 12 Jul 2026 12:16:31 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6ddc974sm13079371b3a.60.2026.07.12.12.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 12:16:30 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Ma <jack4it@gmail.com>
Subject: [PATCH net-next 0/3] net: nexthop: per-nexthop UDP dst port for fdb (VXLAN) nexthops
Date: Sun, 12 Jul 2026 19:12:15 +0000
Message-ID: <20260712191218.236-1-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306966-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jack4it@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jack4it@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack4it@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 393C3745B56

FDB nexthops let a VXLAN fdb entry point at a group of remote VTEPs, with the
kernel flow-hashing across the group (commit 1274e1cc4226 ("vxlan: ecmp support
for mac fdb entries")).  Each leg carries its own remote IP, but the UDP
destination port is always taken from the VXLAN device (vxlan->cfg.dst_port)
and cannot be set per leg.

Some deployments pack several receivers behind a single underlay IP and tell
them apart by UDP destination port.  To spread flows across such receivers they
need a nexthop group whose legs share the remote IP but differ in UDP port,
which is not currently expressible.

This series adds an optional per-nexthop UDP destination port for fdb nexthops:

  - Patch 1 adds a netlink attribute NHA_FDB_PORT (__be16, mirroring NDA_PORT),
    stored in struct nh_info and echoed back on dump.  It is
    only accepted together with NHA_FDB and NHA_GATEWAY.  Control-plane only;
    datapath behaviour is unchanged.
  - Patch 2 wires it into the VXLAN datapath: vxlan_fdb_nh_path_select() sets
    rdst->remote_port to the selected leg's port.  vxlan_xmit_one() already
    prefers rdst->remote_port when non-zero and otherwise falls back to the
    device port, so nexthops without a port are unaffected (backward
    compatible).
  - Patch 3 adds a selftest.

Example:

  ip nexthop add id 1  via 192.0.2.10 fdb port 4789
  ip nexthop add id 2  via 192.0.2.10 fdb port 5789
  ip nexthop add id 10 group 1/2 fdb
  bridge fdb add 00:11:22:33:44:55 dev vxlan0 nhid 10

Both legs share gateway 192.0.2.10 and differ only in UDP port; the kernel
hashes flows across them.

Testing: kernel and iproute2 built on net-next.  The control-plane selftest
passes (6/6) and a datapath test (two netns, tcpdump on the underlay) confirms
outer traffic is hashed across both UDP ports.  The series is bisectable:
patches 1 and 2 each build individually.

Note: remote_vni has the same per-leg limitation and could be exposed the same
way (e.g. NHA_FDB_VNI); left as a follow-up to keep this series focused.
Naming NHA_FDB_PORT vs a generic NHA_PORT is open to discussion -- VXLAN is the
only fdb-nexthop consumer today.

A matching iproute2 change (the `ip nexthop ... fdb port N` keyword) is posted
separately to the iproute2 list.

Jack Ma (3):
  net: nexthop: add NHA_FDB_PORT for fdb nexthops
  vxlan: honor per-nexthop fdb destination port
  selftests: net: add coverage for fdb nexthop dst port

 include/net/nexthop.h                         |  7 +-
 include/net/vxlan.h                           |  5 +-
 include/uapi/linux/nexthop.h                  |  3 +
 net/ipv4/nexthop.c                            | 20 ++++-
 tools/testing/selftests/net/Makefile          |  1 +
 .../selftests/net/fib_nexthops_fdb_port.sh    | 78 +++++++++++++++++++
 6 files changed, 111 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/fib_nexthops_fdb_port.sh


base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
-- 
2.43.0


