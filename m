Return-Path: <netdev+bounces-183894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52869A92BC1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857181B6667A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158EB1FFC62;
	Thu, 17 Apr 2025 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IspLDB+V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75266A926;
	Thu, 17 Apr 2025 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918167; cv=none; b=dV72YtnZ1Ewjj3sfFzRzkiYMqXD//4S+ZuC85GKqYnvNweUATlofw9rYJ/5JXt3VR7whJcBulubokCiBTBVG14OHpwDIoB9QhT3MkXpQDW75YyHNp2XbId5SBsn/3oRSPJWCH+9MvrlirqW71LVgiKd5hiJvqJToHWY1HdPUnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918167; c=relaxed/simple;
	bh=xCSO+aU3Agp3vem3X3Hyh06hNg3NbiYbcjqXlWntsAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeQyu3W6eUyy+Xm7p2huN6YS8uQd8mnoXJVI0WozZuk/2vRw/mCXzpEPxGz+Mgd2lqT39PQKvAuDw94lPk3PZbBZkozGX4ENXMHJ8DujM3bGRcFnAvj2UauwcLniBUwQ8Yz58DptB5GiqWVGuWC4mom0CTsJRsqeJdmZ1DNVi9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IspLDB+V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1KdVo7F91S5PkDs6oE07gvBkmD6Ico8AKRIVQJgRk7M=; b=IspLDB+VbgSMCuVEOA9xLcMUri
	X+D+MRfGX5BXM0Bqj7tpX8Aage33W1Q94WicxdYFiBiERphrWN/srFcbdyMnmNRPFrHGUm75W31Q3
	TIX4mXgqU6O3/0wfoH5W4fc2k98kFwsKDZqHsMS2VOcEIPnMTvdlUaOym++Ru7RXDoJw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5UvG-009p9H-BT; Thu, 17 Apr 2025 21:29:18 +0200
Date: Thu, 17 Apr 2025 21:29:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 5/8] ref_tracker: add ability to register a file in
 debugfs for a ref_tracker_dir
Message-ID: <9b9329b3-b8b7-4805-a996-837c1d36c37d@lunn.ch>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
 <20250417-reftrack-dbgfs-v3-5-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-reftrack-dbgfs-v3-5-c3159428c8fb@kernel.org>

On Thu, Apr 17, 2025 at 09:11:08AM -0400, Jeff Layton wrote:
> Currently, there is no convenient way to see the info that the
> ref_tracking infrastructure collects. Add a new function that other
> subsystems can optionally call to update the name field in the
> ref_tracker_dir and register a corresponding seq_file for it in the
> top-level ref_tracker directory.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

