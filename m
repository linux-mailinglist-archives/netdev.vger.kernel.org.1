Return-Path: <netdev+bounces-217434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B7B38A8B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25901BA6050
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B2D2ECE98;
	Wed, 27 Aug 2025 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EI7ZHGlx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F92857C7;
	Wed, 27 Aug 2025 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324550; cv=none; b=nV4cKjojU3ThTUpeRxYhTdhjh81z4qn7kLp9oHXOLaX8uzG8P98Y0mEW4Lz13815qWDPPk6F85Jsv+sLfVOIMvi+KT8XING9miwo7cWwSG4M6udqRYj72juZt0D5E+mQrZO12hEUoglpxpMhPMbPMDFUOv0cZAqE7aAP0RB4AJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324550; c=relaxed/simple;
	bh=jZYku9dzOnZGIeSCCzwUX7FVfwR/MF3JExsR22TgIqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubpq2vY8we8gFQzfyJeacbYXd/jVOmO6yA7HxhlWRkI0+AGlDa+YgeDd3SAYEY+qVC1rANfavxUOpzVgrVDNkN/ff6Elj0skjQNYaSHNC0+8T97fxKYAZqKdaVj7oUsXuTeI4CK26NFuCstPtxJYv1+yS50kaLbhagFdtBw5/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EI7ZHGlx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mmudr4OJjkExk9DTyzyKRxQKXUDtpB3EvNfDUHRnlWQ=; b=EI7ZHGlxAwUF4BXOzx9lpiVKZd
	nOUfT0RCacsr+V166UjVeUOtBVX5aEqo983uEoxymqP5cfsz+PgFXEWe+cTcDQsD/TNUU/HvSM1oI
	B2YRW11cLwO2NfvRelECReSomt1JIdGJ9j3v5W6q2uX9YQmM9XRJPknigHOLNU2lib+E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urMEU-006FrZ-IO; Wed, 27 Aug 2025 21:54:58 +0200
Date: Wed, 27 Aug 2025 21:54:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <a61b6cdb-0f20-480c-877a-68c920e76ae2@lunn.ch>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <316f57e3-5953-4db6-84aa-df9278461d30@linux.dev>
 <82E3BE49DB4195F0+20250826013113.GA6582@nic-Precision-5820-Tower>
 <bbdabd48-61c0-46f9-bf33-c49d6d27ffb0@linux.dev>
 <8C1007761115185D+20250826110539.GA461663@nic-Precision-5820-Tower>
 <bd1d77b2-c218-4dce-bbf6-1cbdecabb30b@lunn.ch>
 <05B2D818DB1348E6+20250827014211.GA469112@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05B2D818DB1348E6+20250827014211.GA469112@nic-Precision-5820-Tower>

> I try to explain the it:
> 
> driver-->fw, we has two types request:
> 1. without response, such as mucse_mbx_ifinsmod
> 2. with response, such as mucse_fw_get_macaddr
> 
> fw --> driver, we has one types request:
> 1. link status (link speed, duplex, pause status...)

Is the firmware multi threaded? By that, i mean can there be two
request/responses going on at once?

I'm assuming not.

So there appears to be four use cases:

1) Fire and forget, request without response.
2) Request with a response
3) Link state change from the firmware
4) Race condition: Request/response and link state change at the same time.

Again, assuming the firmware is single threaded, there must be a big
mutex around the message box so there can only be one thread doing any
sort of interaction with the firmware.

Since there can only be one thread waiting for the response, the
struct completion can be a member of the message box. The thread
waiting for a response uses wait_for_completion(mbx->completion).

The interrupt handler can look at the type of message it got from the
firmware. If it is a link state, process it, and exit. If it is
anything else, complete(mbx->completion) and exit.

I don't see the need for any sort of cookie.

  Andrew

