Return-Path: <netdev+bounces-284821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP92MBs5+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:50:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEC24DA836
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88E593012332
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DE144D6A9;
	Wed,  6 May 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="Ew0dgU0P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E727421F06
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071549; cv=none; b=ijdJc+T0Y0fCF2JMGQOmbXpX8SGg58ll4i6xc6TR93BZGJJ7kB7aRytfVi1TM4RJzgSqnWSZ7XRDkUchkbWtdBRDkHxpEqrN8zOaoLp9ZPngkwsSBvOZoOpZtAWgmRILigyeNLTXxsm/WB8i7D+eOYbI9C7G8zk0P/yon7FYs+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071549; c=relaxed/simple;
	bh=/i5A7HvXIH2pkx3qahfYpWAzD4ix0sd0DqEnIeRVGm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k0GtFPYMC1Fgcs7neCRxhViPmKGlZy+PbxgykaEao5ZCrqvKp9702qvIMFZ68rtSYp2rWNRHx2cc7jCwxD8LZWNl8XVKodvu/TIjlgAmOHYkxqS+0Fpv0zqwk57ui69uzxnQxWc+Ilmu8s7N+3v8fbqCvSRl3ETJ0esHuWGRNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=Ew0dgU0P; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so80531195e9.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778071547; x=1778676347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xduljJRFZGdlBnAgyasd2iQDnZmICTkUp84nQkKVvPE=;
        b=Ew0dgU0PyIBzN7nFQAobH+go1LJQYFyl16yn4w49BXltTSa27cWrbv1a0U9hTt4LKC
         rQfrCIoayHA7IM8U5CtaXHaFUS4y5wkffhLwRjhlyACXBsUYbfL8iLbUQsjK07WTPRyL
         hDjmbj50y0wIT+2MW554wv2Ft4JzH0Heur+Iq9LhRTMk84KSHgAoB84m+t6XT5p3a08f
         IwBp8U35Y1d7j2xABWqx3jQJk/US4Luijb4O93dB3mCyr/GN5MOwEryLAGDFGtVaVOWs
         23X7U3p1ygs5syU9hA+3LsuRd8lFS0in9PljTt4AmnAM0ecTRdQRdfwW7Z2KSd+CtYIo
         mnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071547; x=1778676347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xduljJRFZGdlBnAgyasd2iQDnZmICTkUp84nQkKVvPE=;
        b=aAQraBl1xb8GhYU977em5/mk1tBfrbsb+WRDMytn71sK6JjVdzstsKXSGot9IoEvod
         Q3zqSd0K6Gx7bMbCOSBORktXl3WC3vxXYoVCmIsycXT1QSSMahNznMtViu92xfIO4n9s
         mfp/iPEXY6PhJZ/B0ERxlzHBQy7Z9Bvi/hLMtcuxB9hlQy+HccN5cuJ01qwlVQTJe8ed
         0Xm0VsIImxYVyPMZ1mMvAZEq+IL83jxh7KWzMYC79XeELmKYSMHyk3xY3bKWun9nV8vd
         apYO+7VQJb96FNh9s3KkkVf6V8VIpYp00VTe4hlk9ieNh1kiyGYrhFgwCiW7vi8IOgHq
         DZ7w==
X-Forwarded-Encrypted: i=1; AFNElJ+GWHwPCjEBlzA3VXlww45kF1Qnkiuq1lGYBX0o1W5wIWT2WU2aAuQyxvr6vTP2ZTCLmrBxqB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2c9MHdmoKJR82rBRl/x6fbR0UW9zghH8yDjBB5/0AyY7QjMf5
	BknhW1Bac3q0HOlAnAF0RxvZzNb09rnwS6x0eImWDwfqDfZeN3OG+JsxrDObAk+vYXo=
X-Gm-Gg: AeBDieuAR63UsRp7V0EWMMxXw6VDt0kP3Lk54I5X5JFw5rGml5jTtcAFT1IZKFd9hNN
	/GRQHkXHXgpaB+t3nJPe+ezDaYDI8ut6ZBUAVxAgUZscnvze/9pXgvL5iUbnXqimYll7MClYmQX
	+0nIPj3XpNUyw+9zxUL4cXNSOTZ2p+9GLfsR8ebJxp3ThqeqVdK3G3ftKes2lvLGROJF34xXZPf
	y45HkCY0HubjI2O4SWqA49gZJiuxtHB/Gbvabdei4/x7xeIGCZDwpJQNGT7GFHbAjYZ3ym7zhSc
	Yylo6o6cfWeZV0YaWNwh5xmrRtApElLPZTqn700CvUxn7gFnAs32W4wyUN+viIp5YRgmvTeRihw
	UhC7CVZ5b+s7d7k8wuC5UyVyKtHteNP4vCuCb+jG65cyfW6pHViAkeSWIZ6rr7ByU7gLbolqYNN
	6mHcQEe9YnzEHjUvB+HcA1FG8HsmiFJZobN6syYF0OymkSUWAVKqnlQlttR6JQwc5bwLwxlEvo9
	hPSNI+N2DJ2oCj4oxQZ65QJG4Ck/Sfa
X-Received: by 2002:a05:600c:4592:b0:489:1ff1:74d3 with SMTP id 5b1f17b1804b1-48e51f3c4cemr59553125e9.20.1778071546568;
        Wed, 06 May 2026 05:45:46 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm74792275e9.15.2026.05.06.05.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:45:46 -0700 (PDT)
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
Subject: [PATCH v3 0/2] drbd: switch from genl_magic to YNL
Date: Wed,  6 May 2026 14:45:39 +0200
Message-ID: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3FEC24DA836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[linbit-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284821-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linbit-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linbit.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linbit-com.20251104.gappssmtp.com:dkim]

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

Changes from v2:
- Fix compile error

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
 include/{ => uapi}/linux/drbd.h               |   45 +-
 include/uapi/linux/drbd_genl.h                |  359 +++
 include/{ => uapi}/linux/drbd_limits.h        |    2 +-
 17 files changed, 3653 insertions(+), 1466 deletions(-)
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


