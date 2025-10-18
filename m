Return-Path: <netdev+bounces-230680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB65BED26C
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 17:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A4C64E92B1
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F21922A4EB;
	Sat, 18 Oct 2025 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NbOvrSpT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3332225779
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800688; cv=none; b=FiAJEMKahtNxFQ29Aan9c1IHn0CxzdiQfvydUp5yTvNK99RvLXBCHEYFCITQjvCzsGVCGdGa32B953PxZ9ZUm53Rp2kubNaiE/aNt5Qe9P/cxEJgUGjqGz5B6f8+goZ10KaKDhDI81oA5N84UaCjHhwZZXRAyVRaprRgJjoqnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800688; c=relaxed/simple;
	bh=uPnH5ewj9MAoqq1yVrco8LvFEZu5ocqvEtDb1ZRbnWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In6cbkldjx0Wprshiadrm6WfhKKFkflfJRyczLCef7coDn+lS51EpQBupRlxyvHa4emo/yJ1mNE+HH+PHVcLjyxFXBLAd/yXD6cTzebr5WMRPhqepJlMFO+BzjsFHtRdddRcJ4BPtHT85egjCue/sB/VUk/kq7R/x1KGMtF7TOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NbOvrSpT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e9d633b78so702775666b.1
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760800684; x=1761405484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ziuauqYm5nAIFZTrsIsUXlvSa4YCy2hrgmDn3UImNQ=;
        b=NbOvrSpT5b6SMtAxSgF/eT61MVylZoRTA9IQdmsIu8/HWXUKDu9UGhMSq87BN5feG5
         PSBVs7dCEOkh3vybsvPXniZmlklB8EHlcxjaO+v3MoHDlwVYI/s00Rogg/ln/qDAv068
         iqRMOszYKYYFpYGBjN3xtjT08mSMxQXTWjLbWFGA8YJejxXn9a5iY6KHy9HTMugG3Vhp
         wdxeR7SjALhGPmRzck4morX9LkUEVOe/nPqjEvS1ZmF7Hkpe6KxDWds3EnuZdqN349I0
         jF0oYIWwF3jzaZThgqrhXICzPXP0aVXTgzTGgteYJZjl7AnNsBiKnPQPZECa6/Qau3Wz
         0Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760800684; x=1761405484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ziuauqYm5nAIFZTrsIsUXlvSa4YCy2hrgmDn3UImNQ=;
        b=lBKBuS8gpL0MlnIFVxo9HTgULcXT3DIdYU7SvxYERfPcD4vw38R/V7E1jpPBPkOt6t
         uxaDKnJvSH2LGqhkgDSObgNso4j+5KNvg22UG4ffNeHobw3F5hHYrh4ukQOQZ5EI2UrU
         2V91qoh/ufeOaXmmQ+sH6wjMHJaTKhSsPcKyZgIk+PQi115G7pvZabxjSA7QZokfGRya
         G0hiZR6/5RY7LxeLEPxCmmlnIZLu96QugHGDL6IwYY8MCF/GizreIkxkXkjEsOF7gdgw
         9fpzPeYaSLiYzlojq/6Hj9w/HDFSkluB/A0gH78BZI2Y/U1bOFxZ/e2zpXFGhtu5QGx4
         8PcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy8skefnO8D+DuZiuszgKZ6pFlgQOPCbFmH4AuJVQvubZK+5eka9lRlSApY2xu8W9puW2gI3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YypG0/Mr8aXbvcKLMjDmlTfXxzrfUZAYA0BLxEYEHfI2pJT3TNm
	+lXSH0C9x9VWhbwZd6eHTwatWGReoWypOjRT/vZGuZS5/p8LZORXwXjp
X-Gm-Gg: ASbGnct14Q7L4uuWFyodxvAHKIp7WZ77ssc/kEeVEtgj73D6STuADHjwXzwJefyjEW0
	0RRkUd+LGDp+858JP3Cvq5vHUaTjbK3sawPPDIykRD/veUnMXI1PZxklog5d3hKmPLMgSlUdsiR
	twCr4xV6fymzWQmj8A56HebEfFYMbPXlo3w65sqdIxTFRhakk3WPf+RqxQXq+fJrpwLajUb6qdZ
	9Pp/ieprEKVGDNd3QgSe243mgNft2wO66uT61amH4gcQxUw4lekLhe9+y57gVuso5/o8mgebHoD
	c/lQCdGVSkMglKk2bMETTUsgjgFhzxtfMvKSQKBoJqMIr84Bq+rZoC6ka8ERgnoGPt1pxh4RY88
	jOiM9hcT/Iel7MUb1tmIOqchfvPEp5mUOK8vX/fPHYeUDOWf2Oe2plx/Z7Uq+TdN3YgXT/g5PIQ
	jYVZj3C5TKCbqZ64+Su3rNfMXi/PMXCy88jpYTQtURsDT7c0VagNM0hrfSy3QY8aeSVk052ddth
	Q==
X-Google-Smtp-Source: AGHT+IG9vq0qMlQ90uZLTJ+7i+vyez08khY42hQiH9++p1pjab0KxXKoIzUX4plMAY7ETu5kWV6yhg==
X-Received: by 2002:a17:907:894f:b0:b33:821f:156e with SMTP id a640c23a62f3a-b605249e3b3mr1287934366b.12.1760800683677;
        Sat, 18 Oct 2025 08:18:03 -0700 (PDT)
Received: from tycho (p200300c1c7311b00ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c731:1b00:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm259983366b.54.2025.10.18.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:18:03 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH 3/4] tools: ynl: call nested attribute free function for indexed arrays
Date: Sat, 18 Oct 2025 17:17:36 +0200
Message-ID: <20251018151737.365485-4-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018151737.365485-1-zahari.doychev@linux.com>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
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


