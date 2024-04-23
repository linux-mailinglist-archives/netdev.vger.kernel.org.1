Return-Path: <netdev+bounces-90654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D748AF6B9
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 20:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BFE285384
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9A46A03F;
	Tue, 23 Apr 2024 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T06PXO27"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CC1CD39
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897547; cv=none; b=MgyUnVg9n64GVIGS2JxlKiAdU3gJeKBhW/SHzbgTBbCXo0yZ04OXEj8fLXK3RP65PHnLfPmk/XrsTVKtMHXQi9bld+uofAVsRcooR/LK+vcyjyVzJD1WxoH+2j9ZP2H+dsZTsjdmgbYpvvfMn4u8l1R/vDxk72fboTxJ6qlrNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897547; c=relaxed/simple;
	bh=HlSq4+53kpIvVV698i52HU1Q1lk4N9kxKXA5tq73oPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T8sxRZGbViogbLqvwRUcECZ368oqBLSBpKdgb5D1FeAt+V3aQtXLgslI5xMo9ZiSqtBoxaSP7Hf0A32HZG7r66+28eZwhj931q+qq9fShq8mp+bMQVmzsHNHSpq41sAowHi7x1Vm29WDt6plIluUe53jZnu5HUWu+S9sW4qnOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T06PXO27; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a5b68eceeso18931725e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713897544; x=1714502344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11PbC9TVWukv/d0s3ZoI8BIqTTqQkSG5khgm1hVUYh4=;
        b=T06PXO275XnhKTa9frOQ9A/Pw/8+Xsz/yaAccPICY83FsqAb21vYa1CgnisX6Pc/Zw
         VjESmXuhRsL+UeT8frcO/JifSgExCLzGHhPCv8/Viq8rvdG9JT2LZRXftmGk1OqnIYcH
         d2NLOzHzI7BCzbOgMZR7mGcRw/3Ngmw/yFzTQZRK5P3mE6BJCAWcBBvSaKvYSjTaVQ07
         RT4ml6BeLIqKyv61wf0I2EgwZXe5B38z5sn9uufEE09xFpDSx7sLCrildYdiiP6Ijbdf
         59S6ZtkzVhg3V+RKZDQi+T4YI7GIcEHsrFS/0J7Ij9vxu+WYfTKsAlJQnpDELIgTI8T3
         n5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713897544; x=1714502344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11PbC9TVWukv/d0s3ZoI8BIqTTqQkSG5khgm1hVUYh4=;
        b=hNZYIzIgQ5LuFiCzatuIu52ScAPf4zQ5hH6Y9wPC4+ynJeKC8RTuQ/IclW0xYNObt+
         ydnldhl80SB5aq0dJ0ahlNZXTp0sNtKMjxmYNmETscO77fE3pyaHJwh5fv91SJEKBZBR
         a6o7JaEpnlhhcij11pST7Dko93bjPDvgifA2Tbngmqhmk6DAnv+sULQBGLx+ExUUHHan
         NxoxXbW7jDp2uvXaeoBdh76o7+0jVlykPQZ9O0Eo63KP8QpWzgmSiPvL/3EsYk9+Rj51
         qgGXQJ4LIPN/U0TKrpr3zYgLN7FItmEl4eU2l1nKcWa9zPSNJrjnXaqqXa9asG6QQ6q+
         xuyg==
X-Gm-Message-State: AOJu0Ywgjn3DQTX8ZSO+YqBTOYCxcIJJKQuUR7r2ffKX4OpSEFut0D5r
	UEMjwdwOSu/0xw1txnZ9zDACHF0ktKLPI/iHHKxCxsjeEUfmwQ5rXBBXrV8m
X-Google-Smtp-Source: AGHT+IG9eDje5/ATavPrxORyaogMG+AF67wMytIT0mvQLdRNRMSAVByDbS52hinu/SHFF1DAIcKFWQ==
X-Received: by 2002:a05:600c:310a:b0:418:5e80:a6fa with SMTP id g10-20020a05600c310a00b004185e80a6famr102068wmo.14.1713897543579;
        Tue, 23 Apr 2024 11:39:03 -0700 (PDT)
Received: from lenovo-lap.localdomain (93-172-164-233.bb.netvision.net.il. [93.172.164.233])
        by smtp.googlemail.com with ESMTPSA id i4-20020a05600c354400b0041902ebc87esm17793971wmq.35.2024.04.23.11.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:39:03 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: Exit exec in child process if setup fails
Date: Tue, 23 Apr 2024 21:38:20 +0300
Message-Id: <20240423183819.22367-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we forked, returning from the function will make the calling code to
continue in both the child and parent process. Make cmd_exec exit if
setup failed and it forked already.

An example of issues this causes, where a failure in setup causes
multiple unnecessary tries:

```
$ ip netns
ef
ab
$ ip -all netns exec ls

netns: ef
setting the network namespace "ef" failed: Operation not permitted

netns: ab
setting the network namespace "ab" failed: Operation not permitted

netns: ab
setting the network namespace "ab" failed: Operation not permitted
```

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 lib/exec.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/exec.c b/lib/exec.c
index 9b1c8f4a1396..893937550079 100644
--- a/lib/exec.c
+++ b/lib/exec.c
@@ -36,8 +36,13 @@ int cmd_exec(const char *cmd, char **argv, bool do_fork,
 		}
 	}
 
-	if (setup && setup(arg))
+	if (setup && setup(arg)) {
+		if (do_fork) {
+			/* In child, nothing to do */
+			_exit(1);
+		}
 		return -1;
+	}
 
 	if (execvp(cmd, argv)  < 0)
 		fprintf(stderr, "exec of \"%s\" failed: %s\n",
-- 
2.34.1


