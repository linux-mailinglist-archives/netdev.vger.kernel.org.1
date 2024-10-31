Return-Path: <netdev+bounces-140690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8099B7A51
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA06280BEA
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DACB19ABBD;
	Thu, 31 Oct 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd5kABBI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DBE191F65
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376866; cv=none; b=iaan3yyrlLhGSAtOSwNOJi+g4qxedgphCNK2qmjQRbR1FYrRYq8uPmr1IiD/u3sZuPlAh1NJMPpll/CpIm/XkS1hAaZyrv89L1sAU53f4yVw8ymPknP3KaDUBaM82uKCp8w4zNnOPhp+P0F5uR5mdo/zH+NpEe0lauN5nHGwXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376866; c=relaxed/simple;
	bh=KDjroN32FOyFQYH5QqMQ6Jr/RaS7orSOjGDBfkDgzQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjvPkUrrSVQJG8os3l9duSKKhXZNydh2eiB/NzhGrZw8lVN0eyAVJt9s/OkP8VGvlR/NQwHatphek8wx17zZUKBjdfSn6mvELdHXtx2o6JVoJUnQl75sRlGuJiPzBnTECwW5I7U8gkPqXbyEfcnuOFDrXdH2H4G6aJ4FVzRJ24k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd5kABBI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539fe02c386so1777880e87.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 05:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730376862; x=1730981662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pegCTwmOsAalYVSqftHLLv2q/dMO922qXsLEv2pv/6Q=;
        b=bd5kABBItTd3hZeOtVJ2ReRZQYyZu/7evPvH7d5e88YJzoWSnl9NgJQxohbgr1r36i
         cc6x/KU0JS4lXgiFziFbF85itEfE+5RZiKkj4vH7CY29x5axX19iP7SrEEC8y0u1xijQ
         UMeQjqNfFBndM0iP/i5Mi2bmVzkoSfwu592LBVmoXDZfC3h1EdjJtZdkKWHpOltr+f7/
         QDXsf5mTUcByngKVF+OhGcY/jnWw9hrvLiHRZ37R/WU9bZgrmdn0+MbSe1KtdtSZdK88
         lQtXeF6H297JOcYjofIuMP1tq+VhzJI/CjDpSxgkswGqkzDW5c9JDcv98LyJIuEENDMY
         xPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730376862; x=1730981662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pegCTwmOsAalYVSqftHLLv2q/dMO922qXsLEv2pv/6Q=;
        b=j2opVL1coawQlpsFYZJeKGUplTLFb7zZuXyp+0egYhhrWgiFeSeruo5VnhKWcWBrll
         CiPdOoUD5QIj4h8xXgVJCeaWlb2MOYS256xM/WmpVXGuaX4+xrrY1rapP8//NRs0zrjK
         +ATcpB5DZb56l75rH/HApahztfNrcnIhfrMGtQoS6dAztJFIDdb4gtaQl1oQwBwb1FPT
         BDsDGBkv3/7H6acBHxtNMprt33H6rHg35/cOqtXmiZe4yC4AZcq4hGXRlTGuJibihl5/
         L7bVw/cb6Y0TE7AJ6LVz0XTgI1siqS21rE5iViTP6FE99om17AFLZCBw+BjBougy7VLO
         gMrA==
X-Gm-Message-State: AOJu0YxUcjuuzAUjiZMSNGRbf7fpw7r4ajHZQ3Yisc96J5mAJ3+5wyA2
	nVxqO9v2Jo5tFej1I701AxnEDK5XdKo5tLIZeTsb0M12q1MDzya5Yrq9j/t/RXc=
X-Google-Smtp-Source: AGHT+IGrIXBd6jkN8PQZywGXvEEdVtnlcmQKO/IyNF1fM9VJoSkOyV+PF7492q5lna5gZBGZvcznow==
X-Received: by 2002:a05:6512:ac2:b0:539:a2e0:4e94 with SMTP id 2adb3069b0e04-53c7bc2972amr707867e87.30.1730376862016;
        Thu, 31 Oct 2024 05:14:22 -0700 (PDT)
Received: from localhost.localdomain ([83.217.198.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9be7dsm179672e87.71.2024.10.31.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:14:21 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <kirjanov@gmail.com>
Subject: [iproute2-next] lib: utils: close file handle on error
Date: Thu, 31 Oct 2024 15:14:11 +0300
Message-ID: <20241031121411.20556-1-kirjanov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reap_prop() doesn't close the file descriptor
on some errors, fix it.

Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
---
 lib/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/utils.c b/lib/utils.c
index 66713251..aea4e8b7 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -73,7 +73,6 @@ int read_prop(const char *dev, char *prop, long *value)
 
 	if (!fgets(buf, sizeof(buf), fp)) {
 		fprintf(stderr, "property \"%s\" in file %s is currently unknown\n", prop, fname);
-		fclose(fp);
 		goto out;
 	}
 
@@ -98,6 +97,7 @@ int read_prop(const char *dev, char *prop, long *value)
 	*value = result;
 	return 0;
 out:
+	fclose(fp);
 	fprintf(stderr, "Failed to parse %s\n", fname);
 	return -1;
 }
-- 
2.43.0


