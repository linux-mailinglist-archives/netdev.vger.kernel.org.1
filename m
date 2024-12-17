Return-Path: <netdev+bounces-152621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 633759F4E8A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA27B7A3B5C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737271F759C;
	Tue, 17 Dec 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkf79P8o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499841F5408;
	Tue, 17 Dec 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447282; cv=none; b=QWZ/1MPvGtF/ACyNDgYbzJxOJJZKzNu6hDXtq8zaC7u18MvJHNFPSpmslezrED6isvfPIyZxiJPrIl4R4PI9jBIXUVUVdqFUBEbxlFL/tIA8J06UpPgkA0/4+ojk+NHTXiHP6EAMbQLnVo9kXkIGmIcP+ABahKq74flpSKzNGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447282; c=relaxed/simple;
	bh=Xd328Stxc8oRYqI/Dec7c6ksGaLHbk7Wyqz4IDRV7fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOucwq2hG4h7xjtC6JhR4Gh42BhqrtyakMLIYTW4IbKFaOB+qg5MoZ2wObnbXDRnB273Yd8MvftFrHlz+9VfMDG06rUPPN3zeaG8k6lIRIQwTh9TXEn2k6U/uDhKWgtZ+cOAIRXMIfwHOnQMNeGnDBD15DjXGAvQ5mY13Jt8Nb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkf79P8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187C6C4CED3;
	Tue, 17 Dec 2024 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447280;
	bh=Xd328Stxc8oRYqI/Dec7c6ksGaLHbk7Wyqz4IDRV7fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gkf79P8oQ/DjuS37DLvM9D9fOc+Wrj49t8skrNHdqhL8U6buzA1GwBubA5o/rsssA
	 7BFgOGcu2gthaL9ZZ98mA48CUNLjVpwQnCWxvMX7MvLUENkka2aLvjkN5KIeqF5KZ8
	 f6wwbPUL8DQh1LpeZgKVRQ9VSQz4beVT1Z7QDDMLih8r7ERCS4g090fLFzJfYsSBrG
	 nMzjPr6DQPSL92+c3LkwGkjVSBinR/SWGOSxsnOSTjQ9/EyvwKNeywXwCsQNDT0jTT
	 ermo6CLeyk2dxUG3/rd6Nc960RWxs39HpAkDepDbhzMwjGBKANQtkbTBCm3oQklavl
	 EZXfvdR97L2UQ==
Date: Tue, 17 Dec 2024 06:54:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, davem@davemloft.net,
 edumazet@google.com, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, aliceryhl@google.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] rust: net::phy fix module autoloading
Message-ID: <20241217065439.25e383fe@kernel.org>
In-Reply-To: <778db676-9719-4139-a9e3-8b64ffa87fd2@redhat.com>
References: <20241212130015.238863-1-fujita.tomonori@gmail.com>
	<778db676-9719-4139-a9e3-8b64ffa87fd2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 09:54:11 +0100 Paolo Abeni wrote:
> @Jakub: I still can't reproduce the nipa (rust) build failures locally.

I'll look into it. Just in case you already investigated the same thing
I would - have you tried the rust build script from NIPA or just to
build manually? The build VM is using Fedora 41, IIUC it should have
new enough Rust compiler but I may have messed something up trying
to install the latest compiler manually...

