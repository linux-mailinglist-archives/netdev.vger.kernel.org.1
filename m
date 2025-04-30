Return-Path: <netdev+bounces-187085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A71AA4DCD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C934C6D76
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378C825D202;
	Wed, 30 Apr 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uKCtvNli"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1120F091;
	Wed, 30 Apr 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020853; cv=none; b=cTaOT1Z+fgAoBOpv3XOdHnXOisvrASSNF3SowQNXoAvWRKf/cESK2pKNxUBKGW3ybCJGf2j6pLEJmCuX8t9cJpuqOCtntb4WUUk1jOXAWCFGaTN8CKCMmEMchWgiuuJjIAxBf3FEJY4ryDRw8gAqF3f+ULSBS/+J5oo9c5/aruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020853; c=relaxed/simple;
	bh=mPLjTAxWHwLg9gyNm9BRX8KIn00KRxy7wHJdiAYmIo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMzLOdbXVmZo4oODiwTgCrUzXAXO7sCX1YXzOUs06CTtHNb0/ypCIT1eYYL5ZSzZgpWtAE6MmhtXydPHJUaEkaZhYCy4d4e/BCkJH9auHjIm389cfvaqwga+fUMap+ZRE18xIGbQTkZ1XMMoQ49fWL641uowHmhvaPCXT8zYl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uKCtvNli; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8bIs2AY9hJDk+8BWTJdPekdkEKdVhYQajXn0RhFxKbg=; b=uKCtvNliQTpmnIEy9eeO6gLbGD
	xfyxvAclAt5uyqlX8d5MAlfbE3Fl0Efin2CwfSTCJJ2pDC89hD8GQp/VaoQ9tacNowJ4dTSk8C2Vv
	dSgGglbRIp9bA33S9zKqkdcfEEaf7SSNPXdVqQ2etphvmGuWhvhnfYTsvmqbtniFjnNg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uA7mW-00BDoO-Dz; Wed, 30 Apr 2025 15:47:24 +0200
Date: Wed, 30 Apr 2025 15:47:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net V2 2/4] net: vertexcom: mse102x: Fix LEN_MASK
Message-ID: <eb7776fa-6425-4b3b-a9d8-6541c1bdf93c@lunn.ch>
References: <20250430133043.7722-1-wahrenst@gmx.net>
 <20250430133043.7722-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430133043.7722-3-wahrenst@gmx.net>

On Wed, Apr 30, 2025 at 03:30:41PM +0200, Stefan Wahren wrote:
> The LEN_MASK for CMD_RTS doesn't cover the whole parameter mask.
> The Bit 11 is reserved, so adjust LEN_MASK accordingly.
> 
> Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

