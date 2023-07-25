Return-Path: <netdev+bounces-20645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B8876052F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 04:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7812281748
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89BEA0;
	Tue, 25 Jul 2023 02:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0248BE5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 02:31:19 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3277710C8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 19:31:13 -0700 (PDT)
X-QQ-mid:Yeas5t1690252186t993t62476
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.134.159])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 7532735167881424581
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com> <20230724102341.10401-6-jiawenwu@trustnetic.com> <ZL5VDJeoRYy37LY/@shell.armlinux.org.uk>
In-Reply-To: <ZL5VDJeoRYy37LY/@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 5/7] net: txgbe: support switching mode to 1000BASE-X and SGMII
Date: Tue, 25 Jul 2023 10:29:46 +0800
Message-ID: <03cf01d9be9f$e0a2e670$a1e8b350$@trustnetic.com>
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
Thread-Index: AQJQc7ZImbL9NUPTrDJxH1gVz1U29QEpEj0rANNTYPauzG5PUA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Monday, July 24, 2023 6:40 PM, Russell King (Oracle) wrote:
> On Mon, Jul 24, 2023 at 06:23:39PM +0800, Jiawen Wu wrote:
> > @@ -185,6 +186,8 @@ static void txgbe_mac_link_up(struct phylink_config *config,
> >  	struct wx *wx = netdev_priv(to_net_dev(config->dev));
> >  	u32 txcfg, wdg;
> >
> > +	txgbe_enable_sec_tx_path(wx);
> > +
> >  	txcfg = rd32(wx, WX_MAC_TX_CFG);
> >  	txcfg &= ~WX_MAC_TX_CFG_SPEED_MASK;
> >
> > @@ -210,8 +213,20 @@ static void txgbe_mac_link_up(struct phylink_config *config,
> >  	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
> >  }
> >
> > +static int txgbe_mac_prepare(struct phylink_config *config, unsigned int mode,
> > +			     phy_interface_t interface)
> > +{
> > +	struct wx *wx = netdev_priv(to_net_dev(config->dev));
> > +
> > +	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
> > +	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
> > +
> > +	return txgbe_disable_sec_tx_path(wx);
> 
> Is there a reason why the sec_tx_path is enabled/disabled asymmetrically?
> 
> I would expect the transmit path to be disabled in mac_link_down() and
> re-enabled in mac_link_up().
> 
> Alternatively, if it just needs to be disabled for reconfiguration,
> I would expect it to be disabled in mac_prepare() and re-enabled in
> mac_finish().
> 
> The disable in mac_prepare() and enable in mac_link_up() just looks
> rather strange, because it isn't symmetrical.

It needs to be disabled for PCS switch mode, I will move the re-enable to
mac_finish().


