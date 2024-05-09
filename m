Return-Path: <netdev+bounces-94778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF28C09FF
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 05:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C6D1F2216D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 03:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B2D12BEA4;
	Thu,  9 May 2024 03:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC326D517
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 03:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224282; cv=none; b=PUtYDI1CGqrKOw8a42J+Jbzfo89T+CkmNKggf5eF+mSanbUSmFhsQ6exvZu7Z6qx7/tQbqJCUU8W0/BKT1pwBVMDE+psD/MCEHJc/P/vc9+pP/tYad6eDCo2zxbED5cEE8ycXu/6pgM6xtdrOEurj8/kum9SQztpzSPw8XIFXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224282; c=relaxed/simple;
	bh=H8MQ9Mah0/xDsu2ucPyYx6dqcLcNSYA4l5IWtkDVZKU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=C+XocXRZCXSxLDUd/EVza2OEuA9rmrG4jwjR6r27B/pbIUPjGlEZ/MhFpCjpOjDbYbrSQ+8Iqy8Yw8GaXVzPbOttLLcj0MVwPdXmhXdwHewaLFHfzvYOoob/sFv+WsUwjK3dNgbhfPTBnh7DFVlo2GhWQ0kPE4RUTQCtjiJjXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas12t1715224127t058t23064
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.129.236.74])
X-QQ-SSF:00400000000000F0FUF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 7894192083632368795
To: "'Simon Horman'" <horms@kernel.org>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<rmk+kernel@armlinux.org.uk>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com> <20240429102519.25096-5-jiawenwu@trustnetic.com> <20240502092526.GD2821784@kernel.org>
In-Reply-To: <20240502092526.GD2821784@kernel.org>
Subject: RE: [PATCH net v2 4/4] net: txgbe: fix to control VLAN strip
Date: Thu, 9 May 2024 11:08:46 +0800
Message-ID: <00a301daa1be$34d98620$9e8c9260$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKMAc/6KzgCZu6RyYLqheGkGVll8gG5kjUzARbteTiwFO7YYA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index aefd78455468..ed6a168ff136 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > @@ -2692,9 +2692,9 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
> >
> >  	netdev->features = features;
> >
> > -	if (changed &
> > -	    (NETIF_F_HW_VLAN_CTAG_RX |
> > -	     NETIF_F_HW_VLAN_STAG_RX))
> > +	if (wx->mac.type == wx_mac_sp && changed & NETIF_F_HW_VLAN_CTAG_RX)
> > +		wx->do_reset(netdev);
> > +	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
> >  		wx_set_rx_mode(netdev);
> >
> >  	return 0;
> 
> Hi Jiawen Wu,
> 
> NETIF_F_HW_VLAN_CTAG_RX appears in both the "if" and "if else" condition.
> Should "if else" be changed to "if" ?

There are 4 cases where wx_set_rx_mode() is called, CTAG_RX and CTAG_FILTER
combined with wx_mac_sp and wx_mac_em. But only one special case that
changing CTAG_RX requires wx_mac_sp device to do reset, and wx_set_rx_mode()
also will be called during the reset process. So I think "if else" is more appropriate
here.



