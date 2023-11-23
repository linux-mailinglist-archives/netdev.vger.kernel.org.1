Return-Path: <netdev+bounces-50412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFFE7F5B0B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9E4B20C18
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB25200D9;
	Thu, 23 Nov 2023 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF1919E
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 01:26:53 -0800 (PST)
X-QQ-mid:Yeas10t1700731527t371t17379
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.129.197])
X-QQ-SSF:00400000000000F0FSF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 7172090465262182802
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com> <20231122102226.986265-3-jiawenwu@trustnetic.com> <4a36b46d-3f71-430f-8158-da58769ae52a@lunn.ch>
In-Reply-To: <4a36b46d-3f71-430f-8158-da58769ae52a@lunn.ch>
Subject: RE: [PATCH net-next 2/5] net: wangxun: add ethtool_ops for ring parameters
Date: Thu, 23 Nov 2023 17:25:26 +0800
Message-ID: <00f801da1dee$fe4975a0$fadc60e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIZ7m4FfqhO6yXRbjtvxmXj2jKlSQJjneaLAvi6Bwev3R0LsA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

> > +	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
> > +	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
> > +
> > +	new_rx_count = clamp_t(u32, ring->rx_pending, WX_MIN_RXD, WX_MAX_RXD);
> > +	new_rx_count = ALIGN(new_rx_count, WX_REQ_RX_DESCRIPTOR_MULTIPLE);
> > +
> > +	if (new_tx_count == wx->tx_ring_count &&
> > +	    new_rx_count == wx->rx_ring_count)
> > +		return 0;
> > +
> > +	if (!netif_running(wx->netdev)) {
> > +		for (i = 0; i < wx->num_tx_queues; i++)
> > +			wx->tx_ring[i]->count = new_tx_count;
> > +		for (i = 0; i < wx->num_rx_queues; i++)
> > +			wx->rx_ring[i]->count = new_rx_count;
> > +		wx->tx_ring_count = new_tx_count;
> > +		wx->rx_ring_count = new_rx_count;
> > +
> > +		return 0;
> > +	}
> > +
> > +	txgbe_down(wx);
> > +
> > +	err = wx_set_ring(wx, new_tx_count, new_rx_count);
> > +
> > +	txgbe_up(wx);
> > +
> > +	return err;
> 
> Could most of this be moved into the library? It looks pretty similar
> for the two devices.

I tried to move them into the library, but *_down() and *_up() here
involves some different flows for the two devices, it's not easy to handle.



