Return-Path: <netdev+bounces-117416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF4594DD41
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 16:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BCB282530
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861E15854C;
	Sat, 10 Aug 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQKDtvRw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F41C28E;
	Sat, 10 Aug 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723299963; cv=none; b=cb53H1R9jL3XuEA97FHCbm2XZvLedp6Nu1/m77M0vejDiQ4CAcv5JHxCFar3Dnj+vHdiKQngz2k/UvjxTb4V+bwwRU/r2XxUDf8m8U5patDZxkO+R4gyE9kBdgPBC+q8A3Q8bx+Ix4LDusRYiFFeF3sZEYieY7TcZK0ANkkkhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723299963; c=relaxed/simple;
	bh=6iYctb45lseE85ygDF0bq/6v6TsN7c+y5bkeSJNZepQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZanlMFU/dvdr5XTMtR9QH3W3VaqBO84d9hBXdVRuzC1zrI5sVcMBdKnH/zDwI0muI7cNORi/vhZzXod7HJmy7lyiRUfO7VlqVS9JfJiEwjt5TtogGrxfMiKJrlFdTHeucDuZ+Rjd1gxolCiH69NnykuXtRGbDuqXQ6peeCYBt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQKDtvRw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc5296e214so29385915ad.0;
        Sat, 10 Aug 2024 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723299961; x=1723904761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHJU46kp5NRUCO1dv4cjP/0P8D8p4Vpvquu0O6FzSjw=;
        b=XQKDtvRwycaZwicFniZGsmTqaVy51WThQi0d7VCeD6wKuXd5Un2oeA4JZz73jyKGuu
         99p/4LGHfIqBruLrXDD2a2okFjXHE7lXXrDTdSTanXIVRNEmR/Y9xnTVkCgI5lBnrsJL
         ztyUZCB8GcMP7XzRuN+kgzFO0TNzzQF66MikmkhQ1gfBviAbYMxfUSLqWoOAkhFUAYS7
         sVNxHQhhOqs6s5DMx4KFkdZVFOkDgTlJa2azEiyThoRlg06/J6GDdpxA5fLypZ0dbEu1
         /aUcjw45L5+jZP8x+MYu/Ta/CbKwT3jg7ZXlpN19p71OPldfFOu94aKohUTTtry0cxi1
         Q3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723299961; x=1723904761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHJU46kp5NRUCO1dv4cjP/0P8D8p4Vpvquu0O6FzSjw=;
        b=oYV+JgS3jh2IZaw+73SgHOszJ9HD496hXUEGpDBzPYzA1l01jp40AWo9CS1yqhn8oA
         DMxKyw5gbPEQ0N2O2dVPZv+rW4FPZmIOY6SbsoRGeM5e8Srop0AQHozfSC2zuXxGllgN
         Kvue2fKiadcpkQK6NGrfJrxbD86Y4/ZCTrsPOKenpA+VJXMievKY0lN83cHply3eo2I3
         BnjQDPcqRu6d2twTmYlVF8pCjtU/OjNBXalBIBTma1VpetTJr+sHqs6fUUwpZc0TBYI+
         pEITfBOF+YMC4ZmN6GdTrkmXSIGbYvRNMXd7ATDy8VrFYqif9L5vkaVxk/NqYA4GJ6iJ
         25PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyEXC4MU1ZrtgdtYl74WObLGe/e9+Qkaz3Vwf/5ihFstgKqDDCBBPBD9ehlW0b2/SKAI+58jFVUXHQwn3vxMQaFIkWvCSOZPrSDPvN
X-Gm-Message-State: AOJu0YzCxEqthssxbIgPQ3TIxVjCHDY1d1q9Ya1/O6K7elqsfXQFQB0M
	zpxiRvy1vbIuEfDfXCXEoDuk+ESVkMIfCtnPVdE621caGHWYkMS4
X-Google-Smtp-Source: AGHT+IESu8/btjRYxF0epSMSZmWR+7r93HywEzULcBpEwRzoi+fCeUwj3mvf0U2JFwpMBYGG55ginA==
X-Received: by 2002:a17:902:cec1:b0:1fd:876b:2a5c with SMTP id d9443c01a7336-200ae62f450mr58017405ad.65.1723299961042;
        Sat, 10 Aug 2024 07:26:01 -0700 (PDT)
Received: from localhost.localdomain ([218.150.196.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9b2124sm12284395ad.167.2024.08.10.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 07:26:00 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Moon Yeounsu <yyyynoom@gmail.com>
Subject: [PATCH] net: ethernet: dlink: replace deprecated macro
Date: Sat, 10 Aug 2024 23:15:02 +0900
Message-ID: <20240810141502.175877-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Macro `SIMPLE_DEV_PM_OPS()` is deprecated.
This patch replaces `SIMPLE_DEV_PM_OPS()` with
`DEFINE_SIMPLE_DEV_PM_OPS()` currently used.

Expanded results are the same since remaining
member is initialized as zero (NULL):

static SIMPLE_DEV_PM_OPS(rio_pm_ops, rio_suspend, rio_resume);
Expanded to:
static const struct dev_pm_ops __attribute__((__unused__)) rio_pm_ops = {
	.suspend = ((1) ? ((rio_suspend)) : ((void *)0)),
	.resume = ((1) ? ((rio_resume)) : ((void *)0)),
	.freeze = ((1) ? ((rio_suspend)) : ((void *)0)),
	.thaw = ((1) ? ((rio_resume)) : ((void *)0)),
	.poweroff = ((1) ? ((rio_suspend)) : ((void *)0)),
	.restore = ((1) ? ((rio_resume)) : ((void *)0)),
};

static DEFINE_SIMPLE_DEV_PM_OPS(rio_pm_ops, rio_suspend, rio_resume);
Expanded to:
static const struct dev_pm_ops rio_pm_ops = {
	.suspend = ((1) ? ((rio_suspend)) : ((void *)0)),
	.resume = ((1) ? ((rio_resume)) : ((void *)0)),
	.freeze = ((1) ? ((rio_suspend)) : ((void *)0)),
	.thaw = ((1) ? ((rio_resume)) : ((void *)0)),
	.poweroff = ((1) ? ((rio_suspend)) : ((void *)0)),
	.restore = ((1) ? ((rio_resume)) : ((void *)0)),
	.runtime_suspend = ((void *)0),
	.runtime_resume = ((void *)0),
	.runtime_idle = ((void *)0),
};

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 7bfeae04b52b..d0ea92607870 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1842,7 +1842,7 @@ static int rio_resume(struct device *device)
 	return 0;
 }

-static SIMPLE_DEV_PM_OPS(rio_pm_ops, rio_suspend, rio_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rio_pm_ops, rio_suspend, rio_resume);
 #define RIO_PM_OPS    (&rio_pm_ops)

 #else
--
2.46.0


