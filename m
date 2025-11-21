Return-Path: <netdev+bounces-240784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A945C7A59E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id EE09B30058
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645672820DB;
	Fri, 21 Nov 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY4mWkcQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B6281508
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736495; cv=none; b=ksKwxBlpVEyqrvMTxAJ8EA3e70uLqShCb5zRSIpw3hszDrRaf2nhRhHbONntpW922O0T8bn0DK365PQfPS+oohPvv7Psr1NdbNEqlVvGmUREEj+HpCu3izdAzxBcDekdvY8bnm3pAh0d6xx6WHmg6iOjxweu+hhLVo/C/qdz290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736495; c=relaxed/simple;
	bh=jHWs6VsuYyKccqCRiGkTqp1Ohec6PkMs/sFlqEz/8No=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYdiCN9YihllMNuhZc5HJqrbCHpc3GHuh5Vps9yb2PIIRNUXSCOUp4EW7oPbAeWAIAExndEUSc2SKWNjQsxciWbMUZiNaB2aMylZyeu50Tk/vD6qUuzyO0/KMKY52eEfMXr9RbPntn2z8UekN6peazpKKEqF1Jte0YP872CNJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY4mWkcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4CFC4CEFB;
	Fri, 21 Nov 2025 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763736494;
	bh=jHWs6VsuYyKccqCRiGkTqp1Ohec6PkMs/sFlqEz/8No=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oY4mWkcQUQ3MRN32vwPYArEj5KFGfO+lIN+CiOK3DWV3IkSZ/QXlop1EBq92WuPtW
	 dJ0FB9ptymlQ/58Tp37HQi+GaAWIvSgiW+/dGrIu8kDWzBVBMtjJ0EPRl/Jlb/RjFv
	 L19ram7Us84okKMj3B5255t6vXOzQS3pUlUVV+jI4hAqhkTv9tjVX+CP8HRjZ8Ej93
	 klO4GngDgYyPnl0z/EW0aFRjAhWZloppcb9vZdyTOd+lPRH1fmT+g/55HfWNJNdXHQ
	 6kkj5kVOj1WuR7GfP1xV5/+l0LjJJkQNUq8Bf+Qt+tsJpMP8Hz1G2eNJYFEoHBlRH/
	 wniBJVyl4wtCg==
Date: Fri, 21 Nov 2025 06:48:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Message-ID: <20251121064813.57f2018b@kernel.org>
In-Reply-To: <q5n6ata2nhrtbkcnemyuiuhsf43365uqpdrbhm2qvpckxkyyuj@u3ugwpyqab6a>
References: <20251119165936.9061-1-parav@nvidia.com>
	<20251119175628.4fe6cd4d@kernel.org>
	<32hbfvtxcn3okpylfcgfeuq7uvrufpij4y7w6au6vxrernwthb@pdxvc6r6jl5z>
	<20251120065223.7c9d4462@kernel.org>
	<q5n6ata2nhrtbkcnemyuiuhsf43365uqpdrbhm2qvpckxkyyuj@u3ugwpyqab6a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 09:35:24 +0100 Jiri Pirko wrote:
> Thu, Nov 20, 2025 at 03:52:23PM +0100, kuba@kernel.org wrote:
> >On Thu, 20 Nov 2025 13:09:35 +0100 Jiri Pirko wrote:  
> >> Thu, Nov 20, 2025 at 02:56:28AM +0100, kuba@kernel.org wrote:  
> >> 
> >> Nope, I reviewed internally, that's why the tag was taken.
> >>   
> >> Well, For the rest of the notifications, we have NEW/DEL commands.
> >> However in this case, as "eswitch" is somehow a subobject, there is no
> >> NEW/DEL value defined. I'm fine with using GET for notifications for it.
> >> I'm also okay with adding new ID, up to you.  
> >
> >Let's add a DEVLINK_CMD_ESWITCH_NTF. Having a separate ID makes it
> >easier / possible to use the same socket for requests and notifications.  
> 
> Well, you still can use the same socket with just ESWITCH_GET. Request
> messages are going from userspace, notifications from kernel, there is
> no mixup.

AFAICT DEVLINK_CMD_ESWITCH_GET is already used from kernel.
We could technically use the seq to differentiate but that's not very
generic.

> For the sake of consistency, shouldn't the name be ESWITCH_NEW?

No preference on the naming, we can go with _NEW, tho, as I think Parav
is alluding to, we don't send _NEW when device is created (which would
be the natural fit for _NEW). Perhaps we should?

