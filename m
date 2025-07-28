Return-Path: <netdev+bounces-210419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D25B13327
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 04:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73E41891968
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 02:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A811EA7F4;
	Mon, 28 Jul 2025 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oPQLvFP3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121C02EAE5;
	Mon, 28 Jul 2025 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753670991; cv=none; b=VWijXYAhQRi6i+Oa0hwwhvZSUncrUMklGzhdHw1765R+mekGOK+rEfGSRzwp0gpi+ZVBsrNUY3SnOLIjrNIIjX8L4X0mxdrjubnwcLek1ywMSOaxzmtsXNpT0mBaUtztH8N8fd1j273jK2pRNdXOKV4koJAxijdkj7nJQBXBcTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753670991; c=relaxed/simple;
	bh=AVuRZOvYZsiFfwU6cAIHhxNEFaYF8i+dnfrjAK3EgsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9WD6fLJcQQ6QuLo7fNMWm1XuoT7sAwLsMDAhseYKrdPyxgsH0Dp9kDS3fZ32iM1bVhgkRorcHKJmztVdcz8wnjbUZKl/NpUhzkjDdIJWtRwmjp4AgLc9ZQc2QZiuzqRyvfgIAT9eowN5JuM/WeG6Yku0M1tginqXw3hV6xEOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oPQLvFP3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=as/pGkfaKJZ4VchcYP1ApYHiu/TLHPFvOgtxMx7Fe6k=; b=oPQLvFP38Eb+Qifd2IydHclM2/
	F7Quz3N0r9OT54iE+OzE8LA/ZQ+90hyp1bSbA8Tq3IpbntFNshji7Qe/Esu5A3L1WN6HSiqWAi+YZ
	QNU8eB0FFqjTQvDuv7wf/9OleEljzvLYJXifdMk7sO/0pEF6/DWHjp5gpiO6DSZzzFxs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugDvg-00337A-0n; Mon, 28 Jul 2025 04:49:32 +0200
Date: Mon, 28 Jul 2025 04:49:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tian <27392025k@gmail.com>
Cc: irusskikh@marvell.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: fix overwritten return value in Aquantia
 driver
Message-ID: <c42fc24b-2cd5-4598-a4bf-b088325c3d14@lunn.ch>
References: <20250727231750.25626-1-27392025k@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727231750.25626-1-27392025k@gmail.com>

On Sun, Jul 27, 2025 at 04:17:50PM -0700, Tian wrote:
> From: tian <27392025k@gmail.com>
> 
> In hw_atl_utils.c and hw_atl_utils_fw2x.c, a return value is set and then
> immediately overwritten by another call, which causes the original result
> to be lost. This may hide errors that should be returned to the caller.
> 
> This patch fixes the logic to preserve the intended return values.

Please include in the commit message why it is safe to OR together two
error codes.

	Andrew

