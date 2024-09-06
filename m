Return-Path: <netdev+bounces-125907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17E296F384
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC33281065
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CEA1CBE82;
	Fri,  6 Sep 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wmr+/n+O"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28D1C9EB7;
	Fri,  6 Sep 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623318; cv=none; b=Q8aHLRrYn1LWyLyxUJESHO+Rus5YYwq5ecHanjD6ZSYDOSaVooiq/jg8f59x0a50ZNb9RplL2nSg/wA2TIkaWtNf48sMW16XUmQeTfmF82a+5ttemEI8+auf4DfXDabtxRZZ1J5hzHHS2SXcTsBTUBVCuxcvctwgdFxKWus/9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623318; c=relaxed/simple;
	bh=boRqGurXA5pXpB6tT0GBMpD4KtA+S4FzluXv/sX46/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeHkf+zb/IGJ4QmAF8E2TLBzV38LGgX2aK/zZlNdmoNNJfDY9Ti7Vn6xFr/PPVn442ETzciHPtXPdwUS+lTG9M+ogiDT3QjtyBp1vszFrZZt9eLJYl2+XsK4PsBtqeSK8G6E+AWVK7w/f1NNgPe2jBTOy36hVauu6eWCuOudWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wmr+/n+O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2ivheLk9PpJPW/IdL7OqFA2vAw2jy/QidjUHNBBy73Q=; b=wmr+/n+Oyvf9at8tSA3CQ4BQKI
	10sZjPHNbZam3Z4pYoZV2hSaGuwVAxOEPZ+ZAlqN2MTUk9RoRChlUZ1Ri+JN4Q+V00yCuwyGLe2Nm
	tNayxKGlaPnxLp8izAs7qngg563X0M3MnDHgV1eT9FSFiIuPr9TotXcN5G67N0pbQ0t8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smXRu-006ndk-LP; Fri, 06 Sep 2024 13:48:22 +0200
Date: Fri, 6 Sep 2024 13:48:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= net: ftgmac100:
 Enable TX interrupt to avoid TX timeout
Message-ID: <18cfef9e-2ae7-44b6-bfd6-2fe0bba7fbb5@lunn.ch>
References: <20240904103116.4022152-1-jacky_chou@aspeedtech.com>
 <80f1cd36-c806-4e09-9eac-a70891f50323@lunn.ch>
 <SEYPR06MB51345FBC0146F1517B36584B9D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51345FBC0146F1517B36584B9D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Fri, Sep 06, 2024 at 01:57:56AM +0000, Jacky Chou wrote:
> Hello,
> 
> When I am verifying iperf3 over UDP, the network hangs.
> Like the log below.
> 
> root# iperf3 -c 192.168.100.100 -i1 -t10 -u -b0
> Connecting to host 192.168.100.100, port 5201
> [  4] local 192.168.100.101 port 35773 connected to 192.168.100.100 port 5201
> [ ID] Interval           Transfer     Bandwidth       Total Datagrams
> [  4]   0.00-20.42  sec   160 KBytes  64.2 Kbits/sec  20
> [  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
> [  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
> [  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
> [  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
> [  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
> [  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
> [  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
> [  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
> [  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total
> Datagrams
> [  4]   0.00-20.42  sec   160 KBytes  64.2 Kbits/sec  0.000 ms  0/20 (0%)
> [  4] Sent 20 datagrams
> iperf3: error - the server has terminated The network topology is FTGMAC
> connects directly to a PC. UDP does not need to wait for ACK, unlike TCP.
> Therefore, FTGMAC needs to enable TX interrupt to release TX resources instead
> of waiting for the RX interrupt.

Please don't top post.

So this does seem like a fix. Please read through:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need a Fixes: tag, CC: stable tag, use the correct tree, etc.

    Andrew

---
pw-bot: cr

