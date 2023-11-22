Return-Path: <netdev+bounces-50203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6F7F4E74
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1261BB20C55
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B0B1DFE8;
	Wed, 22 Nov 2023 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PavdHcsT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582594E1D4
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B535C433C7;
	Wed, 22 Nov 2023 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700674416;
	bh=N+anVkjYTl8YlQ1vGLG/+NNOYSZ2+PLbmCAE1NOxbBs=;
	h=From:To:Cc:Subject:Date:From;
	b=PavdHcsTDEKp06vMB5wBqWclpHPzGMDvk1h4Z8gvOsJiUNjsEwHOfVPMjIxkqOJav
	 eLl9ZgrooO4HWTkgb/QpZJHrEX74HDDJyti7wU9Ve2siIcmzDbEz5iNmVYnASNowiG
	 kRFjvJDxPcDdZK1zmHF3xOdNzJ9YE6QEatK0gSzFX5/C8xYct49IBPg07P5MEO4sLO
	 YUeEf6lJNhhTyFp7tutC/PbY3r1jc5MjYxBtfGQ0esXz+ZwZinYTEmc8mBIO0fT/Kb
	 3mwoP7CVaUSk2LocPjN06u5LdXh9VYmHdq7GFny8rUP0IXIGZLVhpZxQ777sExU31B
	 npxQ3iCOkQB6A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tools: ynl-gen: always append ULL/LL to range types
Date: Wed, 22 Nov 2023 09:33:23 -0800
Message-ID: <20231122173323.1240211-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

32bit builds generate the following warning when we use a u32-max
in range validation:

  warning: decimal constant 4294967295 is between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compilers are very likely to produce unsigned long (and a warning) here

The range values are u64, slap ULL/LL on all of them just
to avoid such noise.

There's currently no code using full range validation, but
it will matter in the upcoming page-pool introspection.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index c4003a83cd5d..0756c61f9225 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2064,12 +2064,13 @@ _C_KW = {
                 first = False
 
             sign = '' if attr.type[0] == 'u' else '_signed'
+            suffix = 'ULL' if attr.type[0] == 'u' else 'LL'
             cw.block_start(line=f'static const struct netlink_range_validation{sign} {c_lower(attr.enum_name)}_range =')
             members = []
             if 'min' in attr.checks:
-                members.append(('min', attr.get_limit('min')))
+                members.append(('min', str(attr.get_limit('min')) + suffix))
             if 'max' in attr.checks:
-                members.append(('max', attr.get_limit('max')))
+                members.append(('max', str(attr.get_limit('max')) + suffix))
             cw.write_struct_init(members)
             cw.block_end(line=';')
             cw.nl()
-- 
2.42.0


