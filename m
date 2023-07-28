Return-Path: <netdev+bounces-22375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC09767366
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE7D280C29
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548A1640D;
	Fri, 28 Jul 2023 17:29:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29722156D3
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:29:39 +0000 (UTC)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3033A97
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:29:33 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7748ca56133so23306939f.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690565372; x=1691170172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT09jtLuy7a5zKnUmbIcfbqwcSckF6Rn16/QMnBw9d4=;
        b=ik1kl2QQs6gPAyqKxmdly76qC7JHXn+5QGW4RI0PwbnJ0R/L395Y9sycGvRLYDQcZy
         nOWDXXXddSS5rl784gp45eNnu+DdKmIEWVUWQ4TW9vyspok+cwRiIAg60ADmJe70X1CY
         7kz/kUN29oVvwFQAhtrdsqOTTt+2KHcw/wuMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565372; x=1691170172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT09jtLuy7a5zKnUmbIcfbqwcSckF6Rn16/QMnBw9d4=;
        b=ewx3fI9oKZpZ2jfwhQk/rp0wUrOCOoBnxfBIfk5De/hsxneCPTJmeb/w7FqBRgcShP
         +mScwOP/sbhfv1Hq/Q25VfB7iBsQKdJC0EKAVoDEOXhV5RiKuQkJKB5flqqWiuwUxYar
         1m6Ey2w1UaS89TIIvh+IUZmGdfh7ft8gSwgoDwo02+eIyLNKdahxiqfH0pqjwW+fbbaH
         zss9JodtLtlhfF3g4Xmy4Rwp0C24qXlSJ4dXSUWa0W0+RAIq3k2DI+16ms+BUB7VOsU+
         UeBOExq//hIQTZgXEjLn9LY/fShIA8Zofc19fq8qiUTTCGWwmPJvigqt2TgjxddOSBkA
         sb/Q==
X-Gm-Message-State: ABy/qLbD6pDKvnJN3OVo7xsTZL6L6BeHkBndqPhcNihxIj8VdIrGgzGB
	Mxxni6ZZu5ZriVzJZPP1UA5Kgw==
X-Google-Smtp-Source: APBJJlE1OMp2GGXg6HYJsYLE/2Pq79PXrP4ciLYxaRJN/m5Tq3XeasWWvCny30uP2LXSkucWtGutdw==
X-Received: by 2002:a6b:c9d3:0:b0:788:2d78:813c with SMTP id z202-20020a6bc9d3000000b007882d78813cmr248574iof.0.1690565372321;
        Fri, 28 Jul 2023 10:29:32 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1181050jal.136.2023.07.28.10.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:29:31 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: shuah@kernel.org,
	Liam.Howlett@oracle.com,
	anjali.k.kulkarni@oracle.com,
	kuba@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH next 2/3] selftests:connector: Add .gitignore and poupulate it with test
Date: Fri, 28 Jul 2023 11:29:27 -0600
Message-Id: <e3d04cc34e9af07909dc882b50fb1b6f1ce7705b.1690564372.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690564372.git.skhan@linuxfoundation.org>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add gitignore and poupulate it with test name - proc_filter

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/connector/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/connector/.gitignore

diff --git a/tools/testing/selftests/connector/.gitignore b/tools/testing/selftests/connector/.gitignore
new file mode 100644
index 000000000000..c90098199a44
--- /dev/null
+++ b/tools/testing/selftests/connector/.gitignore
@@ -0,0 +1 @@
+proc_filter
-- 
2.39.2


