Return-Path: <netdev+bounces-141392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796D9BABA0
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 04:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBE0B2099B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 03:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC573165F04;
	Mon,  4 Nov 2024 03:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Z2QeVFF1"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B411FC3
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730692674; cv=none; b=F80IHP/ENjrd439gvHcyn4FEk1T96GudcwUIRSDUEbnrRliZOnMDWnm5zkCKE3EGeNLEYhjYP1R25B2iqf7bgNX7E/qAyBW4IBalRMNouXIKLzmX+MOPW06KaxSxTeVyuCDF9JUqnfOYXNsSEqyrkNas29Il/XwGZqBnZTQqnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730692674; c=relaxed/simple;
	bh=CPGVDr61au8mX05CtAg/Zqd1BdLGkKwJ/6F7Psbp/lo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqgtOz3pVhcHEICK9m+ILVaraXc7WJlWShM4HVqWtbA8f92jgOGYk+bNhYFc68qD1eLUWSlDIT5rXDEkRhSqsiGbRHzZY1JGlOWXvfaLYFiH9cnO2MKg/3JzbwWlck0p0aHfx8YtSKxo/3igiqls5jjIeaeEYyi6N40+JOT17oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Z2QeVFF1; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730692670;
	bh=CPGVDr61au8mX05CtAg/Zqd1BdLGkKwJ/6F7Psbp/lo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z2QeVFF14j6DKRGlLWwGEISxW60VYEQSzx/k/+QuKRZuNzWrrRGIqIqVOKBB97RHx
	 42iLmtEqHK5vkA6fUhM537G8fRk2O2inMH78vpp/n3zN7Fzo0rNXvMdWhjlDEuNgrz
	 Co0MHyLaKaQH3Uy02wPyearNIDpgNTbZ3TAGFtiOZCdGfYaJC0Z7OoTiuwT/0pJFUi
	 j6hLCWKZs3rksuKFDTv4huAILfN0zgWX4pVsb9phcjnnB32LZXa4y5xUtGQW/RHbzH
	 rYuhMloOUVHIZPR/8yKZdr0pL80tFYLwTBXZjpEfWLLsuRE+oeePa6f+uWHAAv2quI
	 Hvgz6prs9rbOg==
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5BFD16A03A;
	Mon,  4 Nov 2024 11:57:49 +0800 (AWST)
Message-ID: <7346cdea74daedd0abecfcdcba2e7aa3be203a6e.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] net: ncsi: check for netlink-driven responses
 before requiring a handler
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Date: Mon, 04 Nov 2024 11:57:55 +0800
In-Reply-To: <20241103105414.75ddd6bd@kernel.org>
References: 
	<20241028-ncsi-arb-opcode-v1-1-9d65080908b9@codeconstruct.com.au>
	 <20241103105414.75ddd6bd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

> > Currently, the NCSI response path will look up an opcode-specific
> > handler for all incoming response messages. However, we may be
> > receiving
> > a response from a netlink-generated request, which may not have a
> > corresponding in-kernel handler for that request opcode. In that
> > case,
> > we'll drop the response because we didn't find a opcode-specific
> > handler.
>=20
> This makes it sound like the code is written this way
> unintentionally, which I doubt.

This seems like an oversight in the response path, failing on a missing
in-kernel handler even if we don't later use it. If we were
intentionally enforcing only known commands, then we'd also be checking
on the request side.

But yes, I can certainly word this in terms of what this change now
enables, and provide examples.

> > Perform the lookup for the pending request (and hence for
> > NETLINK_DRIVEN) before requiring an in-kernel handler, and defer
> > the
> > requirement for a corresponding kernel request until we know it's a
> > kernel-driven command.
>=20
> As for the code - delaying handling ret !=3D 0 makes me worried that
> someone will insert code in between and clobber it. Can you split
> the handling so that all the ret !=3D 0 (or EPERM for netlink)
> are still handled in the if (ret) {} ?

Can do! The -EPERM case can probably be simplified a little too, as it
just indicates we didn't get a success response from the remote NCSI
device.

Will work on a v2 soon.

Cheers,


Jeremy

