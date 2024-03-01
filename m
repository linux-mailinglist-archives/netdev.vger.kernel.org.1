Return-Path: <netdev+bounces-76758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8979D86ECA1
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 00:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24FD1C21EF7
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 23:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3575F476;
	Fri,  1 Mar 2024 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6TVCOIV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A955F46A
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334353; cv=none; b=bLPVN993yt3SatuxQODiwTrV9OteyedaU7qjIJYPulRMqJ91ISG91nLNITRX2QNCf6bi7M4lCEW8JxP2S1hRedXKlvWhW81fDshPSITRQ52xe1lnXaG0plT5nQK53+bAGHeF4LGuQMSTDQnCtwtDoLRcLgDa849NZVGkImWf+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334353; c=relaxed/simple;
	bh=LYJESzFtqcgL/UEJZGNrt8IF5+SGZcoBhszjj2nbHrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N37FrZd7oLHiDiZeWrkmY9EWfiV87t/3P41KsxIT4vyVqkO6Kqu7CF8oFD36rVjSCRmzRq/xiQbew0HQcloI3KiUrDexquNVT/UkWDJUD4D5qIAZ9BLrG3zqMA5JpSFIS1lG6d7dyw986HAErXAcQ2GQL2nB9IzzSQZzofn01fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6TVCOIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A36C433B2;
	Fri,  1 Mar 2024 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709334353;
	bh=LYJESzFtqcgL/UEJZGNrt8IF5+SGZcoBhszjj2nbHrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b6TVCOIVUomZmnBB8Sj6T7wNcDAYo0brk7H32XmTuUhoOLSnO1vF7IXna33esbZ77
	 kSdSZ3/Y0X4DpOFEM46+nX2k54Bc/WwHgresWYkDshnJR+slVV88z3rQMr/JU51Hdv
	 rMRKZK7+I6rCMEaZtYTEYkeG2O+BkcUVSaud7uih8fJZfi2Q6/8uZRJ+RyZXM9pIeQ
	 IKiPuDTaJmtajvA+i6yDd7CvNjXWwx/8Dyf39ouFg1VYa+OSx2FSuH1sbJjqDuUN1t
	 25RpXBoi2OpIdhcIsjeFr97eITZ6rbv3h873T4FVO7fnaN4tC2g6n5nbxvxmDP8l+/
	 XptZAbKZ7+6aA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] tools: ynl: add --dbg-small-recv for easier kernel testing
Date: Fri,  1 Mar 2024 15:05:42 -0800
Message-ID: <20240301230542.116823-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301230542.116823-1-kuba@kernel.org>
References: <20240301230542.116823-1-kuba@kernel.org>
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


