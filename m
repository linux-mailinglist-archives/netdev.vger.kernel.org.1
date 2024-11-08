Return-Path: <netdev+bounces-143288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE39C1D1B
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458661C22BD5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE611E8824;
	Fri,  8 Nov 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+T1S0iA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2201E5000
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069510; cv=none; b=WS8OyxOfAyl3qABDJ/reQY5XlTzmoI58gPSr0hqC/wjU6ZyzLrHc7+nuAxKYkyN1e0JJVhFZaG4wXdn6CHESWmZu5qMv5hJzLhKCB3e1dhp9aHCbStjqFKMaNyDNeZ35fX7Vqv/7tYBBobUpD9cp40lWOeKoi3uB/DpQ0nvmeOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069510; c=relaxed/simple;
	bh=ohjqzMpsu21GuDKSMl0u0Kku7h3y+NzZyYyujI8tG/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQoQVIpQiuCM8ctXUoHZCTco979Ebmro1/WM5o4McSloHSlkd7BG3312fm05gU8RbYBalh5jSZB1jPNk4sEFW4kJRAA14zDTEUZSJL7pRNr1dz6IrsZtFI5ylHFP9z6ExSMcdp5q/mEShFLXh4oVTXwoyj4VgoO8JQCHYMShqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+T1S0iA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53a097aa3daso1795587e87.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 04:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731069506; x=1731674306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NYGGqDNm/aoW1tOjWuU2CXuiumwETODf+xi+nymdIk=;
        b=F+T1S0iAD0uwDaF460SkRXUQ+FPQvKJS8eVZCQbAJ+oP5pc2tjYFe5C/0XpkazxO6M
         0R6shmsBPE+VF5nh0mz0MFJgh99jyyfacz2CQ99hlueqdJnKQHlIumz5N7VAGukJD66a
         qsihxHqNdcVeQhkHcXrrL5nYyCIIoebBZPwBNlk0CmZGlvLFLbv3VZXvn/B4fosiB6Az
         lc44UqrnkwN+rxr306KCBFxW02z4ZE5MEABFbJo6urp96TDI9oS42bebbnEUCYYFxGy0
         ABnXFopcwTqBhtRR8+QQ/y4WscWZMYhkln9JdaTVL+zQ15ZnpjtDuEYn4/0sW6MZjcp/
         DvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731069506; x=1731674306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NYGGqDNm/aoW1tOjWuU2CXuiumwETODf+xi+nymdIk=;
        b=hJlYRmFTKBEmf4bUMtcV48KxvLtjUCrtaUm+Y97SyORgtnLKOwE6KREEOT4OV74++H
         byQ+ESkKXqTxtKUFxZIF38hUt4cu/skGa2AMs7PmA4/3O754GnAbzBBO8p/ZxWzX1G+X
         RUnev6WuPWzbxBAi2aIxze3/BVT3Qh5/nVxPgv2ZwfK7/Jt6zyHV6NhFeRy3ywVykdtn
         Py6ZTe56ipdvIy4HHLJwbWxy3lV54WncjNeZhcwCweqoeOy6cwBuS50RRpieHfYGJfWL
         dToitpkB3cwjvwOVki6Z2SBVcwaB+Ii7KE/tVAV3m9HCBU40r7v8PL7xi0R6OzZH+FV1
         gekQ==
X-Gm-Message-State: AOJu0YxLN+0DYaAga8FIPOsLYilbu+IC0OAHz4D1Unn+Mk4Cz3i2E9gM
	XM4M1eKBYU91DBJ1i7YWv2DRIHnzVh1a7Axy+JDksz7Cl4iEDnimAzAUY7pn
X-Google-Smtp-Source: AGHT+IGSNHEicdPO/rNdWOqBFo3ypvyS+FBiaaVq6XeVINf76LDNHWFIFjma2E3Ww48sdKqp2GKaGw==
X-Received: by 2002:a05:6512:4013:b0:536:55cf:3148 with SMTP id 2adb3069b0e04-53d862c578fmr1353414e87.31.1731069505208;
        Fri, 08 Nov 2024 04:38:25 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:68e2:1bff:d8bf:7339])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c1f56sm62991365e9.34.2024.11.08.04.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 04:38:23 -0800 (PST)
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
Subject: [PATCH net-next v1 1/2] Revert "tools/net/ynl: improve async notification handling"
Date: Fri,  8 Nov 2024 12:38:15 +0000
Message-ID: <20241108123816.59521-2-donald.hunter@gmail.com>
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


