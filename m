Return-Path: <netdev+bounces-291044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Wy/lEl5GEWqUjQYAu9opvQ
	(envelope-from <netdev+bounces-291044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8999D5BD676
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC513014960
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745731DF748;
	Sat, 23 May 2026 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jESf02C8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28703128CF
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779517019; cv=none; b=TJSaYQznp2V7NJoU2YaY+9tqqnFvk53h9U2OyGNbSORWjXGnSb7rBP7hD5NT/21ewuasE6+GkDjrXvo3GB8CKjiVQl1H5z0duOjAT+4UjJVhYInXJphY/WH5xB1Av3OIer7V7am8P0z8BcGRMRK830LAusf4Fap5lYgntcmdny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779517019; c=relaxed/simple;
	bh=6vWtXTV5AWRrQwdRE02h91apgPdmqZFkLk4HMjD1Ufs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UKVkR+1HjiE8R95vjfjzc3hukKDTx/51vcfOB4+tOiCeK77qMKeh4wckj0fV2WIMVD8R8LT37K78z5YJtH58kEy9Vgaya0hm2DbWZ79DDoN/l4CTNxhbg5ky44uYX5zSoJgvTwYj+fEVoj0UW10A8rAbYx9X/Y/sRbmrzRZFfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jESf02C8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd6aeb3637so194279385ad.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779517017; x=1780121817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BVLuCd4qtjaZyU+GZy+jf9vxfy1McvpJWrAdrS22ygI=;
        b=jESf02C8ERsv2A8lQB6ViQcWvEqm4/cmNhXooyf10kn6B3Q/rgMaiwAKaT9sa1YIv8
         csHLf6owVFWn2ArLlBfHRB/nWjl4TmfGU8apmxIE1szR8TFTg5eUr8nvBzHDcR0ycOMv
         6yoOLzTFPBS1CMmAlzj/x2idzc4nyujhJz1fG850+urYTKTaguFhKriC9M2b5zHTCn4o
         4tLrsNz92tO/zM7aA1XCJdi7HZqMrB8ylBgSzLG9I+ZKTgDt0Orn6yfsLxVaBWRC5eoU
         9W9VH6SQHd2aZLOrb+TM5VsILkSfr2hYL0c4qjYasnSfL9f7IKXU5NtJWEuiTFy4/TJb
         g0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779517017; x=1780121817;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVLuCd4qtjaZyU+GZy+jf9vxfy1McvpJWrAdrS22ygI=;
        b=QgqN8u5gMWEJ9L3YLo+ydjcJ8c2yOIQpDx9M3BPlzVbOfHdSsL9zadCAV16PgrEajU
         1JgLbX4RGUvAo04oOQX0lKdVyObrnxwaAJ9JJTmCemrw+aEXiyhYwX/eqp9+CrAaby1K
         9wDaP4T7lMLtnFjmpwwxkvcyHDIC9O1u0Rn2t2Ud/+YHQeGipMA3q983Ln+YCHhWNUN6
         YHEGyOFQeSq/V80RwpSpPsWrLFM52MBQy01UrK2DPourk9XsBaJtt+Z59cNnnJRBQwgq
         GesxRJJ+kbAw7Z4bYSczCFe3AgVBdP6xiIwAkqi21OUBxvQnCbBuwxohjDu5iVLe0XFY
         urRg==
X-Forwarded-Encrypted: i=1; AFNElJ94okLxEy2ua1pmCGoeaHVLeAQvry1mapgGNZlI596J0DYS34YZ3BMExbPfhJt00bv+s7WMnCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLV4I9oCBM+BnxXFAircugdUPRJES9cqc8/MrpktIKs0A54Xi
	AdzKRUcvsibT8JozKDC6X9QHVNFp9EneIdx8RakIlzvHi8ZwwquDj0UpQOZGNRY+JL+iN5hAuBn
	A7bm03A==
X-Received: from pgbbw34.prod.google.com ([2002:a05:6a02:4a2:b0:c80:ca29:73c6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70e:b0:2bc:8ebd:af76
 with SMTP id d9443c01a7336-2beb03466afmr71738405ad.0.1779517016457; Fri, 22
 May 2026 23:16:56 -0700 (PDT)
Date: Sat, 23 May 2026 06:16:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523061654.2767060-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/5] geneve: Allow binding UDP socket to a
 specific address.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291044-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8999D5BD676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

By default, a GENEVE device bind()s its underlying UDP socket(s) to
the IPv4 or IPv6 wildcard address because there is no way to specify
a specific local IP address to bind() to.

This prevents deploying multiple GENEVE devices on a multi-homed host
where each device should be isolated and bound to a different local IP
address on the same UDP port.

This series introduces two options to specify local IPv4 or IPv6
addresses for a GENEVE device.

The corresponding iproute2 patch is here:
https://lore.kernel.org/netdev/20260523061102.2762452-1-kuniyu@google.com/


Kuniyuki Iwashima (5):
  geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
  geneve: Pass struct geneve_dev to geneve_create_sock().
  geneve: Pass struct geneve_dev to geneve_find_sock().
  geneve: Add dualstack flag to struct geneve_config.
  geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.

 drivers/net/geneve.c         | 228 ++++++++++++++++++++++++++++-------
 include/uapi/linux/if_link.h |   2 +
 2 files changed, 186 insertions(+), 44 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog


