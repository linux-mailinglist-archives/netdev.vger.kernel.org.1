Return-Path: <netdev+bounces-272105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLLeAjpOxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:18:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A1B3376A2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F22FC30467ED
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456663FFADF;
	Thu, 26 Mar 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E82Fm2Yr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FC3FF890
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537672; cv=none; b=OGTmu64mIpcNoqyUuQfFc5eVnacq/fWO/cfoZQaukCnQ97T9u2FhIu91m89bOlDNdjYaz4Vq2f0zGhuTNxNZhtIC/eJZjJOPsUYVqI9VVaXjVNsrzfNyULou/MjE8ZQytNEAajcm1vS2BXEd/a68wmvEe9EburwMbIEwwiwohk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537672; c=relaxed/simple;
	bh=jhUluxnOnXLTYrExMH2GUBs0GFaV+n3AxshVQjkfG5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWRPbXe4OjfDKJ9PVOoatukSRQgAnOqcE6IbaBiP893eWhRSlIWdOL8VOPxQAmPq/LD6Vn3IUzHnMwm9Idy/beO9rR5MJEZRJfwXbsradGWHzd3e4FHvLYWrv4b6hdUT03ZNH0PcbobWzOsoDYMRKVdlDzbZuaX4YlqCknQt5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E82Fm2Yr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b061b6cf36so8082995ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537670; x=1775142470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCoW6mouvlV/2Yp7iZzyAAghySisJwNrZrFcduzYkY0=;
        b=E82Fm2Yrh/VB6fdrVtNgwUqyE4wHfRWpbTqM8JWldXz1FtpzlQFQKvDSrVeZupYGZi
         quRFC0r+mI12rDqKnwjJ4euK2UZuhqXpOJmWN8XBPmPQ/uH2070EDJFPT3nQY3f1M6ri
         NST4oPrYgeslEbRu6jMRNLYzUcxt0iaH6eLt9squzkXZbJoTkcBwVN0WMuopkTPKldXf
         KqlckOmJ1pNIX9o0s+ad/XMSAWrrvVwIdw38TsVo9K1JWvgFIkjpejUOtGLOMUYK8kDP
         SBzJ/BNDz+OJsWPi8EJpw7eoJJ7/b42qALiXCh3nutaxkb/rOixJBbB7JARV5P+epI3+
         pRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537670; x=1775142470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCoW6mouvlV/2Yp7iZzyAAghySisJwNrZrFcduzYkY0=;
        b=iI8+deAL6MbaSJb6D2cH6Ous+bJiZAtTGnlQx349qM3E+9HfQF/ThAap/Oo/RBZyX0
         Mv70RiMnHiO2qP1zVRSth6XSHFTwpwnLg8qGT4XGqC8isn51SiyMudK+zC3hb6fGy5Vi
         xQt6HaptvULhgk/JxMRzZDPmZwjmiRPT06kFRR45m4EB4k2ftX3SWpIovqfo/3xw/Al+
         gtLO9X+zsdYsz6Qa9mJI/lAJt6C1IjPQcuJSNWh5euFQMISn0qcSrThPa/OesJCyInz1
         drzm8N6OWHoRbTJbob2ogOyNVqMgUwOTHKqRU2teedImolKQ2/ldBIl0fYM5NdPpH4dr
         0zmw==
X-Forwarded-Encrypted: i=1; AJvYcCWcwDR/JIp6QPjwJywoPlkcegTVVlA4Oi4qoit/n2xhuLFwdjm3iL7bEYaOF/A5xy5fTFqRd+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx96xM4Etd6/ZC4JoSVz99k+HO3p7wjPlJNWIFrfirMujrA9rE
	i/nAssPRNr8EzziJkj+eU4KrL21XsO4ERv1aesLHrDSI8d4y/M+LSARU
X-Gm-Gg: ATEYQzzNgnRHlupqvrtHq6rXCmKHI4yQm4Z/zCQ3q0mz8w92W/4/yF+tNs0fo5M84vU
	+mK4sRs55NzXp0zXa7EOqhZiMxZ0sXln9ecbRzTpLFO6Kd47cZ1Qmvrc95JhpaSOSxbMFjvPILq
	paK4wUl0ENRF+QEV37//slsD3/1M+KAIhaY1tVycToZp0M4ap/LwOYhFMBtalxjy9kilsBiSMeJ
	i0r1HEj+RNzrbjaGshltSHSVUrsE7Bm4ir9huLMXCgIOf6RMLwgNHAQy3vXBjYeFNh0RnPYzEmg
	cnfujXH3/vxDPl9cuvuwdYwTYA0QX+7r/TFNrIiCruV36PkrCrOwPwT5OhgTuB8yfFfRnPrnhFM
	Gue6cUpeui8a/dqgFVGxcQVyTQeU7EMK3/RnyVU9km7p0pn+GrzaamUeY/UyvzVdNIIbkEfyFQY
	vG0ca71iP8hJxRcIutBniQ/bPsU6mlwv9TU+lr8dra6wj8KY/jSHw=
X-Received: by 2002:a17:902:e951:b0:2b0:665b:c7de with SMTP id d9443c01a7336-2b0b0aef15cmr88760115ad.40.1774537670058;
        Thu, 26 Mar 2026 08:07:50 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm33146375ad.59.2026.03.26.08.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:07:49 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] net: bridge: mcast: add multicast exponential field encoding
Date: Thu, 26 Mar 2026 15:07:38 +0000
Message-ID: <20260326150742.50289-1-royujjal@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272105-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48A1B3376A2
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

Ujjal Roy (4):
  ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
  ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
  ipv4: igmp: encode multicast exponential fields
  ipv6: mld: encode multicast exponential fields

 include/linux/igmp.h      | 158 +++++++++++++++++++++++++++++++--
 include/net/mld.h         | 179 ++++++++++++++++++++++++++++++++++++--
 net/bridge/br_multicast.c |  22 +++--
 net/ipv4/igmp.c           |   6 +-
 net/ipv6/mcast.c          |  19 +---
 5 files changed, 336 insertions(+), 48 deletions(-)

-- 
2.43.0


