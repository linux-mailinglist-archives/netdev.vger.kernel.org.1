Return-Path: <netdev+bounces-262191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OUOKBRKo2kF/QQAu9opvQ
	(envelope-from <netdev+bounces-262191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:03:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 445CF1C7D87
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 312E1301629D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603F383C7B;
	Sat, 28 Feb 2026 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh9cuxdC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAE383C74
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772302116; cv=none; b=HTZW1qiq8JUr9Fc54MfMpKvuar6+VG/eqFWzoGsv7neUME0BrzsnJlwfx7V2j4OUDTfLP24rYJnPmWubScVM01hyAh9AwYJd6QG9zwy7LwMCMJYp+7MGyGnONNwMW9VfUHrOmrB6HFSiqejbYbzLlgvZrdEYfS9Gg2i6mBVN/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772302116; c=relaxed/simple;
	bh=T8MKheElYMCrERWIN1kNw9bUZSTVWnvnyWPev6Vi2q4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZfBWe9KFzJytKV7fROUwqciwtsmiZgI5d3wZObimD27qp/3L95J5E/NCPF3wzLbDFRULTvp5FKLGouV5Pjp6RQQKP0HpaQBc+8m5oZE8oDsIlPmDF7UHMJMtkzI6Euv2wORYdSQ8T2K+JDSfLvwFJSH30zPS/REc6/yvEttQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh9cuxdC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82735a41985so1812896b3a.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 10:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772302114; x=1772906914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwAc3eqfbsDFXKOI/9IkPHAT12S5GKUgm1F1AhZ+6RA=;
        b=Qh9cuxdCQH3S62ZI9AB4FAacbmVPclHt8fLDNJDIG4n2PdkGE8YH5vNuMUFGzQJa0O
         Zip3umfmYiM34ZAI7vb4qilbKtnQcTD4VSzn6jQxXbXtw1iEfg9Z9+dckmm36usFTQdt
         5SA+Bdf6DfFjFykaP+27+LS7lrvNkDzMbbxV581Ch+SRzjmTtxxZupvvN8Y98+50pixy
         S5+kppVM3R27o/gOQYMdRvqJqD667t4L/EpOwqsyBCc2MhFOJb3qkdJrL+E9gaxRUaKf
         kSuvwPGzgnS3eWPthJ/SP5bufqDcBl3WO6NN+Yr+GWM3kTmCQxOvtmPfMqgtPV1JX7/J
         dsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772302114; x=1772906914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwAc3eqfbsDFXKOI/9IkPHAT12S5GKUgm1F1AhZ+6RA=;
        b=vPHJpyuTBdKxh3x3CenRq1gozx02iyLTiIijrFWvdUL+S4ouVKbqvCIO/NusemDXOP
         ndBMROyH63Xgq3m61iU6qLTshzT3DVdHraIgc/S969WHmxiVjdxiz0iM732J/rJ9ZjNg
         I8kcp774o1BGZsGddr6xOU+J8LDlb+ExtNXYBjbSPeOwWb4gjqSXIsvBePHBm51NNTGK
         Rmuiq9RKrZqJEdLNFTv6G4gFqgdvlPWO8jgUacc9WP5O6qZne+t0yukBxA2WF35XTSio
         BmbflGuwR4R377ZePKd9Ylw8YHtjTF+fOVsdrrGTkRKnrlsqrBLq5EGdBOJ1YKUcC4i/
         FpOA==
X-Gm-Message-State: AOJu0YxELuImOFYmFx1/aWjes7M+JPNbyfoG6tp5NS+uHxDBQZTiPrBS
	M0Tk3PezQlUQfZCZCTngUEj7+3nHhL/K+0Sq5P5ADpJqCpL9bEuJtdiI
X-Gm-Gg: ATEYQzy5zglY3ApgZeXU0lm4uDASy3++NE67oJohCctwWE9/jLF48CZuS50tKueTh+U
	IUS0bPjXe21mrtMpxSCfFFYnz1RMgbLXY4RJ4D3LRC3FYXj8vPwAo5u0CtXky9kGXnw0WXM9NL+
	xXhT/trY9dQFDhxB3uRp0VwUrLEo0XDH6wdph0ff0QPpoL+365BN83vEMALmDyFwtagFRsrVYtx
	CBqWKuED6unb5p68BqNVfwpugX4Apqz2YEO7miPqGrmccL7ps3ZJVQkdn3l1uy39cVIwTkBudC0
	RtM75CY963x9EMxnnlam5vxRtLP5Psnj5g4yz/CM3g7D+soQW1OkF8xKukSCL4IP1wiRFo0BPxd
	ffvOIEi6BV0o0E9ufZTsah3gPs5ykStApKL8dNwC96dy/ZnEimzw/C/88lp9RN0YRiaYvjUCR46
	vmJN1D3VPfmlt4VUoCVTGmUhiu6NL99sdk4VbpOE7z6NrrHEI4z94eauQ68Onn1gUOLO5c
X-Received: by 2002:a05:6a00:2e89:b0:823:786:1990 with SMTP id d2e1a72fcca58-8274d99c2d7mr5907758b3a.21.1772302114190;
        Sat, 28 Feb 2026 10:08:34 -0800 (PST)
Received: from sean-All-Series.. (1-160-203-78.dynamic-ip.hinet.net. [1.160.203.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm8065154b3a.36.2026.02.28.10.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:08:33 -0800 (PST)
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
Subject: [PATCH v5 0/2] Fix compiler warnings/errors in SUNRPC and MACB
Date: Sun,  1 Mar 2026 02:08:19 +0800
Message-Id: <20260228180821.811683-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262191-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 445CF1C7D87
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
  sunrpc: simplify dfprintk macros and fix nfsd build error
  net: macb: use ethtool_sprintf to fill ethtool stats strings

 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 fs/nfsd/nfsfh.c                          | 2 ++
 include/linux/sunrpc/debug.h             | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.34.1


