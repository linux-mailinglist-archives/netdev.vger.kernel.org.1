Return-Path: <netdev+bounces-131197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F5D98D2F0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06221F23382
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8D1CF7B4;
	Wed,  2 Oct 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P92+ui/y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD81CF7AE;
	Wed,  2 Oct 2024 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871537; cv=none; b=NYZ8nrI4NqamP+rp8HDj3kHGFDCCCq/AKWlOXEWV0KL5QwOy7rZiDuHCZZozfs0VlnDRNya5u7QG4Zf6fEA6EA7zSVVRqeLo9QWrDwJLjCX7YyWOQTHWGL3CBnHyMVwe8I/MiFcR0U11dlAsN3V5KYhXM4BmTRBqjU148J1T7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871537; c=relaxed/simple;
	bh=PKdoeMcD7lzOM1XvJJb2N/4Ew7wtL3xzZzq75utKfGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNBktkm4c1py91+7MwkTNzXMVt6i+/7r5wzJ0VmgqB7FnQXE8Uk/UGrO5ZpfV0qLENI/94/AgMKgiOh/2jErRMmB2v8VltBj+rBLw1TWRIcIVD906u564pvfxts16Ifye0KdXnuj4kNRyClGfsTrv+fjV5qel9e7tNfGAdWATaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P92+ui/y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ShIcHfuNuoV920IUwp6pQ1cYx2Jhnay0IFUqJdBAWl0=; b=P92+ui/yaACFwJpdfJf9j1yMY0
	ivVP8wBCk8yC5eX626xbCeDq3wxlD+N2icmUJljfhe9SN+TidXTXlFQD4PulAbjbOO4ynBWAY8ybs
	pkbbw3y/XWgqENlVAnXcij3oND6qpY08Gbxj0YtgcE669TLtVSvYcgv/nhIjL4hRKDCs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svyJY-008qxK-OU; Wed, 02 Oct 2024 14:18:44 +0200
Date: Wed, 2 Oct 2024 14:18:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
Message-ID: <e048a4cc-b4e9-4780-83b2-a39ede65f978@lunn.ch>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-2-fujita.tomonori@gmail.com>
 <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
 <20241002.113401.1308475311422708175.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002.113401.1308475311422708175.fujita.tomonori@gmail.com>

> > I would also document the units for the parameter. Is it picoseconds
> > or centuries?
> 
> Rust's Duration is created from seconds and nanoseconds.

How well know is that? And is there a rust-for-linux wide preference
to use Duration for time? Are we going to get into a situation that
some abstractions use Duration, others seconds, some milliseconds,
etc, just like C code?

Anyway, i would still document the parameter is a Duration, since it
is different to how C fsleep() works.

	Andrew

