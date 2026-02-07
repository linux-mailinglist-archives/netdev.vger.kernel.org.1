Return-Path: <netdev+bounces-257773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePpQAKyjh2lSbAQAu9opvQ
	(envelope-from <netdev+bounces-257773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 21:42:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F33A107187
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 21:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAEB3300679C
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 20:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D833DEF1;
	Sat,  7 Feb 2026 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4S+6ejb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AD33C1BF
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770496934; cv=none; b=ANs79OpcLhDIAzDK6e3N1Wq568vxgO5oAZkbbmlYVHaFUW5rqUvmpt2l/gcehicx2/wRHOJ9Skj+chWNWGm/C5tLi4V13usqr78LMHba4Kq+P3jJ15pt1URg7kCcbee5RrsV+M2Q22hueXVz8uo+1hW2EWUnARJzg8L6MmCDRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770496934; c=relaxed/simple;
	bh=SgB+7X2J6q5nj+Tt37bKxUOLZy1yocZh1rNAXoGerNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pTo+EoNUpy+kwykJ38cXfKwWmrLayZ/3w7noWWKYZLDGkDDM85B7ZlYSqsk0dNLpkQRSCqSi+ju3WahQi9pDv73XjpQXyiQnwxcChJL+YKwU6NpLql2MW+l6TCGnxoSOa/e15upU0QxJBshuxaWuhlevDHPAmHFl8ZiQTR+Qkw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4S+6ejb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4832701b9b7so8664425e9.2
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 12:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770496932; x=1771101732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s47mbZuoXQzOwS1M5tDCGnLg5mGMRM/tKAbOh3BYLRI=;
        b=D4S+6ejb4ebTRLD65U7ft1kr88TKNBWgJrfiYjqFnXvpGUnDs7w2YCYnSkkYyqkz88
         BLUmVio3YQfr6QScd7y6WpUcVUf9jPAUquw+2cUQrUVkOPN4I/BHu1h/U/rJxHAYbvjn
         8C/K6+SJ2wnfeGwK88n+ZhltiuPmIFmlSRRDg+gTgCec4Un8aeeIvYaxAy9Fns0Ds5nY
         RGTiZB+ndnM+qk4Pz48nfpn9arumeQZTE9h6ETjsKzy2S29fsBlyOBjS1QcSRDquQoJV
         J3Lbn2N+pkWFu8sKyQeLKqnil9/6rEXOWxipPKsR1SAWGWQd1niqUSHeLJaVi18MLZLm
         co9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770496932; x=1771101732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s47mbZuoXQzOwS1M5tDCGnLg5mGMRM/tKAbOh3BYLRI=;
        b=w/Wx25Gv9Q4GpVJpcIT4/94fWstuuX6IqEs2StXijWQOsERdL4cuK0zA+jVV0xI+CY
         bBGvorQF6jYnK8K6vlsYWRv1Pe5pdnZciyF/Tc1OJ2v5rjGGZhXpEjBcLouUhqTkuhcI
         p2s70V4p/hg/SXeAbyLP8POPK/RJc0uDQJjbX+0UNaGhuJ/3iyLW/ZmaCXiJU+NCN8Tr
         ieiSI0Ymxj94uyb3jed6wj21M+cdCSwQNv160UCj87/kWq4d/TEDdNBUbWCKf+dy0rN7
         vW0nMOp6qSTdi0OP+kIxhi1cc9ln79plaDzRbLwPAZIHcaFS6IFpiArAb9mFNorLLCdr
         bGzQ==
X-Gm-Message-State: AOJu0YxndPaBTH928gEoVhdgavhFEtUPOeTpeUICDkhoyKfDaX0TXn2o
	vThnxPC2XpfzNibV0p0SU7aXTRIWTSXMuq1RO1yK5sshHF7mr5kKe5LX
X-Gm-Gg: AZuq6aKW02s7JbnNYhj2uSfz7UKy/a3ZJi1u/hikPCa8K1VUWR+IUtJR83IMKvoWzk8
	jLN3f9mfFhoebSyVYn51//eUa4/oxvMu0Hk8ERqbIDBtsPKADr58+Txy0w1ydPTnbuPMkn+po9H
	y/O1+dfu6FIIGZRdyjq/BELss1ENr/QzOIsIh1ZXrognjJNTKZTkkItmfa+vHl7doBnpaO6gQC/
	uHOva+BsfH7qNV7FqdfHLFnYZJCE/6qn5uGg/mF30woXArw5b/hRiNNMbk0A2PwRNwqst5QUGu9
	qZCNI0a4/J9cBmjdoH4D3SEW73ZoRxsa+y3flJCLfGtkEhd5qaN8EnDVPU9gIggr9asrgZVwvm1
	vZ+SxIvS/ljJNXGkmQpuuq1hbFaGRA7LJWSKbZ1rSCho4WY/r6HHRPIF50Fdzv9AJz7vT83fy9N
	q+l7uJNuWH9BYPcfRBgY8pNG8BJsJ+jPSZ9WTvVXRgsdgZxg8vJafsCTEXmTAAfal2rPVdP4R2y
	/RCG78O16sgtXqaKiV6ZO7wLlDqRiqLSBkuJ+q0lNKDWxIM+ye1GNLJGrRDRqbZl09ZHrwr
X-Received: by 2002:a05:600c:3b03:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-483201e3b8cmr90093405e9.15.1770496932027;
        Sat, 07 Feb 2026 12:42:12 -0800 (PST)
Received: from localhost.localdomain (173.red-79-153-132.dynamicip.rima-tde.net. [79.153.132.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a924sm324540145e9.10.2026.02.07.12.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 12:42:10 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net-next v4 0/4] discard ARP/NDP b/mcast/null announce (poison)
Date: Sat,  7 Feb 2026 21:40:32 +0100
Message-ID: <cover.1770399836.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-257773-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F33A107187
X-Rspamd-Action: no action

The current ARP and NDP implementations accept announcements with
multicast (broadcast incl.) and null MAC addresses as Sender HW Address
(SHA) in ARP or src/target lladdr in NDP, and updates the cache
for that neighbour.

Multicast (incl. broadcast) and null MAC addresses shall never be
associated with a unicast or a multicast IPv4/6 address (see RFC1812,
section 3.3.2).

ARP/NDP poisioning with a broadcast and certain multicast MAC addresses,
especially when poisoning a Gateway IP, have some undesired implications
compared to an ARP/NDP poisioning with a regular MAC (see commit message
in patch 1 for more information).

Worth mentioning that if an attacker is able to ARP/NDP poison in
a L2 segment, that in itself is probably a bigger security threat
(Man-in-middle etc., see Note2 in patch 1)

Since these MACs should never be announced, this patch series discards/drops
these packets, which prevents broadcast and multicast ARP/NDP poisoning
vectors.

This patchset only modifies the behaviour of the neighbouring subsystem
when processing network packets. Static entries can still be added with
mcast/bcast/null MACs.

v3: https://lore.kernel.org/netdev/cover.1770241104.git.marcdevel@gmail.com/
v2: https://lore.kernel.org/netdev/cover.1769464405.git.marcdevel@gmail.com/
v1: https://lore.kernel.org/netdev/cover.1766349632.git.marcdevel@gmail.com/

Changes since v3
================
  - Respin rebase on top net-next

Changes since v2
================
  - Target net-next instead of net
  - Use mausezahn for patch2 and remove arp_send.c
  - Kept ndisc_send.c for patch 4, as ndisc6 and mausezahn are not valid
    options (see comment)
  - Fixed comment llsrc->lltgt (AI review)
  - Misc fixes: shellcheck, alphabetical order in Makefile

Changes since RFC v1
====================
  - Discard announcements with multicast MAC addresses
  - Check for dev->type == ARPHRD_ETHER instead of HW addrlen in ARP
  - Use !is_valid_ether_addr()
  - Added multicast test coverage and renamed tests accordingly
  - Dropped patch 5 (scapy utils)

Comments
========

On `ndisc_send.c` alternatives, ndisc6 and extending mausezahn were not viable
options. Submitted with `ndisc_send.c`, as preferred by maintainers.

Having said that, I still think Scapy is the best tool for these sort of packet
generation, and can simplify - perhaps at a cost of some test execution time -
selftest creation and maintenance. As also mentioned in
../bpf/generate_udp_fragments.py, it's sort of industry standard, and is widely
used for dataplane functional testing. I've personally used it in several
organizations to functionally test ASICs, NPUs and SW datapaths.

If maintainers are willing to reconsider that, I'd be happy to work on
transitioning the existing selftests (using ndisc6, mausezahn...) towards Scapy.

Marc Suñé (4):
  arp: discard invalid sha addr (b/mcast ARP poison)
  selftests/net: add no ARP b/mcast,null poison test
  neigh: discard invalid lladdr (b/mcast poison)
  selftests/net: add no NDP b/mcast,null poison test

 net/ipv4/arp.c                                |   8 +
 net/ipv6/ndisc.c                              |  16 +
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   3 +
 .../net/arp_ndisc_no_invalid_sha_poison.sh    | 368 ++++++++++++++++++
 tools/testing/selftests/net/ndisc_send.c      | 198 ++++++++++
 6 files changed, 594 insertions(+)
 create mode 100755 tools/testing/selftests/net/arp_ndisc_no_invalid_sha_poison.sh
 create mode 100644 tools/testing/selftests/net/ndisc_send.c

-- 
2.47.3


