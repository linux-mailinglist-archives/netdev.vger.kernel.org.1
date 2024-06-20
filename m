Return-Path: <netdev+bounces-105485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE999116B6
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3E61C2274C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B214374E;
	Thu, 20 Jun 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsUnK8CW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5257130ADA
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926153; cv=none; b=Fu1nQzha7ZT9EiuYxQ0pFFpAD/m8+IQ+VmpfvvLuJCOxDjWxwF2WfENoggQru/HX/+S7ExZlQbSqFIqqUjnrOr6wWsCyRInK2oSeM6rip2Mlm1uq/SW8uMLVXN5arBRkWHjkd8wnmjPHwrtHx1x015INoQPTHORqZ1P98Khh9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926153; c=relaxed/simple;
	bh=ntpxYppCIoJn8lPT5mNgVV6d3Hw983mb6VVLWtN7yxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUWSTfSAly4kHL566OAmAIyC5+heckPZi0WatMZryswsKgGZ4/HU9BZnNg00iyYPrrMfCz8HJck+Th2ID/z7NTjZnlzYy8oKUBWwbpfpnngsfymfIAaY/UrLarUamqc566coH53PzrcEPOZjiZjlXuAHESgyyl+L2N834fAD/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsUnK8CW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A99EC32781;
	Thu, 20 Jun 2024 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718926153;
	bh=ntpxYppCIoJn8lPT5mNgVV6d3Hw983mb6VVLWtN7yxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsUnK8CWkwxc8kZ/pydG/5CNGoyuokMWlIXhtnfZ7iJ4liZu5TGtsR6wnH8Y968Ix
	 gw7X0b6W0heRzfZ2xJaM/rcW1tbUPsj86NIsqubm58Zq40s6VMmqMay3TDZXQtLigi
	 Dua4x6c7n8LnOiPm45P8ue0BarQixLBVK3f+EGRpAEk75CiHlEwXllcxI1NykIpvSK
	 Deo7qkEvgP0VMwJDFKjW0safYtOo6Ydit0yGLih1zL373627JL0kUI0aoZcBComW4m
	 ZubGsKGVUjdIt05I1+76YJdZpTvqbdauSh9WhbLsLX60/wfT9f2vV9Toc0P5dMV4is
	 V7CkkaykSdMNQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/4] selftests: drv-net: try to check if port is in use
Date: Thu, 20 Jun 2024 16:28:58 -0700
Message-ID: <20240620232902.1343834-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620232902.1343834-1-kuba@kernel.org>
References: <20240620232902.1343834-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use random ports for communication. As Willem predicted
this leads to occasional failures. Try to check if port is
already in use by opening a socket and binding to that port.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 0540ea24921d..9fa9ec720c89 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -3,6 +3,7 @@
 import json as _json
 import random
 import re
+import socket
 import subprocess
 import time
 
@@ -81,7 +82,17 @@ import time
     """
     Get unprivileged port, for now just random, one day we may decide to check if used.
     """
-    return random.randint(10000, 65535)
+    while True:
+        port = random.randint(10000, 65535)
+        try:
+            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
+                s.bind(("", port))
+            with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+                s.bind(("", port))
+            return port
+        except OSError as e:
+            if e.errno != 98:  # already in use
+                raise
 
 
 def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):
-- 
2.45.2


