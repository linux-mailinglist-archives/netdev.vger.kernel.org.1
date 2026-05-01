Return-Path: <netdev+bounces-283248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAlFFRXk9Gl1FgIAu9opvQ
	(envelope-from <netdev+bounces-283248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:34:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B24AE8E3
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59ACE3046532
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FC33112BD;
	Fri,  1 May 2026 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub+oYrwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7E309EEB
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656704; cv=none; b=bcAXqkaC+GTQSrrfsEMhMicTgG/cfVOjWa8SFJVFspI8OO6RZqRj50UOUnpbkcnsQXH/El3lssl6A1Ka8jfPQQQcZ9d6yd7N/kJ0ChAbEaF8qxzxlSW3nMjF/tpponmVS36ApxfBexbJr7ZNjx02bmlbyQMK4qzULjGPRP6qihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656704; c=relaxed/simple;
	bh=GPJn3apAiATfWozyMoTFurVezJt7ECoPiWTiUW2+1Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onDepB3+53KLI0fuEsa7b8PF+0eT8VTY9mE4WkEWP4vDFEjdqjTrfp18xZ9RK3XnEp2GHAjASLQXshU2ZiXFuU4Sn9SavxN72Uo7XAV+KvBI8kjcLWFFvdPey7OMihHkN3zlLHbDe1HwPHm7d4kCQHKfcr1ME7GBpHbGzyvcaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub+oYrwD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-364ef7a759bso539979a91.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656702; x=1778261502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMiYNnBeGWnD4tEnQiWJxALYagtWxwAZ6KTfja4eTyg=;
        b=Ub+oYrwDjLjL7rHLIiRLlsCo4a5rZ0k1TP9CiAdQFH1KEKltajlDngYCNKyNY4nRnI
         pT6tzbGJzrpVlry2kYn2k+rb0KiyfwHijfoGE5rXQhW5DLIQSZgXHs/xWB+d2TKvsciP
         7JZRs8pqkLllF/3syfqlRFobVjCvczZ8LO/X4iY7nwX9WZWr5zrpNZ0tJZxa+A/hYDYd
         wah+pG6deRHi6shzi8OA4dJPthLvLXdIfb6tUSpV2UOLIBpC+2o22dpoiBhsYC78+2z9
         IQ+wNeo486UPkqstQaLB6ujzLSrYB1Ud/GymfgxIZ0EniN2OiO7tqn+gdRfIjV6AGeyA
         gsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656702; x=1778261502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMiYNnBeGWnD4tEnQiWJxALYagtWxwAZ6KTfja4eTyg=;
        b=ZQwMTyEsSDMnEVqvSrIjHn5KYqdDy6nuPvNdKGGI3WfAbQ5R7oZuw4j/u08DOAv3G+
         nj6wDzjl4jwPA46SvNmD3OjamfXshKIB9F5tTjvu4PFYdrL2pufST2VkvYtDqKkEjjkr
         +m0LP2ylYehg56osQ9c/AC3sLqeuaBnR6joPIKAjv0d2mfFDvUfdHm7dRUrlCvkaFjMM
         FQz+pz+sLEOMuiKYuLlNKmXTPfzdgsWOCCvyZaLrCjyJRp9I4Pirs5T0/hOrGE3IX/ug
         n9x7k2FyuoEZv2agsJj7R1/y80hFKHFtkhgXFs+Cl1YeYXRNDJI2RXofzhRwdXEnIPKv
         MLsw==
X-Forwarded-Encrypted: i=1; AFNElJ+S1bGJyckpFuvqfDc33Xfarx7vhWa0kB02OTFN12ShaN3mti+/ik5yiafj3jJh456uzq7QNHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZjMyJt+79Ug+hQZYEAahgCr8vvyo79vmb1IhpIzCYEiUZyTx
	/J9F3Gd9MQq5qB5wmmcszRXAc4mKsxLEFguj2iPJ3Y4LVrnW036UD68tZt4nj1oOcU0=
X-Gm-Gg: AeBDiesDQqRc8k5p3gDoy8IVmtr1WqFbvUciSPnf4/UMY70TzE1NK3N9hN5uOHOp3Om
	qPth3nOzFuq2Xo9AHx4k/rCmKFysyHoKGnwo12b9wbmQpND7oxyL8MEdOTSerzRsbaYg/ZJAm3c
	sA6aU7I3C1rv1mP38JKYNKDfp39qEFnTBQM0AZ6emft0Q29AtZ66QZ0tSzv3rfX0kcldISgmTGC
	/cBrWUNa2RAKMtJfHp3M5SqxJAG4V0Sy/yLVsyPc3/fT4A3QFYfRzsTeIuK/oMm0ViawISz6fY/
	KfMdaCbhmwra3NnQ4MBmR2BjwV9AvkXiT6ljMJSfNWoW900SgUT7fOet+IpHm966T8N9RkFhDho
	KcA447Cm6TJxQDWlX+WC8OPM6Mht246XGg1poqBDpJO5+/MIYvCrzXzqur8IrVek2jI1jJWL6oH
	c4ioXLc7vzbxo2XxcqdeUWpGiFWY4VO3WNgcWGifMB0wzSOfSY6w==
X-Received: by 2002:a17:90b:54cc:b0:35f:c6bf:2bba with SMTP id 98e67ed59e1d1-364c49a1ccemr7557565a91.11.1777656701718;
        Fri, 01 May 2026 10:31:41 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm2908906a91.2.2026.05.01.10.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:40 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v5 0/5] net: bridge: mcast: support exponential field encoding
Date: Fri,  1 May 2026 17:31:24 +0000
Message-ID: <20260501173130.3486-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF0B24AE8E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-283248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Description:
This series addresses a mismatch in how multicast query
intervals and response codes are handled across IPv4 (IGMPv3)
and IPv6 (MLDv2). While decoding logic currently exists,
the corresponding encoding logic is missing during query
packet generation. This leads to incorrect intervals being
transmitted when values exceed their linear thresholds.

The patches introduce a unified floating-point encoding
approach based on RFC3376 and RFC3810, ensuring that large
intervals are correctly represented in QQIC and MRC fields
using the exponent-mantissa format.

Key Changes:
* ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
  Removes legacy macros in favor of a cleaner, unified
  calculation for retrieving intervals from encoded fields,
  improving code maintainability.

* ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
  Standardizes MLDv2 terminology by renaming mldv2_mrc()
  to mldv2_mrd() (Maximum Response Delay) and introducing
  a new API mldv2_qqi for QQI calculation, improving code
  readability.

* ipv4: igmp: encode multicast exponential fields
  Introduces the logic to dynamically calculate the exponent
  and mantissa using bit-scan (fls). This ensures QQIC and
  MRC fields (8-bit) are properly encoded when transmitting
  query packets with intervals that exceed their respective
  linear threshold value of 128 (for QQI/MRT).

* ipv6: mld: encode multicast exponential fields
  Applies similar encoding logic for MLDv2. This ensures
  QQIC (8-bit) and MRC (16-bit) fields are properly encoded
  when transmitting query packets with intervals that exceed
  their respective linear thresholds (128 for QQI; 32768
  for MRD).

* selftests: net: bridge: add MRC and QQIC field encoding tests
  Updates bridge selftests to validate both linear and non-linear
  (exponential) encoding for MRC and QQIC fields, ensuring
  protocol compliance across IGMPv3 and MLDv2.

Impact:
These changes ensure that multicast queriers and listeners
stay synchronized on timing intervals, preventing protocol
timeouts or premature group membership expiration caused
by incorrectly formatted packet headers.

Test results:
Giving results only from modified API vlmc_query_intvl_test() and
vlmc_query_response_intvl_test() of the script bridge_vlan_mcast.sh.

Using old Linux code, here is the result:
    - TEST: Vlan multicast snooping enable                                [ OK ]
    - TEST: Vlan mcast_query_interval global option default value         [ OK ]
    - TEST: Number of tagged IGMPv2 general query                         [ OK ]
    - TEST: IGMPv3 QQIC linear value 60(s)                                [ OK ]
    - TEST: MLDv2 QQIC linear value 60(s)                                 [ OK ]
    - TEST: IGMPv3 QQIC non linear value 160(s)                           [FAIL]
    -         Wrong QQIC in generated IGMPv3 general queries
    - TEST: MLDv2 QQIC non linear value 160(s)                            [FAIL]
    -         Wrong QQIC in generated MLDv2 general queries
    - TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    - TEST: IGMPv3 MRC linear value of 60(x0.1s)                          [ OK ]
    - TEST: MLDv2 MRC linear value of 24000(ms)                           [ OK ]
    - TEST: IGMPv3 MRC non linear value of 240(x0.1s)                     [FAIL]
    -         Wrong MRC in generated IGMPv3 general queries
    - TEST: MLDv2 MRC non linear value of 48000(ms)                       [FAIL]
    -         Wrong MRC in generated MLDv2 general queries

Linux code with this patchset, here is the result:
    * TEST: Vlan multicast snooping enable                                [ OK ]
    * TEST: Vlan mcast_query_interval global option default value         [ OK ]
    * TEST: Number of tagged IGMPv2 general query                         [ OK ]
    * TEST: IGMPv3 QQIC linear value 60(s)                                [ OK ]
    * TEST: MLDv2 QQIC linear value 60(s)                                 [ OK ]
    * TEST: IGMPv3 QQIC non linear value 160(s)                           [ OK ]
    * TEST: MLDv2 QQIC non linear value 160(s)                            [ OK ]
    * TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    * TEST: IGMPv3 MRC linear value of 60(x0.1s)                          [ OK ]
    * TEST: MLDv2 MRC linear value of 24000(ms)                           [ OK ]
    * TEST: IGMPv3 MRC non linear value of 240(x0.1s)                     [ OK ]
    * TEST: MLDv2 MRC non linear value of 48000(ms)                       [ OK ]

v5:
- Added 'Reviewed-by:' as requested
- Modified script to fix AND logic in classifiers and updated comments
- Passed expected value as argument rather than hard coding in script
- Added minor comments for macros

v4:
- Removed binary application and related codes for selftests
- Decided hard coded match based on extra arguments for selftests
- Ran shellcheck on modified selftests code and fixed
- Updated comments on patch[1,2,3,4] as per review
- Added 'Reviewed-by:' as requested on patch4

v3:
- Updated the series title for better clarity; old one is here
  https://lore.kernel.org/all/20260326150742.50289-1-royujjal@gmail.com/
- Added key changes section for new selftests patch
- Updated netdev style comments and addressed review comments
- Fixed MLDv2 MRC conversion logic during query generation
- Mentioned intervals in units wherever applicable
- Dropped type casting and fixed indentations

v2:
- Retargeted the series to net-next as suggested
- Fixed a compilation warning in the MLD rename change
- Kept reverse xmas tree order in IGMP exponential encoding change
- Added bridge selftests to validate IGMPv3 Query MRC and QQIC handling

Ujjal Roy (5):
  ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
  ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
  ipv4: igmp: encode multicast exponential fields
  ipv6: mld: encode multicast exponential fields
  selftests: net: bridge: add MRC and QQIC field encoding tests

 include/linux/igmp.h                          | 167 +++++++++++++++-
 include/net/mld.h                             | 185 +++++++++++++++++-
 net/bridge/br_multicast.c                     |  22 +--
 net/ipv4/igmp.c                               |   6 +-
 net/ipv6/mcast.c                              |  19 +-
 .../net/forwarding/bridge_vlan_mcast.sh       | 140 ++++++++++++-
 6 files changed, 483 insertions(+), 56 deletions(-)


base-commit: edf4bee4215a173c0534d1851d7523d827149f9e
-- 
2.43.0


