Return-Path: <netdev+bounces-103727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F090936D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985D41C23643
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987D918FC65;
	Fri, 14 Jun 2024 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="myTAzNPC"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132CB14A4CF;
	Fri, 14 Jun 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718397157; cv=none; b=IZ/ofQk9OkCxZX8O01/O0z1M0jJA+bdO3hmT2fRtc7R1NEaV7TEHBwwV06p6txIC+2VswVYDV/+WGGSUAWENHxTn0wxb9HysraUlvF4/1JRebr1gdl494ONhGn61LvS89UqlANzVrCHUX8wIHGGWuhcKRgO6/K11hGoiyg/tQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718397157; c=relaxed/simple;
	bh=L1VZqixVpico4OrBQvGOWbsgyvmCSJfZmLShYcCWJqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dj4vD5nHiw25tWxP7fFDgwltI2Y8iqQRCwY/nyY6INozUoYw5s3A9EeclrhOp8rFh9/iwL4BFFabxZV8e8kmuVnDjx5jf/6eDwn7GaXIyq000zNdnCUfhxMu+I7aNX/QnQBaOguubDZxhpEvleFVrcMJsLfnjEZreNUq8g5LcVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=myTAzNPC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=+HCNZSA4iRcGEvPYHEr/y1MovqU3OVbhI37ShOMMN+4=; b=myTAzNPCVzd2RinBJxJjSozlIb
	bldQOcxyhbv2/4+7WJk0pyqhq/DIkVAfH89rvVkxgGBW5Yx4Zoc14EswfxwSyJPWw73pAvn8Nsrfe
	TjEFOl2uhGIjO/Cwd0J4rdv1QbDQG1MylJmQHLvL388JVC0k66LHM6Of12QUuODLkSwkfx2H9B9Eq
	3m1TBc7VCandNTFXHxIJX38y4tZv5HSx3AdYcq0X+eW3Q+4jy4MJKwKCLH+tapLecnV0lfwwsz+sP
	LyYC0vHbwwBSmtKzFw2khhyYEHKWGrps9p9VXF8ppskEdCuIrJLPp5+nDQfatA1W9C0hXJn0tDMp8
	o2phj75Q==;
Received: from 17.249.197.178.dynamic.cust.swisscom.net ([178.197.249.17] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sIDay-0004p2-If; Fri, 14 Jun 2024 22:32:24 +0200
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
Subject: pull-request: bpf 2024-06-14
Date: Fri, 14 Jun 2024 22:32:23 +0200
Message-Id: <20240614203223.26500-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27306/Fri Jun 14 10:28:44 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 8 non-merge commits during the last 2 day(s) which contain
a total of 9 files changed, 92 insertions(+), 11 deletions(-).

The main changes are:

1) Silence a syzkaller splat under CONFIG_DEBUG_NET=y in pskb_pull_reason()
   triggered via __bpf_try_make_writable(), from Florian Westphal.

2) Fix removal of kfuncs during linking phase which then throws a kernel build
   warning via resolve_btfids about unresolved symbols, from Tony Ambardar.

3) Fix a UML x86_64 compilation failure from BPF as pcpu_hot symbol is not
   available on User Mode Linux, from Maciej Żenczykowski.

4) Fix a register corruption in reg_set_min_max triggering an invariant
   violation in BPF verifier, from Daniel Borkmann.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Daniel Borkmann, Eric Dumazet, Jiri Olsa, John Fastabend, Juan José 
López Jaimez, kernel test robot

----------------------------------------------------------------

The following changes since commit 14a20e5b4ad998793c5f43b0330d9e1388446cf3:

  net/ipv6: Fix the RT cache flush via sysctl using a previous delay (2024-06-12 17:51:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 7bdcedd5c8fb88e7176b93812b139eca5fe0aa46:

  bpf: Harden __bpf_kfunc tag against linker kfunc removal (2024-06-14 19:14:37 +0200)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Daniel Borkmann (3):
      bpf: Fix reg_set_min_max corruption of fake_reg
      bpf: Reduce stack consumption in check_stack_write_fixed_off
      selftests/bpf: Add test coverage for reg_set_min_max handling

Florian Westphal (1):
      bpf: Avoid splat in pskb_pull_reason

Maciej Żenczykowski (1):
      bpf: fix UML x86_64 compile failure

Stanislav Fomichev (1):
      MAINTAINERS: mailmap: Update Stanislav's email address

Tony Ambardar (2):
      compiler_types.h: Define __retain for __attribute__((__retain__))
      bpf: Harden __bpf_kfunc tag against linker kfunc removal

 .mailmap                                           |  1 +
 MAINTAINERS                                        |  2 +-
 include/linux/bpf_verifier.h                       |  2 ++
 include/linux/btf.h                                |  2 +-
 include/linux/compiler_types.h                     | 23 ++++++++++++
 kernel/bpf/verifier.c                              | 25 ++++++++-----
 net/core/filter.c                                  |  5 +++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  2 ++
 .../selftests/bpf/progs/verifier_or_jmp32_k.c      | 41 ++++++++++++++++++++++
 9 files changed, 92 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c

