Return-Path: <netdev+bounces-303097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sVYNK3KlQ2rleAoAu9opvQ
	(envelope-from <netdev+bounces-303097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:16:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5179F6E3761
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:16:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=c47CNE0w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303097-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303097-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 006B130254B1
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD3403E82;
	Tue, 30 Jun 2026 11:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B653F8882
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:02:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817338; cv=none; b=tmQ+5xILnrDNkrynyTn0kjls+u5GJpFjR7HxqiH4f5PUjDj/CP6qEcORxxFu049OsTNqptoHqJw37cqKmNL8B54B7gdMzzSM2wCMsZluMqRcfp0kVNL6eYop2cTnPJ6RJXb6P2o0AfsrvToB12WuNjvFFpd+12nAhUG31rI5x64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817338; c=relaxed/simple;
	bh=Ky5CE7imFLCL+LdihcagyThlg3g5Kbu9v3WlDuHEhs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/rb/a/z9+9W2nOdSrUyxVyUez3byIJmq62AwQMiDtfGGT4DQnoo/x8c0Tz9gzrIitJGFXe2xVtKQ7zDgGr7yFXZp/zbVyURG7loMaEq0m1BlFxkMVt7EvYX1LO/baq4P8UAr5O+xe8WZofBzG0XM8PRbdFNYf6L98RF32WJRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c47CNE0w; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c82538b6c0so25904275ad.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817336; x=1783422136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSwj0KKZ3DW6Npk2hIc1aOdKUnyuXiuy56Baluf8DAM=;
        b=c47CNE0wW9lwaR1bBk08Nf7moA7gPX89TYOevEeYgtunKL7IFZl9VTaXhGyb+hsNHp
         8dOmTW0osJQ0eUn6MXWjGCr3MPSAqPmGLr+ib+ZpZhO5e0PXqgRPf8a+vZHLZQJKunKp
         ku3FTU5WxMIu4GpbWLTG7hYyGk5wWhgAT7t849gwsXBPMgd/mdpk3LOjanlR8KjQUVxy
         mhGf72BklQznZ6/OfRSBXTUbXGEtbaycYT4zP9sBcczeU1lSEeGbEvMPI3euLS+lbojc
         JcDcUEE6djhn6VMi8/DKTEnCL7bA7ZS2xEsdxnrtJ0bRdq6mGvB5gwmdS4CPHqTqWVPu
         Tw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817336; x=1783422136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSwj0KKZ3DW6Npk2hIc1aOdKUnyuXiuy56Baluf8DAM=;
        b=V4/z8lNJTezzbyNrnaZ2ApAH0JyF7OJcDdEoHltkHu+dp7PeF0snfrjEsgAabWd++c
         NadlbMBAv9kwjY7rEnebbGjzcYq5ayI7P0O6oTqUtnxh2AmmxJ2PM4fPmI4b6XE9Op7m
         8bQWVsQYY9J85NkoJjql8B7mZ5Hojqef4n6apvMXlxCLMb5tpVhxSfW759rDG5rgU7tn
         nmbbCpbTBxxPPUJbPNEzrt3vkiI0CN1rFRDc+tDUE3ZLN/5WDv9U07vr3RGE5QZPmR1F
         FkRESeH+wTxlwWRaXLKoHwFkdSvn/kgUooxnYH/bLeVwrmv/pHgAvh51znun6eCljYzs
         4nlA==
X-Forwarded-Encrypted: i=1; AHgh+RpJpbS1iDO5k5SegRID47KvBUFL7/6GJ3V1LxmHihNL6mKkum2jkHv8IWp6YA9cYj63TqjIEbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxojyBbZ2Qp03cCxqWe09yVK//R5bS99KHJi9RhoXSRJa7zKZ0q
	PwVb8f4KLKjfJy5XQiK9CZ6sY0JahfEnXiTBRFQ2WZ0X3lef18FwFJCF
X-Gm-Gg: AfdE7cmAlbsdDyrZUU1CHbnp0RAP4BSEI24eVAZ/ZI4L6jIryMZeaAYePA84W58PFjv
	BQTWIPucXYzesiuSVWt5d5EMJGpuKdqhqo7hJzb7uPifb2rnr9d07GxIoEwPBCEEnW+H0dTzoJR
	NwmW+Zk+TXDIWRkZI36APNoO+YFCxEBzQKMEW1tzQyaN5lHvGNJ3so6/IFbOL5jQmxtUV6B9wvP
	O6P36Nn5wEZe9Wdf9z/5dWGeW3mvpYHvF/t1U3NijThh0dtyZuTYW/t9jV+SbcHLY5w2xcj94M7
	hisULhoJGuoeb47Hl96it56pMsNJvSh2lh0UowAg7gSeKd2qOUgZULtpw2q/vXfp+mGbB6ID9Wz
	hA2cn08bafO/QCGW+Cu6fLJXvRcX/ue9KcArJLL6L7cnjmcTSXggP93yMo8sTJLFTZtlI+r9ukz
	tgkcL7Rl74SPmBL2EByyCjF+aPNYcb9KOOCU2ZSCz4
X-Received: by 2002:a17:903:2c08:b0:2ca:6c8:abd4 with SMTP id d9443c01a7336-2ca2ea18718mr26189015ad.34.1782817336111;
        Tue, 30 Jun 2026 04:02:16 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:ae0d:35d1:dac9:a0e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a701b5sm11455265ad.17.2026.06.30.04.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:02:15 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] net: report multicast group user count
Date: Tue, 30 Jun 2026 20:02:04 +0900
Message-ID: <20260630110207.37841-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303097-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,gmail.com,google.com,nvidia.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5179F6E3761

RTM_GETMULTICAST reports IPv4 and IPv6 multicast group membership, but
does not include the per-group user count. Userspace therefore still has
to parse /proc/net/igmp and /proc/net/igmp6 to obtain the Users column.
In particular, this prevents iproute2 from moving "ip maddr show"
entirely from procfs to rtnetlink.

Add IFA_MC_USERS to carry the user count in RTM_GETMULTICAST dumps and
RTM_NEWMULTICAST / RTM_DELMULTICAST notifications for both address
families. Update the rt-addr YNL specification and extend the rtnetlink
selftest to verify that two joins increase the reported count by two.

Yuyang Huang (3):
  net: ipv4: report multicast group user count
  net: ipv6: report multicast group user count
  selftests: net: check multicast group user count

 Documentation/netlink/specs/rt-addr.yaml |   4 +
 include/uapi/linux/if_addr.h             |   1 +
 net/ipv4/igmp.c                          |   2 +
 net/ipv6/addrconf.c                      |   1 +
 net/ipv6/mcast.c                         |   1 +
 tools/testing/selftests/net/rtnetlink.py | 101 ++++++++++++++++++++---
 6 files changed, 99 insertions(+), 11 deletions(-)

-- 
2.43.0

