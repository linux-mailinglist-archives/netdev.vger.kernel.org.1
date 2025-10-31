Return-Path: <netdev+bounces-234553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B017EC22E11
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 741014E11F8
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C7B223DE9;
	Fri, 31 Oct 2025 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOO4duwx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073F85626
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874334; cv=none; b=Dpgr5XItrzMvgirHEySb5ldT8M1xakhhP+d4O5pmrNfDz/jDlRYCJ1wDUKKg4vok6IjevZnnDBZqa6pv2Hj1o14NDGqxl945buDzcA6mylLmkMCnIXKUDZ9WWYemWX00FaZGB2AmNEIiHissFqeBiDP/9OC2jHnIu4rYvjV9y+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874334; c=relaxed/simple;
	bh=MFeSTiNraoPtQ8950YIXb03sF8z5CHCR5Msfmt4Qmnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEDuaTN/nChhaY05OKyViGEmYRAyS0dAhVj2l/K2Onq06zvkakxrE4Nb6an4Aw41tAi+8d7U2CJ+PQyY/tgiVpsHOyD/bdKxv1HXk2UO4QfN3NCPgKVtEIVflPfyS0NkChpoXWsYkOZSIoKQdUtuly7rjUGBfhrkOSeVzDvEwC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOO4duwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85599C4CEFD;
	Fri, 31 Oct 2025 01:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761874331;
	bh=MFeSTiNraoPtQ8950YIXb03sF8z5CHCR5Msfmt4Qmnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OOO4duwx4qdqhesBSUIfLcNMqqZV0aZZDjGpFM72+0GAUke2n95gN0jh4svM929l3
	 ZlIUGIv66XZveaBi82urWrcbGamvgLQ+SLxq8aZYgS8pl2mnBZfhO7Va1jNWrfCmTM
	 FvjtjeDprqGCDb6byrWJTgMtecuFD45+Md8WGYJB7434iSNAmNW9D7akejxLLnZ4oW
	 5wQltkGauq81jt6Jh9DncGdMADlOfmRY9ugacZL27XRgZHFk894Kxc97a5eAw+b5kH
	 cVo5ITJzFe85mor2VMHQL6Nx4BbutWyI9ko683xRTXbaBQnLO3pekjmt11gau44NvT
	 CRBpO70rPV/Ug==
Message-ID: <bfdd7558-31d8-4d83-8532-40f2371dfe34@kernel.org>
Date: Thu, 30 Oct 2025 19:32:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ip-xfrm: add pcpu-num support
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>
References: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
 <20251030090615.28552eeb@phoenix> <aQP6Ev_21Z45JuG9@krikkit>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <aQP6Ev_21Z45JuG9@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 5:51 PM, Sabrina Dubroca wrote:
> With the netlink specs project, it's also maybe less attractive?
> (netlink spec for ipsec is also on my todo list and I've given
> it a look, ipxfrm conversion is probably easier)
> 

That is an interesting question. I guess it depends on the long term
expectations for the tooling. There is a lot to like about the specs.
Does Red Hat include the commands in recent RHEL releases? ie., do we
know of it gaining traction in the more "popular" OS releases?

