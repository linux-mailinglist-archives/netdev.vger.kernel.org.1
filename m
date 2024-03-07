Return-Path: <netdev+bounces-78363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02663874CBE
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05CD1F23E87
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368A31272D0;
	Thu,  7 Mar 2024 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsf8zbSW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A731127B62
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808824; cv=none; b=Q7MzzqtGGXVogkTKTK+BaspgVKfxtlPEyvFhUj1yp1FxrMzrAaMVbHGfqI/FzTYTSrOCNJ9OVQc9Sqw3gwaDe7JFG289f2/t2ha6V9g+qCcwKMzz+qLNNwaWFQz+YbK1xS4Mk+VKscjVb3y6WE/+lSEHIIyWsYKGaxHQunBcMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808824; c=relaxed/simple;
	bh=PaGCgG4Cjlk2hcUzkJR4k3b5pvtRzuJr/115LuBjY0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MG82m8GYnoI0ct9rsO4KphyVOZYq4yHvuX68HZbfNYNp8SeengVg9dAa74VmkCrHIl8JIjQGzKN5Xqbg9g+DynsLn+Kif5jjthJUvAuM5o27KeUL8q/I9YoRPbtvaf2nNLec8zagCROUsQNd/5o0AbKBv3zuBke0tUbwdGX1FrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsf8zbSW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso309919e87.1
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 02:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709808820; x=1710413620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Muz5/5L7n1ayLcsbrrD75UeujL6BSqkLKz1e4Q1H0OM=;
        b=jsf8zbSWYc/Le5G5FuaFX0GJNKMbdsjUb2Rs1PxVlvPjOUfZiBTRRcMlXm3VqLlI22
         46YQmupCd9QjSMATxSflea5DfZlvGC55mJNECoUyK5tyE9mVgnCQg7UCQ7Uhe0YU+IiZ
         36RDDwFE69vCHxlfQHympcZqSl2V3RDzNTsSWwqvZ5sQhdzSkJIGSwzdKa6jiPVvszb+
         o5eLfTZZikNbnAG1W+jLs9EyBDhHcbvkXld0+86uN6kFZSQhL7EwPAfGyjAQckwIOAj6
         5YUPI+J9ir1lL30G8goke2WtDV9gYqq2maAr4QpEY881FqPLci9IcC0lBYOxP7CjJNKE
         DRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808820; x=1710413620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Muz5/5L7n1ayLcsbrrD75UeujL6BSqkLKz1e4Q1H0OM=;
        b=b8eXgzfw0AcQXVFMafgF3oe57D11uAP+SmCxar/7uh8wLd1LrxKXmdvI19icD2B/lq
         qoSafpzgSOzVFVnTLDBJdEmJq00rwDtkfKiaq23jLDkt6sW9+JA5f1CelWqIUGbZBzMW
         oiuyW87m4E7sNkJ2xU0nVALHcK5ACpEo/gTuMPXJxLftzoiemwbNHk2r+qmK/E1YcF85
         2nauEORYjLn5RmCfyBgAMyTfONIkW0aU+KJQcDiKbS65xXgg77P0pPd3mCvNV4qTa+L5
         FSBGPPOUY/xlXDyQdazqT4hOBMs128mSybsfK+KtzkPi1NBQcS1+OGPV3n+jNzHPszZf
         X0MQ==
X-Gm-Message-State: AOJu0YxE3Us9mx34FbnI28K8KJEEym8t3ODlWZmW1vP7u05c1AsDABGR
	1zOQEEHWkv8qZHDcvixul5HjOESrrXfnPAyKKzUbz6bqWwanxzFe
X-Google-Smtp-Source: AGHT+IG9vaUFX+fpIeA982toO///MJFcRsHcX48XBlgHopMxM1hKnDwaW1Kt/qLDLT6Up+IKJs1MKw==
X-Received: by 2002:a05:6512:3c91:b0:513:6982:d940 with SMTP id h17-20020a0565123c9100b005136982d940mr2750931lfv.1.1709808820059;
        Thu, 07 Mar 2024 02:53:40 -0800 (PST)
Received: from localhost.localdomain ([83.217.201.225])
        by smtp.gmail.com with ESMTPSA id s24-20020a056512215800b0051330f9d828sm2610071lfr.129.2024.03.07.02.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 02:53:39 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2-next] ss: fix the compiler warning
Date: Thu,  7 Mar 2024 05:53:27 -0500
Message-Id: <20240307105327.2559-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the patch fixes the following compiler warning:

ss.c:1064:53: warning: format string is not a string literal [-Wformat-nonliteral]
        len = vsnprintf(pos, buf_chunk_avail(buffer.tail), fmt, _args);
                                                           ^~~
1 warning generated.
    LINK     ss

Fixes: e3ecf0485 ("ss: pretty-print BPF socket-local storage")
Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc/ss.c b/misc/ss.c
index 87008d7c..038905f3 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -1042,6 +1042,7 @@ static int buf_update(int len)
 }
 
 /* Append content to buffer as part of the current field */
+__attribute__((format(printf, 1, 0)))
 static void vout(const char *fmt, va_list args)
 {
 	struct column *f = current_field;
-- 
2.30.2


