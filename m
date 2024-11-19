Return-Path: <netdev+bounces-146261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866149D289E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F684280F62
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C9B1C4608;
	Tue, 19 Nov 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUIq0ehn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CC1AC43E
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027880; cv=none; b=FFQU8/HEhcglmedb+iKvRtpzGDBLUDqfKjFyGElZbBj/VtAYWBiGxP8aDNuXINgsd4iwvM2KhA5cv3HXUdtA3stRdXHarUXpGFcUpSfwpi1dc2x1sY9vTscuxs2OGUOxxaJd3neyP5cZ0pB+yfd0B2Xxi3LemlJnwCMBTZrdO0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027880; c=relaxed/simple;
	bh=n8hPukwWauuQ67aJqQ96bezQSw5tbxCTepIr+Pn+mAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upXzqupCiVYar4+hBZtq0htQuuHHWpQU/bYFBavzN8TP5PMCO4uySwCj9c0IJ1VyIdIJTiSixVopSI6Xagqna8dUAvRNJ62SJwvZlc9hEWKyXtMNVNvdRICx7LmXwCp+FiQaaXPYPFz7cCdd8OmE7AG0YDv6Y7Rc/dLDTWwEv48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUIq0ehn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3615CC4CEDA;
	Tue, 19 Nov 2024 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027879;
	bh=n8hPukwWauuQ67aJqQ96bezQSw5tbxCTepIr+Pn+mAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sUIq0ehnZ/WdLUbKAqZPGqo6ny4FKeg9XmaNYDoVhkE/Tw8L5Y3saGAD8b4tnu99p
	 PqrsmafbIpl2hpR7VouLErkt/2KcO/QqbOS8ZFPMt1TJMt2COTGsoWpIn6JvXXBvaG
	 WYK4hYP2D84Dx5vPKA6XahAAYhvKdVSnp6scv/WVFehPLkwH+IVSzUYzgUtBI/0SGX
	 XfxFeRrQSFmPuDRGCoxMUaO9k64cFqLH62IJ18JzVUOYHNVeM4tLDkhfJbgyjNFsw0
	 VLc2D9fFKQYa9C1gVBuFOE2iyJz5Allq7xDskZNZO93szmLEQt8fao31Uc9MbwP3I4
	 FQ0XBoq6OcOOw==
Date: Tue, 19 Nov 2024 06:51:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Carolina Jubran <cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, donald.hunter@gmail.com
Subject: Re: [PATCH net-next V3 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20241119065118.24936744@kernel.org>
In-Reply-To: <ZzykxEIYZPjjRbVy@nanopsycho.orion>
References: <20241117205046.736499-1-tariqt@nvidia.com>
	<20241117205046.736499-4-tariqt@nvidia.com>
	<Zzr84MDdA5S3TadZ@nanopsycho.orion>
	<b4aa8e75-600e-4dc5-8fe1-a6be7bb42017@nvidia.com>
	<Zzxa13xPBZGxRC01@nanopsycho.orion>
	<20241119063313.5bc46276@kernel.org>
	<ZzykxEIYZPjjRbVy@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 15:46:28 +0100 Jiri Pirko wrote:
> >> Not sure. Perhaps Jakub/Donald would know. Ccing.  
> >
> >I haven't read full context, but all "nested" arrays are discouraged.
> >Use:
> >	multi-attr: true
> >and repeat the entries without wrapping them into another attr.  
> 
> But we need to use the array index. It looks a bit odd to me to depent
> on the index in multi-attr in general. It is not guaranteed other
> atrributes don't get in the middle. Ordering should be maintained, that
> is ok.
> 
> How about to have a nest that contain just one multi-attr attribute?

You can make the entry a nest and put the index inside, if it is 
significant.

