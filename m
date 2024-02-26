Return-Path: <netdev+bounces-75106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2848682E4
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3A428EB94
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCE7131739;
	Mon, 26 Feb 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/ze5984"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF705131E21
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982432; cv=none; b=TAWTrBTviW/dOUpwBFr0B8nwbtMDaS/PaFh0jr7QL8kq1YJIBvrOqgKKNEeE710ihD7DwEXGlcOVbtL6sY9E3GPF/OkeSWrhLFDIxGuozfVI0r4W03MkuGhS9/GmJH+gjkoonF1jiqeW2DhED5DV2f/1rx31CDZEEZMZNc1ObPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982432; c=relaxed/simple;
	bh=ytpu5RniJVYQK26fm9wO+IuhEgz4zFwbY001eyhzwXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYOcPPjoTyvr91/KLWXK5UukNMf+n9IidxMLphGFEP1TAFCg6JFlpa11oYEiJUq49qjpTh4YwUvAdF7RDjVn8AwyWBitRlFCaNJkA+KhZHl/oGDhtnflXPGCy4CCFbfBHzg0YvtGET2R3jgBrkQwSL6MvNFYmXkutRWHGo/OHtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/ze5984; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2678BC433A6;
	Mon, 26 Feb 2024 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982431;
	bh=ytpu5RniJVYQK26fm9wO+IuhEgz4zFwbY001eyhzwXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/ze5984oTigEz2rHdPD7if/0Wd7FQ86uFWGeCG3tl/CupXVNTpcwiUSMoWa4kjzF
	 X5PTriMEsSa1Ih5/TY3CXYn37QcNtLYzCWFTJ9CMejbW1BUjBb7sAYIhP0C4bx8yIV
	 zUk9ZPaduFZSlF5CVR+9fW84QCHEnK7ZKEB5YQeJ+ZBSk3eg2ZIy8y5bvbPALCU489
	 KodNT44w70wOOx1zYz6Xgc+cItFgNdAR0nKfmMPcfsTbyZrixQWxsjPhvh2+gZWuqj
	 xzn3FhycWR6+2aNl4DNes2WfJC1GUya6fcK0u7QHr29/+/udOKPHPc+e6sjE7C5+/d
	 tCmCQIYIV7BFg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/15] tools: ynl-gen: remove unused parse code
Date: Mon, 26 Feb 2024 13:20:13 -0800
Message-ID: <20240226212021.1247379-8-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226212021.1247379-1-kuba@kernel.org>
References: <20240226212021.1247379-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f2ba1e5e2208 ("tools: ynl-gen: stop generating common notification handlers")
removed the last caller of the parse_cb_run() helper.
We no longer need to export ynl_cb_array.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 2 --
 tools/net/ynl/lib/ynl.c      | 2 +-
 tools/net/ynl/ynl-gen-c.py   | 8 --------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index f427438a1abf..59e9682ce2a9 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -83,8 +83,6 @@ struct ynl_ntf_base_type {
 	unsigned char data[] __attribute__((aligned(8)));
 };
 
-extern mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE];
-
 struct nlmsghdr *
 ynl_gemsg_start_req(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version);
 struct nlmsghdr *
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 88456c7bb1ec..ad77ce6a1128 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -297,7 +297,7 @@ static int ynl_cb_noop(const struct nlmsghdr *nlh, void *data)
 	return MNL_CB_OK;
 }
 
-mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE] = {
+static mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE] = {
 	[NLMSG_NOOP]	= ynl_cb_noop,
 	[NLMSG_ERROR]	= ynl_cb_error,
 	[NLMSG_DONE]	= ynl_cb_done,
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 6f57c9f00e7a..289a04f2cfaa 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -40,14 +40,6 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def get_family_id(self):
         return 'ys->family_id'
 
-    def parse_cb_run(self, cb, data, is_dump=False, indent=1):
-        ind = '\n\t\t' + '\t' * indent + ' '
-        if is_dump:
-            return f"mnl_cb_run2(ys->rx_buf, len, 0, 0, {cb}, {data},{ind}ynl_cb_array, NLMSG_MIN_TYPE)"
-        else:
-            return f"mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,{ind}{cb}, {data},{ind}" + \
-                   "ynl_cb_array, NLMSG_MIN_TYPE)"
-
 
 class Type(SpecAttr):
     def __init__(self, family, attr_set, attr, value):
-- 
2.43.2


