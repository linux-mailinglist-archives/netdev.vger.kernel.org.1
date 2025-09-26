Return-Path: <netdev+bounces-226738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AFBA4941
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB67E189AC2E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33D023C51D;
	Fri, 26 Sep 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATR+jDnu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE723D7CE
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903345; cv=none; b=KChoP3Y2JCkDGf8ogCYso3hyZptNZytFrVDfEhWI2BHEZP3/I1utXeYBLdIzBI/GNr/qotmZu2U6YpcXcXX1Ytg76M9GKcz8FHKRNBQOXlwMRHx83p+KJjlK5BabobEJN6WgbHYsYoL03qhdOgxG3Qu1iH5EvtX5VGzb5a0hT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903345; c=relaxed/simple;
	bh=fCFtnpHpwYMofzs/A1ZBMsIX2GLcFi3vYB2j7+QN0bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RCjPQrM6ejt3P4xjLWZbLgeTCAK/mhWBrm/x2hoEJubkDzhpvoCQqez/KbqfwFAld9PypvYO8AJU9r/ydgYoqUzVEW562Tvu5pun4OP48Xzv+MEwpu5JqJYPr3F0obYppIs7acv9st5uP+Wm0ludumpJ8+eUuA/zoRylR7k+J7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATR+jDnu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3882e7432bso148943866b.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903342; x=1759508142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qTwebXNfRQKHZNFBatzbVF/Los3WPx3q3T72l22p6FM=;
        b=ATR+jDnuI2i/wG6nbwVYU1iGnWa58dGkPeQ0/yHU0HkVLwBsOBmKEuuszuB/9igH+b
         +ugeJSUfBAB3ewmywmnhnRQUcFXpdW1j/pbum7l2B8vEyVO6p6mpKnw/dAEPdiLTxp47
         sBrhvK/UZyKIiHRqzfMxHIf/XAM59AhzcYPJAM0KG363zh8hVF2gN8BZI47N8CbGjQxZ
         vagveqDPCuPgCHbVwwu6W8XoU8sihqHTprX8H38Vq1XYSIRk2jUNXJ4S/EteQ2CeXAH/
         8aXjMpugm7/oQks7MkYwwHyN9z3FftmU6DFsG94IizA1J16JLSgRo2pxtwakOvE+RL+Y
         Ding==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903342; x=1759508142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTwebXNfRQKHZNFBatzbVF/Los3WPx3q3T72l22p6FM=;
        b=eAD7zkx8YTcRx5DELybTRx9OUJu54+PksidsaaRGNyM4fdsAEnRlozgFQ+mIvse6ye
         zh4X0dwTsIqEy0dAYEvgPEt+hVGUS36NaisyP/4+fswhd+TBUphRztVbpweGa8F0tpK4
         50l5NRP7Kyki4y5PRzGwrTA0GLf4EDZXadNpggPe4hqggzrzj0MWEV1PE9E6Xg6HVDCO
         wn4NP1N4qwFQBIygiYO0P30Q6sHIVIyyJRjMoNwblc3G6q5cZTbuvU6IbYRqny0yiy1l
         E7IlnUrzF/yEtRSWC972q7qEIDrdEUYBOt++AxBWv4f5Lbgiqyzr9WGGvI/5upuQlpo4
         KDYA==
X-Forwarded-Encrypted: i=1; AJvYcCVs7JIlGjxGp0ztz7FuX7a2KEAiFoeqhf9tCxIPcvZZYGTqYiypTn1ebf5KMO8K4tDA8YSJVcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsO4hxz9IkcsdoLKfzhePpjFXeYisPEVHVkLDKEgmhb45Zypcw
	CRGYOl2tz0+AGzexwAlrrAqm4ZMPsFIcNv2h286/LNEHySuw7j2wxSH7
X-Gm-Gg: ASbGncvrg07rma3K/LkUa/znwRnUQcDgPLDEz0o0JxlOROm80r1lNMdImvcD64uwMdj
	hftx/b12f5FykzsqBirM2+MwqCFANdJxTe/J2bJc2x5zGqLDX2wZpau4+bRQ/cUzrZRoMB+shPt
	Ae+C6t5gM/K1hA1kmVUY4eF0X81XlpZUQpJVR+CBH74GlhC8FCQ1nWzuNdT6UUFuLrLFco4G80P
	ubE4eJNRkyaGq+TuDpqaA7BHM5Sd4zdheWITtU1E0Mjlv6f6klnKfVClBq1KyTvuquF5PgMDWDo
	ANNhnxc31vCEo3+WGppJWBW0cISqmSLzzr3Yopi4CxAQ1QxnmMHf7DdlN+61K+dSi3tZzD+No2O
	B5oInI4njsNFUKrqoHryAJbhwSI9xMeQkFDzEvx5vrHY0RkG6JNWWVXchNqBsCjVGFHrftNmIgZ
	OTHWxe2s8R98mD/ZHv
X-Google-Smtp-Source: AGHT+IGSKS33vEp7IxROvUKAQKlFRVsjIANObx7t3xDIK+wvc7qqDK/f+4CjmaBx5z0SlWt790YXtQ==
X-Received: by 2002:a17:907:6ea3:b0:b07:c909:ceb0 with SMTP id a640c23a62f3a-b34bbbda586mr890952766b.32.1758903341471;
        Fri, 26 Sep 2025 09:15:41 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b36f410e129sm248308566b.89.2025.09.26.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:15:41 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: net: Check return value from read
Date: Fri, 26 Sep 2025 18:15:37 +0200
Message-ID: <20250926161538.57896-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to retrieve the return value from the read() function
and raise an error if negative.

When building the test with the command
`make -C tools/testing/selftests TARGETS=net` emits the
following warning:

tfo.c: In function ‘run_server’:
tfo.c:84:9: warning: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
   84 |         read(connfd, buf, 64);

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/net/tfo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo.c b/tools/testing/selftests/net/tfo.c
index eb3cac5e583c..8fce369e6c37 100644
--- a/tools/testing/selftests/net/tfo.c
+++ b/tools/testing/selftests/net/tfo.c
@@ -50,6 +50,7 @@ static void run_server(void)
 	socklen_t len;
 	char buf[64];
 	FILE *outfile;
+	int ret;
 
 	outfile = fopen(cfg_outfile, "w");
 	if (!outfile)
@@ -81,7 +82,9 @@ static void run_server(void)
 	if (getsockopt(connfd, SOL_SOCKET, SO_INCOMING_NAPI_ID, &opt, &len) < 0)
 		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
 
-	read(connfd, buf, 64);
+	ret = read(connfd, buf, 64);
+	if (ret < 0)
+		error(1, errno, "read()");
 	fprintf(outfile, "%d\n", opt);
 
 	fclose(outfile);
-- 
2.43.0


