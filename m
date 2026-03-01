Return-Path: <netdev+bounces-262414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECIxM7ZmpGlcfgUAu9opvQ
	(envelope-from <netdev+bounces-262414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:17:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D272A1D0923
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B8E73008A5B
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586730E82C;
	Sun,  1 Mar 2026 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyZC87rE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED12773D3
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772381847; cv=none; b=fQ+FKeqBzAsV6D96sIuPRdg0866NeQX802DGXWp3NUNgkLzMnjooXywCkGZSxgAKYB++w2Qln7zagEbnxk5np4ARxrjVZvZwI7rot5wp/s7Bx7xEuryqYUULqB+vQWD21jwcxbSk6AGqWd21qiT8OcWLyuenw89m4w5jvzvPZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772381847; c=relaxed/simple;
	bh=QfrtzPBTQgtN7q9STXng21AoBcTIYcmlUXaobTZcOIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ggH9aBiFSq8wSyZEc2tLo9/aK3TDRxaF4EuKWwz4nPRQVsjY4frqpvlK4a7N6Zmslruvqq79ticaAAEWGfErxLaBoYjVN5EorU3XqzhINedK0+0XJhp2Z+X814hIxjzdnH3KjPjqlSKNLSgpb54npeK5hIUdC/8r9Qi8l1ytZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyZC87rE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824a9348603so1373993b3a.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 08:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772381845; x=1772986645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Os/820D5KUwvVqZOLIPxhxLinek0g8TJ2GUPXHxbYBg=;
        b=LyZC87rEguhRUNISDEuez7TmCfn3ENSNUAXPibV6FvEPGdbTp+rThaqh1MkOmv1mVo
         CR+DSRkGOYGMIaknOCqX6J7M1efzYAJ7JvyXq8N2OfBcVm1unUJBieNxoIWHvM5SVgXY
         9UHgONz6jjiVMGaHyjnb2KMpv5hmAR2vx1ijDFaqjY6JCdXMJG2DY/Sk12tiYmczji1Y
         54uBXyUGAfvWxgLhTROcPqMa0MPyHPcEZd5qR+4c1GxzwQ4r5CP+DGVnCcENcwTISd0I
         LwEC5Prmgh0nx3nqHWVPZKPKoAlkZwm1PGOVU4TZNDmjJ475jyGzA9ECAfSgvhJEe60n
         O2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772381845; x=1772986645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os/820D5KUwvVqZOLIPxhxLinek0g8TJ2GUPXHxbYBg=;
        b=GPa18FZ5PTHLJ+zT3vH2wZtWFAN1kTrE5sjt+0kCUZgyeRIVm3RxIRAdHc5iXScf3M
         XjII8RG2F6aNGB5BSkbgBVyiQWD3gkC/0HKgyC6uNH5EWTCM8B9jGTIlaF1dV+l3YR+O
         Ox5V50/zPe+j6N39IL34/IiX03nurAWHLFaNRoF/c8OgO83Ck73lVd91x2Ycwu23Keo3
         cv08xo9oplroyBRyXFWGRxzWrFO0y8TW7COXhKsCHr4CByxB1f27/0osfDSVfWr1/mL3
         fH8jT0ZuQKpz5heBbiaWjGe0jEnoweyckNwpGKeRGoE1Lteopa1VRp9g8NH2PZCWdpB7
         DceA==
X-Gm-Message-State: AOJu0YxqCA8bgWfSgl7XRC/JurTYvwkGOxaNGDoPDv1u+xHFuX30bpNQ
	xHwCly2r/claqB5C/dbTkbfLiRJhVmKZ5LduHcxRoUVobrcjiP/7dE7L
X-Gm-Gg: ATEYQzwFebGYglFXZ+CTZNIXTfX0LERg3un3p8uZ9vTySd4QhkIXuqZQFpvcdgedS9A
	tR6d4k14k59/2Yq0kNfDNNwWSYdYfo8keX4j0+y64JKGIKEgjfw0vClAPKhjk3z3Xb8j3iOVOhl
	gx3Y+4cY/L+lK3sV32W8xL3rXaKZ/CLfnmPJwlFdrOn3zsu3IsgGOWvVjG+w+iZg4QgKkEhGhp3
	PoHfohlCMHW+UgtIm1L4qBaLaZiUP5ROwsbaUenJQNbmP+v/iSu9rMPQ78TfWsSmJQO6ewbLqJh
	bfh0I7X2soFVd9kgFuqzZQAuguDVjRez6xQFn/YyfcdvXqLeJHxzKFHworherekbJiBW8b3hMaT
	iOVpCLZYqYuy191SKbj8wYKHdg1R9eGdrt5DhpjJXTTcM3pijTp/aaHONfEHJ980NTRPSF2roL3
	NAUAld4LpLcbE2HsVy913okunxwc4VPegSLJF7Ncm+6I6wdjUBxqYFvOwrPR/HspcIlYgP
X-Received: by 2002:a05:6a20:cc0b:b0:38b:de3d:d542 with SMTP id adf61e73a8af0-395c3af081fmr7302665637.51.1772381845303;
        Sun, 01 Mar 2026 08:17:25 -0800 (PST)
Received: from sean-All-Series.. (1-160-230-14.dynamic-ip.hinet.net. [1.160.230.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa61fcdesm8651456a12.11.2026.03.01.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 08:17:25 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v6 0/2] Fix compiler warnings/errors in SUNRPC and MACB
Date: Mon,  2 Mar 2026 00:17:07 +0800
Message-Id: <20260301161709.1365975-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262414-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D272A1D0923
X-Rspamd-Action: no action

This series addresses compiler warnings and a build error identified across 
different architectures and configurations.

The first patch refactors the dfprintk macros in the SUNRPC subsystem. This 
global fix silences unused variable warnings and, by incorporating 
no_printk(), ensures continued compiler type checking. It also includes 
a specific fix for a build error in nfsd (nfsfh.c) uncovered by syzbot 
in non-debug configurations.

The second patch fixes a format-truncation warning in the MACB ethernet
driver by ensuring the snprintf output fits within the destination buffer.

v6:
- Instead of wrapping dprintk in #if blocks, completely remove the 
  redundant RPC_IFDEBUG() macro and associated #if guards in nfsfh.c and 
  svc_rdma_transport.c.
- Remove the #if guard around the static helper nlmdbg_cookie2a() in 
  svclock.c.
- Verified via .lst and nm that both variables (buf) and helper functions 
  (nlmdbg_cookie2a) are fully optimized out by the compiler when 
  CONFIG_SUNRPC_DEBUG is disabled.

v5:
- Simplify dfprintk and dfprintk_rcu macros by removing the redundant 'fmt' 
  argument and calling no_printk(__VA_ARGS__) directly, as suggested by 
  David Laight.
- Fix a build error in fs/nfsd/nfsfh.c reported by syzbot. The error was 
  caused by a mismatch between the variable's lifecycle (defined via 
  RPC_IFDEBUG) and its usage in dprintk.
- Add Link tag to the syzbot build failure report.
- Update series title to reflect the general nature of the fixes.

v4:
- Refactor patch 1 to use no_printk() in sunrpc headers instead of marking
  variables as __maybe_unused. This provides a cleaner, global fix and
  enables compiler type checking.

v3:
- Expand commit descriptions to include technical details regarding macro
  expansion, as requested by Andrew Lunn.
- Test the different platform, such as ARM, ARM64, X86_64.

v2:
- Split the original treewide patch into subsystem-specific commits.
- Added more detailed commit descriptions to satisfy checkpatch.

Sean Chang (2):
  sunrpc: simplify dprintk macros and cleanup redundant debug guards
  net: macb: use ethtool_sprintf to fill ethtool stats strings

 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 fs/lockd/svclock.c                       | 2 --
 fs/nfsd/nfsfh.c                          | 2 +-
 include/linux/sunrpc/debug.h             | 6 ++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 4 +---
 5 files changed, 6 insertions(+), 15 deletions(-)

-- 
2.34.1


