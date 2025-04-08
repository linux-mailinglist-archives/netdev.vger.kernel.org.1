Return-Path: <netdev+bounces-180321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4FCA80F1D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BD216CFD3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067821B9CE;
	Tue,  8 Apr 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUJHL/UN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D941218845
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124350; cv=none; b=CzekuRSWPvVHSEg7/7Jz47/04rEB5/GrVortpbKgAGEwWr8TccXZO/iUD8iFb5AHGezBUyQ1fBchiq4pylZYB0SQXgqM3L3HAwazP6QMkTQulw7sFGkmdJZEylxgDNhHzN9vGOvTUWClPw0TkC8SiobiQAC5cVktJfZT+xG/6o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124350; c=relaxed/simple;
	bh=mORJqIW84BKJiMhV1u+lX50sdqaNbxiSBvPcBU1oHfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEiFbPxgt7VXoCITmC8Wl2WN6d1VolkXBSD1PzVTl/brU67ZJ/g4/Bbht6P0vrolkW22NXXN9fgA6hvpPp4w8UmLFYJtq0hTviCvR7gRxKE7JxV93y87JauOPZJovnyCdPOlG4Dkjq0wZ9iQ6L3kstHYGYEz6u56oSr0LX1aUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUJHL/UN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC15C4CEE5;
	Tue,  8 Apr 2025 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744124349;
	bh=mORJqIW84BKJiMhV1u+lX50sdqaNbxiSBvPcBU1oHfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kUJHL/UNqHQxow1bzSn3vmLdTw6C5m3iA6Sg85QryFAwR5i+Zpmd+0rnWDpBLn+ge
	 i4L36l1YjYUrocmYir+TQefbofh1xi45f8tN/XWu2tSNFr9UrB0oHyFTIFGLXrmmMh
	 x6IjQ5epIFNpD8iHEH/EPBr3LzhlxqOjeQTfnasAua4PqlNTMfU7/hSI5rRDengjCl
	 eybNG7TpPs1EeghzjkA7IEr8uhJxfy3woc0EvR45fvPBD5nFX3f7xKkjrqBFr6EAAi
	 EHqiN8D+NRJ8YbMPiOn/HOxOpztlKn9gVkpuG3U+J1kC/Yl07S9cDSYX7rldANcaTD
	 qM02pXc+smBbw==
Date: Tue, 8 Apr 2025 07:59:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next 2/8] net: designate XSK pool pointers in queues
 as "ops protected"
Message-ID: <20250408075908.27f834da@kernel.org>
In-Reply-To: <Z_SHQJ_pLOgz9vpM@LQ3V64L9R2>
References: <20250407190117.16528-1-kuba@kernel.org>
	<20250407190117.16528-3-kuba@kernel.org>
	<Z_SHQJ_pLOgz9vpM@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 19:17:36 -0700 Joe Damato wrote:
> > -	xp_clear_dev(pool);
> > +	if (netdev) {
> > +		netdev_lock_ops(netdev);
> > +		xp_clear_dev(pool);
> > +		netdev_unlock_ops(netdev);
> > +	}
> >  	rtnl_unlock();  
> 
> Is it actually possible for netdev to be NULL here?

So I've been told in v1 review :) I should have probably linked to
previous postings, these patches had been a part of various series
before.

The code is indeed buggy, tho, we need to move the netdev = pool->netdev
assignment under rtnl_lock..

> I feel like it probably isn't, but if it were possible we'd need an
> else case here to xp_clear_dev(pool) without the netdev_lock_ops?

It does nothing when netdev is null. Actually, due to "other changes"
all callers of xp_clear_dev() are now wrapped in the lock. We can
move the locking inside that helper.

