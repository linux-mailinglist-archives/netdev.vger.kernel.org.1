Return-Path: <netdev+bounces-65028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECBB838E7D
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981B22887AD
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E25EE74;
	Tue, 23 Jan 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HZ1upIbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA455EE71
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012890; cv=none; b=p9vuodKmKIAz/XBKIg4kqAp0glpCtn5+EMv3bXkOqE/Xbs/A3gzzbDBNh8nk04Wiwt7FmhRXiVhzLs+BsNmlMVM27yGvHUfXmnkW6dGXM8+chWtW8jF1Q06I5RsV91YS/384qMxBfPSuPAnGtwIACpn7BC8dsFz7+nGUjRNIpzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012890; c=relaxed/simple;
	bh=mNJfhFrzCnirpLXJ5iI3TEJymxjQIJ/DWffLWkrOsl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrF756W0g2GLsl4iYdHF4DT2LlzP3KfcZUm7S01qlA45JlaPojM47u9sYZFUEqosiOEy3FH0A+LRbmSyhOyIBTdpSRaUbds3IqpCjDBUwCyabedJe8wk+QqISHympkBg8XNxF65qmvQwPO953gCmZlbUc5uDkC85dBO66VkI6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=HZ1upIbq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d746856d85so11493965ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 04:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706012888; x=1706617688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWNyc2ZrRFbLhMvmi6sT5LZ78Db+KMqOAgITyuzVG8A=;
        b=HZ1upIbqWEtD+rYAI6hR9EAj3nnLU3l/TVmFESEpfSubrSkuPVP5d45q8HjJW3sOS3
         E1VUuo8lA6r3qIQi5vMYYfJvvdHq/oMNH2fDk2TaTlNdmeUfApuZVJn2icx1QEkX5ePL
         9KU7jN5oshZKVPsBfuXIZSWHJfMBoBDtS2qu0EDPC4BOCRMLjoUcNGWsw/UTUjqsvg3k
         Gwqtw4au+kvhZvqAd0opTwn8TKMR/+A4li+zfPDBAm2YeeiBBUGNXlCTOtOJSR8nYQBE
         ddpG1U8h0BEf1iIyJTp2U0hZilEdNqytJlE7NPXRch16NXtnE5lbm+iDwRtZuIrouDi+
         MsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012888; x=1706617688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWNyc2ZrRFbLhMvmi6sT5LZ78Db+KMqOAgITyuzVG8A=;
        b=CMWetv3xHhXgoB1D7g8ziXJJ2dzQtB47h8ltVPOi5Uh9h+LYHxguWgfKWazoJNO+qA
         Ojbfw386UblWis3eKFXa1lSZ4zDEppIODXiAWVvID/ZS0NAXOQTBYDoum+vcvdqHATmO
         sh3bT8pVZyLDYdc4rqnKKS4p+sgOCkuur3BdCGP/eWO7Qm4QGthaJhD03S9w8t5YFUSN
         5c3ylciIG9OyjhriZ9yiXxLDUuxdRg9uG+gnLFJXCcVvRkt9YB2lUDrxo6vlGNaiRoar
         Hf3r0KA++IFqjqy7Slx04YDYDj2kRIPITbLQLxv976EVqwgUxOXqiFOXNe/20mmtsxhy
         V8LA==
X-Gm-Message-State: AOJu0YwBiQ3UHPdySxxBqvpScWzx8VIDZTZJC/1oMi8UoEbxNmkwMaGC
	Zo+qUvYYW3jaCHDLmDefNvOXtcyQeKpomSmBv/FaL+EFi8HevRloA0WsXygwGEBN+wZj8NDty/3
	MJw==
X-Google-Smtp-Source: AGHT+IFIVaZpG5Qjwmncagn0GBVeBnT+Shg5p9hRljc/0rIrzuxqOGd3+wHj/nc+1CJfJj6KfyKaDg==
X-Received: by 2002:a17:903:2689:b0:1d4:94f6:56cb with SMTP id jf9-20020a170903268900b001d494f656cbmr3016815plb.117.1706012887977;
        Tue, 23 Jan 2024 04:28:07 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id ke5-20020a170903340500b001d33e6521b9sm8867643plb.14.2024.01.23.04.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:28:07 -0800 (PST)
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
Subject: [PATCH net-next 2/4] selftests: tc-testing: check if 'jq' is available in taprio script
Date: Tue, 23 Jan 2024 09:27:34 -0300
Message-Id: <20240123122736.9915-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123122736.9915-1-pctammela@mojatatu.com>
References: <20240123122736.9915-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'jq' is not available the taprio tests that use this script will
run forever. Check if it exists before entering the while loop.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../selftests/tc-testing/scripts/taprio_wait_for_admin.sh    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
index f5335e8ad6b4..68f2c6eaa802 100755
--- a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
+++ b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
@@ -3,6 +3,11 @@
 TC="$1"; shift
 ETH="$1"; shift
 
+if ! command -v jq &> /dev/null; then
+    echo "Please install jq"
+    exit 1
+fi
+
 # The taprio architecture changes the admin schedule from a hrtimer and not
 # from process context, so we need to wait in order to make sure that any
 # schedule change actually took place.
-- 
2.40.1


