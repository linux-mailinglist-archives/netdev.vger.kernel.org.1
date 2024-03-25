Return-Path: <netdev+bounces-81511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D9288A663
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1340B2A31C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7A818E20;
	Mon, 25 Mar 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIgLvCgV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3171B49;
	Mon, 25 Mar 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348120; cv=none; b=Xp5UXRHlsqh9GdCOW1hsCaSthaBfv7XEvE4+0o8hUOZJtKWLfqZJVdn8Sp8rsuIjDkCYQLmhtt0+02R8NaGdaARkrywg4lUEyNhgHY5ub6A2KpGmjJriCvGVNVBh4+mnQt+8pCANjGg/6vawQLRgEZylwQ5GwnEVt7HZM4NPh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348120; c=relaxed/simple;
	bh=kPBdh5SS5pZORafvsJ22i52oJzmbOCyYMHBI8MOB+bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PVhn+GESO+rp0Ex//dsfE8XWWBXn+na1kKEmKw7E5zv0lyhn2jofjf0vw6MuutpTr5mYF7573rOvINYY7IrOOaxAQfpGTNvO8LB1KAPOLtLyL40HlPtw0Pm0hR2GkwfOIZGHXzMiS1/Ls2LDxnUpeAdswinAq6ja7wMopoXSVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIgLvCgV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so2523870b3a.2;
        Sun, 24 Mar 2024 23:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711348118; x=1711952918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQmep/UU+G0+ycp01O4+/Bj+y9CF6AqqlbtM5le2tOw=;
        b=lIgLvCgVGlQqECOg4Bbi9UQXr63pIVv19g37gOYyS7NkuI6DlYFEbIoS6j9iApFxxS
         ypX1N5zgAzd6XUz0FCyFcRMe153mro/M+v0U3YQd363TLCifgfWm08GWx8k5Ll2ZAEmx
         TjhUM87V2JUrzv3n45vN7Zap73ewMrl+k0sj9RdiOgRjoEu8v6xvHXkl9w9csPQ3lQmZ
         k+KBC4eIW4EN/guCplpDw/3YWHKUfAr2kv/LDh9gh555cF1v8/qbvo8fXJNdxfqlMhmn
         uM8K/36GwU1zu0fs+vatIDtM+o/hIw8dlHgROFNGsjZ4pkXcXg3I7hBO7o6KS5fUgBi+
         xDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348118; x=1711952918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQmep/UU+G0+ycp01O4+/Bj+y9CF6AqqlbtM5le2tOw=;
        b=oxMEobcrXh6St9bLGDUGb8IBWcCqQVyWl5Bv4yMzpy7mj8eB45RpOSlSs1SQ2NzXSW
         +00v3vH0WdvwyI9LvU8Hq11WAxyM+eYpMG4lqpEClkm1ds7L5Tx4W8MO+Dc9Q+63vXIN
         vAB6ha8UUWzEYmIHjjVsZd+jz0YnkpDSSQ+ER55I23kHxM1X6Iot0alOOrkNXO5T9s+c
         DdIganOV5SnPeepKBIJ1eXnttDUpaZnistNRhuATK37f67+ZwX8cPpsRuTfYr7NfuWDo
         h8ds/1QMH5Ni4tFGmU2LuJRBsWzfRL05JfpLISRdL/zXYSz/7PhYeRuqBELK5eQMt9OR
         WbUw==
X-Forwarded-Encrypted: i=1; AJvYcCXa/l9y7yiuqvSgxMocFZJQeiHJqmAGWI9RuXJXO5K0I+e1JaNXLS2TbzzgAJnl2H76aFaTrUIc192N3QakWT2WtAYOB/5uGlW+PehKZqPVrHK/
X-Gm-Message-State: AOJu0Yyw+2nSAbh8hfda7kL+WJ+cevlOYuQ7V8JH7KhyJTxm1tGZ/ijZ
	mEkYMgObCcXBq7WXUwY8r7gcf0Y/jWkblvqFyC1uVpqppQIg+dQ+
X-Google-Smtp-Source: AGHT+IGPEEMZDGNkpLOB5TsD7voOSGGsp6/hRm0kYm4XZ6hSRvIobhimpSSWWfay6/CdifgPuulVgw==
X-Received: by 2002:a05:6a00:4fc9:b0:6e6:8df5:e903 with SMTP id le9-20020a056a004fc900b006e68df5e903mr7706587pfb.13.1711348118420;
        Sun, 24 Mar 2024 23:28:38 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id p1-20020aa78601000000b006e697bd5285sm3520253pfn.203.2024.03.24.23.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:28:37 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/3] tcp: make trace of reset logic complete
Date: Mon, 25 Mar 2024 14:28:28 +0800
Message-Id: <20240325062831.48675-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Before this, we miss some cases where the TCP layer could send rst but
we cannot trace it. So I decided to complete it :)

v2
1. fix spelling mistakes

Jason Xing (3):
  trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
  trace: tcp: fully support trace_tcp_send_reset
  tcp: add location into reset trace process

 include/trace/events/tcp.h | 68 ++++++++++++++++++++++++++++++--------
 net/ipv4/tcp_ipv4.c        |  4 +--
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  3 +-
 4 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.37.3


