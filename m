Return-Path: <netdev+bounces-277757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lG86Acx922mgCgkAu9opvQ
	(envelope-from <netdev+bounces-277757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:11:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 495193E37F0
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7081A300CE65
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5D8377EA5;
	Sun, 12 Apr 2026 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWQjcj8V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B3231836
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992263; cv=none; b=IYcj6bwz1CcZG43B7Of9ZnhV2gwVMHagApgM3Y5a9S2dMVa2DOWdMSQA43K0d8MCmlHjsILkMu48mQP6/CedvhV60nkyba9UFe1tPQ1B+7C8Zw254jJXoVUedYT9VSO5yGQkhyRVGdjkOAQMSo0/2l9ZPQaQSXiASVawo9z1knw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992263; c=relaxed/simple;
	bh=DN1YYPSHImU/U5TMNDB5Ec47OLtn6flhiZP9gVoHmi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYFEx4hzUvOC0xfEm1FpIMhbjEoX1be0qssDZlhlDVI6dVUNImMkjryX6ZeiuHEdnfJxzZASsbKrD/36GVtDNIWKN4aRC8MYw2EwAGdKvIyg/XOIcLOK2PoSGzoMjolK1SpbBNZ3J20P0V0gVFBqqeN6evVxuWsHE6tE8BOzQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWQjcj8V; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso1432803a12.2
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 04:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775992261; x=1776597061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akueeEYc2Me3zisgTMBqzXUfPeZV9sXVNUmdWR6Vztk=;
        b=jWQjcj8VVeylOlGBTrPtSkigwqQ7U+0srmsoFsPkuBP8KUVgxPOaA94CCXlr3qQ9Q0
         3yFAu/HHQZcBF5LuZNqRZ3EykrW8R8rhA6u7IlB4GnEKAUWl2syz4qYsfu7IDSenDqwA
         YhoJgu1aph2Hvnc0QGExzn6fnehjgxfXYmT1+yukvKrW9k8ISMihgZ5+e049+iLFB8YG
         gmXdpfZxaD9f5qDy9o7nJxYcWBQJeulqKIwDyQsyAh06bMfsdlMZCRgPIjjb8fW9GhV6
         3OS4mywTGOx0w9blvXdGRFgzALE35TPxTHQ703uMOlJHzCyhPzQVVjgVoDWHrLgGaJ+9
         0cIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775992261; x=1776597061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akueeEYc2Me3zisgTMBqzXUfPeZV9sXVNUmdWR6Vztk=;
        b=THuPhRe2hJx7cjTsdqCYTLlqRP2opyz1EFsh+amdXgL1h1hkUAEP8pUhJ6bBOv+0GK
         e21yC8gCFV/1OxsPsBD6At9ntSHsDHSUgXEfv+gwtGInQJNgKD8Am8N3qJLs2IC9dV2v
         l1l4PSTmO0qwnjF0V8tdCs+fF3IZK3q2htv94/L3vIzy4eE4w3DY8HaSoN+OcQq9Xfx2
         p1FgXkY3COdntjOQThU3Da9wWMsUi/JgI4AwJ6S009kmiiX914A02gmKbgRem7CGBsIl
         Iam8FO4F39jx6g3VWOxXNON68XvhdBXSEYJw4y2u6zf6Xwn+r4JSQBjwONy7CU4B9E5+
         BrfA==
X-Forwarded-Encrypted: i=1; AJvYcCWm47XZYevWXD8yYF3OVlyUYwaemLNyefCK9SmxArlMoLYSG4hZqwEDJnP8vXS1bvLnjobQ8+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXKmT5a1SYPVJ/haTL4yt9MNw6RA+jtv5LzjP8r1wx51lWUpd/
	W7K1Zfu/ZxXyQYaMFB9h8dHTNoAc0Ca21uTug/IHhw1EyrnLwIFwGUsR
X-Gm-Gg: AeBDietzqvKGniSxBIx5I11qwsuBHDTqL1btW8njD5leV7tIq6ijXXDGf/kasUN7tRQ
	oA4cE+FbKR/2sX8aCmISwBqgqAOkHTWGmX2fqzetN/zQUFOIXjXv2DwWK7vTMydAQc7GD0ICNAq
	H5im9kxLnwSYCd0ue/wpFfZASMw30py3hgMbNfWCff01Kl+8+jfoXVEUdmHUQ0bvlB6uirBngdY
	1mmqxNlI40/vVMYim1x2JcF1mq96CjBCtTlEh2wQrcgVc/Ex8OrZzlMm5o8NFtxAWbU7sLaUSCF
	NGmhmNbLFt3mQRTiMLyURMQEQbiFpRKkBch5n/TwHll4vXiFueX7TvaLcqoiiP7AqWv+eVyt4uf
	5GjgXtb30jfb8nieKdNj0GFjrEFiPGtP2JGYl0iu+HcvbDqt2xYQYqCgAm8JQxhrgM5w39/4aPF
	Xsxmh4B0QEjJC5hRDdBeHrcQSAff4OjNSyksPPn3JM
X-Received: by 2002:a05:6a21:338f:b0:398:787c:d2e4 with SMTP id adf61e73a8af0-39fe3d0e8e0mr10815770637.17.1775992261411;
        Sun, 12 Apr 2026 04:11:01 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7934c9ef38sm2522981a12.12.2026.04.12.04.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 04:11:00 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/5] net: bridge: mcast: support exponential field encoding
Date: Sun, 12 Apr 2026 11:10:42 +0000
Message-ID: <20260412111047.1326-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277757-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 495193E37F0
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
Giving results only from vlmc_query_intvl_test and vlmc_query_response_intvl_test
of the script bridge_vlan_mcast.sh.
Without patchset, here is the result.
    - TEST: Vlan multicast snooping enable                                [ OK ]
    - TEST: Vlan mcast_query_interval global option default value         [ OK ]
    - INFO: Vlan 10 mcast_query_interval (QQIC) test cases:
    - TEST: Number of tagged IGMPv2 general query                         [ OK ]
    - TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
    - TEST: MLDv2 QQIC linear value 60                                    [ OK ]
    - TEST: IGMPv3 QQIC non linear value 160                              [FAIL]
    -         Wrong QQIC in generated IGMPv3 general queries
    - TEST: MLDv2 QQIC non linear value 160                               [FAIL]
    -         Wrong QQIC in generated MLDv2 general queries
    - TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    - INFO: Vlan 10 mcast_query_response_interval (MRC) test cases:
    - TEST: IGMPv3 MRC linear value 60                                    [ OK ]
    - TEST: IGMPv3 MRC non linear value 160                               [FAIL]
    -         Wrong MRC in generated IGMPv3 general queries
    - TEST: MLDv2 MRC linear value 30000                                  [ OK ]
    - TEST: MLDv2 MRC non linear value 60000                              [FAIL]
    -         Wrong MRC in generated MLDv2 general queries
With these patchset, here is the result.
    * TEST: Vlan multicast snooping enable                                [ OK ]
    * TEST: Vlan mcast_query_interval global option default value         [ OK ]
    * INFO: Vlan 10 mcast_query_interval (QQIC) test cases:
    * TEST: Number of tagged IGMPv2 general query                         [ OK ]
    * TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
    * TEST: MLDv2 QQIC linear value 60                                    [ OK ]
    * TEST: IGMPv3 QQIC non linear value 160                              [ OK ]
    * TEST: MLDv2 QQIC non linear value 160                               [ OK ]
    * TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
    * INFO: Vlan 10 mcast_query_response_interval (MRC) test cases:
    * TEST: IGMPv3 MRC linear value 60                                    [ OK ]
    * TEST: IGMPv3 MRC non linear value 160                               [ OK ]
    * TEST: MLDv2 MRC linear value 30000                                  [ OK ]
    * TEST: MLDv2 MRC non linear value 60000                              [ OK ]

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
 include/net/mld.h                             | 183 +++++++++++++++++-
 net/bridge/br_multicast.c                     |  22 +--
 net/ipv4/igmp.c                               |   6 +-
 net/ipv6/mcast.c                              |  19 +-
 .../net/forwarding/bridge_vlan_mcast.sh       | 150 +++++++++++++-
 6 files changed, 491 insertions(+), 56 deletions(-)


base-commit: 3f3a2aefbc661b837c8e344f944982d61c2ae037
-- 
2.43.0


