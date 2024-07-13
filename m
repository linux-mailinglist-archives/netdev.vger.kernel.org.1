Return-Path: <netdev+bounces-111245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FA69305F7
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 16:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A751C20E1D
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF84A139CE3;
	Sat, 13 Jul 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sKGRVReP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3277213957E;
	Sat, 13 Jul 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720881714; cv=none; b=N9kyrapSfsYgIODedzHJUHuTjRVza7wd72kyUkMtMjXzQrjopbn1/Ix9OYxPGDT1NyXckT6oUEgLbN/DLz7//vh67CL20jI0wGiN+RQylCv20Kx5oluELGdp0EGo++9b9yz2TEqJ9Yirr1iEtLbiZZfFL0i7+lz5bgNbR8rFH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720881714; c=relaxed/simple;
	bh=lq1aHbUl37PMTZuPrCpKplzJKSFpje0S5Qu6bBGoyE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrHgtE1+2SSXbEV6FScMHWM3YSa+wl+BF5DI/A3ws3rs8Sc3zgUroFWDRvO/P4xmyWRfN3iW+bKVyiu9HyfvQPK9Xl7VUG5XOoAGcJCItF5SeXRTuGTBdLnDsQHAzhO2x7M4jGcBsHHwNNOy+EJKGF82l7lC2JJcfFeol5kw15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sKGRVReP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e/BXSwiXqGECBGWmSMc9ZqyV2x4E7YNDJaAAaD3oAIA=; b=sKGRVRePyxSrheYN81sicow1TK
	wz2xywaRWiZHTeRFi2SljM18oN2NyjHZE98QeUv8FvKB376Je7fWeCiR/1mbWtvxrCBkVeultnZep
	MbsrMJb6qQhrTNm9m0d2JxGLN3+GiJ1kGoR8ZNcHJzkawpAdjjoFxdfcX3RZ8Cc3/Na0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sSdwL-002ShD-Nr; Sat, 13 Jul 2024 16:41:33 +0200
Date: Sat, 13 Jul 2024 16:41:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next] bnx2x: turn off FCoE if storage MAC-address
 setup failed
Message-ID: <c9e7ab8a-9ccf-4fea-9711-11cc89e12fc4@lunn.ch>
References: <20240712132915.54710-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712132915.54710-1-kiryushin@ancud.ru>

On Fri, Jul 12, 2024 at 04:29:15PM +0300, Nikita Kiryushin wrote:
> As of now, initial storage MAC setup (in bnx2x_init_one) is not checked.
> 
> This can lead to unexpected FCoE behavior (as address will be in unexpected
> state) without notice.
> 
> Check dev_addr_add for storage MAC and if it failes produce error message
> and turn off FCoE feature.

How broken is it when this happens? This is called from .probe. So
returning the error code will fail the probe and the device will not
be created. Is that a better solution?

	Andrew

