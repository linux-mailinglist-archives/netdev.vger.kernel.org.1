Return-Path: <netdev+bounces-158293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA5A1155E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3301F16401F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28362135C8;
	Tue, 14 Jan 2025 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiPJG16d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789820F077;
	Tue, 14 Jan 2025 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897251; cv=none; b=ocGFk/JYXGIx/ahWciiBdB1qGe+Ag5Uc2o4IuDfNkk+cmq5sze45HntR6C2KF7fmLy56nNhcHHVotNQ86YaTlroqPO4ImweiErCvHcgaH5nULUox/ejKehrhQSK17b4HTcomrXn0+wy6Kjy+3pBIGi80EcCQRInMi2xkoIbN3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897251; c=relaxed/simple;
	bh=d/upMete9vj0EkqodBncVcFAMFsJvdWgCyo4hKBSqBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SN6IuvGCkQf0R90Y4znkZVsHMuogTgcfaw5kLVN+Cx6jvdJkYLzZK58G1GK80knYMTmtnvGa9HGwOIOOnImuOqRAqnWIAPiazth5pmQ09007ABvirY57KGhCJbpi1WLTkwbGLwV8ap8Gxwza9KTbBq5iajTPOejfA6Kxr4NFlWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiPJG16d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF044C4CEDD;
	Tue, 14 Jan 2025 23:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736897251;
	bh=d/upMete9vj0EkqodBncVcFAMFsJvdWgCyo4hKBSqBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MiPJG16ds8cS0q/mQZFQrhkKQWx3Gg8JdeSkIj5TAkNgwnZEHj/R+901XAqPaMWqJ
	 koPIKtC+TsnIK58b8cYtTDYLD8XVwyxaFBJxIfw4DnRSrhnF3I6ut0IGVfCFtWN5Uv
	 ivQY1csluyO0KEMulzJBfXQ0D90Q++z2Tw8tSeu3zTHuh6CUPr+vGUqg2IwXPrfFaq
	 +3he+sQ2fgmIShZONaljmzdmCp/wje9zT2xebqO3t1jA+v4KlWboIK2M5xrqWNWVZN
	 cj/PFxr/CA0+EJVqbk7jI3fa5JP7QgwCWIO+uLhlhGyn2vNv9FroPW2mTXmhVv3nQz
	 sYG10ELbo0Fkg==
Date: Tue, 14 Jan 2025 15:27:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, Julian.FRIEDRICH@frequentis.com,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 upstream+netdev@sigma-star.at
Subject: Re: [PATCH v3] net: dsa: mv88e6xxx: propperly shutdown PPU
 re-enable timer on destroy
Message-ID: <20250114152729.4307e3a8@kernel.org>
In-Reply-To: <20250113084912.16245-1-david.oberhollenzer@sigma-star.at>
References: <20250113084912.16245-1-david.oberhollenzer@sigma-star.at>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 09:49:12 +0100 David Oberhollenzer wrote:
> @@ -7323,6 +7323,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
>  		mv88e6xxx_g1_irq_free(chip);
>  	else
>  		mv88e6xxx_irq_poll_free(chip);
> +out_phy:
> +	mv88e6xxx_phy_destroy(chip);
>  out:
>  	if (pdata)
>  		dev_put(pdata->netdev);

If this is the right ordering the order in mv88e6xxx_remove()
looks suspicious. We call mv88e6xxx_phy_destroy() pretty early 
and then unregister from DSA. Isn't there a window where DSA 
callbacks can reschedule the timer?
-- 
pw-bot: cr

