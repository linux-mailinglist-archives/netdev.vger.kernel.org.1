Return-Path: <netdev+bounces-26910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98F07794F6
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9448F282419
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748141172D;
	Fri, 11 Aug 2023 16:45:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722FEAF9
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 16:45:04 +0000 (UTC)
Received: from out-107.mta1.migadu.com (out-107.mta1.migadu.com [IPv6:2001:41d0:203:375::6b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD1C30C1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:45:01 -0700 (PDT)
Message-ID: <03763b62-8d49-6fbf-5ce9-21c334c9aac2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691772299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=admShfSykcaAtbel+tfZWUdxGTiA82izBewytBKFlQ8=;
	b=RIok6yu/Auqn0MWP4OKNMvm04myfUt1AS598KaVNv0crBmVGWPuLF/VrUoacz0fJcmspTE
	b6+9STyNuUxLP6a2PcQyjSNhMw68Tj+mCkXjOXWNIrpY5VI3s/I8u0LCmV1y6s5N3znJ0x
	hYMMwEvvVarUEoJ8BNStd3ucIvWQ2Qs=
Date: Fri, 11 Aug 2023 17:44:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: phy: mediatek-ge-soc: support PHY LEDs
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <a21288bf80f26dda6c9729edb5b25d0995df5e38.1691724757.git.daniel@makrotopia.org>
 <ac6a4318-3a47-2c77-6b81-b5f04765c04e@linux.dev>
 <ed096dfe-6a42-4838-972b-7a28afaf2f6e@lunn.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ed096dfe-6a42-4838-972b-7a28afaf2f6e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/08/2023 17:39, Andrew Lunn wrote:
>>> +	/* Only now setup pinctrl to avoid bogus blinking */
>>> +	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "gbe-led");
>>
>> This function gets reference on phydev->mdio.dev, but there is no code
>> to release it. It looks like a leak which will prevent module unload,
>> but I don't have hardware now to prove it.
> 
> Since it is a devm_ function, it should get released when the device
> is destroyed. Or am i missing something?
> 

Oh, got it. Yeah, resource managed code needs no explicit *put() calls.
Thanks for the clarification.


