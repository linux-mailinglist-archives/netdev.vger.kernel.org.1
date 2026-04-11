Return-Path: <netdev+bounces-277622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOlgBBCT2WnxqwgAu9opvQ
	(envelope-from <netdev+bounces-277622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:17:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD833DDAF9
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FCCE30347B5
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6FD271A6D;
	Sat, 11 Apr 2026 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA93PnsL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5420E334
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866635; cv=none; b=V4sGqnvtlK/ElVqsH6dopPneF+y2EFkmdqgWz+wqWzQmEd+B3cRqScS/1QYy7B1fKa1MbeA1qGqnwjX4eDLL+rsYtWDvUJyTpSe4geUFquN+JcB9j+htdlvKfbJOFnnX9NbHqPFiGksefC3u2KF1XtDQJbCdlRRLR1DFreqw2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866635; c=relaxed/simple;
	bh=lwr/BZdnzpyNNg2NwLakVIP3TG1oh36S0z/Hctq4hHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l/o8lSbVGSrjnHOBODV6aWYqKWsUsdZJdNMHct0goS568Fdk3Eamjf3ww1CLT+GnNFDj6+GCSJ59YvIXaBcLFrJvL4dbJ8ggxwOzwP4vbcd5zILF694wlV8m9zp2L5y/5cKpN+LDe0egaj3/TGJcQbLB0VS10yrHPMyecY8QDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA93PnsL; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1203749a12.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775866634; x=1776471434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGroRrPUmeJuw2t/fNDoydAUsIKWbQ4ohVi9Js90EoI=;
        b=gA93PnsL7T7q0KlPK2wAnNDdFebFyn1RNvffNGstJKOvHc6N5FavdX1aMbCQOdUt/I
         WhgtbPeWyIno/U4uLxoMedN7a5Keu7uQJ7ZG87xbvQQGXvzaA/EU+hq0u3aaK9xm8MqL
         krvS90GXzooMdLukcV+PUhTJb+aoeNqit+tyGZROBHMq9SJ0vuqSrNzTeUYZ+B5sIx0i
         u8/h+Omwq9z+9oPCS6/sPEwy/O/8DBxGUMbD/PHPqTwAxRwJcf/ctNskhgtsgwFKvF8V
         NLKgRBlJv89QBynotVABIZKdHYXjr+ewwotQU81XhxdN2HwmHbdyg9rL0vKcxgr+XSsG
         /thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775866634; x=1776471434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGroRrPUmeJuw2t/fNDoydAUsIKWbQ4ohVi9Js90EoI=;
        b=Qm2A0cGDlQMUSHDlo7x/Z3U4+qvYkvS1oU2DU76Jih85p8oWCT0tYGQkiZcEwtmJDA
         ZRXLP86H4dPurokJY6xKREDz+KH3ap01OQlape4giDWnEAB03cxPXK+K/T4Y2e3V0RTF
         y04sA3XEnykQgLZwndcTstHQSjLu97mmfTh5s4xutxP3uxVhsjqO760M71n2OJLagzU8
         LsSNozQ0hZkNqwg30ksTfqpnQ0WJVH+TSWpWRW0doMpH+cRGecIJp4OvGYyWCm3BO4Zg
         yxEWlxrOCH1Q4fuKrKAQW7XpYMQG7gKZ/qrtkzf4vCSh+833iaoEr8b+rYIpujzhCaj9
         f4Bg==
X-Gm-Message-State: AOJu0YxjJo4iYYh747y09OBC7fu3p8dF/yyvgVFY1dnf8I003LG9d4fm
	WIbvfyVyOXHXJHYGGHY+RQQu//zhnIoeTQUf9skmi2HgKWsKNY9GcB2v
X-Gm-Gg: AeBDievb21lihsCs952fFS1ua5GHvS44F3HxWXvJUiBeeesGEvtz+x3/UwYHhh+FC+L
	6cwTLvyrhVuZDV7JyQzVBUcfipW04y2gd1dsTjpuEMYWC469j424js/6IH4KR1gYeAYr444t7zm
	cwmqBvaMF7cHGb2Bmfvv81rDyX93YxhgmvxRQsTunEHEfsM01EmPHumOrWWtOxzo6NMZJ3rVMMy
	9Wp25lKZShroeLf+L+Hgqomi1nlSmcIvVM7/gtxMYi85ULFEccO0DcgPTvLvZyEgSOmf+ajh8zu
	jtIslmoGlP/itznesWV5lqXFuRdJwDoeGw2FgJiESbj3e+H72bCikaB3HzWLxbCr3FpjNZWqVe6
	gPFQSfpIUIV00EaBHNdgjAwxvUZJWkTgZA5UpCTPIYFYgXO0Wl27WLKelzakAK5am3elk4wmchx
	1Zl4NOseaHTA8d
X-Received: by 2002:a05:6a21:338c:b0:39e:badd:c1d8 with SMTP id adf61e73a8af0-39fe3f3d7c9mr5409820637.31.1775866633992;
        Fri, 10 Apr 2026 17:17:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b3b29sm4016549b3a.36.2026.04.10.17.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 17:17:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 0/3] Use kmalloc_nolock() universally in BPF local storage 
Date: Fri, 10 Apr 2026 17:17:08 -0700
Message-ID: <20260411001711.3418264-1-ameryhung@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277622-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BD833DDAF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Socket local storage did not convert to use kmalloc_nolock() since there
were observable performance degredation due to kfree_nolock() hitting the
slow path and the lack of kfree_rcu()-like batching freeing. Now that
these concern were addressed in slub, convert all remaining local storage
flavors to use kmalloc_nolock().


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
 net/core/bpf_sk_storage.c                     |  19 +--
 .../bpf/benchs/bench_local_storage_create.c   |  21 +--
 .../bpf/progs/bench_local_storage_create.c    |  11 --
 9 files changed, 55 insertions(+), 216 deletions(-)

-- 
2.52.0


