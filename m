Return-Path: <netdev+bounces-65026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD33838E7A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B911C226AD
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE855DF1D;
	Tue, 23 Jan 2024 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Qz5rSUgS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A385DF19
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012884; cv=none; b=WwgXRntBkOMHZKrckk6cs1WrHf7lBvAh2Y4dYV8RHiSv842gTuaBas/G7HFx3ONvlsj/fX53hloF3IuGqEDCZPHeapL4fNCCx7Or+l7maDuwCJn8nWxOv3CgyimgpLVoEjtkys6Cm+zpqoMzvdlesVHsqR4NmU1m5XmNlPQ5QC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012884; c=relaxed/simple;
	bh=MjGJJ58fY48RLmG670Db8+WyDbzgw5a4WzmBK9YtRnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZcghcGXGYbDDejXoNXNY/nZ5wlqxQfEWEpD5Rwdzpp5IFTv+WIyJUHX02LsC0HnDvXGw5TifM7lul5HqHOXSHdhm3EgoZDKGExlOjhiQELt8gnY05UfVw9vGSaO8MUC4reQof6MvXjBOn8xPb3KVPW74eqqJBRTjcSNd9/QGkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Qz5rSUgS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d748d43186so14072895ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 04:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706012881; x=1706617681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2iTXjkZB7fjt2k7xfvkK8ipfMoEf5Zm2H5xBPVYq42I=;
        b=Qz5rSUgS02iHJ8h5Q0GiDtT+Iv/MfWRUwQuY7OxE1wJg+pv8krIiXfUnHel+iP9oh3
         WWqqdYNnQWsFhBUQCGora0Mfx21Un0YkJbrlICldlCC5i7V+DcbKMkndbHwbmRTm00WQ
         GzjFsjW5OK1tHuswFwFiGVQu6w91inTdY1xXKkIrzmdgskAq1cbBhH8LApcRXzfiuw3j
         8+c1F4hMCnOFqevDcLaYeFil0dUOCPaPPl5JE1Xher695Fkm8QyC/MapBQIE1HatRUfG
         9yeCdoU6LafFMFo4ONj0pAixMWixggHB+8ljEwhnDBxqntOit5ykl4Z0y2xnlMgPZSJI
         b/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012881; x=1706617681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iTXjkZB7fjt2k7xfvkK8ipfMoEf5Zm2H5xBPVYq42I=;
        b=xKeqmWyB9zxDaifRG8UrMGv/jnnaFmF6yBL+BE580GPUIwSvG2hanM5HIgrvShufqP
         Y/OD4+5bebDIiBPciEsyPzROjffkaC6oKElgt14SxQO1pOHscqLBhAXEmikzBT7VaIXq
         Ui9kDGhlYyrV3eMXNY2YhRJ1VMjmM9bOIFyDzlkJbiDb0kjb15L5iL0BfAK+bnPX+Qi+
         7FDLzVqwbCQIqaINGT+yS5wO0eoLh/J5/aZ+lPbDoGig8hRBZXYRAOFa5zAlKPRDsg73
         4oKFXVLnmqdcDhUyghL6YaGsB/y7r4L1pm9HT3QC7quhaCCgg/nJCHa8C/IHWI01FTuS
         aLJQ==
X-Gm-Message-State: AOJu0YwYysmZzTVqfvWx0DdKYEquBvG8ZY9cuSZJ/7ScJF8gMFHrAaij
	Qp9BUeoERWhtF72v55dmR821AUnEe1WsgLD7UgWiyL5VLp3cKBrzImycdUF7i2zJebMjajrxIJl
	oXw==
X-Google-Smtp-Source: AGHT+IHNluqhKQigzcgv5rFnxTVI2aZH8cX7eLAcIvqCCX+vJ7smcoSiC07KE5L2EaVvz00E7VVHuA==
X-Received: by 2002:a17:902:e74d:b0:1d3:4860:591b with SMTP id p13-20020a170902e74d00b001d34860591bmr3746141plf.0.1706012881133;
        Tue, 23 Jan 2024 04:28:01 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id ke5-20020a170903340500b001d33e6521b9sm8867643plb.14.2024.01.23.04.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:28:00 -0800 (PST)
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
Subject: [PATCH net-next 0/4] selftests: tc-testing: misc changes for tdc
Date: Tue, 23 Jan 2024 09:27:32 -0300
Message-Id: <20240123122736.9915-1-pctammela@mojatatu.com>
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

Patch 2 improves the taprio script that waits for scheduler changes.

Finally, Patch 4 enables all tdc tests.

Pedro Tammela (4):
  selftests: tc-testing: add missing netfilter config
  selftests: tc-testing: check if 'jq' is available in taprio script
  selftests: tc-testing: adjust fq test to latest iproute2
  selftests: tc-testing: enable all tdc tests

 tools/testing/selftests/tc-testing/config                    | 1 +
 .../selftests/tc-testing/scripts/taprio_wait_for_admin.sh    | 5 +++++
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json   | 2 +-
 tools/testing/selftests/tc-testing/tdc.sh                    | 3 +--
 4 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.40.1


