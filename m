Return-Path: <netdev+bounces-141298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FD29BA67C
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AB02817FF
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F8C17C234;
	Sun,  3 Nov 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT3i8M7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E0171A7;
	Sun,  3 Nov 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730649403; cv=none; b=AZrcY4oSpHwAIwmoKvAGzDv/3nSEeevFE5juODHTsX2V+YUodYZ9RbIORLkUkrplRigScxJzl1L2/ce+7XgKupjS/sau/zUo+a6rmb0J8bJKv9TglV5pgHcqzdTemiA0fiTwCRe7HiWWEVy7/uP0oDVtibONTY7GA5UuyZeBFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730649403; c=relaxed/simple;
	bh=hnqJ7IVGv1LC6XmwhhrDger8rkxnfl0Y/nDKSzs8xEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFyqeoG5AMfEoAmZWaDzx+NfGFCNviWfc51L7W6vfMyTVhwi5wtWEd6Zc0hrICl8QBouwCg8MfQr5zMGl7D5BBtjy2vMBDpiJVJORM0qIMuzcwruzsaE5TLdfuk2WtQzaSePJ+rbEsXh/E2gyRoqgsM6+Gn8WLzbXqDAbKrYPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT3i8M7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E21DC4CED0;
	Sun,  3 Nov 2024 15:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730649402;
	bh=hnqJ7IVGv1LC6XmwhhrDger8rkxnfl0Y/nDKSzs8xEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MT3i8M7dkJ6PdgNW4BJhGkpR9wReyaUQFm49A5DX/2MP8EKiYDf4R/7wD09s2kPj6
	 eh+YQYnOZFASLqFaU1OUTzau460opj8yq30j+sirQ0GzXZEQYrKhCtQgf/iNgjvNP4
	 9sdkATZHEtGbKFnAsiWWS+9VMXKR1doFdDgWLDCMxOdtYlaH3L0aYZA5E3EdZSDZB9
	 0LY5BQe8bA7aL7P0TtqA2s38sQf9Wpz0xojrxurUzoidMRaXfQzZVNzge9lh9qR63x
	 llGgFInDzFyeYHePyXvfMqEnpZpRxePWkvYRGpr4PYpxedFciwgpF6pD95+kjmyb9F
	 7HwPODgWrKznw==
Date: Sun, 3 Nov 2024 07:56:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yi Zou <03zouyi09.25@gmail.com>
Cc: davem@davemloft.net, 21210240012@m.fudan.edu.cn,
 21302010073@m.fudan.edu.cn, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, Markus.Elfring@web.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: ip6_fib: fix null-pointer dereference in
 ipv6_route_native_seq_show()
Message-ID: <20241103075641.2ea347cd@kernel.org>
In-Reply-To: <20241102200820.1423-1-03zouyi09.25@gmail.com>
References: <20241102200820.1423-1-03zouyi09.25@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 Nov 2024 04:08:20 +0800 Yi Zou wrote:
> Check if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_family
> in ipv6_route_native_seq_show() to prevent a null-pointer dereference.
> Assign dev as dev = fib6_nh ? fib6_nh->fib_nh_dev : NULL to ensure safe
> handling when nexthop_fib6_nh(rt->nh) returns NULL.

Are you just sending this patch because nexthop_fib6_nh() may return
NULL? Not sure it can happen since we know we're walking a v6-only
table here.

Please try to crash it and add a stack trace to the commit message. 

BTW your last posting was white space damaged. Stick to git send-email

