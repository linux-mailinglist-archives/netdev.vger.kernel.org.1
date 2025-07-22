Return-Path: <netdev+bounces-208909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B663DB0D8B0
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F479163F78
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77D2E4271;
	Tue, 22 Jul 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZDBwDnEH"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963A2E425B
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185544; cv=none; b=tK+kZ7Mjm00Xf8NtwJdpOESydMFS3RF9XMMZTvGHOG7Fi0DwfhNvqwM943RfJAGTPl4TY72bBOFDWKVcElVHkjCi+FY8q7VNe+ix5+rlRCg4RTBeRT4jiiKUxzJwGFAb1zfQxPL8ZhI3AA0qBdCoDwuSQee70asihSD8fp+ZNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185544; c=relaxed/simple;
	bh=yL2d/9IXy4X1vzcvklpYsN0CYWqiKrn9MOHEPX0zopk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHWZNLR+FrjKbnmVeYS7KwSYbPerEZ+SUKtyblOD6wAaye+H0i6mNc0YK7Ku5YLuRTsJt+pvnyAw04enYjOE0bHJC0MFQpU9lbQRiw8MrVKT0hTLNSoe6KAyYjmDuV0qyFaY9MqyUrhcYoSrl4VZhDN1laVOoP+qj+kx2KfTUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZDBwDnEH; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753185539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOi+8KHVkjaz3TIe+vlIT+Tt0tHI/hRTrBNBmnrIfVI=;
	b=ZDBwDnEH6ZF6X45/ldSLpLzAbKbx/n2EiovqL7bqkJDIXefUeDIDchXtwU2V8gX8i0BKAp
	Aa/eRBVrQ1Fmuf+/t3B6jWZMkt0xDWJJIwQ6A+ZuOXDMFAc9mu+0l59LKIkJUHx1anVP4r
	1OKoWfZBtUxwV9skKs9/69y1rNELeZo=
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
Date: Tue, 22 Jul 2025 19:58:14 +0800
Message-ID: <20250722115815.1390761-2-chen.dylane@linux.dev>
In-Reply-To: <20250722115815.1390761-1-chen.dylane@linux.dev>
References: <20250722115815.1390761-1-chen.dylane@linux.dev>
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


