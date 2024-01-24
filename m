Return-Path: <netdev+bounces-65572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E783B0DC
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 19:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD301282EC9
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC912A16C;
	Wed, 24 Jan 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hKZTYt6z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9C128366
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120391; cv=none; b=QcvRP5go/8xOqZZMqz668FN18W684ipWhUR7TyP9lAF6cP+aFujbyu4wnI9JghSwWjv/2zwZuEW8AUf10NT6zdZ9OuEf4BSNGLArZfAf7T9svSlj9rW+ISXAE0e2ZVLPFxlb+gOjw5kEdOCTOyU5KdhSp69sHRY5drzxJr6fcb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120391; c=relaxed/simple;
	bh=2SHR9FJSHmpmQEnrTkrOd4u6y8dYPE+jYTMnavJVZ10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0Ps7krfKCnvRtC8V7WeasQjLBekGQuDp1BBk7K9dtIlYMAPhQkkpCpuMkbZfw8vn5YaFPzGQOBvS5WqVk0wj6+f8vJ4EEd78S4DLVn5PlSIhtB9S2zrDV7+XJIo0TrWNqobeWyVXbDqPC7CkaRSOOSs6qo5UFJJBEuSzmoN4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hKZTYt6z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7393de183so21845945ad.3
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706120389; x=1706725189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LilT+84arpVB7ic1mUnPbpXL4IkNHurS4WyyyTTg1s8=;
        b=hKZTYt6zd1XDaJSZYZJKM2A2cDEWUlA1qhZZja6gdTm8/549zP0fvZpGen8LLU6RTB
         gbFRoS/X0GJuHz5lkBeisFTeqLlVhtP2i2hp7fTVfeYkuksOlBoOmESeEXJTWiX5zSS7
         MHF+UdIhEAMAZaHeaxpQhQYChvPk3dQUHDivbD7Oj3FWTgDu6fwBObOEnt726JB/AHWj
         kBewwlOzC9RCybLZExxB85vkE3lkQGrIvN80KpxIV2CVIH2ZZr2V7xP7O95UQtaX3cJh
         1DO3p0tnFtjnsIJlQeLPF8MtCApd5JRL/r4TkiTzyBbvdmx4l9KLicAZUrFXLEG0Wv9t
         ajXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120389; x=1706725189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LilT+84arpVB7ic1mUnPbpXL4IkNHurS4WyyyTTg1s8=;
        b=X2ENdnAkoHCTYr1Ed+laSzHr9OBkMiI3MNnFs6HIlYaY9KSS3d8efdJdPDRSGCiREY
         W3cIE1xJ9d/SG0fUcEYpT1qVPcHpjrzVYQhGtyBnvErmjwOSLWzR1UZIh2r9ciMgAGRk
         m83LIixV2ZZNNqq2sNgNQt5BddzsP66Qt1J0hLA56gP+EzWhrCpkYM/l2V8vf2Yotmic
         sJHtruTYEAnlBz8psXr9Q/hYsLyrUKUxlULT4bq1y0qJFSEDL01yyq8xvBibvhGSfeYX
         DRUUWN3uTVFGdpwML/v8esC6IjiAV4MD/hcvWHpC4YEeTL10CBppQNXeUx8lsnFkAlp3
         MpDw==
X-Gm-Message-State: AOJu0YyWJcdyL99On0VKJF0ryacwZRfxZ5XzSsThKxfgLO9W5KLfr8xd
	qNc8WzPePMPJqgPN7w0V9bBndbJrtP7yjZjVDC1XgrCG2tv87Ki5CGksigubsdatc/bJTYw8x2L
	5aA==
X-Google-Smtp-Source: AGHT+IGO5NziFeNJSMCoCa+lcUVWrD168W9To4nBZxA3JZx9FvVHotwTH2Sbg9XaZeYWKNY/dOBn7A==
X-Received: by 2002:a17:902:b414:b0:1d7:7811:625f with SMTP id x20-20020a170902b41400b001d77811625fmr801875plr.7.1706120389288;
        Wed, 24 Jan 2024 10:19:49 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b001d74ce2ae23sm5577084plb.290.2024.01.24.10.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:19:48 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	dcaratti@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 0/5] selftests: tc-testing: misc changes for tdc
Date: Wed, 24 Jan 2024 15:19:28 -0300
Message-Id: <20240124181933.75724-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 3 are fixes for tdc that were discovered when running it
using defconfig + tc-testing config and against the latest iproute2.

Patch 2 improves the taprio tests.

Patch 4 enables all tdc tests.

Patch 5 fixes the return code of tdc for when a test fails
setup/teardown.

v1->v2: Suggestions by Davide

Pedro Tammela (5):
  selftests: tc-testing: add missing netfilter config
  selftests: tc-testing: check if 'jq' is available in taprio tests
  selftests: tc-testing: adjust fq test to latest iproute2
  selftests: tc-testing: enable all tdc tests
  selftests: tc-testing: return fail if a test fails in setup/teardown

 tools/testing/selftests/tc-testing/config                      | 1 +
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json     | 2 +-
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json | 2 ++
 tools/testing/selftests/tc-testing/tdc.py                      | 2 +-
 tools/testing/selftests/tc-testing/tdc.sh                      | 3 +--
 5 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.40.1


