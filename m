Return-Path: <netdev+bounces-77350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0A87154C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00701C219D1
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322477C0A1;
	Tue,  5 Mar 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S97vFh84"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D27BAFF
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616797; cv=none; b=o8vMmvGDcfjAoUxq81FX6nkkZtfuvnvc2Ly45xmQ6Wdh66X4XZrf9HytUtxr5RvNCmdhQx6lHtC8ezUuVHGg1G9Hh7SflT/C+b3FBVFzGYJV3olBBVAHus0Sb0nBGIzc2CBqyViPa1nyhlTkXmbKFIyW7g8tZ+rT0CZDvdw6IUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616797; c=relaxed/simple;
	bh=LYJESzFtqcgL/UEJZGNrt8IF5+SGZcoBhszjj2nbHrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK0rQ8Q0NCP/VGWbnsrarNgbKgHxx4tDX6AICz2ivS5ZgTyzRtHNUB/CrdcD1230wZUHT0FAOUc9O1rSaCYGEI8RNDsj48/PTtL8VHmlkwZ8cyzvDnd8HjBnxGWRp/GPQtgVcD7qY3FnQPOfT3VsqHBGQe1H2uTLQlbI9vswmhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S97vFh84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85137C43390;
	Tue,  5 Mar 2024 05:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709616796;
	bh=LYJESzFtqcgL/UEJZGNrt8IF5+SGZcoBhszjj2nbHrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S97vFh84pqHCGblhNbepzGexY1Rw1B9MUdz7LqokLSlwPNEl5RP7mHGRmIm0CVBBD
	 pfZWfTXx09RBDEjI+Rw+W9tH4E8+GBkynlPegP1YsbDLIuvb9tVG9nzKp2QaGUJ5iV
	 MwvB2AvILI01OfCDv4vqQjE4EP5FbJGnFE0U4KhBLcl03eSKt3yDGl+XUi+Aw7x768
	 TtK5sgUkLF/KXWSl1P7DPn20n9xDV+DnyAHu8gO9O3/ajx1vFVaI7/1DiZ5cNKtQPD
	 9es6+Jrzw9g+SzCim1X74A/DaBnPj+NhnuNq3wS/pyV6BfTWeaJI7KfOUyLa2Vfi77
	 FO6HAMazrlJAQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/4] tools: ynl: add --dbg-small-recv for easier kernel testing
Date: Mon,  4 Mar 2024 21:33:10 -0800
Message-ID: <20240305053310.815877-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305053310.815877-1-kuba@kernel.org>
References: <20240305053310.815877-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most "production" netlink clients use large buffers to
make dump efficient, which means that handling of dump
continuation in the kernel is not very well tested.

Add an option for debugging / testing handling of dumps.
It enables printing of extra netlink-level debug and
lowers the recv() buffer size in one go. When used
without any argument (--dbg-small-recv) it picks
a very small default (4000), explicit size can be set,
too (--dbg-small-recv 5000).

Example:

$ ./cli.py [...] --dbg-small-recv
Recv: read 3712 bytes, 29 messages
   nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
 [...]
   nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
Recv: read 3968 bytes, 31 messages
   nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
 [...]
   nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
Recv: read 532 bytes, 5 messages
   nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
 [...]
   nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
   nl_len = 20 (4) nl_flags = 0x2 nl_type = 3

(the [...] are edits to shorten the commit message).

Note that the first message of the dump is sized conservatively
by the kernel.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/cli.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 0f8239979670..e8a65fbc3698 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -38,6 +38,8 @@ from lib import YnlFamily, Netlink
                         const=Netlink.NLM_F_APPEND)
     parser.add_argument('--process-unknown', action=argparse.BooleanOptionalAction)
     parser.add_argument('--output-json', action='store_true')
+    parser.add_argument('--dbg-small-recv', default=0, const=4000,
+                        action='store', nargs='?', type=int)
     args = parser.parse_args()
 
     def output(msg):
@@ -53,7 +55,10 @@ from lib import YnlFamily, Netlink
     if args.json_text:
         attrs = json.loads(args.json_text)
 
-    ynl = YnlFamily(args.spec, args.schema, args.process_unknown)
+    ynl = YnlFamily(args.spec, args.schema, args.process_unknown,
+                    recv_size=args.dbg_small_recv)
+    if args.dbg_small_recv:
+        ynl.set_recv_dbg(True)
 
     if args.ntf:
         ynl.ntf_subscribe(args.ntf)
-- 
2.44.0


