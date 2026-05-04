Return-Path: <netdev+bounces-283758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDzEB5th+GlJtgIAu9opvQ
	(envelope-from <netdev+bounces-283758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:06:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A8A4BAC04
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51F2F302D5E1
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C4D35AC04;
	Mon,  4 May 2026 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuIhZL48"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F4355F4E
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885512; cv=none; b=ghDbK50rwILo1B0TfOv1z1qFQhAuGSNaKPfKc5pHpFlyIg1dlwD0ZRtn9upSK4fyyUkSl/9alFByjmcrkCE8hr/dBuqucsOhQM/SU+8KYu/Nk2k0f09eGEIVOCKY3u2E3sArtKlIX9y2NijROH813mNOBRv8cowIUD7S3PxsAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885512; c=relaxed/simple;
	bh=1S5dJfUyYQg5FGS0pNOidUwpCbERfnNKxzgJNlBKE/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m0bhkD+XHeOdP6Z2cxcOFc9Vjzu5jjPgPW+V7eDpkBEQsN9JDrDij+nnRqPzLIfLivksu/Qp5WsqOwVTL4Q6egOyRyv1dPQuddGUFcz9HhovEWQrgUwo4md2wKj6sLPAKD4SFNoopLcRKT0LiqV+QdEJVLKVNSu4Y955S7KBtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuIhZL48; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-44f1b4d0fb0so196196f8f.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777885509; x=1778490309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv8M0pobvUQaNrtbaUGlGWjxtYtpJJO/kHh47aIpTxM=;
        b=nuIhZL48M287glH8oqWbxp8Yv4Ee1UQ2iY7CC+SUKBTYv6YdgNycfQMKTMbmpG//BR
         4Doc3eje02zIGjpfkoR0nGZK4den3vp92qwtNrReaO35rfb8KODm+EVF878TwENwXXrV
         c6M1WZMa9nlCIeq23AOjr4BfaTLgrXCqczrndxXWb7zDAsmIVOAI5s4KBdqAn5Tp2A9O
         alopnJms8tTErwGY7yU1UpnB3vvz4H9ilDyXzf+mY+RVQWlZFCsw/u1z2jB/SdwBpXLX
         5W3eDvm6u4F+RLLTv2MTqli4/BU1r1RwEg74C3NBALtq5S+oZKhhTlh9KVBH1FFNNGMh
         BtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885509; x=1778490309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv8M0pobvUQaNrtbaUGlGWjxtYtpJJO/kHh47aIpTxM=;
        b=KM7f8AX+LU+25vU9tLDOoAMM/Y4Noy8ffl7TvOZc/JVBVTDQnqs5kh7tKOwlymfrdp
         Deqg4oBfj/+bqspO8kaQyx83cnK4OFyzXQ/B7RrstgQlRcFrqs5NYn+EWLVlQaK9TaG8
         nRZGtemuHaGUbCRIZTIlA9xZziH4iDEuDMSAmgdiLh+GJhWyH9BNtMN8yTLNYDk54WYa
         qzcgMOMvvFzHvtoNGOGjrDvbGt7RhwB2XHSkVnEU0XdP5/xEWrft1giwnffGh+ncgHPP
         LmScNWgWnZUOLMMl/ZxzGyAQxF6tUx1KbH2F7nv+2zNzF72vscdJn4thfQy9WcBEI4cu
         gMFg==
X-Forwarded-Encrypted: i=1; AFNElJ+t1M1D9WWG9j2wuZHzR2iupx0vR7K8eJdUGceQgaYEm5n8NAhbn9fEF5CgVcuj/WfzGllxgXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7EWGKv4uYtSkcegfNNlceb8GbH6aLwuAT3imB8UHN9EooYt4
	PrCTWJ6jk8CJugWLZPDHe+Mtgefko+PZrxZ8jm50HRY1CfmmjlL8L/+4hZTuNKmrDLW0g8hfB+T
	l3/ZEhlANr8MOsl+7PA==
X-Received: from wmdn1.prod.google.com ([2002:a05:600c:2941:b0:488:890d:75d7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c089:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48a98676a8fmr117917645e9.28.1777885509261;
 Mon, 04 May 2026 02:05:09 -0700 (PDT)
Date: Mon, 04 May 2026 09:04:55 +0000
In-Reply-To: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7880; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=1S5dJfUyYQg5FGS0pNOidUwpCbERfnNKxzgJNlBKE/0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp+GFAAPLFLzqtCpP86GYCDu+7ToXARljhdNPj8
 KQu6ewaxriJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafhhQAAKCRAEWL7uWMY5
 RsyvD/9kn34McFuAkRYhAZhMD68+cF2W+FqMGBON2dgQbossmGSlTAiCf+SmdwRTQ0ioGP2dRIA
 xC604C9nUO1b35pQ3t7WXI5dCfP6iw2SiBN+t7CgLb8Tilp7xzoZ4bFRkjy2K4wEhWZVRefpk/j
 Xgm9zn3mX5J0pM/pyeuSsg7gILQO9E1xLJVGEkiGGAnKLwiqk+2nVu+E65o0vq5D+SivyZmQbeL
 P6xqRaKl21Afh45W6ran2RlVeSX4yxeLwCdP0aPO+n5rpIcA24z9NQ6o+28oc3F+ueAoOVoKC0O
 23StIOEAeI0IDKXM5Q+2KVIec6jJlRqdlAs0+Qra32D9rBHUIs2aCheCXZXyUDTkq+aqjgbqO3y
 VLcMQYSX2NnFXLJ/JS7jYB3kFKCnVX+YQgMxNrIzVCMNB1DWvizLhljdPW8qt/uWp4skAgyz4zX
 oA8w0lIHYk2e4C5snrn3A1dVLsOrpWD4xgMhZVU3Qy3UHetWD/p8djQ9N1hz/bXTUXFfIA9ild9
 UUDAcd/pfUhOUwkyKDcjTJYGt0hFY883JvCC6nPL9rKqVVVE9Nfo6uhmpEd2XkeBS84WyoZC6pr
 aNs3tlZFQ7EmIvJl4qhuIsrgkAoB1SvsLeIP7zRDEEdVxTusd/i9QAWdHvPsJ82WHRnEu9YYSCX rMcCdSmpaQsCbpg==
X-Mailer: b4 0.14.3
Message-ID: <20260504-binder-netlink-v4-2-601b41cd25b2@google.com>
Subject: [PATCH v4 2/4] ynl_gen: generate Rust files from yaml files
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 70A8A4BAC04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283758-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,linuxfoundation.org,lunn.ch,gmail.com,kernel.org,davemloft.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,google.com];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

To generate netlink frames from Rust code easily, generate Rust
libraries with methods for generating different netlink messages as
appropriate.

The new 'rust' type corresponds to a Rust version of the C target
'kernel'. There is no Rust version of the 'uapi' target since Rust code
exports its uapi via C headers - choice of language is opaque to
userspace.

This logic is kept in the existing ynl_gen_c.py file to reuse CodeWriter
and other shared pieces of logic in the existing python file. This has
the disadvantage that the gen_c part of the name is now wrong, as it
also generates Rust. One possible solution to this could be to rename
the file.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 139 ++++++++++++++++++++++++++++++++++++++-
 tools/net/ynl/ynl-regen.sh       |   2 +-
 2 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 0e1e486c1185..76b8b2f1ac16 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -19,6 +19,7 @@ import pathlib
 import os
 import re
 import shutil
+import subprocess
 import sys
 import tempfile
 import yaml as pyyaml
@@ -1744,6 +1745,19 @@ class CodeWriter:
         else:
             self.p('}' + line)
 
+    def array_start(self, line=''):
+        if line:
+            line = line + ' '
+        self.p(line + '[')
+        self._ind += 1
+
+    def array_end(self, line=''):
+        if line and line[0] not in {';', ','}:
+            line = ' ' + line
+        self._ind -= 1
+        self._nl = False
+        self.p(']' + line)
+
     def write_doc_line(self, doc, indent=True):
         words = doc.split()
         line = ' *'
@@ -3415,10 +3429,126 @@ def find_kernel_root(full_path):
             return full_path, sub_path[:-1]
 
 
+def render_rust(family, cw):
+    cw.p('#![allow(unreachable_pub, clippy::wrong_self_convention)]')
+    cw.p('use kernel::netlink::{Family, MulticastGroup};')
+    cw.p('use kernel::prelude::*;')
+    cw.nl()
+
+    family_upper = c_upper(family.ident_name)
+    family_name = f'{family_upper}_NL_FAMILY'
+    mcgrps_name = f'{family_name}_MCGRPS'
+
+    cw.p(f'pub static {family_name}: Family = Family::const_new(')
+    cw._ind += 1
+    cw.p('&crate::THIS_MODULE,')
+    cw.p(f'kernel::uapi::{family.fam_key},')
+    cw.p(f'kernel::uapi::{family.ver_key},')
+    if family.mcgrps['list']:
+        cw.p(f'&{mcgrps_name},')
+    else:
+        cw.p('&[],')
+    cw._ind -= 1
+    cw.p(');')
+    cw.nl()
+
+    if family.mcgrps['list']:
+        cw.array_start(f'static {mcgrps_name}: [MulticastGroup; {len(family.mcgrps["list"])}] = ')
+        for grp in family.mcgrps['list']:
+            cw.p(f'MulticastGroup::const_new(c"{grp["name"]}"),')
+        cw.array_end(';')
+        cw.nl()
+
+    for idx, (op_name, op) in enumerate(item for item in family.msgs.items() if 'event' in item[1]):
+        struct_name = op_name.capitalize()
+
+        if 'doc' in op:
+            doc_lines = op['doc'].strip().split('\n')
+            for line in doc_lines:
+                cw.p(f'/// {line.strip()}')
+
+        cw.block_start(f'pub struct {struct_name}')
+        cw.p('skb: kernel::netlink::GenlMsg,')
+        cw.block_end()
+        cw.nl()
+
+        cw.block_start(f'impl {struct_name}')
+        cw.p('/// Create a new multicast message.')
+        cw.p('pub fn new(')
+        cw._ind += 1
+        cw.p('size: usize,')
+        cw.p('portid: u32,')
+        cw.p('seq: u32,')
+        cw.p('flags: kernel::alloc::Flags,')
+        cw._ind -= 1
+        cw.block_start(') -> Result<Self, kernel::alloc::AllocError>')
+        cw.p(f'const {op.enum_name}: u8 = kernel::uapi::{op.enum_name} as u8;')
+        cw.p('let skb = kernel::netlink::NetlinkSkBuff::new(size, flags)?;')
+        cw.p(f'let skb = skb.genlmsg_put(portid, seq, &{family_name}, {op.enum_name})?;')
+        cw.p('Ok(Self { skb })')
+        cw.block_end()
+        cw.nl()
+
+        grp_idx = 0
+        if 'mcgrp' in op:
+            grp_idx = next(i for i, grp in enumerate(family.mcgrps['list']) if grp['name'] == op['mcgrp'])
+
+        cw.p('/// Broadcast this message.')
+        cw.block_start('pub fn multicast(self, portid: u32, flags: kernel::alloc::Flags) -> Result')
+        cw.p(f'self.skb.multicast(&{family_name}, portid, {grp_idx}, flags)')
+        cw.block_end()
+        cw.nl()
+
+        cw.p('/// Check if this message type has listeners.')
+        cw.block_start('pub fn has_listeners() -> bool')
+        cw.p(f'{family_name}.has_listeners({grp_idx})')
+        cw.block_end()
+
+        attr_set_name = op['attribute-set']
+        attr_set = family.attr_sets[attr_set_name]
+        event_attrs = op['event']['attributes']
+
+        for attr_name in event_attrs:
+            attr = attr_set[attr_name]
+            method_name = attr_name.replace('-', '_')
+
+            if attr.type == 'u32':
+                put_fn = 'put_u32'
+                arg_str = ', val'
+                method_args = '(&mut self, val: u32)'
+            elif attr.type == 'string':
+                put_fn = 'put_string'
+                arg_str = ', val'
+                method_args = '(&mut self, val: &CStr)'
+            elif attr.type == 'flag':
+                put_fn = 'put_flag'
+                arg_str = ''
+                method_args = '(&mut self)'
+            else:
+                put_fn = f'put_{attr.type}'
+                arg_str = ', val'
+                method_args = f'(&mut self, val: {attr.type})'
+
+            cw.nl()
+            if 'doc' in attr.yaml:
+                doc_lines = attr.yaml['doc'].strip().split('\n')
+                for line in doc_lines:
+                    cw.p(f'/// {line.strip()}')
+
+            cw.block_start(f'pub fn {method_name}{method_args} -> Result')
+            cw.p(f'const {attr.enum_name}: c_int = kernel::uapi::{attr.enum_name} as c_int;')
+            cw.p(f'self.skb.{put_fn}({attr.enum_name}{arg_str})')
+            cw.block_end()
+
+        cw.block_end()
+        cw.nl()
+    cw.p(' ')
+
+
 def main():
     parser = argparse.ArgumentParser(description='Netlink simple parsing generator')
     parser.add_argument('--mode', dest='mode', type=str, required=True,
-                        choices=('user', 'kernel', 'uapi'))
+                        choices=('user', 'kernel', 'uapi', 'rust'))
     parser.add_argument('--spec', dest='spec', type=str, required=True)
     parser.add_argument('--header', dest='header', action='store_true', default=None)
     parser.add_argument('--source', dest='header', action='store_false')
@@ -3471,6 +3601,13 @@ def main():
         render_uapi(parsed, cw)
         return
 
+    if args.mode == 'rust':
+        render_rust(parsed, cw)
+        cw.close_out_file()
+        if args.out_file:
+            subprocess.run(['rustfmt', '--edition', '2021', args.out_file])
+        return
+
     hdr_prot = f"_LINUX_{parsed.c_name.upper()}_GEN_H"
     if args.header:
         cw.p('#ifndef ' + hdr_prot)
diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index d9809276db98..4f5ceb4fe147 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -17,7 +17,7 @@ done
 KDIR=$(dirname $(dirname $(dirname $(dirname $(realpath $0)))))
 pushd ${search:-$KDIR} >>/dev/null
 
-files=$(git grep --files-with-matches '^/\* YNL-GEN \(kernel\|uapi\|user\)')
+files=$(git grep --files-with-matches '^/\* YNL-GEN \(kernel\|uapi\|user\|rust\)')
 for f in $files; do
     # params:     0       1      2     3
     #         $YAML YNL-GEN kernel $mode

-- 
2.54.0.545.g6539524ca2-goog


