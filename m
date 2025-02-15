Return-Path: <netdev+bounces-166629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D603BA36A1E
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BBD3AEF10
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943313B5B6;
	Sat, 15 Feb 2025 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnHFTSfp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95621373
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580739; cv=none; b=iM+3RqYDpnOc+HhrrBwSHg/kLc22xT0iBZGndKDGGAXGJE77rGgS7kLt4cB+l0VgHy//kSqtIM+QWjh0nMAxrA2rSD3Ef6f1xwZIEpB4mucrO2t2Nsbv6CUy8ijlp3OZmhVYg+Vu4h+lkN7X4R2XW5QNytAZh5rEpYcVMobsePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580739; c=relaxed/simple;
	bh=enJZqGIQCOftnQL1LgNxEpH2ib1VpwniWnHKj/zJSnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ji3btgytF7InyRRy9T/mcR1zH6G8CRJ16xCnLiBCBfnZgh7aIiFe9NUl0zQNzNx+TDyPt+y+zO3pQbcMQg7JSgCgtUZ3jKXgTQjLNseZ2iNk1v5fHpip/KTLb3NFYAr1iT1oSI5cPhfSbGAgn1NQXLYl8mhtZqsEJhJsveUma+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnHFTSfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0C6C4CED1;
	Sat, 15 Feb 2025 00:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580739;
	bh=enJZqGIQCOftnQL1LgNxEpH2ib1VpwniWnHKj/zJSnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gnHFTSfp4utxEfAYuWKWcNIKmIePtt/+KR0FPt2hGIvkuDAmwuR0b9K0tVhCQLiw3
	 Pbs/dd13I+l9DUMM4OOMl86wF61U5r4GU4p9t1i72zeCUhmqURq/+xLWWxnfbWUIFo
	 BXPM+icS6OMUUm7zqqMaEp4mtKDmwrgzJo/kF6mVsnz/6fi2rUjQayAW/GKyTUeGkX
	 MS8zXc0NYvVNzDeMRKhUjQRI8+X4Zt7IyLCzMYyt9NpVsrbCJHSf0oOaG2PgdSysUS
	 Ksf+seIqGkRXjWS9hCgl7+znVvk6tL5pkf9gd/a0syYDP9wNeL3xzge51JZwtf1rxy
	 SQtItGBGflQbg==
Date: Fri, 14 Feb 2025 16:52:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
 vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v7 0/4] Support PTP clock for Wangxun NICs
Message-ID: <20250214165218.5bce48c3@kernel.org>
In-Reply-To: <20250213083041.78917-1-jiawenwu@trustnetic.com>
References: <20250213083041.78917-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 16:30:37 +0800 Jiawen Wu wrote:
> Implement support for PTP clock on Wangxun NICs.

Please run:

./scripts/kernel-doc -none -Wall drivers/net/ethernet/wangxun/*/*

Existing errors are fine, but you shouldn't be adding new ones.
You're missing documentation for return values for a lot of functions.

Note that adding kdoc is not required, you can just remove it where
it doesn't add value. But if you add kdoc comments they need to be
fully specified.
-- 
pw-bot: cr

