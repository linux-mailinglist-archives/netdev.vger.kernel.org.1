Return-Path: <netdev+bounces-170299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6982A48142
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0397A7EE8
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2E8235BF8;
	Thu, 27 Feb 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fT7O/9qk"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C52309A3;
	Thu, 27 Feb 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666442; cv=none; b=ORYmBHqi4IXl5FYPxWnR35yTSsqYPtAOXNhf5D6R1on5ryrOjdVKssHBxjzE0p+zyABi0+pOMUcZ/8TItnjkunWHpKkxWdkI+yZ3rPiVNyGRSK6oRgdXjwRk9iApNNfkGoMmNSTrPjBvr2C5l8MDD1fSr0OO7juYttwjOrapDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666442; c=relaxed/simple;
	bh=3Q/8NY2SrIgt2b3sV8RIf9HNevVZp7vM9NtNBn8vW18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MpUPc7+wD9Wotx4q77XydLyowwwnRdd6rf0alaJmwfUp+JPd1OW39T21nq00qY5BULEsmtVmqt66zGvK0m/2uPrOE8Thsmsyao4kaG4thDFUKiP25bRpeJuiwh/05IQ5EGPypFTTcRCuQoqRRu0r+cW6x8GbyP7UP/Bd6/0kHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fT7O/9qk; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740666429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vs9vXYTdcS8F45fqup/G8Nl4E6Z/Osp2FFL8xUBkHDY=;
	b=fT7O/9qkV2csontrbjal4dBrdUn2fuA/E51mpyGMTGKF5TQBNR0BVOPH9FiLGXpBx/T+gl
	N5d4jh4RrSJIqLFHQBTOLWIwcSq5OqKhJn/9QKo3v4y/uCGg1EcHKwaBMNz+PfGR7rvdRB
	JML78qqhpaBOV+xCUkQq+dXdM7ZmAvE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v1 0/3] Optimize bpf selftest to increase CI success rate
Date: Thu, 27 Feb 2025 22:26:43 +0800
Message-ID: <20250227142646.59711-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

1. Optimized some static bound port selftests to avoid port occupation
when running test_progs -j.
2. Optimized the retry logic for test_maps.

Some Failed CI:
https://github.com/kernel-patches/bpf/actions/runs/13275542359/job/37064974076
https://github.com/kernel-patches/bpf/actions/runs/13549227497/job/37868926343
https://github.com/kernel-patches/bpf/actions/runs/13548089029/job/37865812030
https://github.com/kernel-patches/bpf/actions/runs/13553536268/job/37883329296
(Perhaps it's due to the large number of pull requests requiring CI runs?)

Jiayuan Chen (3):
  selftests/bpf: Allow auto port binding for cgroup connect
  selftests/bpf: Allow auto port binding for bpf nf
  selftests/bpf: Fixes for test_maps test

 tools/testing/selftests/bpf/prog_tests/bpf_nf.c     |  9 ++++++---
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c  | 13 +++++++++----
 .../testing/selftests/bpf/progs/connect4_dropper.c  |  4 +++-
 tools/testing/selftests/bpf/test_maps.c             |  9 +++++----
 4 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.47.1


