Return-Path: <netdev+bounces-283410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fhIsBt359WkHRAIAu9opvQ
	(envelope-from <netdev+bounces-283410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 15:19:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C464B21C1
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 15:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA228300C5A5
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8AD1E32A2;
	Sat,  2 May 2026 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLJ91kIh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7301A9FAB
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727962; cv=none; b=JG0dHMrTfX5xz4wAQLzdfgBGr5H0QgU5Ehld+70ekEv4p52YNm6IUOM3D+MFqXAbkb6GqH3oaMNi4k58hFDorY580PcH4jbRjzPxb9B29T2yF1+6UOjSinc6BwU1XvqzkTZ7id+XMAR6MMND0lBQdFGZ6SNzK4/nOTp1ujWRayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727962; c=relaxed/simple;
	bh=HyVORvmUzvwB1Nl5p7wOIBo6yAmsVN9A+bqB5xudpLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twZko0mpa06xS4pq7xf9nHT/up6V92GKpK2D2SlUTiQDb1McrueRf6J3SnJ9CrZ17iUHFcPSAo3LJB6fozdFCNCSLFq6VvJ9XAVSiBQSckFZj6zX9vckFGpZsq0F3OKh37Oky8K8AeMPGSdo+KIjIl6vzT9dtVNp+lkO/8eaE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLJ91kIh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so67632b3a.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777727960; x=1778332760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FwzP1nrwPQwraOurWhbU6oQqB1NFo74SdXflMLy9biw=;
        b=FLJ91kIh5HwHulG9KfG2l4axMbkJksF4RFmmYmuRgXzsdX9BRPGIDm8K6NRbtiBptl
         RUCx/bew3P9G+J7nmgGyUnq7dsHe2/XYZCuJ1pBC7NMJA+ZG9GFrVfYv+fawOCGm02R4
         CIQDgnQ1zPmOgb6I00lofW6oIrG40IgJGOEaMPRd9/4Pv30iNxIK48DzMA0NIZC6If2i
         qRCMi38e0yihp+Zfv8LJ9ZrhGzJzNnU841sgVeUAsl9Nnyjo40aQm+hdte5GRajZUYYL
         w/vqXHyXzLKLMyDH/41ycdbbxevDEG2uIZVc6hJ2X/KHlTcH8fK1x3L8kcM6P9oSI2nb
         g+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777727960; x=1778332760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwzP1nrwPQwraOurWhbU6oQqB1NFo74SdXflMLy9biw=;
        b=jvTYlrk82IiG62kx8VNGhcFsfF+rrGIX0pAm/B9pcc0fF1EUMTqtIsYjYNad0uZjMO
         X5wwScN1sIE8BoLAO602l2PkUrG0iKxusv4pgT+R0bVYt6qpQSpvEyLCDr11uIyVxM3p
         6k5wKqczmLeg5IX7uHQ7yT1sdDLPWQXUUF32lvbolBNuptPl/yl948qtK76KHMfFJryz
         wgxa6RQL1F+TWWUobMtERZ7k0hupyrj8dE7fLswQgcAIDdGz6gPHWOxhlkyBKjr5UqZV
         CYRdD+t/Y3GJIGbrZU0hqEgc7DordOcALBuvAvK56r6SXwv6a8wbF075QARMODHF8u6F
         xIXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Hiku22UR477qZenxRmo12W/PKJ3N97vPyn2SY+GTsyBGEUWep73eR5LRIBPcKoaDwrRAdxQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYP4PL5CjhM3mHP/vUvI9LvqVHmlJFWb0apiqUkUb69/yibB9
	Zb76fmfwsT9pxA7AO/4S3M7Z6JE/p5vtWwba2FhOwSyRL7uZiiaV2dWYlLb+oGvwgF8=
X-Gm-Gg: AeBDieu+KwTaMwH/od2lrvnv2Dn6f1YorVasjRvlBfrJOekyahClpLvDf/uC/bNyMMm
	VeLB5xlmJKw56RQorWgGlMfCPDix46787go+IV8DETcN1H3qp3+iHXRJBpkj1CXvP5rw1N3TA8Z
	bn1yrPVWTbv2w5bxcnmQw3tcwvmqoGhxsLLCIactdDuq+OzHDKdyNjjl+BDspe4RaaDPauogjqH
	U2ZEW3yyQt+YEJKDI0TKpXoQufXhSxrng0hfMj30oOAuGtWq2FmbEsnFumr2C+v8NTHWjlI0yl3
	YqiYOh9kKqAfhwFET4tsvEN4eZtDFtm2J5tq49uLb4aPtlDYvfLKU4SBwSHqoNG3rQcMNGWUvbI
	5UZiJ/4h+Ovw1p68tis+c8/vQB2kEV9+nqSqAYI0xiAjkdc0WmrsoocyFznwejlZRkwSTBaHWGY
	DoQkAdyKwKcFIwSdcbsOLDQelTu1/YrnJK1skAB5bOAa7WAM99hw==
X-Received: by 2002:a05:6a00:4188:b0:834:e5a2:d089 with SMTP id d2e1a72fcca58-8352d29abeamr2977873b3a.33.1777727959490;
        Sat, 02 May 2026 06:19:19 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0176sm5553791b3a.39.2026.05.02.06.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:19:18 -0700 (PDT)
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
Subject: [PATCH net-next v6 0/5] net: bridge: mcast: support exponential field encoding
Date: Sat,  2 May 2026 13:19:01 +0000
Message-ID: <20260502131907.987-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60C464B21C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-283410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,bridge_vlan_mcast.sh:url]

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

v6:
- Added Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
- Previous thread can be found here:
  https://lore.kernel.org/all/20260501173130.3486-1-royujjal@gmail.com/

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


base-commit: 0f19519fdd22bc0f5429377da3a52327c5eee166
-- 
2.43.0


