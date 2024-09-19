Return-Path: <netdev+bounces-128958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C82B97C969
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 14:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909DFB213C0
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505119DF82;
	Thu, 19 Sep 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WmVYim2V"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A319D09A;
	Thu, 19 Sep 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749798; cv=none; b=SluN+MhAgtN0NXPoOCljQwd2Y5HieaqiGPhLBH+qIjfzOMmOBm6tMFWVGQKRByMDA5UENKL73qpnbR6oPEKIulA/OXmQ9nzqTN19ykuI0bmQJdElumnf0BhJc8jillWvp5qBvNvguhpwibXoAUTfxxBok0cUYJb3gxcWf9YijHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749798; c=relaxed/simple;
	bh=vkh4Ay1zTY0iiLAWWorMyVZYwhLbNU2d8zepOPEOkaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G399hoLVcyzUUzmSxBs922DhGoewfiHq95I4uO9p3kTESQZ8Tv9dOI/+m+YzdrmJpsv7EIaArk6DIPNoDqsewSkTeG8Y07YUrMp8gHfIahz8LWgWfEokT+h0CLiHsCJwsNgQBuenjDR5iCQYO+9+fioYatqwJUx8/p+IQTXFAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=WmVYim2V; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726749791;
	bh=+4ltGAVEzrHoagPXKaFdfBj/AJkWKcAhVfPM62hcyyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WmVYim2V/4PUaKRq9MRgUC5zdyhXQ7tSQ76it7dTsMSEQUwtKtK/WvohX6DyAmMcN
	 D1GaGr5ck9B/RLLLjojYdILfGiwUkiAc42xY31sJVuIgu1iCDSB5Ne8WoV0jLCqI8d
	 zrQVH2/E8wHrzeL472ZLIgKvcRebtNP0/pDHSIeMrOMs1K3UHnNiSWWyaDfov92n6B
	 nX+72Kkyna45gtpiXraRHWX8dA2MM2VAD3/mATghE5+9YSoGPDZR+jxbVLBJfj7SYt
	 +PZlFeirujvDyDFZLcpTy+hpNAk8k+YbLWlsrFQSPy8kfZwx9aUoN4J9MxpblfUpCb
	 Cm5dILFZG65Ug==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X8Ztl2z32z4wb5;
	Thu, 19 Sep 2024 22:43:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
 sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, almasrymina@google.com, kuba@kernel.org
Subject: Re: [PATCH] powerpc/atomic: Use YZ constraints for DS-form
 instructions
In-Reply-To: <20240917073750.GZ29862@gate.crashing.org>
References: <20240916120510.2017749-1-mpe@ellerman.id.au>
 <20240917073750.GZ29862@gate.crashing.org>
Date: Thu, 19 Sep 2024 22:43:10 +1000
Message-ID: <87o74jrezl.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Segher Boessenkool <segher@kernel.crashing.org> writes:
> Hi!
>
> On Mon, Sep 16, 2024 at 10:05:10PM +1000, Michael Ellerman wrote:
>> The 'ld' and 'std' instructions require a 4-byte aligned displacement
>> because they are DS-form instructions. But the "m" asm constraint
>> doesn't enforce that.
>> 
>> That can lead to build errors if the compiler chooses a non-aligned
>> displacement, as seen with GCC 14:
>> 
>>   /tmp/ccuSzwiR.s: Assembler messages:
>>   /tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is not a multiple of 4)
>>   make[5]: *** [scripts/Makefile.build:229: net/core/page_pool.o] Error 1
>> 
>> Dumping the generated assembler shows:
>> 
>>   ld 8,39(8)       # MEM[(const struct atomic64_t *)_29].counter, t
>> 
>> Use the YZ constraints to tell the compiler either to generate a DS-form
>> displacement, or use an X-form instruction, either of which prevents the
>> build error.
>
> Great explanation text, a perfect commit!  :-)

Thanks - I'm sure there's something that could be better, but I do try :)

cheers

