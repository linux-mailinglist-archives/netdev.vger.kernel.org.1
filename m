Return-Path: <netdev+bounces-49282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E997F17DD
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0106B282714
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFDF1DDEA;
	Mon, 20 Nov 2023 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AJ8R0APo"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F3FB4;
	Mon, 20 Nov 2023 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MZyP9bbN2OhFmaCO48JjdH05j95W9qWzKHyC/r9shIA=; b=AJ8R0APoE3kvguae/t7BRpSBMx
	CbYGmu5Fck97KBn9bNsfBC/0axTNbqoXuhPbuH3owW4KH2Tj3hpjWvP0ZJuXGmgo2hoV8mw2Z2GKK
	9UcjURzUH8ViNZr/kAh4OJQSdtGinFLoIhZy+RLK/0LpEYf2czxFxlWSsJWzjcTOF627S2Vk/is7C
	H0Y+uXehusnOrffASCN/8v/dNbj0roeAthhOWeakUv27dUwPB7Fi8nVK6K6rDzheSgqoRuNPxeMoa
	oY1eUM456tHJ58poVvkLUmZNl8QRxoPypM8BNJBMCLc7QhGAhnKHTHe16kR/UNsXimxuaZw0KDyWZ
	z8+52VYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r56Z8-00B1Hd-1z;
	Mon, 20 Nov 2023 15:52:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 444DF300419; Mon, 20 Nov 2023 16:52:01 +0100 (CET)
Message-Id: <20231120144642.591358648@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 20 Nov 2023 15:46:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Cc: paul.walmsley@sifive.com,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com,
 davem@davemloft.net,
 dsahern@kernel.org,
 ast@kernel.org,
 daniel@iogearbox.net,
 andrii@kernel.org,
 martin.lau@linux.dev,
 song@kernel.org,
 yonghong.song@linux.dev,
 john.fastabend@gmail.com,
 kpsingh@kernel.org,
 sdf@google.com,
 haoluo@google.com,
 jolsa@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 samitolvanen@google.com,
 keescook@chromium.org,
 nathan@kernel.org,
 ndesaulniers@google.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,
 jpoimboe@kernel.org,
 joao@overdrivepizza.com,
 mark.rutland@arm.com
Subject: [PATCH 0/2] x86/bpf: Fix FineIBT vs eBPF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Hi!

There's a problem with FineIBT and eBPF using __nocfi when
CONFIG_BPF_JIT_ALWAYS_ON=n, in which case the __nocfi indirect call can target
a normal function like __bpf_prog_run32().

Specifically the various preambles look like:

   FineIBT				JIT

   __cfi_foo:
      endbr64
      subl	$hash, %r10d
      jz	1f
      ud2
   1: nop
   foo:					foo:
      osp nop3				   endbr64
      ...				   ...

So while bpf_dispatcher_*_func() does a __nocfi call to foo()+0 and this
matches what the JIT generates, it does not work for regular FineIBT functions,
since their +0 endbr got poisoned and things go *boom*.

Cure this by teaching the BPF JIT about all the various CFI forms. Notably this
removes the last __nocfi call on x86.

If the BPF folks agree (and the robots don't find fail) I'd like to take this
through the x86 tree, because I have a few more patches that turn the non-fatal
'osp nop3' poison into a 4 byte ud1 instruction which is rather fatal. As a
result this problem will also surface on !IBT hardware.


