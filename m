Return-Path: <netdev+bounces-136503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE949A1F09
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2D81C25DCB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4461DDA2E;
	Thu, 17 Oct 2024 09:51:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A71DD86C;
	Thu, 17 Oct 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158667; cv=none; b=RAldMvEqWyjobQvCY6JASqURDwfQKXvIUcVIw7CmIzvcMysqBCcz+C1pXdgXNEpwCKMc6fOtjIBZuxiUEodI4qX6E9w4aFb3zts1ntQlELWizNHfMEEQW+AQAYtZQb2NvjHXyWoSoP9hSGejkZkL78nSqHOdOI2yelhPiaNtyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158667; c=relaxed/simple;
	bh=mQpC7YgB+kq1ZruSzdGLaLBqEEwfjlPwVeWJnpWWNoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oa9IQEA93bw9JBdCPTcwpFGnLhYqGReCvC4lXxXz21HXr5zStNTuvZsc0rDEBia9aEvYq9DDAwQ2YCpu06IocvZzBe05SaBcF81UnruZ1kA0lzl1UuwRkio2Ir+OFG7ZPYD/RVQHnIFYLsnK2zZLZLbDQYnfYEgqrYM/1jx/ep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb561f273eso7160071fa.2;
        Thu, 17 Oct 2024 02:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158664; x=1729763464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn3d5DrrbfnZw+8+PLA51MpHzKJn4lcgJlRW9cmouQs=;
        b=ugT7DMAkLUcbCbEYht7jJagYR+3s4b66IUwRjw5y9LogOH8RoUElgKUjrt4ApqH6q8
         KbnI8br7kyQAgwiYWPgBnSHYaLpyqCxrCwAu3b5qrjOojHU5kgaHyj+fDQcPcFj/m6Qr
         Bh69u9M0LEirAPb8LMgXr1eW8XslgwH11QYzhkYn5EJHi389D2xgxn7w42kLwF5e8Y9t
         Y58qPYQzbMmPKWPh+8vmzaXCzNRhjooxdtSiRszrJ3z6WNynqBMDM5Xgr94PlRcjRgXa
         7L9BRyd6NdwiRYGkfSZhb2AnUpkULWoWxVjx2yTgzgGIIm/0us4RBSWPav6+fEoxKs3T
         q1dA==
X-Forwarded-Encrypted: i=1; AJvYcCWEgFxt5lp/yjEwmulWXIazEGm8pTMrpSDPmFQaKFNGDKwdYhFiKTDSWvN1lzZhJ2zPEvoxzwz6DS2t1tw=@vger.kernel.org, AJvYcCWlRMnr/JikpXlvaGOW8Xi4+dZP7zQUIa88R+ZKOgVO9YFbaSHvETXsOO77SV4CyLSPMVph3Kxb@vger.kernel.org
X-Gm-Message-State: AOJu0YyKiXB6gdoi1gRFVW6Zd6iq3ra4uInC7m7imFlNhLLqveY+wFGp
	Xv3mo4z9lBfXikDTGLQzLhXFRt7IJ63lddIobIl+McsgphoPrlhR
X-Google-Smtp-Source: AGHT+IFa3YWVHSYU+4G/aPkDrpr5t2bDTp/QkCYC8GdBQSYAJJmQiHsb+dlsWyXpknKVHapSBkUzMQ==
X-Received: by 2002:a2e:a986:0:b0:2fb:4c5c:3f7d with SMTP id 38308e7fff4ca-2fb4c5c40e0mr84002081fa.5.1729158663573;
        Thu, 17 Oct 2024 02:51:03 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4f9416sm2557858a12.35.2024.10.17.02.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:51:03 -0700 (PDT)
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
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com
Subject: [PATCH net-next v5 7/9] net: netconsole: extract release appending into separate function
Date: Thu, 17 Oct 2024 02:50:22 -0700
Message-ID: <20241017095028.3131508-8-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017095028.3131508-1-leitao@debian.org>
References: <20241017095028.3131508-1-leitao@debian.org>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9a5cca4ee8b8..e86a857bc166 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1084,6 +1084,14 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 	netpoll_send_udp(&nt->np, buf, msg_len);
 }
 
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
@@ -1094,7 +1102,6 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
 	const char *header, *msgbody;
-	const char *release;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
 	if (userdata)
@@ -1115,10 +1122,8 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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


