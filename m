Return-Path: <netdev+bounces-65694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B855B83B611
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB9E284B6A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 00:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328B467C62;
	Thu, 25 Jan 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gaAggpsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820B468D
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706142627; cv=none; b=gsaVvXEJx0/qjYIOP2vSZ7Dve05/h8OB00FNMUUYTP6rxGAgt32hDbUknuNop4KUUOwYwoC4lLn3c3ss+A00FxbTfPHoGCJEzE0oa75ooAioqaTE6FKUC8hV4xTu1TvRuj8n4A4pYmdEjGA0IL23824iQCpERtUazNvt/savyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706142627; c=relaxed/simple;
	bh=3yteI2ybUubAH5CujHpgcS7qoJxKc8vJCs7EzjX9vMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FgHSYF0c9MGX4LBVHWNQrZdIqHuaFT5gb4tCdG7Tg//JV3Y4/gFc+OXENHgIumaFj/aqisWy9kuBeLLSQrGusOjQDPq44Slu7jm2/sVEuGNxiIWfd+JEcLdNySlAjsfIZVXRbpDLrraZC2+ZAiMUJYwWcUfbA6DjBrUmLyTxdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gaAggpsK; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dde290d09eso4099611a34.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706142624; x=1706747424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o95DHArKhHsVxZUrtiTfK3GJrg5R+5zGPrNbLEZjDzs=;
        b=gaAggpsKToOW7QX/fR5ptTk0OYBsflX/Ed/vX5+0eTUAjjN0Oa8DysYCOvaJa9IofC
         Up6pR+f/zCm/78Y1tfVKWvjmqoTjRCZPUt3EXKaTDo3en3sZgPvLrxTCOd5SAO7YdX6T
         2REG85kr/vFEpiQBXBk2sdrq+Bo0EqIr8mbn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706142624; x=1706747424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o95DHArKhHsVxZUrtiTfK3GJrg5R+5zGPrNbLEZjDzs=;
        b=ZzVnopXRFqytkmCAMU5xgZkkNgdAy1/uY40icE+5PKnRsLCB6/9YdmArsfT+eEPyS0
         zA4RxhqYxX4qD0EjhCgwTnoPQMY3KatCvHRBSeqgoTA/X/RUDoWqYfWNVd4gI8C70bcY
         NKvuubr7lKief7ezs+qP05tGUZ4iJAR83gNeKJhNDuCxyhG2kqEZlKlY4ED+3eIEgUl9
         osPZfr6GM2k9hlJgB+kW1Euf5pyYD1V8AFHjr4ucUpxprsi06/k/xYKggq34j7AKCHGb
         jmi5JQT1WYv1aG03H4IeCe1rY+myodcnl1CQTY1O6tFyoB9980q56ZTFPfddeE3FdbMu
         tVMw==
X-Gm-Message-State: AOJu0Yy++1XKIhs9NCSGr8laSOhY1pcHGPgxM3YR0NrKQHpfI4z+vljY
	SVbiHBFTfWtrPVOyiYeZaAHc51C1ICAmXmyGLWPdeLtkrdgPz0cznRe8FX0Yy/mCuar7vh6xscW
	I3bibHBXGmLpiapl4QqpP5Umi740ZUh7/Kwj2B0IZWQ/3Es7cNvq6To0q03V2dYrntdwY1LNolb
	CIhztzuHDIVE4X0NrI6pDW9yPeubZnambmcgM=
X-Google-Smtp-Source: AGHT+IHmYMjXEPgnQyGsocCjhJTBUa/xeea8vBDEncnBG3yTUSNmvdiR9rqqD3XwYv7ig1n0WOsfpw==
X-Received: by 2002:a05:6830:6b45:b0:6de:9a8d:3362 with SMTP id dc5-20020a0568306b4500b006de9a8d3362mr80771otb.49.1706142623851;
        Wed, 24 Jan 2024 16:30:23 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id w10-20020a63d74a000000b005cd945c0399sm12550486pgi.80.2024.01.24.16.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:30:23 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	weiwan@google.com,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next v2 2/4] eventpoll: Add per-epoll busy poll packet budget
Date: Thu, 25 Jan 2024 00:30:12 +0000
Message-Id: <20240125003014.43103-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125003014.43103-1-jdamato@fastly.com>
References: <20240125003014.43103-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using epoll-based busy poll, the packet budget is hardcoded to
BUSY_POLL_BUDGET (8). Users may desire larger busy poll budgets, which
can potentially increase throughput when busy polling under high network
load.

Other busy poll methods allow setting the busy poll budget via
SO_BUSY_POLL_BUDGET, but epoll-based busy polling uses a hardcoded
value.

Fix this edge case by adding support for a per-epoll context busy poll
packet budget. If not specified, the default value (BUSY_POLL_BUDGET) is
used.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4503fec01278..40bd97477b91 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -229,6 +229,8 @@ struct eventpoll {
 	unsigned int napi_id;
 	/* busy poll timeout */
 	u64 busy_poll_usecs;
+	/* busy poll packet budget */
+	u16 busy_poll_budget;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -437,10 +439,14 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
 static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
+	u16 budget = READ_ONCE(ep->busy_poll_budget);
+
+	if (!budget)
+		budget = BUSY_POLL_BUDGET;
 
 	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
-			       BUSY_POLL_BUDGET);
+			       budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
@@ -2098,6 +2104,7 @@ static int do_epoll_create(int flags)
 	}
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs = 0;
+	ep->busy_poll_budget = 0;
 #endif
 	ep->file = file;
 	fd_install(fd, file);
-- 
2.25.1


