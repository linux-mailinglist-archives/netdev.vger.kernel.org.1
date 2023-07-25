Return-Path: <netdev+bounces-20794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D376103E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E64A1C20DF7
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D551B15AEF;
	Tue, 25 Jul 2023 10:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5514281
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:06:45 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A591213A
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:06:16 -0700 (PDT)
X-QQ-mid:Yeas54t1690279490t896t59957
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.134.159])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 15445414712776279798
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com> <20230724102341.10401-7-jiawenwu@trustnetic.com> <ZL5VyBb9cUTq/y3Y@shell.armlinux.org.uk> <03d201d9bea1$8dc4d740$a94e85c0$@trustnetic.com> <ZL+Bpxn8O3PRMv0p@shell.armlinux.org.uk>
In-Reply-To: <ZL+Bpxn8O3PRMv0p@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 6/7] net: txgbe: support copper NIC with external PHY
Date: Tue, 25 Jul 2023 18:04:49 +0800
Message-ID: <03f201d9bedf$730b38c0$5921aa40$@trustnetic.com>
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
Thread-Index: AQJQc7ZImbL9NUPTrDJxH1gVz1U29QJ+Bk4MARxYyuYB8KqHgwGoO8DwrqM6nIA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tuesday, July 25, 2023 4:03 PM, Russell King (Oracle) wrote:
> On Tue, Jul 25, 2023 at 10:41:46AM +0800, Jiawen Wu wrote:
> > On Monday, July 24, 2023 6:43 PM, Russell King (Oracle) wrote:
> > > On Mon, Jul 24, 2023 at 06:23:40PM +0800, Jiawen Wu wrote:
> > > > @@ -22,6 +25,9 @@ static int txgbe_get_link_ksettings(struct net_device *netdev,
> > > >  {
> > > >  	struct txgbe *txgbe = netdev_to_txgbe(netdev);
> > > >
> > > > +	if (txgbe->wx->media_type == sp_media_copper)
> > > > +		return phy_ethtool_get_link_ksettings(netdev, cmd);
> > >
> > > Why? If a PHY is attached via phylink, then phylink will automatically
> > > forward the call below to phylib.
> >
> > No, there is no phylink implemented for sp_media_copper.
> >
> > > > +
> > > >  	return phylink_ethtool_ksettings_get(txgbe->phylink, cmd);
> > >
> > > If you implement it correctly, you also don't need two entirely
> > > separate paths to configure the MAC/PCS for the results of the PHY's
> > > negotiation, because phylink gives you a _generic_ set of interfaces
> > > between whatever is downstream from the MAC and the MAC.
> >
> > For sp_media_copper, only mii bus is registered for attaching PHY.
> > Most MAC/PCS configuration is done in firmware, so it is not necessary
> > to implement phylink as sp_media_fiber.
> 
> If you do implement phylink for copper, then you don't need all these
> conditionals and the additional adjust_link implementation. In other
> words, you can re-use a lot of the code you've already added.
> 
> You don't have to provide a PCS to phylink provided you don't tell
> phylink that it's "in-band".

Do I need to create a separate software node? That would seem to
break more code of fiber initialization flow. I could try, but I'd like to
keep the two flows separate.



