Return-Path: <netdev+bounces-236421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 526EDC3BFAD
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6EA2350C5A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AB421C173;
	Thu,  6 Nov 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="R3Mu1FR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970823E359
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442142; cv=none; b=gn7kq/gDsLbeY8ZNWSe7ZozCoTXkiE9WQx2ukqol+hRQrQc4vfBN5XiAonsZ2/3wVjU3sRUYVz6DJ77dVjlSXZpoZqyEV/LnJDUukCM2g15l2fl21yAmYslBhlH2lNW9w44ZW66nkpWDGXz6R03010nwztbAD5f0/j+4DAVm8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442142; c=relaxed/simple;
	bh=RA53KQxPWA5Nr1dOpX2ajFNIfdMy0AVQ6Ya7WBb8GSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T51PcFBE6zaqJBarNxNYgWzqwq0AyNomd4h0ywvcjY8U9N34zs5ziZNdmUcexV06AdSLv1sNn05r2yE/cQfnYPLdQzdlFJKsgMdSOvqkxcDMkGbO8GMIOIfQZsZ/Acg6vwW1jZPanhZzKHf//kTOOur/AsGOgdw0aN0W5EsOVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=R3Mu1FR7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so1325300a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 07:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762442139; x=1763046939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt5pFxvvoH0grmS+HdJ48McpDITycYmV3JJBkx2YrO0=;
        b=R3Mu1FR7pIISk4WZ5HGKVJxkqtefxaMGc74nUfbLSwzl9J1/U8hc6buF1yBJnIGgON
         BOWZ01wfzchB+KwsU0qMDr6vSAa4O7GNnabhVTfP4uCokQTVYcQyUVPJoN6N4I3uYCHx
         7XI9+NdaTA65WSpLSDWx/V5qFdjOquYm2a2byozKD537rYJMa5uYJ0tjtGiS1lRg3Xoy
         cAsZWmZln1RsyFlNPTSApZVCsHjuFhQUncdkkCV4dxU757dEb6hHPUftTIK3yjWd/c5A
         8uOTlKyAFjDnvg5f5Fs+ZxuaLIoxy5qyoxQeFLN6qaWMe2YDpSzJZS3jNHZUYhjpK0mW
         sOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442139; x=1763046939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qt5pFxvvoH0grmS+HdJ48McpDITycYmV3JJBkx2YrO0=;
        b=TungIlRyGAq2NDcHCn4QrkHNVypvJKWgW4Nmuy2nKjXuYo7RWs9CnNQih7cBMol/Rp
         o6yr0FXpDsG0RE/zjLQFCz22KImHgqu4fgREV7rwPmMEIj3FZUFxFA+A6uO5WFeP6Xip
         SmH1zQCdqaByaCJfh908fT/mKetXOoqb3UTPaLonQm6to4QZ1IzZygQVO6jpq5YXeZuL
         +++/iSgZz58dvuxcvnCgBvfBovcRfBHuyRcYPOqhH9BImv5zCwpY3Lb0+bva0Fv9ZjOA
         JvEGSm2RJzGNPjD8sKQG7sHePTxO1EEsK6T++Wl66dQ7sZULuCfbglenCZKkMDNsILGv
         QH+A==
X-Forwarded-Encrypted: i=1; AJvYcCXIOR/qBlY5xkXljnVXhdo9LzOfrl1Bm4SHk2fnimJXfU9WVqE+sDB7vkD4Q2v5VDYxCHFNWXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjn+Xl5g5X7XbRnwJHTZwnm8X2WFnLUdx+gWIbhFL5yWaUJ/FF
	Pa4/zCd0jI+0Hu6IiaRbtU2mJmJzlXQk2nIqL0Qel0sB2Ly6GDW2EZu3
X-Gm-Gg: ASbGncvCKKa4+eyrwf2uSRvrEQaUhqph4sslF4Ue4dLzinlMKNnmaO3FIjlimp/vpvk
	Kc7MVX2mOAaD2CsCMggmstRnoPXB8CXKCZWjt0tDAGkLmnEqQDzjoH8ta67HP66py2+wjg2yrLi
	94DqUIMl72VhauTcNyqUoRt6C0b4WWVVDkXLn2nLXMkIZtZ87E9h4DcRjaj2JI7NpB8dSAz/Ofs
	ibpe/eM6OlzUZzajFg0zGdmOrUZUzlJ4di/iGhJJXKcEVXCaiSWC3S7qSsH/nTar5D2yW9EpHJ5
	4K2h3ldQBzEgNmOngII8eOWXj9Vb+89xpyDT3VKIx2fGZqaTBmvQSGUBYxUFIG/syxZXsgXy7CX
	HjhkYbDUnVeInxMdu6y9zqWVCANupUfaaTnCoVtF1E8Ih5nxuAdifo66QHNvAtKxWkHZO6IOgX5
	dUlFvcIe0CWiASl9eBbFKws15B8Fl9KscbBWw3/Lq4ojNay0TCtXEPHFccjlpFQCD2HF2mtgUi2
	DXhb1BObazo
X-Google-Smtp-Source: AGHT+IGZffSPSJALm0kliEaiXrYJm4yGrmr2vy697Ywp7E/VeBe3jg+lCzgIqJLIm78aJI83L8bBYg==
X-Received: by 2002:a17:907:3d4f:b0:b70:df0d:e2e9 with SMTP id a640c23a62f3a-b726552ff76mr846274266b.44.1762442138784;
        Thu, 06 Nov 2025 07:15:38 -0800 (PST)
Received: from tycho (p200300c1c7266600ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c726:6600:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c6f95sm234012566b.64.2025.11.06.07.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:15:38 -0800 (PST)
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
Subject: [PATCH v2 3/3] tools: ynl: ignore index 0 for indexed-arrays
Date: Thu,  6 Nov 2025 16:15:29 +0100
Message-ID: <20251106151529.453026-4-zahari.doychev@linux.com>
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

Linux tc actions expect the action order to start from index one.
To accommodate this, update the code generation so array indexing
begins at 1 for tc actions.

This results in the following change:

        array = ynl_attr_nest_start(nlh, TCA_FLOWER_ACT);
        for (i = 0; i < obj->_count.act; i++)
-               tc_act_attrs_put(nlh, i, &obj->act[i]);
+               tc_act_attrs_put(nlh, i + 1, &obj->act[i]);
        ynl_attr_nest_end(nlh, array);

This change does not impact other indexed array attributes at
the moment, as analyzed in [1].

[1]: https://lore.kernel.org/netdev/20251022182701.250897-1-ast@fiberby.net/

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 Documentation/netlink/specs/tc.yaml | 8 ++++++++
 tools/net/ynl/pyynl/ynl_gen_c.py    | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index b398f7a46dae..3e3da477dd5d 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -2044,6 +2044,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        doc: Index 0 is ignored and array starts from index 1.
       -
         name: police
         type: nest
@@ -2064,6 +2065,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        doc: Index 0 is ignored and array starts from index 1.
       -
         name: police
         type: nest
@@ -2303,6 +2305,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        doc: Index 0 is ignored and array starts from index 1.
       -
         name: police
         type: nest
@@ -2493,6 +2496,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        doc: Index 0 is ignored and array starts from index 1.
       -
         name: key-eth-dst
         type: binary
@@ -3020,6 +3024,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        doc: Index 0 is ignored and array starts from index 1.
       -
         name: mask
         type: u32
@@ -3180,6 +3185,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        doc: Index 0 is ignored and array starts from index 1.
       -
         name: flags
         type: u32
@@ -3566,6 +3572,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        doc: Index 0 is ignored and array starts from index 1.
   -
     name: taprio-attrs
     name-prefix: tca-taprio-attr-
@@ -3798,6 +3805,7 @@ attribute-sets:
         type: indexed-array
         sub-type: nest
         nested-attributes: act-attrs
+        doc: Index 0 is ignored and array starts from index 1.
       -
         name: indev
         type: string
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index aadeb3abcad8..d01ef8fa5497 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -852,7 +852,7 @@ class TypeIndexedArray(Type):
             ri.cw.p(f"ynl_attr_put(nlh, i, {var}->{self.c_name}[i], {self.checks['exact-len']});")
         elif self.sub_type == 'nest':
             ri.cw.p(f'for (i = 0; i < {var}->_count.{self.c_name}; i++)')
-            ri.cw.p(f"{self.nested_render_name}_put(nlh, i, &{var}->{self.c_name}[i]);")
+            ri.cw.p(f"{self.nested_render_name}_put(nlh, i + 1, &{var}->{self.c_name}[i]);")
         else:
             raise Exception(f"Put for IndexedArray sub-type {self.attr['sub-type']} not supported, yet")
         ri.cw.p('ynl_attr_nest_end(nlh, array);')
-- 
2.51.0


