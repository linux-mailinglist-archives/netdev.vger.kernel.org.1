Return-Path: <netdev+bounces-159811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A590A16FEA
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08877A3C7A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85E81E98E6;
	Mon, 20 Jan 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naunNDo4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333C1E570E
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389545; cv=none; b=XvoYWHUmSAqVK4iE1Xvu/fU8ZDDBbcXkiN/BI+kaE7Y9grUNPmtXpyR4tIKupXkcOAVSS5ay+tXz0pvXfkt35niyyM38Z8wteypK+hFXkMBG6ZOjji8VTPTs6o96VJVR7s4XcINxmZeorN0KEAfvaDeY6eXgttj8nvMzGHJOdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389545; c=relaxed/simple;
	bh=uCaNQv2D6zIDC9X7MmfcllqBuUeKwwME/kB9Tl+mEgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQfBhAuuvZqdrhxjCuOGonfO75O3iRF5OkNHeb8EYjSLTrAyJUbAxrj9e/ltAnFnBjTm9Vr0IjGBEcATVDiMkROxgolkIwF/NHauti5oGuOFGxBvaSz+FgvMIYDUVycluPGfA9z4clpjSjdTQ7Ht4/iWfY4HPn+GUYZvYFDAv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naunNDo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A83C4CEDD;
	Mon, 20 Jan 2025 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737389545;
	bh=uCaNQv2D6zIDC9X7MmfcllqBuUeKwwME/kB9Tl+mEgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=naunNDo4XGiszkDW5DVmr2NWAXPzht2mJqP9sv11WQb9PQrQpbGI4dnyJAGtvEy/C
	 37qwcDhG5evy3SGN/boBcWTqXweF0q1pMOzXrFUNZEAOA6p5b4gCEy0S1C/GWnlWoh
	 lrH7e4/tyiMA9jYLWVH1VnEtQrdwFMOWwgoSbibeDXlDXl3sEKXTTyaQZzKg8WQnAA
	 D8v9JqsnB/LEhRhyviSRcAJeh8DUJpRLytyJK27+E7uGvD6kXdmhzvcepM2JaDjQ1O
	 4yDgfa96OPKdl96Uma2SVwEtC+lZ4PDeismCAhk/bgoZ7Rc32RXXzdZpcS6cT1Jj70
	 0eCv1MlBhRAsg==
Date: Mon, 20 Jan 2025 16:12:21 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: fix regression when binding a PHY
Message-ID: <20250120161221.GY6206@kernel.org>
References: <E1tZp1a-001V62-DT@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tZp1a-001V62-DT@rmk-PC.armlinux.org.uk>

On Mon, Jan 20, 2025 at 10:28:54AM +0000, Russell King (Oracle) wrote:
> Some PHYs don't support clause 45 access, and return -EOPNOTSUPP from
> phy_modify_mmd(), which causes phylink_bringup_phy() to fail. Prevent
> this failure by allowing -EOPNOTSUPP to also mean success.
> 
> Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


