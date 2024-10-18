Return-Path: <netdev+bounces-137029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8E9A40E2
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965AE2820B6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728051CABA;
	Fri, 18 Oct 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iTdWkaEv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E25520E303;
	Fri, 18 Oct 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260946; cv=none; b=pLq31V1+5siEG5j9EDDshax1dPbFx5f/HpbkZfeav0/tIY6521WxoHhR3t/goU9inbv0EoeqHWBU0lwMyYRIPPMb8/rtANjQwhMVaHZ2RYImRQDAVZpZSX6JyH8AC/qTPeai8oxe+tLr/od6KUb4bHPe69p3U6u9Z7p0syl0dlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260946; c=relaxed/simple;
	bh=sp/8VgE247oHOKA2IfXDk0dpU8OMXWAdY/t6SGxUoPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn5EP89w2koFn+62z+n/j8koOJpkz+hSOd7lhNXsvAqAzUDwGzqZV7ko8IA0ECZjyoEKxBNPD4S81pzXHNF/+kNlGPe28+ExJnVJKPcPvrTArF+J50/ZMSnCFtbJvmqiTfBSzv7LWjS5/XMipd+l2Iv5ZxDgefBb6Uetz+dRgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iTdWkaEv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WZsAM426OdvH2MtOAXw6j7kHoBSScDVPPwZ+JOdmPYY=; b=iTdWkaEvbE5SbnZBoNK64XbABz
	zHqOM4p5eH4edVXAIOXw7r1cCf3m9QgCA0O76euTPGGAxUxBlVGEYxWCzdFchhCMRJ03EwXe2R5hn
	GKm+UumZXb3T2RYSo8aVZWtZA+BwnHzN1WVgNQpU/ZIaRVWv+dpPOVUludVw4LuRKtN4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1nlG-00AXgE-2U; Fri, 18 Oct 2024 16:15:26 +0200
Date: Fri, 18 Oct 2024 16:15:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/8] rust: Add read_poll_timeout functions
Message-ID: <146d0bce-19c8-49bd-be9f-511c8e9b21e5@lunn.ch>
References: <20241016035214.2229-8-fujita.tomonori@gmail.com>
 <CAH5fLgjk5koTwMOcdsnQjTVWQehjCDPoD2M3KboGZsxigKdMfA@mail.gmail.com>
 <CAH5fLgi0dN+hkTb0a29XWaGO1xsmyyJMAQyFJDH+geWZwsfAHw@mail.gmail.com>
 <20241018.171026.271950414623402396.fujita.tomonori@gmail.com>
 <CAH5fLghpBDKEwW9maYD57O9+FuMDtVUJm7Dx6JdvjS2p5ZQNbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLghpBDKEwW9maYD57O9+FuMDtVUJm7Dx6JdvjS2p5ZQNbQ@mail.gmail.com>

> > Ah, what's the recommended way to get a null-terminated string from
> > &str?
> 
> In this case, you should be able to use the `c_str!` macro.
> 
> `kernel::c_str!(core::file!()).as_char_ptr()`

Does this allocate memory? In this case, that would be O.K, but at
some point i expect somebody is going to want the atomic version of
this poll helper. You then need to pass additional flags to kalloc()
if you call it in atomic context.

	Andrew

