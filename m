Return-Path: <netdev+bounces-216214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA906B32972
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 17:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4CE77B0772
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840A22068A;
	Sat, 23 Aug 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="meuTteMB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580FAD4B;
	Sat, 23 Aug 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755961235; cv=none; b=qQ29KsGOikiGxpH9p8cFva9QOzU/hNVWo5XWNY5Vr8+yrJkKNzh083/m80p6JE8vL6zR5+jDeiFYhF8EaZ8cZrbtIeasj4bcFNHK2LsMmqM+kHPcLzSC2+mX7fs4T/wN3cvst27fI0dbVYXDcWosnZ8KL34w9CTPR/yzzTQHwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755961235; c=relaxed/simple;
	bh=6anMMmFxMH1bFlrMan1cmYhcqvvNDHSsWn+JcL9a05M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geFTTqd8Q0Oo7muyeM8IoNfgbMnh54/w2eBxW9o193974RTcQAp+CtacqL3CajB3mxA3wMimkRj731EmWTBbx61F/OLTmoYzIQCxR+nqig6S/N8PTjmnDqAbRpAcKDIdJCJubI3SGfgPktwpSh21X9+i9s3JujbDIBuX17A3+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=meuTteMB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=izbJJKWxT6wg4mluEd0gaVyUH9jqhvLbE1m2d94sbPU=; b=meuTteMBj64Z0LpuNlGkQ0zlfo
	DFELIyNKwy9/8S60p8QiPdIRe7VTwYAIgpq+qxSaN4qyCNPd6qO7dXa5Cu1O7sZV2nyiQGVihITyj
	yeh4dLpmbb7iEjGjLmhVXp3UqVTbgqdpU5gPMGCSm0IFGNU8UUngS/2b94LrhJMJKnD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uppj7-005lNI-Mg; Sat, 23 Aug 2025 17:00:17 +0200
Date: Sat, 23 Aug 2025 17:00:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: fix ageing time for BCM53101
Message-ID: <4469d2cd-5927-4344-acb0-bc7d35925bb1@lunn.ch>
References: <20250823090617.15329-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823090617.15329-1-jonas.gorski@gmail.com>

On Sat, Aug 23, 2025 at 11:06:16AM +0200, Jonas Gorski wrote:
> For some reason Broadcom decided that BCM53101 uses 0.5s increments for
> the ageing time register, but kept the field width the same [1]. Due to
> this, the actual ageing time was always half of what was configured.
> 
> Fix this by adapting the limits and value calculation for BCM53101.
> 
> [1] https://github.com/Broadcom-Network-Switching-Software/OpenMDK/blob/master/cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h#L28966

Is line 28966 correct? In order to find a reference to age, i needed
to search further in the file.

Are these devices organised in families/generations. Are you sure this
does not apply to:

	BCM53101_DEVICE_ID = 0x53101,
	BCM53115_DEVICE_ID = 0x53115,
	BCM53125_DEVICE_ID = 0x53125,
	BCM53128_DEVICE_ID = 0x53128,

	Andrew

