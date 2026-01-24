Return-Path: <netdev+bounces-253065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PNmDK+gdGmd8AAAu9opvQ
	(envelope-from <netdev+bounces-253065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:36:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DE7D40A
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78EA730041C0
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5F32417E0;
	Sat, 24 Jan 2026 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlGwy4JL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACC1A00F0
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769250986; cv=none; b=d4GmH7+mtJbHg/3lmHoVXN/eDMCptzllEBgSF8PHJCTp9H/zu5e/yuowpEWvT47PWlOyd/g27//mNSmXmx27uNJcA7+0i+A1tbdWMo/mBLLEZsRuY1xnf8VspBhMRP9fWrHiEiE0h30fGSP2P77RGCZh8yaY4KT1Rk1Wf6hxk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769250986; c=relaxed/simple;
	bh=uZktoa9nwKYOMB40W/F1FbukjUOG+xb9xQc5zLXOkvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alpmLjfiRiJw7UgRzjgdNyE+ujYxc/xXMdEk6syB4ro+UbRZBRQpXVrfrAxSHKycXVtCRuBd7jrmJ6RrWCe3emMx27349YeUjOE0SMgvszi7uhKH9RAvvyl+rOEd9VBYV7dodvWW6Fw2rHvh4siNbWTm/Xtx2mfJk79dPyI7Dho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlGwy4JL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48049955f7fso23479775e9.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 02:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769250983; x=1769855783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=id1hLw6ZvU3sPPbM3xii8tiFX5fv81jh+WFXbM2/0Yc=;
        b=HlGwy4JLDnzyJms5vM8NheI4vWHCgioHk3SUGdv+9NMfx4aq3vmgOeAhan19bPXsY+
         HDuVfcQ1wzwOohtvUIMr8E/VWSxHgN7JSzBmLMVRACt8nZ3HRWSEzYrN48/yoPF1cXHk
         b2Uc+NkruQlY04nU+XavDJeeXvmepOWRmj8KiLg0ECxfzwxjGNz/uLr8lNhTBhPj3k8n
         qrlhRg3Mw++716IH9dawx5gz1UlNJLRg8v8zBTz/RjbKMbciSjqkyH9Xjl+EWFTi/uU6
         WgNmMk7ii+5o0ZRJZfLl06qhKVpZEO1h9u7XbDPFPQKNP8VyZ2Oh5TsM02LuTsjBxZGR
         Qb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769250983; x=1769855783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id1hLw6ZvU3sPPbM3xii8tiFX5fv81jh+WFXbM2/0Yc=;
        b=l52bPlqzQfhCUJuaDKKOcLyaW0q2ki7T17d9ORe2ilCQrs/BBrOfgalYAMRH/Ie+zs
         FSC+Reg1Hv/oWflsznY5TfdfbF8QMRMuChdC8DdicxTjc88iAgyXlQ60LofWX/iItiHU
         UfyyEQDHs54wLKI7STjCX8ogi2mszpa2AIbioa2k4xWwPiaejz9vjOXTHq4PA4kL1HLZ
         6Ufo9WI+85XnuR0BWZL0aB6SUMVOBTV8QvqJboj7ruB2FR/W7bW/Ex8y2bO9EXmaG4f9
         7LuPsHKCW9UvcCuRnnZ2y+it34Zg3QnjGZnjFh0nlER4ReouTRIe26sHckQbKv4eRNrf
         FuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Iv3c1k4sFwxhRnyEZSoaVEdPlnMPsoA38yPNqvM5wZYFcylM8nr7qI6CV6zkVaoUWQgq8yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcdSr9+D1Iw3K7A4dFl3yDQxGkwS/dbRm2GPI5uxBU/DquuvM
	uTdgQ6cBEzjhOqM+yCIyS48+H2qpB5H4wZb0/peb6KDlabuDP3A6zqUqDO420Q==
X-Gm-Gg: AZuq6aKpp+mZ+ayFkbCkMf5nQXHhqkcL1uJuygyPxDy9LOm/P8uL49AebbJA3rSrZsc
	o1sc/jdvtqBffs7XLp2Eqnfe4MiIKIsT7zrmmBl2tw0JTdW+c4KsHJP48ne/+8yTBZyCoQ8Bmzg
	DlKNdRZwzvElbixVCHRfxL+FgfsJGuVsUu1o402cJ7P44qdfeQSSj/Nn5dG2jWTTlabRrIMpsD6
	IZZ0hjF9857CzSU2VANnaAc9EGvulZSV3TQAwaP6gIBbQXfrbaaCiTvCD38tzWWnRf6/PJ2bwIo
	+RP3/LZQSnK1JMHFIvvnIYqztZFS5jrqcRbHXOBddSP77Z5WhmfKL26fD2YK2m81mpLiea8wOyU
	HRVo8QkRiaP0UxIWWVDy18zQkeXydIqvlUCy1fH3d3mM6z4Z9/pApXQDdmCxPJzwmuYSCGfdEGh
	+PVxsCjBc/3KCQTLs89vWk2cxTPP1mkWWcb3Umo8s2rQW2PkZyFOpuWqh8vhdlctFJ9ICxr3sMm
	fxu56HwvZDIQ3xvzg==
X-Received: by 2002:a05:600c:1396:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-48051256163mr62601405e9.26.1769250983210;
        Sat, 24 Jan 2026 02:36:23 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804db8da59sm46164855e9.5.2026.01.24.02.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 02:36:22 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 0/1] io_uring: zcrx large buffers support
Date: Sat, 24 Jan 2026 10:36:16 +0000
Message-ID: <cover.1769249792.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-253065-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB3DE7D40A
X-Rspamd-Action: no action

A single patch enabling large buffer support for zcrx by propagating
user parameters to the net + sanitisation. It depends on net/ changes
that can be found in a 6.19-rc5 based branch [1] that's already pulled
into the net tree.

[1] https://github.com/isilence/linux.git tags/net-queue-rx-buf-len-v9

For convenience, all changes including net and io_uring can be found in:

https://github.com/isilence/linux.git zcrx/for-next

Link to the netdev series:

https://lore.kernel.org/netdev/cover.1768493907.git.asml.silence@gmail.com/

Pavel Begunkov (1):
  io_uring/zcrx: implement large rx buffer support

 include/uapi/linux/io_uring.h |  2 +-
 io_uring/zcrx.c               | 39 ++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.52.0


