Return-Path: <netdev+bounces-84991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C45898DFA
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AE51C20CAB
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8212D214;
	Thu,  4 Apr 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ENLR582i"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AA1CA82;
	Thu,  4 Apr 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255586; cv=none; b=odimAWRGuYoYupmKNqJQ6Uxh6Nuw1f2XMaMBLLJa9AIEJgVBJ+lc8defiSP0ScunvOedl4kE795iTVp5kIhXnBC7X8QJeZLc/bKr3Fx6W6+ZuHYNWwzJSvq38lz7AJgPHehBtcDlJ3PM7/lrU8ljbKKzRXWbQtNK/MziDA7c0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255586; c=relaxed/simple;
	bh=qKJhLJ+OkI9jevLl4q88CLgM+UHJJ8Zp4B1Ddbf8k5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cl4Oy9kSAw9vqH3kEy9oS9Xt31gvSBq7uolclcNuTyLyDjlmKKVHwb1PtNRUEyLuQ3311c6RJDybklyoFj7yRFHSK0QG8aeOc17p6ZtxuKN85R82ZCc50mFcm2/wqLv4GXdVn9z1sxQZEIxE9zedXsSkvx+Fw1Xhz0sTnAKKMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ENLR582i; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=yNm7dbP3edq4ZSXrfjFFZl6GVvZvEhPMYhCjZZw9nBc=; b=ENLR582iq5Oe/tbUYQbbHTH3qF
	0oRBcjtIQUlTMUfaBH1dtP7/dg53Mp1zuK1qFM1b3Dgzz0hkwMs3RkAfgnJo5L+fA6FoS81iLNAeG
	7snwXJ3f2LAYCN6Tm6tQl/p8b7dZmwvhw4TBiVUOUoFkw2Xl48RUmmeLFtgsw+i0wNY5FLCoVfXQc
	eFFCMXhfdqhB3seWdLTerkNB30Fl/uHLdDCcVoT3c/Nq1Dl9jtLyHEh41S1p5Oh0AOuKzTZWP2kMR
	HVF1wxXSqay7duP/3JgD3vTpwdlEmL+6YJFHpRg9zgDbZ2TcdDFhz5TDuWstW46tuONuSvL6+4pqO
	L1AZlZDA==;
Received: from 14.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.14] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rsRtT-0001iz-G4; Thu, 04 Apr 2024 20:32:59 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf 2024-04-04
Date: Thu,  4 Apr 2024 20:32:58 +0200
Message-Id: <20240404183258.4401-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27235/Thu Apr  4 10:24:59 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 7 non-merge commits during the last 5 day(s) which contain
a total of 9 files changed, 75 insertions(+), 24 deletions(-).

The main changes are:

1) Fix x86 BPF JIT under retbleed=stuff which causes kernel panics due to
   incorrect destination IP calculation and incorrect IP for relocations,
   from Uros Bizjak and Joan Bruguera Micó.

2) Fix BPF arena file descriptor leaks in the verifier, from Anton Protopopov.

3) Defer bpf_link deallocation to after RCU grace period as currently running
   multi-{kprobes,uprobes} programs might still access cookie information from
   the link, from Andrii Nakryiko.

4) Fix a BPF sockmap lock inversion deadlock in map_delete_elem reported
   by syzkaller, from Jakub Sitnicki.

5) Fix resolve_btfids build with musl libc due to missing linux/types.h
   include, from Natanael Copa.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Greg Thelen, Ingo Molnar, Jiri Olsa, John Fastabend, Shung-Hsi Yu, Uros 
Bizjak, xingwei lee, Yonghong Song, yue sun

----------------------------------------------------------------

The following changes since commit 037965402a010898d34f4e35327d22c0a95cd51f:

  xen-netfront: Add missing skb_mark_for_recycle (2024-03-28 18:28:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to ff91059932401894e6c86341915615c5eb0eca48:

  bpf, sockmap: Prevent lock inversion deadlock in map delete elem (2024-04-02 16:31:05 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'x86-bpf-fixes-for-the-bpf-jit-with-retbleed-stuff'

Andrii Nakryiko (2):
      bpf: put uprobe link's path and task in release callback
      bpf: support deferring bpf_link dealloc to after RCU grace period

Anton Protopopov (1):
      bpf: fix possible file descriptor leaks in verifier

Jakub Sitnicki (1):
      bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Joan Bruguera Micó (1):
      x86/bpf: Fix IP for relocating call depth accounting

Natanael Copa (1):
      tools/resolve_btfids: fix build with musl libc

Uros Bizjak (1):
      x86/bpf: Fix IP after emitting call depth accounting

 arch/x86/include/asm/alternative.h |  4 ++--
 arch/x86/kernel/callthunks.c       |  4 ++--
 arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
 include/linux/bpf.h                | 16 +++++++++++++++-
 kernel/bpf/syscall.c               | 35 ++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c              |  3 +++
 kernel/trace/bpf_trace.c           | 10 +++++-----
 net/core/sock_map.c                |  6 ++++++
 tools/include/linux/btf_ids.h      |  2 ++
 9 files changed, 75 insertions(+), 24 deletions(-)

