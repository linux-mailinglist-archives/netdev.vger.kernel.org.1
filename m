Return-Path: <netdev+bounces-121873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29D95F196
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247221F228B7
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468FF17C989;
	Mon, 26 Aug 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BFQbKoTR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E817BED8;
	Mon, 26 Aug 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675947; cv=none; b=BM93FcgaOo52yy2qjZIqTUQdfEts6ys7Ck4jy2gWZPZ3+bNne9nczPD5qRiSELIUkEsbQM8+XN2+osbxwsZbnkd/OaGdCGRpiKs6sKvxNIs6uGVcHHAezZOpl5k1o89v4MzNbFd8m0p6UbHnY11YTSJ/N+KJhDRkg8qP/Qs/n9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675947; c=relaxed/simple;
	bh=i9e0WEfEfs5VoygZ6ew0o68vtXB5PFsl1XYNpLUgsGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX8sBq4iHxJGNNv9uX7+z+oex+q8pWRx6dXpCgAO950zBXuqQYxc+JEKQOydgHAi4+bdP16RzFPoAQqfNe4mVATWU8+juAfhZr6+xHPhb2h+Vi6MKAsKv5KGB3Et2/w9s2VzxXcptlA4aPOLXYJCU1VPckFPIf7Rl/qAVFL65Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BFQbKoTR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0Gnf5Qk6YjuCabvYuN2ZYFYbV25fmkxlioNdLFYEIww=; b=BFQbKoTRdvps0lHE8anzoORlPE
	98XMl1SZys7/8nfhpDJ7HNW03PVe2HjRm/qyRDZ+qexAwasOuTbyPy9GGbfhLqTdgAQQa4xRI+kVe
	JNxnTpw8P8aS8us60hVDOhP6ye+rF4jVYEhPgOWfU4OQuBnCjBkDUQhyEfHQF8VyApi4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siYzi-005hqz-Vv; Mon, 26 Aug 2024 14:38:50 +0200
Date: Mon, 26 Aug 2024 14:38:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Frank.Sae" <Frank.Sae@motor-comm.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v3 1/2] net: phy: Optimize phy speed mask to be
 compatible to yt8821
Message-ID: <ec362c1c-0722-4e50-a695-b271348272ab@lunn.ch>
References: <20240822114701.61967-1-Frank.Sae@motor-comm.com>
 <20240822114701.61967-2-Frank.Sae@motor-comm.com>
 <a4fbc34b-5d87-449a-83df-db0cfc1bf3cf@lunn.ch>
 <cf3193b6-589f-41b7-b89a-a94ba3b751d8@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3193b6-589f-41b7-b89a-a94ba3b751d8@motor-comm.com>

On Sun, Aug 25, 2024 at 10:56:54PM -0700, Frank.Sae wrote:
> 
> On 8/25/24 18:59, Andrew Lunn wrote:
> > On Thu, Aug 22, 2024 at 04:47:00AM -0700, Frank Sae wrote:
> > > yt8521 and yt8531s as Gigabit transceiver use bit15:14(bit9 reserved
> > > default 0) as phy speed mask, yt8821 as 2.5G transceiver uses bit9 bit15:14
> > > as phy speed mask.
> > > 
> > > Be compatible to yt8821, reform phy speed mask and phy speed macro.
> > > 
> > > Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Ideally, your Signed-off-by: should be last. No need to repost because
> > of this.
> > 
> > 	Andrew
> 
> Andrew, please help to confirm that the Reviewed-by: should be followed by
> Signed-off-by:?
> 
> it should be like below:
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>

It is a cosmetic thing. Each Maintainer handling the patch on it way
towards mainline will add their own Signed-off-by: to the end. By
having yours last, it keeps them all together.

Just picking a random example:

commit 5b9eebc2c7a5f0cc7950d918c1e8a4ad4bed5010
Author: Pawel Dembicki <paweldembicki@gmail.com>
Date:   Fri Aug 9 21:38:03 2024 +0200

    net: dsa: vsc73xx: pass value in phy_write operation
    
    In the 'vsc73xx_phy_write' function, the register value is missing,
    and the phy write operation always sends zeros.
    
    This commit passes the value variable into the proper register.
    
    Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
    Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
    Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

David added his signed-of-by. But as i said, it is purely cosmetic.

	Andrew

