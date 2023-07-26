Return-Path: <netdev+bounces-21132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCE37628CA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B87281162
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24421108;
	Wed, 26 Jul 2023 02:41:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73DB1101
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:41:57 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFB82691
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:41:52 -0700 (PDT)
X-QQ-mid:Yeas44t1690339233t549t05954
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.128.134.159])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3078516715268493991
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com> <20230724102341.10401-3-jiawenwu@trustnetic.com> <d745524b-b306-447e-afbe-8935286301e4@lunn.ch>
In-Reply-To: <d745524b-b306-447e-afbe-8935286301e4@lunn.ch>
Subject: RE: [PATCH net-next 2/7] net: pcs: xpcs: support to switch mode for Wangxun NICs
Date: Wed, 26 Jul 2023 10:40:32 +0800
Message-ID: <043201d9bf6a$8c700350$a55009f0$@trustnetic.com>
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
Thread-Index: AQJQc7ZImbL9NUPTrDJxH1gVz1U29QJ2Yj+YAXg6ZPquvnOBAA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wednesday, July 26, 2023 1:32 AM, Andrew Lunn wrote:
> > +static void txgbe_pma_config_10gbaser(struct dw_xpcs *xpcs)
> > +{
> > +	int val;
> > +
> > +	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL0, 0x21);
> > +	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL3, 0);
> > +	val = txgbe_read_pma(xpcs, TXGBE_TX_GENCTL1);
> > +	val = u16_replace_bits(val, 0x5, TXGBE_TX_GENCTL1_VBOOST_LVL);
> > +	txgbe_write_pma(xpcs, TXGBE_TX_GENCTL1, val);
> > +	txgbe_write_pma(xpcs, TXGBE_MISC_CTL0, 0xCF00);
> > +	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_LD0, 0x549);
> > +	txgbe_write_pma(xpcs, TXGBE_VCO_CAL_REF0, 0x29);
> > +	txgbe_write_pma(xpcs, TXGBE_TX_RATE_CTL, 0);
> > +	txgbe_write_pma(xpcs, TXGBE_RX_RATE_CTL, 0);
> > +	txgbe_write_pma(xpcs, TXGBE_TX_GEN_CTL2, 0x300);
> > +	txgbe_write_pma(xpcs, TXGBE_RX_GEN_CTL2, 0x300);
> > +	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL2, 0x600);
> > +
> > +	txgbe_write_pma(xpcs, TXGBE_RX_EQ_CTL0, 0x45);
> > +	val = txgbe_read_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL);
> > +	val &= ~TXGBE_RX_EQ_ATTN_LVL0;
> > +	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
> > +	txgbe_write_pma(xpcs, TXGBE_DFE_TAP_CTL0, 0xBE);
> 
> You have a lot of magic numbers above. Please truy to add some
> #defines to try to explain what is going on here.

Some registers give only magic numbers in the fields, like a frequency,
bandwidth, etc. And other fields are reserved. Those registers don't
make much sense to define the bits field. But I'll try to add more
useful defines.




