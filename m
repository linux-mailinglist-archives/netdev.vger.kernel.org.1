Return-Path: <netdev+bounces-133043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBAE99458C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1C51F24FAF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E21CDFA3;
	Tue,  8 Oct 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcMNJg0/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3201CC14B
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383746; cv=none; b=fv+8S5poiE4qQRMSRxhJiXVNeoLHzqGM0cJaOs0nsiYhKtJ0ztiUoldBHeSJrwOqrbkMG+E0zzNEQUD2B+6slH0SeZDC6t5Y7Nwp5WyqJvzLukYjPiJzPTquxTkeO16cIzip9CBwODmX2lBEprFnmKeCKXgLJhq4NiIPoIx4K6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383746; c=relaxed/simple;
	bh=8RJiOJ8JRImzyqFjtg6dRbv/W6gDVhM1vHp1xjxQn+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pyrf9T8FxMdBnUj9XXhFw2ZiBT7sUrGcD/AxJobEsTGuuu4ThiuuCc1Usbrkwc8LA6JvUIDBTSImNoY0488ZoV7MboHq67RT0PiBwaorr2DtvJjuF4+hskWYiJBE9Fr8cxZcT2hv400VxfGuEeE+B8rafzbxPa6iccMIwFxg4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcMNJg0/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728383743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fvnxqJ/5Q1Es0acNiJuMiLLZHilQRbZHPUZF0n1lFsI=;
	b=YcMNJg0/3tJU+DIMll+4iARabVEnwQXh1M9PchYo/3/zYrMpmBsqVCloZ5oq6fJs25Q7WV
	hkznzEfznYIerjTutJIW3hs8gF3X+WSFsfjUD3EWgFYLfVbj+v4undiK2hdHObLqKVEg7h
	8RSNGM45MQp1UGrgmWu6uJWzIX7b3jE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-rsjpDy0wN5GWw_5f2VSJow-1; Tue, 08 Oct 2024 06:35:42 -0400
X-MC-Unique: rsjpDy0wN5GWw_5f2VSJow-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d331245b9so188785f8f.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 03:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728383741; x=1728988541;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvnxqJ/5Q1Es0acNiJuMiLLZHilQRbZHPUZF0n1lFsI=;
        b=X3GbK+ojjAN397mSk8vcDaEe6edoVOYslAzRCul4kvm4s1K3Rp2K+2NqUHLaDuFhwI
         7fCR0OWZFLOZ3/KFz9liWXgaz+bE8PtCHJmqfJzFPnP2cRy3CCbYf1d5g0z9zzWHbACi
         3T6oAhboivHz6wE1E1GhUn5vjyhcM1BfWmqGiKa1O5zJFAJJ56YFcpeSeFKPRu/vvCxi
         c70M1XoJ8sqDV8bplLV6G3ftciVNS/FO6WuuB4PgregrvAqpNgn/f0OugaHxkBKS2/n3
         wt/C3SqDdT6o/u8d//2fH0F+dTAjksBprmLEJ51Dc3qMqDdUIHWT20ffE0j6sQfMsfEJ
         GddA==
X-Forwarded-Encrypted: i=1; AJvYcCUBW+yAVG9+eS/naexhQ8W3p2cCTmXmJBuaQdNfERMenOQDV3h34eATfEd3ZNYMv6FQ1j+Ccfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ihaGnrp+XSXYKHPD1okwcFYnHcGRgoj+et3GUbzryKo28h+1
	HVCxQWizmzGXkMJrhtlCm46z1K32SbcsvZkqmmb37V0RXFXd0qm0ii6+fQi6V8vsmB6QnMthpFw
	FB2yhixMQDshj9bx9sdHI95E7v8n4FHXMkJlfKKkf7QihGgbLuZgOZA==
X-Received: by 2002:a5d:6dae:0:b0:37d:354e:946a with SMTP id ffacd0b85a97d-37d354e962dmr518547f8f.50.1728383741069;
        Tue, 08 Oct 2024 03:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxGmrpdJbsZcplTfu35eHH9LxnT19RV4Eq47T/jPyDvujZKh64C6mAiQ2bnwt3svn3CQ6NQg==
X-Received: by 2002:a5d:6dae:0:b0:37d:354e:946a with SMTP id ffacd0b85a97d-37d354e962dmr518514f8f.50.1728383740594;
        Tue, 08 Oct 2024 03:35:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920cc7sm7812926f8f.61.2024.10.08.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 03:35:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E838015F3AD5; Tue, 08 Oct 2024 12:35:32 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf 0/4] Fix caching of BTF for kfuncs in the verifier
Date: Tue, 08 Oct 2024 12:35:15 +0200
Message-Id: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOMKBWcC/x2NQQqDMBAAvyJ77kKMIUi/Ij2YZFcXayKJloL4d
 4PHOczMCYWyUIF3c0KmnxRJsUL7asDPY5wIJVQGrbRpleqR5Y8LH9Gj2xn96GeJE3LKuKZwfKm
 gs9qqzvSG2UHtbJmq9DwGcBvD57pur5c23HgAAAA=
X-Change-ID: 20241008-fix-kfunc-btf-caching-for-modules-b62603484ffb
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

When playing around with defining kfuncs in some custom modules, we
noticed that if a BPF program calls two functions with the same
signature in two different modules, the function from the wrong module
may sometimes end up being called. Whether this happens depends on the
order of the calls in the BPF program, which turns out to be due to the
use of sort() inside __find_kfunc_desc_btf() in the verifier code.

This series contains a fix for the issue (first patch), and a selftest
to trigger it (last patch). The two middle commits refactor some of the
selftest code to better handle building and loading multiple kernel
modules as part of the testing. See the individual patch descriptions
for more details.

---
Simon Sundberg (2):
      selftests/bpf: Provide a generic [un]load_module helper
      selftests/bpf: Add test for kfunc module order

Toke Høiland-Jørgensen (2):
      bpf: fix kfunc btf caching for modules
      selftests/bpf: Consolidate kernel modules into common directory

 kernel/bpf/verifier.c                              |  8 +++-
 tools/testing/selftests/bpf/Makefile               | 35 +++++++-------
 .../testing/selftests/bpf/bpf_test_no_cfi/Makefile | 19 --------
 tools/testing/selftests/bpf/bpf_testmod/Makefile   | 20 --------
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |  2 +-
 .../selftests/bpf/prog_tests/kfunc_module_order.c  | 55 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bad_struct_ops.c |  2 +-
 tools/testing/selftests/bpf/progs/cb_refs.c        |  2 +-
 tools/testing/selftests/bpf/progs/epilogue_exit.c  |  4 +-
 .../selftests/bpf/progs/epilogue_tailcall.c        |  4 +-
 tools/testing/selftests/bpf/progs/iters_testmod.c  |  2 +-
 tools/testing/selftests/bpf/progs/jit_probe_mem.c  |  2 +-
 .../selftests/bpf/progs/kfunc_call_destructive.c   |  2 +-
 .../testing/selftests/bpf/progs/kfunc_call_fail.c  |  2 +-
 .../testing/selftests/bpf/progs/kfunc_call_race.c  |  2 +-
 .../testing/selftests/bpf/progs/kfunc_call_test.c  |  2 +-
 .../selftests/bpf/progs/kfunc_call_test_subprog.c  |  2 +-
 .../selftests/bpf/progs/kfunc_module_order.c       | 30 ++++++++++++
 .../testing/selftests/bpf/progs/local_kptr_stash.c |  2 +-
 tools/testing/selftests/bpf/progs/map_kptr.c       |  2 +-
 tools/testing/selftests/bpf/progs/map_kptr_fail.c  |  2 +-
 tools/testing/selftests/bpf/progs/missed_kprobe.c  |  2 +-
 .../selftests/bpf/progs/missed_kprobe_recursion.c  |  2 +-
 tools/testing/selftests/bpf/progs/nested_acquire.c |  2 +-
 tools/testing/selftests/bpf/progs/pro_epilogue.c   |  4 +-
 .../selftests/bpf/progs/pro_epilogue_goto_start.c  |  4 +-
 tools/testing/selftests/bpf/progs/sock_addr_kern.c |  2 +-
 .../selftests/bpf/progs/struct_ops_detach.c        |  2 +-
 .../selftests/bpf/progs/struct_ops_forgotten_cb.c  |  2 +-
 .../selftests/bpf/progs/struct_ops_maybe_null.c    |  2 +-
 .../bpf/progs/struct_ops_maybe_null_fail.c         |  2 +-
 .../selftests/bpf/progs/struct_ops_module.c        |  2 +-
 .../selftests/bpf/progs/struct_ops_multi_pages.c   |  2 +-
 .../selftests/bpf/progs/struct_ops_nulled_out_cb.c |  2 +-
 .../bpf/progs/test_kfunc_param_nullable.c          |  2 +-
 .../selftests/bpf/progs/test_module_attach.c       |  2 +-
 .../selftests/bpf/progs/test_tp_btf_nullable.c     |  2 +-
 .../testing/selftests/bpf/progs/unsupported_ops.c  |  2 +-
 tools/testing/selftests/bpf/progs/wq.c             |  2 +-
 tools/testing/selftests/bpf/progs/wq_failures.c    |  2 +-
 .../bpf/{bpf_testmod => test_kmods}/.gitignore     |  0
 tools/testing/selftests/bpf/test_kmods/Makefile    | 26 ++++++++++
 .../selftests/bpf/test_kmods/bpf_test_modorder_x.c | 39 +++++++++++++++
 .../selftests/bpf/test_kmods/bpf_test_modorder_y.c | 39 +++++++++++++++
 .../bpf_test_no_cfi.c                              |  0
 .../bpf_testmod-events.h                           |  0
 .../bpf/{bpf_testmod => test_kmods}/bpf_testmod.c  |  0
 .../bpf/{bpf_testmod => test_kmods}/bpf_testmod.h  |  0
 .../bpf_testmod_kfunc.h                            |  0
 tools/testing/selftests/bpf/testing_helpers.c      | 34 ++++++++-----
 tools/testing/selftests/bpf/testing_helpers.h      |  2 +
 51 files changed, 275 insertions(+), 108 deletions(-)
---
base-commit: bcd28cfd04ebd3f871443e4746e511147686e517
change-id: 20241008-fix-kfunc-btf-caching-for-modules-b62603484ffb

Best regards,
-- 
Toke Høiland-Jørgensen <toke@redhat.com>


