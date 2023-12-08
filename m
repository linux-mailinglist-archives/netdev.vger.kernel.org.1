Return-Path: <netdev+bounces-55206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65E0809CF1
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 08:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAB11C20A0A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22FDF4A;
	Fri,  8 Dec 2023 07:14:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 162741 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 23:14:41 PST
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083710EB
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 23:14:40 -0800 (PST)
X-QQ-mid:Yeas9t1702019567t333t03269
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.204.154.156])
X-QQ-SSF:00400000000000F0FSF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 375664412574875027
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20231206095355.1220086-1-jiawenwu@trustnetic.com> <20231206095355.1220086-2-jiawenwu@trustnetic.com> <ZXBjwWjd1Jv8916K@shell.armlinux.org.uk>
In-Reply-To: <ZXBjwWjd1Jv8916K@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next v3 1/7] net: ngbe: implement phylink to handle PHY device
Date: Fri, 8 Dec 2023 15:12:46 +0800
Message-ID: <06f201da29a5$f1f04910$d5d0db30$@trustnetic.com>
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
Thread-Index: AQIXPBN5cam3kR8JTO5owVnFd3tKkwGHnNu7Ah1JO9qwB6udIA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

On Wednesday, December 6, 2023 8:06 PM, Russell King (Oracle) wrote:
> On Wed, Dec 06, 2023 at 05:53:49PM +0800, Jiawen Wu wrote:
> > Add phylink support for Wangxun 1Gb Ethernet controller.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_type.h  |   8 ++
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  20 ++-
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 126 +++++++++++-------
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h |   2 +-
> >  4 files changed, 93 insertions(+), 63 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > index 165e82de772e..9225aaf029f8 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/netdevice.h>
> >  #include <linux/if_vlan.h>
> >  #include <net/ip.h>
> > +#include <linux/phylink.h>
> 
> Nit: would be better to keep linux/ includes together (and in
> alphabetical order to prevent conflicts.)
> 
> > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > index 8db804543e66..c61f4b9d79fa 100644
> > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/etherdevice.h>
> >  #include <net/ip.h>
> >  #include <linux/phy.h>
> > +#include <linux/phylink.h>
> >  #include <linux/if_vlan.h>
> >
> >  #include "../libwx/wx_type.h"
> 
> As wx_type.h includes linux/phylink.h, which is now fundamental for the
> definition of one of the structures in wx_type.h, the include of
> linux/phylink.h seems unnecessary here.

Should I remove the include of linux/phylink.h that have been added in other .c files?
 


