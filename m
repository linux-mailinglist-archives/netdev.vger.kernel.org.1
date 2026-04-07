Return-Path: <netdev+bounces-276117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMvsOhxB1Wk73gcAu9opvQ
	(envelope-from <netdev+bounces-276117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:38:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB33B2745
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C9343096838
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21853344DA2;
	Tue,  7 Apr 2026 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="lFqi79mZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C819344020
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583253; cv=none; b=ur9fgdBEzGqTCobyUYpkQ+QzvQP34x3JyfMVPOMXhQeAhqd8UYFC2PnuPbpyempTEwQuitOX03EQg9iFC5k3EdznuYk4VKGw80bzPTHcs1cbdDRtjJqvAAjxGT4JLXITeUrq7NcwMgcOwdmW/0CM4m/Ko+VYaiBXFPYICFEcUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583253; c=relaxed/simple;
	bh=g2ZM5FmkM/cMVSD6A+ioyLtze+wBXuHB3O6JxpHUSc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YLGm6DFUU/O4zF/XlMciXUXETGMhmasqmOE8pk8rOgvPtx9/nmcBRImYNygeO7+A2gREbJKGY2rrCQDPFgIwbzyC1wWRH28etjfIfuA2PztCSOLpRvnTju3UBJrBv2FCro0vJ3cEbaPzi0b5ANlkdSPBAfDL0ztxUQQMUtb1QRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=lFqi79mZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ba840146so13931625e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1775583250; x=1776188050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8RvP1qL9GHPweA7UFv71M7qDWUSH6dTBdOKH8YAv1Ek=;
        b=lFqi79mZTeg+5CMl63eOKuFMI/QQTHWniLygGpcDNMWbvhG0557PZMk/NzXO+HDPqF
         iWSkhO/mYyAE6vEm/MzzGwWK4u65n7SxifZuUEcfIzzunAmEf+6w4Y2eNP12aUp1f93n
         zDEsLnk791P9UD4D4v4DCUtwBRHCpeuf1EpK+NCOkXljPimJmO0ndYECaaykHbNls/3e
         jjSwLMy0VhE5QxMPY2rEI9BSb+aUI7m2IYJINV3/kOGSdv8Bfag8gylobJlKqO4x++z3
         2xh8rIRm3M1XGw/1SgOhAnHp5cZ13bE6LotBD0Q4J2ajpfvPe/RVpgY7APOqz+1OArDV
         EuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583250; x=1776188050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RvP1qL9GHPweA7UFv71M7qDWUSH6dTBdOKH8YAv1Ek=;
        b=dgMloDtlp+Qr9oBOC6bOy7UPos2rpGvcNolHudNBfw0/zLAUjoSz/8EV9Gad0/qNw4
         X7Bk+HFJ5FBNpCz3eYFHn6l7tRyWcb7KTDfKAqbofGfHjaer4g4IHKR2XB+W4bWXrgzb
         WGV+UoKKmhhpRhAu1Pt4tAt8ipn4+O8qXyim4ZhGg40DErQJ810aoJJB4FuSiAkn4bMS
         y15cc1YXc0CVAZwbJ9i0/d8SGubSPhEF/NJ83RTIobGLbJswTWgOdvJirRKqrQIprCwM
         dh82JxGZieGaOGCaFeLI+N4gdtQv+WPOFn8rHYwCIyKDiFYoPsIxtF04ohBH5z5Q/ffb
         YN2g==
X-Forwarded-Encrypted: i=1; AJvYcCVMZA7Gcm1l5Q51iCs3DdtrnVDa3e5at2+9DJPevyQm+7dZED5bNsFPbWuptu0T/LEY5Y5EakQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7uFhoEjkL4kYzBI7bRqBw/l5u4ynadbvrtOhSiSNBofoQFG+
	Vv7AUWQ9dLZgr1opJ55xe4Sl8LehPAeieufZU0WJzZ7WlT1NQCTKvHryyrLkaHLezRU=
X-Gm-Gg: AeBDietsQsg1LPsGuJx3sQRQLMjABXU6jwxXKz4gTrEFZKsMgvsnEFXsyUI+/tCGEt4
	wPHQ4nGe0bnuCCpAaaN4oAsdrP1DaCFvOv4XYkvrf3GIbCwBvQRVDgkckOmNoKyO88xYu9mzm0D
	9SN4B3735Y02NPXuQuP9nRkqOgZeyjIUamvlL+J3Q6eQfNxya+xNtytOmPQsMo1SNd8QOVDJl67
	ptg/Ovf5ZXcRRH99c1nFzqlWvjddZ1fEi6VjEl/hH7gSXBcMu8mwtJRl6uwnQegIlIUNERmcCxv
	uWKAvgDV3sSV3CR/RCwzi7i+9m5xIBk7IY3/vqLPbfMf8jYBQVTzieIxcUFRBMbH1TDkyw/CYNN
	I/gtTwZdKXioZu2Cl03U3vRaxldpLP1NVloAU4T/Jpx/K7ucjIpJCz+jxrjlRn/EtwCahfrN5oe
	1hM75IKVkQ8LFVrHlznKQufzOQO5J2tdQz4nuWHe4ikuSvOut/wGP5+4TyaGKBF6v0BQlTlB7ol
	3OGOtxJ/8kB+99wV35vAg==
X-Received: by 2002:a05:600c:4b23:b0:488:a723:ea53 with SMTP id 5b1f17b1804b1-488a723ebddmr100893325e9.7.1775583249679;
        Tue, 07 Apr 2026 10:34:09 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c4e930c7sm6667275e9.6.2026.04.07.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:34:09 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/4] drbd: switch from genl_magic to YNL
Date: Tue,  7 Apr 2026 19:33:52 +0200
Message-ID: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[linbit-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276117-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linbit-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linbit.com:mid,linbit-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48DB33B2745
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DRBD's genetlink interface was defined using a custom multi-include
macro system, genl_magic_{func,struct}.h. This system generated struct
definitions, netlink policies, serialization functions and more
from a single "magic" header.
It never really caught on; DRBD is its only user, its internal macro
jungle is next to impossible to understand, and even harder to debug.

This series replaces it with the standard solution, YNL.

First, shuffle some headers around because the YNL generator expects
to generate UAPI headers.
Then, add some optional extensions to the YNL generator to support a
minimal set of old genl_magic features required for backward
compatibility.
Then create a "genetlink-legacy" based spec for DRBD and switch to it.

Note: this family primarily aims for compatiblity with existing
userspace. The next planned step is a new (also YNL-based) family,
"drbd2", which will implement all the actual modern recommendations for
new netlink families.

Christoph Böhmwalder (4):
  drbd: move UAPI headers to include/uapi/linux/
  tools: ynl-gen-c: optionally emit structs and helpers
  drbd: add YNL genetlink specification
  drbd: switch from genl_magic macros to YNL-generated code

 Documentation/netlink/genetlink-legacy.yaml   |   23 +
 Documentation/netlink/specs/drbd.yaml         | 1109 +++++++
 drivers/block/drbd/Makefile                   |    1 +
 drivers/block/drbd/drbd_buildtag.c            |    2 +-
 .../block/drbd}/drbd_config.h                 |    0
 drivers/block/drbd/drbd_debugfs.c             |    2 +-
 drivers/block/drbd/drbd_int.h                 |    6 +-
 drivers/block/drbd/drbd_main.c                |    6 +-
 drivers/block/drbd/drbd_nl.c                  |  416 +--
 drivers/block/drbd/drbd_nl_gen.c              | 2610 +++++++++++++++++
 drivers/block/drbd/drbd_nl_gen.h              |  399 +++
 drivers/block/drbd/drbd_proc.c                |    2 +-
 include/linux/drbd_genl.h                     |  536 ----
 include/linux/drbd_genl_api.h                 |   56 -
 include/linux/genl_magic_func.h               |  413 ---
 include/linux/genl_magic_struct.h             |  272 --
 include/{ => uapi}/linux/drbd.h               |   45 +-
 include/uapi/linux/drbd_genl.h                |  363 +++
 include/{ => uapi}/linux/drbd_limits.h        |    2 +-
 tools/net/ynl/pyynl/ynl_gen_c.py              |  293 +-
 20 files changed, 5087 insertions(+), 1469 deletions(-)
 create mode 100644 Documentation/netlink/specs/drbd.yaml
 rename {include/linux => drivers/block/drbd}/drbd_config.h (100%)
 create mode 100644 drivers/block/drbd/drbd_nl_gen.c
 create mode 100644 drivers/block/drbd/drbd_nl_gen.h
 delete mode 100644 include/linux/drbd_genl.h
 delete mode 100644 include/linux/drbd_genl_api.h
 delete mode 100644 include/linux/genl_magic_func.h
 delete mode 100644 include/linux/genl_magic_struct.h
 rename include/{ => uapi}/linux/drbd.h (86%)
 create mode 100644 include/uapi/linux/drbd_genl.h
 rename include/{ => uapi}/linux/drbd_limits.h (99%)


base-commit: a9c4b1d37622ed01b75f94a4f68cf55f33153a31
-- 
2.53.0


