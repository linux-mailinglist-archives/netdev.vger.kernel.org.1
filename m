Return-Path: <netdev+bounces-144339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1EC9C6B39
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CD7B26013
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856A1C07C3;
	Wed, 13 Nov 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad5DaurI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD541BE86A
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488932; cv=none; b=Ebwt2UA/D+bQEjnfGKDwXSePozcJY9CDxOLcq36ChIwKwsKctO3evj9KwYhiIqbzzxtFp7z01gdMshKt0ehkZs/hEro2ymBOyyskGH352C9+MB5U8PpFkj/dsNtADL1M7hZN3AG/G8VxnPJBH+hmoS2TF+oVOiZCE4IeBuZGcwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488932; c=relaxed/simple;
	bh=ohjqzMpsu21GuDKSMl0u0Kku7h3y+NzZyYyujI8tG/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ9tQ/nZqfxUgoa1RxUKwkdEAn5FhI3zsY5GfL+q5w6zmfxLOSHKnVdfQi1uzQCpETEanIILNZON9jabqWJZV6f43JbS+FWhdjzqJsRMmURBVJYY7ueqnhcBOIRRtQwhU7LDPG0uuThIy6UBm5VeslpYL7pyccp55sVhImu4cIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad5DaurI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so44754501fa.1
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 01:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731488928; x=1732093728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NYGGqDNm/aoW1tOjWuU2CXuiumwETODf+xi+nymdIk=;
        b=Ad5DaurIWXIu4l/vcl0P+Sk3j52wi4j9FU7EINzXU/leC0w//iMEDEW5AvQ4dGhKjO
         dYatDx9WB0/s9n6O2UNM1yy1gf+r+FZ04u3SBz6SernoWsVwaweXvqwQdcwj706DmyE1
         irTPgLHJjb+cIejtKYtZ+fLaSe4jbQZzI1Mqkb3VAKGFCya2l41PyX5p7KlY0ZaM024M
         sROL2eaUg6C0Y2DE4E3tCSpjdAFrKppAzFvj40ueoHhXVn46wcXFiJHeiuXw2hkmHj0X
         ffb7WqlDvmFHOClABZlFr6tLujLOpFEM0AKHl0+GQDFT+sHK9sxO1Jp8QXgwwmlvBeUr
         nVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731488928; x=1732093728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NYGGqDNm/aoW1tOjWuU2CXuiumwETODf+xi+nymdIk=;
        b=ahjwVR1+9bFsRaxE0/kKfd/pMToVObkUgI/UY403avEqRB490ugewVDqGfQytlhMjr
         wyhZx3Rm7+iuHMk6vxw/qRRGnl7mDktz7sBXegflaZNLZaONHzEecRH8uCLogKWSY9VF
         otcBdmXyDCQHj226dHqcjLyGJjWzCuBJwm918D4+s0a4CA7wICnIBlWiCtDcaLlssQ5a
         hX/g4BR2HoNRlnt7IgCztBfFVcukGM3Mnog92s+c89gJBelx2lKvgg5CO7+rhdguJvdh
         88vDCi6/uM6xvDqQuJgX1oAUWJqcfPJnVi16hkIsQhNB2CS3xsuDQADOhzauU/jLkl7Y
         tetQ==
X-Gm-Message-State: AOJu0YyNVy5xk19xzcmYNcJep4ctRTKKESahwNmtkRStGMAFDaadofuZ
	YbqH7udz+nThhKKA2LhMo1631jpoi8a8upxYmXGVA3CLh5U28cwKcWy+CYC/
X-Google-Smtp-Source: AGHT+IHiI/TEx3BTswRAwctRS2IK6RiDjUIQA28fCI4q659SDAVz0B3+xCp/ByOrfY3KRQADH5UmIw==
X-Received: by 2002:a05:651c:b23:b0:2f7:7cf7:474d with SMTP id 38308e7fff4ca-2ff202686afmr90814511fa.27.1731488927982;
        Wed, 13 Nov 2024 01:08:47 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:c1e8:dddd:ac2:ca40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5503c63sm16939165e9.26.2024.11.13.01.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:08:47 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 1/2] Revert "tools/net/ynl: improve async notification handling"
Date: Wed, 13 Nov 2024 09:08:42 +0000
Message-ID: <20241113090843.72917-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241113090843.72917-1-donald.hunter@gmail.com>
References: <20241113090843.72917-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 1bf70e6c3a5346966c25e0a1ff492945b25d3f80.

This modification to check_ntf() is being reverted so that its behaviour
remains equivalent to ynl_ntf_check() in the C YNL. Instead a new
poll_ntf() will be added in a separate patch.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/cli.py     | 10 +++-----
 tools/net/ynl/lib/ynl.py | 49 ++++++++++++++++------------------------
 2 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 9e95016b85b3..b8481f401376 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -5,7 +5,6 @@ import argparse
 import json
 import pprint
 import time
-import signal
 
 from lib import YnlFamily, Netlink, NlError
 
@@ -18,8 +17,6 @@ class YnlEncoder(json.JSONEncoder):
             return list(obj)
         return json.JSONEncoder.default(self, obj)
 
-def handle_timeout(sig, frame):
-    exit(0)
 
 def main():
     description = """
@@ -84,8 +81,7 @@ def main():
         ynl.ntf_subscribe(args.ntf)
 
     if args.sleep:
-        signal.signal(signal.SIGALRM, handle_timeout)
-        signal.alarm(args.sleep)
+        time.sleep(args.sleep)
 
     if args.list_ops:
         for op_name, op in ynl.ops.items():
@@ -110,8 +106,8 @@ def main():
         exit(1)
 
     if args.ntf:
-        for msg in ynl.check_ntf():
-            output(msg)
+        ynl.check_ntf()
+        output(ynl.async_msg_queue)
 
 
 if __name__ == "__main__":
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 92f85698c50e..c22c22bf2cb7 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -12,8 +12,6 @@ import sys
 import yaml
 import ipaddress
 import uuid
-import queue
-import time
 
 from .nlspec import SpecFamily
 
@@ -491,7 +489,7 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_GET_STRICT_CHK, 1)
 
         self.async_msg_ids = set()
-        self.async_msg_queue = queue.Queue()
+        self.async_msg_queue = []
 
         for msg in self.msgs.values():
             if msg.is_async:
@@ -905,39 +903,32 @@ class YnlFamily(SpecFamily):
 
         msg['name'] = op['name']
         msg['msg'] = attrs
-        self.async_msg_queue.put(msg)
+        self.async_msg_queue.append(msg)
 
-    def check_ntf(self, interval=0.1):
+    def check_ntf(self):
         while True:
             try:
                 reply = self.sock.recv(self._recv_size, socket.MSG_DONTWAIT)
-                nms = NlMsgs(reply)
-                self._recv_dbg_print(reply, nms)
-                for nl_msg in nms:
-                    if nl_msg.error:
-                        print("Netlink error in ntf!?", os.strerror(-nl_msg.error))
-                        print(nl_msg)
-                        continue
-                    if nl_msg.done:
-                        print("Netlink done while checking for ntf!?")
-                        continue
+            except BlockingIOError:
+                return
 
-                    decoded = self.nlproto.decode(self, nl_msg, None)
-                    if decoded.cmd() not in self.async_msg_ids:
-                        print("Unexpected msg id while checking for ntf", decoded)
-                        continue
+            nms = NlMsgs(reply)
+            self._recv_dbg_print(reply, nms)
+            for nl_msg in nms:
+                if nl_msg.error:
+                    print("Netlink error in ntf!?", os.strerror(-nl_msg.error))
+                    print(nl_msg)
+                    continue
+                if nl_msg.done:
+                    print("Netlink done while checking for ntf!?")
+                    continue
 
-                    self.handle_ntf(decoded)
-            except BlockingIOError:
-                pass
+                decoded = self.nlproto.decode(self, nl_msg, None)
+                if decoded.cmd() not in self.async_msg_ids:
+                    print("Unexpected msg id done while checking for ntf", decoded)
+                    continue
 
-            try:
-                yield self.async_msg_queue.get_nowait()
-            except queue.Empty:
-                try:
-                    time.sleep(interval)
-                except KeyboardInterrupt:
-                    return
+                self.handle_ntf(decoded)
 
     def operation_do_attributes(self, name):
       """
-- 
2.47.0


