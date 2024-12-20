Return-Path: <netdev+bounces-153709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C599F94B9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF815188D96D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D1216E1F;
	Fri, 20 Dec 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="HFYezXmV"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4986F218855
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705798; cv=none; b=fnOiClcryDz0vfit/tfz87dHT9hvpTDVm8PuDmjDQ/2rRDPgImahHQdoxY6LIZR/a+tBxCmhnp77MH/xcaa/a59hIoVxer93L1TsMoUHMOL4RB5RrUdi/AbUYlUEhwWucLPUEYMa1mASZJzVYGzjuO9PFCZ27deLnGpaGAEl6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705798; c=relaxed/simple;
	bh=kwUrk8WLQcX5XzL0uxoRha9XWvXuv/afkguY7RfEU1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rLICzi+9v6Je5j/dIL3Ys5EIEe9ERIh8OCWNyqR3HsHwOB97aYfAmzIDGiigszg9lrxXMslbaKkV8ja2iwSYKAzJqN935srQs6tKzBLly6IShtqphkBlJiQ3Fn8EW+wCmwBIu/+NvnZTgQiBjCcbdF42tlailfbWtFPd0oOG1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=HFYezXmV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1734705786;
	bh=bN7/LC4OfI6mHgatVMhnDTYPvxro/Lz5vE8lxIdsk3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HFYezXmV8dUTNShbpN0V7/U5d5shG5nvZH4AlA4HDr0EG9PCJsv9ytBgCjq1cwe2e
	 +MARbFQ6wVHm+kewYHGrrJ2FTZFnaFtunAe2pWJ0rkiU7rgl7nn4WsjSYsQNCRtuBV
	 oLvzMzxV7/CmFL+DZQ9wPfvjOsW2JmoOQIsm5TY1Jh2zzA9EJi8vzJfco5T8404/rr
	 EkpwGwX5P8Z2FMksHhpGENGm2zYQ28poAEDUp6zRuN+h5n442m1F9DYN0ZS19rZV7/
	 bbvP2Q9cAa+1H2aWoF4tDVssQeI+VK/NtV8yzlkZrsh7DFhkCApn4XVhkJioYsjJ0N
	 g1vwYo/jsBeuA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YF9Bf4Y7bz4wyw;
	Sat, 21 Dec 2024 01:43:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, arnd@arndb.de, jk@ozlabs.org,
 segher@kernel.crashing.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 24/25] net: spider_net: Remove powerpc Cell driver
In-Reply-To: <20241218175954.3d0487c1@kernel.org>
References: <20241218105523.416573-1-mpe@ellerman.id.au>
 <20241218105523.416573-24-mpe@ellerman.id.au>
 <20241218175917.74a404c1@kernel.org> <20241218175954.3d0487c1@kernel.org>
Date: Sat, 21 Dec 2024 01:43:08 +1100
Message-ID: <87r0621klf.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:
> On Wed, 18 Dec 2024 17:59:17 -0800 Jakub Kicinski wrote:
>> On Wed, 18 Dec 2024 21:55:12 +1100 Michael Ellerman wrote:
>> > This driver can no longer be built since support for IBM Cell Blades was
>> > removed, in particular PPC_IBM_CELL_BLADE.
>> > 
>> > Remove the driver and the documentation.
>> > Remove the MAINTAINERS entry, and add Ishizaki and Geoff to CREDITS.  
>> 
>> Yay! Please let us know if you'd like us to take these, otherwise I'll
>> assume you'll take them via powerpc.
>
> I meant to say:
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks. Yeah I think it makes most sense for them to go via the powerpc
tree with the rest of the series.

cheers

