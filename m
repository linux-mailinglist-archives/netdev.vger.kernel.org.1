Return-Path: <netdev+bounces-256834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGbfHV7Eg2ncuAMAu9opvQ
	(envelope-from <netdev+bounces-256834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:12:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2CECF10
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 036D0300C91F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2C339B5B;
	Wed,  4 Feb 2026 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9NU/F8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6DF33985
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243140; cv=none; b=bFlUDEQgnmpyCRF2ybBZXTSaslv0XRP97tobKc9cGER9ZjIE/Lgsm3k/arbRKT9wr2hTPWAcv87mallD+SAIb/CYth+7tibtTNOez6hWLLPhm2qG0vyvlVn7q0fYXfVu3bcuzfq8bajiOFHznlNTvVpRfiukviIMSgVUToCQRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243140; c=relaxed/simple;
	bh=Us4/zZuGL8aAInir8lXDppXNnYn5ljBw1rEQ/0ZH1k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJ4fdRMCrTchbvmX83tbrGv2mx6ofQJuQqKOd9+pMEfn50bYvQ2z59F8moAcu8ACMJkTCcGUewypP7JNbyXmYwukA6X60e4KftICPYS+T+D6AcnmVP9MCkZSnX5tMCRmUI1VImtwI1l7kFaE0lePiyjdmQ3kUAl/7/uZORFlohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9NU/F8n; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4327790c4e9so94690f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770243138; x=1770847938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44/wvetjOFm9AgKooNkkYQ0Wfl890PA8mzqhB1+bdNE=;
        b=Q9NU/F8nbU96qa9Ak5ec+QIOoWNt7JflUKSd6ckAuI28M+SIVxJMN4gpf5KFiur2H5
         gMtyDvTcRwV6t9i0o/OUAtg9CEx9xDIrvrZGeSbKy3MKhBHSjUcywaBpUXOCOcfcTtLc
         ACuJZwEZbP81fQmo3pgo3hZZrW90CXBwdaLLyfGR2e1V941eW0xLPMLBCB00Q+bbNrIH
         jtLQQzRPJ+9pdmxKRpW9knyOoiWYCez+YlbHifKjoESHO4j6EWMjcZ10mgXu47EYrXdq
         DudPDDZoP0XodLy9LjSRLbWopB1hncEV1hTpuC7/haXVgebMHr/bUi+v/VqMhC0/Df/6
         000A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770243138; x=1770847938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44/wvetjOFm9AgKooNkkYQ0Wfl890PA8mzqhB1+bdNE=;
        b=N03M2CRKIL/qRLbGkt12e1shpfg/IuFyaNlksvYY92kuMUIRMGhCsQI+tRECqCUJ8v
         fWxjGZyi78z/KhYtG/XB13inuoDdkLWAyapJuVgo4m4cbCOkOvyxnvAgqixv7zPJCbGV
         4M8j16bxWdgL3/ZBl6cGjE5p3rKX0UpaED45R2+8524/0qjURGWF2YTwllWSBYCew59q
         XzlEnc9wmBUQDJPGJDmdjnHLLLKAo/8LCmVHpr+13RYNEAOA8xOr44mzpuaDFMgJ977Q
         mqrluarX6hH5wx2afCQJUDyN1AIH3IZNzB5Q6a9PQcSsWP2TQBsofQrQ7sGFXktQmzCm
         lkqg==
X-Gm-Message-State: AOJu0YwxYoY3VcwBHfErLg7nLbYKwA87rWNhPPMwKr4zcXMJyZOPZh4G
	wVGu5izT65F5u3CPccf13WrBKTr0pne9WrRGVaUvIods0GNX/6MiyK4GWlsAdQ==
X-Gm-Gg: AZuq6aJ/iKZdDYKXUeLn5TOH8e0PEQL1yklV28ZV6wBTWIE/uXoUz6uKNQXFa1h4G+r
	BEaipjPd5yzO2ADfH/U0U8YJljD3Hw6jwzYOTqOFXiDGkbh2bwAioaby/KET6MOR7WTimSLeINW
	OFh1fsyEfJcupi255FIpds3WnX7TeK1KNxOJ2tkJu0H6f5MTsTtmNONn1/7PRzGbtbGvkXnhkI6
	Q12AnWpLAsTMP+x3yJuLse3Q+cwmPnGpOsJBHWnKo87krFWzE7BNcrr04yZbMjU/7y/fzGtrlho
	L6SWwveXUxu0BaY7baIpHLLfP9xS1SSKeB3PgAc5gnnEQBavQ/y/Q8Qs44myK+qFIT0rSXV9J73
	4nCQY4qTuT1jM8J0yyRp5SUZi30Ol2MnTWCDBKIR+UPz1aIo9HHSvmaL/o3r8APyvryIhEd9Lzs
	0/i5yQK3LZCok+xrcarXNmweXJhy0xuseHRx0DytMrXfqhrqnOom7XA8r/VA/w0KXpNgRqE7Y2F
	ZBmYoeXmUjgt8E+LRn61m6ZgGwGKX72jFaBE6xt1BPwUHrMBZJwciRGGo2m
X-Received: by 2002:a05:6000:1846:b0:435:a594:33dd with SMTP id ffacd0b85a97d-436180594acmr6500813f8f.46.1770243138363;
        Wed, 04 Feb 2026 14:12:18 -0800 (PST)
Received: from localhost.localdomain (173.red-79-153-132.dynamicip.rima-tde.net. [79.153.132.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d47sm8327099f8f.5.2026.02.04.14.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:12:17 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net-next v3 0/4] discard ARP/NDP b/mcast/null announce (poison)
Date: Wed,  4 Feb 2026 23:11:57 +0100
Message-ID: <cover.1770241104.git.marcdevel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-256834-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAA2CECF10
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

v2: https://lore.kernel.org/netdev/cover.1769464405.git.marcdevel@gmail.com/
v1: https://lore.kernel.org/netdev/cover.1766349632.git.marcdevel@gmail.com/

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


