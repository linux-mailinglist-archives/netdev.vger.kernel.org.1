Return-Path: <netdev+bounces-140705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3579B7AFA
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0481C21D65
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968CC19F135;
	Thu, 31 Oct 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P2NEWXBW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ECF19E7FA
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378613; cv=none; b=gQErZj/DOOvdwcsCpiOkNHDML62ET0QC1U2dez58e390w0Wzy2ac133Z2TGdstAaZNB+z9vJJA5qdNBPPvoG+FftjJoUHC4KVUdX6Vtybq30j9K2U6A+ELEjW+1cTqqRZLajWJjptWERXvtYvAj0XxDBGx+zta0bPduR71gxPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378613; c=relaxed/simple;
	bh=bocSY7vbMicEhDBpc3OxOM6h7JPzn2rWWWwKJqgosp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bURKr7Rb0Zuy5SJI8CEk4B6ylTg5or5nLSajyblp+mwJI8mI/0V7nCZhRHS1eOdG3XwfMY7QzgXOjuqgRpWASz/9+jzzinbztybAxFgkM+pterITmu2sWJxUuboTgTJPr8eXrVtXP5SPcPlSN2jxvKXf2GiZcpJqBdFYKIalRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P2NEWXBW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2x764qeI5+g0J2JFcSYLK0w4dQfCOCuN31kxwrQrzac=; b=P2NEWXBW+fdYe/MRySXXTczCWc
	S2qZ/PYtotVCB+lLGlvTZDDPjDwlgvkLQxGoFqImyTUcgA/22XYXOzhKAiJKGwD04yFTwCaGCwK8t
	E4z/ooAThaqWPk+fxF1QHrXYhQkeVbnHoqR+mGfV6QbiAIpomBP6npIxE1xfzCJ1dPB4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6UWC-00Bmd6-3n; Thu, 31 Oct 2024 13:43:16 +0100
Date: Thu, 31 Oct 2024 13:43:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
	sdf@fomichev.me, vadim.fedorenko@linux.dev, hmohsin@meta.com
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
Message-ID: <4bc30e2c-a0ba-4ccb-baf6-c76425b7995b@lunn.ch>
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
 <757b4a24-f849-4dae-9615-27c86f094a2e@lunn.ch>
 <97383310-c846-493a-a023-4d8033c5680b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97383310-c846-493a-a023-4d8033c5680b@gmail.com>

On Wed, Oct 30, 2024 at 05:51:53PM -0700, Mohsin Bashir wrote:
> Hi Andrew,
> 

> Basically, in addition to the RX TCAM (RPC) that you mentioned, we
> also have a TCAM on the TX path that enables traffic redirection for
> BMC. Unlike other NICs where BMC diversion is typically handled by
> firmware, FBNIC firmware does not touch anything host-related. In
> this patch, we are writing MACDA entries from the RPC (Rx Parser and
> Classifier) to the TX TCAM, allowing us to reroute any host traffic
> destined for BMC.

Two TCAMs, that makes a bit more sense.

But why is this hooked into set_rx_mode? It is nothing to do with RX.
I assume you have some mechanism to get the MAC address of the BMC. I
would of thought you need to write one entry into the TCAM during
probe, and you are done?

	Andrew

