Return-Path: <netdev+bounces-124569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450D969FEE
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC8F285E5C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207A016EBE9;
	Tue,  3 Sep 2024 14:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37206153BD9;
	Tue,  3 Sep 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372502; cv=none; b=TOT/N+l0M3IyqqztzSFMyCiDsG1X2JhecJS1lmVBwPpMtoWNDvdQAiGjlB0boGYpqrKBhagMzE2CvqjU5AgWDBtwfvlTSTp+G7DxRSZv+UgrALiJ4nxkLQvSy9R3/x3M/MZ6hTgITt9bQURcmxoMt1wmLxTVCaRsw/5o6iuvlh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372502; c=relaxed/simple;
	bh=t77M5W+kIgKwAFHJfmdNTV404RH2uKt2Eph1DvmLlvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGFvhubmfkVaBRJBN6lgzt88/ff/sRgc01u4iK86ktV2/Q2jcbFSV0XUGAAV0YTK/FUA5XUrX6lPbtaEAchODNmyTzBJKgAgE47zpUXOxAmSgKS3TK/GxCYD2Evvus5otMOHwMxEWPx2Z/5D7wz23x2bAJccb3kEzJs++olPrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86a37208b2so618807666b.0;
        Tue, 03 Sep 2024 07:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372498; x=1725977298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih9PC9k6wPmVOkf+4o0P4GhHfg/wLrT8/7dcdLX3m48=;
        b=uNNfMLfJh+qzjqFdDkoaxkYHM+It4ttVLdD/Z6/kbGpSpG9ja1uKwrNKiLKPe9BMRq
         jQPNNX6IvSmZoGV1Z7cIsGImkfIyKkG4iOrntsvGrGrSFUICUec9ovewiYrtfFtj9MLl
         C2gXdfPy/I9XjeVsKM73h8leyH4PU07g71kg5zmgxey/1d+4Ks8pW8FTIJGilCvTlKJE
         2DppVM8c/e+qG9y0WH5ddi9FBFsPDEoX87fu2LQUY9HmNjhS6VQCLDkuSs0/q00pdFx2
         +pcl9qhHFOC/DNAFfuplaktLsXFQEy2CIb6F+kI4+ueRfpN5F4OYuA7WpkU5wBy47W+K
         lJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUBVgH8syonh+g7hGv5IKZwf/ftR8ZplwXjX9vR2iHBldw6pH0DFx08Jd9AW9sfWnHmlL7Ft82c@vger.kernel.org, AJvYcCV6+F1Sj40r2AGotYmvMeiBh3XmEpTfluxgdU2N5QSLQG4XkTZvMYcNnpD+Z81kMCKEH/GfCD2g/HpDpKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxwlwL+O3OflpqiLK0sSfjp/5wjS3m3gA8My+WPz0hpH9CSBU
	ZouJ2oKqVACkaTT4hzi3zh0bcc7E4+YQp9E7N2QZqphRspPxP1ui
X-Google-Smtp-Source: AGHT+IFhF+NDnLoVyJiMayu8TUu9ISf293FaXzrkvwn/p3O9fIy1Tv62iaIDsLLSpj+1Tkyg4IP/0A==
X-Received: by 2002:a17:907:948f:b0:a72:750d:ab08 with SMTP id a640c23a62f3a-a897f77eef9mr1232058566b.14.1725372498007;
        Tue, 03 Sep 2024 07:08:18 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891daeb1sm687879266b.169.2024.09.03.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:08:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	thevlad@meta.com,
	max@kutsevol.com
Subject: [PATCH net-next 7/9] net: netconsole: extract release appending into separate function
Date: Tue,  3 Sep 2024 07:07:50 -0700
Message-ID: <20240903140757.2802765-8-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903140757.2802765-1-leitao@debian.org>
References: <20240903140757.2802765-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the code by extracting the logic for appending the
release into the buffer into a separate function.

The goal is to reduce the size of send_msg_fragmented() and improve
code readability.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c8a23a7684e5..be23def330e9 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1058,6 +1058,14 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void append_release(char *buf)
+{
+	const char *release;
+
+	release = init_utsname()->release;
+	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
+}
+
 static void send_msg_fragmented(struct netconsole_target *nt,
 				const char *msg,
 				const char *userdata,
@@ -1068,7 +1076,6 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
 	const char *header, *msgbody;
-	const char *release;
 
 	if (userdata)
 		userdata_len = nt->userdata_length;
@@ -1087,10 +1094,8 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	 * Transfer multiple chunks with the following extra header.
 	 * "ncfrag=<byte-offset>/<total-bytes>"
 	 */
-	if (release_len) {
-		release = init_utsname()->release;
-		scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
-	}
+	if (release_len)
+		append_release(buf);
 
 	/* Copy the header into the buffer */
 	memcpy(buf + release_len, header, header_len);
-- 
2.43.5


