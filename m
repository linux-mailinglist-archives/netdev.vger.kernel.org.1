Return-Path: <netdev+bounces-22474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E39B76796D
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0C42827C3
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71AA380;
	Sat, 29 Jul 2023 00:24:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944837E
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:24:06 +0000 (UTC)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594192680
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:24:05 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-345d2b936c2so1325415ab.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690590244; x=1691195044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HIeU+TWEJ9SHiH0PuMDlq+ijy5jWckAGkZXhCnVsnVY=;
        b=WOgKTJT75jB4KqOF6kEnfq0vx2OflxgDsz+zH43o8dD+xHb4h3OFWUiB0EoxBuqsSz
         poQX4LS/5mBeGowuzSOicZJ+aoc8o7CPNY1dBd+pgAi4t1Z+u9wi0/CdyrIWzv+oTiu+
         lTcIgyEZ8PKn3xtZbbvRkJmudW9J0CSq6LsaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690590244; x=1691195044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIeU+TWEJ9SHiH0PuMDlq+ijy5jWckAGkZXhCnVsnVY=;
        b=BFzZ5OWUWqxW+82YGnnAbTIsHCvfhHslPNg3KLIZUpTDkmMNKO81x8RONSDv1dmUNh
         e2uv1DqNL+gFNAilkIOiJlPV+hOtoGkOVN+MYIMaFEhnKWLlt/cl8BoI0MuLmhcJlvg+
         ZVZJqLjsgWN1FytfXgKxj9XSb8M5P4p7vxgqzx02eLawsr7K2psG9cibz96FvgarELwJ
         WQBxtx48Z1P7pTgBYxlrzspBtn4uqkUNbBPbPlvFgq8xOCt/XDqnVzqgKAF8kmUEPs2z
         9Hq9FBuGxPe8XLj5T+CRW8r+5MWOddv7z3F0oc+QDYhCeq+6wfs6EYHsPvc/jSCrBfoB
         tVCQ==
X-Gm-Message-State: ABy/qLZNTso6r9B7LKHgcZPCm0AveOJTJrbfldlYB1SLC3k1UKnKsvrP
	E9o8l84qaLCU+T5WttC33bGUea3BG0QzY0JDBS4+yQ==
X-Google-Smtp-Source: APBJJlFxzLDh4U/zUNgrcQ2hxtYq7pJ++OjUt0NgiNKY77A+Y8REpbsUiZgaUS+PiXRaDKHdpKlpUw==
X-Received: by 2002:a92:dc51:0:b0:346:1919:7cb1 with SMTP id x17-20020a92dc51000000b0034619197cb1mr788138ilq.2.1690590244776;
        Fri, 28 Jul 2023 17:24:04 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k25-20020a02a719000000b0042b4437d857sm1460925jam.106.2023.07.28.17.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:24:04 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: shuah@kernel.org,
	Liam.Howlett@oracle.com,
	anjali.k.kulkarni@oracle.com,
	kuba@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] selftests:connector: Fix input argument error paths to skip
Date: Fri, 28 Jul 2023 18:24:03 -0600
Message-Id: <20230729002403.4278-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix input argument parsing paths to skip from their error legs.
This fix helps to avoid false test failure reports without running
the test.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
v2: Removed root check based on Anjali's review comments.
Add netdev to RESEND

 tools/testing/selftests/connector/proc_filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
index 4fe8c6763fd8..4a825b997666 100644
--- a/tools/testing/selftests/connector/proc_filter.c
+++ b/tools/testing/selftests/connector/proc_filter.c
@@ -248,7 +248,7 @@ int main(int argc, char *argv[])
 
 	if (argc > 2) {
 		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
-		exit(1);
+		exit(KSFT_SKIP);
 	}
 
 	if (argc == 2) {
@@ -256,7 +256,7 @@ int main(int argc, char *argv[])
 			filter = 1;
 		} else {
 			printf("Valid option : -f (for filter feature)\n");
-			exit(1);
+			exit(KSFT_SKIP);
 		}
 	}
 
-- 
2.39.2


