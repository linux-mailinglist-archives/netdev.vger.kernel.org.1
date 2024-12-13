Return-Path: <netdev+bounces-151818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954899F10D9
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D23163BD4
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF91E377E;
	Fri, 13 Dec 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLgP0HLd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800F1E3769;
	Fri, 13 Dec 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103375; cv=none; b=Hamt352n2hVvF5tix04zczm4ZfbhHyjTI7U+u8KGYTTBTu5hqIok2PlhpNCIAhG3kplMQ6XS+NP4r5Ns8TBQp5vXLdb6pEA8wo4JuT7Wwr1xaCZrdox8yBvMEh/ptkDMLH3sckGjRVo9uWNHctth3C3S07uRhegKAyjGoG1z+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103375; c=relaxed/simple;
	bh=IxAuYcWype869icFjRSyjTERVjyGtQO/sWtOyqzdQaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/RJ0RGb0Dhw1MWSjymYrdT1tVkpwzcIQ8ikR9vWC3pthvoktI5KgfLAZ1oYL8/7nuTk4REuYglwg34rRO1IK/Xt9TkKT53bJPBUTvjrC8rDA3thY5IVviUxXvLt4kmicQXQMfjdVAoduYwec+2Nb2ciI4JW6daV1qjcYhbMJ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLgP0HLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8580C4CEE0;
	Fri, 13 Dec 2024 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103375;
	bh=IxAuYcWype869icFjRSyjTERVjyGtQO/sWtOyqzdQaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLgP0HLdfIOtTPTdTBk7hmrEiTE0OtOo25dDZkNgN7Lcp+FWeQnviY4lYinj+u3M/
	 lqz2PjXUqlwi0BIWUQm5lwe0RR6MnmoHhvsxeeVdonMSrlk0QhLMY8aUIDNHHRVlTf
	 s/7IT6ROnXMmQpqfCDakXgA+ng3sWKMAPDdBOb3WfzLBT/UbbdaSj+LQYOM0hJjFuh
	 Y7K5pmNCdQQiokdGswGKfBhFAsrSnwAmq6hccQ1uiTuPyUgClK4PDh7wiHIppPT7lI
	 5c7CgOaKl+4/myRy2j7+OcGFFYcPTLNmM2oYpQkjPXw2zcuajc7JuYc8nM8AbHmFmO
	 jI1SJoPyuLnxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	jiri@resnulli.us,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 3/5] selftests: net: support setting recv_size in YNL
Date: Fri, 13 Dec 2024 07:22:42 -0800
Message-ID: <20241213152244.3080955-4-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213152244.3080955-1-kuba@kernel.org>
References: <20241213152244.3080955-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recv_size parameter allows constraining the buffer size for dumps.
It's useful in testing kernel handling of dump continuation,
IOW testing dumps which span multiple skbs.

Let the tests set this parameter when initializing the YNL family.
Keep the normal default, we don't want tests to unintentionally
behave very differently than normal code.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: jiri@resnulli.us
CC: petrm@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/ynl.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index a0d689d58c57..076a7e8dc3eb 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -32,23 +32,23 @@ from .ksft import ksft_pr, ktap_result
 # Set schema='' to avoid jsonschema validation, it's slow
 #
 class EthtoolFamily(YnlFamily):
-    def __init__(self):
+    def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('ethtool.yaml')).as_posix(),
-                         schema='')
+                         schema='', recv_size=recv_size)
 
 
 class RtnlFamily(YnlFamily):
-    def __init__(self):
+    def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
-                         schema='')
+                         schema='', recv_size=recv_size)
 
 
 class NetdevFamily(YnlFamily):
-    def __init__(self):
+    def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('netdev.yaml')).as_posix(),
-                         schema='')
+                         schema='', recv_size=recv_size)
 
 class NetshaperFamily(YnlFamily):
-    def __init__(self):
+    def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('net_shaper.yaml')).as_posix(),
-                         schema='')
+                         schema='', recv_size=recv_size)
-- 
2.47.1


