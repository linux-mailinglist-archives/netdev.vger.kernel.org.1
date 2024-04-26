Return-Path: <netdev+bounces-91500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A38B2E0D
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 02:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205DE1F231E3
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 00:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37210380;
	Fri, 26 Apr 2024 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGW7dGoC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8D365
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091485; cv=none; b=nDiw/1/bdz8314obnFQxmkRqHekIgk4cKsAaaGLJFT5Lafqc3Q/0d0eUP/l9KIHYOXWi3fs+DTgpFgONzOKPwYNmhLXYI9ipvljjbHZ6sMbcKsc2xtOzYg+cwPYZ1rnAO5v3GiGqoYffLUU4KMSbdkCJnQ+siZLrNp1HuDxDITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091485; c=relaxed/simple;
	bh=LD02Xwyyc7KgYVw7OFcqU5ENOqpJTNTp7ia7YiJuusg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIWjcqyPburkkX5JoxNkks63C8MM3ypYPWhtDWoXboGU7VGnd5FtCktiprGlvOw27Udk/UzLYfOx5xZO0DjNrxEyBu27zjhZfqVD9fjhWYqxCW2G3eALk1PyjsU8euzJ5ONFcBxjB0/KmH0P3CaCeG7z86abZGHi83p64HHxCpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGW7dGoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460D9C113CC;
	Fri, 26 Apr 2024 00:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714091484;
	bh=LD02Xwyyc7KgYVw7OFcqU5ENOqpJTNTp7ia7YiJuusg=;
	h=From:To:Cc:Subject:Date:From;
	b=RGW7dGoC076G/ehRzkcYpXiKCL6Chq+SQPLuLwzczsQbWlqtemfhFUiNo55ON0Hgw
	 X0oEEw8wF30ob4ylnoGkF9f1WKBXAktH4VZ+rDFmLM1HA47GUrQCS1AwKHiFVMMqFR
	 XG1gzbtGZ+0KEaafEdSzshHuHRjUUhRmGGWUSWqUgXN28okDQ+vTZ1x06KP8PXw+cj
	 ZxHMQjw+oxHyMOndiM6gVHWMW4px2sLQaYr2Syl98Wq0LZJhlo9hTJ+CIQYEDtaRjB
	 9g8/60srSUoomW6smQ5x/jElR/fZpBvrmTcQxvlhI7rm6EATzlweTb/VLtdbyKkWEh
	 3nxydfYOnosGg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tools: ynl: don't append doc of missing type directly to the type
Date: Thu, 25 Apr 2024 17:31:11 -0700
Message-ID: <20240426003111.359285-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using YNL in tests appending the doc string to the type
name makes it harder to check that we got the correct error.
Put the doc under a separate key.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 35f82a2c2247..35e666928119 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -233,10 +233,9 @@ from .nlspec import SpecFamily
                     miss_type = self.extack['miss-type']
                     if miss_type in attr_space.attrs_by_val:
                         spec = attr_space.attrs_by_val[miss_type]
-                        desc = spec['name']
+                        self.extack['miss-type'] = spec['name']
                         if 'doc' in spec:
-                            desc += f" ({spec['doc']})"
-                        self.extack['miss-type'] = desc
+                            self.extack['miss-type-doc'] = spec['doc']
 
     def _decode_policy(self, raw):
         policy = {}
-- 
2.44.0


