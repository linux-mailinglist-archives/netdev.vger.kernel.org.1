Return-Path: <netdev+bounces-113322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D79B93DCE7
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 03:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D8D1C23493
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 01:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E85394;
	Sat, 27 Jul 2024 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhUMHyi2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B417E9
	for <netdev@vger.kernel.org>; Sat, 27 Jul 2024 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722043280; cv=none; b=T09/xUIbqTtve0ktQdcVYwmnz2gjSdz+Jlx42+cIsgxQmfIgbPqDpWuy5coL9wtWwdw8uM3mx24Rnc6XL+snrPj+6wlUvEuozQ+lNSVcig2ymBSDac9/N7D8JptDeIZVF2A4pBfT+M3SVsUZfvQ0EAVarVjdOlPjrukShcOjufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722043280; c=relaxed/simple;
	bh=BH5/cfWgYbyCKGyii0H+kqAUGxaodJyrYwsr64hpNjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brxl56CrGGJ1ex/z7BmCN7+nnMvZJ7edMR8nyhc64q6mQcyWXZeQob0Bv2TEc2rfoioiANkjG46f90Acrr9QhLh/+B5My+jHErWeY+s1FXrOp9uH+wbj/1c6Wlh8rBVvdZk85k58MNA5wlyb8zXot53lACTnbM7Y9CHjuQCtvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhUMHyi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B217C32782;
	Sat, 27 Jul 2024 01:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722043279;
	bh=BH5/cfWgYbyCKGyii0H+kqAUGxaodJyrYwsr64hpNjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FhUMHyi2+HTZDtCuzrbVllhsQohqNBvQcFIrBKEc37ep2yeR9Wx3iYV710+7iVpXo
	 NF8+TM2/r9vusONr47sZMGXL/Cspa2VB/rSVHmLBmurH1hV4vTKjYcg48n+ef6RiP9
	 psk8Lfyjmj49BcZKN7zGwjS4td94fT65aZD2wG9cCWgVfmDJxRCrt7LWMZu8VJCLl3
	 oVkT2lTbNB2LXLxN0JUyfxDQy12oijVZIOv07c/bjvqg5S+R0C+9x/7+QnBv3KZG/s
	 t1h22Wmxv5iBfciJSj2vgqvxfydlSD6TSs8uCXBqBndeiBWt/QjXGyCk2SRzKXOeXC
	 a2S2kklHqUeLw==
Date: Fri, 26 Jul 2024 18:21:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net] rtnetlink: Don't ignore IFLA_TARGET_NETNSID when
 ifname is specified in rtnl_dellink().
Message-ID: <20240726182118.1674906e@kernel.org>
In-Reply-To: <20240727001953.13704-1-kuniyu@amazon.com>
References: <20240727001953.13704-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 17:19:53 -0700 Kuniyuki Iwashima wrote:
> The cited commit accidentally replaced tgt_net with net in rtnl_dellink().
> 
> As a result, IFLA_TARGET_NETNSID is ignored if the interface is specified
> with IFLA_IFNAME or IFLA_ALT_IFNAME.
> 
> Let's pass tgt_net to rtnl_dev_get().
> 
> Fixes: cc6090e985d7 ("net: rtnetlink: introduce helper to get net_device instance by ifname")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

