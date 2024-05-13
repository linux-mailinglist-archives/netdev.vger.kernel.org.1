Return-Path: <netdev+bounces-96110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B938C45E4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCE51C21066
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FE220332;
	Mon, 13 May 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G5DcfSeG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8C1CA89
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620841; cv=none; b=J3ZCSBHBk5JBB7TdmVEcWEH9sw6ynrY+X9ktODT15aAP2Ind0n9HUKmnbhKixVdIa2SVpJDO22EZh+AX7i3gZH9ld9JuBnnnQ9A4T2NiFsRdBe4gyXGWFBDCaX6PY9rJQAmwKxPZKH6/NhSpuhj3BNU2DQiLTwr6nI1oUNu0ZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620841; c=relaxed/simple;
	bh=Yl1irXY7zS6ZdKqAXZGx2bV/egMOGekvZj1V6jSGdes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdKgx4/9GHP0n+7rVoFiQujovmOxBXBXkpIHE/V1isOSA25s1pSpwW4zIgUHH3q5bl85L3fJlpgKBmVIw/6BBMGPPTLrlfy8lTqiW0rD10XsBhTNppef9eWDgucEHC95j6ICczUGD08tgO+dwtZH4KbsxmC88xkt7/QvL6P75U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G5DcfSeG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P7Dg67nTj6NsmCr27Lipct1RdGRABUIwR9zqXbH+AMQ=; b=G5DcfSeGvBgNgwWSw/IMJPlqnP
	uhaR14X7CBP0hU8M7XLS3eeB2nxSzYtdjdA43Pz+b10gfFVp9a5zA2qw9Kam/UowlDTYLsrMymP3G
	/Ojy/1RW1qEspLXflxW1TIsrJvPeha31zNz/T9LwQA2umUi6nzP2Knvif2rup4CwGo3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6ZLi-00FKC6-OA; Mon, 13 May 2024 19:20:30 +0200
Date: Mon, 13 May 2024 19:20:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/5] net: ethernet: cortina: Use negotiated
 TX/RX pause
Message-ID: <7ddcdf22-bf68-4877-8d44-eef9689f1106@lunn.ch>
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
 <20240513-gemini-ethernet-fix-tso-v3-4-b442540cc140@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513-gemini-ethernet-fix-tso-v3-4-b442540cc140@linaro.org>

On Mon, May 13, 2024 at 03:38:51PM +0200, Linus Walleij wrote:
> Instead of directly poking into registers of the PHY, use
> the existing function to query phylib about this directly.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

