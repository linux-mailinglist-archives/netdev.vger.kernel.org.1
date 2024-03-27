Return-Path: <netdev+bounces-82635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC1188EE21
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 19:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAACBB21972
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC7714F105;
	Wed, 27 Mar 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDWcl568"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E8C14D717
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563431; cv=none; b=gOkJE4A58xaL6sqVHWgXG08PWDqLYs694EhD2ZLgVnVKECAnATBSBRJ5Dr1ZwPH61iEyNrL4u+9c6xnWh4kpX6bCB+u4J5DAupJtlXaUYmmspDBWpDm6dxOxdYMKbzzb39PDmdS+Tz3WYYnDB168RAz/s3UE/kf6nekBA7UzkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563431; c=relaxed/simple;
	bh=ZwOfMQEo85FAbkApsVodyGnX3s2noxt0sg8rMI+dkqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrU/OCIo9BG59t++rpMDrDuDA4AwU1/tGHeITAQ58GHC2nk8KyG/1O8YhxDx84wkqDSX5xsz0ak/vTYruG2UJXhw/wg5N/fbdyMDnsOoQMFscVpIKfnDkesqYMLJ/4h046WcyxcufiL1AR2Zu6a23UBUPmKLcLYNE81oMw1hFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDWcl568; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so22121f8f.2
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711563427; x=1712168227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qn8TFAerzpQEshTl46/Kmqots7yf4ojhzF0TbaqZVQ=;
        b=CDWcl568I/dxMw3EXLPoEv1ipsIWRGgb+43rZsN4T7Ns7rrj9vzU25PVKe5dp7NGDW
         rs/aMy7jMGsbUjsLZkqe56BFgt1j+jLFQuvhHBfKaWMfgrOQS+BYp8D9q3f9ab59vyG4
         uQfjXcnEGBxNpDSMxTtD/q1JldogEY9me6RVI5AOrw8sPisQE+TXN1rJnHdXpZ6QRGbD
         p8IUPG65dU0EF7d/9WxdQgKu45tX6iQNx/yOcv1BLrZxpQ4haCQoeYYxFBhEmsr/XstB
         B6qqa4kTdcQLcQL9JpcOx7lPx/fEEWYI+mNJyZ53f9WYulAN+m1mo0bPo3v88YhEMZ0z
         fNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563427; x=1712168227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qn8TFAerzpQEshTl46/Kmqots7yf4ojhzF0TbaqZVQ=;
        b=BtyiaPWHTs8wT+crcGk2WsX1ra1VyNfHSqdUoqKWDAJ90OKdrF/lJI2AnMZiW3s1Nd
         XHy2P5deWZtaBNREPizSzs+Xfo5d+DIzCOm45zvQKZnPf9TTCVLIm/mSN+1+vtTUvhry
         jeADO7b3lv24aJMF9qK0aGtHwWiEiGdDd6othE/ZXP1zxKbO2x5RzlIj7npxK1Mlnf/J
         Wk3PoJQCDHn7oJ14BSdJ4Vx++43arg6UWOBQk1X/MB0x1gU1MSodwWr7Jn6gu0skAv/j
         8SNWhj2SJn5xmdkzjDCdeBvd2SPnatPahVyE9Gho0UTabipeekNdnGIPZpmWSM7BL850
         Sjug==
X-Gm-Message-State: AOJu0YxBjMU8fkfw4vqKQxcsA4u0V/tBERFF/wEm8i09ViUzx8JIEPDa
	vcrNa/TXEJarox1PiHHPJeSS5X3uCo+w1W/3vCFJ96dHj5PhEZ7w2lysEHUfR3g=
X-Google-Smtp-Source: AGHT+IEzwcAq/r/gKjkq9VnQEaNHYZLr28fY/AggxCHwtEHZgzJXo/nhBfvVmyObpBNhmfUqlXXZ6g==
X-Received: by 2002:adf:c00c:0:b0:33e:d8f:3466 with SMTP id z12-20020adfc00c000000b0033e0d8f3466mr533651wre.33.1711563427149;
        Wed, 27 Mar 2024 11:17:07 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:5876:f134:d112:62c7])
        by smtp.gmail.com with ESMTPSA id t14-20020a0560001a4e00b0033e96fe9479sm15467848wry.89.2024.03.27.11.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:17:06 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message support to ynl
Date: Wed, 27 Mar 2024 18:17:00 +0000
Message-ID: <20240327181700.77940-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327181700.77940-1-donald.hunter@gmail.com>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a "--multi <op> <json>" command line to ynl that makes it possible
to add several operations to a single netlink request payload. The
--multi command line option is repeated for each operation.

This is used by the nftables family for transaction batches. For
example:

./tools/net/ynl/cli.py \
 --spec Documentation/netlink/specs/nftables.yaml \
 --multi batch-begin '{"res-id": 10}' \
 --multi newtable '{"name": "test", "nfgen-family": 1}' \
 --multi newchain '{"name": "chain", "table": "test", "nfgen-family": 1}' \
 --multi batch-end '{"res-id": 10}'

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/cli.py     | 22 ++++++++++++++++---
 tools/net/ynl/lib/ynl.py | 47 +++++++++++++++++++++++++++-------------
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index f131e33ac3ee..1b8f87b472ba 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -19,13 +19,23 @@ class YnlEncoder(json.JSONEncoder):
 
 
 def main():
-    parser = argparse.ArgumentParser(description='YNL CLI sample')
+    description = """
+    YNL CLI utility - a general purpose netlink utility that uses YNL specs
+    to drive protocol encoding and decoding.
+    """
+    epilog = """
+    The --multi option can be repeated to include several operations
+    in the same netlink payload.
+    """
+
+    parser = argparse.ArgumentParser(description=description,
+                                     epilog=epilog)
     parser.add_argument('--spec', dest='spec', type=str, required=True)
     parser.add_argument('--schema', dest='schema', type=str)
     parser.add_argument('--no-schema', action='store_true')
     parser.add_argument('--json', dest='json_text', type=str)
-    parser.add_argument('--do', dest='do', type=str)
-    parser.add_argument('--dump', dest='dump', type=str)
+    parser.add_argument('--do', dest='do', metavar='OPERATION', type=str)
+    parser.add_argument('--dump', dest='dump', metavar='OPERATION', type=str)
     parser.add_argument('--sleep', dest='sleep', type=int)
     parser.add_argument('--subscribe', dest='ntf', type=str)
     parser.add_argument('--replace', dest='flags', action='append_const',
@@ -40,6 +50,8 @@ def main():
     parser.add_argument('--output-json', action='store_true')
     parser.add_argument('--dbg-small-recv', default=0, const=4000,
                         action='store', nargs='?', type=int)
+    parser.add_argument('--multi', dest='multi', nargs=2, action='append',
+                        metavar=('OPERATION', 'JSON_TEXT'), type=str)
     args = parser.parse_args()
 
     def output(msg):
@@ -73,6 +85,10 @@ def main():
         if args.dump:
             reply = ynl.dump(args.dump, attrs)
             output(reply)
+        if args.multi:
+            ops = [ (item[0], json.loads(item[1]), args.flags) for item in args.multi ]
+            reply = ynl.do_multi(ops)
+            output(reply)
     except NlError as e:
         print(e)
         exit(1)
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 557ef5a22b7d..cecd89db7d58 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -927,16 +927,11 @@ class YnlFamily(SpecFamily):
 
       return op['do']['request']['attributes'].copy()
 
-    def _op(self, method, vals, flags=None, dump=False):
-        op = self.ops[method]
-
+    def _encode_message(self, op, vals, flags, req_seq):
         nl_flags = Netlink.NLM_F_REQUEST | Netlink.NLM_F_ACK
         for flag in flags or []:
             nl_flags |= flag
-        if dump:
-            nl_flags |= Netlink.NLM_F_DUMP
 
-        req_seq = random.randint(1024, 65535)
         msg = self.nlproto.message(nl_flags, op.req_value, 1, req_seq)
         if op.fixed_header:
             msg += self._encode_struct(op.fixed_header, vals)
@@ -944,8 +939,20 @@ class YnlFamily(SpecFamily):
         for name, value in vals.items():
             msg += self._add_attr(op.attr_set.name, name, value, search_attrs)
         msg = _genl_msg_finalize(msg)
+        return msg
 
-        self.sock.send(msg, 0)
+    def _ops(self, ops):
+        reqs_by_seq = {}
+        req_seq = random.randint(1024, 65535)
+        payload = b''
+        for (method, vals, flags) in ops:
+            op = self.ops[method]
+            msg = self._encode_message(op, vals, flags, req_seq)
+            reqs_by_seq[req_seq] = (op, msg)
+            payload += msg
+            req_seq += 1
+
+        self.sock.send(payload, 0)
 
         done = False
         rsp = []
@@ -954,8 +961,9 @@ class YnlFamily(SpecFamily):
             nms = NlMsgs(reply, attr_space=op.attr_set)
             self._recv_dbg_print(reply, nms)
             for nl_msg in nms:
-                if nl_msg.extack:
-                    self._decode_extack(msg, op, nl_msg.extack)
+                if nl_msg.extack and nl_msg.nl_seq in reqs_by_seq:
+                    (req_op, req_msg) = reqs_by_seq[nl_msg.nl_seq]
+                    self._decode_extack(req_msg, req_op, nl_msg.extack)
 
                 if nl_msg.error:
                     raise NlError(nl_msg)
@@ -963,13 +971,15 @@ class YnlFamily(SpecFamily):
                     if nl_msg.extack:
                         print("Netlink warning:")
                         print(nl_msg)
+                    del reqs_by_seq[nl_msg.nl_seq]
                     done = True
                     break
 
                 decoded = self.nlproto.decode(self, nl_msg)
+                rsp_op = self.rsp_by_value[decoded.cmd()]
 
                 # Check if this is a reply to our request
-                if nl_msg.nl_seq != req_seq or decoded.cmd() != op.rsp_value:
+                if nl_msg.nl_seq not in reqs_by_seq or decoded.cmd() != rsp_op.rsp_value:
                     if decoded.cmd() in self.async_msg_ids:
                         self.handle_ntf(decoded)
                         continue
@@ -977,19 +987,26 @@ class YnlFamily(SpecFamily):
                         print('Unexpected message: ' + repr(decoded))
                         continue
 
-                rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
+                rsp_msg = self._decode(decoded.raw_attrs, rsp_op.attr_set.name)
                 if op.fixed_header:
-                    rsp_msg.update(self._decode_struct(decoded.raw, op.fixed_header))
+                    rsp_msg.update(self._decode_struct(decoded.raw, rsp_op.fixed_header))
                 rsp.append(rsp_msg)
 
         if not rsp:
             return None
-        if not dump and len(rsp) == 1:
+        if not Netlink.NLM_F_DUMP in flags and len(rsp) == 1:
             return rsp[0]
         return rsp
 
+    def _op(self, method, vals, flags):
+        ops = [(method, vals, flags)]
+        return self._ops(ops)
+
     def do(self, method, vals, flags=None):
-        return self._op(method, vals, flags)
+        return self._op(method, vals, flags or [])
 
     def dump(self, method, vals):
-        return self._op(method, vals, [], dump=True)
+        return self._op(method, vals, [Netlink.NLM_F_DUMP])
+
+    def do_multi(self, ops):
+        return self._ops(ops)
-- 
2.44.0


