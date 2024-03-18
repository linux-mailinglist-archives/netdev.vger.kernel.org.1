Return-Path: <netdev+bounces-80378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EEE87E8E9
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22641C2122F
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69DE3717F;
	Mon, 18 Mar 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="BBhRlJhM"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D44364DA
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762658; cv=none; b=VhNnSkJP40QtwAIqTO8bJ4p2mjvsEAThdV5GAXekqbo8kVTUFFv57K968ICiyrDoFAh35k/Psu8/yQBmcCP0YGvLT//Ff7feaOaChXEt8M3G9k/reUPmri1yfixrYB6IJjBOIq9vewcnJNKGzF3G7Wx3zAn8hOw1rFfzkGQUGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762658; c=relaxed/simple;
	bh=Avro1UFyq/QfKObQk7qmBZBI7bReO0u1fqs4mcIDyPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RkaTh77dmicc3uSB8CIA/+IgZ/SKzzy3k7UpHsMnAwFKK14Y/6UymZ4Rg75AtwsEJUrasOuBR8mBM4KqaoinIPLy201mpiXRIJQ4TwgJjPi8k+BNOA0mI/rk/voA1Uryhk8cfbgigerUzCCRRRnzkEAhItOmS6pPIBQHJlBlX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=BBhRlJhM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710762652;
	bh=Iu+6WHoni3dZzZuI+kVQY9A4E2w/WBparVAHCv9ZkRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BBhRlJhMpEsQqRM73j78u3Juw7S4OXn2Z4iUr/buzSoGd41Bo0Z24s9N76AewzXJs
	 vbR6crRw1mcM9vRdUXm+THHQLVmfH/FTtaeN7YFoEYBi3OETrCnsLC0D7aVen6+BJE
	 cY1ZnIX3r+YqBW+pXeNEaxxqsrMIIpqbZMdZnNrC4nhTBJlV1/ebv/QhIfb1ZKU5CY
	 EZQVP/SWN+gPkTgSXJ1kYfEDpS4b+Aj5SMrnFK4TsD/GX/L1S0xIxL2Fk2P/kbObXg
	 TLCyjFNV0JwxliMhCKUi4Lo3f16xWDx84Bn//bIcFNcotpeOelonHxlAr7v39SB7Ie
	 c+0e6wZPiMhmQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TytTl197Pz4wcR;
	Mon, 18 Mar 2024 22:50:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 dtsen@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, wireguard@lists.zx2c4.com, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org
Subject: Re: Cannot load wireguard module
In-Reply-To: <87jzm32h7q.fsf@mail.lhotse>
References: <20240315122005.GG20665@kitsune.suse.cz>
 <87jzm32h7q.fsf@mail.lhotse>
Date: Mon, 18 Mar 2024 22:50:49 +1100
Message-ID: <87r0g7zrl2.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michael Ellerman <mpe@ellerman.id.au> writes:
> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>> Hello,
>>
>> I cannot load the wireguard module.
>>
>> Loading the module provides no diagnostic other than 'No such device'.
>>
>> Please provide maningful diagnostics for loading software-only driver,
>> clearly there is no particular device needed.
>
> Presumably it's just bubbling up an -ENODEV from somewhere.
>
> Can you get a trace of it?
>
> Something like:
>
>   # trace-cmd record -p function_graph -F modprobe wireguard
>
> That should probably show where it's bailing out.
>
>> jostaberry-1:~ # uname -a
>> Linux jostaberry-1 6.8.0-lp155.8.g7e0e887-default #1 SMP Wed Mar 13 09:0=
2:21 UTC 2024 (7e0e887) ppc64le ppc64le ppc64le GNU/Linux
>> jostaberry-1:~ # modprobe wireguard
>> modprobe: ERROR: could not insert 'wireguard': No such device
>> jostaberry-1:~ # modprobe -v wireguard
>> insmod /lib/modules/6.8.0-lp155.8.g7e0e887-default/kernel/arch/powerpc/c=
rypto/chacha-p10-crypto.ko.zst=20
>> modprobe: ERROR: could not insert 'wireguard': No such device
>=20=20
> What machine is this? A Power10?

I am able to load the module successfully on a P10 running v6.8.0.

I tried running the demo (client-quick.sh) to check it actually works,
but that hangs sending the public key, I suspect because my development
machine is behind multiple firewalls.

cheers

