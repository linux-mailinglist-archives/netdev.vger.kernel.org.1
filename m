Return-Path: <netdev+bounces-59865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6B81C670
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 09:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9441C216D7
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2BAC15B;
	Fri, 22 Dec 2023 08:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943FF9D6
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1703233259t489t55861
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.246.92])
X-QQ-SSF:00400000000000F0FTF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 13446419673455424711
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20231214025456.1387175-1-jiawenwu@trustnetic.com>	<20231214025456.1387175-7-jiawenwu@trustnetic.com> <20231215183826.7bc82ef0@kernel.org>
In-Reply-To: <20231215183826.7bc82ef0@kernel.org>
Subject: RE: [PATCH net-next v5 6/8] net: wangxun: add coalesce options support
Date: Fri, 22 Dec 2023 16:20:58 +0800
Message-ID: <02bf01da34af$cad838a0$6088a9e0$@trustnetic.com>
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
Thread-Index: AQGJGR1PeE+ADS0PDOgt78qCBoEWgQG4toSAAb8FC92xO26e4A==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

On Saturday, December 16, 2023 10:38 AM, Jakub Kicinski wrote:
> On Thu, 14 Dec 2023 10:54:54 +0800 Jiawen Wu wrote:
> > +	ec->tx_max_coalesced_frames_irq = wx->tx_work_limit;
> > +	/* only valid if in constant ITR mode */
> > +	if (wx->rx_itr_setting <= 1)
> > +		ec->rx_coalesce_usecs = wx->rx_itr_setting;
> > +	else
> > +		ec->rx_coalesce_usecs = wx->rx_itr_setting >> 2;
> > +
> > +	/* if in mixed tx/rx queues per vector mode, report only rx settings */
> 
> What if there's only a Tx queue? You'll report both rx and tx
> coalescing params?

The current driver does not support this case.

> 
> > +	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
> > +		return 0;
> > +
> > +	/* only valid if in constant ITR mode */
> > +	if (wx->tx_itr_setting <= 1)
> > +		ec->tx_coalesce_usecs = wx->tx_itr_setting;
> > +	else
> > +		ec->tx_coalesce_usecs = wx->tx_itr_setting >> 2;
> 


