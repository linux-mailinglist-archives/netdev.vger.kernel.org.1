Return-Path: <netdev+bounces-246477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EA5CECEE0
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 10:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D1153007FF1
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34F52848AD;
	Thu,  1 Jan 2026 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UI4X/Qa+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B437DDA9
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767259976; cv=none; b=ErP0bGva6UDqBG8GUcsVb47mrxS5vR2zxFPDoxDxA53+LAwMP92zCU5lkhId47WHFtOO/e5R0uAB+5HrD55TDXxaxqenOOyVxzWC8J3ZLafTmQo2mnsz5OqveTuACDeXGpFWz0OHkPsMSqtT5xN6X3O/b1j0m7lHUf0bH75OisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767259976; c=relaxed/simple;
	bh=7wPFP0ujIenNuzkXEB7115SyROMWNMNdPtCFg/o4+0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is/ZJwd2ECsk+xquD7/lwXRcu0BZ8Izk/GkCRv7JckzOryBk0zIDFziQ1khzLbbee3y80NhgNiSOLThUC06aQLZ8iIPLnh8EDdXnoCvN8WpogmTht3H211dNh30QM7KUE0h3Yc/BUide6CqsOXia6J7HzkMdSPKRaFNsKT6VEoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UI4X/Qa+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wlPMXhPeCmqUSaedAgKNyIQzTnkIsBP5hHCoCErnH84=; b=UI
	4X/Qa+2+G34BjmMSTeXR1y09wWOKDCyzLGRx4BlIZHnri8fJINIsYcjNQlhjmhasJXhs04BpavPRj
	pawQ0CAg3WuMqnp1jyfim29SNpB8+/IdnW6LDJFWEP9h3FAZ0USgnlNGhmYOloonPBRu2brxlyCTP
	D27wgcOHPpNcuNs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vbF2v-00147X-Tk; Thu, 01 Jan 2026 10:32:41 +0100
Date: Thu, 1 Jan 2026 10:32:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net
Subject: Re: [PATCH net-next 0/2] tls: Add TLS 1.3 hardware offload support
Message-ID: <86879bd7-0b26-483d-b261-728d13c40b57@lunn.ch>
References: <20251230224137.3600355-1-rjethwani@purestorage.com>
 <58a92263-47cb-4920-82eb-2400005b0335@lunn.ch>
 <CAKaoeS3rRk8FGv+zb_vYuYoMAPe7gAsgxq_TKG4OcT5QkKOwjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKaoeS3rRk8FGv+zb_vYuYoMAPe7gAsgxq_TKG4OcT5QkKOwjA@mail.gmail.com>

On Wed, Dec 31, 2025 at 11:34:04AM -0800, Rishikesh Jethwani wrote:
> On Wed, Dec 31, 2025 at 1:17 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > Tested on the following hardware:
> > > - Broadcom BCM957608 (Thor 2)
> > > - Mellanox ConnectX-6 Dx (Crypto Enabled)
> > >
> > > Both TX and RX hardware offload verified working with:
> > > - TLS 1.3 AES-GCM-128
> > > - TLS 1.3 AES-GCM-256
> >
> > You don't patch any broadcom driver. Does that mean it just works? The
> > changes to the core are all that are needed for BCM957608?
> 
> The upstream Broadcom bnxt_en driver does not yet support kTLS offload.
> Testing was performed using the out-of-tree driver version
> bnxt_en-1.10.3-235.1.154.0,
> which works without modifications.

Please include this in the commit message.

       Andrew

