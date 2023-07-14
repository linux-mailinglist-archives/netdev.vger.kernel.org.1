Return-Path: <netdev+bounces-17781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB56575308E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566BB1C2146A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EBD4C8F;
	Fri, 14 Jul 2023 04:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD14C8A
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:26:24 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC622699
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6skC+RvlbgbyR/EKdDhgXCrauBUUoVWMmNI+FpROXw0=; b=ZA
	QyujDuQ1sfGmafrrfcCvd+rhP1K79PCc4emzpotEiNGyElG2pxWRkWQ5n6bFQ5H/5Nim+TUs2Y7Kn
	1JwQmMboyuXj+Up9jUj8UjEV1nxIcTKDPkN/fzD/itB0saKjXwNLc5wM8gw0h9gSwHf/dpCuEhLtC
	uo+afiQttGL5zdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qKANi-001Jhl-KJ; Fri, 14 Jul 2023 06:26:14 +0200
Date: Fri, 14 Jul 2023 06:26:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
	dongbiao@loongson.cn, loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [RFC PATCH 10/10] net: stmmac: dwmac-loongson: Add GNET support
Message-ID: <f50469a6-74ed-44bc-a2aa-fafdec717cc3@lunn.ch>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
 <98b53d15bb983c309f79acf9619b88ea4fbb8f14.1689215889.git.chenfeiyang@loongson.cn>
 <e491227b-81a1-4363-b810-501511939f1b@lunn.ch>
 <CACWXhKmLRK5aGNwDyt5uc0TK8ZXZKuDQuSXW6jku+Ofh73GUvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACWXhKmLRK5aGNwDyt5uc0TK8ZXZKuDQuSXW6jku+Ofh73GUvw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 10:24:37AM +0800, Feiyang Chen wrote:
> On Thu, Jul 13, 2023 at 12:07 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Thu, Jul 13, 2023 at 10:49:38AM +0800, Feiyang Chen wrote:
> > > Add GNET support. Use the fix_mac_speed() callback to workaround
> > > issues with the Loongson PHY.
> >
> > What are the issues?
> >
> 
> Hi, Andrew,
> 
> There is an issue with the synchronization between the network card
> and the PHY. In the case of gigabit operation, if the PHY's speed
> changes, the network card's speed remains unaffected. Hence, it is
> necessary to initiate a re-negotiation process with the PHY to align
> the link speeds properly.

When the line side speed changes, the PHY will first report link down
via the adjust_link callback in the MAC driver. Once the PHY has
determined the new speed, the adjust_link callback will be called
again with the new speed and pause parameters.

So what is actually going wrong?

   Andrew

