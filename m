Return-Path: <netdev+bounces-232258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1BDC03773
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 22:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489F73B20DF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A7026F2BD;
	Thu, 23 Oct 2025 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPTBPTQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824B22B8BD
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252847; cv=none; b=mY9SUCCypqZoacaqj3AMrhLMHrKDZj081JFJgYT+8nGHOsfOG6Crnd+xnx6PQkcgRbHhI0orS82waBoDVNfu4nR2IP1J1LwKmknOuUeyYr9QwBPyh/ACEm4vQGVUjBJ0q5ezBdrUaEQCeDDJB7Lj5ekm/zJ19Xg+j77AKbv+pmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252847; c=relaxed/simple;
	bh=hklffgyYK4VMFsD0CdS9XrqoU+fsq1a2y3wTFz4L+Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IKwl35cLoDm0bPBgPXZu3eZmop+NIyJMxT42qq1yNvdCjdQMV3TE4GNITOGp227iZQE2grWw+nAblNL/vyY34pAifeu64IZr6e6ZQ24POBQR1xja0Oc0EcGrdsKUVVxtlLdueeIS9cKYmXdtvADSB7Kda1Z/TaUw78t0W/QawJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPTBPTQi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so1219443f8f.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761252844; x=1761857644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcTYeshnmr2jeZu3uYGRDZUvk+BEhVzCgVA2Gfj5vu8=;
        b=XPTBPTQiS3KAtT2nBIuEMxUpB+mGeaoUnLN2NolR0ku26czbPRyR/orFs3oUBi6PCc
         8qCz32Z9H3gG8QKSuR42x2SGmyLhCcfl8MlfTwbXAEnAdn2lKyQtton8WxQiac9Dzg2q
         2FccvBUJzgvDNtc0AatZlLJ3ZgIbOEChIjzh5B1d4J3IR3A77GFBSs21GHQHCe6L7HYe
         yTx98ms0AL73kzx/cq4CtTLu95gMShBFhOwwyKKD+hjDJ/IskAj1ERlQjgX7/g78tPHj
         qeDo73mDNre1sitSZlYqxYWUfGArvqAHK1iYuk+as6laYhmaZsEHPTLRAtXmF9gB6N2P
         DLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252844; x=1761857644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcTYeshnmr2jeZu3uYGRDZUvk+BEhVzCgVA2Gfj5vu8=;
        b=Rhu0W6uxt7VuwBY8ntfi2t2LohbSgNYcQPl37bHHVVmsUUOkMJSsJsqMKZjjDTRcp4
         X/O5tSEx9TxFntT6buUSS3AMfslvBheZ2+1gORKyTvAIEnu+LE7QTjUgJo2xFypxrg0I
         hVZk8FXTcuTPiMBEOzG7Qy+LvBup1XOPOzKp0UNWkxuFscQxjbrjKkN9fyRE8U8GFqox
         9uAbw4rXJLB3TsqSXog0mAvPi0Hu1HvzZmaZ/I0laO2f15Z5v3y6gVq+85x8dKUR+fWb
         YDcnN9EW1C0/rgpENBEgZspxLaCfJzKSQ62YKmY1ByRbe+CAm56+iplARUdxgPtZnLai
         X5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVValVKkqr3rldO9dsJklsG57pOi/0YgFO5V/A+1NSRHPQg5oZQ2C/myVr+mxUtDsoPlHDOs/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRNdraX+qXEHtXKTgrbK7KdkIynsvTvLzNu5xhKdx01LcXUg6X
	e2rwj/7lp6SlrKPRaq5zZbcypQeJW4LNlsADu9VnrjjPN7lqaa1i7m7t
X-Gm-Gg: ASbGncu3ntoWhKEdydaYOB2TjdElDeIxRgn1H1gxahReuvgQh0HwbV7l5wg59HleYEW
	sBruhtRYB6LEKSmFlKjBVoYtVi61fST+1gKoTysP+Yqj9dBklKJaa9qkcSKD4/wLdTO5ikUh075
	mK6Jz1tIghGmb8b0cUmcfawNnJyzbCfNNlJ1ta2vOJcAWFoSPX1DiD0sYBbyeC+ILBXQ3UeEcgi
	+7s1s+okijO/0yI/xoli17rQg8bAzNIK+JXKP9TY62CkBCBL8geoJVqlVd2tlLUts24x6CP14uz
	8w+66oXFc4xuGLRCMYrOkEFemvPh9BRpUVxt3d6TvE1QHLVUgtWcTOPVmlv7u5rBjnm0/oXK4YA
	egvTfY8nXvYGP5QnyS5DU7Cmkx11rMH8fyNnKfWPgGjUdR5oiYACb/7Steygq46OU1wfpcGwd7S
	2elvU/BkhsmbNxxfYClOQVhHhS2ZMMoxBUFjseUhrZmmmIOttBg1LdDxMzei2fpg8qBwyJDeEQ
X-Google-Smtp-Source: AGHT+IGNcYfvgrEtyv7m+Z6cYdS9youXfDFaSCxmdJXoMuPMDUIma4zmYzmszUwxmllhSMsx0bTfvA==
X-Received: by 2002:a05:6000:26d1:b0:408:d453:e40c with SMTP id ffacd0b85a97d-42704d8efa0mr18802626f8f.25.1761252843821;
        Thu, 23 Oct 2025 13:54:03 -0700 (PDT)
Received: from alessandro-pc.station (net-93-70-84-238.cust.vodafonedsl.it. [93.70.84.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898add96sm5658143f8f.30.2025.10.23.13.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:54:03 -0700 (PDT)
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
Subject: [PATCH v2] selftest: net: prevent use of uninitialized variable
Date: Thu, 23 Oct 2025 22:53:52 +0200
Message-ID: <20251023205354.28249-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to avoid the usage of the `ret` variable uninitialized in the
following macro expansions.

It solves the following warning:

In file included from netlink-dumps.c:21:
netlink-dumps.c: In function ‘dump_extack’:
../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized [-Wmaybe-uninitialized]
  788 |                         intmax_t  __exp_print = (intmax_t)__exp; \
      |                                   ^~~~~~~~~~~
../kselftest_harness.h:631:9: note: in expansion of macro ‘__EXPECT’
  631 |         __EXPECT(expected, #expected, seen, #seen, ==, 0)
      |         ^~~~~~~~
netlink-dumps.c:169:9: note: in expansion of macro ‘EXPECT_EQ’
  169 |         EXPECT_EQ(ret, FOUND_EXTACK);
      |         ^~~~~~~~~

The issue can be reproduced, building the tests, with the command:
make -C tools/testing/selftests TARGETS=net

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2: applied the reverse christmas tree order

 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7618ebe528a4..7de360c029c6 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -111,8 +111,8 @@ static const struct {
 
 TEST(dump_extack)
 {
+	int i, cnt, ret = 0;
 	int netlink_sock;
-	int i, cnt, ret;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.43.0


