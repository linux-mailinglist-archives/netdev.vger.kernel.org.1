Return-Path: <netdev+bounces-73343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C20B85C02C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 16:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404541F22CB6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628A76033;
	Tue, 20 Feb 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0wnsq6i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAD6A35B;
	Tue, 20 Feb 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443609; cv=none; b=Va3ty6tgnDRuC4cp2/Pi16hQFrlzTRmyjZonLZcbFkkWQ5SL8ZkpKhl3pOYAlv2bYfxhx+YS1dgQhZDdNx1XPGOw6VY22kEWpviUfaSnVcHLRAcK7quWiXfTp9cIlqsMQixj448BAYLlTFjapEhInGHuVBtolRgDmFXtn156LLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443609; c=relaxed/simple;
	bh=jsqJtbz874QeHCsEiKi0wr+fx4ckG/ELmZhBVBCxL/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MF9rRHMgYD3OsDorLHn4EI3ojy1+TRPEKeHNcObbASNKIqjWHsoT0dLeeISaSXyg7Iotyp9pXQCvV0ZUzIM624k9IXvI8NZ1O+MoNerg56X+e+ziJPs4QaUzdOUQa5E5S4ILEAew4kcwREdjU2BCRfQtUbmX0TieeuMcuiGW++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0wnsq6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9DDC433F1;
	Tue, 20 Feb 2024 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708443608;
	bh=jsqJtbz874QeHCsEiKi0wr+fx4ckG/ELmZhBVBCxL/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M0wnsq6ik+2ZZju1Hs+Y0LRLobtH/YHtJDhBHhnY/WvdtFPAsj6YW4u8lXz/Jy60P
	 HISGT1AcNolElgj3QtP11+R9+bolOowQmLwVs/3FPQ/1fGCTU5RUFkRQTlYYAPXT94
	 WakqFp00Syp2M2846hVHRogonHd69agNLE9P4kBYvIub6qTi/UEHdsgF5Ek2nnusIg
	 sHoYjJzD8X1pqXZrVtrq+QvvttHi6qWYl+F6+EL7hhIqHh9cZZxbv6mXxNtfJ3uGCk
	 F8ZxzhYMBI0xv1cpMpo+xy67qUZ9ugHjybrJvhDIDhnswgkKQ/sQu+FeiWhQPTvGuz
	 Wdpc1VwtQP0QQ==
Date: Tue, 20 Feb 2024 07:40:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 stephen@networkplumber.org, f.fainelli@gmail.com, Johannes Berg
 <johannes.berg@intel.com>, Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH net-next v3] net: sysfs: Do not create sysfs for non BQL
 device
Message-ID: <20240220074007.1e91ce62@kernel.org>
In-Reply-To: <20240219104238.3782658-1-leitao@debian.org>
References: <20240219104238.3782658-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 02:42:36 -0800 Breno Leitao wrote:
> Creation of sysfs entries is expensive, mainly for workloads that
> constantly creates netdev and netns often.
> 
> Do not create BQL sysfs entries for devices that don't need,
> basically those that do not have a real queue, i.e, devices that has
> NETIF_F_LLTX and IFF_NO_QUEUE, such as `lo` interface.

FTR, I applied v2, thanks!

