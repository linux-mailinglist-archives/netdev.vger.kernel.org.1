Return-Path: <netdev+bounces-277640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLvLL9Cp2WnGrwgAu9opvQ
	(envelope-from <netdev+bounces-277640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:54:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8263DDE95
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B229630125D3
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4073124A058;
	Sat, 11 Apr 2026 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCxjHN9z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C46E1C5D59
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872462; cv=none; b=D59eFwUN7so4jWQIHV2mBxhidd1NahNsD01Ydrft2JtpWBmy9vXQphW9FlehJkmZSmgx+MhcNeDGE/kbkWDQQx9FX75frvLlzoslIKSsHKKo9XUdADP5dM8TApRrQULvn0D5m3+W0ZLF8Xuorq8a5opTPY6pxIACDWuaEwmQy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872462; c=relaxed/simple;
	bh=y1rD/Xlz+H3Uk2xCBv6acb5+esgcxvfwhin9b/OMVpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SVkMcdOZAhwxY4+shVDX4PlRex28kxEE1X7WwF2WUhvvwVjrTTXuGRNFy8d73KT1dHUNUn9ys9m9C+nsV6WHAShfgDipymr4xep8QCR0pJ2S+WeoSt6dhD7piVsOtjB/ho8UiT4evoK2btmGTStm/wr6RsPLfm7kWKqYssiFQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCxjHN9z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8296dabef74so2931113b3a.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775872460; x=1776477260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7aAGf7fMkZUFikXqLf4oYNOgRDcgvC7Fdq638y84n0=;
        b=KCxjHN9zPIxlmdnWGbYKW+Z3bVHOhaliJPLC2BQuzlY+j3RmTxBv0VsSdeUbEO3VBD
         wWbHy+kgseEGbP0GkNDEZesBi/nfYM5WzyOIFe6Pw8jMHuAHu0X6zc0EZAfI8VIbKU7d
         Sdx4Atd3binH4k5vYgF5qCUqFe5gMb1hghln22borSNffkGB1CQ4N4mysH5PwgGmcZEZ
         vw0T58pZ740O4d2hZbhPFrTVgTjcm7hXELsIwP4nbA+CN5mard9L9nNvVif9ddXh45+D
         jAWFYcZJNTManet8Z5+BrrhqSc1TgVpT36hqECQAniKKiowCfasqvznOVlzIsVMfOt/+
         MPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775872460; x=1776477260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7aAGf7fMkZUFikXqLf4oYNOgRDcgvC7Fdq638y84n0=;
        b=LKpXUnepSjc51B7lpUJzO0sQhiKDABn+uUhtxnehy+pQ/L7kBlYLPqcFdEuSOFeqch
         3A6ri/laZKvnmOebmBgRZK8TecLd6fMA+dBAme+lP+LBQjZ7yOpQ7gGJCP6o4v4rjQ9x
         E7zk6LDVa/V+rROvcu2lwxay0tpqcSSPmD4ZPi+qHjnRzzakYLEf3Hk/ZYqavMOaY8Ay
         +KFK/X7Cphh2P9EnOXoHMkyDxF2Iv66ZG0MwGLU1F5MU9tPR29e0nQ/yBufE0Q1kYt9t
         jh94LSguCGi8fMc3Y0KroQsS9sISw9T2HY3pFI9O22xm6LyRtqOTCnYiMjbvDSVCDZTS
         exIg==
X-Gm-Message-State: AOJu0YyygWJ5oCievgn+mcmXah4p/MQ5NpPzIMgj9wFCTVhoL0yz9MNY
	k7OGphQ6caRKvLMDgoe1jBw+FElXzTROKMCHPPVezRZIhGXKVHk3ZTce
X-Gm-Gg: AeBDieuZ9jYwpXH4sZwfehBJOzSv9yPvD4SNQ3m9aeiL5tGIMCl1VbJF4WjCxI+dsRl
	T32dAcMdDwgrLwwOhyP02Oq6eoRg2i8tqMjG0dYrarJ/Z854MMthvUkNTKClUPc1Ngdbz0ISXzi
	nBVi4XESSSorZ7xKdBmwdj/M4AiOwqfm8BB7MEePJiCWfujSzoHqrWYzw3i6tqu7CVX2mN5c8UF
	7BcBY98v8/K62OTCo2pzUKzQx2N72b53FtUftuJj2CA2ImZAnyst68TXXRh5/xrxeu72fT31QmB
	OFZ5B5HC5HSuyvpeyY1yPOdaek0DaR6HIy+26phqRZPY8Jv8biVbEjDpxNHa4eTIv+bvtcG8PfY
	pfTXN0t/oZDOXpGGWpPvBS+xQLL48wog0x4yUr874i81WXZfAHJiYla9oiejCdyxixvOsh4o5l+
	1FnXwUU/zDML967Q==
X-Received: by 2002:a05:6a00:3907:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-82f0c29fed7mr5926596b3a.25.1775872460343;
        Fri, 10 Apr 2026 18:54:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4dd37asm4244318b3a.42.2026.04.10.18.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:54:19 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] Use kmalloc_nolock() universally in BPF local storage 
Date: Fri, 10 Apr 2026 18:54:15 -0700
Message-ID: <20260411015419.114016-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277640-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 1D8263DDE95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Socket local storage did not convert to use kmalloc_nolock() since there
were observable performance degredation due to kfree_nolock() hitting the
slow path and the lack of kfree_rcu()-like batching freeing. Now that
these concern were addressed in slub, convert all remaining local storage
flavors to use kmalloc_nolock().

v1 -> v2:
  - Fix build (CI, Alexei)

Amery Hung (3):
  selftests/bpf: Remove kmalloc tracing from local storage create bench
  bpf: Use kmalloc_nolock() universally in local storage
  bpf: Remove gfp_flags plumbing from bpf_local_storage_update()

 include/linux/bpf_local_storage.h             |  15 +-
 kernel/bpf/bpf_cgrp_storage.c                 |  11 +-
 kernel/bpf/bpf_inode_storage.c                |  11 +-
 kernel/bpf/bpf_local_storage.c                | 146 +++---------------
 kernel/bpf/bpf_task_storage.c                 |  11 +-
 kernel/bpf/verifier.c                         |  26 ----
 net/core/bpf_sk_storage.c                     |  23 ++-
 .../bpf/benchs/bench_local_storage_create.c   |  21 +--
 .../bpf/progs/bench_local_storage_create.c    |  11 --
 9 files changed, 57 insertions(+), 218 deletions(-)

-- 
2.52.0


