Return-Path: <netdev+bounces-228526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9BEBCD589
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B1C42536D
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB02EFDA6;
	Fri, 10 Oct 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gG5ajnbC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8812EFDA5
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104307; cv=none; b=EWrcFqmlgwRhWBqZWS3rw7QDWE6kKkF4GJoQuLnTmaXdp4CG1oQT5QLhxM/++vCb9D0NW5pZx29IDsLE84ooyBed3zfAULFXDAlGFacHGl2oLnby8z97fe/TQsVrOvPG8rdQzQKehtbjrIbdOUeSxqrD96LU3TCXvT3RvczELUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104307; c=relaxed/simple;
	bh=aP6KvYdPFnC1vI+uIAbFW9bWLn2//lbUQyyA/EzmnHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMeFhrlv3RTt/NlFsCTEpuLRl9pJWuWpg9JpzUxhsG3+Nk+XReTjSHNTKg1d15EdSY4eN6Q+Osjg3HB3rl1KJdW1V7FSFcwXYyjfErsvAP4UF9o8kFl1iANlyyVOF7+qI3Qmuw0PmIssrwc55REVCUnqmDQ5q59BviVoQNqbfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gG5ajnbC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7YzZen0SnBLJiOgQiQY4Nuyrw85yOhaGlINCM33I34M=; b=gG5ajnbCAGpAQks51R5Vyf++qF
	JwR7KAn+3gg1j2RuzCnNmWj0UJ1fSnW3jeWaJT4jasykFIIF9b+2mXaonPnw7/fGBjFMrvhCCqVfG
	EhP7IaMPP3j9CspLtRnaxipvuV16HTAWs9wJq/RdZ4ki7JiuuuejZlKkLjRBC3twqoDQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v7DX0-00Abj9-63; Fri, 10 Oct 2025 15:51:38 +0200
Date: Fri, 10 Oct 2025 15:51:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Jakub Kicinski' <kuba@kernel.org>, netdev@vger.kernel.org,
	'Andrew Lunn' <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Paolo Abeni' <pabeni@redhat.com>,
	'Simon Horman' <horms@kernel.org>,
	"'Russell King (Oracle)'" <rmk+kernel@armlinux.org.uk>,
	'Mengyuan Lou' <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next 2/3] net: txgbe: optimize the flow to setup PHY
 for AML devices
Message-ID: <f76ed32e-b007-484c-a228-4b7774a49020@lunn.ch>
References: <20250928093923.30456-1-jiawenwu@trustnetic.com>
 <20250928093923.30456-3-jiawenwu@trustnetic.com>
 <20250929183946.0426153d@kernel.org>
 <000301dc39ba$55739250$005ab6f0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301dc39ba$55739250$005ab6f0$@trustnetic.com>

On Fri, Oct 10, 2025 at 03:48:57PM +0800, Jiawen Wu wrote:
> On Tue, Sep 30, 2025 9:40 AM, Jakub Kicinski wrote:
> > On Sun, 28 Sep 2025 17:39:22 +0800 Jiawen Wu wrote:
> > > To adapt to new firmware for AML devices, the driver should send the
> > > "SET_LINK_CMD" to the firmware only once when switching PHY interface
> > > mode. And the unknown link speed is permitted in the mailbox buffer. The
> > > firmware will configure the PHY completely when the conditions are met.
> > 
> > Could you mention what the TXGBE_GPIOBIT_3 does, since you're removing
> > it all over the place?
> 
> Okay. It is used for RX signal, which indicate that PHY should be re-configured.
> Now we remove it from the driver, let the firmware to configure PHY completely.

Does this rely on new firmware? Or has the firmware always configured
the PHY, and then the driver reconfigures it?

	Andrew

