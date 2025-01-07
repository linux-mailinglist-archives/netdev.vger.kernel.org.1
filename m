Return-Path: <netdev+bounces-155855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E21EA040EE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31383A0799
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355741F03F7;
	Tue,  7 Jan 2025 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NAlPt8cB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C51DFDA4
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256956; cv=none; b=L71p8Kb0bN04AgcpPAD9UJHhbHvSpHgZMjeG79stMnxpF+3Kdp/+B+YXd+PiOXh0bASF9xO7CrWdQyWPDAjSLT5Txq2ucFm6jfaEj8ncNpupALa8y6gDPRfkfivDiPZ0aLxSFY+BtWIxgpi4DnSKcxnBozMko/Yh0pvbl5e8tMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256956; c=relaxed/simple;
	bh=hwq6JyzR+l8FtHX7QDft0HWOvQLffMGn0i8Z0A2eNwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akK6t217wcRR3yf8OfnEWdnSx8D9kyPbDL2QJmIgGfPf8ppdnVvpgQ7i2Az+lmMsJE1tDLFzAGVO9W4zrt1fItUcZLgs1kEQRvD+cw59jYTYlU2j6T4j87+6/xDnssXQZpofQhMwXaDS7YxIoqZbW7u2yd2goKJ3lAkin/fkGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NAlPt8cB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MXlzbDz1LjcDaXZJVbcZcnKnYwbw/otVAmCjNXUCMuw=; b=NAlPt8cBZpY0frzkHSh4T/ISo2
	ranf+o+V96z1LgKf6UKy7LE837SLn/J4CvGcQ6Vo9LQlbA99Hrp4HoLhm3oQ5gr8JEHF/Q29QD8WN
	znDe1+0ZDT9MJDRUFRa86zcMxVo1iDyHg5Z6Hd+NcBZwYVT+ng95gHQm8aKeJu3qOshQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tV9kG-002F3a-6T; Tue, 07 Jan 2025 14:35:44 +0100
Date: Tue, 7 Jan 2025 14:35:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next 1/2] enic: Move RX coalescing set function
Message-ID: <a6f55884-53b3-45a0-90bb-2a633ad5c56e@lunn.ch>
References: <20250107025135.15167-1-johndale@cisco.com>
 <20250107025135.15167-2-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107025135.15167-2-johndale@cisco.com>

On Mon, Jan 06, 2025 at 06:51:34PM -0800, John Daley wrote:
> Move the function used for setting the RX coalescing range to before
> the function that checks the link status. It needs to be called from
> there instead of from the probe function.
> 
> There is no functional change.
> 
> Co-developed-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

