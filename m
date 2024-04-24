Return-Path: <netdev+bounces-91123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE838B1783
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 01:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529342858BA
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 23:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B016F289;
	Wed, 24 Apr 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxMCCDar"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBD41C68
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003075; cv=none; b=s7HuVc//gHiDwIWXVOP1Nnv7EiQZQf+8qVIKLelyd7bm4OluH0buYkbzBCZ8zGRn0UgDwCqfw7NItQ+d2/uPE927tu1Xu5QjYcvxB944etwaIqHCdk0e/hSbg1l7zJcUsD/vTr4meD2f/cNhXTjLhJ2WrManhZCZQQnil0nQkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003075; c=relaxed/simple;
	bh=0ZKK7XAy1miGUYwPd+P9lggffp1jKkLor5eLUf+by+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAWpVBw6beLXjCmvQuV0VhDC+faF1dfYJv43YN1cE7TU2D9FUgyBcKUhSckI7ptVn1EJfRoD49DJ/IJpNGoapGwt5Y+veZQN2jjEDqqeTVq1pbtGYucxPr7oFGauB9+jODje7GJsbo6qkOSHYJYFNSiGoZHtYp4dV6u1zIjtj0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxMCCDar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00756C113CE;
	Wed, 24 Apr 2024 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714003075;
	bh=0ZKK7XAy1miGUYwPd+P9lggffp1jKkLor5eLUf+by+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SxMCCDar01bnIJK8/Y+7vrCkaYMbQrnsNOy1AHM2Z0GnzyX3/YREAPH9GvIHJluN3
	 abmcd/s5wZwU+o2jzZQ9+8Zfw4ba5jPrQWlX5n1XAryk+vsGfcokH91Qbd/bfakGbU
	 +p95c3XWZ8OkgHrwwJIbktgGOZhgF61qAdvYuZ6XmTvHL/IggSjxsG4amMgeLFwxwp
	 K7tUBTSm3Dw+AZbT5WYjNsvUkfSjNmChsn1qdi9Adb4UDX8UOL4J1+f/zs/V7CKchV
	 /sFQCHMSa3G8TTw1/7BVGexXleb4yhv1jN4LxGVmHyT1w0OTpSbFhhvK5bzgRKN0of
	 EAkxGbP9gUojA==
Date: Wed, 24 Apr 2024 16:57:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
Message-ID: <20240424165754.1ba023ba@kernel.org>
In-Reply-To: <1380ba9e71d500628994b0a1a7cbb108b4bf9492.camel@redhat.com>
References: <20240405102313.GA310894@kernel.org>
	<20240409153250.574369e4@kernel.org>
	<91451f2da3dcd70de3138975ad7d21f0548e19c9.camel@redhat.com>
	<20240410075745.4637c537@kernel.org>
	<de5bc3a7180fdc42a58df56fd5527c4955fd0978.camel@redhat.com>
	<20240411090325.185c8127@kernel.org>
	<0c1528838ebafdbe275ad69febb24b056895f94a.camel@redhat.com>
	<20240422110654.2f843133@kernel.org>
	<1380ba9e71d500628994b0a1a7cbb108b4bf9492.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 19:25:37 +0200 Paolo Abeni wrote:
> I would say just bw_min = 0, all others fields are ignored in such
> case. But not very relevant since...

> ... my understanding is that you have strong preference over the
> 'attach points' variant.
> 
> I think in the end is mostly a matter of clearly define
> expectation/behavior and initial status. 

Agreed, no strong preference but also no strong argument either way?

Maybe my main worry was that we have 4 "lookup modes" if every one
of them have fake nodes that's a bit messy. With fewer modes it's more
palatable.

And IIUC TC uses the magic encoding method, so that's a precedent.


