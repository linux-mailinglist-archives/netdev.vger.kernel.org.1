Return-Path: <netdev+bounces-82697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69B988F48C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 02:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78060299DCC
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 01:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D749617550;
	Thu, 28 Mar 2024 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckhifJt8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE53368;
	Thu, 28 Mar 2024 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589385; cv=none; b=Ila4FHJ+Bm9xidHCXaSS7ai5cMGReYbqqQkb/6V7TafVQsrys8BZ8g0os6KMuSFSThE9UZ+3YrNuFNb5NJDJAaTW7aAaLAhHe/pg2T93w++RWGSF8eSN4XTc8NBflI45KNoGDVZ225tl8xQQN6oRkmjgaATG2gos1I3Ehb9FXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589385; c=relaxed/simple;
	bh=GjZawt6xoy98e3Xp/Y+236Wtagn1P4gXHsS7RC+0S60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dLxRI2gW84wnsQPvbzaAwSTvcxGKuA3cSIMWkaIplI2ESzEZ+knkN/AueEkBLEylQEhK1VrSg0S/yVTMa5+Zl3J7fctgW3r43pglyIcl3FR7yslVRMCZvkrCbBntgytoftJu0/n4nXp30rT02rjQT6xuKoC86PbEYtrGTOJ8Z4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckhifJt8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so1024838b3a.1;
        Wed, 27 Mar 2024 18:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589384; x=1712194184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnr6mD1K3zXgGPE0SDwjtoTMxIipbCVjzzKQw/uc1b8=;
        b=ckhifJt8cASI+G1pXT21xBoEh+7o/cGGEVkNOfWByEYSKPxVItTNTxRkqEkN/6Ck3M
         MoWKDbhnqmXAzQpbP53oG3X6YPFZTr6oTZm5YKNy07gXmqejkI0HUZoOc88Rd0EkmChH
         MrHLzUJtb+4XDUtfs9141kuz/rO9qNtam3+nzPt5apGw0Uuiyn178EQc3wNSmqgeE/t+
         bcU559ZQ0vZDhQW2znZYnZpwW1qmTGGmdujmuy7Iso6kbQQk+FR1o+dA+98nFGOi4jVA
         SrwWMAS+Jb2dXlH31NQfqn9U+NOQMUdRfNan2OIPFjGNituk2WN8AcTVUXMJDuUN1zUv
         Z7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589384; x=1712194184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnr6mD1K3zXgGPE0SDwjtoTMxIipbCVjzzKQw/uc1b8=;
        b=GiM4bJoxFCpc+aqlIgdSwCNqyz2t2efo9GVOY2hC+hTUv/cEsmRp227POMgFTunPHV
         2QZ6OjADkXnvz3Ktl+BbI1ij1prXm7tMxJkPM8dV7/t+myKCUaoCNAx/cleAYwjz94AK
         54D8L9P8xeMpPjg6yMLDyBgOdyOfv1wbYg6GSXuupdSBIt6PVhfGcesQ24dbOQjtS0Jd
         W2E2uqJKVF0nuvoG/U55xLUa4fIrBXgNLjqsZ1Snm2FryOfujUzmOvNAYz2j8iKiUS85
         XtHzQPec745s0hEZR63M0dgyKWZYrHIuYEDBzjilwLsY7SXnWOkoIXnCh9RQpC91CIay
         2yFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF2TOGwizXDpl7zTbyxtq5YoaDjTVXSx9KC41EXy7fMSoOBsHv9yXjRvLljFAVpfcOpors5fWP7vfsan3p+sLHftimVhNgOZFkyc9cWNeBoOVejyFEI5ncV5LV
X-Gm-Message-State: AOJu0YxL3GnuVkDdA9SfJjH80K4ZqZMJkR3A8wQoMQdw1EECylcT6qfc
	027QGbQfvTNG+FAiqiNydGewCUfF4f8UdTh336+shkKaFT3Fy5GM
X-Google-Smtp-Source: AGHT+IFECPtMYMPkz/XyDf2wvLowijIT5I7aeAW6f+9oJSADgOj1T6V6Mlh2GFflyTvYOC1wApR58w==
X-Received: by 2002:a17:902:da85:b0:1e0:e85c:72dc with SMTP id j5-20020a170902da8500b001e0e85c72dcmr1439310plx.19.1711589382252;
        Wed, 27 Mar 2024 18:29:42 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:21bc])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902694500b001e038619e34sm187995plt.221.2024.03.27.18.29.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Mar 2024 18:29:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: pull-request: bpf 2024-03-27
Date: Wed, 27 Mar 2024 18:29:38 -0700
Message-Id: <20240328012938.24249-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 4 non-merge commits during the last 1 day(s) which contain
a total of 5 files changed, 26 insertions(+), 3 deletions(-).

The main changes are:

1) Fix bloom filter value size validation and protect the verifier
   against such mistakes, from Andrei.

2) Fix build due to CONFIG_KEXEC_CORE/CRASH_DUMP split, from Hari.

3) Update bpf_lsm maintainers entry, from Matt.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-net

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Baoquan He, Jiri Olsa, KP Singh, Stanislav Fomichev

----------------------------------------------------------------

The following changes since commit afbf75e8da8ce8a0698212953d350697bb4355a6:

  selftests: netdevsim: set test timeout to 10 minutes (2024-03-27 11:29:27 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-net

for you to fetch changes up to 4dd651076ef0e5f09940f763a1b4e8a209dab7ab:

  bpf: update BPF LSM designated reviewer list (2024-03-27 11:10:36 -0700)

----------------------------------------------------------------
for-net

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'check-bloom-filter-map-value-size'

Andrei Matei (2):
      bpf: Check bloom filter map value size
      bpf: Protect against int overflow for stack access size

Hari Bathini (1):
      bpf: fix warning for crash_kexec

Matt Bobrowski (1):
      bpf: update BPF LSM designated reviewer list

 MAINTAINERS                                               |  3 +--
 kernel/bpf/bloom_filter.c                                 | 13 +++++++++++++
 kernel/bpf/helpers.c                                      |  2 +-
 kernel/bpf/verifier.c                                     |  5 +++++
 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c |  6 ++++++
 5 files changed, 26 insertions(+), 3 deletions(-)

