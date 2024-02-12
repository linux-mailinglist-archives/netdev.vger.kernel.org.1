Return-Path: <netdev+bounces-71026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CBD851AFD
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9911C22397
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929B4653A;
	Mon, 12 Feb 2024 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFsGhHpW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382547A6B
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757890; cv=none; b=tULNPVXCNA2r09fBegsh1NC4jJV0f7HSEpH5aabGc09fsA1/uP65sFQ7JGJjYp9MXZWiUCvH6cfZ9+L3LxLV0Jz/cvqJSHahKK5nD2E1H/NcKTXTN91Xd5zgvbpRVQq97EXKTk32R4mchjk2lXK1LzxMekNiEKUsndd+j39wELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757890; c=relaxed/simple;
	bh=X1ERMo2FIsnRYgV1Nkna7r9McgZRVxQ/5bAFEoN8ga4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOINn1JEb/ZOD45CqgDD2cmuUQt968gRhVprvk+0J8aMqwVZWRM3H24w88XL4jWRsmM8UQpVAEvAmYhP9UZxg9Dq5wo7Q8m+1Fj7CUofUQlQp0M6epiGhr8whc3NJJOSM5HmFtlvMt85rskTAaIdMTo2Z7DSOUAL6IclXiJCqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFsGhHpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E567C433F1;
	Mon, 12 Feb 2024 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707757889;
	bh=X1ERMo2FIsnRYgV1Nkna7r9McgZRVxQ/5bAFEoN8ga4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eFsGhHpWhdy6qHgoCB4AE42q7yYnRjLSiQpcuYK4HWq7DjfrGswegF3NYulgodXVW
	 jNND/02FKYTfDZgWjP1AMpciY+HL1H5WPhfIECI4Qd6GQ50KGQ354rDU+3Vf0FvDDc
	 //9zzCD6t5y7FyGR4ixsvUlNjlWZ4OVdeob8MVE/DJf1txOfiHXd1ABXPY32NgZnd2
	 rQqb4/X2e6aHFbAAQHXv+iBJoUSRvnnEn/zgSmtCU3yUCV5IJL3uwjpe5OON33aHSb
	 ILZ73ymxDGWdqqfTmm+7jJhx5G3HACF2eORldCNDHL/mOd30R8EFA8P0lFVkXISSYD
	 KhdJVCv9UYGxw==
Date: Mon, 12 Feb 2024 09:11:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, borisp@nvidia.com,
 john.fastabend@gmail.com, horms@kernel.org
Subject: Re: [PATCH net 7/7] net: tls: fix returned read length with async
 decrypt
Message-ID: <20240212091128.7e038b89@kernel.org>
In-Reply-To: <Zcc7jydL2xIYFrQW@hog>
References: <20240207011824.2609030-1-kuba@kernel.org>
	<20240207011824.2609030-8-kuba@kernel.org>
	<Zcc7jydL2xIYFrQW@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Feb 2024 10:02:07 +0100 Sabrina Dubroca wrote:
> 2024-02-06, 17:18:24 -0800, Jakub Kicinski wrote:
> > We double count async, non-zc rx data. The previous fix was
> > lucky because if we fully zc async_copy_bytes is 0 so we add 0.
> > Decrypted already has all the bytes we handled, in all cases.
> > We don't have to adjust anything, delete the erroneous line.  
> 
> I had an adjustment there which I thought was necessary, but I can't
> remember why, so let's go with this.
> 
> Possibly had to do with partial async cases, since I also played with
> a hack to only go async for every other request (or every N requests).

I must have seen some reason to keep it back in 4d42cd6bc2ac as well :S
Let's see if someone complains..

