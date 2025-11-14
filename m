Return-Path: <netdev+bounces-238766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB68C5F310
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A18E4E21BB
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E634677D;
	Fri, 14 Nov 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIZ2hNVy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49890326952
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151212; cv=none; b=gO3sED3ky/KOpA6gBNNdFD/vLTB1c6z8wruyU3beNwqv0bD6amBP5ZEOI/3mKP6ufR0M1b9iE/kyXVk4jsy9diwkl+aNQNt5knIxL/kRDXXQMcN3bMk5pc37bmRrox6L/DF5R7SSQf1wcKCipdd7roeYldIPSrBWG3DWSZkjmhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151212; c=relaxed/simple;
	bh=gfsEfam1TnFDHwHfKeJ/eALWiVqPybvUIuBzruEQW+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kwK0S9ykgNW7xelz3wN+CXcnTKQVURppVaqPP6cCaSZ1LBkUMQB3vNZt50nk539EIRbKFEoTLqcNEOixiE7iv4FNRHvzh1echki7xFsJej2HFofcebW5yDMJT+AIxcbNYPSoXdsVhpsSq2G0Yo6jPV1TySkh53Mu3pxBsMzzB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIZ2hNVy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ba49f92362so1346241b3a.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763151210; x=1763756010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uf3BUSzSZCJoavzKn2m+Jz/HGUOS/A8evMUw5+t52po=;
        b=iIZ2hNVyg2oJCn/9hzCj5MwhOjKE6SckaxoxOpzSDKRNjPjxsO9/d41qauIsVODR7h
         V3cXtal55vsxmsVXMWmy15D9xDu/WHcYVkRrjaqJxDSO3d/1ji20OPmHgt/zAphQ97ME
         OVyez6xaLu4lt4+iXlPQXwzDudTTQZ2VlcHJm3s5T0z1C1OfbtSt2mHIJSJ0Pbv0ZLnE
         dbjtgvDyMY/P5SEYiAkR0jTeNGiKujwAskF+yRlBLCTP9CuAc2KiBX5dzNYRLn2hkLkd
         b1/DGO6T+91ipSUwnHjeRQZBRJ5iZ260wgVWgLY7wxyIYprUXQbz0MtJFpWi7naeB8AR
         1Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151210; x=1763756010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf3BUSzSZCJoavzKn2m+Jz/HGUOS/A8evMUw5+t52po=;
        b=kkxcvM7g0GCkOO39f3oldqFAKGugNKPoAVRO4z4k9Epclyahj+u0H/+PJZUGwQ+okh
         IJDlqFPoIZPpgQ7ItE2oMhhoTBFShGBH0jsA6ff/7+h12PnFTcnmwzhEsRr3JIASD/52
         YvNKT12fQHx54jar/KgkTf7IFbDoxri76xLksIydd9DWgW/QU79SQ+uSrmsXjeJrIqQl
         +MfwcItADw4YcWJUU/MBjOG33ieyoFizcepIzi0E6t9lNtAp1rm3B0n39jqeSUiKd0+2
         vhtXNpOHvy+Cc3cCywxzr15jABrLcUzR7zCYdqXSibKXzz/7jh6+okkyh1l0Z0WVQ2NU
         HO6g==
X-Gm-Message-State: AOJu0YwuxzAwgRKTCJlZgDY+OcjeI03L3vEzzUgCNB77lFo+cnAqihLv
	JGvLiyKSOfbRUn8sdzd2v+Dz87C+HBpnLmphA6N1NbErJbhevwZDDLQ/
X-Gm-Gg: ASbGncvp3RuVy1gItboK/Tui0FuoV8gzgom2l2i5vrReh0ShvRR2uvhDbVXGMMrgrO/
	o++YIu+lFF47nn1dlD3ZeRCPgg0oxUTzVbJAuX3Hyp3jO6YiEEGFVUQPZvwvRfbV05iV3ZFPWoP
	EmnHpctYyi9NllTjyrnOxICfjLsAwbp+TvCuThLxGcWOheu6UWfdCRBfNOGR7Wk3ywU0ngIqgOI
	7yPdGTHbB0coJyTY8ALQgK33iCvzBqh19FGtQycBRgul+kqK4ChyiUDpiPmL8MisdhirTuwX/Bc
	mpW3TujUwHmzWMulapxbTOw1rruB63JmMrLlnYYOiUPxrCDGupeC5kUBIBJD5zOlnrBVGUaJiqe
	IbMX5PP3xdyqZG8C899M+RnL9+FVQI715KCYRhL1TzIZSk+jrfJ83Di3CZlRgUY2C9JN79HANKg
	ToRowsidlF7F9O5A==
X-Google-Smtp-Source: AGHT+IGL6d/Bnb4w2lmsKjgdb6AVcFSnWvfPhyiBt4Hqj7GOAjqk2+JskkwiYum6+UOIV5MTWdmo7g==
X-Received: by 2002:a05:6a20:431e:b0:2cd:fbcf:147f with SMTP id adf61e73a8af0-35a516a9b22mr11012015637.14.1763151210372;
        Fri, 14 Nov 2025 12:13:30 -0800 (PST)
Received: from localhost ([2a03:2880:ff:14::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375081023sm5559248a12.21.2025.11.14.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:13:29 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/4] Replace BPF memory allocator with kmalloc_nolock() in local storage
Date: Fri, 14 Nov 2025 12:13:22 -0800
Message-ID: <20251114201329.3275875-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patchset tries to simplify bpf_local_storage.c by adopting
kmalloc_nolock(). This removes memory preallocation and reduces the
dependency of smap in bpf_selem_free() and bpf_local_storage_free().
The later will simplify a future refactor that replaces
local_storage->lock and b->lock [1].

RFC v1 tried to switch to kmalloc_nolock() unconditionally. However,
as there is substantial performance loss in socket local storage due to
1) defer_free() in kfree_nolock() and 2) no kfree_rcu() batching,
replacing kzalloc() is postponed until necessary improvements in mm
land.

Benchmark

./bench -p 1 local-storage-create --storage-type <socket,task> \
  --batch-size <16,32,64>

The benchmark is a microbenchmark stress-testing how fast local storage
can be created. For task local storage, switching from BPF memory
allocator to kmalloc_nolock() yields a small amount of improvement. For
socket local storage, it remains roughly the same as nothing has changed.

Socket local storage
memory alloc     batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
kzalloc           16    144.149 ± 0.642k/s  3.10 kmallocs/create
(before)          32    144.379 ± 1.070k/s  3.08 kmallocs/create
                  64    144.491 ± 0.818k/s  3.13 kmallocs/create
                  
kzalloc           16    146.180 ± 1.403k/s  3.10 kmallocs/create  +1.4%
(not changed)     32    146.245 ± 1.272k/s  3.10 kmallocs/create  +1.3%
                  64    145.012 ± 1.545k/s  3.10 kmallocs/create  +0.4%
                   
Task local storage
memory alloc     batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
BPF memory        16     24.668 ± 0.121k/s  2.54 kmallocs/create
allocator         32     22.899 ± 0.097k/s  2.67 kmallocs/create
(before)          64     22.559 ± 0.076k/s  2.56 kmallocs/create
                  
kmalloc_nolock    16     25.796 ± 0.059k/s  2.52 kmallocs/create  +4.6%
(after)           32     23.412 ± 0.069k/s  2.50 kmallocs/create  +2.2%
                  64     23.717 ± 0.108k/s  2.60 kmallocs/create  +5.1%


[1] https://lore.kernel.org/bpf/20251002225356.1505480-1-ameryhung@gmail.com/


v1 -> v2
  - Only replace BPF memory allocator with kmalloc_nolock()
  Link: https://lore.kernel.org/bpf/20251112175939.2365295-1-ameryhung@gmail.com/

---

Amery Hung (4):
  bpf: Always charge/uncharge memory when allocating/unlinking storage
    elements
  bpf: Remove smap argument from bpf_selem_free()
  bpf: Save memory alloction info in bpf_local_storage
  bpf: Replace bpf memory allocator with kmalloc_nolock() in local
    storage

 include/linux/bpf_local_storage.h |  10 +-
 kernel/bpf/bpf_local_storage.c    | 235 +++++++++---------------------
 net/core/bpf_sk_storage.c         |   4 +-
 3 files changed, 74 insertions(+), 175 deletions(-)

-- 
2.47.3


