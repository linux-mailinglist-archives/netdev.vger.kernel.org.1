Return-Path: <netdev+bounces-48759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28757EF6D0
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5321F27174
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5FE43174;
	Fri, 17 Nov 2023 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="03yixsoL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B283DD71
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc5916d578so19905675ad.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700241167; x=1700845967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywcsv0Vot4tIP0btu2oA5BeANdc32gnbECR0tYYRLJY=;
        b=03yixsoLV6YElKp238rKpO3bjuTETnmFx5roIb43dzgPbeaY6HBaCOCcJ4Dp2C6Z3r
         piGeTLPMVucFuCZ78H19pvB5iHoc2+fA/4dJ/jgguCyoB7wit8synKI7h9fgroiR8U2E
         sFT4A9SrRGcxWqA/HTtzMMA3Q9ntQVqynaanIBEJQSa3m6qFabKKkDCKGNQZn87VIuu5
         jaUQrpeM9jETseo0cyTXNRtUUkCaWVhey9qig+ph2L6t0GM8PhugppUe5RDs5FBwyrmr
         YbV88LwMU0wTds8cSLCIpPcEDSvpd0Nt1TMi9vIbtE8Mkh72cXgUkbWK0PjTWZl/FQg8
         tRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241167; x=1700845967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywcsv0Vot4tIP0btu2oA5BeANdc32gnbECR0tYYRLJY=;
        b=d8CsWL3tt75PcDlkFFWa+dTnEhHs+/pWRnD7qzsq/Otyaq1fn+Zy6xn9LkqaTb3H36
         ez9QKRlAIVwlY4AaTeXCl5b+MBGrj0RX4Jwaq1K14CpZ5tr40g2ym9NtugJjkoda7+Rd
         q9SOcgrucAOxA2g98nDTCTlVKAwGd3HovlN8II5yWVJu443V+1n0U/GW0IrO6zUzetAR
         sMCuG1Tro4yEyDX8dorhTrPKO758gio8x30+XuNuAWJofa7Rud6hAlSr+CV4ElW0fbIm
         eoLc0zccubnkr28CYM4CWr+tYSgv57uzxakhb6JSbyNufuJ3RD+5B9TDnHU/9Uqz/ByR
         rZlQ==
X-Gm-Message-State: AOJu0YySYH6vDalxu1+UYBZcYYy+NEXug4Gtvnk1DL5yvO6SJcHKhzcy
	mG82rGyilgSZiIQ4hiQqZSD6r/gVopnfAVXfkf4=
X-Google-Smtp-Source: AGHT+IFffJepZH1l3sxSYQy3bL7eQJMnUKwB9jZ3xIDrXY+g0dOJMo+lTpujh1VWCaoV7RQGpZ7RmQ==
X-Received: by 2002:a17:903:32c8:b0:1c2:1068:1f4f with SMTP id i8-20020a17090332c800b001c210681f4fmr293382plr.17.1700241167006;
        Fri, 17 Nov 2023 09:12:47 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:49f6:37e1:cbd9:76d])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001ce5f0de726sm1343979plc.70.2023.11.17.09.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:12:46 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 6/6] selftests: tc-testing: report number of workers in use
Date: Fri, 17 Nov 2023 14:12:08 -0300
Message-Id: <20231117171208.2066136-7-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231117171208.2066136-1-pctammela@mojatatu.com>
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report the number of workers in use to process the test batches.
Since the number is now subject to a limit, avoid users getting
confused.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tdc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index f764b43f112b..669ec89ebfe1 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -616,7 +616,7 @@ def test_runner_mp(pm, args, alltests):
     batches.insert(0, serial)
 
     print("Executing {} tests in parallel and {} in serial".format(len(parallel), len(serial)))
-    print("Using {} batches".format(len(batches)))
+    print("Using {} batches and {} workers".format(len(batches), args.mp))
 
     # We can't pickle these objects so workaround them
     global mp_pm
-- 
2.40.1


