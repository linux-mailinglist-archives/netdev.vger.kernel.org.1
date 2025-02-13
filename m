Return-Path: <netdev+bounces-165724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C53EA33408
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0862A167C69
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6874085D;
	Thu, 13 Feb 2025 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAqKpY2d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB563D984
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406901; cv=none; b=f+RklktzSvh0mgDxvCnOndddFIspSbWtbDyF50C9F08+agl3CrYDIbpO1P+feEfD4Wov2bkeC035bOjnDBn/fX+7AphfJFB00e1H1K/TxJuTYUBXGZaVBZgHCE8frUpvUJ34BAc2Z1Rx/nErjbu0oTVVG6y5gXFRwlduzTNkL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406901; c=relaxed/simple;
	bh=0FSaosIyC6vHW2Tuz3I0pEbkzaVjxhCF8jiJpJSr8ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bck8fPgdQy9t1Q2SvbX6AzcESwTSMoZn5Z9f/p1UzzHZPxGIcivJeZWmLaxQRiDxk42+IEcbrwzwFsnjqRkvKi+NdBXV+FS/uFaFfau+ONentTN+p7z18s/cei5vjdW5/7MD4AjMMYkWHkL6SgeUj4yBi+Gebss5ptF17seBkuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAqKpY2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AA3C4CEE4;
	Thu, 13 Feb 2025 00:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739406900;
	bh=0FSaosIyC6vHW2Tuz3I0pEbkzaVjxhCF8jiJpJSr8ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fAqKpY2dWCd2wyTc5UFCmkubQwHHVYFstS7UhnjLqkzMByi27zJ3hXjNyHeoc9q8m
	 CAAWuEVCNNsaCFqCLLZzkEZ1QjADY7Bqz+apT8uTJQmzDuMzuVVyeelRYzKkGfyfex
	 ww7PL0K7c37ZMtayrgdwlUQB+SvrhhF1oJsv9z7oU01G7tg8/v3ueR5Mxnv0GlMIb0
	 KjuWqEQO8jHCVinlyuyByBnxcViuMKbay6PJifauNcEuXagGTHoCf8cnhey5x6cWw1
	 quzsds89z27crswSpSqf2va30w1fmHWLSQS1QUES+Fe9hRLcLu8Plhlc3kcrOjaUkS
	 Tt3eX9bveONyA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] selftests: drv-net: resolve remote interface name
Date: Wed, 12 Feb 2025 16:34:52 -0800
Message-ID: <20250213003454.1333711-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213003454.1333711-1-kuba@kernel.org>
References: <20250213003454.1333711-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Find out and record in env the name of the interface which remote host
will use for the IP address provided via config.

Interface name is useful for mausezahn and for setting up tunnels.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 886b4904613c..fc649797230b 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -154,6 +154,9 @@ from .remote import Remote
         self.ifname = self.dev['ifname']
         self.ifindex = self.dev['ifindex']
 
+        # resolve remote interface name
+        self.remote_ifname = self.resolve_remote_ifc()
+
         self._required_cmd = {}
 
     def create_local(self):
@@ -200,6 +203,16 @@ from .remote import Remote
             raise Exception("Invalid environment, missing configuration:", missing,
                             "Please see tools/testing/selftests/drivers/net/README.rst")
 
+    def resolve_remote_ifc(self):
+        v4 = v6 = None
+        if self.remote_v4:
+            v4 = ip("addr show to " + self.remote_v4, json=True, host=self.remote)
+        if self.remote_v6:
+            v6 = ip("addr show to " + self.remote_v6, json=True, host=self.remote)
+        if v4 and v6 and v4[0]["ifname"] != v6[0]["ifname"]:
+            raise Exception("Can't resolve remote interface name, v4 and v6 don't match")
+        return v6[0]["ifname"] if v6 else v4[0]["ifname"]
+
     def __enter__(self):
         return self
 
-- 
2.48.1


