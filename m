Return-Path: <netdev+bounces-77668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFED8728D1
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 21:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76671F21E07
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 20:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379CE59B7A;
	Tue,  5 Mar 2024 20:36:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rmail.be (mail.rmail.be [85.234.218.189])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D8A1B941
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.234.218.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670968; cv=none; b=cP/OVdhBQDTrYygiI08qTSNRBo2AKKD9BNnyaXUSgc3ZydhKsbaiin93DvESddpkT+00g00CJd4vbe6Itmx1j1+ItF2Yp6L20O/QV248rxNckizIcLiHxy4F4MPy+L7GbAl4i3mtts3GZBBp5Dbn5Fpk5ErE+aQl9fmfJYVUUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670968; c=relaxed/simple;
	bh=CUDbIWJg4f3T+elSPI34EWmMZGLez6kybNXPpbp4bWU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BBEz36nY9IO3t5z2vnLLIrHlrOwuO5q01stducp8uHbwrNJYvLhA3Cc32Nv5QVXQ65LATfITjWyrUHC8Ywj1yZNIBZw8aeZzaVtYd6/daiEG8gyXaLC3xpWKscG7rOdvuwlaM+PTJh+Wv4vWq0mR+dd303sC0hmmncXrAet53EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be; spf=pass smtp.mailfrom=rmail.be; arc=none smtp.client-ip=85.234.218.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rmail.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rmail.be
Received: from mail.rmail.be (domotica.rmail.be [10.238.9.4])
	by mail.rmail.be (Postfix) with ESMTP id EA84E4C75C;
	Tue,  5 Mar 2024 21:36:03 +0100 (CET)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 05 Mar 2024 21:36:03 +0100
From: Maarten <maarten@rmail.be>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] net: bcmgenet: Reset RBUF on first open
In-Reply-To: <20240305071321.4f522fe8@kernel.org>
References: <20240224000025.2078580-1-maarten@rmail.be>
 <bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
 <f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
 <20240305071321.4f522fe8@kernel.org>
Message-ID: <45ba80640e989541e142c32fb3520589@rmail.be>
X-Sender: maarten@rmail.be
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Jakub Kicinski schreef op 2024-03-05 16:13:
> On Mon, 26 Feb 2024 15:13:57 -0800 Doug Berger wrote:
>> I agree that the Linux driver expects the GENET core to be in a "quasi
>> power-on-reset state" and it seems likely that in both Maxime's case 
>> and
>> the one identified here that is not the case. It would appear that the
>> Raspberry Pi bootloader and/or "firmware" are likely not disabling the
>> GENET receiver after loading the kernel image and before invoking the
>> kernel. They may be disabling the DMA, but that is insufficient since
>> any received data would likely overflow the RBUF leaving it in a "bad"
>> state which this patch apparently improves.
>> 
>> So it seems likely these issues are caused by improper
>> bootloader/firmware behavior.
>> 
>> That said, I suppose it would be nice if the driver were more robust.
>> However, we both know how finicky the receive path of the GENET core 
>> can
>> be about its initialization. Therefore, I am unwilling to "bless" this
>> change for upstream without more due diligence on our side.
> 
> The patch has minor formatting issues (using spaces to indent).
> Once you've gain sufficient confidence that it doesn't cause issues -
> please mend that and repost.

I'm sorry, it was blatantly obvious and I missed it :-( . I had added 
indent-with-non-tab to git core.whitespace , but it seems to only error 
when a full 8 spaces are present in indentation. By any chance, is there 
something to test this? In the main time, I'll do a git show -p --raw | 
hexdump -C to check this .

I've fixed that on my git (and fixed some similar issues in other 
patches) and will resend.

thanks,

Maarten

