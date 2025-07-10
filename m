Return-Path: <netdev+bounces-205883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF881B00ACB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A241C83C20
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404052F5462;
	Thu, 10 Jul 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFsMIDdd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4EF2F533E
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169881; cv=none; b=P2eSfD9i+KpBh0lWmh0p0mlPiR8lC40RAOCcKIFEZOisNRjg6LVSKp5doHIcHoVUk46EPKo/SWDlWmopHZNMXoEv6anuZxRFOTl5M3vwJSMEwiSaSn/Z1OSW3sHW4SPWdULz/c876K0iC01rR4DUO1MynKNo9cplqH95UTZwEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169881; c=relaxed/simple;
	bh=QyGJleVBH18j9ibmb6r9nbV8el8WN4n+6IZFPnVgzYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ilAU6zVlkamDUccLgjS+n96XPIxrxgvWy6wuWBeMl4CumSa8j7tdccrHklUs06qi0nhe1cq8Ygd/tKDHlLlZBq72baslS0WhtapaV6T0tv0uZFRRp/uvFt+MVP+VfCTrw1jcbI2gY9pv7wNrt74yMm2dHw2GojiCw9I1SuWRXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFsMIDdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C86C4CEF8;
	Thu, 10 Jul 2025 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752169879;
	bh=QyGJleVBH18j9ibmb6r9nbV8el8WN4n+6IZFPnVgzYU=;
	h=From:To:Cc:Subject:Date:From;
	b=dFsMIDddA5T3RK94pjMsdEIneeZ7hQB0xpJnOdRUVXwWgyZe56B6fg5y1YkErRocj
	 W8Ln0+mGKGSg5VF0ut/TE5XdJcqsGr5v0nGGdt97xRSlHr2xOv2MoiMfzwcCqdJQ0I
	 4pu4740tGwOSrObAZrli9uTAJVZjU5gZ70a7X9hbjpze0LV/4cBNZaUxUssr4c9v4v
	 tZOO4TCIQfLfbemNTZ5BvCrKwPXunjfK6Iexq8VWUfLoIoacjPoLEBV6bY9fPhztzE
	 mUHritkJpDeQPLEsbuNL65m8LZrTbDQ3EzRyhINqpkXuUB+uqw6U8hlxyrq6WYBfFC
	 0oXdDQyGwkw0A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	jstancek@redhat.com
Subject: [PATCH net-next] tools: ynl: default to --process-unknown in installed mode
Date: Thu, 10 Jul 2025 10:51:15 -0700
Message-ID: <20250710175115.3465217-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We default to raising an exception when unknown attrs are found
to make sure those are noticed during development.
When YNL CLI is "installed" and used by sysadmins erroring out
is not going to be helpful. It's far more likely the user space
is older than the kernel in that case, than that some attr is
misdefined or missing.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jstancek@redhat.com
---
 tools/net/ynl/pyynl/cli.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 33ccc5c1843b..8c192e900bd3 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -113,6 +113,8 @@ relative_schema_dir='../../../../Documentation/netlink'
         spec = f"{spec_dir()}/{args.family}.yaml"
         if args.schema is None and spec.startswith(sys_schema_dir):
             args.schema = '' # disable schema validation when installed
+        if args.process_unknown is None:
+            args.process_unknown = True
     else:
         spec = args.spec
     if not os.path.isfile(spec):
-- 
2.50.0


