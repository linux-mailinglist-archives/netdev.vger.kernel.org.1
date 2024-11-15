Return-Path: <netdev+bounces-145393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EEA9CF58B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F3B286B3E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AD917C219;
	Fri, 15 Nov 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecQQMlMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7331A1714C0
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701559; cv=none; b=dXG0IugSNAQ+h++/9iJWFxEIkntkKO4JSVSfk7nw7rlkfGoCSGemXNgmKUNilUYaVJXm6tuQ+wp6bKqA9U6bzs+OLgVkFXS6E55IbNjJRZGwC7MOyzLzSAcSUclhxKBXgXpQCGA7JZKmLu85tuNcgancfAhC1JXOrMdHhMuqi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701559; c=relaxed/simple;
	bh=3IwGyw+upT5tWVAMKMFbyTxAZ04FjkHNXYtlYn22oCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVS0H0IlgSE+uU638Y9hJ2tVjKK524Q2ST4xJs2TzU4igG77F7VkIXE34KDRnFs/D+5XHlg56yljaoTmjZT8MUf3OeYgV5RLAuaJNIqHA9exqBXUDagtmHDEG7Vpkz0GfjptG0x4hrZrjYGOvpNJ5z2bdtIa4fs4qImfDQujoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecQQMlMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF18C4CECF;
	Fri, 15 Nov 2024 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731701559;
	bh=3IwGyw+upT5tWVAMKMFbyTxAZ04FjkHNXYtlYn22oCM=;
	h=From:To:Cc:Subject:Date:From;
	b=ecQQMlMeC37vH9qbaQfn13NNG9mofBhNnxlJdSxMPzerXPk7H8DFqOeSxsQrDmMTr
	 S1JNkKx1kfgQuDBHMjjhlC8Usy6p9v73+rKW7pSA9eXFTUsn9r5EzQVJYKHI3KU7kv
	 sOirfXD48+sRCsvQgmioQLtvuhYl5Fdka0tQwpg94w+CXBOAfLEuKf1jVVLlJj/NTY
	 gWlMyXOpgoVqxaK4+B8YnIMGotK7Y3BxRMvAb4imUamK1UAPIQYmQ6AvOUofLE0Ek8
	 ilgrerELZ7h4t2bt7C5pb5PyBnaui+N4AoWg/8Ndnr2XL40GI6VESQG1cpLcalPuxy
	 lnLSPGMudB2yw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] selftests: net: add more info to error in bpf_offload
Date: Fri, 15 Nov 2024 12:12:36 -0800
Message-ID: <20241115201236.1011137-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_offload caught a spurious warning in TC recently, but the error
message did not provide enough information to know what the problem
is:

  FAIL: Found 'netdevsim' in command output, leaky extack?

Add the extack to the output:

  FAIL: Unexpected command output, leaky extack? ('netdevsim', 'Warning: Filter with specified priority/protocol not found.')

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/bpf_offload.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index 3efe44f6e92a..d10f420e4ef6 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -594,8 +594,9 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
     check_extack(output, "netdevsim: " + reference, args)
 
 def check_no_extack(res, needle):
-    fail((res[1] + res[2]).count(needle) or (res[1] + res[2]).count("Warning:"),
-         "Found '%s' in command output, leaky extack?" % (needle))
+    haystack = (res[1] + res[2]).strip()
+    fail(haystack.count(needle) or haystack.count("Warning:"),
+         "Unexpected command output, leaky extack? ('%s', '%s')" % (needle, haystack))
 
 def check_verifier_log(output, reference):
     lines = output.split("\n")
-- 
2.47.0


