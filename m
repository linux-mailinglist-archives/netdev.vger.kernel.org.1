Return-Path: <netdev+bounces-73868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87785EECD
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAA91C21667
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 01:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507FA134D8;
	Thu, 22 Feb 2024 01:58:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2327125D7
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 01:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567123; cv=none; b=HZM7f0uLf3H80TvJwWWG2/Rg3akLOKsJArxmZKzPQQhA2L09FEKavCLu7H3pmdEk6bMaCXNJllh7ybHnKQtczhNj2uTkqE+4r6JT6TA/xftZYOaH+Te9C2ZrArDo4K+qWOuulfJFIWnVF9dGfwPNxuvY0iEr/98/Z/6aexSET/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567123; c=relaxed/simple;
	bh=2QIq1hCyoEqjIkfwgL8iMThWjKQKSaSwhoVboXa04jE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=UgEJWq/xuyx9XEdAxijtgJuqrpjOmOqfk0OOmvIxAmkXeMvcYRSfpScJ4jGnHoQXNrSYw5oYzBbGVgTgrFf3MEvEBkgRls6GdAjdP7EV/7Awev5EXXrnK2ybTzezvzfmatnZ/J4Kxx7Q0VUXwK9Eza+tlZO8fA2AGRKMucx0sko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1708567018t123t14999
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.192.112.158])
X-QQ-SSF:00400000000000F0FTF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 920514574638062572
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<maciej.fijalkowski@intel.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20240206070824.17460-1-jiawenwu@trustnetic.com> <9259e4eb-8744-45cf-bdea-63bc376983a4@lunn.ch> <003801da6249$888e4210$99aac630$@trustnetic.com> <33eed490-7819-409e-8c79-b3c1e4c4fd66@lunn.ch> <00e301da63de$bd53db90$37fb92b0$@trustnetic.com> <96b3ed32-1115-46bf-ae07-9eea0c24e85a@lunn.ch>
In-Reply-To: <96b3ed32-1115-46bf-ae07-9eea0c24e85a@lunn.ch>
Subject: RE: [PATCH] net: txgbe: fix GPIO interrupt blocking
Date: Thu, 22 Feb 2024 09:56:57 +0800
Message-ID: <021e01da6532$6ab0e900$4012bb00$@trustnetic.com>
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
Thread-Index: AQKQWSrySMPq8PWl707TeSOritAirQH7bedeAP/Pp5gCVYvqAQHVv3hWAVoX6xevZapD8A==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Wed, Feb 21, 2024 10:36 PM, Andrew Lunn wrote:
> On Tue, Feb 20, 2024 at 05:25:26PM +0800, Jiawen Wu wrote:
> > On Mon, Feb 19, 2024 12:45 AM, Andrew Lunn wrote:
> > > On Sun, Feb 18, 2024 at 05:04:52PM +0800, Jiawen Wu wrote:
> > > > On Tue, Feb 6, 2024 11:29 PM, Andrew Lunn wrote:
> > > > > On Tue, Feb 06, 2024 at 03:08:24PM +0800, Jiawen Wu wrote:
> > > > > > GPIO interrupt is generated before MAC IRQ is enabled, it causes
> > > > > > subsequent GPIO interrupts that can no longer be reported if it is
> > > > > > not cleared in time. So clear GPIO interrupt status at the right
> > > > > > time.
> > > > >
> > > > > This does not sound correct. Since this is an interrupt controller, it
> > > > > is a level interrupt. If its not cleared, as soon as the parent
> > > > > interrupt is re-enabled, is should cause another interrupt at the
> > > > > parent level. Servicing that interrupt, should case a descent to the
> > > > > child, which will service the interrupt, and atomically clear the
> > > > > interrupt status.
> > > > >
> > > > > Is something wrong here, like you are using edge interrupts, not
> > > > > level?
> > > >
> > > > Yes, it is edge interrupt.
> > >
> > > So fix this first, use level interrupts.
> >
> > I have a question here.
> >
> > I've been setting the interrupt type in chip->irq_set_type. The 'type' is
> > passed as IRQ_TYPE_EDGE_BOTH. Then I config GPIO registers based on
> > this type, and use edge interrupts. Who decides this type? Can I change
> > it at will?
> 
> There are a few different mechanism. In DT you can specify it as part
> of the phandle reference. You can also pass flags to
> 
> request_irq(unsigned int irq, irq_handler_t handler, unsigned long flags,
> 	    const char *name, void *dev)
> 
> #define IRQF_TRIGGER_NONE	0x00000000
> #define IRQF_TRIGGER_RISING	0x00000001
> #define IRQF_TRIGGER_FALLING	0x00000002
> #define IRQF_TRIGGER_HIGH	0x00000004
> #define IRQF_TRIGGER_LOW	0x00000008

There are flags passed in sfp.c:

err = devm_request_threaded_irq(sfp->dev, sfp->gpio_irq[i],
				NULL, sfp_irq,
				IRQF_ONESHOT |
				IRQF_TRIGGER_RISING |
				IRQF_TRIGGER_FALLING,
				sfp_irq_name, sfp);

So specific GPIO IRQs are request as edge interrupts. It looks like I can't
change it.



