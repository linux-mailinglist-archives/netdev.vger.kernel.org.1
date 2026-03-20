Return-Path: <netdev+bounces-270012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFJOBVmOvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:13:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E2C2DF3B5
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97AF0304899D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA743E51F3;
	Fri, 20 Mar 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ0ZoYD6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC723E4C74
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030248; cv=none; b=FrlvVhaagRhrsdxe5t/boPEWO7VcfbgyEkhpf4mBcbOU66dOAEv/+BPeU5ESvFsM2mn5IqRfBfjrDx3VzUPjRQCKZS3kJZ3Q0I/c79lwIxsTK8TPuML2f7D7JymHg+v5uwnuVHyVY8pmSf6hgkSCB6OrH8Hz7bMKhQATet06G3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030248; c=relaxed/simple;
	bh=bUiSWNCV/q5GUTFEbO+pksJYyRD9RwJfg6d89NZyVP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ssGfrKVj+ZzeIDjdu0khtanVFKsGPuIzOyrqH/Ic2K6GK0q/adJ1M9YD2i2QxFxn8DvPZEy3RDqr+F8/pk8OM8Tnj2ZcKvjtE9+RC9DfcJsl6beWbGfu5pmWycpMzTQaHQzyD9AmhrPGanQj7b+HfbKbgF/iJHzvayTX2uNSNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ0ZoYD6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so1066509a91.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030243; x=1774635043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nlLjQPOmeaFila1aoTGt7mA4cxCj5RPLrmoLbYLboac=;
        b=KZ0ZoYD61cxyevsY8aNSJncPBT+8tw1VX2NXfdSFeaKpy05cnXzIfSbpg8lV1bnpnp
         wRPTa3B5AWIaBiwRlEnmfQu2vkjlKofsZyEatzVeup8A1VpjT1EAtGeJM78PagAMhHsv
         5+qryXzH3U+Xc9a2veZoPQph6g6csC7WxVGWcV1lFxv/H8W5Zi+3dNhnVW+bVA9051Mu
         Cz+oKWO3bsM2h94QNl52VIl9KA1EdfZAqyLCk6cqfi2CZ2PvoDYDHyG+Vlj3eKfDmh0b
         02YZnVW11RybGH16jnOsbv7jWAhzAVPIqs6XJfBQmHroB+LH48wU63OFe47kDbqYko/8
         ySmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030243; x=1774635043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlLjQPOmeaFila1aoTGt7mA4cxCj5RPLrmoLbYLboac=;
        b=ntFWOHDj2a8DtS4debdkc4rmTZ5EzyxJ4GCecHb/i1aCjc7zrXVHEpWsoZhdlukJtZ
         pFYbI0Ut8QxUFKIAXBKJOTGj3RdBtmwIWWJYU/of1Ya/Skn48AFXWt0stlG0lGUzhl11
         0nxoJrpwwE5yV86ePMP6CGSFeGebn/uKYexEtDO3Y87BFnlh6BE4poN7nzpDQogbSbUv
         3MC30RGUc5HH8kJwuhXj/94t+nakNaV4x0U/9leeAjqlmpkPqI0NKmntLsj2roOVhLkP
         A4bH6lFYZFXT1JCOvwY1rxM85slWH+fvowm7U8cQ9Sp2coAVbVkd+vj0E8xirTPLkUT+
         pVoQ==
X-Gm-Message-State: AOJu0YygkhM0bO+/BAA+Z+qsw/BnF090Bhc/motJNjQLCHE8dw3AfI5g
	MjTFTUK+ExPS7l4Id58zkgHhzYz85aZxucZMXCNLC67XvyYzvTgbv+o7
X-Gm-Gg: ATEYQzwX0dXrF3Ewlx1D4fixlndEJVFVksQA8ydn05QkCOtHi8PEPIxhtirJ08HHD+r
	81Vrx2iGDfaLYkSy8gG9cqH/YbnYf2sfxD708XIogbhr+A/4wGAd52no9pbgSpZ0qZZZ7kLuvXR
	+gJUsVE/oidmrfdRa/OPJj+lq+u5jYlIx+CseLI8/Rls7rCwyAG90/P2rhe2FpQ8v0NTxz2NvZt
	1vOvkJN0lo8uUA8/zb5PtXP0gEbGzQ3wx329ttlbX4RgUvbpNn+zi03aro6oVklvR3arDEh2P6B
	2GH1F9HcRTlKJqSODAuru03ccNDtrV443qCNp6jdqQ7MnSVXHyCPeAiHi73Pf2H/bJ0GlYYX8WK
	D6mWz7mg8ZZoH1n6Q9XX73bnO/G/2jN4AGjdbYgtnOLRzEmyBt0iBWCsRUZ4fZe+en3H9JrOtNA
	QKHIID+m5S7EHvdgaXn8m/3lkDWPGD3+2nR0Sj/AQZD+xpiXT45SPG830hs/tVeG0NsyFwkQgV+
	36mfm8HZw==
X-Received: by 2002:a17:90b:17ca:b0:35b:98d7:a67 with SMTP id 98e67ed59e1d1-35bd2d0860bmr3278434a91.31.1774030241779;
        Fri, 20 Mar 2026 11:10:41 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd368837bsm959352a91.11.2026.03.20.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:10:41 -0700 (PDT)
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
Subject: [PATCH v4 0/5] sunrpc/nfs: cleanup redundant debug checks and refactor macros
Date: Sat, 21 Mar 2026 02:09:50 +0800
Message-Id: <20260320180955.150696-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270012-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.861];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2E2C2DF3B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series cleans up redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
across sunrpc, nfsd, and lockd, as these checks are already handled
within the dprintk macros.

Additionally, it refactors the nfs_errorf() macros into a safer
do-while(0) pattern and removes unused nfs_warnf() macros to improve
code maintainability.

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
  svcrdma: remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
  nfs: refactor nfs_errorf macros and remove unused ones
  nfsd: remove obsolete __maybe_unused from variables

 fs/lockd/svclock.c                       |  7 ------
 fs/nfs/internal.h                        | 28 +++++++++++-------------
 fs/nfsd/export.c                         |  2 +-
 fs/nfsd/nfsfh.c                          |  8 +++----
 include/linux/sunrpc/debug.h             |  8 ++-----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 25 ++++++++++-----------
 6 files changed, 30 insertions(+), 48 deletions(-)

-- 
2.34.1


