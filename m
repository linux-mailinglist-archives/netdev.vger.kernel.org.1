Return-Path: <netdev+bounces-52301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F9E7FE324
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242D51C20ADA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB63B1BD;
	Wed, 29 Nov 2023 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="by6h9GTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D0A1703
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:24:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfafe3d46bso3271815ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701296695; x=1701901495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boH2XvYQnpBpBXH5Z+yQzRXQ5rbOkFbvurC2g24QJlY=;
        b=by6h9GTuIXHQdcm+9KtaMeVBv/jQBcwbEEH2zt0r1lF5RxjOZEQPMJIt09kUSawI+t
         Gbzy5PcOuzxIwDSlAQv8gxk9P/kjp5yZIKo2d2RPmBiiqdYsIa2R2BoL/AwRNTQWWvZS
         iQUmUAfczGjhNJQnNdUAHBsUZqcbL4J34VLTYbqnZkSDIkb2dF1BpvbIF80n9Kb/vrSD
         HAlj7DrQXudNSjP2I6qAm819VK6VwaNiKfmsJXU4aELgTu1kfpQTIHJJghROmCw6/NdV
         L/j0VeWoXpLlOcKqaJIHtT7CvNTJUZWUHtTZcAspKxS1EJtoOjhf+GzUWpc8myogTJf0
         zfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296695; x=1701901495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boH2XvYQnpBpBXH5Z+yQzRXQ5rbOkFbvurC2g24QJlY=;
        b=gsabTUyWChKNMHd5/OMwELjj9l93ItlOYiH1GIPY3po3nU/WzKhA+67urTg9doUCVC
         VIIEuKg3044QhKqsnYMhty0jMbrp2GGhC/04RoNGVOM3NBdxQSySzi/GECxPr1g2ocpq
         SuJKSpFNBHHVy1p48H/88ZbNpyQEMcxM3BjK6jiW2Z6hwd/hSGmLpfnWTHX2BkFJ/yMO
         C3w0qFh4VcgoV+di5JYBAwIzmFcA8wHfZqWs24eJCifOy3AIuDg8j5yY3LXL8LVUxkAv
         wc/qOHHhPX9jWvYFaKBN5iuxV4T67Mp9Su4JHobpHgaVxgNFwEICHySd7zB1Uo/Qx78V
         +ddQ==
X-Gm-Message-State: AOJu0YwW9QJO8KAG5h2FJinwPxRlCfl0tz00XEaj4+DfXvI/irFaO8zP
	lmWOXvfR33lTneqC2eQisyp49TU/CS+4WTgmCoI=
X-Google-Smtp-Source: AGHT+IFvmJExB91/kXCn45gNOep8CJWPXl3id5s9b9Htkc5jp3hI1N5aGUPK/r8ayf6P5+GL9QpEAA==
X-Received: by 2002:a17:902:da8b:b0:1cf:f506:c98e with SMTP id j11-20020a170902da8b00b001cff506c98emr8020601plx.16.1701296695300;
        Wed, 29 Nov 2023 14:24:55 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001cfb971edf2sm8663697plg.13.2023.11.29.14.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:24:55 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 3/4] selftests: tc-testing: rename concurrency.json to flower.json
Date: Wed, 29 Nov 2023 19:24:23 -0300
Message-Id: <20231129222424.910148-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129222424.910148-1-pctammela@mojatatu.com>
References: <20231129222424.910148-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All tests in this file pertain to flower, so name it appropriately

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/{concurrency.json => flower.json} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/testing/selftests/tc-testing/tc-tests/filters/{concurrency.json => flower.json} (100%)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/concurrency.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flower.json
similarity index 100%
rename from tools/testing/selftests/tc-testing/tc-tests/filters/concurrency.json
rename to tools/testing/selftests/tc-testing/tc-tests/filters/flower.json
-- 
2.40.1


