Return-Path: <netdev+bounces-134857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD66B99B632
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 19:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B1E1F21DD9
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC1A5A79B;
	Sat, 12 Oct 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G1hrBF1g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEBFC133;
	Sat, 12 Oct 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728753594; cv=none; b=OA8MWq25a11AAZl9S3f6Ct/V86NLMu7/9g4zjS8DY4JKLDbAzdnrP5eg9LM6sh3CUP2UTiuRGoawLJG1jb/vxm89pa4i75N8n+83oBqY77FlJDm6AaJLymNb8h/pDTsOaf/sp1MpQgydsc0KBAHUyjMkHXnmlFnrzLw0ojOo42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728753594; c=relaxed/simple;
	bh=E5EA3yaO7IT/VzWRUHmP/Bp4fD30YgNPM8dQ/IhI4Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3OJLi3khleqzjKxyJdzk/UPUpk9Oe2mBjbrQaAGCkbrpoOBgHzDngUg/TpiW+dxI60oKtPm2tqn4DXDvZGlpbS7FZ0RWMKraXPQ6a988bktameRlCNM4JYqjV9B6TvHAmPppGDtdq0p+K9NMfvbD2Wm/TF68MAKFn+NTLrnIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G1hrBF1g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XKaJLtZDVliGjLJYfhaXiQTeTZJZyVMiRKaSEE2p3qM=; b=G1hrBF1gxqg1Zl4K8+0ov+vPxP
	gaVytrEBkhRk60KA3xdbP5vvGXhsf7lH6s7kvV5bnlKKxOngng2Jnrqr/8OiR60um3Em8/6jg2SwU
	F/BOIikl2HrUbfILd/2qchL6SSIOldEWKC4iWn70NzQB2BA+k1KxQaVmd3C/0fKsdDyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1szfmE-009oFS-6q; Sat, 12 Oct 2024 19:19:38 +0200
Date: Sat, 12 Oct 2024 19:19:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: aquantia: fix return value check in
 aqr107_config_mdi()
Message-ID: <29cd3478-378f-43de-8733-28369b6c02bc@lunn.ch>
References: <3c469f3b62fe458f19dc28e005968d73392f9fa3.1728682260.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c469f3b62fe458f19dc28e005968d73392f9fa3.1728682260.git.daniel@makrotopia.org>

On Fri, Oct 11, 2024 at 10:33:52PM +0100, Daniel Golle wrote:
> of_property_read_u32() returns -EINVAL in case the property cannot be
> found rather than -ENOENT. Fix the check to not abort probing in case
> of the property being missing.
> 
> Fixes: a2e1ba275eae ("net: phy: aquantia: allow forcing order of MDI pairs")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/all/114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com/
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

