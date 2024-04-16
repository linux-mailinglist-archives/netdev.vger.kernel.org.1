Return-Path: <netdev+bounces-88385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F180E8A6F37
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 17:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD67F284B33
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C912FF80;
	Tue, 16 Apr 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nVE1jAPp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354E12FB02
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279677; cv=none; b=AXYftZXjasdZECc9oahmBknzTujXj0VB5x2apmkUFhc9YRb1mSCqXiy4TSR6PZG3tmKUMXhgCiueXtGU+3Ogsq8yN2syQwch/hToRLZrOxpToBS98K5g3F97rllaVMiRzKUgqI8phqHeDnEap4wD8vQkyQfDQVZ+XnXa0KfoqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279677; c=relaxed/simple;
	bh=MWHKyOfKhdA9Wj8JXUeOUxHHyuouVKpvPXOa9IUBPds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Md2w0n+sA+nbn4VvMRL8r3RLTU3fcbFtTqM1inqSpO+jRnaU0FhnLom5PMF6KJy75jOWWcRsW9j256eG0YIhlqcNk5OVdQCHJhkihUYhC01l9YkdUcdX508V31PvdpL6Ewp99xXuZqgK7noYZNnNyz4nRgKHe2oGYL5ZBIDpn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nVE1jAPp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pEW5EUMDVmV+XuFjVR0be6IhtcuVaF7H9DPm5Say46E=; b=nVE1jAPpFMry/MBn5ZDpnRO97w
	ofy1e4uWmx6qxp9ABQ7U3dlocOlm4Ny5h71/cUtY6aYteSd1XF7vv5K+KDCeiSaJ2JeR6kxapfV0N
	X0FBhWmduys28Zkj2SzTkqSQcVPvTyT38OM9gQxVK/W8CAvzDkWdUoTluFrbqsye3Z5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwkJ0-00D99h-3w; Tue, 16 Apr 2024 17:01:06 +0200
Date: Tue, 16 Apr 2024 17:01:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net 3/5] net: wangxun: fix to change Rx features
Message-ID: <2dd77896-d0dd-4d29-bcfc-e7fb114eb575@lunn.ch>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
 <20240416062952.14196-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416062952.14196-4-jiawenwu@trustnetic.com>

On Tue, Apr 16, 2024 at 02:29:50PM +0800, Jiawen Wu wrote:
> Fix the issue where some Rx features cannot be changed.

For fixes, please describe the observed behaviour being fixed. Does
ethtool -k return the wrong values?

Somebody might run into a problem, and look at commits to see if it
has already been fixed. However, it is hard to tell what this actually
fixes with the current description.

	Andrew

