Return-Path: <netdev+bounces-91103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CFB8B163D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 00:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6164C1F23DF2
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71515ECEE;
	Wed, 24 Apr 2024 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JyNFpLEM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10567142E6F
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998076; cv=none; b=cq4iRTet35gzBGp9qEZ7izJPH8jHNWP62PyWquxZbPOAX7Rn+py1I46h/3qDT1wXCNQaatuDVVFBvzvma0aIn7LEfcxkrX1SElJj/0dm5Yptvoxn5Kzy6HZxKkXyhtp3TyWoqwkJLJYBdvYFUqXh4wfd40jqo9S1cDojAgvo6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998076; c=relaxed/simple;
	bh=CaIy8WZtU9QhE4sjbsPQqXiuTfactejDtbUoAhUJqIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwidMYSI4pm6c7LQrAGhcLp5rFsLc1kgsqs2hwPY6ymkXebmPwIjvwrQ6ZPvYjVQmBbnx5CA74kD1Ztz/pZ76d0OsIYSTkkJvv7juM0VNgdxP+jQX7B1xaNUqDaZuh0IPexsWQxu3uzfA3w3bVGDHoBQBTAsXW2SwtFOHQQchp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JyNFpLEM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vZ3B6dq2zPnL83S+QfF4z13TMNF7T6rBVnaRE/Ud6yc=; b=JyNFpLEMtqDJctphOR6y3yPRMl
	7bqs7eJ6ihFsW2Piu5j/4nFer0bvYUlZwfri6guvSjZWTbGi9vXKzirUokby+sMNCxkMh/ZVxCtCK
	KOUns3XzfYnIO07NHDbaQnxUOTxjy/gvxcLxBmfdklaCO7q4h/dbZee9C2WT1KYxDhxg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzlCB-00DtSt-Vq; Thu, 25 Apr 2024 00:34:31 +0200
Date: Thu, 25 Apr 2024 00:34:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH] igc: fix a log entry using uninitialized netdev
Message-ID: <033cce07-fe8f-42e6-8c27-7afee87fe13c@lunn.ch>
References: <20240423102455.901469-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423102455.901469-1-vinschen@redhat.com>

On Tue, Apr 23, 2024 at 12:24:54PM +0200, Corinna Vinschen wrote:
> During successful probe, igc logs this:
> 
> [    5.133667] igc 0000:01:00.0 (unnamed net_device) (uninitialized): PHC added
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> The reason is that igc_ptp_init() is called very early, even before
> register_netdev() has been called. So the netdev_info() call works
> on a partially uninitialized netdev.
> 
> Fix this by calling igc_ptp_init() after register_netdev(), right
> after the media autosense check, just as in igb.  Add a comment,
> just as in igb.

The network stack can start sending and receiving packet before
register_netdev() returns. This is typical of NFS root for example. Is
there anything in igc_ptp_init() which could cause such packet
transfers to explode?

A better fix is to allocate the device name earlier. A few drivers
call dev_alloc_name().

     Andrew

