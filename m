Return-Path: <netdev+bounces-70000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 937C384D364
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B41BB23103
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C0A128814;
	Wed,  7 Feb 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDgsbFq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE812838C
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339671; cv=none; b=bExLIrwJ8swiseeMqHqUC9O08fYwJAyp8P3zTEWMmxLdjNYO4dZehIdCpoY8Mb3NrXiq0+1YSOCXfKIO3CRGTYtjZdnHX75zH/lv3zxHPBPpzkpxKgYjKCj6h2OTWgB81cop1Rec3MptJi3j7ateRQN/x7EBI1A6Jw+IKvk8svk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339671; c=relaxed/simple;
	bh=PwerdDp7wCoE8EO6/xoms5W2Sj9M/x8Z5FpXbvmD4lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rPjCWm8aCx7pmmueJZiQdWOKCG6xqLfatCMXwhE0dMVwY7Mf35OJCfESfKma97cMPzaSQpjuFNJ+ReFntTe9e/UhnM/knjAcdg2KrTBgxONXwZUmABGgzTiwst3DGmdl9c6YbQ7l14zqGWhGo/cYB8qrHAlQMUOtZ/HuQawdAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDgsbFq5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0a96bad85so17285681fa.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707339668; x=1707944468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XvL/tOSWck1ZSBp2NCk9xU8fBE5w8xX/1OJJSjQ+zIY=;
        b=IDgsbFq5cACrWQlZxDHwECidZ0uT/4PEOCpuLEo5W3ctgb7+qBZCWNpb+AJmvfVD1Y
         zC5v42yfBNqyfGYBUTqJB8qOzniAk5McgL1aXmLmrgqCdtwlAjFtNJFezCY2JgVmlbY4
         FKYUG43O26CgCn+1d961FRUXpc4TgTkZlm5RZseTwKM/6jScro6B/X1jbPylLLlVKSJA
         Kf6KZX6L8KQlxCnnSdZmuHHiSOYDZYLrNXQz8hbDJADrhBJ+9iiYqDWS1H8oYeZd1vy4
         E0zdySW4RztmhtUBNd6z3wsITIkKWLN6jk9doZ8rYtj4sHm5xvkNeiSKHyEIctto+nFI
         ngjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339668; x=1707944468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvL/tOSWck1ZSBp2NCk9xU8fBE5w8xX/1OJJSjQ+zIY=;
        b=PWBpZWC1RXerMjrsxjSbv37l/q00sSjXIKgKVPhdhUjMMFJlQPsMJb4UD2twm/eZAc
         cvpDTwjaSYwaxrCjVH901sWjX7jOqu5Is9wEdd2oZMfCiQKHjV4k8OOP14xLyZ+tAlTs
         zO1okxNfPmueQBgO1x/WqN/qH2MUjwTIfDSFOv8GP9aW1eJPN1yBiFoaLMblNf1+lP/9
         HJDW9XWdsQFdFphgP1PEglx7vzUKh1Z3if5x42cZDSgafa952KyVlVDny+G5ncDeMV1T
         bceNHM7aeMN+nWvvc48Bi/EQoJK5JEswW0721bBGAjqA8DYCQYSE5i3Psw8Mrk3mW5SR
         3GCw==
X-Forwarded-Encrypted: i=1; AJvYcCUjzbj8xd9QdLts+fxdZB9DgpSWVb2LgfzVn3sjsnUac3z12MxeocGf1tyvTE8gDVf2Gek8bf+jwfWWaQF8qH6CMFByecLP
X-Gm-Message-State: AOJu0YxYhb25wnpGkzn3Fb0JqYBrmkbg5jEpRj5C4rvdA7gn6eXAmf9b
	IkdK+2UXzbvuQt2MM69jiZ3RdEvVqv1eNByn5zYn403tZZcK5JkO
X-Google-Smtp-Source: AGHT+IHl28Nm/SyONyW3tGq6bw68Y3dkc7OhaZHGL3ILNvbP97C56mbfR+2qWJut+1wbrgB8JynUHQ==
X-Received: by 2002:a2e:b8c4:0:b0:2d0:c6f9:b58e with SMTP id s4-20020a2eb8c4000000b002d0c6f9b58emr2798157ljp.2.1707339668077;
        Wed, 07 Feb 2024 13:01:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0iRMkLbq1LwFfRp2Ssy0DkbYZ6hMwnnXWTr4z2fcb2CJtc0wUobiYzxLcM/KdlD2I/L6/X2zk8tt9CShD9y3Uc+Uryx8K
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id v19-20020a2ea613000000b002cf1cf44a00sm313739ljp.52.2024.02.07.13.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:01:07 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] tc: Fix descriptor leak in get_filter_kind()
Date: Thu,  8 Feb 2024 00:00:14 +0300
Message-Id: <20240207210014.13820-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add closure of fd `dlh`.

Found by RASU JSC

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/tc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tc/tc.c b/tc/tc.c
index 575157a8..4f89719c 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -167,6 +167,9 @@ struct filter_util *get_filter_kind(const char *str)
 
 	snprintf(buf, sizeof(buf), "%s_filter_util", str);
 	q = dlsym(dlh, buf);
+	if (dlh != NULL)
+		dlclose(dlh);
+
 	if (q == NULL)
 		goto noexist;
 
-- 
2.30.2


