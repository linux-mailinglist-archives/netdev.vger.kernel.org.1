Return-Path: <netdev+bounces-141347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6199BA845
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8C828133D
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C387185939;
	Sun,  3 Nov 2024 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l3WqskXm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331E33FE;
	Sun,  3 Nov 2024 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730668770; cv=none; b=SJOGD/YAunObgVOZzAe4lucehIV1HsI2FD0ihSnEDppwUdFMIjqogy7vCITizw2NCVBkVaP2WeCUw0aG5O6i1+ncjiCpj90ehdgXE1T4gUj+/7TAcUZ6zAlYweSsPV7D4u2T15B+0lt/IyE433hk62NnWpnRF0u4L4TNWXwQdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730668770; c=relaxed/simple;
	bh=9eS2bpz0gSgO1KgQBOosqdQwUct702nHG3K/HfmPWiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDG4Dk71VKEg5Cd5ZJeNhifZaIZp1zxQvCanse/P5OR+dtA00k/q/7+ilkZaOUjMuB8OA3uXArUoQwCAQ1pQO+Guu6C0/94NT6LgWMR3eFJIxXsHOOldIFRNXtGM1N86TrDcYG0fyhkvPIjbeugrEKcxjRUBkWbYp7kekhtbyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l3WqskXm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=53a5eMeL2YTmwuaOu3c+9vYGuoaT5UJwIu/oE7AmBl0=; b=l3WqskXmLE7X9iXSZP9MLv237m
	/VoJsykZNEu5UQfPUmVEOHu5jlXr20LB+2L1jqnKnENsrJWKGIF4kBKN9K+SVkrukPNHCeHHEi+F2
	7ww4e0VzJHbUKPTA34JqJKne4fr+S4dNaQoC7CPL1Qh3qZmOUPoCt8BUPJdsQx+qIAQQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7i0K-00C2X3-TG; Sun, 03 Nov 2024 22:19:24 +0100
Date: Sun, 3 Nov 2024 22:19:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: 'Jakub Kicinski' <kuba@kernel.org>,
	"Gongfan (Eric, Chip)" <gongfan1@huawei.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	"Guoxin (D)" <guoxin09@huawei.com>,
	shenchenyang <shenchenyang1@hisilicon.com>,
	"zhoushuai (A)" <zhoushuai28@huawei.com>,
	"Wulike (Collin)" <wulike1@huawei.com>,
	"shijing (A)" <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>
Subject: Re: [RFC net-next v01 1/1] net: hinic3: Add a driver for Huawei 3rd
 gen NIC
Message-ID: <61c2a2bf-c39a-4629-b57d-8d6ecb264842@lunn.ch>
References: <cover.1730290527.git.gur.stavi@huawei.com>
 <ebb0fefe47c29ffed5af21d6bd39d19c2bcddd9c.1730290527.git.gur.stavi@huawei.com>
 <20241031193523.09f63a7e@kernel.org>
 <000001db2dec$10d92680$328b7380$@huawei.com>
 <661620c5-acdd-43df-8316-da01b0d2f2b3@lunn.ch>
 <000201db2e2d$82ad67d0$88083770$@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201db2e2d$82ad67d0$88083770$@huawei.com>

> To properly review (error prone) pause it would be better to remove it from
> initial submission and add it in a later dedicated submission.

Not really. It should be in a patch titled ethtool, so it is easy to
find. And since i've pointed out most drivers get it wrong, you will
assume you also have it wrong, assign a developer to go read the
discussion on the netdev list where i point out drivers which get it
wrong and what is the correct implementation, your developer will then
fixup your code if needed, and all i need to do is confirm you got it
right. Or shake my head and say despite the warning, it is still
wrong. 

	Andrew

