Return-Path: <netdev+bounces-275093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEysJrjYz2mb1AYAu9opvQ
	(envelope-from <netdev+bounces-275093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:11:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D32395A2C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E6C2308AC78
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7343C8710;
	Fri,  3 Apr 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqLHL1Pu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE05A3C6A49
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228463; cv=none; b=g29+rO1YFfUNI+9EIn9Wv5DZHothqGjbqYZ0r4fQigYqVJJAgmic8IqGJa2AsMDUV8VlGJ4fbLhsHStSTZcd+/ZoScaXOewyD3FnDE7OJ9iyieERxqkplhqlw/LCzjWttMqvRFXfsMOSL27AoZSChHpeSgASGBgIjkFNdSmhzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228463; c=relaxed/simple;
	bh=4T03tU+HgJyUNh24jwyBJCtFpN1e7T9GXw7WPkcUWAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vx886uThj9C5Df0nkKu388TA3lx4KTPWAKJfgiVRdkiAItSJ4nnRss5f3rojttJ5Ti1MufL0Q4SvOti138CAZ6ZMgwusfqWfHo03didvq8yYPJ1gfnOueHNxW6phTk6Toc820Acr6SUUylob5EmLJ+CJ/by08EA+I43BTxMqDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqLHL1Pu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82d03827316so603069b3a.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228460; x=1775833260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYEKwooYgSKsCFZiHLlPAB+cRjNKV5UWBUUDOOvo/B8=;
        b=nqLHL1PuPq6cfrUp9WegC8YrePQIifVctubI4VleZd2ZKrpBjnWkcV+Vkz+ELm7ewd
         EhadxO2JiiWiEu7FQp7iVni+1y2qtx1Kja/a6Onk10PFSN1bLmAtlCR6nX8MSttsbytg
         YCVYbofX8i2TwEAKH5+2YY0O6sx7lkpujzQKhef+uCw8rpVOXc7IpNcsMSn/oJhOp6oP
         cQAmm16iwvPDA2aox36SUjUMkuESslLNd+MLO0ceN7KR6bqWMir0mICJQu1tWqGDBliT
         aV+F5L2Vt6lGf3Qs4Xy0KbYLHRxupaviB1jeeOrCUVRFgAm9E+nC7LvRSe40+HJLrO0/
         gTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228460; x=1775833260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYEKwooYgSKsCFZiHLlPAB+cRjNKV5UWBUUDOOvo/B8=;
        b=hfrwTrgGOX1prPooJmNUT7Dzfdt/B8SfoqYeUwit5k+TzMVBRdWZXIKoGxOXpc7Q6A
         LCx5R9GItNwW2WwZgYVaRTYDUQj9c9pnzLHPS2IN4Bp6cdBFxk8baUBzJ/D0XS09DaoX
         +IA4vULrz/gvbQRgnbhQcZO2uzBsay2yV9hVYtVABVJLvQ9NROEpKWG855o6POPtLYdO
         XHkUwmiH68PGEzk54LG1q1U0w8E8muEQ/Y+OMDbmqxvjtSHhn+Z44X7MPyy6hrK28Okp
         7mArtowhzLkmMdxs1FHQg3bRthgzECt3T6MZyEXLeJpuYQZt2A/6Rnk/VjkCcMdBYw9/
         txxg==
X-Forwarded-Encrypted: i=1; AJvYcCUUCww+BMA/r0cfyhgwUYDmSN7nWszmJhje/RniyslcBQMY/DCO8s1rl3rnu4VbD6fhEQwb9c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjT8kvSd3f1RBXQsN7YS7/35CVysctarGTy9PNL1XBTnqsIu0
	U45akvgBouPTDU9/YOusf5e9ALdyCZIluyR55YlWgOBov3k9bH1PIeGL
X-Gm-Gg: AeBDieuCfUHObPI8kZec0CmPDBPEvg3zPtHS4OPbdpKENUiN/O73pluV9vLZWWV3Z1s
	DICWHR1bTZMkivnOgO9zWeWIH5S+ulj01xWF+Yh+sqANH/gcAARdHHkrDbnTU5Fz/upV/m9nhOQ
	2+jaGcs2WBJxAaVYP2LDuP1GBInxmFoRU8xJdKVDMmUZRIXUvz3izO1BqPA+bwaNnOcCGLgmjCr
	0v9YIwYks3oaabB9wBOW+Ed0iKC+0B66RXYfWPXiLZVtfbuXdPiuIAhUluZ3lI824XYrQYlmIKV
	+w0CpJ2mRI2Yqp+PBwu3uCudPfkZDVdAthmVdSVZd2bUraRcTdJF7zH8OFWtRkWVVfTMVmNRJ36
	ZuZqOiLEJcyUSpaeFZ16GRJ7F4TNSPfkYnN5FKvW4UVuJiTXu41JYdj8bnLH2Rmvx+h0qaKl9Ky
	k/qtFdub0bgTCyIUjOIAGyVRZXN+oTgQXRdWA//GF9
X-Received: by 2002:a05:6a00:340a:b0:827:2d7b:5038 with SMTP id d2e1a72fcca58-82d001e9e7amr6034017b3a.5.1775228460095;
        Fri, 03 Apr 2026 08:01:00 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm7789483b3a.58.2026.04.03.08.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:00:59 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/5] net: bridge: mcast: support exponential field encoding
Date: Fri,  3 Apr 2026 15:00:45 +0000
Message-ID: <20260403150050.1235-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-275093-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92D32395A2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

* selftests: net: bridge: add tests for MRC and QQIC validation
  Updates bridge selftests to validate both linear and non-linear
  (exponential) encoding for MRC and QQIC fields, ensuring
  protocol compliance across IGMPv3 and MLDv2.

Impact:
These changes ensure that multicast queriers and listeners
stay synchronized on timing intervals, preventing protocol
timeouts or premature group membership expiration caused
by incorrectly formatted packet headers.

Test results:
Giving results only from vlmc_query_intvl_test and vlmc_query_response_intvl_test
of the script bridge_vlan_mcast.sh.
Without patchset, here is the result.
    - TEST: Vlan multicast snooping enable                                [ OK ]
    - TEST: Vlan mcast_query_interval global option default value         [ OK ]
    - Vlan 10 mcast_query_interval (QQIC) test cases:
    - TEST: Number of tagged IGMPv2 general query                         [ OK ]
    - TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
    - TEST: MLDv2 QQIC linear value 60                                    [ OK ]
    - TEST: IGMPv3 QQIC non linear value 160                              [FAIL]
    -         Wrong QQIC in sent tagged IGMPv3 general queries
    - TEST: MLDv2 QQIC non linear value 160                               [FAIL]
    -         Wrong QQIC in sent tagged MLDv2 general queries
    - TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    - Vlan 10 mcast_query_response_interval (MRC) test cases:
    - TEST: IGMPv3 MRC linear value 60                                    [ OK ]
    - TEST: IGMPv3 MRC non linear value 160                               [FAIL]
    -         Wrong MRC in sent tagged IGMPv3 general queries
    - TEST: MLDv2 MRC linear value 30000                                  [ OK ]
    - TEST: MLDv2 MRC non linear value 60000                              [FAIL]
    -         Wrong MRC in sent tagged MLDv2 general queries
With these patchset, here is the result.
    * TEST: Vlan multicast snooping enable                                [ OK ]
    * TEST: Vlan mcast_query_interval global option default value         [ OK ]
    * Vlan 10 mcast_query_interval (QQIC) test cases:
    * TEST: Number of tagged IGMPv2 general query                         [ OK ]
    * TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
    * TEST: MLDv2 QQIC linear value 60                                    [ OK ]
    * TEST: IGMPv3 QQIC non linear value 160                              [ OK ]
    * TEST: MLDv2 QQIC non linear value 160                               [ OK ]
    * TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    * Vlan 10 mcast_query_response_interval (MRC) test cases:
    * TEST: IGMPv3 MRC linear value 60                                    [ OK ]
    * TEST: IGMPv3 MRC non linear value 160                               [ OK ]
    * TEST: MLDv2 MRC linear value 30000                                  [ OK ]
    * TEST: MLDv2 MRC non linear value 60000                              [ OK ]

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
  selftests: net: bridge: add tests for MRC and QQIC validation

 include/linux/igmp.h                          | 171 +++++++++++++++-
 include/net/mld.h                             | 190 +++++++++++++++++-
 net/bridge/br_multicast.c                     |  22 +-
 net/ipv4/igmp.c                               |   6 +-
 net/ipv6/mcast.c                              |  19 +-
 .../selftests/net/forwarding/.gitignore       |   2 +
 .../testing/selftests/net/forwarding/Makefile |  10 +
 .../net/forwarding/bridge_vlan_mcast.sh       | 157 ++++++++++++++-
 .../selftests/net/forwarding/mc_decode.c      |  73 +++++++
 .../selftests/net/forwarding/mc_encode.c      |  78 +++++++
 10 files changed, 675 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/mc_decode.c
 create mode 100644 tools/testing/selftests/net/forwarding/mc_encode.c


base-commit: 8b0e64d6c9e7feec5ba5643b4fa8b7fd54464778
-- 
2.43.0


