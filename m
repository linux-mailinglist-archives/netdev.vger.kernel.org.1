Return-Path: <netdev+bounces-208915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C43B0D902
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1AEC3B2543
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2966928AAE6;
	Tue, 22 Jul 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vd+nk4QM"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330A2E92AF
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186196; cv=none; b=m2nZakJOp1SGqfjs25HFYORNbcfnQ1zqnakI9zxwuBxbpACS5J1/do96pwgd6ijQ12ropKBiZ/u/dcdoisNR94Z+rB1uergIOoM0VCsIl/XtmR1zDkGjF4kGhCK5fY1VAH1X5PY2ON2VLjJfvW0/Nh+lhOdhiIZtwUIsGbITmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186196; c=relaxed/simple;
	bh=yL2d/9IXy4X1vzcvklpYsN0CYWqiKrn9MOHEPX0zopk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McmcCICQAnDOlbQIWS/+DidJrmepE6R4O0LTWsnnYEn0OFte345AXQFQpGZ0GmEh+908c+ZtyXTS3ALpyTrpyJ7+mpTKDvxhbjvicays6DXZYfz4CKIKQgaTKPASP7V6Vr3a/kSX05bH7tD5Gkrec+B7OhOuTrQmqhuKUQnO1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vd+nk4QM; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753186192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOi+8KHVkjaz3TIe+vlIT+Tt0tHI/hRTrBNBmnrIfVI=;
	b=vd+nk4QM3X7JYfyRWPQ+UGSuUl389lkLeF8qMz92jpbrM9b42Y95Mudtf1JzrWsIZlYu8x
	96FU+6ilYK69UQOJ9zdsfCJe7WrTxUUoQS1jtd57VAx8d+XEg2s2qNkf46gEgMZaRMXzrf
	KyumCO+MfZms57yOhPbFxYPSQvSb7y8=
From: Tao Chen <chen.dylane@linux.dev>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 2/3] bpftool: Add bpftool-token manpage
Date: Tue, 22 Jul 2025 20:09:11 +0800
Message-ID: <20250722120912.1391604-2-chen.dylane@linux.dev>
In-Reply-To: <20250722120912.1391604-1-chen.dylane@linux.dev>
References: <20250722120912.1391604-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add bpftool-token manpage with information and examples of token-related
commands.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../bpftool/Documentation/bpftool-token.rst   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 tools/bpf/bpftool/Documentation/bpftool-token.rst

diff --git a/tools/bpf/bpftool/Documentation/bpftool-token.rst b/tools/bpf/bpftool/Documentation/bpftool-token.rst
new file mode 100644
index 00000000000..c5fe9292258
--- /dev/null
+++ b/tools/bpf/bpftool/Documentation/bpftool-token.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+================
+bpftool-token
+================
+-------------------------------------------------------------------------------
+tool for inspection and simple manipulation of eBPF tokens
+-------------------------------------------------------------------------------
+
+:Manual section: 8
+
+.. include:: substitutions.rst
+
+SYNOPSIS
+========
+
+**bpftool** [*OPTIONS*] **token** *COMMAND*
+
+*OPTIONS* := { |COMMON_OPTIONS| }
+
+*COMMANDS* := { **show** | **list** | **help** }
+
+TOKEN COMMANDS
+===============
+
+| **bpftool** **token** { **show** | **list** }
+| **bpftool** **token help**
+|
+
+DESCRIPTION
+===========
+bpftool token { show | list }
+    List all the speciafic allowed types for **bpf**\ () system call
+    commands, maps, programs, and attach types, as well as the
+    *bpffs* mount point used to set the token information.
+
+bpftool prog help
+    Print short help message.
+
+OPTIONS
+========
+.. include:: common_options.rst
+
+EXAMPLES
+========
+|
+| **# mkdir -p /sys/fs/bpf/token**
+| **# mount -t bpf bpffs /sys/fs/bpf/token** \
+|         **-o delegate_cmds=prog_load:map_create** \
+|         **-o delegate_progs=kprobe** \
+|         **-o delegate_attachs=xdp**
+| **# bpftool token list**
+
+::
+
+    token_info  /sys/fs/bpf/token
+            allowed_cmds:
+              map_create          prog_load
+            allowed_maps:
+            allowed_progs:
+              kprobe
+            allowed_attachs:
+              xdp
-- 
2.48.1


