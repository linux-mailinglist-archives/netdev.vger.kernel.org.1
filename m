Return-Path: <netdev+bounces-184920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13144A97B5C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187051B60C80
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A566721B9C9;
	Tue, 22 Apr 2025 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2g72zWP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805712153F1
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365876; cv=none; b=jRKq+RBS3KCwIJP9tZKnA0ILwx3q2eyVsOhVtWhFGMIrF9mKRNubfOKxD4kvH6wB2mg806HC8X0m6mPAp1U7y9kODBFhG1zLohAhQOUjAB5ORAm+LLzYWNxrlP/8MBVZq9lfg+uli2Syd9bMG+8km1B3UNHGaESQE5uIhGFW7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365876; c=relaxed/simple;
	bh=CHTDlU9BxgzuLjgpREQqER2HjlVFE8cfDXhpACU6sfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDZ7QoaTlEO93JbDtsN5X7JPJJQGPyxT+yGY2DjTxwmurJ/NIS+ovud1JJNLGGsAELevhGw0OVMfrcZgKAgBCiW+cQOiDm2DyzHHWGoiz2uQMYxAOPNdJWgDKrPB5TFsKN4UofA+/ERcu5f9NNqBiOJ74ofS8l2NUuF851pmbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2g72zWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49C2C4CEEC;
	Tue, 22 Apr 2025 23:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745365876;
	bh=CHTDlU9BxgzuLjgpREQqER2HjlVFE8cfDXhpACU6sfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d2g72zWPfobjVbVky4OBy87MwakggBhwwVvQkHJLijzSumzBIkdDA8GwI7Uku76yW
	 ieAsZq3eTI2smm2e5ge2lD1hRJLxVrr0jzm5xbNekLJ8yQfs3PfxlJhVoz/SDL8U9R
	 y0vFtlOVAXdNcaj9CvVA9yBv6LYJ43W/mFBuUQYimBEE+GIyEk6gUIUfoxQCzavb4S
	 B2tDgswSGv2HxO47l/qB4ABWrvIIKhTGEX019uxFIqpbJhPTI0ejJTENEe0fYqMb/E
	 2c954sTfCUfT3YhpSETxkIhDXsnsx09uD6hzIMGNZWyr5+VZxiK4IxXdQ0UuVjUGRg
	 v5mwIe/SjFhkA==
Date: Tue, 22 Apr 2025 16:51:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Alexander Duyck
 <alexander.duyck@gmail.com>, netdev@vger.kernel.org, hkallweit1@gmail.com,
 davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <20250422165114.23a36b01@kernel.org>
In-Reply-To: <e7815c91-e047-4b3e-b3e4-371f30c9dadd@lunn.ch>
References: <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
	<CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
	<06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
	<CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
	<CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
	<20250421182143.56509949@kernel.org>
	<e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
	<20250422082806.6224c602@kernel.org>
	<08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
	<aAfSMh_kNre5mxyT@shell.armlinux.org.uk>
	<e7815c91-e047-4b3e-b3e4-371f30c9dadd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 20:13:43 +0200 Andrew Lunn wrote:
> > Should one host have control, or should the BMC have control? I don't
> > actually know what you're talking about w.r.t. DSP0222 or whatever it
> > was, nor NC-SI - I don't have these documents.  
> 
> I gave a reference to it a few email back in the conversation:
> 
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.2.0.pdf
> 
> Linux has an implementation of the protocol in net/nsci

But to be clear the implementation is for when Linux runs as the BMC.
It does not interact in any way with the host AFAIU.

