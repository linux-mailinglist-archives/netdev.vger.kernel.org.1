Return-Path: <netdev+bounces-78125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143AE874255
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BC81C22B58
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264231B81C;
	Wed,  6 Mar 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="qaIqxVtL"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E51BC4D;
	Wed,  6 Mar 2024 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762602; cv=none; b=khfAg7aXVEidHFrom16cQbE7CCshIqgrWa7Lf7YOugK7/qHMppvG5MtOFpVUw6PiedMnxNhZhVMh/0nTxCyZNEEtpKtIN5P5TFV/VwLWpCLszwLE09xNyIwvEaGP599y2SNwHDxm39LJFHYiCiC07p208NCwcAo2LnhxgFZt3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762602; c=relaxed/simple;
	bh=TFsKezRzawhE7oOuTAWfh/dOyK8yTCLaCq4+gB2KP54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=COhJBANIofqiOH5I5pGmXLri/5mDc9ce5ijTnvfk+/EKwtweZG3aEqEUusyX7XMkA47rWJyWi9ZVjySYlQr1E6Sk9HemGaguOLkJf7Pgtma9OFjmqg45DPBWG0plk27z9Pctv6GQe/j0ZsJ3Ng0krWtuRZvptl6YQhM9+iDa+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=qaIqxVtL; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=oaf7D/ZljYFWOfK3n7Vi9B4TQYH1WWFNt+ruoPy675o=; b=qaIqxVtLmUIewsUv3JEeGcXdE+
	LNPteFVS3IAnUPKMrkXV8e0KlRgvBLt887co1xiCAs6xCtvOnUMYNdbyrO1oHVyloOZUvyGQt62yW
	yN1X4lDoQ/wmWwi3iPGSzySgj2gzSONsY7dttfZ1hRcqY/SeD9i0nCeq69JcnQzXSHqYO9c5BpZDq
	61guAnvWkhSUy/heaeoRSEB3eEWlzYR7VAqzn8fod2Emt/s0xhejdXOf+mu16g8EUnEhs2ZcxviNl
	Fcf4Sii5NlU2pOayNzUFvNQAOsn/eSo4b3JcyBqQ1SzHK42GolIqWemaxwPgqk82ZY0336gCHULIH
	x4Z7qQRw==;
Received: from 11.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.11] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rhzLy-000DZU-DL; Wed, 06 Mar 2024 23:03:10 +0100
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
Subject: pull-request: bpf 2024-03-06
Date: Wed,  6 Mar 2024 23:03:09 +0100
Message-Id: <20240306220309.13534-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27206/Wed Mar  6 10:25:15 2024)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net* tree.

We've added 5 non-merge commits during the last 1 day(s) which contain
a total of 5 files changed, 77 insertions(+), 4 deletions(-).

The main changes are:

1) Fix BPF verifier to check bpf_func_state->callback_depth when pruning
   states as otherwise unsafe programs could get accepted, from Eduard Zingerman.

2) Fix to zero-initialise xdp_rxq_info struct before running XDP program in
   CPU map which led to random xdp_md fields, from Toke Høiland-Jørgensen.

3) Fix bonding XDP feature flags calculation when bonding device has no
   slave devices anymore, from Daniel Borkmann.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Tobias Böhm, Toke Høiland-Jørgensen, Yonghong Song

----------------------------------------------------------------

The following changes since commit 685f7d531264599b3f167f1e94bbd22f120e5fab:

  net/ipv6: avoid possible UAF in ip6_route_mpath_notify() (2024-03-05 11:16:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev

for you to fetch changes up to 2487007aa3b9fafbd2cb14068f49791ce1d7ede5:

  cpumap: Zero-initialise xdp_rxq_info struct before running XDP program (2024-03-05 16:48:53 -0800)

----------------------------------------------------------------
bpf-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'check-bpf_func_state-callback_depth-when-pruning-states'

Daniel Borkmann (2):
      xdp, bonding: Fix feature flags when there are no slave devs anymore
      selftests/bpf: Fix up xdp bonding test wrt feature flags

Eduard Zingerman (2):
      bpf: check bpf_func_state->callback_depth when pruning states
      selftests/bpf: test case for callback_depth states pruning logic

Toke Høiland-Jørgensen (1):
      cpumap: Zero-initialise xdp_rxq_info struct before running XDP program

 drivers/net/bonding/bond_main.c                    |  2 +-
 kernel/bpf/cpumap.c                                |  2 +-
 kernel/bpf/verifier.c                              |  3 +
 .../testing/selftests/bpf/prog_tests/xdp_bonding.c |  4 +-
 .../bpf/progs/verifier_iterating_callbacks.c       | 70 ++++++++++++++++++++++
 5 files changed, 77 insertions(+), 4 deletions(-)

