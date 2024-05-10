Return-Path: <netdev+bounces-95257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C053F8C1C49
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 04:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21451C20CD0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB06313B792;
	Fri, 10 May 2024 02:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB433CD1
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715306482; cv=none; b=DDpfgwahxEXqSTpEI/He9gJUmxLUCsH8YpOj+/QzXh1W0F47VsV1DdBYK6JTmNKnx/iZ9xLNJfrrXoK7R+mQbnkIAPvQaAoMnPBtf1/rV+bZUw/m6BL9TJpgskFeIshe3X1jz1WssRmwE7e+GLNL8X+OpqDkQ6lbEwhKsSaJsu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715306482; c=relaxed/simple;
	bh=qplZe+Ye3TUk9vnjcEO7ib1ASLziITxXCBe57+hVE/Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZDFv9lSHhbyNh+f5eYTOWkqcRaSUBtPLmqxY4lbQIP4OECCjhUBPsAvc/YEBLbJZnoDixZaAsRLQxuAP6tNG679ZD19G6HH5FgpuekCNq0NaYXJm3X+9r0iWzDLqRUSATTAJMzBWp40nETRNXsygELae1np9IYRPnDFgQTum3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1715306260t508t53600
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.129.236.74])
X-QQ-SSF:00400000000000F0FUF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2670729245027292565
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
References: <20240429102519.25096-1-jiawenwu@trustnetic.com> <20240429102519.25096-3-jiawenwu@trustnetic.com> <20240502083614.GC2821784@kernel.org>
In-Reply-To: <20240502083614.GC2821784@kernel.org>
Subject: RE: [PATCH net v2 2/4] net: wangxun: fix to change Rx features
Date: Fri, 10 May 2024 09:57:39 +0800
Message-ID: <011501daa27d$703c9080$50b5b180$@trustnetic.com>
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
Thread-Index: AQKMAc/6KzgCZu6RyYLqheGkGVll8gLXURPdAmMsUBywAyGIMA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > index 6fae161cbcb8..667a5675998c 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> > @@ -2690,12 +2690,14 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
> >  		wx->rss_enabled = false;
> >  	}
> >
> > +	netdev->features = features;
> > +
> 
> nit: I think it would be slightly nicer to place this
>      at the end of the function, just before return.
>      But it would make no difference to the logic,
>      so I don't feel strongly about this.

Thanks for your notice, but it does have to be written here.
Since 'netdev->features' will be checked in wx_set_rx_mode().

> 
> >  	if (changed &
> >  	    (NETIF_F_HW_VLAN_CTAG_RX |
> >  	     NETIF_F_HW_VLAN_STAG_RX))
> >  		wx_set_rx_mode(netdev);
> >
> > -	return 1;
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL(wx_set_features);
> >
> > --
> > 2.27.0
> >
> >
> 


