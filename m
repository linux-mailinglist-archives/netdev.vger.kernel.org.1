Return-Path: <netdev+bounces-75758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB19886B10C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7087C1F23BC6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055FB1534E3;
	Wed, 28 Feb 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlP4LZd1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3B151CDB
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128766; cv=none; b=ZRCo9RCpEuAK47JU4EB7CI5z+NKeRD0SKYV1fOrHO9hW4ZH1kibfuMJczhBEIZz5ynpPnJivztCAp5+cqm1W6/Ii4LYyEYJ7t2DNuActIyY3TprMJdh8PmiFs+P1dn103sJ20e9ZzHHzYEXU9nJzul0AxTXKT2zNP61uzCnurfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128766; c=relaxed/simple;
	bh=38rh2rcGmYp3eG0FBJS3Tu+aaqrCsyjcVfRaI14cYfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BiY0zpzI+BgRsa4Db6t7d2abWhRP6gGcQXO3K8y08aC99xu2LdXT2LvqSkT4GWqI5f8+ul2+r1rkj1iuL0D7fsGST66ex/cfHQzQ/B2VBYtaMqBqScH+pI/DX+5bYJ1m92z1Kh/WppwXwMZhKV1Yl7NgtBci+HOSP8jtClsUiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlP4LZd1; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513056fe2b0so670179e87.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128763; x=1709733563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MsZV9ZXZHa4eODBeyDTojMy/w9Lw+RzL4frXmBJ1Rc=;
        b=FlP4LZd1q6lcNdKTXUSprhm6cSfv7AbJHii6vxDJ4n1Aw+kVOMOoSs1Q546Dq6RFaT
         +vT0tl3aSHt/gckTZqcPxspcpH7pM3YGB9pedMISralgNfc4nD1fUyg6lKoIxnhFHfjt
         Fyprh/5nULLk7LKS1lLcXbYr1nlimIV+lPmfoyZcVOVefnOQxTUF2uaKbo5nRZFtUqnz
         DVM0a1X6LhdJXZXYMFtrJU2xtDzEDZk4+NhZY7g3028j1HhRIQZnmq6ubsoz7nnlrEGw
         jkc6x2kniKxLUBQOdpjgpK4XVs+xee9kxeYtcKBjJYl9Ofd/U/oPtQRphco3ts4vCUxF
         YMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128763; x=1709733563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MsZV9ZXZHa4eODBeyDTojMy/w9Lw+RzL4frXmBJ1Rc=;
        b=tpcze27GZvsAAj9si7sIsCgyA9hWaOeAJJ5b3RhU5Q6Abt0J4WcOAC7vhJEVdMyoOh
         wo+Nlh4l5P/j66HnZsYzJn99WUUB584dWj3JELUDGS1FcxkxYZRj2VKZNFKJxFTZhzCR
         FCqx2ygP7nWKpzw54Ow6cdpDjAcISSCdTEJBY+/7DW1+oIbnYvrQ65yN6nbbbdAa3Jh9
         6kbskTS0ceX5OoVGsEEHp9BkuD7tP1iDd8z3qfAi3DX5mPQqUosIlANtbUySVXF7zCek
         6uHa0LJSAMCySLKHSpVccnhwYZaTuSk/Sb5dZNXsF9O4XUqs8dz7RuYzuAVN8IMkCR7H
         01eQ==
X-Gm-Message-State: AOJu0YyiMUX1VSECuxtQeQt/H5fxfqi7WNwz4oB3ay+2StT/yejIshO3
	rrCVTJek96IPChvLBg6tksdp4dFEp0G1AIlSwMCCPgXbrEGtazE4Q8QOoduJlIjebaFa
X-Google-Smtp-Source: AGHT+IEBmxTo1lGFMMPRMYm+k1bloOutCpq3Ao1WOO2bwYVderXegg6Ry8KBfJsaPVQaurycZsZ8Ow==
X-Received: by 2002:a05:6512:2820:b0:512:bc0e:27fe with SMTP id cf32-20020a056512282000b00512bc0e27femr7952528lfb.1.1709128763251;
        Wed, 28 Feb 2024 05:59:23 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id b19-20020a0565120b9300b005131e8b7103sm95204lfv.1.2024.02.28.05.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:59:22 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2 3/3] nstat: convert sprintf to snprintf
Date: Wed, 28 Feb 2024 08:58:58 -0500
Message-Id: <20240228135858.3258-3-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240228135858.3258-1-dkirjanov@suse.de>
References: <20240228135858.3258-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use snprintf to print only valid data.
That's the similar change done for ifstat.

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/nstat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc/nstat.c b/misc/nstat.c
index ea96ccb0..7beb620b 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -483,7 +483,7 @@ static void server_loop(int fd)
 	p.fd = fd;
 	p.events = p.revents = POLLIN;
 
-	sprintf(info_source, "%d.%lu sampling_interval=%d time_const=%d",
+	snprintf(info_source, sizeof(info_source), "%d.%lu sampling_interval=%d time_const=%d",
 		getpid(), (unsigned long)random(), scan_interval/1000, time_constant/1000);
 
 	load_netstat();
@@ -636,7 +636,7 @@ int main(int argc, char *argv[])
 
 	sun.sun_family = AF_UNIX;
 	sun.sun_path[0] = 0;
-	sprintf(sun.sun_path+1, "nstat%d", getuid());
+	snprintf(sun.sun_path + 1, sizeof(sun.sun_path) - 1, "nstat%d", getuid());
 
 	if (scan_interval > 0) {
 		if (time_constant == 0)
-- 
2.30.2


