Return-Path: <netdev+bounces-273304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIWMMiTMyml3AAYAu9opvQ
	(envelope-from <netdev+bounces-273304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:16:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDBB3603C5
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E5AE302DB73
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E138656C;
	Mon, 30 Mar 2026 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atSTXYWV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6147396D1A
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898188; cv=none; b=f2X7Se6g+GXj03kw51LL3hU3ECzl7ka4Mtham8pgrS9tRNOS9Q1+amcmTRRk9TR71QXI1F70b7PKmhpYbmTgoHm4hL7pnJxRxD+pF3jkt8qc/W28sZjCa8JFqaNa15PJAtDWC78mayYr8TgUPO6Uipk5CGaFB1Toc5dBf0dtEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898188; c=relaxed/simple;
	bh=BOuU4kLSFj0T3OadxVFJ/Pv96MAovOPfw0gN6reRqiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IL5vj5g8UXA5Ran73LPcn+6hI/FfnCmptdgfsMsOerdRA8F8vHoZUepwaoDiYxo1im4zF0x5G09WQ6rwWwBCrn1clw/zWeuZWn1sIluglBGt6/z5sdPXKlzrSdDD8ObjWFN24FLqkKby1FRifssXc4q6QDwjaF/Rthxj2wjyA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atSTXYWV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso2995373a91.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774898187; x=1775502987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaNyh4ecr42g5LIJwYY728KlnH3gHzvSwNNrUVP18Jg=;
        b=atSTXYWVQQk2dZMZ1AVoT8BJOP8W2yAyhd4j3dEgUndvJzt/dyPSuMAAsL/UfEv5Ux
         mY82bzhdG5HDr59qUv4xsZ/ISrVMM4iCWTfmEW+eMb1MbFlSQMzJi6DGoF+Fez18EYW4
         38F/qNYdpMQ8C9vMHe9x6t2lTWN5T4AymgJ6olrhX/ZjJl/q+5vKoGpvu1fy0EcC/V5X
         QQo9q2jM+fkj7M6uhRq8DEe9IFl3PFKiyF7AOeK6SXJTcEOh0dtzHePU5ZrVM3kfL7oW
         Yk0JHWUfVyHmRuCyDtAg3t+4WYyz32DU4ss/ZqXD0S20DRng2hwoQsYtdERbzP+QQFYB
         kLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898187; x=1775502987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PaNyh4ecr42g5LIJwYY728KlnH3gHzvSwNNrUVP18Jg=;
        b=Lrhcwl2GJ3S0Ox6itx34Y32Os5MCI2AOsQX3kGfLQUxSnIJiZbMP26/SgldUqqdSer
         vHEWEJgGXs4pgJ5PNe2R/Agyvxs1pIYP/jwdVVqePeyhbApFa+fsU2HCYkMHXjNcSsqm
         bHF10sr2EhRivfGZ/opaVfKBRAyyVRe17QEezhjjSQGmtbS6+nA4w1e4L6yuhgctiOAL
         s9wy4ssmKMkexw4F5Z8knrOEg9zTO9Uo4kvQvW3MCFlSniPqkvGAVn/v1VqbBSSoE8TY
         e2Nq8r7GNhIGQQxnlAdAXDYFumcontVXroetwtWdbRUaK6Zm7Lxl/iHMwMwAcMXS/Eqx
         KyLg==
X-Forwarded-Encrypted: i=1; AJvYcCWaMQG7KigC4m4AXaZQcj8MU1YnV31XF+Eme6asvYtPJzv0Xwb7mo5CTz62C2KzDK+o2nfhuY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcb8nNGh5Bqi8plumbTL0W07tEcxcmbb2OMDQO8OtDjqCdCb80
	IWT841PFmJowCLl22AN8igCO1FBkgWIQxElyIppDSpzTgNt4DPijR4Hx
X-Gm-Gg: ATEYQzyBuRU/reuenVomXDY5pSfPn9a/INodusm0kaeVEPenxOgB4oyBtp+i6YZzch7
	YWYwog3Ov2pv5tmiQ/06UgOtt78zpIC88meHydMWpiBFetrVnWt9GBpf7Fm4nqpYo61pH7lfQrd
	60QYQhWeFoOWVKRfgG02fbPutco8L85kQKZ0gTyEbSiObepIbjI/gpLUIArFrMMziMnIEQds7cw
	9jd1LTVxpVBn10tK+3qbI0BqC2+l28pW0zudkGEZ/tGR2Ay+JTJOBcEkZcOCS6bcNkn5vzsM3Tj
	G7J18sIRGiZefEhiFgW/UsMtHmPMc2v5zK/A3R6Nx+o3YQd8GaxaQ9BwDkgaShiNhEf96dBPdmI
	CjEI1tE79QxZB5h5FY23CwBDTKPLe2CWMISv6i5cWhMA7E5sOqb38tt8yG5TzH7KL35+d5rSm/v
	tZj1ZnLohYhGX9twojP3HeTlRI6i3x0k/OUjYHhZ4c
X-Received: by 2002:a17:90a:e70d:b0:35b:90e7:c453 with SMTP id 98e67ed59e1d1-35c2ffaf73emr12904875a91.6.1774898186798;
        Mon, 30 Mar 2026 12:16:26 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm9627178a91.17.2026.03.30.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:16:26 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/5] net: bridge: mcast: add multicast exponential field encoding
Date: Mon, 30 Mar 2026 19:16:06 +0000
Message-ID: <20260330191611.16929-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273304-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 5FDBB3603C5
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

Impact:
These changes ensure that multicast queriers and listeners
stay synchronized on timing intervals, preventing protocol
timeouts or premature group membership expiration caused
by incorrectly formatted packet headers.

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
  selftests: net: bridge: add tests for igmpv3 MRC and QQIC validation

 include/linux/igmp.h                          | 158 +++++++++++++++-
 include/net/mld.h                             | 179 +++++++++++++++++-
 net/bridge/br_multicast.c                     |  22 +--
 net/ipv4/igmp.c                               |   6 +-
 net/ipv6/mcast.c                              |  19 +-
 .../selftests/net/forwarding/.gitignore       |   2 +
 .../testing/selftests/net/forwarding/Makefile |  10 +
 .../selftests/net/forwarding/bridge_igmp.sh   | 109 +++++++++++
 .../selftests/net/forwarding/mc_decode.c      |  38 ++++
 .../selftests/net/forwarding/mc_encode.c      |  40 ++++
 10 files changed, 535 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/mc_decode.c
 create mode 100644 tools/testing/selftests/net/forwarding/mc_encode.c


base-commit: cf0d9080c6f795bc6be08babbffa29b62c06e9b0
-- 
2.43.0


