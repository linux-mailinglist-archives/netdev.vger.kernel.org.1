Return-Path: <netdev+bounces-143289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D39C1D1C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87022282A5F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03A1E883E;
	Fri,  8 Nov 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDf7yxqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E61E7C26
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069511; cv=none; b=fa+73rbD4Mgbv1Obz3vOLdTQbt1vzZVysFl4EQHhn83ArPpu9j7+ZHPup8ev2lNBnadbudvk2AL2bvZjuWXX3ZJCanySiRiw1Xkge7QJ+prH2GBBt7rYELdpVUorHg740ZnrU7bf95ITD47mCC3JOHlVNmOOb3qlb+wXS39K4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069511; c=relaxed/simple;
	bh=6uhhLHdX8wI5DTj5B2dsks+AMNym2eCsT19vTsAyNOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHIYZYuN9/JkYS6KgfWBzBoPYENch3pV4gK+tRuFh+Ha1/OZEVQUoOOmu/9IAG7NimXkugP9U1Soz3sQW3wfbh/oLEFNZBFQQxXA2N2svFMPL1yhmxM4zPK+rpLOLKFHG7+xMwiQfwXqBncKqtlTVYc5+b0A0uo+PbGd6A5rFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDf7yxqz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so2091617e87.2
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731069507; x=1731674307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX+5sFCdsUeVNERYlwF+hY0WGapUy1gc9BsqgVDvwUI=;
        b=cDf7yxqzT/F74yspVFlUr7GwC65iUrLafu7p8uGFgG8eGFZSocb759Avyy3FNoPQHd
         yWZoqvU2ptSqf5CCET13Jl2O3+4vzv/513iQUdKyqB0PMOrJ8YEWcznQCCQplWrzVnxg
         LCPdhwy7BRut+CaVTRB0FHOQgf5hGM42KHSGQINFN0bmrsVYXkMXEairjixEaHyHBfGG
         2Yub5d1kcIRePvljeAfmqoCcZVZmCX0AAc5M2+6ZsYlemw8diGC/eEaMIwKlX0SQWZbZ
         mFRFnXKmypddtj9a/o68E/hukal/JqLgCRhBnMOuX3g8UEQGTei32u1b3BNRGogsBadE
         lTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731069507; x=1731674307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX+5sFCdsUeVNERYlwF+hY0WGapUy1gc9BsqgVDvwUI=;
        b=Kd8p5ZaEsajHuXn1VOJ8Dxt4xSqCOyKOfgTiHNuxJx6mYk+u2HsEg31WCuo6Y33oyN
         4aDqPuii+S1VNV96yvaS7cA2jP+1rPb6/mgse8QNppvQYwNVl9ILUBgook87xrBsxHHI
         IRaZ8T71r3jz4Y7HojniAepkAJbS3BWbAF+SK0aF2sU4Qj9GAcIpFb/lNGBW9aqvtgrH
         Xxr1KzVKu1GIEN7qoP863gxDIM+yXFKLkkE7i2NZsFVVZ/aoaTT+KcyAKHpl1TLwZdNC
         oFJk7dT6PggRpLZwj4Q7uhXuSMRTwfADBo5tePHay2RoFbuWlVzAp7zSvpnAKECBlxZp
         yRMw==
X-Gm-Message-State: AOJu0Yz5QHBI2yQ/dZYA8+Jmrm6sgjTOpcuV8vmB7yV37N6z+im7RPdZ
	pD97ONwyw6X6GfMXgPmVwJgyl7M73zPbEcEaqNM85ZPPS8jb+6tRYOS/CMiK
X-Google-Smtp-Source: AGHT+IEz93LRUd3hZfFM6zJ8CZ3Qjimd4S5FvAwVgsiR7hZ1DzpQ0rpz4yREViowo3+9sp70bgvbZQ==
X-Received: by 2002:a05:6512:1046:b0:539:e5e9:2159 with SMTP id 2adb3069b0e04-53d862cd2b3mr1691806e87.31.1731069506628;
        Fri, 08 Nov 2024 04:38:26 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:68e2:1bff:d8bf:7339])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c1f56sm62991365e9.34.2024.11.08.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 04:38:25 -0800 (PST)
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
Subject: [PATCH net-next v1 2/2] tools/net/ynl: add async notification handling
Date: Fri,  8 Nov 2024 12:38:16 +0000
Message-ID: <20241108123816.59521-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108123816.59521-1-donald.hunter@gmail.com>
References: <20241108123816.59521-1-donald.hunter@gmail.com>
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

This patch adds async notification handling so that messages can be
processed as they are received. This makes it possible to use ynl as a
library that supplies notifications in a timely manner.

- Add poll_ntf() to be a generator that yields 1 notification at a
  time and blocks until a notification is available.
- Add a --duration parameter to the CLI, with --sleep as an alias.

./tools/net/ynl/cli.py \
    --spec <SPEC> --subscribe <TOPIC> [ --duration <SECS> ]

Here is an example python snippet that shows how to use ynl as a library
for receiving notifications:

    ynl = YnlFamily(f"{dir}/rt_route.yaml")
    ynl.ntf_subscribe('rtnlgrp-ipv4-route')

    for event in ynl.poll_ntf():
        handle(event)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/cli.py     | 14 ++++++--------
 tools/net/ynl/lib/ynl.py | 22 +++++++++++++++++++---
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index b8481f401376..9853fd261ee4 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -4,7 +4,6 @@
 import argparse
 import json
 import pprint
-import time
 
 from lib import YnlFamily, Netlink, NlError
 
@@ -17,7 +16,6 @@ class YnlEncoder(json.JSONEncoder):
             return list(obj)
         return json.JSONEncoder.default(self, obj)
 
-
 def main():
     description = """
     YNL CLI utility - a general purpose netlink utility that uses YAML
@@ -43,7 +41,10 @@ def main():
     group.add_argument('--list-ops', action='store_true')
     group.add_argument('--list-msgs', action='store_true')
 
-    parser.add_argument('--sleep', dest='sleep', type=int)
+    parser.add_argument('--duration', dest='duration', type=int,
+                        help='when subscribed, watch for DURATION seconds')
+    parser.add_argument('--sleep', dest='duration', type=int,
+                        help='alias for duration')
     parser.add_argument('--subscribe', dest='ntf', type=str)
     parser.add_argument('--replace', dest='flags', action='append_const',
                         const=Netlink.NLM_F_REPLACE)
@@ -80,9 +81,6 @@ def main():
     if args.ntf:
         ynl.ntf_subscribe(args.ntf)
 
-    if args.sleep:
-        time.sleep(args.sleep)
-
     if args.list_ops:
         for op_name, op in ynl.ops.items():
             print(op_name, " [", ", ".join(op.modes), "]")
@@ -106,8 +104,8 @@ def main():
         exit(1)
 
     if args.ntf:
-        ynl.check_ntf()
-        output(ynl.async_msg_queue)
+        for msg in ynl.poll_ntf(duration=args.duration):
+            output(msg)
 
 
 if __name__ == "__main__":
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index c22c22bf2cb7..3eca432f5d7b 100644
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
@@ -903,7 +905,7 @@ class YnlFamily(SpecFamily):
 
         msg['name'] = op['name']
         msg['msg'] = attrs
-        self.async_msg_queue.append(msg)
+        self.async_msg_queue.put(msg)
 
     def check_ntf(self):
         while True:
@@ -925,11 +927,25 @@ class YnlFamily(SpecFamily):
 
                 decoded = self.nlproto.decode(self, nl_msg, None)
                 if decoded.cmd() not in self.async_msg_ids:
-                    print("Unexpected msg id done while checking for ntf", decoded)
+                    print("Unexpected msg id while checking for ntf", decoded)
                     continue
 
                 self.handle_ntf(decoded)
 
+    def poll_ntf(self, interval=0.1, duration=None):
+        endtime = time.time() + duration if duration else None
+        while True:
+            try:
+                self.check_ntf()
+                yield self.async_msg_queue.get_nowait()
+            except queue.Empty:
+                try:
+                    time.sleep(interval)
+                except KeyboardInterrupt:
+                    return
+            if endtime and endtime < time.time():
+                return
+
     def operation_do_attributes(self, name):
       """
       For a given operation name, find and return a supported
-- 
2.47.0


