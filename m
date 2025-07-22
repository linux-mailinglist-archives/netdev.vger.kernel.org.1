Return-Path: <netdev+bounces-208945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBDCB0DA7F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D081AA76F2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658742E9EB1;
	Tue, 22 Jul 2025 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YNaKA0Mr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21AD1DE4DB;
	Tue, 22 Jul 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189610; cv=none; b=fGWGBrQapeB2zLlA260/hMs432NgEiJDOegyh5qh1U8J7DnCF/Wvolsj3loDnmz3URtG7LOsQ689Br1nSjxIOY9KFUw5c9Xed6OvotDxUgpdBYjAhgMVq2Uhey0/50T+JEbGMRDnqMe9WcWuIo54YOSICCeZVBO5cox8vNLP+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189610; c=relaxed/simple;
	bh=R7VMc//EpgkxIP/3zpr1MLiNz7ojkTVdH/u36Efqrto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWt2QigkacdpGD9H9xN1VaUEAeAJtplIa31y7JZ/XShSCWcsPzMYJSchYrG8dRo3nzaBEf7zuBAG2QJZTRop7oxriZ0Ca6/8Se079CHt1m5gJNDgfdmw+MkZdWfDsJrMc44xGSs/fLz4DMdvfeC4YMJwSqpo75cox5TOGoiJRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YNaKA0Mr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zi4vSV2136IMrdONKtbsuO4SnihqiAzTpX/4sPu+TFU=; b=YN
	aKA0MrT6r4FavC3nvjWKw/SsQ2Rk7T505e1bKa5IXW3cExRjojLHBXnxUjeMY+Az24+9SW5pDXEHO
	expQbt3Bzly5Zv03N0o/QY4QKBzpxRxM+T0jkS9X63LBHMDXY2fvnVJ+BLGeayQtJy/PnRzM2K73n
	D7QMMDhGYQsk094=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueChZ-002Sse-3z; Tue, 22 Jul 2025 15:06:37 +0200
Date: Tue, 22 Jul 2025 15:06:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yicongsrfy@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oneukum@suse.com, yicong@kylinos.cn
Subject: Re: [PATCH] usbnet: Set duplex status to unknown in the absence of
 MII
Message-ID: <1c65c240-514d-461f-b81e-6a799f6ea56f@lunn.ch>
References: <496e1153-acac-468a-b39c-9ea138b2cf04@lunn.ch>
 <20250722020933.1221663-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722020933.1221663-1-yicongsrfy@163.com>

On Tue, Jul 22, 2025 at 10:09:33AM +0800, yicongsrfy@163.com wrote:
> Thanks for your reply!
> 
> According to the "Universal Serial Bus Class Definitions for Communications Devices v1.2":
> In Section 6.3, which describes notifications such as NetworkConnection and ConnectionSpeedChange,
> there is no mention of duplex status.In particular, for ConnectionSpeedChange, its data payload
> only contains two 32-bit unsigned integers, corresponding to the uplink and downlink speeds.

Thanks for checking this.

Just one more question. This is kind of flipping the question on its
head. Does the standard say devices are actually allowed to support
1/2 duplex? Does it say they are not allowed to support 1/2 duplex?

If duplex is not reported, maybe it is because 1/2 duplex is simply
not allowed, so there is no need to report it.

> Since CDC has no way to obtain the duplex status of the device, ethtool displays a default
> value of "Half". I think it would be better to display "unknown" instead of potentially showing
> incorrect information — for example, my device is actually operating at 1Gbps Full-duplex,
> but ethtool shows 1Gbps Half-duplex.

I agree that reporting 1/2 is probably wrong. But we have to decide
between "unknown" and "full".

	Andrew

