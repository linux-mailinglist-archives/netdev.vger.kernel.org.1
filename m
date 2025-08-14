Return-Path: <netdev+bounces-213750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0999EB267ED
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D54E1CE355A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4123019B8;
	Thu, 14 Aug 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwfniY4L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0E301023
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178462; cv=none; b=htNWcUdNSIVGD3+qcK9ss13M3xkIN+Qiuojy7q9x86nPAqeWamvGdYQ87ZcKVYNgLz9uLxZWbVqht8IpEuHHOg4NyZLxEFXM75HQyWJI81sGNZZhuy+RIvLOHTXsimNcr+DmcIP7ikb/EFa+0LGdGNkj3Du/QiImnlxdspYjIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178462; c=relaxed/simple;
	bh=v2QJ6dB0UlKcB2mR4ANUzjHeC3zwp5glfyM/nd+cCXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qW8ge4QrQn/KcFbO6jUjWbUf2iBKK99OP8NSUu2wQQ/nnUrRfPAXTzNtNOOhyYJI0/mbMemc9j2TMat94SKgomaS6NDz0457WWXtoi0wPt19ZMJp/nevm6UZ1qT6ZfOfoO4AaOqTBB6vbgVwf8w2d1utK5BV9efuUS6/bST0lSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwfniY4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D07C4CEED;
	Thu, 14 Aug 2025 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755178461;
	bh=v2QJ6dB0UlKcB2mR4ANUzjHeC3zwp5glfyM/nd+cCXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LwfniY4LeqZWgZclsv0VfaS1Ih1ZHkYqUhVyzdITdXJO9xTGpxperUmk5kNwm4eoF
	 /dc+l1s7VxmuGM1KUBXFJIpsqGqP3dBMNT5jvS6RYYMEz3WDLH/ctERlqC3uIMI/gO
	 NOdLYb8CBCHUMIiM6Dkxme5qFLUDvYZ9sXYBUGYIM13IvV/qlHeD4IPHoGpbkpjJIa
	 m0+AYaLGPI2obZRmvf9kXaFSOXU+6k9vMpSLTE4Waym8RPJgcJEe9Zv73+I7DzoVV/
	 DDriS+xEfFJJA377sD3zBU4jt3GtdENCPz+yPS6sxcix4xsx8jQ68Ab9VvyCV1wKDI
	 v1f6CQEzblaVQ==
Date: Thu, 14 Aug 2025 06:34:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, mlxsw@nvidia.com
Subject: Re: [PATCH net 2/2] selftest: forwarding: router: Add a test case
 for IPv4 link-local source IP
Message-ID: <20250814063420.40ea16ab@kernel.org>
In-Reply-To: <aJ2RvybsdTpRZ27k@shredder>
References: <cover.1755085477.git.petrm@nvidia.com>
	<78e652584c82d5faaa27984a9afef2d6066a7227.1755085477.git.petrm@nvidia.com>
	<20250813134037.3c8f5a98@kernel.org>
	<aJ2RvybsdTpRZ27k@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 10:35:27 +0300 Ido Schimmel wrote:
> > The new test case doesn't pass for us:
> > 
> > # 22.73 [+2.13] TEST: IPv4 source IP is link-local                                  [FAIL]
> > # 22.74 [+0.01] Packets were dropped
> > not ok 1 selftests: net/forwarding: router.sh # exit=1
> > 
> > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/251622/97-router-sh/stdout
> > 
> > LMK if this is an infra problem, I'll hide the series for now:
> > pw-bot: cr  
> 
> Seems that we need to disable rp_filter to prevent packets from getting
> dropped on ingress. Can you test the following diff or should we just
> post a v2?

Tested, rp_filter fixes the new case!

