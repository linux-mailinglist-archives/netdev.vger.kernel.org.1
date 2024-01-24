Return-Path: <netdev+bounces-65628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3117D83B305
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12AC1F235F2
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5EC133983;
	Wed, 24 Jan 2024 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyrtfEy+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567A13343E
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128208; cv=none; b=KM35tcEtSMmGMRCIC7zyPcmkUd0rUPN3i1B0j7xNNT85KnOl9S8wMTvK3uAQMNwvtTz2mY/vVQRK24PN2+vS7lYfX6R0y6eewDHi0DLqE5oAXpycP5vbSjlYhoNPF+riiCUjq+jpg8ZsZoJVv/kt96uznDMDT/SH6zT9lpcNOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128208; c=relaxed/simple;
	bh=P6Ex6YkaWupwZCGrALKw4OGrciXcv4jlaXQOcdB22Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSTy5q2cdV42YEG16DEPkmjp55ugu0qtnaJ/83Dfgp4tgomp93fknFJtiWtCH5Groqb8Dz36OewbEMoxpddxAEfCHOBTj9LZrk8nEbWFBGl+ioKjrgomJTddslG4jnENumRYm95r16Mb5B88K3DYrxhJcg2tRN62wxBj2uCPAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyrtfEy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15F7C433F1;
	Wed, 24 Jan 2024 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706128208;
	bh=P6Ex6YkaWupwZCGrALKw4OGrciXcv4jlaXQOcdB22Z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QyrtfEy+jdbAAm/R8QrhRhnGPMJaJd4cwOWjrlzNBplowyB+qByth96EVyfUdE+4b
	 CXjCN0lyWfariMJ3jJ168vzaDsh+1/rAU1GvfSS+qGwU91L+pUTyqzu+KIWKT7mnnh
	 r/I6rBzI8U4iTyDiD9nvBbRLbtvbFwfVYAcUoJgBELnLurINFf9StHGIyvUQR+8tJV
	 kAWH9ddfOh9avWuMmq03TQLwZe/PCGInwnf5frZVLbAswrLweHKeZiCq66bFzJU3ps
	 +/slXzzv0zKkfpoMIVPJZuGW5z7EsgyrqhjbBJwkBrzRQUL9QTCsy0ibM4aRg1zz6b
	 xvUEduEcKSGIg==
Date: Wed, 24 Jan 2024 12:30:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Guo <heng.guo@windriver.com>, David Ahern <dsahern@gmail.com>
Cc: Vitezslav Samel <vitezslav@samel.cz>, netdev@vger.kernel.org
Subject: Re: [6.6.x REGRESSION][BISECTED] dev_snmp6: broken Ip6OutOctets
 accounting for forwarded IPv6 packets
Message-ID: <20240124123006.26bad16c@kernel.org>
In-Reply-To: <ZauRBl7zXWQRVZnl@pc11.op.pod.cz>
References: <ZauRBl7zXWQRVZnl@pc11.op.pod.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks for the analysis, Vitezslav!

Heng Guo, David, any thoughts on this? Revert?

On Sat, 20 Jan 2024 10:23:18 +0100 Vitezslav Samel wrote:
> 	Hi!
> 
> In short:
> 
>   since commit e4da8c78973c ("net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated")
> the "Ip6OutOctets" entry of /proc/net/dev_snmp6/<interface> isn't
> incremented by packet size for outbound forwarded unicast IPv6 packets.
> 
> 
> In more detail:
> 
>   After move from kernel 6.1.y to 6.6.y I was surprised by very low IPv6 to
> IPv4 outgoing traffic ratio counted from /proc/net/... counters on our linux
> router. In this simple scenario:
> 
> 	NET1  <-->  ROUTER  <-->  NET2
> 
>   the entry Ip6OutOctets of ROUTER's /proc/net/dev_snmp6/<interface> was
> surprisingly low although the IPv6 traffic between NET1 and NET2 is rather
> huge comparing to IPv4 traffic. The bisection led me to commit e4da8c78973c.
> After reverting it, the numbers went to expected values.
> 
>   Numbers for local outbound IPv6 seems correct, as well as numbers for IPv4.
> 
>   Since the commit patches both IPv4 and IPv6 reverting it doesn't seem like
> the right thing to do. Can you, please, look at it and cook some fix?
> 
> 	Thanks,
> 
> 		Vita
> 
> #### git bisect log
> 
> git bisect start '--' 'include' 'net'
> # status: waiting for both good and bad commits
> # good: [fb2635ac69abac0060cc2be2873dc4f524f12e66] Linux 6.1.62
> git bisect good fb2635ac69abac0060cc2be2873dc4f524f12e66
> # status: waiting for bad commit, 1 good commit known
> # bad: [5e9df83a705290c4d974693097df1da9cbe25854] Linux 6.6.9
> git bisect bad 5e9df83a705290c4d974693097df1da9cbe25854
> # good: [830b3c68c1fb1e9176028d02ef86f3cf76aa2476] Linux 6.1
> git bisect good 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> # good: [6e98b09da931a00bf4e0477d0fa52748bf28fcce] Merge tag 'net-next-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect good 6e98b09da931a00bf4e0477d0fa52748bf28fcce
> # good: [9b39f758974ff8dfa721e68c6cecfd37e6ddb206] Merge tag 'nf-23-07-20' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
> git bisect good 9b39f758974ff8dfa721e68c6cecfd37e6ddb206
> # good: [38663034491d00652ac599fa48866bcf2ebd7bc1] Merge tag 'fsnotify_for_v6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
> git bisect good 38663034491d00652ac599fa48866bcf2ebd7bc1
> # good: [7ba2090ca64ea1aa435744884124387db1fac70f] Merge tag 'ceph-for-6.6-rc1' of https://github.com/ceph/ceph-client
> git bisect good 7ba2090ca64ea1aa435744884124387db1fac70f
> # bad: [ea1cc20cd4ce55dd920a87a317c43da03ccea192] Merge tag 'v6.6-rc7.vfs.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
> git bisect bad ea1cc20cd4ce55dd920a87a317c43da03ccea192
> # bad: [b938790e70540bf4f2e653dcd74b232494d06c8f] Bluetooth: hci_codec: Fix leaking content of local_codecs
> git bisect bad b938790e70540bf4f2e653dcd74b232494d06c8f
> # bad: [6912e724832c47bb381eb1bd1e483ec8df0d0f0f] net/smc: bugfix for smcr v2 server connect success statistic
> git bisect bad 6912e724832c47bb381eb1bd1e483ec8df0d0f0f
> # bad: [c3b704d4a4a265660e665df51b129e8425216ed1] igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
> git bisect bad c3b704d4a4a265660e665df51b129e8425216ed1
> # bad: [82ba0ff7bf0483d962e592017bef659ae022d754] net/handshake: fix null-ptr-deref in handshake_nl_done_doit()
> git bisect bad 82ba0ff7bf0483d962e592017bef659ae022d754
> # bad: [dc9511dd6f37fe803f6b15b61b030728d7057417] sctp: annotate data-races around sk->sk_wmem_queued
> git bisect bad dc9511dd6f37fe803f6b15b61b030728d7057417
> # good: [7e9be1124dbe7888907e82cab20164578e3f9ab7] netfilter: nf_tables: Audit log setelem reset
> git bisect good 7e9be1124dbe7888907e82cab20164578e3f9ab7
> # bad: [4e60de1e4769066aa9956c83545c8fa21847f326] Merge tag 'nf-23-08-31' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
> git bisect bad 4e60de1e4769066aa9956c83545c8fa21847f326
> # bad: [e4da8c78973c1e307c0431e0b99a969ffb8aa3f1] net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated
> git bisect bad e4da8c78973c1e307c0431e0b99a969ffb8aa3f1
> # first bad commit: [e4da8c78973c1e307c0431e0b99a969ffb8aa3f1] net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated
> 
> 


