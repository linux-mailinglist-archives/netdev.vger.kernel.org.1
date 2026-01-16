Return-Path: <netdev+bounces-250584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C231ED379F2
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 747103004F1E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C8337B91;
	Fri, 16 Jan 2026 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cHNVRQts"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C623D2B2;
	Fri, 16 Jan 2026 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584226; cv=none; b=G6Wob2rMERVvnhGrJgTPv8Sm7a8cJjePH+VBstq90I2t0X1A72gwwSHHBKjpUKw0gvE3YSkOMPaWoN39B9UyhGjpdnx6o1vx1JnC7hGfF838am+Qy0fKAzrdH8HdY3fREMz1FfPNs86rZWExvQ/1RdMno0O474p7D+JXdWWqjwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584226; c=relaxed/simple;
	bh=GVh7cRTdfrinz7j06+o0SpknmSx2dwVUTC6dhGWGMu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4GMDamj7pq3wYg0micxRsbz0+0V+aiAtz1lr/12ppD0CQkAxT5BqTOeK6HY9/efwkvyI0lBJACrucpmToC5NZAUCL1D4xSftqZsyISCv5B6dTV0YIU+9PDE7ijmu1q17VWt627jOqWodAS3I8zlFVOcA36DRv/QIqssuDec9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cHNVRQts; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1GzRULt8Tsp0YZr10Rjqc+u3hQoQsE+Jtq4T+leliK8=; b=cHNVRQtsZTyVqzUN3mPiS+rkqu
	tLLSUErUAwrNyo1omM5geeFItBYV5EAhj9Zm9kM8TxjIOMbw8n13zzfodspa8wTO0JbYVLIEB/xAY
	ynj7bLcFp3ZkXHO7pCwBqNbacou9Pj8hIx1qZIhGU0Zc9KpxDthmd/Kk6ygoZiinV7b0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgnXl-0036Cd-M8; Fri, 16 Jan 2026 18:23:29 +0100
Date: Fri, 16 Jan 2026 18:23:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: justin.chen@broadcom.com
Cc: florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: bcmasp: Fix network filter wake for
 asp-3.0
Message-ID: <f104b361-bc3c-4666-86e7-68fd5218eafe@lunn.ch>
References: <20260116005037.540490-1-justin.chen@broadcom.com>
 <20260116005037.540490-2-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116005037.540490-2-justin.chen@broadcom.com>

On Thu, Jan 15, 2026 at 04:50:35PM -0800, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> We need to apply the tx_chan_offset to the netfilter cfg channel or the
> output channel will be incorrect for asp-3.0 and newer.

If this is a fix, should it be queued for stable?

   Andrew

