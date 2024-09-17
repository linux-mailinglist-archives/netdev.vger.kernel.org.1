Return-Path: <netdev+bounces-128665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B2D97ACA0
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 10:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDC528C88D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5F15699D;
	Tue, 17 Sep 2024 08:11:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3C61FCE;
	Tue, 17 Sep 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560701; cv=none; b=GCE9ac1OGJhgL3Yn4uLkVndAt9/0r9cXGezYBNuMvqWq4mAHyZmcMrgxRQ3UEfb0yimAt4s58rekbVfynvftZTkDzyWfcGJWfVSQGaOA6wUQz+w2W3Q9/rZT/h29dJIZ2MRCm3ka5ZIxbhVtr6cjBEoWdKSes+bblDP84fFF+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560701; c=relaxed/simple;
	bh=AyfUySwOi7sTbJtZyiiODBIT8ZblI+EL8ThHaGv2Qic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcxxSv1i34csHoB9Ij5/ftm6xBIMQxwDgmPIHHmpu2byREyup44x1x7GOk558AIyU81ap6+8A7A01XNdvSEFlH/3AaWXvfiLQlaHRC9OaNdpinslMnWYpPJi1dye7J6viEIjwPwIShcb48MOiW2vqcf8uvVEPbuNCmwCrQfLEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 48H7bs3P021626;
	Tue, 17 Sep 2024 02:37:54 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 48H7bpcE021625;
	Tue, 17 Sep 2024 02:37:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 17 Sep 2024 02:37:50 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, almasrymina@google.com, kuba@kernel.org
Subject: Re: [PATCH] powerpc/atomic: Use YZ constraints for DS-form instructions
Message-ID: <20240917073750.GZ29862@gate.crashing.org>
References: <20240916120510.2017749-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916120510.2017749-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.4.2.3i

Hi!

On Mon, Sep 16, 2024 at 10:05:10PM +1000, Michael Ellerman wrote:
> The 'ld' and 'std' instructions require a 4-byte aligned displacement
> because they are DS-form instructions. But the "m" asm constraint
> doesn't enforce that.
> 
> That can lead to build errors if the compiler chooses a non-aligned
> displacement, as seen with GCC 14:
> 
>   /tmp/ccuSzwiR.s: Assembler messages:
>   /tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is not a multiple of 4)
>   make[5]: *** [scripts/Makefile.build:229: net/core/page_pool.o] Error 1
> 
> Dumping the generated assembler shows:
> 
>   ld 8,39(8)       # MEM[(const struct atomic64_t *)_29].counter, t
> 
> Use the YZ constraints to tell the compiler either to generate a DS-form
> displacement, or use an X-form instruction, either of which prevents the
> build error.

Great explanation text, a perfect commit!  :-)

> See commit 2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with
> GCC 13/14") for more details on the constraint letters.
> 
> Fixes: 9f0cbea0d8cc ("[POWERPC] Implement atomic{, 64}_{read, write}() without volatile")
> Cc: stable@vger.kernel.org # v2.6.24+
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20240913125302.0a06b4c7@canb.auug.org.au
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-By: Segher Boessenkool <segher@kernel.crashing.org>


Segher

