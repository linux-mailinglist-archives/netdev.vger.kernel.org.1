Return-Path: <netdev+bounces-269457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GMNNSIIvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:28:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C572CCCFF
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC1483064D93
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B1333A9C4;
	Thu, 19 Mar 2026 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlpL6J2m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85330FF36
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929938; cv=none; b=e4ZgX/ADY7gv7/5TEv8bI5tl40CW0MvTUBDInCKwGvbvxq85zjVPhmu5LfNSyXmddHcXBr7SSUIJJ6T6cgv6DPzQLzpp4eVJvZJFuXu7xg0Dwymg5UBy9U9jEQkuUy1u5L3BMdaq2PBZNy7ASDfGc7zYHhh3tNFjllPxK+o7TCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929938; c=relaxed/simple;
	bh=cXaB6onOcmhtlbEQzAjZenJRjBF6efrCAwAQVv+cJrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qqDkRodR+fq2ju45sENip0LIROPIKwVGkoBqt6W9qafu4P5PGJO7emgGV5Dtiho0O6U/3jXVkra9wB/9xNqHeC49IueZfLw3m7laKnwJzdozHN1GpRJ5HL9+3XmPMPwnavT+ywayPQaQXqRZBGmsJSVoOVOLfEA/AQ9jB8WUpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlpL6J2m; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35b95a7444bso692523a91.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773929936; x=1774534736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pxDBjr6/ReCHWPKHk/iZN3r3a0nWe4360PPKYwY4WSo=;
        b=PlpL6J2mZyXlwQrAL7LGkl2fiVlbtleLQusEvdmonectOxd9FkxSMKFGajV6p2a8Qm
         jSeV2sE5Y3gec0TdFKZ6IxNRg2dB+I1pdAX6AdT7HUzFCUeIHl2fxbGC3qFrv9sVxicQ
         gVoSDrBL+btS9igXxepsRx/fkrDRZpRMb/asadw71h4pYDSvMSvruBmsXHuptyFKv6As
         Vk5tSvXem2rDp0GIMPsPDAGYCyMHY3J0W+C2AGuKoZy7HThjSalbhCMDYGR/cwySPh/t
         svHVWgnsVjRa6Mpna38rwFuKgTOs0tMK2QN/m/FIShkt55WnzP85pY0gl+hxA0ihWZkz
         Veow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929936; x=1774534736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxDBjr6/ReCHWPKHk/iZN3r3a0nWe4360PPKYwY4WSo=;
        b=pQlwSltmoQ5db+AI1kaLavHOkgfNGuT5Ec0JFIZS9hSkKgCeXHvyb/68mzA33grbVE
         4WwEGxxOFrebgqUAexs8zT8Aw2oVfM9oSl0NuXbDjcrsag6vjFPq2jxTVHSXSA9bq6Ww
         cYtedKl0aw2wv71e930GggN+FU+Ad8bvLyDSF/z/NouXw2nstxgKYD9+1yNea+nTiEWH
         lTVtAGKMEP5Mv+EwjEVBO1VpHM3zgBgWf1eYg5HEv1kY08H8eyuEPjAxVyz41kqwIoKt
         pHjJBTzmjLFp2DPyH7DO1DX5FToCpTiJ1M6NsEHwlbc4XThGbXpljo4ckpt0uaImyG7N
         LMUQ==
X-Gm-Message-State: AOJu0YyJVwsxFS5isXMVSPunZnVtnvjbbdjrDXfrouD42DTRDMreu2ZL
	4GyVvFy1tbuY3kpXfEKy0sRKfL2cxSrDo+ELSr/qv4wm2kbLAYiCjqj5
X-Gm-Gg: ATEYQzww1gt5pk7fvhjetMJrWHQZZjMSS+/6sevLaOQh9hRcrjdbR996G6Hw1YVRlTb
	cM4PooxZK4o96Gxa7pYR/t/A7DVDwQMckUUjuUSU2chkBcwo2JFwRK6eQWkDJ4eJ1S6XfEVLoKi
	zvfhYGq9tIBCyhn5IBQpDLaQMslKDGBge6+Z0k2yq4i6JT3F5iVsvQjtj7X4eSpj/ZYWjxkpaaz
	1a3ZZgMPUgvM9Ao3lTnZPtDcT03AXl/Gg4+yTlO+dvb5v0tXx/wYz13mXUyHbMUjLKWYF52/boP
	UrLUx5SLDSI5GucGUy8TjadOgMc0sSQ/ZMaEREWEeqzE1Lz36yQXKNDUJ3KhKstkTxMemu0wQ1o
	S7CmFJharnK2iIu6cfN0CnnQGxTBYfSSyAYRdNeoyMbcG7dKfJx6nk5PL8Bqxv/+Rf++DGJfz/0
	iHiCaSe+qJ4ftwOikmND3Z3S9l0nQPBo4CKbeQJez07cXZkYbejYFhADrmL4V3hvHDCrpJm8k=
X-Received: by 2002:a17:90b:3d8e:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-35bb9e456a3mr6473116a91.4.1773929936315;
        Thu, 19 Mar 2026 07:18:56 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63286ebsm2695321a91.17.2026.03.19.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:18:55 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v3 0/3] sunrpc/nfs: cleanup redundant debug checks and refactor macros
Date: Thu, 19 Mar 2026 22:18:43 +0800
Message-Id: <20260319141846.78222-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269457-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.656];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46C572CCCFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series cleans up redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards 
across sunrpc, nfsd, and lockd, as these checks are already handled 
within the dprintk macros.

Additionally, it refactors the nfs_errorf() macros into a safer 
do-while(0) pattern and removes unused nfs_warnf() macros to improve 
code maintainability.

v3:
- Added nfs_errorf refactoring and removed unused nfs_warnf macros.
- Split sunrpc and nfsd changes for better clarity.

v2:
 - Follow reversed xmas tree order for variables in svc_rdma_transport.c
   as requested by Andy Shevchenko.
 - Polish commit message: use dprintk() and remove redundant file list.
 - Correct the technical claim about dprintk() type checking.

Sean Chang (3):
  nfsd/lockd: Remove redundant debug checks
  svcrdma: remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
  nfs: refactor nfs_errorf macros and remove unused ones

 fs/lockd/svclock.c                       |  7 ------
 fs/nfs/internal.h                        | 28 +++++++++++-------------
 fs/nfsd/nfsfh.c                          |  8 +++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 25 ++++++++++-----------
 4 files changed, 27 insertions(+), 41 deletions(-)

-- 
2.34.1


