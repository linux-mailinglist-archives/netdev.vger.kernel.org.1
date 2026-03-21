Return-Path: <netdev+bounces-270216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IeIFASovmlkVwMAu9opvQ
	(envelope-from <netdev+bounces-270216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:15:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83F32E5B64
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56EA6300F52A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8932F6900;
	Sat, 21 Mar 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTfAMkmw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A685280CD5
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102529; cv=none; b=Js1jXW69rIbTruv2NFJt7VK48Z9i3Z/ajM4/Qeu/JRHPy/z34AtdFpdCjAUXHtg3EnFRGUqkGHMrleA9UrkfYKLAh/IV//BMqToApsDuApSkhZmQ/jrbRgAuoEZkiNZjsZo20Y9+aJd+fek8eh5MMwU9i7A0TyTM4FzvcjryEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102529; c=relaxed/simple;
	bh=3+K/ApuxwjyEMBrtQSSDiQv9ECGp4Y+q1xsZnKf+JrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=idDbjzfeOsKPBBrUXeOrBJg1TMZODVWLvuMOTL3Dt1cdJABBSi0V02fG1eL1OWsPn++qvpHZThcXlvM7tv1mMLiqWbdewOU+ajfs49oP3Ko7OoF8rayqZYqvCtLsmwM4i7+JVHw7tQmHAPdGYx2Rozdrj7sEKwDTFBfhhQgbRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTfAMkmw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso598731a12.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102527; x=1774707327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UuapLcFBj9/2tM0hd60ExcnAcuLnRL+SJ5nrXPeI/3k=;
        b=RTfAMkmwC2+H3DbdKJDDZ2ynYzlTPr/6B4yrsKU834f02+kxycSySyQfZ4+q4poT5J
         CqbJ/3vLE8+rwNoUiDgFyIaGt+bku+ViMxdTWjaLlZxDOlOZtYqQGvKZVHcL/BwtMUFE
         PwcZjIwtAj+Ljh/JEb1wh9SUeA4/cs9+xUW/utrhV/82Nn6PDbBC0PR/Ljv9nd/qLCIC
         ew6nLhPCJzpul74+rDufHlg05BtD1JHdYmR3YrKxSnuPDL/C//fCBBbOp+NFAs5CYapI
         4McTQku56GKI2Mcugqji+oAVkGV+ZNr52+FLwhqxcJvaYe8esLFBWZtxcplvZ93cRxee
         /mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102527; x=1774707327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuapLcFBj9/2tM0hd60ExcnAcuLnRL+SJ5nrXPeI/3k=;
        b=KSvKwk+oxqbQQcH6WBhfJl14CFMekNd/r/0whD2zDrP18rQlB12YrKOc8tqrxUK71j
         ZvM5Nk+Ex0q79Phpii2nte9vTemNVAwV3cT2+UXkmbuOlamzlsDjiBVbSGuEz/TfsNqP
         sQir964o8QNp0/OGJnlcVddAvEFO8i0Mwu3BCeej6twqHQCrwzufB/Qi3l1wCjZD+yzD
         kDDbJ+vatrdfYJRPgT8aRskLC3t3Tao/y87ryTlUjACmhv2PWpq2qcWSXv77t7eZF0Vj
         aHtBuhHbXll36l3R9aG6hGs7SpD7oSml8NMCvh76VEknH6bS/BA3zrSN/WhGJQaZte3T
         XeUw==
X-Gm-Message-State: AOJu0YyxIBUDz75STFMxcdP5LWuWpQTZznS1PL1vmyHx2c6WZhcBByx3
	ncrC7rWJh3T28nMMeMnSKE9WFubzlQ1MARXTCDZj72wohEpv4/XqfM4jhA4KoA==
X-Gm-Gg: ATEYQzxtec388MKvmVCIeWOB4kQbkyn3XQrhTF8OBQjbm2dNeeocCgsakT3I3XDvKV7
	OZVqhP1BpxUaJyRcG9nm+wdNVdUW0ZhfeQsL985McvmcJh3dK2pOIcG211/by4xT4VGnsnErhXi
	v7L4w0QCvXgb5tjisQy9qD5UzDGt9ihNhM/9spLIpD30cZoEvdBIhOFRG0BKrff5K6GJaZkmVeA
	JDUwcGJhtaWbw//mTFM2HtXSkMy/BAi6z3UHbhJDbojGfVof2zHRUXa+wPEhWy0OGs4usYy4FbM
	7z6eWMi4HM1Qt0xEw+QeZQStFB8b+qMO4zSHNPlrZUjnhtopj80gtbiUedjcNW0XCJrPTuMmmx5
	4t1aplUsvtcdmpAslEu5NvqmE2Ev94cPFPEpi2sWkogYFGVQkkslecmMU9gxOqAsr5FHyHoBoWB
	aKSih36yltJd4GXVT3sScetZYU0bmYcCNZVa/Qhxn/yjqM4Pz7JrR7UjEQGh1g74UxwF5MmKYJK
	zqHsOHywQ==
X-Received: by 2002:a17:902:e54a:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2b0825bf592mr63385375ad.0.1774102527511;
        Sat, 21 Mar 2026 07:15:27 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm52680715ad.25.2026.03.21.07.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:15:27 -0700 (PDT)
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
Subject: [PATCH v5 0/5] sunrpc/nfs: cleanup redundant debug checks and refactor macros
Date: Sat, 21 Mar 2026 22:15:05 +0800
Message-Id: <20260321141510.68214-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270216-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A83F32E5B64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series cleans up redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
across sunrpc, nfsd, and lockd, as these checks are already handled
within the dprintk macros.

Additionally, it refactors the nfs_errorf() macros into a safer
do-while(0) pattern and removes unused nfs_warnf() macros to improve
code maintainability.

v5:
- Reformat the cleanup of __maybe_unused into a formal 'Revert' patch as requested.
- Update the macro refactoring commit message to include historical context
  (commit ce8866f0913f) and use backticks for `git grep`.

v4:
- Add a missing patch to include/linux/sunrpc/debug.h to ensure dprintk()
  properly handles variable referencing via no_printk().
- Remove obsolete __maybe_unused from fs/nfsd/export.c (revert ebae102897e7)
  as suggested by Andy Shevchenko.
- Add Reviewed-by and Tested-by tags from Andy Shevchenko.

v3:
- Added nfs_errorf refactoring and removed unused nfs_warnf macros.
- Split sunrpc and nfsd changes for better clarity.

v2:
 - Follow reversed xmas tree order for variables in svc_rdma_transport.c
   as requested by Andy Shevchenko.
 - Polish commit message: use dprintk() and remove redundant file list.
 - Correct the technical claim about dprintk() type checking.

Sean Chang (5):
  sunrpc: Fix dprintk type mismatch using do-while(0)
  nfsd/lockd: Remove redundant debug checks
  svcrdma: Remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
  nfs: Refactor nfs_errorf macros and remove unused ones
  Revert "nfsd: Mark variable __maybe_unused to avoid W=1 build break"

 fs/lockd/svclock.c                       |  7 ------
 fs/nfs/internal.h                        | 28 +++++++++++-------------
 fs/nfsd/export.c                         |  2 +-
 fs/nfsd/nfsfh.c                          |  8 +++----
 include/linux/sunrpc/debug.h             |  8 ++-----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 25 ++++++++++-----------
 6 files changed, 30 insertions(+), 48 deletions(-)

-- 
2.34.1


