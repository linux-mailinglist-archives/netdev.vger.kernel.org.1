Return-Path: <netdev+bounces-99929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C28D714C
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 19:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443E1B22024
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 17:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1532B154453;
	Sat,  1 Jun 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDPiOt3c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542B152E05
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717261744; cv=none; b=DARTbQIv+A0jFc2R+6FOTJEDWoePSAT6pKIW+08nkBvMSX+HZ+WPwedmjf5ESXxqEKG4D7lcuPxHRY0/8AYB/V9V6ZU4ctVnmEDp/uE5FgUFCIta+d0jzHvFX1VFYzqq7ViMY3chq0IjPQO7lLRpewlBJ/U4BgdqyPvhhw5l4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717261744; c=relaxed/simple;
	bh=gWgzxNPhUBG5zxTOXWQLE2Hu4R6nhG+XOFrjGu0tIvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlDM48pQTiKP0qqMc0vyUWih+iLO3bql0eZYlNppv1LNNj6gEu1q9b5WuEXT811pvAJC5ZpcPngzcZKLN4XOos4V1mpX4XkhwA864m8PxwGgIfjaNAiKy8chlfS2FsErOPaFkrACgT86J4c8BUkWnHDT37IaQUGD1shalMvYUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDPiOt3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7464C116B1;
	Sat,  1 Jun 2024 17:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717261743;
	bh=gWgzxNPhUBG5zxTOXWQLE2Hu4R6nhG+XOFrjGu0tIvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDPiOt3cYURXJ2JMXqJ9TB4uF3OY2Qd4OE+gECbHZI6HUg91w9HxX1xNvI5Tvq/Fh
	 9c1325PGDm9d8+KFPPXEDdbQYWWXlReuWADH0P/hZpwnV3BFuULE+rzAZeodHVsoCG
	 mj9IRWbC/xvihWxM/PnEPMrmO5aaATWBqtF5tCt/w/Av9B4LJNdAVvzfJbZlDZ3zTt
	 9yqkeLo7SqB8mAuQmaxOnQXPQb1aoJOJ3dUzHJloWQc2scpaXWFq7DwhRTV5GtazxY
	 yv+39RRL/puU1pkU7ZgANXBn0+bFPh6HE3vO07sPhi58Q4BvdhlcGqymEQ9tfn05g3
	 6OtK/BBjXEedw==
Date: Sat, 1 Jun 2024 18:08:59 +0100
From: Simon Horman <horms@kernel.org>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v4 5/5] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Message-ID: <20240601170859.GT491852@kernel.org>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-6-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531142430.678198-6-enguerrand.de-ribaucourt@savoirfairelinux.com>

On Fri, May 31, 2024 at 02:24:30PM +0000, Enguerrand de Ribaucourt wrote:
> The errata DS80000754 recommends monitoring potential faults in
> half-duplex mode for the KSZ9477 familly.

nit: family

     checkpatch.py --codespell is your friend.

> 
> half-duplex is not very common so I just added a critical message
> when the fault conditions are detected. The switch can be expected
> to be unable to communicate anymore in these states and a software
> reset of the switch would be required which I did not implement.
> 
> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>

...

