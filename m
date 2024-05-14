Return-Path: <netdev+bounces-96437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B98C5C8B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61332826C0
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19EC1EA80;
	Tue, 14 May 2024 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlSDxY/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0A1DFD1
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720148; cv=none; b=DZ+6LJ+uCGXmh1O9g20qZkWAXpDe5U7ArkvzbEF1itCqeYo4DRYjnAajKjxQ5FVqNBfRnqDW2hmGrtWF4YqH+5S6pn5OLvqMDo7a4T0JB3+Xn2zAp6sQkGjbTHz0RoHC8uN2jjCcCF0svd8dDwzHaXf9394y3q5bIZ6H+639Q8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720148; c=relaxed/simple;
	bh=vSeAhkp1hbe5oNp1QSbYur7MefFdiJOIYNLt6rPcQ9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0Yr6l7XuHNTnMRdVBUtWBx8NBIeNhU1S24elXDCnrQak+D85kaw/wzNOypsCIWdX0kO5VAvPGIjLTV5e5oX/QtCsGbZEpAKDYWEnjdQ6HF6RNcLUtjAeHCnUGnhJI+FJu8PFbSOBC3dOBK1PV5KNWYl2Y28UMXAq0ea9dS1eO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlSDxY/z; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e6792ea67fso30861681fa.1
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 13:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715720144; x=1716324944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPB92E+VHUZrFr56iU71H3rfDi/dCMrD9uVj8QxQ924=;
        b=RlSDxY/zZqKobd5PFG89D6T0HLXyV9h8LrED0YzYBP/XxJInLmoKyX1shNKwWxUB6J
         ZAheCCDvU4LMS2unD0yMYpqa9BCs4LzXtjDh07bQAk3kySq5Cv4ZZIKErt0oRf2zOLrU
         0TupCL3+lIc1ZeXbjRrEjc3RAGDFE60lAn/tn9WLjxCiggugrBe7GfdZw7RG9g2TAfk2
         tCy9uBqRA3+S5oI2jTG2b0m0exMck+Q19qEAuQWF43o/L0KOwubsF5TduyVEJjUqeQU2
         UBfCttcM03lVPacSJtpeesWUM8EGirUoaD3nw7gYYOfDPuV0CinyGBBPRKTYXalsLXBe
         Wzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715720144; x=1716324944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPB92E+VHUZrFr56iU71H3rfDi/dCMrD9uVj8QxQ924=;
        b=DSBUQrd+fqHJpzaThrBVTej3sP3+kuE3iCpDMDucVXiX+fkFYKaytKTPlYc5SWTWZt
         fv8hndpWwdyGBJp2qn15HFIB4mRJcpe6bq0GUorsnwyallz+JDYmvKJM8iLuwWE+6lSH
         3ffRwTbhov4SSuwbiMs1EkD50+W1NVs04mJFZ7Znx8ajbt3dKHvF2FtcmKepDDwbR9KJ
         nFFpy3wQ7GVaPcGJq46iygsrfFPQds802B+ujMO+GdbZdEG/c7ftj4aUPm9cxjpZwvq7
         Ex5Y2hx6XbuQXWslqpj6e4WBbhZp5F7AJsVwwNB0RZoUqscXA1fWEuEopYQRiJkl5g5t
         NeNg==
X-Gm-Message-State: AOJu0Yyd48aPJVittq8PfJF0Ix8yRfhJwvTOUiPvNOXZAjRoWJ/pvWaO
	lV7BkOq4NekaAriuL3Z1w8PwipaEKHrKwpVxyPQ4XVtKMv8cqZFA2okPoNoI6BbWjQ==
X-Google-Smtp-Source: AGHT+IEgdwlp9Hsw0VrV/1NYuUjJGIRMUUg9TThxqYwjEGE39M5jE6dY69upaf6V7Bc/RIli7zaB+Q==
X-Received: by 2002:a2e:d01:0:b0:2e5:6be9:73dd with SMTP id 38308e7fff4ca-2e56be97534mr61633171fa.18.1715720144192;
        Tue, 14 May 2024 13:55:44 -0700 (PDT)
Received: from localhost.localdomain (109-252-120-142.nat.spd-mgts.ru. [109.252.120.142])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d15155f2sm18334181fa.98.2024.05.14.13.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 13:55:43 -0700 (PDT)
From: Anton <ant.v.moryakov@gmail.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Anton <ant.v.moryakov@gmail.com>
Subject: [PATCH] utils.c: Fixed potential memory leak in getcmdline function
Date: Tue, 14 May 2024 23:55:25 +0300
Message-Id: <20240514205525.28342-2-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514205525.28342-1-ant.v.moryakov@gmail.com>
References: <20240514205525.28342-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The getcmdline function in utils.c dynamically allocates memory for the line1 variable using getline function but fails to free it in case of an error. Added a check to free the allocated memory if getline returns a negative value, preventing potential memory leaks.

Signed-off-by: Anton ant.v.moryakov@gmail.com
---
 lib/utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/utils.c b/lib/utils.c
index 051cff9c..d46b47fb 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1339,6 +1339,9 @@ static ssize_t getcmdline(char **linep, size_t *lenp, FILE *in)
 		cc1 = getline(&line1, &len1, in);
 		if (cc1 < 0) {
 			fprintf(stderr, "Missing continuation line\n");
+			if (line1) {
+				free(line1); 
+			}
 			return cc1;
 		}
 
-- 
2.43.0


