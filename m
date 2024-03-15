Return-Path: <netdev+bounces-80197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B201187D760
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 00:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452641F21ADC
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 23:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32459B6C;
	Fri, 15 Mar 2024 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pxiLr+G9"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361414A81
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710546281; cv=none; b=aCfvH821iHO++qUy6Enj+BIilCbDtVh/ESXQkTy76C8YavUgDtMCF0a7kLtB4/nA+V7OJQfNWmhafV7bAZdaVP1zkHRaOJ4Ggv/KGamPtjvn/DLjolBhhkOhrIJmkvySLU0WgYsz3ALmWgNYkBPtgJAQDIVOXDpOFHK1PKIgnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710546281; c=relaxed/simple;
	bh=9W0emP71TLyVegPtfhIFli30mDZIEwfJd9QfnxEAAeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D09+SqnMBW3lt13Cpj5SCpIRwidLFIecwY2yuIesWI/fkBbxSQC/VxXd6T9fU58MzxqJ0v4px8h1YfoQR6XMSNm+rciR9Gznk73gEXbSP5DOA0RyvyNMXnjmTMX9VpVG51HvvsqBnehmCl080lvQRAIDuaxerlkzTacLivmhkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=pxiLr+G9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710546268;
	bh=DmvrUMNXUtpSZVzaitPWmDSNlpeFznZ95+rmUpDj/bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pxiLr+G9wiG7ShCCGxO97nJBFeBRkNkYKBAmEE8oi7eDQyyASb3PwlGGzp405JCnD
	 QOOs2fOMa+QktpaFLnFJV1dGPT+UMeapeG08ZRLGmeGrs3r/R2/7xxtVYZh6ZMA6m7
	 PzVqUyA9ej9kCGsSTqzUcMxRCIFvVlyi9sPVUcJd7/YQ+RE7p2KADSiCi1iyj+eXxn
	 BrUMsmuRqyKEmfAIHa8X2efgR5B9RjkDMdDPVi/ltHJHb9bpe/nnqTnbZBBqWVJ1YL
	 nltG8fh3063WnK4ywUhQmftbcikNAktd0Lq9ABQu2vAXiv8Ehhb3LsGaMXY61BhT4D
	 dj9tVuTv980KA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TxLSW4Rr9z4wbr;
	Sat, 16 Mar 2024 10:44:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 dtsen@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, wireguard@lists.zx2c4.com, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org
Subject: Re: Cannot load wireguard module
In-Reply-To: <20240315122005.GG20665@kitsune.suse.cz>
References: <20240315122005.GG20665@kitsune.suse.cz>
Date: Sat, 16 Mar 2024 10:44:25 +1100
Message-ID: <87jzm32h7q.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> Hello,
>
> I cannot load the wireguard module.
>
> Loading the module provides no diagnostic other than 'No such device'.
>
> Please provide maningful diagnostics for loading software-only driver,
> clearly there is no particular device needed.

Presumably it's just bubbling up an -ENODEV from somewhere.

Can you get a trace of it?

Something like:

  # trace-cmd record -p function_graph -F modprobe wireguard

That should probably show where it's bailing out.

> jostaberry-1:~ # uname -a
> Linux jostaberry-1 6.8.0-lp155.8.g7e0e887-default #1 SMP Wed Mar 13 09:02=
:21 UTC 2024 (7e0e887) ppc64le ppc64le ppc64le GNU/Linux
> jostaberry-1:~ # modprobe wireguard
> modprobe: ERROR: could not insert 'wireguard': No such device
> jostaberry-1:~ # modprobe -v wireguard
> insmod /lib/modules/6.8.0-lp155.8.g7e0e887-default/kernel/arch/powerpc/cr=
ypto/chacha-p10-crypto.ko.zst=20
> modprobe: ERROR: could not insert 'wireguard': No such device
=20
What machine is this? A Power10?

cheers

