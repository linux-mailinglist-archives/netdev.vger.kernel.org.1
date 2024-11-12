Return-Path: <netdev+bounces-144059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D09C567E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD591F25055
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFF7218D98;
	Tue, 12 Nov 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToYk00vD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D400213159
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410258; cv=none; b=o1T/IHQG9uIA5fWFYWfaQ5ELPFHHeD0bRSxRm959k0YxLJ8UK0pDQPPs5Czrq8IC55wElaIiYOkHCXu6UkHp/3WHzJDPQnQza6rfrmvOcOkbkX2ETKGjhPHfm9BR03G1HmLsa+EO97bG5kWy1vURIt0wps9gQhlCubIueF7phsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410258; c=relaxed/simple;
	bh=ohjqzMpsu21GuDKSMl0u0Kku7h3y+NzZyYyujI8tG/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td7bUzmsB1FODI/CjyYbjfPmnkdXNLHH2qGPAYtKCaAqCjBvFoJF6pLFFTEZiW1pBx8Nk+zz0xHMWrrWsqs095+eT9FKLfqRw/l68clVEqaEYm4H/Z8nZlx3Re1epc4m7MdR7EYWomhnt+hLgx14CQ76J7QR6zQsB99ALw58Uyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToYk00vD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43155afca99so36661395e9.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 03:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731410254; x=1732015054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NYGGqDNm/aoW1tOjWuU2CXuiumwETODf+xi+nymdIk=;
        b=ToYk00vDEJ+QYowoWIgypW6Z3vgIlKOhS0freOmxCwzn2XCrMzcPrPRI7tCkLASXO0
         lKJDSMHewf9ltg3lp0N4Vg1AMzEJnRvNrQdVe7J6Ow6m/LC4DmzEZdyGtimF5J7RH77b
         7xbyW4qunEmYdfBNJHKBSzqsjX8AzztNuvawAedCB8BZGxOyUs++KAX1kuqmD9UfC9GC
         Ke6PjVVyuqtsmhsTTKyl0Ygsjo/YGzK279z3jIScMOfh45/llkgZ5lTYnHNKkyl9A5dX
         b2HE7YAPYDt8lpFX5arysKmV0ypkBu0bKMZJcmft/FqzY1OW5Af12rr4kaULQxRLaxs3
         BRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731410254; x=1732015054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NYGGqDNm/aoW1tOjWuU2CXuiumwETODf+xi+nymdIk=;
        b=Cv75ho2SJyf+ZgLfz2uFIkl6cT0O9zFtDDzCXDM6mwK80ky37GKBd+2s29ConeRhEp
         m9DkhbWouiuGXmqqWonvs0vt35t2X4hOOfvoaucUMikaBHpJwJ7xf0EADphFKK+YEfZY
         5jfOYsOqrqShpKHS0jRWJnFsbkDh/fdX6NZ7W3xUdyEbRRmkcqI8aGvklaYZkspmDOro
         0jcu0uztVTh7TbbZX0USPV16Kh8LZAeD+S2j9ll8FW5GjkPTXNNcRj7MVA3joUHeEYMs
         5x2b7lJGWuSQ3+OhE95twSbzifEnG/llyx3JGOaVDhUH4t2EtWPufqTh+SlPKA9In6KS
         Lxow==
X-Gm-Message-State: AOJu0YyQ3DprbBpIBnpKXRbR9nPA8PUOKPn1K2sjRqXt0b6F/SVe/ar2
	YMEi1kqtxsECYR1IbkcrSDwG2o7+2ILrXQvK9dTi4jMEMk1/gLf9QFwKhksM
X-Google-Smtp-Source: AGHT+IHnmTuq+k96RgSd4MEmSv0/h6oLWg5DuARLzdgkjfYwiYg9AcNtJj4ii2poVb7s0hRbV9HVPw==
X-Received: by 2002:a05:600c:548d:b0:42c:b67b:816b with SMTP id 5b1f17b1804b1-432b684f329mr134763755e9.1.1731410254268;
        Tue, 12 Nov 2024 03:17:34 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:a1ef:92f5:9114:b131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm203543685e9.17.2024.11.12.03.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:17:33 -0800 (PST)
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
Subject: [PATCH net-next v2 1/2] Revert "tools/net/ynl: improve async notification handling"
Date: Tue, 12 Nov 2024 11:17:26 +0000
Message-ID: <20241112111727.91575-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241112111727.91575-1-donald.hunter@gmail.com>
References: <20241112111727.91575-1-donald.hunter@gmail.com>
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


