Return-Path: <netdev+bounces-70800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ECF850791
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 02:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF651F235F2
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 01:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCFB15BA;
	Sun, 11 Feb 2024 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b="u9ry5fEH";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="lddwAs5I"
X-Original-To: netdev@vger.kernel.org
Received: from e234-5.smtp-out.ap-northeast-1.amazonses.com (e234-5.smtp-out.ap-northeast-1.amazonses.com [23.251.234.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A327B15B3
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707614845; cv=none; b=YCeyzBdMdwG4K2YCOnaBCYo/fi22YIcKXL+WANw+6NF5xXYc8pOQpcAAoXgUZtJdYojONQgTxARakh8RLFriornHomxxuDp60Uie5aEg9H9EiHv/mjni0Q3BCjJc+7n8NruWQ6HIii5BMNpEPjjowv+jw4VuJmjCLqKzjYjF0a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707614845; c=relaxed/simple;
	bh=qbQeIxXb3Jag7qsNsWfJbt9BbXGphZvUuv9M/yOPRCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rl/1pRZY9k39S2Ozk7HqTCeDHViqayJRQpBxtyKcOYHdBzj35JKMzh8jz4U90BG5xce3LGfKU90aDFO8GxrX95ZLDgLaFlOZWSUHk2UY5/QwN7g42vbp5qUGaRXk5L2QsmC42kGnuaqllpelab/RZxnasHEdfPUgtnrdYPLfbAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com; dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b=u9ry5fEH; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=lddwAs5I; arc=none smtp.client-ip=23.251.234.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=otpfqkfjftndw3gmuo745xikcugpdsgy; d=hrntknr.net; t=1707614842;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qbQeIxXb3Jag7qsNsWfJbt9BbXGphZvUuv9M/yOPRCY=;
	b=u9ry5fEHOlK6MBCi7TqnE0ncngXtAfPSHxn49c+AHYULJ2bNaFdwWXM/peKOCJ/6
	5+GZtqB4i21wIABwZet4rd20T9aAG1g2Wjo/n7TAlU8JDVSAw1X/iBYm8/YuSlvUDJK
	sNXowYNr2eIyzfR6Rz4W5BZpv/y+x3n6ySi2AiZqa2Yc6/sY3XlrOw7xaaXzYGOg8mb
	HbavZJYn4bP0ANnUdAfElVgd24jd9jLEP1fqA0FTvwYjFEf/YZdPmn/6ZhFzX1N3MNz
	9PYua+jKu244G8sVW8dgj0QEGwhegr2JnPiUd+EoMNCNLiJLu2kmqYkwuWmhxhhcygA
	NM8ztQSOEw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1707614842;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=qbQeIxXb3Jag7qsNsWfJbt9BbXGphZvUuv9M/yOPRCY=;
	b=lddwAs5IVOZGx49P1EwDJwCK3TJkovGcOTAauFNL5yj3QikXHXsvrpslTPvaFlug
	8fUWMk4kkKpCBzDlLQLVwsZZEppmjLB2RtMTRRrtp6gdPIt8oMo51SarWVsa1Mh+krG
	xY5SDpu0Z5yoGHmIH4AnR0JgOsZC+lCkpEdnKSWA=
From: Takanori Hirano <me@hrntknr.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Takanori Hirano <me@hrntknr.net>
Subject: [PATCH] tc: Change of json key: options.handle -> options.fw in tc-fw
Date: Sun, 11 Feb 2024 01:27:22 +0000
Message-ID: <0106018d95c6ad17-f5369f4f-486c-4744-9cda-4826d243c1a5-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240210092107.53598a13@hermes.local>
References: <20240210092107.53598a13@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-northeast-1.rx1zlehJXIhTBJXf7/H1gLdwyBf0eKXp6+AKci1nnIg=:AmazonSES
X-SES-Outgoing: 2024.02.11-23.251.234.5

In the case of a process such as mapping a json to a structure,
it can be difficult if the keys have the same name but different types.
Since handle is used in hex string, change it to fw.

Signed-off-by: Takanori Hirano <me@hrntknr.net>
---
 tc/f_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/f_fw.c b/tc/f_fw.c
index fe99cd42..56f5176c 100644
--- a/tc/f_fw.c
+++ b/tc/f_fw.c
@@ -124,7 +124,7 @@ static int fw_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u
 	if (handle || tb[TCA_FW_MASK]) {
 		__u32 mark = 0, mask = 0;
 
-		open_json_object("handle");
+		open_json_object("fw");
 		if (handle)
 			mark = handle;
 		if (tb[TCA_FW_MASK] &&
-- 
2.34.1


