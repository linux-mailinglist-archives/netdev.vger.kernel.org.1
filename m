Return-Path: <netdev+bounces-143419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4759C25BD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9711C2335E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657E81AA1E0;
	Fri,  8 Nov 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e89+0a9x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C61A9B52
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095016; cv=none; b=Cq25zUn/dHp9SXZtKEIbY89Y6/8qYfCY+G+TJ/bVH++NFBlDMdqbmRfbVKlo9o1H4IpPVea9od4+007k1514HOUd6zJC+idb3Q4ngktIOd0xWO+V65cLtvYd+RMB5AXsbqgBSNZbNzzE75sPOwH9uFK5Ps+ox07AR71YSr27iTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095016; c=relaxed/simple;
	bh=NExr6ffPpXGyEvJJiPu9KiGgD1sl5/+o020ZMWhKH0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McjG0A8SmWe81QtfGp1RP7XM8UlNSWdLev8QTNM3+xoJdBiDaoHM/F/FTZrxTf5upmYvOyl48lrkQ/lhVStgDOnd4Lmg7aGBF52t269hDIswWTgZsP/Hoa80VTG2s47cpRtPNO9uVuTRPP+dmTl2a8ioJlj+SK1l6Avz72ydOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e89+0a9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7717AC4CECD;
	Fri,  8 Nov 2024 19:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731095016;
	bh=NExr6ffPpXGyEvJJiPu9KiGgD1sl5/+o020ZMWhKH0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e89+0a9xK93wHyhc21Xc+Q8Dc6RFPpPqKH/89aVMssviSNHHs9+DoQVrivlGoi4xN
	 lCne+RY7wxGBdMf5FRzGOpYUp2A9/POdoDpkga0gS5n78ivVSfvsyhJMe8xxEZTtEN
	 TBCScftVW9NjZMc81kiMizR4LB6fzj0v0KemKzsyBRYTksP5xlZMqa2tJafXpk0XJ+
	 G3EZe0iujcbuzDHvgf9iC4dsjHaQ1CkcP/R5aujMh8dBfLv31TbwX540iZ5EotnPDM
	 0hVSvMWpNvZ7TdFEe2dqvd8kbx7I7ajyBzCgXLYHE/DhSdB95t9OxdAddz66dkZ1kT
	 ZFZ9sp2arU1jg==
Date: Fri, 8 Nov 2024 19:43:32 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] r8169: improve rtl_set_d3_pll_down
Message-ID: <20241108194332.GG4507@kernel.org>
References: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
 <e1ccdb85-a4ed-4800-89c2-89770ff06452@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ccdb85-a4ed-4800-89c2-89770ff06452@gmail.com>

On Wed, Nov 06, 2024 at 05:56:28PM +0100, Heiner Kallweit wrote:
> Make use of new helper r8169_mod_reg8_cond() and move from a switch()
> to an if() clause. Benefit is that we don't have to touch this piece of
> code each time support for a new chip version is added.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


