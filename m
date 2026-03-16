Return-Path: <netdev+bounces-268296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFn3EX+EuGltfAEAu9opvQ
	(envelope-from <netdev+bounces-268296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:30:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F302A17BB
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CA043045270
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041E374E71;
	Mon, 16 Mar 2026 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMn9rRFa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D337417A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700166; cv=none; b=ha+UeW/U/QA6IMe1B+OHqMX+YriyJvD11XVhnbkEVoJ1fDMPkjF3J4XUXtMje815q6qYfL/+JPOIzR2maqtY/ueBZVnipcYKhKwXcIBVdZAjdrWVmkVuzcCNHy7TvT16wRrh6T509P8bYw8eZCWd52tVqI+ijYT8icmjLKba5FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700166; c=relaxed/simple;
	bh=jyNxYmx5UB2XwVBzrPIt/v521XrQK8jWoaatFoXioqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1RXMk/jgZRpfFo2Z4kxxaMxB+4bSEAmNMM/xIBmljpaayaMbNHlV25uCNHiIy7YWUqn5G1zpazbxojsjMWK903RFDW/6GX1M1e1swZvGXb0noICtgOv2aF2RDc8oAkSkRHjonMCihSXxiMN3n0WYDZ9ybZ0HL1r3ED0pOuW0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMn9rRFa; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79495b1aaa7so47108057b3.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700163; x=1774304963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omed2F+AqWiwSMzDcFuf7st7hlR6TZL1wyoNIJPdTr0=;
        b=XMn9rRFal8dlvd7EaX0AqXe5plw4ois8LmhTEgSEDmwkYClkt+Pd9SFtojlgWOBOm/
         tucB/NyVFiglUhpi/tqaiY8JATMVWzzp80oERakv557SKHU0pTOeEn/KkrIMFi2qWj8l
         tPfai8Z9vngm80FYz3ni50W3vdoQ1cZ3tq1loIZSb9/myJJdvMOwJSKICCTFA8+RXKFc
         fa2Gb7USJGm6RbR/bRz2xUBEN33yOkpHfq75+EK1jAyh5XaXOLJM7K6gy3QM+BNHiXO3
         I9Wj9fvGATzEPyflcEALH4rhjtiEgS5g1R1Zgfh99A2UiNjBcIAEq+KHn5wTC0j92Qrm
         fBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700163; x=1774304963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=omed2F+AqWiwSMzDcFuf7st7hlR6TZL1wyoNIJPdTr0=;
        b=OfgBdIDHCHnbqUglQgESrZZE92IDHLFDL4AJJJm72i/9u1nXuzWgRZ5o2drgiJZXWU
         pktf6imt+VnNU/ivbaT6ULTyfZMUivQJBFjUWbpYYAwSQ8gPvjdoL2bunEHTGWCX2c/x
         uDkZWCd1nUWt8Bwjqt9sym5tDXd05E3Ysq6uf8VLraRSvHWTKvL5hwOxtWk6e13h3CY2
         lLpxB92TlNXSNxVRZfsQ5Pq/iAIxHOLnBV7wallJ5EonZ4dWJCPRXw8a1qGNW5KBaphh
         k52AuoM3/GxQF/l5gN/2OcGXdJZH8nU5VkaOR2KDicLjmp0uAt41In6ACEYPA76ZhiLx
         6g9g==
X-Forwarded-Encrypted: i=1; AJvYcCVWyJWIAt625dQ6CB5EisfRuIMH4bxLsWUt9x2Oh4OQ1Id84juU3hXGCd/Oudn8pR6/OiPdma4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs1XtY88c+e7u2dlQJN5x4QAY8F1GjB3MYFEzTy7res3Lvxzzv
	BZQ5ulFoePeXSQIi9H4A4EuWUncgmucjS4f/TJtj8B2Ic61uOKFbbubg
X-Gm-Gg: ATEYQzxnQ4efiOYfk4blOE3IZlO2jFAE/779Qxu2TYf6Er+BrXdnsjxS+TWPAOqvHtr
	EItuFNl3hw5XGxDXy0cOHQNzyJvn1yfPt1+ufFT0PRbJsGKehDwDjIHW5fXPRMd0wFwXYGsqU3t
	CQUZtmA4j4p9kRgHlewK05R6SwgvQDfX9sXPbu58JELLv2SHFvHz5ka4EhA//ZVTrCSF2Z7fo0h
	FUihlXXiSAAMQWN08Vl3xVUuF4BeiajEsRBlhSMYYrk23bzqiKot27W1eDktKVq1G9d3Psy87lm
	hYM4amADZknrvFEAmGZgL+jZvDWCpVVUrcQK2JUkF04D7hkrTmMLjVpswliGseNyp1FTVBqos6X
	kEX/+3U3G9ysRlcE+oim7mrDxNoJRcUjDM4tSLv8Ey5BV0K4aCf2HKo4cgaa2ousdvJRRyF4ezW
	CLUOYs/rZaQOwUhWVqnzJXhg==
X-Received: by 2002:a05:690c:81:b0:79a:3a79:a4b5 with SMTP id 00721157ae682-79a3a79b4eamr90331507b3.11.1773700162705;
        Mon, 16 Mar 2026 15:29:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm92905497b3.10.2026.03.16.15.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:22 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 15:29:13 -0700
Subject: [PATCH net-next 2/6] selftests: drv-net: extract _find_bss_map_id
 helper in NetDrvContEnv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-2-b53c8cd72b23@meta.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
In-Reply-To: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>, 
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268296-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B9F302A17BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

Factor out a _find_bss_map_id() helper from _attach_bpf() so it can be
reused by other BPF attachment methods. This will be used by subsequent
patches in this series that add support for netkit devmem TX testing.

No functional change to existing tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index ccff345fe1c1..08e90448f48d 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -467,6 +467,15 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return (bpf['pref'], bpf['options']['prog']['id'])
         raise Exception("Failed to get BPF prog ID")
 
+    def _find_bss_map_id(self, prog_id):
+        """Find the .bss map ID for a loaded BPF program."""
+        prog_info = bpftool(f"prog show id {prog_id}", json=True)
+        for map_id in prog_info.get("map_ids", []):
+            map_info = bpftool(f"map show id {map_id}", json=True)
+            if map_info.get("name", "").endswith("bss"):
+                return map_id
+        raise Exception(f"Failed to find .bss map for prog {prog_id}")
+
     def _attach_bpf(self):
         bpf_obj = self.test_dir / "nk_forward.bpf.o"
         if not bpf_obj.exists():
@@ -478,17 +487,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._tc_attached = True
 
         (self._bpf_prog_pref, self._bpf_prog_id) = self._get_bpf_prog_ids()
-        prog_info = bpftool(f"prog show id {self._bpf_prog_id}", json=True)
-        map_ids = prog_info.get("map_ids", [])
-
-        bss_map_id = None
-        for map_id in map_ids:
-            map_info = bpftool(f"map show id {map_id}", json=True)
-            if map_info.get("name").endswith("bss"):
-                bss_map_id = map_id
-
-        if bss_map_id is None:
-            raise Exception("Failed to find .bss map")
+        bss_map_id = self._find_bss_map_id(self._bpf_prog_id)
 
         ipv6_addr = ipaddress.IPv6Address(self.ipv6_prefix)
         ipv6_bytes = ipv6_addr.packed

-- 
2.52.0


