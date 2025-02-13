Return-Path: <netdev+bounces-166074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF8A3472F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03ACE18937AC
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF692156653;
	Thu, 13 Feb 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICUmgOgP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6C156F41
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460278; cv=none; b=gfGU2naHCyvMSsVV0Y7lW6dcdAlXWNG+7edc4XRhtskAlYI+6xq0jppWZItcLgF2DH4DOpQ4NYLKaewl0lSaA8rxnRg6Tkvk/sVr7Awx09lDdZuajyALlGAv3RDh6ob++91ogI/K5MWwBv0fSQNGEL+zN9o5xm3F+GmGMpvDJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460278; c=relaxed/simple;
	bh=siTpgn5Ruqsm9LL+SWDB68+vLcQUGKUqGmphsLQycFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alv/DtsCzvjPRn/pUIJXdu3EOxxHJPyBtnsgb7QCvV4a/DgL7XYqaIjkSXwk21fmJNFAd0ZeaOwlgVaGIcUSJHVkUamDVRo6PFlTXLKR8jvz2mQd/0Z6vfXXQrlYDEc84ImHGdOkKBXaSfZLNOxQkPxooWkA7Gu9Jjjelmuwwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICUmgOgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35CFC4CED1;
	Thu, 13 Feb 2025 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739460278;
	bh=siTpgn5Ruqsm9LL+SWDB68+vLcQUGKUqGmphsLQycFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ICUmgOgPPpI/GWVQdOgz34NLNQ/u2lphEPfCvF5siIEte7xe7pjbxxNoMKyajspRQ
	 dQUGBWxUq7kr29Qb0/Y1VWVz8v4FO+t3H4nrddkj9WkEAvKlHQ084c7LjAjgt0xWKB
	 vuWnhIrtbEifsqNFzA6wJsUFy4zXUDb+ubERo1Pjt111ffYBNkXxeEfUW46fIpSmkr
	 zVbWM0qBf0+bHtpslvEtp4ncYydzGtVQ3msv36wwyOg3I9z4BJ9r9SyWycWPui5LcC
	 HMre6opzdYtBq3kcGbxa1FTMEB2JxiZvRs/4J6KNpNtML73sh5HkkKNUmf0HHtrKzW
	 dpnaQK4vOA8Ew==
Date: Thu, 13 Feb 2025 07:24:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, Luigi Leonardi
 <leonardi@redhat.com>
Subject: Re: [PATCH net v3 0/2] vsock: null-ptr-deref when SO_LINGER enabled
Message-ID: <20250213072437.111da6fc@kernel.org>
In-Reply-To: <04190424-8d8f-48c4-9d07-ce5c2f09d5a1@rbox.co>
References: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
	<20250212200253.4a34cdab@kernel.org>
	<04190424-8d8f-48c4-9d07-ce5c2f09d5a1@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 11:15:43 +0100 Michal Luczaj wrote:
> On 2/13/25 05:02, Jakub Kicinski wrote:
> > On Mon, 10 Feb 2025 13:14:59 +0100 Michal Luczaj wrote:  
> >> Fixes fcdd2242c023 ("vsock: Keep the binding until socket destruction").  
> > 
> > I don't think it's a good idea to put Fixes tags into the cover letters.
> > Not sure what purpose it'd serve.  
> 
> I was trying to say it's a "follow up" to a very recent (at least in the
> vsock context) patch-gone-wrong. But I did not intend to make this a tag;
> it's not a "Fixes:" with a colon :)
> 
> Anyway, if that puts too much detail into the cover letter, I'll refrain
> from doing so.

Never too much detail :) But if it's informative and for humans I'd
recommend weaving it into the explanation or adding some words around.
Sorry for the nit picking.

