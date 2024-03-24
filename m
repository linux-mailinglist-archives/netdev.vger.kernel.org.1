Return-Path: <netdev+bounces-81426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB9E887D9A
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F171F212A0
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D16114A90;
	Sun, 24 Mar 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcV/uRfo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E5C2C8
	for <netdev@vger.kernel.org>; Sun, 24 Mar 2024 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711298096; cv=none; b=DB6G4sPe48Sm5hlyzlb/uftXnQjZQB2dZsW/nNsBOwZpEzEnH+EoZwScptYULdT75x3wacb01F2balq0LBVQmRi5xBJRO9jJL3d+7KJ0xJRnWuEmPGKxoHCGnyEC4FXUUmx01HnVIOno85udhN84H+s99lU9/RvGX9F9boMjzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711298096; c=relaxed/simple;
	bh=HlSq4+53kpIvVV698i52HU1Q1lk4N9kxKXA5tq73oPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JqtIBOhPyJYMkU2elgi0iwEiDxj11OSBkjOtwO4kv8k6eqeKZoSHS8URc1KqNnzaK6D28Mnt6DypSA2F/1OCOMqp5nGAbP1NSD+RU5p1/v0dbdC5ize/oi2kjo3/3wP708D5vqfu/894OXxuP4p9ci6tOXp062EhuJZrtH1zwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcV/uRfo; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d476d7972aso59368321fa.1
        for <netdev@vger.kernel.org>; Sun, 24 Mar 2024 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711298092; x=1711902892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11PbC9TVWukv/d0s3ZoI8BIqTTqQkSG5khgm1hVUYh4=;
        b=QcV/uRfoX+eoA1dtiAXqFU61XHWPraHVspqZDSfKszhJ29dHDd1Lronggakl0pX0+A
         HL0Po1oRcS2gZv4cYzg/MkEkxki8B8xrcyfXHi2vmYhC0ktpkONUWUVvSSQxXqOOt3D5
         YIg4CDJyDYxhCOBcXxKtnL/gJCNGHJ2ulc/pakpr+N7wCFVRzfUwGOfnJ0EMAYhqHNnm
         HyrN4vXBQFukPiBcyn5P2lwPZ79flbXkuWdtN++cQOKteI8D4OsovmhF26hW1DbELyAw
         ckhmWgx7+1t4LqjuBoo00h4+1zgWtRPnwqM41nT+cmJxv0GjpKSAL1IY4Ca0ROH004rS
         2/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711298092; x=1711902892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11PbC9TVWukv/d0s3ZoI8BIqTTqQkSG5khgm1hVUYh4=;
        b=ogGCdu/uxSnS5vGq6OexNqfm3GuSDBn412CekJOFspREkHY+A4WKuzZTfnb1JMQRLL
         hGwdYjdDWe66gX4Gq/WSGAUiAuYWqaIm+R7NmTWU97j3IgMGkSBQ8Z36xP/l6PPOIv+x
         mrnJlicgVX41tBoPcSMoFyWtlMbf+wwyh9PNpYs1oIODuyB0Zn0yrn7k2MaQu07T53ds
         IXKCTe8U+fpL3LkboaVhun1XneUPBRH8ZyivFBRSKJklRMMExgoL21CfhgF5rjPQt7vO
         O4ZhenofTwNSY/3e6ovosOuz8QhhEEQlso3pPkax2tHY9fMcjn1K4te1yHx5G+xyZrge
         ZSQA==
X-Gm-Message-State: AOJu0YyTZfnGeast/PvhXa3Qhlt9YAeg8j/jMDVM6M+MpbsnaAbSCteU
	2H4L9hUAP3mlP8fQGMS2GNSOikudhF6oLILoWl4QGt8WT1KuVEpTgTZIWUH1lKM=
X-Google-Smtp-Source: AGHT+IEbgF4X9+z0HsTbg6NlbMpUQJCyHEZ1N8C45cXBtVldokNcffXEwNJIlck5RcJpyjyJJxKx+Q==
X-Received: by 2002:a05:651c:b1f:b0:2d4:6e08:34a2 with SMTP id b31-20020a05651c0b1f00b002d46e0834a2mr4106000ljr.47.1711298092102;
        Sun, 24 Mar 2024 09:34:52 -0700 (PDT)
Received: from lenovo-lap.localdomain (89-138-235-214.bb.netvision.net.il. [89.138.235.214])
        by smtp.googlemail.com with ESMTPSA id fm25-20020a05600c0c1900b0041486785b97sm2421010wmb.1.2024.03.24.09.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 09:34:51 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: Exit exec in child process if setup fails
Date: Sun, 24 Mar 2024 18:34:36 +0200
Message-Id: <20240324163436.23276-1-yedaya.ka@gmail.com>
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


