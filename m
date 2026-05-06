Return-Path: <netdev+bounces-284814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH08O8M3+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:44:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 598094DA6A0
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A445F305C5BC
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C244CF59;
	Wed,  6 May 2026 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="G8G1bFec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E13F210E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071182; cv=none; b=q7j6NiMjGULzAzvsInVssDbrnj8Z/9IBP/lS2cAb7e3HgBS0P91495TOSYeXzzq/JlpnDKxD5ErruofbmscwEoY67RP+EwEaYqeBuzQvJVPlP2j7YpxQSGL5posPCdOCOCzPlJao25EeHwQM6A91W9MXg2vOgIRKSGxtVcRXXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071182; c=relaxed/simple;
	bh=5fxNe/7C/qmME7G5REh94LbkahAVU1alfvlu0Z+8nzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1Z1liw3QViOZj80Eh3OcXEQSq8U3qG1CGW8VWNGmRlKIupPmfZfuGQLDQpZ7SPH1SYYG1W78mT2GHxRwcr3/Iu+cr+tH6CEWNMUA63/GRJC1PGEnekDZQde0eBRF+FCRqnXi+MEqOqX9n0fXI4xaMaF4RUvE0pjamj5nTa31+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=G8G1bFec; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba840146so56349575e9.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778071178; x=1778675978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfZRl/C1nUWxOaIb1UiTP5bzQ2aypWAqsTH4UFzskcU=;
        b=G8G1bFecxUYPvKiOw8j007H1QdXQgtfvMaET8nGSRLbnI18sFBxJtXNRT4WGlt5HaO
         MnXHHZ2wi0ncTXxN4LpiT/hRNsv5qTOeqLy104QQIMe+T9XX5ALQh6K0f0fSBURUk/bU
         5n1p0qJ5RfnQY9YZRawJeR5eDnwyrrzZsEo7qWdh2u6DmamxmDOpzzqGWXgaXraCtNZo
         VKJ7c7v0j3ZsDlPx+Vsw7SSMZZZxBvH29mHaa6f7hIYTv4uje+5qe0d/Nc9YqSFH6yjT
         wLLSVuAT385N2nRidhxfgZzi9JslpO5tVyjkhaFkTzxN5hVB8gNMn3RSFxc/Y8OQgxjh
         6czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071178; x=1778675978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfZRl/C1nUWxOaIb1UiTP5bzQ2aypWAqsTH4UFzskcU=;
        b=Vu5CGD+AjOqNTtdOk6ZrK1Zi9AQcJWjmOo2XIR7AabFhaDyhK/ncp2dwl//oO2OwdO
         bGwUX91fcsBtHDTO6MM5R+JTrbrrk/z0VaXaSS/lzWgav/ri4haL1qMxJpuzq/BZ+fmf
         iYWDeHYZMQo5v1GCO7I1TNNGajeoLmrH/P30FVKABsAIO2j1c+MLyKdpxm0esby1/olG
         /5NHeNA3eVkx2aTbRANtUJzTtURiXfUx6+qbu5bRfzPC6y9qjzxjKV/L0dMVzUOph5Vd
         eawFQqpEyDm2Xh2YQ0WtfcqVWQID4aDvYrmMJLPH5Nes5n83uS8s5iJfN8NE9szWxst0
         ltyw==
X-Forwarded-Encrypted: i=1; AFNElJ+0vcCggpX1iToQGFQJvozzCiuVxp2Ai5v8DCGUp+1p+TKApogGukTbnPyk+Vfg8u3YSz+RY80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVBGcA7nyP+qflSMqGdRYAgVtjxbE4fzfcCNgUi+i7bl7ED7W4
	7x2nJBHJ3t23IWs9sZVTKDntxFW4Uzk6l9gBqLSuZ/Udb1nJzcLqztKZhQnyBBDko48=
X-Gm-Gg: AeBDieuRQYtW5E2QSoNgH9ZZ8wHEnfOwewjqJlMAn32uqI26ChjPfkfrw2Ohn1RXqHE
	YN1bPB/hwQFfg9fje5bdvGcFTpSZOlZ3WInt2bgQ6K+CoWQTb0hdZu726YtxXoKn/PKRus1hoSS
	28Gp19vip/egXz/Bcp5OtoK+wP3chbzeGk8QwK66vNk3UiYI7q+3IUzsW46+j79nKQkYTp4WCkH
	gtvWILo2LoEJy5DmUpA4WMvgk3+Th82z1/o7p6OKG7q2JmcKC8YIwVZvHG56rbT3HOZHJj1sg5T
	zbeOUJ5LApiExOltMbbYZHRdRpcMJYTsBxqCCTgyxzO2O8oKsfTUJEI7GO5KXWH3u8LXRKbXskN
	P6sMQlKN/6IKMCoX+bmhtWfZnDd4pHGZ34tEi7n7BLVW6owLFrhsEHoEogS+RuTBKrfQWhsxmtX
	XTGSPxY316/4yk3NsALBbAo3oGt8vDjxWoN9eZwtMIDN+SV/R3FBgkjlEX8h8sZFxmKXL+lhGKp
	sM1Ru7b72O/hCAgW/02NW3uvgS2s/cM
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48e51f2f91cmr56154685e9.15.1778071178092;
        Wed, 06 May 2026 05:39:38 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53891d62sm76399015e9.1.2026.05.06.05.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:39:37 -0700 (PDT)
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
Subject: [PATCH v2 0/2] drbd: switch from genl_magic to YNL
Date: Wed,  6 May 2026 14:39:24 +0200
Message-ID: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 598094DA6A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[linbit-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284814-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linbit-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linbit-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linbit.com:mid]

DRBD's genetlink interface was defined using a custom multi-include
macro system, genl_magic_{func,struct}.h. This system generated struct
definitions, netlink policies, serialization functions and more
from a single "magic" header.
It never really caught on; DRBD is its only user, its internal macro
jungle is next to impossible to understand, and even harder to debug.

This series replaces it with the standard solution, YNL.
The *_gen.[ch] files were created with a modified YNL generator, but
these modifications are not shipped because the current DRBD family is
effectively frozen.

Note: this family primarily aims for compatibility with existing
userspace. The next planned step is a new (also YNL-based) family,
"drbd2", which will implement all the actual modern recommendations for
new netlink families.

Changes from v1:
- Remove YNL generator patches, ship just the generated code

Christoph Böhmwalder (2):
  drbd: move UAPI headers to include/uapi/linux/
  drbd: replace genl_magic with explicit netlink serialization

 drivers/block/drbd/Makefile                   |    1 +
 drivers/block/drbd/drbd_buildtag.c            |    2 +-
 .../block/drbd}/drbd_config.h                 |    0
 drivers/block/drbd/drbd_debugfs.c             |    2 +-
 drivers/block/drbd/drbd_int.h                 |    6 +-
 drivers/block/drbd/drbd_main.c                |    6 +-
 drivers/block/drbd/drbd_nl.c                  |  416 +--
 drivers/block/drbd/drbd_nl_gen.c              | 2606 +++++++++++++++++
 drivers/block/drbd/drbd_nl_gen.h              |  395 +++
 drivers/block/drbd/drbd_proc.c                |    2 +-
 include/linux/drbd_genl.h                     |  536 ----
 include/linux/drbd_genl_api.h                 |   56 -
 include/linux/genl_magic_func.h               |  413 ---
 include/linux/genl_magic_struct.h             |  272 --
 include/{ => uapi}/linux/drbd.h               |   42 +-
 include/uapi/linux/drbd_genl.h                |  359 +++
 include/{ => uapi}/linux/drbd_limits.h        |    2 +-
 17 files changed, 3650 insertions(+), 1466 deletions(-)
 rename {include/linux => drivers/block/drbd}/drbd_config.h (100%)
 create mode 100644 drivers/block/drbd/drbd_nl_gen.c
 create mode 100644 drivers/block/drbd/drbd_nl_gen.h
 delete mode 100644 include/linux/drbd_genl.h
 delete mode 100644 include/linux/drbd_genl_api.h
 delete mode 100644 include/linux/genl_magic_func.h
 delete mode 100644 include/linux/genl_magic_struct.h
 rename include/{ => uapi}/linux/drbd.h (87%)
 create mode 100644 include/uapi/linux/drbd_genl.h
 rename include/{ => uapi}/linux/drbd_limits.h (99%)


base-commit: a9c4b1d37622ed01b75f94a4f68cf55f33153a31
-- 
2.53.0


