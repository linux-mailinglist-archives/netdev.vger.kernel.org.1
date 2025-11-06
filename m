Return-Path: <netdev+bounces-236420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF806C3C03F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3EE56022F
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AE1221710;
	Thu,  6 Nov 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TQZ0WxLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE121C173
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442139; cv=none; b=oGePzItFJDhR823IkFwAnsDkgkg22FkVkvcFrqziQisN0Dq4HJRv7zSLKtR7KTOMJIg8l1Aaz3I+I1IKG5i9C1AUjwndZUYDqJmzpP432PuC1YPfiVfZVQdRbTcvKfW3bZFRHy5haMkwVY0DqZTLoWPJK4Qjs+S5qV2pZ5IIXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442139; c=relaxed/simple;
	bh=5gLqMz0lPgkfPLQQ/F4jq+XLqtILltmBvM17GbBPgzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N14aCLgYaDnswmvjW1BaesGJxfrCSojFWU3r4zoXycR/1aT2OhvZ6aH3Xtz+nZuIJqLYLUrsrDtuQOhJtHfmmDtLfyaF2/WGaDsx8vGqEl5YQVT68bEH4qUHpCQBlGTsG7k6p9n7V2rXKr4fwoWAF6h8aWEiepKkE7BxrAxzCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TQZ0WxLC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b70fb7b54cdso199218866b.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762442136; x=1763046936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYAyBVOESoWd8OHjmQvuZq8dZaRqZvwpafTiZsvJAh8=;
        b=TQZ0WxLCjpe2ompXRnQL75QvxIQs8wOqNALE2qZx/RD2o+TX4n+THBX2iXfTV1+Ayk
         oyYGY3/4K2LQb9DDIY5ci7iRZYgo1eyrzB8xIDeWm+xp6k6yW3pCZhvfEHK1iDr6Q83n
         ga3rq0SLogTOeSXhYWOsCGX1OtDFhaCuZARuYAsvADmi97NUyZ/+fju++nudY2qm3Hqm
         nnZQnO9dq/qvNf2DLWgqOQV4zYpnOXn3yPzKVTv/3ZvC+8mp/oJJ6BwcGnzdkDAKeiNd
         MohwUauCVfPQkpCvsE3F4Zw3AEUlHFyGuHaY0LHxtnu3nY4lThs9D/Www//qrIsl1JFy
         pzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442136; x=1763046936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aYAyBVOESoWd8OHjmQvuZq8dZaRqZvwpafTiZsvJAh8=;
        b=njdW9IguxN2lBMD3K74QkhpjFTVidA+FyPXvudOMUoDdlra5ywAWXnyd4O+lHILsK4
         Tb6YVfiKbGfnAxPQf2ItY55Gf8JTYIh3Ngh7dXQnpiPk3/HCi+uZRPyjfYD0X45cpbQm
         REkAGdscMDKl2RIKmw9fnagYfvBwjgEhixESvjO9sr06SjnCEXVNOuxvVT1Y6oIDet/2
         CbeuUWPfBFHa8+IN2KhpLYJ5RstIsdsBn/pOe+KTamt/cyGl9iHOPNohpD86DzA7WDrZ
         ywlw+L62fWol2BravHYTjV5xEwzd37am2LCa4JSuS0RsdizB5oOzXb/sQv+2wq2iR2G6
         k7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWYT3t4aLdOwaq/vgJ2EVBEvlWlzGKf1SCb9qY34qiet8O0N8Ysc4WhIYe1vw5AUvwKJuq4gQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRW9vojf+9WIqqagcj/fUoO+TmZzmXaJef8xkQ5UgmFrmoHrk
	hHmxffWn8B1W9Rpa8Elve5aSsVbm33cqWaHYJHpHf5uuLH53BxuRfIr+
X-Gm-Gg: ASbGncvwHl7QD3mhaXUgnSqonvS+F7kLrh9eJrpC8k600bUnt8ZHri22uqohIGFDKjq
	MjiyImJgJ/77SCDfHIuK9eRKl7L40SdSEFqMovLFFn0jVCKQo/Qk1vQxnvNQKNe6nf3jAcM4JpX
	R/WeTxPXILt5fAOPh0wLtB3GRa3gcEqKcKunKaVAzoDCibgzLyo9PbJvgrxzKDq9GX3qmumzML5
	wpUuq4yJ2WT3MOWf/DUTpTdzG3Uswj2b0os+xSx7RRkPNl8awTH3afs4Bq691Q/x1FNMc6h4T3V
	N9Sip4nPy3IsTTHo1UcYrZQLop/5Mxxm0NL+0ihcuEtRGJOsUa1V/wuzo1YjEITkeRGIOYS5Uev
	rzd7HnHXz3HbpRUXdC7e1HSWuEXYZeKtyZ1CB81bFsz43pScTp2BfpeOL33vzggV3o4DWYobUmX
	FG0iqH/msaa2McdDXXzkw8zOhSK6otFYlXhG3weSgPgqXXROv2n90ESV3dFmngOoY=
X-Google-Smtp-Source: AGHT+IFdLQdSCe0SEDn2P3n3hKUsu0q1Zqx4DwqHazciYfq9y5Ynkm+bZPLJBwzijghGxVdtcYy0Aw==
X-Received: by 2002:a17:906:c103:b0:b3a:ecc1:7774 with SMTP id a640c23a62f3a-b72655f0963mr844729266b.53.1762442136218;
        Thu, 06 Nov 2025 07:15:36 -0800 (PST)
Received: from tycho (p200300c1c7266600ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c726:6600:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c6f95sm234012566b.64.2025.11.06.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:15:35 -0800 (PST)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH v2 2/3] tools: ynl: call nested attribute free function for indexed arrays
Date: Thu,  6 Nov 2025 16:15:28 +0100
Message-ID: <20251106151529.453026-3-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106151529.453026-1-zahari.doychev@linux.com>
References: <20251106151529.453026-1-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When freeing indexed arrays, the corresponding free function should
be called for each entry of the indexed array. For example, for
for 'struct tc_act_attrs' 'tc_act_attrs_free(...)' needs to be called
for each entry.

Previously, memory leaks were reported when enabling the ASAN
analyzer.

=================================================================
==874==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f221fd20cb5 in malloc ./debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55c98db048af in tc_act_attrs_set_options_vlan_parms ../generated/tc-user.h:2813
    #2 0x55c98db048af in main  ./linux/tools/net/ynl/samples/tc-filter-add.c:71

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f221fd20cb5 in malloc ./debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55c98db04a93 in tc_act_attrs_set_options_vlan_parms ../generated/tc-user.h:2813
    #2 0x55c98db04a93 in main ./linux/tools/net/ynl/samples/tc-filter-add.c:74

Direct leak of 10 byte(s) in 2 object(s) allocated from:
    #0 0x7f221fd20cb5 in malloc ./debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55c98db0527d in tc_act_attrs_set_kind ../generated/tc-user.h:1622

SUMMARY: AddressSanitizer: 58 byte(s) leaked in 4 allocation(s).

The following diff illustrates the changes introduced compared to the
previous version of the code.

 void tc_flower_attrs_free(struct tc_flower_attrs *obj)
 {
+	unsigned int i;
+
 	free(obj->indev);
+	for (i = 0; i < obj->_count.act; i++)
+		tc_act_attrs_free(&obj->act[i]);
 	free(obj->act);
 	free(obj->key_eth_dst);
 	free(obj->key_eth_dst_mask);

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 58086b101057..aadeb3abcad8 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -861,6 +861,18 @@ class TypeIndexedArray(Type):
         return [f"{member} = {self.c_name};",
                 f"{presence} = n_{self.c_name};"]
 
+    def free_needs_iter(self):
+        return self.sub_type == 'nest'
+
+    def _free_lines(self, ri, var, ref):
+        lines = []
+        if self.sub_type == 'nest':
+            lines += [
+                f"for (i = 0; i < {var}->{ref}_count.{self.c_name}; i++)",
+                f'{self.nested_render_name}_free(&{var}->{ref}{self.c_name}[i]);',
+            ]
+        lines += f"free({var}->{ref}{self.c_name});",
+        return lines
 
 class TypeNestTypeValue(Type):
     def _complex_member_type(self, ri):
-- 
2.51.0


