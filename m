Return-Path: <netdev+bounces-128649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB6297AABF
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 06:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2AE1F277F8
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 04:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBDB2B9B3;
	Tue, 17 Sep 2024 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="IaI+3H6y"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E827473;
	Tue, 17 Sep 2024 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726547725; cv=none; b=sL6p7sk6OtHNI3uH4dXxwCLEHeYAZAY00M9Z08YEk8ck0fF/wg11E949mnT6YkSV6/yORqdfw+RQNF3Z1v4X00xErMllZ46fIxL8UY9tRFITASpJLaK56Hys9lRctZ/0CONjG1diDKb71RVLz2YX2e3hpbZCbY8t0x51p4P+OOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726547725; c=relaxed/simple;
	bh=zcmrsAFC9N4othckacgvwEsP8/w4Dba+dViA+9RwF+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I1PAqkI1LXkVVQD8FbwhPMB6UY2W64X23GA110I+EnCjdAs8U/03ORS3i0bnPWdDxGpxj6fcJySRnkruUrPAb5hqcxK0Z8rMVQl7BktSYVJNeFwNAvPrz9hE9BwuUsimJENQYEaWPFocbMM4YpfaqIcfh/4u3nCVTzGrxZ57gzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=IaI+3H6y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726547719;
	bh=IUEa298+/HnSGhVzOT26xrNR64cr3qT+KBkosyliq2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IaI+3H6ys+fmP41dMTuJyHVoH7u4Qj7Xw3zVhhBSQs9jLFZeo+ep7lMgHu4jaec7T
	 OLJD9DgD75YUc+PBZLbv1wowf49AII0+Qf7wF+s1uQg6oNYzMvg7rMHroPPE+0EfRS
	 AhEBVyb3GIrmck9wYgs+u0CrKwzQCwILDFajlvfyOYZ2ygVnwcG0Zb25NXboMb3lhV
	 AvhuN31qcOF4BcIusJcf/JzauI//CC+BqjpThqeoBtX7No6TzpeKrWvlvzfTKAoyS5
	 q7RqaL2B4lazVZrsfGPmQJ1iDyJ1bUEu3YPGPctN1uAP2NCIJfEgCvNvqktvVisH5p
	 CZBDkNo8yFEOg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X788l4wjyz4xZZ;
	Tue, 17 Sep 2024 14:35:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mina Almasry <almasrymina@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
 segher@kernel.crashing.org, sfr@canb.auug.org.au,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH] powerpc/atomic: Use YZ constraints for DS-form
 instructions
In-Reply-To: <CAHS8izM-3DSw+hvFasu=xge5st9cE9MrwJ3FOOHpYHsj5r0Ydg@mail.gmail.com>
References: <20240916120510.2017749-1-mpe@ellerman.id.au>
 <CAHS8izM-3DSw+hvFasu=xge5st9cE9MrwJ3FOOHpYHsj5r0Ydg@mail.gmail.com>
Date: Tue, 17 Sep 2024 14:35:17 +1000
Message-ID: <878qvqrj7e.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:
> On Mon, Sep 16, 2024 at 5:05=E2=80=AFAM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
>>
>> The 'ld' and 'std' instructions require a 4-byte aligned displacement
>> because they are DS-form instructions. But the "m" asm constraint
>> doesn't enforce that.
>>
>> That can lead to build errors if the compiler chooses a non-aligned
>> displacement, as seen with GCC 14:
>>
>>   /tmp/ccuSzwiR.s: Assembler messages:
>>   /tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is not a multip=
le of 4)
>>   make[5]: *** [scripts/Makefile.build:229: net/core/page_pool.o] Error 1
>>
>> Dumping the generated assembler shows:
>>
>>   ld 8,39(8)       # MEM[(const struct atomic64_t *)_29].counter, t
>>
>> Use the YZ constraints to tell the compiler either to generate a DS-form
>> displacement, or use an X-form instruction, either of which prevents the
>> build error.
>>
>> See commit 2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with
>> GCC 13/14") for more details on the constraint letters.
>>
>> Fixes: 9f0cbea0d8cc ("[POWERPC] Implement atomic{, 64}_{read, write}() w=
ithout volatile")
>> Cc: stable@vger.kernel.org # v2.6.24+
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Closes: https://lore.kernel.org/all/20240913125302.0a06b4c7@canb.auug.or=
g.au
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> I'm not familiar enough with the code around the changes, but I have
> been able to confirm cherry-picking this resolves the build issue I'm
> seeing on net-next, so, FWIW,
>
> Tested-by: Mina Almasry <almasrymina@google.com>

Thanks.

cheers

