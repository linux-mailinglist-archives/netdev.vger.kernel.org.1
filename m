Return-Path: <netdev+bounces-273745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH1FFxg5zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:14:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA54D3717AD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 144EC3055820
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51773FFAD0;
	Tue, 31 Mar 2026 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7jTPJeV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2173F787D
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991257; cv=none; b=HuECRyzEyjdcciyhzxArC9SyVXe0cQYzwKsf3Sm8piXGSt9ekbvsTvC066JEQ79hThDUWaRzcyIk4095U7r3vNhOPwKlPNse57z4E5seCYBQzUmWFOEdqj7evCP7gHkr6L9+mx2Cpl9hr+2out/TzYhPgKuSgsl0z6hzXoJyRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991257; c=relaxed/simple;
	bh=CeGlRCs7IM01/a/Kg5gDCFAH29SjhOjsTar/dGLyF3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crNe/AmexWGt5akSH4Dmm6/TAmOeNYm0K03z72eGgqZSvpGp9PW8icBftEIgMWNlzCNJiEYQAE81PMaamzx23u3Ca3PhFtuovcdkJ7D5FrtNvkFwSn41xfnXuKW2XINABhf1iHny3qUmOXThAFtrj4T1IrpsBImtyg+fe/yFPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7jTPJeV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso1972431f8f.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991255; x=1775596055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6xiV/Md8AP840O0O8l5DFejlK6PlJBQPDkc7TZ0VxM=;
        b=b7jTPJeVb4duFHiEvw3WdOj1tO9hTskE0pGZ8ZRzS8hokoPHmIZAYfnsMTHxOoHa4i
         dN9BAoWNJW2+vcJOd40exDKsbSW4/K3KavDLUxDYX9wRLM4mq3/3XxhhmC90G8MOccKq
         iGU0oBGyfaJouqaSFlTbUgaP6Ech2bkBF4yOGxT/1vF+K3ta6QXnwsRJFiJ6jHPh1p4o
         xJblxVprpjuqTfYEE4TuKfy+QvSnNwUdFnQy1YLVm5sBrLMKJn7Ir+KLWrYe6MabqBl9
         Zl92TtSymgjphTwnLm7b8vwdm6G1Ubtl/RmNkG5nzNBvuyE2LJxOBUN6CF9/lkZEcv3A
         IFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991255; x=1775596055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6xiV/Md8AP840O0O8l5DFejlK6PlJBQPDkc7TZ0VxM=;
        b=M3SYncFkJu8T1ettlYhKcDIOD39Gk0wbhvQem6gWLLo3KfG2h98ryHTw99Wf4i+57S
         On/TbDQb5d6OFK6wXq6M8mVAzHWFG+9yzhydQZtMdJ4QVvmBQ/PxykwrC/QZaC21bHTu
         ak2KIwcMuO7ncdpEulhCdITzzIMLa5L/tOr5xQxU9C5UqWFu2dtJjC8vItxoX+xmpEr+
         XGjM6kjxOa1XVj/y6Y2Kwe53BPYkKLkItA3q7Ene4S1SFVDC5/eC4BP1e+lGIYew0H7w
         6LvjblSVKlNMC3TY56molOn5C4rajeTC/UlYtoULEt+YPgXn8dlocBcBqmbRHRSPtRX/
         Awew==
X-Forwarded-Encrypted: i=1; AJvYcCUXFBPwCgcV4nV36eW9AtTvemln/1Q0QgxVjzfKkb2WNvq+Bx9IJu3t7N8cXhkN6UNKs0ndRLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5W15CmXJWiXx4I/Xtuv7EtbxPR+GSm5+f4W9HqNJz/YFfNe8
	l4PsSwtDcdGbfMAbIJHG70U3bxGZVLs3cYDx/aONJEXgIf8uXtU+XVhH
X-Gm-Gg: ATEYQzzJo19Pv9X8lAumyRLYKMwPnZnXWEEvmd9QXeyXM5RxRttCu9QSOyINXc80+5O
	luWWk8xoTFoyS/N0bKAwPCSQ/YU//j207mKQuE6hBIGc/GClXmCteoZkKf/QFaHG/Sv32V6wSjq
	V3uZwQKCQyJ2LCn/W6RJi5xZWZCg1RQKYga0jw2xQRf2+lPhGg1p0niawt5g5qibeEzUzTUZKOD
	ICmVJp2DWZhvqVF+Q+ejVnEKHoRkKZqMCB80r2Rcb5MO9OzU9Q4qaqZl8xutjoEm6Tln2VUsdxT
	b4Br7Mmd3D1ojyNLdiWeA/dxsVtJJKEpNa1M6gVSPWSG+wUsgW/q8J75eoxU5QgHaedcbLMse7x
	fGVgeyLSVdsiKEv9u9VZXJb0pqkmd3K8o3moihuGmzYaLVc4RA83pNpvBwktieucmSRSenJHfrd
	XLTk/k59DJNkF1Ck1ccmO0U4csWC1PoiJ7RU9G6xR/0yOgTggAILzuFHw98Q7fm4K2gGfr1gVc1
	/ENnjYvmALHzRQivuX0dBSBblSTsA==
X-Received: by 2002:a5d:5d0f:0:b0:439:d8cc:3626 with SMTP id ffacd0b85a97d-43d15105668mr1988984f8f.48.1774991254538;
        Tue, 31 Mar 2026 14:07:34 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2570b18sm32431393f8f.31.2026.03.31.14.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:07:33 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 v3 0/6] follow up zcrx fixes
Date: Tue, 31 Mar 2026 22:07:37 +0100
Message-ID: <cover.1774780198.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-273745-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA54D3717AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Follow up fixes for the recent update flagged by review.

v3: include the mmap_offset cast patch from Anas
v2: reject REG_NODEV + ->rx_buf_size

Anas Iqbal (1):
  io_uring: cast id to u64 before shifting in io_allocate_rbuf_ring()

Pavel Begunkov (5):
  io_uring/zcrx: reject REG_NODEV with large rx_buf_size
  io_uring/zcrx: don't use mark0 for allocating xarray
  io_uring/zcrx: don't clear not allocated niovs
  io_uring/zcrx: use dma_len for chunk size calculation
  io_uring/zcrx: use correct mmap off constants

 io_uring/zcrx.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.53.0


