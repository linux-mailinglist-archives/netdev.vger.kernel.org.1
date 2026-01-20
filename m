Return-Path: <netdev+bounces-251363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65ED3C01A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC00D402FC1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4438A9B8;
	Tue, 20 Jan 2026 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjTn3U7R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C337F0E4
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892795; cv=none; b=X1PiPdmTlOy3/AI2FgvmoRvbaHgTQAQPPjMmq5e2inuMMGHHfltTt3jUc+59UVL2yeUvQJl6Az95V2uSngekZ9e0dyy0+b5Xsx9a+JmM5RchT1nVESrQIMTe/GdRmQRsLp4ffGZulMauoGkVGK5Cmc7Nw5lMvXXVLuDVmT6wfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892795; c=relaxed/simple;
	bh=N2XC72YuwbVooj49gSUC23yr6OLWGEsBRVB0n5dcYww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggKW3Acks1aFMViMO3I3fE0sbCzegotUxnXg8t5K585jfsuzHD3Rklriw53uNXfqdyMABHmvlvlAgGwPNETDV8CA/N2qVgJAcmDuuEYUBOUe9msW22v9iW2k13Km0VfdvaIfe1K2i/8HdplgNsv7TthFonC7/xopy4taZAs31n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjTn3U7R; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0d0788adaso32438605ad.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 23:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768892787; x=1769497587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8e96Wx1n0qpGbVjK3mBfOV2yV5DDoKmdYehuYIVGJg=;
        b=mjTn3U7R+YpbF4E4Uwyr2sfKTXoqfgg5d5jg4DI9l2NI245ny0GbuiRF7Cjo6IbKjo
         tES1nUVdTFWq4JMrC5q6EoL4B47I1S4FZ2Iu9oJDXTVL3k+juLmQ9V2Pu0B/3h4XUtMz
         idsKnU2a3Tb4Z2nb6eKlWwA4Z1sEWHCv3z6VfjBYJWdmJfHTr1Zi/xEpB+6dtsHgXy3n
         SBnXGJyhDDqISt4Co3atOsA4tnnEsJFQ1TcPA5Xkgaw7wgDSApXOBz/BtIiJCOU0oB0y
         hjllQf6aSG9DFXX8+gsxS9yQzQzVGq5FhS5x5nsMUfrCOGAa4TMf68f5VdjlREkS2x8x
         kF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768892787; x=1769497587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8e96Wx1n0qpGbVjK3mBfOV2yV5DDoKmdYehuYIVGJg=;
        b=ernCS5H6rQUqoAicjlUaHTxctqWVKlkljGBndFxlPwFEFe150o3FXke/RvQYYP5IGS
         97bsg5as7Y9V1htUVALA/5oNbTqvTleIO2URSkdu5wB+K9M0ByOVuZI+bOyU5M4uxoX2
         OuB34YO/Peze5pSKrLbuoxHSiYcnhkNX3sMrm2jC0/oqBW/69UqFY5zkdlGY/3aL9BSZ
         zVJIaUrqvK6MUbEXQ6DjvEcuv55N5AXIKevDjFNBg1vC7wSVO7eeiZrjxyq9Pb4P3QWs
         R2due6PycZ0ze/sRArimCTr84xZYSBb5nZ0kv8lhyfofYbgj8XPFgVkoPkIVlw76b8q3
         HuSg==
X-Forwarded-Encrypted: i=1; AJvYcCUTYxbHqQ5zWv3+B+R+4AbyUzsPXK9KGQhVatFUWrsW8IWBXhRqGqwIWch66XaFdhgGNL219Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpk0yIoVJHjhpSqNECqxd1jXX+F9Zve1AB43kIlQZ044vVtLu+
	e4MkM8Bwizo/VYVTFtBsV8kJO0KCFqxEpgdMu1ibfAP6cp8vuXmPqEc1
X-Gm-Gg: AZuq6aJxudrLqvGl6yH5iC1DXwkrPED+vTkTCkidD9p9ZAi4FtiCpT5RCYW6bnyG8+N
	DVNSsrOwcUL2Ad9N1ICo3pO+pzNC/KmKtBGcU5c6C2a70CTpKtdOFcmJrmP33SNmrT1K+wmp1j/
	SYDEot5dCkS2j/+Pm/1CY4Fg25II8w+0kMDurOU29tbqIR9VPHlGKFPypo6hEt6jENrh2Ha+jwU
	0c8Y3wTllfaHwk91Gz7c1jmv0bA5iPj2ZoFBF4Llh2SBOKpu5bHZLoWFGW26rOuUw8Fkf/vY+7k
	qg57XcjUz1kawxNzVuhHU98m4mJmuG9sYE2MFDabKVwn/MgFB82EZPye/o5nTRhcjSC2h1ubLmi
	+hbcmK+5vbnNdHYvPAO2LV2t1vibtemkBWXeJ1MeBRcVLrx0+keOoje0kfwWhYn1jqM85B5kbSk
	VqHch+8CkJ
X-Received: by 2002:a17:902:da88:b0:2a0:d364:983b with SMTP id d9443c01a7336-2a76b39df9dmr7779905ad.60.1768892786963;
        Mon, 19 Jan 2026 23:06:26 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce534sm111695665ad.27.2026.01.19.23.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:06:26 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of bpf_get_current_task
Date: Tue, 20 Jan 2026 15:05:55 +0800
Message-ID: <20260120070555.233486-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120070555.233486-1-dongml2@chinatelecom.cn>
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the testcase for the jited inline of bpf_get_current_task().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v6:
* remove unnecessary 'ifdef' and __description
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 20 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 38c5ba70100c..2ae7b096bd64 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -111,6 +111,7 @@
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
+#include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
 
 #define MAX_ENTRIES 11
@@ -253,6 +254,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
+void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
new file mode 100644
index 000000000000..4ea254063646
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("fentry/bpf_fentry_test1")
+__success __retval(0)
+__arch_x86_64
+__jited("	addq	%gs:{{.*}}, %rax")
+__arch_arm64
+__jited("	mrs	x7, SP_EL0")
+int inline_bpf_get_current_task(void)
+{
+	bpf_get_current_task();
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0


