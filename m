Return-Path: <netdev+bounces-213490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7574CB25496
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 22:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B8C1C25141
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C42C0F88;
	Wed, 13 Aug 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmJss6i7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFB3D994
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117639; cv=none; b=SMSqqarQzzA6ZqarJ2UNZ48ANRrFma1BxXfedf2XX7bkxc16uEmk3Rl+/vfBCnZYQOyN7vYZUUBlxV7apWea9M6fClqDXNTjs5PKTqev8ZAll9MtkbEACWSl6a90cLWMVitbwA6dTL2heTlGCaHh3ZWHiG1gigFlcYZ2+WA6eGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117639; c=relaxed/simple;
	bh=gITD6ucH6ZpKedSlg7DUP3ccgwOzxc6+m3/Lso46bIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XM18jzFQOT3HO2z+VoCZM6NopDgA7o+5+FY7ilATFN34GdUnt9e4NiRDhamv7ZS8ZxDLqQFZ52rquTXgCVW0iQ95vuCHe3OICi8V2bSH9v3Lp2YUtq3qAlDTcTZMouguxUV+xoDJYrvPIK3XOZZExd2QRUNuhr2JrMXko0kZFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmJss6i7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE072C4CEEB;
	Wed, 13 Aug 2025 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755117638;
	bh=gITD6ucH6ZpKedSlg7DUP3ccgwOzxc6+m3/Lso46bIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GmJss6i7zzQ1GPquqFNMbnsFkFczr0zv4ygrO91/IKPaVbdcR7xS3JobLanLe0GlE
	 b88dCXKx+p5txKnaAoDz6I6EIh/rMljqww5ZeCdhw98mXhikQiz259PaHKYlGoTm3z
	 VJxxH74eUxDHKeAq4CrkrAKiFSQXSg5IPWOwHjED6hNQoPDejiEfcbl0YtIKb7Oky/
	 LEiNT9bOeyWQO8iTaXZSdHvJFpGF/7kdw9+MkQDIvo0Lgtwx7H/gw6OXFnMMvxWtlA
	 kotffC/0fr+mQb11SFL2JkJehcvZBeqz6+m10VTF5Q9S4qsVm0cuQ8G08l5c60tCyt
	 siZzjgcVhaN+w==
Date: Wed, 13 Aug 2025 13:40:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko
 <jiri@resnulli.us>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net 2/2] selftest: forwarding: router: Add a test case
 for IPv4 link-local source IP
Message-ID: <20250813134037.3c8f5a98@kernel.org>
In-Reply-To: <78e652584c82d5faaa27984a9afef2d6066a7227.1755085477.git.petrm@nvidia.com>
References: <cover.1755085477.git.petrm@nvidia.com>
	<78e652584c82d5faaa27984a9afef2d6066a7227.1755085477.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 13:47:09 +0200 Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Add a test case which checks that packets with an IPv4 link-local source
> IP are forwarded and not dropped.

The new test case doesn't pass for us:

# 22.73 [+2.13] TEST: IPv4 source IP is link-local                                  [FAIL]
# 22.74 [+0.01] Packets were dropped
not ok 1 selftests: net/forwarding: router.sh # exit=1

https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/251622/97-router-sh/stdout

LMK if this is an infra problem, I'll hide the series for now:
pw-bot: cr

