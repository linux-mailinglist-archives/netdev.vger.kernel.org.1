Return-Path: <netdev+bounces-119048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3079953ED3
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5402BB22A8F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80C9476;
	Fri, 16 Aug 2024 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a0/nDrh1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA18472;
	Fri, 16 Aug 2024 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723771197; cv=none; b=du1pqvWFm2EUhDaZ6R9ioQ+XEAZ8IOJm2MW2vX80CmN3e0VDKpYIQT6ZR782NTM+eICB3O9+C6C76GIdJgtamYTHFJ+9oA6tw+WkhwIQSIzZec3PocStnpx8GX/9sMNsv95M4sz4Em1B638W52LzlqOMHga19TC509kTxFBt6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723771197; c=relaxed/simple;
	bh=+retDJp7M+ayPuWIIf3S8CSyDMQYvux2G6wWjH4xnQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNvqszFypxi4dCAoGY629S33N6+Yo9W6NhoHjs54CoqOu3K60da29j1nKxAYmlMpO8irrABjOf9SH9JXPjR+amwvxRcSdCYi8osGjoF1PoFtLOQcP9hA/0UwXXJEZW0iZXaODRwNkQ47UxDFvVPc357KxwwRFbMN7vM+txqXBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a0/nDrh1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JtUj6xvpKQvNeVeu5yJmyAo5SaxqZV7c3AnQYwIukf8=; b=a0/nDrh1uMwjCbAFzES9zcK0PH
	gA31N/TUQ2xAXVikWQP6uRxmENN0BETTIJFkjDM6nDA2OJKPiWY88fpb/qOUbp7B5MUfLWYryDts/
	/RWaDM9SXY1lExyGTvh9y7k1ud4utSrcpkeqoeQKbU098cEW4YG9Hoy8k7Z81AdFB9h0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1seld9-004t46-V4; Fri, 16 Aug 2024 03:19:51 +0200
Date: Fri, 16 Aug 2024 03:19:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v3 5/6] rust: net::phy unified
 genphy_read_status function for C22 and C45 registers
Message-ID: <b61b5eb4-ee73-405c-aeae-0c26c66445fc@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
 <20240804233835.223460-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804233835.223460-6-fujita.tomonori@gmail.com>

> +///
> +///     // Checks the link status and updates current link state via C22.
> +///     dev.genphy_read_status::<phy::C22>();
> +///     // Checks the link status and updates current link state via C45.
> +///     dev.genphy_read_status::<phy::C45>();

Again, the word `via` is wrong here. You are looking at the link state
as reported by registers in the C22 namespace, or the C45 namespace.


    Andrew

---
pw-bot: cr

