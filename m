Return-Path: <netdev+bounces-27962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A377DC10
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03EF1C20FAE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E10D305;
	Wed, 16 Aug 2023 08:23:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F155D2FE
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:23:09 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92411990
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:23:06 -0700 (PDT)
X-QQ-mid:Yeas3t1692174020t310t50615
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.177.96.73])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8591622483669581868
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230808021708.196160-1-jiawenwu@trustnetic.com> <20230808021708.196160-4-jiawenwu@trustnetic.com> <ZNH68qtZvaXp5c5j@shell.armlinux.org.uk> <081e01d9c9d4$f350d170$d9f27450$@trustnetic.com>
In-Reply-To: <081e01d9c9d4$f350d170$d9f27450$@trustnetic.com>
Subject: RE: [PATCH net-next v2 3/7] net: pcs: xpcs: add 1000BASE-X AN interrupt support
Date: Wed, 16 Aug 2023 16:20:19 +0800
Message-ID: <014b01d9d01a$7e79aa10$7b6cfe30$@trustnetic.com>
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
Thread-Index: AQGWRt0YcmdMZE8wG3Q/Y3QvRd722AJtrWGrAOuyUWACq7XFMbBDYFCA
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tuesday, August 8, 2023 4:47 PM, Jiawen Wu wrote:
> On Tuesday, August 8, 2023 4:21 PM, Russell King (Oracle) wrote:
> > On Tue, Aug 08, 2023 at 10:17:04AM +0800, Jiawen Wu wrote:
> > > Enable CL37 AN complete interrupt for DW XPCS. It requires to clear the
> > > bit(0) [CL37_ANCMPLT_INTR] of VR_MII_AN_INTR_STS after AN completed.
> > >
> > > And there is a quirk for Wangxun devices to enable CL37 AN in backplane
> > > configurations because of the special hardware design.
> >
> > Where is the interrupt handler?
> 
> PCS interrupt is directly connected to the PCI interrupt on the board, so the
> interrupt handler is txgbe_irq_handler() in the ethernet driver.
> 
> >
> > > @@ -759,6 +762,8 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
> > >  		return ret;
> > >
> > >  	ret &= ~DW_VR_MII_PCS_MODE_MASK;
> > > +	if (!xpcs->pcs.poll)
> > > +		ret |= DW_VR_MII_AN_INTR_EN;
> >
> > Does this interrupt only work in 1000baseX mode?
> 
> AN interrupt now only be implemented in 1000baseX mode.
> 
> >
> > >  	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, ret);
> > >  	if (ret < 0)
> > >  		return ret;
> > > @@ -1012,6 +1017,17 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
> > >  		if (bmsr < 0)
> > >  			return bmsr;
> > >
> > > +		/* Clear AN complete interrupt */
> > > +		if (!xpcs->pcs.poll) {
> > > +			int an_intr;
> > > +
> > > +			an_intr = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS);
> > > +			if (an_intr & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
> > > +				an_intr &= ~DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
> > > +				xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, an_intr);
> > > +			}
> > > +		}
> > > +
> >
> > get_state isn't supposed to be used as a way to acknowledge interrupts,
> > because that will get called quite a bit later after the interrupt has
> > been received.
> 
> I think it's just to clear the AN complete bit here. Actually, ethernet driver
> handle interrupt and call phylink_mac_change() to check PCS state. It does
> get called later, though.
> 
> >
> > As an example of PCS that use interrupts, please see the converted
> > mv88e6xxx PCS, for example:
> >
> >  drivers/net/dsa/mv88e6xxx/pcs-6352.c
> >
> > If the interrupt handler for the PCS is threaded, then it can access
> > the DW_VR_MII_AN_INTR_STS register to acknowledge the interrupt and
> > call phylink_pcs_change() or phylink_mac_change().
> 
> I'll check the usage of this method, thanks.

If interrupt handler is to be implemented in PCS, the codes about interrupts in
txgbe driver needs to be all refactored. This will affect GPIO, SFP... 

Could I refactor these codes in a future patch, and keep the current IRQ structure
in this series?



