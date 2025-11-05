Return-Path: <netdev+bounces-235993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C39C37B56
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DA3B34F979
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBD6335569;
	Wed,  5 Nov 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RVbmeBdN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C5341677;
	Wed,  5 Nov 2025 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374374; cv=none; b=JQai0wq8TFy2kxkr6O0ynvXtUAKY3dF695+asy30bUJe/n1e6Kjh9vt8ViZ76Cse98UfzlnpQL6rWWNNBUgL1QALkIscYdEdV1gW2JrnlYJcWN0g/RWszU+asKSEVIwwVfUp9bdObgTglYrXpObdMK0d1VO/yrcFeec5c6GPens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374374; c=relaxed/simple;
	bh=+4BOJ3E9eYPLTMYlpaX9guGkVv/Uzqcqy/bSN65IGO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WatJUzLDkE0EbSx6p4Ca5kv8JSVqqAUcRlsfjITf/gsNWC+R9UKjpY3pR86FngPq+ZFhUo3R0TVM1YNKibRRNX46OKdOLL1uRNyWYSToD+UbJKPdtG/jiw/nJsHM094hr0VbcPKQr74+m7+NrSln/pF4speXeW69pIFzSg0Db/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RVbmeBdN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=URqAPK4dP20tWDL9nRR+cKAmfbGmOiVkDnvpqKSePEY=; b=RVbmeBdNYgSIjyEqRh8lxMaU83
	LaQ2Ag3mc6DCnUth4c8WbrhvTR5MzKD6+e1F5ACsXxAQoNlamOLOsAZQWLjh8R8EgFp1qRi4hEMvl
	L0GAb63Xyw4P2QacM0IRp4nHk6ynOqDcIDY2HUHi43SEkKUz9dZJgqQoFA6GxRNjKSZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGk4z-00D2Op-E1; Wed, 05 Nov 2025 21:26:05 +0100
Date: Wed, 5 Nov 2025 21:26:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: rtl8150: Initialize buffers to fix KMSAN
 uninit-value in rtl8150_open
Message-ID: <a5565fd2-358a-4e76-a449-f6fd97e6dc09@lunn.ch>
References: <20251105195626.4285-1-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105195626.4285-1-dharanitharan725@gmail.com>

On Wed, Nov 05, 2025 at 07:56:26PM +0000, Dharanitharan R wrote:
> KMSAN reported an uninitialized value use in rtl8150_open().
> Initialize rx_skb->data and intr_buff before submitting URBs to
> ensure memory is in a defined state.

> @@ -769,8 +766,7 @@ static int rtl8150_open(struct net_device *netdev)
>  	enable_net_traffic(dev);
>  	set_carrier(netdev);
>  	netif_start_queue(netdev);
> -
> -	return res;
> +	return 0;
>  }

While i agree that res is guaranteed to by 0, this change has nothing
to do with fixing a KMSAN report. Please make it a separate patch in a
patch series. A patch should do one thing, and the commit message
should explain the "why?" of the change.

Please also take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The Subject line should indicate which tree this is for.

	Andrew

