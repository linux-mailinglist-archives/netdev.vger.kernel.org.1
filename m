Return-Path: <netdev+bounces-161105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A076EA1D668
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E5A1885A2C
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 13:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31761FF60E;
	Mon, 27 Jan 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/jlQboR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6421FF1B6
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983636; cv=none; b=VjMN3TjTEL5SiKMX6+ADBterPn92OUg9/dMxknVZ0oTbjuTpME3o6exUl71Nf+L9j83/YkRaXl4aRTvYOCb1QJRahIqzokehHYwHNkOcYVtrjdD/JoBZQmbt6Qv+i2m09bYdrFGY832xzJvp16QX8bYRfg4jJipAaapyrq+K4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983636; c=relaxed/simple;
	bh=8OZ7144oa1zhpCyIBB77wB9B4bLPgwKS/BgrajyuRMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlzNlpVbh0z7jQD9bOxfgwQYHxN1gXaO69fzDFw3ZTKoTQK+kI4/XLlv/rR9yclQSKKEZucnoiZ60XBbj7Iun6wzOl3XLThXnIIhWlHhUvoVy+oXe87yi5poeGA/nu9SH9PRVfPxQ39wbLtzlWNp+JWU7Y/GZLzdTagsif48x6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/jlQboR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737983633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwstsfkpYg4IjZDk0+qfOY/IluGTSBwJqLS1TP8vKVY=;
	b=Y/jlQboRN72B909x78I1UCUdLVbG6Ftb/6v9bnMKrTtF1tYY5yoV/VNO5Tf0XaldsLlwv2
	esZVlieQOHG607LMPAfI8ml1+1M4RSpkcqCJLe6oz0VH+kzwoVkoABtaumAe3R9AOE7DFL
	gTmK3ExHIiNzDR4SK9I+a7Wdfq98Ghg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-Ag7WUXGqML-xyR6cssZKjw-1; Mon, 27 Jan 2025 08:13:51 -0500
X-MC-Unique: Ag7WUXGqML-xyR6cssZKjw-1
X-Mimecast-MFC-AGG-ID: Ag7WUXGqML-xyR6cssZKjw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aaf8396f65fso430584966b.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 05:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737983630; x=1738588430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwstsfkpYg4IjZDk0+qfOY/IluGTSBwJqLS1TP8vKVY=;
        b=W01ew8UsWm9j8Kja8YQoNV5Q1MT/x98Ln1qg7vdJ/z/3xJa+SfeyIAOAFSksD31MEe
         0raPQBi/GY1gHecKM7Y9gKdD+IZtGV5qGGFtguvJWyCazvFGLI/okJ2hTIbu0r/DMmYj
         3d8IMli/0TFW/LEULJM1m3MLSdGXEex/gpPCHnbz4ueLzqcpBtLTcXUDAImxtkhMbtXH
         yyBPleQqgGwsm4YwS9zb9Z5lEXRt1KnCFlv08JvaRpQZ9VLSwxl+I094Wbgx0+ueOCgQ
         IOggRdA4HieZus/viIjvqHe70rmyPDm7cNgQcWHKSrORY/wVJxpifWHoMS0Oite+clWQ
         QpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfJs0GQkACwJFL3rOAsMMl9yLof17KvK9lqFBUo11/cDUiwlypArptTr08tkw6dgjxYzCBo2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMhzPL5PWGb0XPvSpbavXZLXs76A7glavfX7IeG0bcfvjOh5F
	uq4FLqYs3AENIcHZVC0GjWgV3CJ+3O3deqf9LtVvTyhSZexihxGXXS/RcdHsImzqJIieWE3V0lq
	ncAjTtlUvYfWQ05qHraCJdmtYbalidJlsClqUziuvPxZpEMs8rMYo2w==
X-Gm-Gg: ASbGncu/FoYBlUclWmAGSK9fo//tXH7JZFpMpXPzSeAL0mlXMxBmsyI9b6N+apCNQeH
	ALwMAvaZrvLLjbn0V2d4VN9h49gqaos1XgykUjPh8+T3xO+4N9DhigOjVkEO2Bjuqtltpa9Dxy3
	f9nFGLmqKSCT3YNY11uWlvboWmmYY7W3CcRJbzTP1WVq89QWaMBmQsrtpnuzTXo9qNFy2OV6UqY
	vI27fRGYbwgXKI24oBWSI+9QUZFPguFhQ+y6ulfj4kWmhJarvTxRMpUtddF4a48D2er8Z7OdJYJ
	pg==
X-Received: by 2002:a17:906:560c:b0:ab6:3aac:de5e with SMTP id a640c23a62f3a-ab63aace8eamr2326938366b.36.1737983630437;
        Mon, 27 Jan 2025 05:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEntOF7lQgLECst1EbclToF8ZfSOkUszcYnSKdNXE1+HyGjA+45oaKOAyk87OgxdvulVnumCg==
X-Received: by 2002:a17:906:560c:b0:ab6:3aac:de5e with SMTP id a640c23a62f3a-ab63aace8eamr2326934666b.36.1737983630063;
        Mon, 27 Jan 2025 05:13:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18640df4sm5297745a12.48.2025.01.27.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 05:13:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5C0E0180AEB7; Mon, 27 Jan 2025 14:13:48 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 2/2] selftests/net: Add test for loading devbound XDP program in generic mode
Date: Mon, 27 Jan 2025 14:13:43 +0100
Message-ID: <20250127131344.238147-2-toke@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127131344.238147-1-toke@redhat.com>
References: <20250127131344.238147-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test to bpf_offload.py for loading a devbound XDP program in
generic mode, checking that it fails correctly.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/net/bpf_offload.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index d10f420e4ef6..fd0d959914e4 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -215,12 +215,14 @@ def bpftool_map_list_wait(expected=0, n_retry=20, ns=""):
     raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
 
 def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
-                      fail=True, include_stderr=False):
+                      fail=True, include_stderr=False, dev_bind=None):
     args = "prog load %s %s" % (os.path.join(bpf_test_dir, sample), file_name)
     if prog_type is not None:
         args += " type " + prog_type
     if dev is not None:
         args += " dev " + dev
+    elif dev_bind is not None:
+        args += " xdpmeta_dev " + dev_bind
     if len(maps):
         args += " map " + " map ".join(maps)
 
@@ -980,6 +982,16 @@ try:
     rm("/sys/fs/bpf/offload")
     sim.wait_for_flush()
 
+    bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/devbound",
+                      dev_bind=sim['ifname'])
+    devbound = bpf_pinned("/sys/fs/bpf/devbound")
+    start_test("Test dev-bound program in generic mode...")
+    ret, _, err = sim.set_xdp(devbound, "generic", fail=False, include_stderr=True)
+    fail(ret == 0, "devbound program in generic mode allowed")
+    check_extack(err, "Can't attach device-bound programs in generic mode.", args)
+    rm("/sys/fs/bpf/devbound")
+    sim.wait_for_flush()
+
     start_test("Test XDP load failure...")
     sim.dfs["dev/bpf_bind_verifier_accept"] = 0
     ret, _, err = bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/offload",
-- 
2.48.1


