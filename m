Return-Path: <netdev+bounces-286085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFoWHPea/mkMtwAAu9opvQ
	(envelope-from <netdev+bounces-286085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:24:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C352E4FD9D9
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C5F4300874A
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850552853F3;
	Sat,  9 May 2026 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT8+Ryg1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA726CE05
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293442; cv=none; b=PyVZ8wkurKsmqjXEmFqnP5yxpc920buYqW55sArS+G2mYGV4X+I3aBTQH9LwI1+r429C/+sTlQyBXaxrqSojfECfqPIlOgqMEJW6LjtzGxM1m58HXy6UxAMapTOjkIuUBgLudS9gF00VY3j36h6YMcNrqZRkPrBkC4YONOro11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293442; c=relaxed/simple;
	bh=1mi92XKE+g8yTG7xpch2kSA9yHDmlSJwFhac6IBIMP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKTva8VKSUayP7ZtN9NuPy5FrpI1okF+Tdtl2GQx8DjyrzSTQkTm1lGJ3ADcXb5WE4+wJeCozkSuEzLUpZWHmzZDuzYkv7xWRDu4o19aECk3g0Yv9bxVVwLEUQpSOeyY+TkdtNdItq+FIC7BvepTKrFFCMBNb8XPJKeiJMEw2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT8+Ryg1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so2332917f8f.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293439; x=1778898239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0yBIRJCLUR1t2lfnFEwXcxrdkWQyy9LORA2KLU5wU3E=;
        b=AT8+Ryg1edNd9sLxqM/wB3+zYzQbQzWZvPQNpbRlQf48HgSws60CBKpzpBGs/BxW7Z
         e0NJaJZqw9zq/QnldQ9/TlHUCoLcPhngf85tIw7lTaNWSYJY5bRcTeGzzRjnkI94cHK3
         WuQpNZ4FAtEBzl68epPCVxbx8D9HCT7rF3b4yHcBBvoRFNdxmYDgHsD/eFwruApFUnPT
         yDn3qF0qk2P1nssqbaHxfR7VcGnGXHN64hRtK0VZ1cfWFx0inpQycqzbmfDH3QcXSH/2
         iGQo77RC4zTZ2WCnOOwWlw38JRHw/QkLsr88jIMx8jh1QBxAwp5RhaLyKxE9BzcH53g4
         l7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293439; x=1778898239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yBIRJCLUR1t2lfnFEwXcxrdkWQyy9LORA2KLU5wU3E=;
        b=pIybgdcbUYrIwqqIwx12cQk1z5FAWBl35ga7oAr1Fm7BCLcFy5t+FnrCdiVWZyddRG
         4wAQQ6RnpjJndj/5e5/50dYMDuBJ2ZLfGykoHHLsgMEq0Pk4dfI1p2E44groI5vhr97D
         ZnwRs7edIB9eGvPO7Fzj7riN1cpD/kil8q9uq6fYh6gOOqlaNBhgbjceTp/pXLcTBLlL
         mJYvsr1T5AyTcCSu8rrI+o5vGKrh/mByhFD0b6QJ3nonN4FKFs6l5qggxBGV957HDKej
         +tMDV2VlghI/tWgldRqhG2hWGluScwDe8LY/Fj00lbrw4mUG+qNpoVWZPMnxy6DdtZmk
         4ELA==
X-Gm-Message-State: AOJu0YxvVjPTDZXZNu/B7O2bQI3NUm1JUBYm2qgYFBbwr4MgMWJvirRR
	63dEYyHQ6WFubpXJjYe1wYXXaDiuh8pOA0uhYlQ6vo3dg3qF7spfgRNWpwKSL3gT
X-Gm-Gg: Acq92OGrHhPZSh2YpQlaNtDrp/ymEZK35VKiUmXSYkMMkyFfYINz1Y8h6Mjf7ORc9k6
	+puOJSWVeQYHQrzF/pV/dhTlvfm4W04va7WYmCRLQGUVvpKZyNqm4Nc+AG8rCZq+rcgoJWJoDwy
	E57MaMcQrB4ZbRK8F3KJw7Gu3+k4YSIxOuusJ1YLYGPH5WFZ/jOYzjsHBFw73UYRKUFe890sGgt
	O5WxxDBx7ztP+445pb61qBWiZA9vnJkKPOXNFm0klqaxqC+vrWkuR1t7l13rsBvvA5szxJCcq+W
	3/x4bzsjGW2kCIpMTuEwE9pL9lc/dpMFAn7MXc/MI1VfMhJ/EA12MlRJ8COO4lTU5YNsaC2NshK
	bGEFS2D3J9+Y03jUlrqOiZzREVH+2rdnzyoV4oAiOGJAcJtzTp234aULtWWk8Ujis28+cINQ4QS
	qqij3LPskfPIAldI6Rpd4MQgh4Wj9SDeE=
X-Received: by 2002:a05:6000:2b0a:b0:453:dc4d:9265 with SMTP id ffacd0b85a97d-453dc4d94afmr7137378f8f.10.1778293438864;
        Fri, 08 May 2026 19:23:58 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:21::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bbebdsm9506904f8f.5.2026.05.08.19.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:23:58 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next v2 0/6] netshaper: Extend netshaper support
Date: Fri,  8 May 2026 19:23:47 -0700
Message-ID: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C352E4FD9D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286085-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

This series extends the netshaper CLI with missing parameter support
and adds the group command for building scheduling hierarchies.

The existing netshaper tool only supports setting bw-max on individual
shapers. This series adds the remaining shaper attributes (bw-min,
weight) needed for TX scheduling, and introduces the group command
which ties leaf shapers to a parent node in a single operation.

Changelog:

  Patch 1:
  - parse_scope(): use loop over net_shaper_scope_names[]
    instead of hardcoded string comparisons
  - parse_rate(): replace magic number 8 with BITS_PER_BYTE

  Patch 2:
  - Add has_bw_min/has_bw_max/has_weight booleans so zero-valued
    attrs are correctly sent
  - Add has_handle_id; only send handle id when explicitly provided
  - Keep node id required in do_cmd(); only netdev scope has
    optional id
  - Only emit rate/weight attrs for set command, not show/delete
  - Validate ll_name_to_index() return, error on unknown device

  Patch 3:
  - Use print_rate() for bandwidth display instead of truncating
    to integer Mbps

  Patch 4 (new):
  - Extract struct shaper_args and parse_shaper_arg() helper to
    share argument parsing between do_cmd() and do_group()

  Patch 5 (was v1 patch 5, v1 patch 4 dropped):
  - Reuse parse_shaper_arg() for common argument parsing
  - Validate group handle and parent scopes are node or netdev
  - Require parent id when parent scope is node
  - Fold optional node handle id into do_group() only
  - Define NET_SHAPER_MAX_LEAVES (256) for leaves array size

  Patch 6:
  - Document node id as required for set/show/delete, optional
    only for group
  - Add author to man page

V1: https://lore.kernel.org/netdev/20260501011611.3533573-1-mohsin.bashr@gmail.com/

Mohsin Bashir (6):
  netshaper: Extract parse_scope() and parse_rate() helpers
  netshaper: Add bw-min and weight parameter support
  netshaper: Extend show output with parent, bw-min and weight
  netshaper: Extract struct shaper_args and parse_shaper_arg() helper
  netshaper: Add group command for creating scheduling hierarchies
  netshaper: Update man page for new parameters and group command

 include/utils.h       |   1 +
 man/man8/netshaper.8  | 140 ++++++++++--
 netshaper/netshaper.c | 485 ++++++++++++++++++++++++++++++++++--------
 3 files changed, 522 insertions(+), 104 deletions(-)

-- 
2.53.0-Meta


