Return-Path: <netdev+bounces-230568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E830BEB29A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56992744783
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226FA331A5F;
	Fri, 17 Oct 2025 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AePaVdj0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B173321C5;
	Fri, 17 Oct 2025 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724711; cv=none; b=gkCjjrTBlSHxPCK4MAUdj/zP6m7UKh3h2FJ9QJUrzVJ87Cpqax3lzAVC5fyfuonrUBdGy8dc4J6zoAY9SFNrHQhgcheIm9Omnrs0eiF8rwqNs195x3zTbaPF7Oh9YNTDYJD7w0R5F8MSVKj9wSvRmbcrr3wIwtG8IwfL3yT0SrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724711; c=relaxed/simple;
	bh=AfvyLrD2MprehfQJtW59x3ndS/QL+h3U1/KKyP8RNpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3KeRoz26proHH4akkCjbgOW+xRSkPrWG7e9Amcrfu5boBDGYLYm3HfLVyA7+0K+1wcxm7JCFrowFrYf+PrIEEAZBLhJsHwjN/EBTW4ny3Z8VQ3BzCTcEsc8cb7FeBIZcTL46qdIBp5mKCNGHgjnFinLB/QKKf6/gdXOhCBhbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AePaVdj0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LCYHUvL1cfzz2dR9mkOd9+s2TW4qdor+4CL9axhvg1s=; b=Ae
	PaVdj08qvDGwX1bRLTMdXl0o8FPT3ta3mJDlMejwqRboxeNoFOh27cCuirqFf6o3snIimLNMJg05Z
	ApPPhIvio+ChqoNZXk4TV+B5Q49mpHykTM1wR2NpEU36vJsYSTPpDAkC8P2/VgoJRJ+gH+fvI7JLy
	YXOWNf0OO5j9mgo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9ovT-00BJZZ-UP; Fri, 17 Oct 2025 20:11:39 +0200
Date: Fri, 17 Oct 2025 20:11:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 10/15] net: macb: remove bp->queue_mask
Message-ID: <2f4af5fd-88af-4f43-b006-c9f5733c303e@lunn.ch>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
 <20251014-macb-cleanup-v1-10-31cd266e22cd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-macb-cleanup-v1-10-31cd266e22cd@bootlin.com>

On Tue, Oct 14, 2025 at 05:25:11PM +0200, Théo Lebrun wrote:
> The low 16 bits of GEM_DCFG6 tell us which queues are enabled in HW. In
> theory, there could be holes in the bitfield. In practice, the macb
> driver would fail if there were holes as most loops iterate upon
> bp->num_queues. Only macb_init() iterated correctly.
> 
>  - Drop bp->queue_mask field.
>  - Error out at probe if a hole is in the queue mask.
>  - Rely upon bp->num_queues for iteration.
>  - As we drop the queue_mask probe local variable, fix RCT.
>  - Compute queue_mask on the fly for TAPRIO using bp->num_queues.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

