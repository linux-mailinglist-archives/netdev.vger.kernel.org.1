Return-Path: <netdev+bounces-183523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5824FA90EAA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715BC442308
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B22163B6;
	Wed, 16 Apr 2025 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="425W7OW4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D62DFA36;
	Wed, 16 Apr 2025 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843001; cv=none; b=p3650x2mj3xVLmlzD0kFnt5PaB+lfkZBwLeepG1mqrxgjcm475zEHY7PuRDDFWOd8/i/gjFB7bV8OEmtwoCg01ORDA7BpO8/I0Ygdh7Hkoi2YJTUcCb4Ewm3N2tKIkx3gVhFas70v5z6dVBdMTFT0PrDHC/0Gfyn5g8hiF/BAsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843001; c=relaxed/simple;
	bh=qWCJpIq5nqC52G7AQRcnhnyie+0Vqzdr28ats0XW6+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYrjEpK9OMbAss1hIVds2GLe5ulZudz2TCW1nVUKZucFUsYj9L2IjRUGp00CyQZ5XiF7lqhb3ZFpQaC7p85/wGGaJhyPc41pepy0z/BAU/gEi1Ox1dVyomTdz+NQwYzE0UWgMYRWN6NYejHLVZB8Z/jmS8RpSvIgQJZC9XoJ9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=425W7OW4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=45AQq6vMfrfPnLYZSkP+KZnlLff3ShTlcMOWgtQUZ6U=; b=425W7OW4jEdG1jYtVbqDt34q00
	swdvVuT9t4ZjKA87xolZDenRyzmJamztsXIai83+0J9vZT+xgsYnfYRwIig6oAIe1O7i0BhghBL44
	yuCpRWpdrDDf/lFoRie3xnJsdWKAe1c6jRqAilT1lb5KySB+c1L4MWbS11S1lz6LtWaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5BMv-009hb0-Ok; Thu, 17 Apr 2025 00:36:33 +0200
Date: Thu, 17 Apr 2025 00:36:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rutger van Kruiningen <rutger.vankruiningen@alliedtelesis.co.nz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v0] net: ethtool: Only set supplied eee ethtool settings
Message-ID: <6694f2c8-cfc8-41ed-9ceb-3e0b10aec6b9@lunn.ch>
References: <20250416221230.1724319-1-rutger.vankruiningen@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416221230.1724319-1-rutger.vankruiningen@alliedtelesis.co.nz>

On Thu, Apr 17, 2025 at 10:12:30AM +1200, Rutger van Kruiningen wrote:
> Originally all ethtool eee setting updates were attempted even if the
> settings were not supplied, causing a null pointer crash.
> 
> Add check for each eee setting and only update if it exists.

I see what you mean, but i'm somewhat surprised we have not seen this
crash. Do you have a simple reproducer? I just did

ethtool --debug 255 --set-eee eth0 eee on

and it did not crash, despite:

sending genetlink packet (44 bytes):
    msg length 44 ethool ETHTOOL_MSG_EEE_SET
    ETHTOOL_MSG_EEE_SET
        ETHTOOL_A_EEE_HEADER
            ETHTOOL_A_HEADER_DEV_NAME = "eth0"
        ETHTOOL_A_EEE_ENABLED = on

So it only provided ETHTOOL_A_EEE_ENABLED and none of the others.

	Andrew

