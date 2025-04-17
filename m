Return-Path: <netdev+bounces-183898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35450A92BD6
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0D61B6676D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4793E1FF5EC;
	Thu, 17 Apr 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5BeXGUbt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B31FE478;
	Thu, 17 Apr 2025 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918274; cv=none; b=CWPgZ2kViaSXXM6UZe+crrJme+PblAaUOByuMH88mH49kpixIO3RokhcOAM0Y2rK81KogypOqoIzmmi9Kqvj4e+taIHHToZTx3IInswhN2bwj0/lm9NAMLymeKM9dqv2kYWv0OXjiQLgBk8/d22YdiGUrfLjWDgP+M29ayyZ6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918274; c=relaxed/simple;
	bh=RJ9g6jpglUeERJ25XTGm7P5Ldko8LQO56JFMGn4hLzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZTBmpbfQOe8jHgub49GFwhQDXdrszwdknWQ7D16RILQx/tnzJ2p/mek0IKPmtn27gM5zz9+tpF12V/TxioMmDq51F4jT7G2zIajUzBxQ5rb1DnsCg/kk/60V8Dc5a6xNSOxabbru1atP3PBAbx0L0rs4PaKsjvzlZlE7mq2bZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5BeXGUbt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fPcbiSJeC+0zCzhQibzB20NAhfCSI2b4EiOypolDksc=; b=5BeXGUbtrKestdkIbST+csGpyZ
	L50MNHgRa6sMXSLFL0h8XeL+Bmn7rfxzFkmrG0cxBV3MenoIsJYU7ZbyO4STZIZmdJ+l9CnW763VN
	EcXxv5FhrUeWbFGDdyX/V3VWSbqy/SouE+RU0VcwJZhUOIL7Mm1krG4tF6TwP7O26Udc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5Uwy-009pBU-JW; Thu, 17 Apr 2025 21:31:04 +0200
Date: Thu, 17 Apr 2025 21:31:04 +0200
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
Subject: Re: [PATCH v3 8/8] net: register debugfs file for net_device refcnt
 tracker
Message-ID: <a73a254e-9a03-4259-9116-a81de5f37fd2@lunn.ch>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
 <20250417-reftrack-dbgfs-v3-8-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-reftrack-dbgfs-v3-8-c3159428c8fb@kernel.org>

On Thu, Apr 17, 2025 at 09:11:11AM -0400, Jeff Layton wrote:
> As a nearly-final step in register_netdevice(), finalize the name in the
> refcount tracker, and register a debugfs file for it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

