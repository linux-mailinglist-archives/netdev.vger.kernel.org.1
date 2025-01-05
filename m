Return-Path: <netdev+bounces-155234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167BEA017BF
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C073A2D16
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7890035940;
	Sun,  5 Jan 2025 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnZyWypb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AA4204E
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040330; cv=none; b=nc2vwKQ8ta7gTrXmxJDiWWqybdNemMECAtjcqsVEwv1Zzesz+Zi8V7z67CWn9x5rz8tIyj2ix+QMsilnN3K9q1WAJq88T2CHW6YA6wkaBMDDPvLZoKvuf3J6iQty6NrykqLZvizFJVwal7vR1OSwK1X7zDHd6jKKfum5FoRFVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040330; c=relaxed/simple;
	bh=EMPpN9Lz77T6bvMY8U6BiqFQv63yYYxLq1+xJQjiHQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciXEnqP27F+jglVboXaBCIzELGgyXSn0x52UP7JHjeFMKaqWY/xE01QaaWI07dPEgSZ5nA/aXtXCgmYI3XS0qP6HKw1goFkKVlzwBrHvtGbgDDcZLxOL5+UaEMwT4gJloMmBZqa0H8pNYgTcakO9C/bKJrP2yk6TcsYQqCX9HZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnZyWypb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94193C4CED1;
	Sun,  5 Jan 2025 01:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736040329;
	bh=EMPpN9Lz77T6bvMY8U6BiqFQv63yYYxLq1+xJQjiHQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnZyWypb4OaLduG2q7ncDPV19gHR0kUs3k1h5YegZdwp2wysRfP074H44v4a9BEsA
	 J5AwdRU0jLsIhvNmeGFjOpELt9eLf62sQxjWJV3yqxjS60/R76kuf1/VpUwJnxZHcT
	 fwoX4HqTE7mtq7rK2WuXQVwpc7zgAqyWOqWyD6OlwjDl3ghH6/Gebx9JFAQCNhhwDK
	 72pwoFApNhshb3TQABfqGGv70NvhERn7RDasSZlf5/QE4lmj5dq7nikMuHYh/vYPv7
	 aBiG0ombq3y5K5PXKc/WtPbMV3ElruJinKiW5eejA73QFlTAURbu6Lqdx6kOOKHXRj
	 2SgU6EdUetg/w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] tools: ynl: print some information about attribute we can't parse
Date: Sat,  4 Jan 2025 17:25:22 -0800
Message-ID: <20250105012523.1722231-3-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105012523.1722231-1-kuba@kernel.org>
References: <20250105012523.1722231-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing throws an exception one often has to figure out which
attribute couldn't be parsed from first principles. For families
with large message parsing trees like rtnetlink guessing the
attribute can be hard.

Print a bit of information as the exception travels out, e.g.:

  # when dumping rt links
  Error decoding 'flags' from 'linkinfo-ip6tnl-attrs'
  Error decoding 'data' from 'linkinfo-attrs'
  Error decoding 'linkinfo' from 'link-attrs'
  Traceback (most recent call last):
    File "/home/kicinski/linux/./tools/net/ynl/cli.py", line 119, in <module>
      main()
    File "/home/kicinski/linux/./tools/net/ynl/cli.py", line 100, in main
      reply = ynl.dump(args.dump, attrs)
    File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 1064, in dump
      return self._op(method, vals, dump=True)
    File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 1058, in _op
      return self._ops(ops)[0]
    File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 1045, in _ops
      rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
    File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 738, in _decode
      subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'], search_attrs)
    File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 763, in _decode
      decoded = self._decode_sub_msg(attr, attr_spec, search_attrs)
    File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 714, in _decode_sub_msg
      subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
    File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 749, in _decode
      decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
    File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 147, in as_scalar
      return format.unpack(self.raw)[0]
  struct.error: unpack requires a buffer of 2 bytes

The Traceback is what we would previously see, the "Error..."
messages are new. We print a message per level (in the stack
order). Printing single combined message gets tricky quickly
given sub-messages etc.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 72 +++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index eea29359a899..08f8bf89cfc2 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -733,41 +733,45 @@ genl_family_name_to_id = None
                 self._rsp_add(rsp, attr_name, None, self._decode_unknown(attr))
                 continue
 
-            if attr_spec["type"] == 'nest':
-                subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'], search_attrs)
-                decoded = subdict
-            elif attr_spec["type"] == 'string':
-                decoded = attr.as_strz()
-            elif attr_spec["type"] == 'binary':
-                decoded = self._decode_binary(attr, attr_spec)
-            elif attr_spec["type"] == 'flag':
-                decoded = True
-            elif attr_spec.is_auto_scalar:
-                decoded = attr.as_auto_scalar(attr_spec['type'], attr_spec.byte_order)
-            elif attr_spec["type"] in NlAttr.type_formats:
-                decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
-                if 'enum' in attr_spec:
-                    decoded = self._decode_enum(decoded, attr_spec)
-                elif attr_spec.display_hint:
-                    decoded = self._formatted_string(decoded, attr_spec.display_hint)
-            elif attr_spec["type"] == 'indexed-array':
-                decoded = self._decode_array_attr(attr, attr_spec)
-            elif attr_spec["type"] == 'bitfield32':
-                value, selector = struct.unpack("II", attr.raw)
-                if 'enum' in attr_spec:
-                    value = self._decode_enum(value, attr_spec)
-                    selector = self._decode_enum(selector, attr_spec)
-                decoded = {"value": value, "selector": selector}
-            elif attr_spec["type"] == 'sub-message':
-                decoded = self._decode_sub_msg(attr, attr_spec, search_attrs)
-            elif attr_spec["type"] == 'nest-type-value':
-                decoded = self._decode_nest_type_value(attr, attr_spec)
-            else:
-                if not self.process_unknown:
-                    raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
-                decoded = self._decode_unknown(attr)
+            try:
+                if attr_spec["type"] == 'nest':
+                    subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'], search_attrs)
+                    decoded = subdict
+                elif attr_spec["type"] == 'string':
+                    decoded = attr.as_strz()
+                elif attr_spec["type"] == 'binary':
+                    decoded = self._decode_binary(attr, attr_spec)
+                elif attr_spec["type"] == 'flag':
+                    decoded = True
+                elif attr_spec.is_auto_scalar:
+                    decoded = attr.as_auto_scalar(attr_spec['type'], attr_spec.byte_order)
+                elif attr_spec["type"] in NlAttr.type_formats:
+                    decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
+                    if 'enum' in attr_spec:
+                        decoded = self._decode_enum(decoded, attr_spec)
+                    elif attr_spec.display_hint:
+                        decoded = self._formatted_string(decoded, attr_spec.display_hint)
+                elif attr_spec["type"] == 'indexed-array':
+                    decoded = self._decode_array_attr(attr, attr_spec)
+                elif attr_spec["type"] == 'bitfield32':
+                    value, selector = struct.unpack("II", attr.raw)
+                    if 'enum' in attr_spec:
+                        value = self._decode_enum(value, attr_spec)
+                        selector = self._decode_enum(selector, attr_spec)
+                    decoded = {"value": value, "selector": selector}
+                elif attr_spec["type"] == 'sub-message':
+                    decoded = self._decode_sub_msg(attr, attr_spec, search_attrs)
+                elif attr_spec["type"] == 'nest-type-value':
+                    decoded = self._decode_nest_type_value(attr, attr_spec)
+                else:
+                    if not self.process_unknown:
+                        raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
+                    decoded = self._decode_unknown(attr)
 
-            self._rsp_add(rsp, attr_spec["name"], attr_spec.is_multi, decoded)
+                self._rsp_add(rsp, attr_spec["name"], attr_spec.is_multi, decoded)
+            except:
+                print(f"Error decoding '{attr_spec.name}' from '{space}'")
+                raise
 
         return rsp
 
-- 
2.47.1


