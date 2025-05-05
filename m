Return-Path: <netdev+bounces-187726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C373AA9246
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 13:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570D73A76D4
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A3205513;
	Mon,  5 May 2025 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xN+rPHfp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CCD49659
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445524; cv=none; b=Ax4pEN184/jsOKid3Xrkh4xljSR6ker+vqP+9H8R+EVBdev4D7P3ysNTpIbjO1O9oEVxLok+2WJPiq+xzgck24TeIfeAieG0OVSNO5FLa75/wrqs2qtfybFXLV6vCLgBkRYwAyGq8YPGloy3va5qNslJdqdMowQ1Y/zR/PvECZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445524; c=relaxed/simple;
	bh=+xrFH+959Wfjay5dJUOvaqmEVhTD8UmyUNF8VwdpN74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghQse+NkZH2DswFzL5aSeBi03ha73iCXYR8a1rTd8MKfVYt3/K7jMGMKwDQlSrDBHE2K/1f9+/YHRzJDaaQfO3Ll63WQ+pLKHf7FWe11y7jtZw6C9vPrnS2jEN8MzNY0gz4sGdYzrALxmcJ26Dq4t7IeeCNu7JM/jY/DBDfYTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xN+rPHfp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so39700845e9.2
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746445517; x=1747050317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR+iaBeipVE5H/6NIskEDd2663MYaiZaMs1eRdyeff8=;
        b=xN+rPHfpn8UpA/BHgPUx94pbqQLJcczvROnuHXo48cn/hPTDTrtoci17I08UCYaHBs
         0YLBKOy2RYtbkSiRqtqhLp4u/YjoBG7AqCJqaZVahUbVsaGtCEpNPZF8mFOsWdbRsPcR
         0+y4auVLH+vi0CnueldDJ73pZMG+6e3PYIPAAPE4AoPI05tparEW/cZB5WFIh4vVmqiX
         ci058iGfQr/7PV9QDOLiiIbJ93iK1DM3NIpUbI/76y6x0CQ36eBNE81O8FyN4XNSJV1j
         f/0LYUSEOLItrWBmNSObxWwWlakQt06Y6RUTTJi7gZeqRVANjcUMu6+s8HOeXEtJz2tG
         VHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746445517; x=1747050317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GR+iaBeipVE5H/6NIskEDd2663MYaiZaMs1eRdyeff8=;
        b=pAiG97Gl9Le5sUsw5MU8+nKw87GkzLCCWuhVCA2g0YX0fcNWGpHc7uupAo0rzEHtZt
         n2tMM8NlYoeYiMuyMq6lsG/0j5O+CW/7B2tMVljy8kH+MeZC0XmwnLTrdqaOsJhYdc3d
         mnxpNMPuFY6hR55LlXRaLzRtBktxZvj5mw8reRxz++4/E32hB/oFnX5T+dXkd5jLR4E1
         iudrgTzbDcE73hsqCYTK59XI0zAHP6qFdgRBkvn9k7vppSGyYjatN2gBGlda2+/1Bw3x
         pabfcCZz0el7/CfFXhVx+5rHKmhK0k288PSXZPZgmejgKYUnDYkY00H9wvbCibh5j61U
         oDSA==
X-Gm-Message-State: AOJu0Yzg6wGyZszuDAb2snfALsHdfhVrPiG97jWPV8KrL5FnZQrEkDdZ
	YNtkyf6pM0TfoSuHHvfiXQHCMED9LTVzabhP6wDQTLx2UvE2mG47sVJVeO0OJ3VI+lolUftY+kV
	Q
X-Gm-Gg: ASbGncsls1tUL/+1dhiwkUd9O/KKjLFvh+a3W0lsw5bA5uM2GCy55O9Q/lMG+cXFOPC
	nIJkUmhtXC7vfFTXNVTBu00Q+1AoSfKsoeRtC/8dncp8qJqo8aBeQYqpq+541mLu2QLfZFISY2b
	bUHHT+lYgdSyg1VWzsFx0NUeGBkspF9k561yeVzG0ULFuGryvrp45RLk8CR2SkSBfgbbaWCK8Pr
	S/53RvPF+XDQQfmAkN8DtpGIBvkMmPGwfiDv+8cESZedkkN2w6X1kMQe/HVecrF9W3HpQEoaFeB
	tkMIDs9yglDOCuu0lWpMhv7r7OK9CHK4Zq3k6htc0P9hMwdh+j9CQV0eHQ==
X-Google-Smtp-Source: AGHT+IHKyrA430oxeFQPY6G1IdgVGDKk9PFzXFngHNVbfTVR6x+bbr8NJM9SIrD78FbloI8+4zpDDw==
X-Received: by 2002:a05:600c:a405:b0:43e:ee80:c233 with SMTP id 5b1f17b1804b1-441c83cd1dcmr28656195e9.32.1746445516723;
        Mon, 05 May 2025 04:45:16 -0700 (PDT)
Received: from localhost (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae32fesm10010673f8f.22.2025.05.05.04.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 04:45:16 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next v2 1/4] tools: ynl-gen: allow noncontiguous enums
Date: Mon,  5 May 2025 13:45:10 +0200
Message-ID: <20250505114513.53370-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505114513.53370-1-jiri@resnulli.us>
References: <20250505114513.53370-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

in case the enum has holes, instead of hard stop, generate a validation
callback to check valid enum values.

signed-off-by: jiri pirko <jiri@nvidia.com>
---
v1->v2:
- fixed min/max none check
- changed switch-case to fall-through with single return statement
- removed not needed special indentation treating
saeed's v3->v1:
- added validation callback generation
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 58 ++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 09b87c9a6908..acba03bbe67d 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -389,11 +389,14 @@ class TypeScalar(Type):
         if 'enum' in self.attr:
             enum = self.family.consts[self.attr['enum']]
             low, high = enum.value_range()
-            if 'min' not in self.checks:
-                if low != 0 or self.type[0] == 's':
-                    self.checks['min'] = low
-            if 'max' not in self.checks:
-                self.checks['max'] = high
+            if low == None and high == None:
+                self.checks['sparse'] = True
+            else:
+                if 'min' not in self.checks:
+                    if low != 0 or self.type[0] == 's':
+                        self.checks['min'] = low
+                if 'max' not in self.checks:
+                    self.checks['max'] = high
 
         if 'min' in self.checks and 'max' in self.checks:
             if self.get_limit('min') > self.get_limit('max'):
@@ -425,6 +428,8 @@ class TypeScalar(Type):
             return f"NLA_POLICY_MIN({policy}, {self.get_limit_str('min')})"
         elif 'max' in self.checks:
             return f"NLA_POLICY_MAX({policy}, {self.get_limit_str('max')})"
+        elif 'sparse' in self.checks:
+            return f"NLA_POLICY_VALIDATE_FN({policy}, &{c_lower(self.enum_name)}_validate)"
         return super()._attr_policy(policy)
 
     def _attr_typol(self):
@@ -930,7 +935,7 @@ class EnumSet(SpecEnumSet):
         high = max([x.value for x in self.entries.values()])
 
         if high - low + 1 != len(self.entries):
-            raise Exception("Can't get value range for a noncontiguous enum")
+            return None, None
 
         return low, high
 
@@ -2426,6 +2431,46 @@ def print_kernel_policy_ranges(family, cw):
             cw.nl()
 
 
+def print_kernel_policy_sparse_enum_validates(family, cw):
+    first = True
+    for _, attr_set in family.attr_sets.items():
+        if attr_set.subset_of:
+            continue
+
+        for _, attr in attr_set.items():
+            if not attr.request:
+                continue
+            if not attr.enum_name:
+                continue
+            if 'sparse' not in attr.checks:
+                continue
+
+            if first:
+                cw.p('/* Sparse enums validation callbacks */')
+                first = False
+
+            sign = '' if attr.type[0] == 'u' else '_signed'
+            suffix = 'ULL' if attr.type[0] == 'u' else 'LL'
+            cw.write_func_prot('static int', f'{c_lower(attr.enum_name)}_validate',
+                               ['const struct nlattr *attr', 'struct netlink_ext_ack *extack'])
+            cw.block_start()
+            cw.block_start(line=f'switch (nla_get_{attr["type"]}(attr))')
+            enum = family.consts[attr['enum']]
+            first_entry = True
+            for entry in enum.entries.values():
+                if first_entry:
+                    first_entry = False
+                else:
+                    cw.p('fallthrough;')
+                cw.p(f'case {entry.c_name}:')
+            cw.p('return 0;')
+            cw.block_end()
+            cw.p('NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");')
+            cw.p('return -EINVAL;')
+            cw.block_end()
+            cw.nl()
+
+
 def print_kernel_op_table_fwd(family, cw, terminate):
     exported = not kernel_can_gen_family_struct(family)
 
@@ -3097,6 +3142,7 @@ def main():
             print_kernel_family_struct_hdr(parsed, cw)
         else:
             print_kernel_policy_ranges(parsed, cw)
+            print_kernel_policy_sparse_enum_validates(parsed, cw)
 
             for _, struct in sorted(parsed.pure_nested_structs.items()):
                 if struct.request:
-- 
2.49.0


