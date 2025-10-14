Return-Path: <netdev+bounces-229208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F50BD95A2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F8500B2F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EF23148CC;
	Tue, 14 Oct 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tRqf0oPO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FF3148BA
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445143; cv=none; b=EtOk5UTVys5P2ckpSUYAsZAdhy2BVIu8wPRz+Te+dh5r9qP+Ljs6WROtYuzFqkl4jtJLCqNh+jJ70t61m7d9es/8+nKL2QlcLqwP2yA8hNW+qOebtORzLF+VxHgpWPC/VZKYbUtS6QMMyjaNSdihygGGQNaCaxmvjonG34PpW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445143; c=relaxed/simple;
	bh=iUSRhxn+vyRXY2nfQ3HFDIwxDwjg6bXWyWD4p3l511Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp0tCoUrkfkXuIdtkoh7rw2yjRTpWB22wKbBb2BTKdAqJaAtK7EmMkVXVkaNBaHDdc/pL1i4/Tn+9Xmggm4Gwqus6Sz69aAWRbmP/Lv16mQfqGWwFhyCqsviUzagh9y+BxJ5j5tkyuuN1cjKwzja+x28JEgBqQ7mBl+lQqPkLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tRqf0oPO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lDhbtxWg8aXYV9XYn3L8RtmAV6eSMQDTnZdHJx+MXg4=; b=tRqf0oPO5klk7vdTv58/SBeLkh
	YT69ff2y5WEjJKDVarL0qT7J2xTmfbkvwb+tr3DTt0YYSf6GDjXp4L4P9+f8krQ59xfZB8CGO4B/7
	fBnV9V19V2198ee7Jup+eQHkNF0dozZrmOYpGQhhiEalvWpQqFEzTm2FFj7+yUPtR4SY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8eCP-00AuMi-NM; Tue, 14 Oct 2025 14:32:17 +0200
Date: Tue, 14 Oct 2025 14:32:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v2 1/3] net: txgbe: expend SW-FW mailbox buffer
 size to identify QSFP module
Message-ID: <5b9b9525-65ea-45c0-93d8-5d502830332b@lunn.ch>
References: <20251014061726.36660-1-jiawenwu@trustnetic.com>
 <20251014061726.36660-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014061726.36660-2-jiawenwu@trustnetic.com>

On Tue, Oct 14, 2025 at 02:17:24PM +0800, Jiawen Wu wrote:
> Recent firmware updates introduce additional fields in the mailbox message
> to provide more information for identifying 40G and 100G QSFP modules.
> To accommodate these new fields, expand the mailbox buffer size by 4 bytes.
> 
> Without this change, drivers built against the updated firmware cannot
> properly identify modules due to mismatched mailbox message lengths.
> 
> The old firmware version that used the smaller mailbox buffer has never
> been publicly released, so there are no backward-compatibility concerns.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

