Return-Path: <netdev+bounces-164968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E0A2FEE5
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8EC3A2A8B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE6D635;
	Tue, 11 Feb 2025 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJUw+rLd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2E1F956
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232674; cv=none; b=Bh/raij6n0aErllGT3M6obbVSmGxExy1VQ541TJKNHniUmODs15XIBpbhfs7ah+I93LIZqXXncvLLIod5jm5Qc+kF2oxDZmUecFmCKqHJCkmz/COs/9HXuskknDKuUUDnKUOH1siXRWupcE1007+kcueVpOipu7PU3Yv9xs1sHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232674; c=relaxed/simple;
	bh=VrE66MYBOCr65g03fZ5j68A/+5XPHf4FK08Qi/VgBEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkzeAeCeClHuBmP9zG5ume7gBx02+W3z1TBIO/fwAn9MBazsLjjBLJrH1zzNWDiNUKAcV5Im6+xziIXnaEzSrD4JhMawvanRR4iNblJQv8XmISJ8GYNAU3p74O/35IPngjcTIVZVYA/ULgVOGNOSnP7pur/Ar1S27uNP89dNDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJUw+rLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C28C4CED1;
	Tue, 11 Feb 2025 00:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739232674;
	bh=VrE66MYBOCr65g03fZ5j68A/+5XPHf4FK08Qi/VgBEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gJUw+rLd0plaLOOsc56oMYAvTzLot+l8oQJj8hgdQz7CAOYW3p/AJIFFCUUrya/bd
	 sEsTibQfEyJWj9mP0RziJfHwSAv6QvMzIwDFaTFlptQ/7j8Wivw5xg2/nEJtgVKMmf
	 ZgBG1RGspTbbsD8+RKM2hjpGvQfMjt5d+fZLNQ0c0eRKAIq9KpwhOyciVNZ9Y6Hoj7
	 QVcVlwNyQ4h3NvHzpclp8knUP4ZVcstmbdB7dN1HTWhrJzxSfnDIChYU+0YUfWH5KE
	 r9UhOC13JthFKTRLWlp8yy+iXa+zPSptePa/EWcUeXUQtYekRc/G8CgzgCy+ExTzG7
	 pW08/Hmf5hx1Q==
Date: Mon, 10 Feb 2025 16:11:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, David Wei <dw@davidwei.uk>,
 netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, hawk@kernel.org, dsahern@kernel.org,
 almasrymina@google.com, stfomichev@gmail.com, jdamato@fastly.com,
 pctammela@mojatatu.com
Subject: Re: [PATCH net-next v13 00/10] io_uring zero copy rx
Message-ID: <20250210161113.43f59708@kernel.org>
In-Reply-To: <39739559-6d28-429e-a1d6-430fe0f2490a@gmail.com>
References: <20250204215622.695511-1-dw@davidwei.uk>
	<173889003753.1718886.8005844111195907451.git-patchwork-notify@kernel.org>
	<20250206170742.044536a1@kernel.org>
	<39739559-6d28-429e-a1d6-430fe0f2490a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Feb 2025 13:29:56 +0000 Pavel Begunkov wrote:
> >> This series was applied to netdev/net-next.git  
> > 
> > off of v6.14-rc1 so 71f0dd5a3293d75 should pull in cleanly  
> 
> Thanks Jakub, from here we'll merge the rest of the patches through
> io_uring as planned.

You should still CC netdev, to be clear.

