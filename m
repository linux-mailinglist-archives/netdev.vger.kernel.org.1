Return-Path: <netdev+bounces-278728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIn/GCJe32m5SAAAu9opvQ
	(envelope-from <netdev+bounces-278728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:45:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E18402C7C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B22430EE777
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663E33B95A;
	Wed, 15 Apr 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qeyt6jHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E733B6DB
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245978; cv=none; b=TSDQVP6uuAZGeKgaTldrS+PQMfutDyql2Ruv2REb9u9L3kgXL1HRrwCIl0kLVWsBdAAoe0vpckwgWCzaAzqUZlCVoLoL8Qaxp7E+/OqDn9iTeQ6R8IGiUvf50Q4LwJ2KMp0zqK+BpBLWAwVxfa5eHFMfd+8VSYPS12HfVYZkN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245978; c=relaxed/simple;
	bh=pYERZwVis0sfOfVf5rbB7rXtctv5TUqHOfYeJEFG54Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lr+B4MWEHDW7rhUumwtoaI3nKpc7C0WkNy8RIfgz8YGNV1mAeM4iRRQgHkSrGPeyVi+G7rk7jQa9VUNxOJdj7Q34KVrG7uWQMDakKOGSFwdGi/u76xHJw2Hvf+mDsheOC+WLyFvbhX7nnEIZy915PHYJJkAdGkZKEDFWqfulK5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qeyt6jHZ; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66f103b3141so4212939a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776245975; x=1776850775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tOHvc+UXkFcaiR1CPEBZRUJAR3W/AL9Q6jZjmIFzwd4=;
        b=qeyt6jHZOG2ZgGMqXaJbJ6LS2+jH5KwB558Btvv4nVXODm8pZhlv8ygd5pWgQUF5BE
         w2SY0Aay6WWhNu4qYdPegtj2QdiUPOLZbPYxLlF5XBZNYkoR+5zYp/fETlPHa+8wrTT6
         BUeSbh0RZrwlP8bsUhtBR0pHmRslU2ueEwbepNerb+LJ4mH32JqF7leSLsvq5v0gfJkQ
         c26K0W76jM1CUsdpzqIX+E1R99HL9IvwdMOKAa4XsRMCb73VyptZDqLb02IrAoT1SrFm
         FgUTcroYX6wdsriZKtmCoUvfO2pE6EyVFL19vglz0FnHVhVIhdDtuBZvdIZv3LbiFSuV
         pOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245975; x=1776850775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOHvc+UXkFcaiR1CPEBZRUJAR3W/AL9Q6jZjmIFzwd4=;
        b=osIcE2FwdnnkpFTj+nq1ACYM3anZsSnqQyca7waoInAmtvkctL40tlKuuWI+jD8LIE
         1FSobSTQXVHgtzb/JmCthdPd4a1H4Lune6QDqZMXilCFqa0A8fWcepCN03Ldsw5qtH9G
         qHYa3SW8W85MIVWxpvR5LL+zc4d74rzBu2IT9ayD8K6e23eDpTKJfWi06r8xVQXBB7Nj
         obxofXEFACD9OrE7U5s9zPSWWMjj6A7WenBRHSUTzityUP0MtyevBgMkHsmx10E6eNil
         YgFczJCRLnO9tQtr0B9i9tX0BO/6T9mbPZktAu29awQ8uABLlA61tRDitx5UJUSDhOUV
         oKKw==
X-Forwarded-Encrypted: i=1; AFNElJ9T8fEzcTUFB8OZHXkkq3p3o+jp3w38FKbitJB78GsSp4Ih0x69lQWTwKUV9wRe0mz8Xy0DYPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZc5cVArW951+u24u1l+RdrqHH/+DNZxdI6Gd5lmSK4Y0Bb8Sh
	UfwHGSSgVxDNe4AhIbxCf+82sUu5mmm4n9zlZRmc6TsgQqG73MvFDdp65ejJeI5YwA1xlFlyche
	2Sd16UliPfN2oeWyUIQ==
X-Received: from eddo19.prod.google.com ([2002:a05:6402:5613:b0:669:e76e:1fc1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4409:b0:66d:3ebe:3f18 with SMTP id 4fb4d7f45d1cf-6707a471cffmr10854613a12.25.1776245974941;
 Wed, 15 Apr 2026 02:39:34 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:37:52 +0000
In-Reply-To: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7884; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pYERZwVis0sfOfVf5rbB7rXtctv5TUqHOfYeJEFG54Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp31zOwI1Z/qaXVGkJIb+gdFwKml7bNTySwX69G
 2ICiC51d42JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCad9czgAKCRAEWL7uWMY5
 RiU7EACgpzsMvxPt41bivzL0Ky3Ir1wanoaWgKiUkEaTa9qcCksjaXn+nwG8UHENQNVUdmjxj0H
 2e+Nixx06lM/jaCHbn+i70GZIdbXOBvpMy88IiFUbhCBkmGnFwkdk2MVNTWxf0IvbIycPVI26EQ
 IVP7dtKeIQmWl2SdAXrNMW5SrG2hMCn3l8qWY6KFxmgY39JhK0QhDyspdiLfKbkAQqa3qzknZ5h
 x6WbRw2MeyFGMo+gkhnPB+yiE8FmqYoY8Aw4vtl4Ryy6r/UWVnKECilnbl8tSjJgT1VhtNJdEWF
 X2dVhEGRpBJWrY5CUT2L3pc/BO0tcekb7m0ubJy+2LUrelV7hxqpwCV7mY/5KiRGaeK8DLIFVOY
 lpnhgie+tdEhRkY3g5LE52t+0scgU2CGFcN82nVUqIK+8l6Rg3HXbbCwKkaPbGNuN7sehlkL/g2
 y8OK2mW9yJzqKQfgFXDeC2SVb0aaoCGRD2jqMCl3ZI4hyumbaTC1cDERa4XDl/SGBgchj0pnyUz
 +e4Y5eah6cbtZ+vZ3/0kexizpAaqwdWRH0NFA7St1gwz092UNWmHn7JXBM1BnATnsQvTmfe6ctp
 tKklg5CoO+DXV/wfX3IRDE7dj3ub2RuIzJynjsWY07mWe7a34rIzDKFaBOwlkWeUzzD3eNxADcf 2sGuJUCBT8rA6Iw==
X-Mailer: b4 0.14.3
Message-ID: <20260415-binder-netlink-v3-2-84be9ba63ee2@google.com>
Subject: [PATCH v3 2/4] ynl_gen: generate Rust files from yaml files
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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
	TAGGED_FROM(0.00)[bounces-278728-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ynl_gen_c.py:url]
X-Rspamd-Queue-Id: B9E18402C7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.54.0.rc0.605.g598a273b03-goog


