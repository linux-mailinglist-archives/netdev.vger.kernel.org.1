Return-Path: <netdev+bounces-138597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ED09AE41E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E96B24C1D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3381E189BB6;
	Thu, 24 Oct 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9H8lJeb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C51CFEA2;
	Thu, 24 Oct 2024 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770430; cv=none; b=HfFGk7G51u8qBqlSrnS2v6lvs9bLbn8FskmOKA4kTcO2O9PVBdjbMDNvon9NztYR+veEvFrPWi5foVIqvljVVqJCzzKOm8eFB7+ey0hGZtqIMK/roMAQAJsj9nf1ymctU//sCwQRu8Q7euozAVSv4wVRxKB8pAi33VLITrhFgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770430; c=relaxed/simple;
	bh=SJPiKVSmLSdFCzKmPxgqaKEBlut3fRo8Lwy8ODvCwEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/nnh07ZyoRc7TqQTomIKDjOpqD0y78qZnX+TrE/tw1Y5qOvJyqt1j3ig8pHLP3xfV0IxlvAbYpcYDYRCUTLb6rRtuBvsnFYGggMmdcOwoDStF+lyLQRVdQRe3IxrCJIVwNtYyrs0Zp7rG55bzJbZrt3Q/DES4D3Nv1TK9ojJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9H8lJeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF90C4CEC7;
	Thu, 24 Oct 2024 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729770429;
	bh=SJPiKVSmLSdFCzKmPxgqaKEBlut3fRo8Lwy8ODvCwEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9H8lJeb+ZvoGtGJG4TpNfFOU4B4TtyxzYzZbzR4IfL6IDt67f0+jIbaClWEaoS5J
	 NK+S/O2aKEnxacfApyOjNKiX+T2it910jeAD0yPwTx/cJjNaV46X1A6DOUKbvOMmH7
	 c6QsvVD4o4vKHGBFlipKUOvaK9tUbEPJtdXCVJTgX1T8QyUR3BiHVBokBKYb0kqTbo
	 ft/nriO/GfwFLeFVivgpghUIPm/9bQ0DeQXOuB8CRl2zhcasUqeMD456SawPnm89QD
	 FtUCuPN+9Uo/ujI1IO3lavVrhyarZaIGUgnno+rZA7NquJgpujkqZLc1seWB/hgREZ
	 iLs4URIk0a/fA==
Date: Thu, 24 Oct 2024 12:47:04 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Doug Berger <opendmb@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: broadcom: use ethtool string helpers
Message-ID: <20241024114704.GG1202098@kernel.org>
References: <20241023012734.766789-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023012734.766789-1-rosenp@gmail.com>

On Tue, Oct 22, 2024 at 06:27:34PM -0700, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


