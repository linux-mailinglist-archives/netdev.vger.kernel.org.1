Return-Path: <netdev+bounces-81351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D668887602
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 01:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D519A283EE2
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2B372;
	Sat, 23 Mar 2024 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TVio18lC"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098217F
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711153143; cv=none; b=pCn7BrOvxYMcs4u1UfSKOAytEjQxYS6Zt1DOM9+XnUljXVRKi2FG2xeYQtjkmVujYtz0YxrLN1CqlI0p7AsJjUmgBN8Dplu3SIUnCLHmIzUZGquUQCthJzSehKNap8hgpcD9ehVJZNX7fzGOTgjqSTj/06nB1x9o/OGKXOu65qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711153143; c=relaxed/simple;
	bh=eNSZ3J4h9JLdPBKY4LazE6G9kzUQQlpJcfX+tZUCkaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+Tg9HDEUF35p9Q+K3mOHPstNGptRx6zPcxEsYVf8pIckye78ym3Wr7DX7na3byAah2ujGp5grL4pV705Z3U+lDt/2aRj0gwVNaH0sP4Nqiog/n/mJSnXG7/UIE3vu2fXwQGKOp2g742oGHzda+O8yfAvbRkL7eV5HPkARLcSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TVio18lC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1711153137;
	bh=eNSZ3J4h9JLdPBKY4LazE6G9kzUQQlpJcfX+tZUCkaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TVio18lCfxydqx3yzcNv2bxclUkvz2zxdnrNks8sBmuS1vLyQbjFpTb8RD2Zvuvmy
	 VbwsQzY/Y3qjMUJ1LOKJGNIffIwJScZ0mMudGFP/o0AKMYke7YbYsh9GFDXfISMCM8
	 DLDnGWFKQ9rQ03k6yscoCM74459SzQrbcuG4IvVDWMGNwo2ELh7+SxZmjwSY/wUBcu
	 th+iW6lhKnQLegxNyN/lIUuNl1l0Rv9RxSsHmxPBtQlcmBJqY0i8cUhiel3Lvwvt4y
	 SnnqGwgvrK0RDR9nOJ6Js9q26sazD9zIqaX2jt6ADesvZrzkIeH4BI/ZXof1bPSNkf
	 KIvHphQKRLLYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V1fv36YRbz4wcq;
	Sat, 23 Mar 2024 11:18:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 netdev@vger.kernel.org, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, linuxppc-dev@lists.ozlabs.org,
 wireguard@lists.zx2c4.com, dtsen@linux.ibm.com
Subject: Re: Cannot load wireguard module
In-Reply-To: <Zf1sjAgBYCnJ7JEp@gondor.apana.org.au>
References: <20240315122005.GG20665@kitsune.suse.cz>
 <87jzm32h7q.fsf@mail.lhotse> <87r0g7zrl2.fsf@mail.lhotse>
 <20240318170855.GK20665@kitsune.suse.cz>
 <20240319124742.GM20665@kitsune.suse.cz> <87le6dyt1f.fsf@mail.lhotse>
 <Zf1sjAgBYCnJ7JEp@gondor.apana.org.au>
Date: Sat, 23 Mar 2024 11:18:54 +1100
Message-ID: <8734shkdg1.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Herbert Xu <herbert@gondor.apana.org.au> writes:
> On Wed, Mar 20, 2024 at 11:41:32PM +1100, Michael Ellerman wrote:
>>
>> This diff fixes it for me:
>
> Yes I think this is the correct fix.

Thanks, I'll send a proper patch next week.

cheers

