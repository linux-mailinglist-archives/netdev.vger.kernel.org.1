Return-Path: <netdev+bounces-136920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D349A3A10
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89D31F27276
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625241FF7AF;
	Fri, 18 Oct 2024 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODCLmEF5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DA1FF7B1
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243956; cv=none; b=ibukLuG+X5o1M2PDiaxgqDZnIj1uG5P47wLHDGdgoxz13JPU202ascJwKpXquhZ9omDfVKN/5nTPVbKtcIZ8wOVHdgTUD0q6aWKauYiYHbgf2kaZRnazagZ0ymiKZ9MGBSOz4tCG4MYfWDL3owpTKqsl1Ez8iaDjNQr5NF5qgHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243956; c=relaxed/simple;
	bh=QFnnJ7uXi/14ttEBBVUKW6IqjIeEcaaggV0/8puM75w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUnKJNZy6SHIAvWUWTvztwmzRVTRaGpjimKXElVuWJlmSV0+CJXTXqYEUxI2vMMHA8AFUkxx/cadnx2CoveA/830UrwwSgdNlZl2KUeVTmZILHmO1V4ZY8PqBOHJ+n1eH5uVq8O+Ra1XS0jnprC+6Y5e0cicy7jFfGuWTuWY1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODCLmEF5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so18698715e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729243952; x=1729848752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wcyi3QBEKMLJimsSdaShQH9KZmkXCgU284u45fJMhgY=;
        b=ODCLmEF5Q4a/lWfmvsc4Gn90h98ldwKv7YFGf6sslCIKbKQTF8resw2L95RUlvUHxb
         E2QUDMMAJ117/frA8TtlHW70qgOZZ/G2GWz0arOeakZN8lZhI4fMb446CT65JkuyFRDP
         Jss33Ts0qoz6YN+jRMRdGpz4HM25EqbDcwhHziO+BgkwyGSrpQlbVVoUgyPFRiLZX5WG
         hEvBN3l+/SBgeZXJUCw4rgKG3GbnFzsDrDTEhP+TLH3ryhHVw6/tDyE2IaxLT9fc9o78
         lmcq3eoITZa1dssm509HmXVjcmg3sxz4eqncHlyAo0gqFv9jmq7DMgVxoFHwQujiNcjU
         T5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729243952; x=1729848752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wcyi3QBEKMLJimsSdaShQH9KZmkXCgU284u45fJMhgY=;
        b=Yu1RWn7+SGTfRqQQ+XkG6XwWyPD8n3pAV/84awKYC6/vim5N2bPeLzRgc0gElVFl9c
         H96Gfo/TqY5ge//73FJ8XXPerzGvN8QfKOVa5aeIrogGbamDc9dtL3fegsbJjtsiKDIX
         oXrbMW8nI75oHu3VDvExf4K8I/l/dzDzCFOJW2OEokU5aj1lCbPFvsxXpYKWbHaZQ6vE
         tKVLG1+aPEOvc1lOdWKPtRkR5WXc80HSlwUPgYmQeKwqS9EdyxvyCgR9kJXLKMdREwth
         GSgEMLHzzvesso6O5s2/3IcjIPVDkKJdT0CU1EP9XhiJ/x9LoV1+mMTZ66Nr4+l866T+
         /o9g==
X-Gm-Message-State: AOJu0Ywx+McsTE0CmeLyOMRGmDarjYWaCJjYUv5PSKRpSlBJNpvBQF1e
	td9vZdytzWH2yvD7u8en1uXsXvmOcrRP9cD9wkjSm8mju0NJJcGdoP50KA==
X-Google-Smtp-Source: AGHT+IG+DOEHAUVlYWBysK0hMZ6ghnKUgRGxqon0v45S+lpAacJqQsQ2x5W/ziCLXmYpg+PhAK972g==
X-Received: by 2002:a05:600c:4508:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-4316163d495mr12806645e9.8.1729243952056;
        Fri, 18 Oct 2024 02:32:32 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:8040:ab28:8276:f527])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431606d5456sm22107275e9.42.2024.10.18.02.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:32:31 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] tools/net/ynl: improve async notification handling
Date: Fri, 18 Oct 2024 10:32:28 +0100
Message-ID: <20241018093228.25477-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The notification handling in ynl is currently very simple, using sleep()
to wait a period of time and then handling all the buffered messages in
a single batch.

This patch changes the notification handling so that messages are
processed as they are received. This makes it possible to use ynl as a
library that supplies notifications in a timely manner.

- Change check_ntf() to be a generator that yields 1 notification at a
  time and blocks until a notification is available.
- Use the --sleep parameter to set an alarm and exit when it fires.

This means that the CLI has the same interface, but notifications get
printed as they are received:

./tools/net/ynl/cli.py --spec <SPEC> --subscribe <TOPIC> [ --sleep <SECS> ]

Here is an example python snippet that shows how to use ynl as a library
for receiving notifications:

    ynl = YnlFamily(f"{dir}/rt_route.yaml")
    ynl.ntf_subscribe('rtnlgrp-ipv4-route')

    for event in ynl.check_ntf():
        handle(event)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/cli.py     | 10 +++++---
 tools/net/ynl/lib/ynl.py | 49 ++++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index b8481f401376..9e95016b85b3 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -5,6 +5,7 @@ import argparse
 import json
 import pprint
 import time
+import signal
 
 from lib import YnlFamily, Netlink, NlError
 
@@ -17,6 +18,8 @@ class YnlEncoder(json.JSONEncoder):
             return list(obj)
         return json.JSONEncoder.default(self, obj)
 
+def handle_timeout(sig, frame):
+    exit(0)
 
 def main():
     description = """
@@ -81,7 +84,8 @@ def main():
         ynl.ntf_subscribe(args.ntf)
 
     if args.sleep:
-        time.sleep(args.sleep)
+        signal.signal(signal.SIGALRM, handle_timeout)
+        signal.alarm(args.sleep)
 
     if args.list_ops:
         for op_name, op in ynl.ops.items():
@@ -106,8 +110,8 @@ def main():
         exit(1)
 
     if args.ntf:
-        ynl.check_ntf()
-        output(ynl.async_msg_queue)
+        for msg in ynl.check_ntf():
+            output(msg)
 
 
 if __name__ == "__main__":
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index c22c22bf2cb7..92f85698c50e 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -12,6 +12,8 @@ import sys
 import yaml
 import ipaddress
 import uuid
+import queue
+import time
 
 from .nlspec import SpecFamily
 
@@ -489,7 +491,7 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_GET_STRICT_CHK, 1)
 
         self.async_msg_ids = set()
-        self.async_msg_queue = []
+        self.async_msg_queue = queue.Queue()
 
         for msg in self.msgs.values():
             if msg.is_async:
@@ -903,32 +905,39 @@ class YnlFamily(SpecFamily):
 
         msg['name'] = op['name']
         msg['msg'] = attrs
-        self.async_msg_queue.append(msg)
+        self.async_msg_queue.put(msg)
 
-    def check_ntf(self):
+    def check_ntf(self, interval=0.1):
         while True:
             try:
                 reply = self.sock.recv(self._recv_size, socket.MSG_DONTWAIT)
-            except BlockingIOError:
-                return
+                nms = NlMsgs(reply)
+                self._recv_dbg_print(reply, nms)
+                for nl_msg in nms:
+                    if nl_msg.error:
+                        print("Netlink error in ntf!?", os.strerror(-nl_msg.error))
+                        print(nl_msg)
+                        continue
+                    if nl_msg.done:
+                        print("Netlink done while checking for ntf!?")
+                        continue
 
-            nms = NlMsgs(reply)
-            self._recv_dbg_print(reply, nms)
-            for nl_msg in nms:
-                if nl_msg.error:
-                    print("Netlink error in ntf!?", os.strerror(-nl_msg.error))
-                    print(nl_msg)
-                    continue
-                if nl_msg.done:
-                    print("Netlink done while checking for ntf!?")
-                    continue
+                    decoded = self.nlproto.decode(self, nl_msg, None)
+                    if decoded.cmd() not in self.async_msg_ids:
+                        print("Unexpected msg id while checking for ntf", decoded)
+                        continue
 
-                decoded = self.nlproto.decode(self, nl_msg, None)
-                if decoded.cmd() not in self.async_msg_ids:
-                    print("Unexpected msg id done while checking for ntf", decoded)
-                    continue
+                    self.handle_ntf(decoded)
+            except BlockingIOError:
+                pass
 
-                self.handle_ntf(decoded)
+            try:
+                yield self.async_msg_queue.get_nowait()
+            except queue.Empty:
+                try:
+                    time.sleep(interval)
+                except KeyboardInterrupt:
+                    return
 
     def operation_do_attributes(self, name):
       """
-- 
2.47.0


