Return-Path: <netdev+bounces-134240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F359987AF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B040B2824EC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2E21CBE96;
	Thu, 10 Oct 2024 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qq26IAdg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D701C9DF3
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566886; cv=none; b=qbdmX9vM4MCaiVPQYqZqMxwmHM8awgNG8h7qbvoq0xhYqtHv2YC8ynWxLb4EWQ6rcH2/jR+EVvBOyQL/1xqCjVOukJLp18OTt8cDwFUwZi1Jg/3mD4syBBo07PEOsz/g9HbYQdgmCMO9gLmQLp1ZAWMRrsP6ucfXAYwJjoyP1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566886; c=relaxed/simple;
	bh=QzXfylZ4JE8G1GBkjM1ir0PcS2nG6lhTP0K5aixrrz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hKCbzaMOmHquly+qS/zM0T6AzuwD7pPmSnn8Cwc+FYLS7ZuV7LUVQnNBs7TC9tBY4+SPIzdqZqJPD7Wip39ox1Z+GpqXerOS4MfpECSpIe4SYUQOeC1sfZc8dMIam+DEvUU2WzjttrR0GloQBrlsN8/P+RJLTq497ZPhhENQSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qq26IAdg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728566883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=anubq11vB/lo7n+tCLWsH5bZuedG/liPgNJBc/f01io=;
	b=Qq26IAdg2LaeTMon6qG+52PowBADgkb8+y3s/mpOFyL7ndIreLjNpKLels7i1X2qUyEJLF
	5IaGHEgnRoTCEpr989V6PCjsZZTN0aVU1OVy5BwuWbDJJg0LcduTQ1qf0ynLG9VjWzZjA3
	FxksY9mFOSAtMMWRB2eBfKrOr0zgLNg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-ZaDBo0FHNUeeEtS9O8jpaQ-1; Thu, 10 Oct 2024 09:28:00 -0400
X-MC-Unique: ZaDBo0FHNUeeEtS9O8jpaQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4d51b4efso261405f8f.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566879; x=1729171679;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anubq11vB/lo7n+tCLWsH5bZuedG/liPgNJBc/f01io=;
        b=JGVHLA4sC5yjuZJS4DM+ogcOA+7WVupv6skqtZEf4UUCWMjKS1D0UQ/plv/VyjITKg
         4QtvwZrKAQVfrshDlTc0rFAOeeemzfd7M+Gd5cixFGom5yHzedkVCEeKEH6Y0niI2W3q
         es2QpDhpJI99PLXKOCSCcM72KLId4g9+ICSL+BmJc0oVxFFctPpBTQ0lY/hW8dvY2Eu3
         g7PVHEQn1PQRmvrnLpf5jWp/JPPbUSXExaGzK9/HTQA1hVrrmrSeYezYCoei/ZNSG6L0
         QP5fHHzYYICK6xZySZQ111SWEzV7pMz/B+3ZwSLyjAi7qXQM0ClIwgy5rPuLhdAymbOp
         xl9w==
X-Forwarded-Encrypted: i=1; AJvYcCXdln2FLZCjcnDzbNOJMDXp8FD8Hwh/gcQARzhAkY8qKqTcnHwg31KmHGiRspMD+vXBpx4dr8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvEHjMFnoQwp9b+UzRFiZJoNcl91AKkBFO2q8x3sJMsVu5DZB
	yMdspXY8hx11RGnpkG2XoD+hU/GVXMpHXDl/3sFF1IF7kLvdDC3YtGdrcH7y8r/Ye5lwFTx1kfL
	AsnHTN9zLbE1Qa1UXOFrHv4a7AMLJq5eIA6eB/9Eap+SAgxQIKkr7YA==
X-Received: by 2002:a5d:68d2:0:b0:37d:4cef:538e with SMTP id ffacd0b85a97d-37d4cef5431mr1352776f8f.55.1728566879173;
        Thu, 10 Oct 2024 06:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERkXSpoeTCMCSFJETVvt8b1b5EHViM7IaDu9yOPcwCmke2o5zf0SH75HMtnBh5pbFywAM5xg==
X-Received: by 2002:a5d:68d2:0:b0:37d:4cef:538e with SMTP id ffacd0b85a97d-37d4cef5431mr1352745f8f.55.1728566878688;
        Thu, 10 Oct 2024 06:27:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9190f7sm1547399f8f.114.2024.10.10.06.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3D11415F3E9F; Thu, 10 Oct 2024 15:27:57 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf v2 0/3] Fix caching of BTF for kfuncs in the verifier
Date: Thu, 10 Oct 2024 15:27:06 +0200
Message-Id: <20241010-fix-kfunc-btf-caching-for-modules-v2-0-745af6c1af98@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACvWB2cC/5WNTQqDMBSEryJv3VeSGMR21XsUF/l7JrQmkqi0i
 Hdv8AZdfjPMfDsUl4MrcG92yG4LJaRYQVwaMF7F0WGwlUEwITljPVL44IvWaFAvhEYZH+KIlDJ
 Oya5vV1B3omOt7CWRhvozZ1dHp+MJeiYYauhDWVL+nt6Nn9Ufio0jQ0uO7E0p2fL+kZ31armaN
 MFwHMcPlBNHC9gAAAA=
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
to trigger it (last patch). The middle commit is a small refactor to
expose the module loading helper functions in testing_helpers.c. See the
individual patch descriptions for more details.

---
Changes in v2:
- Drop patch that refactors module building in selftests (Alexei)
- Get rid of expect_val function argument in selftest (Jiri)
- Collect ACKs
- Link to v1: https://lore.kernel.org/r/20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com

---
Simon Sundberg (2):
      selftests/bpf: Provide a generic [un]load_module helper
      selftests/bpf: Add test for kfunc module order

Toke Høiland-Jørgensen (1):
      bpf: fix kfunc btf caching for modules

 kernel/bpf/verifier.c                              |  8 +++-
 tools/testing/selftests/bpf/Makefile               | 20 +++++++-
 .../selftests/bpf/bpf_test_modorder_x/Makefile     | 19 ++++++++
 .../bpf/bpf_test_modorder_x/bpf_test_modorder_x.c  | 39 +++++++++++++++
 .../selftests/bpf/bpf_test_modorder_y/Makefile     | 19 ++++++++
 .../bpf/bpf_test_modorder_y/bpf_test_modorder_y.c  | 39 +++++++++++++++
 .../selftests/bpf/prog_tests/kfunc_module_order.c  | 55 ++++++++++++++++++++++
 .../selftests/bpf/progs/kfunc_module_order.c       | 30 ++++++++++++
 tools/testing/selftests/bpf/testing_helpers.c      | 34 ++++++++-----
 tools/testing/selftests/bpf/testing_helpers.h      |  2 +
 10 files changed, 251 insertions(+), 14 deletions(-)
---
base-commit: 60f802e2d6e10df609a80962b13558b7455ab32b
change-id: 20241008-fix-kfunc-btf-caching-for-modules-b62603484ffb

Best regards,
-- 
Toke Høiland-Jørgensen <toke@redhat.com>


