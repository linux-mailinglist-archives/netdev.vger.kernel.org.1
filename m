Return-Path: <netdev+bounces-18274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5775634E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8591C209EC
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E02CAD3C;
	Mon, 17 Jul 2023 12:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C11883A
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:53:23 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D36173B
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=FghBvVCdoIzcPT/sKoGIbyEbSBPC09v/P52guL1mFJ4=; b=3K
	u85qIJxz5f5Nr6Zg893rEyhgOJ/vt68dlw0ouCrv2H+qDbbFi9u7w5oWeyI9CI0xR+dhb61MWUFn4
	8xwO5dYIPz6TW80ob6RGvsrc+Fq4e8i/XAAdUhJMLsdnx9kZbz7CX+BY6xVUzVBlvyB2cl6/o9Rmo
	voXypyWvFqlxiW8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLNiw-001Xq7-No; Mon, 17 Jul 2023 14:53:10 +0200
Date: Mon, 17 Jul 2023 14:53:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Riccardo Laiolo <laiolo@leaff.it>
Cc: netdev@vger.kernel.org
Subject: Re: Question on IGMP snooping on switch managment port
Message-ID: <793efa88-2a97-4cc3-9f84-101eef51962d@lunn.ch>
References: <a9d86e8e-2e7e-fe03-731c-ad4c372d4048@leaff.it>
 <db7508ce-6e92-a199-584b-0a729cd767b9@leaff.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db7508ce-6e92-a199-584b-0a729cd767b9@leaff.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 09:32:35AM +0200, Riccardo Laiolo wrote:
> Hi,
> 
> I'm working on a NXP-based embedded board (imx8mp) with a Marvell mv88e6390 switch.
> I'm running Linux 5.15.71 from the NXP downstream git repository (which is a year behind
> the upstream 5.15.y LTS release, I think). I've applied all the commits related to the Marvell
> driver from the 5.15LTS upstream that I was missing into my codebase.
> 
> I can't get the IGMP snooping to works properly. On front facing ports, it appears to work fine:
> MDB rules get correctly updated and multicast packets get blocked or routed accordingly. But when
> the subscribed is my embedded device (so the subscribed device is the switch
> management port) it doesn't work. The first IGMP packet get correctly routed and
> propagated through te network and all the interested node update their MDB entry list.
> 
> From now on all the outgoing IGMP packets get dropped.
> 
> 
> Adding and removing MDB rules by hand I found the offending rule appears to be
> 	dev br0 port br0 grp 224.0.1.185 temp
> 
> this rule gets correctly appended when I open a multicast rx socket,
> but my device fails to answer to any IMGP membership query until I remove said rule.
> 
> What am I missing? Is it possible for a linux network switch to be a multicast recipient device?

Hi Riccardo

It is a good idea to test the latest kernel before reporting problems
to mainline. You can then determine if its a known and fixed issue,
and the back port is missing, or it is something new. Any fix will be
applied to the latest kernel, and will then need back porting.

I would be interested in knowing if:

commit 7bcad0f0e6fbc1d613e49e0ee35c8e5f2e685bb0
Author: Steffen Bätz <steffen@innosonix.de>
Date:   Wed Mar 29 12:01:40 2023 -0300

    net: dsa: mv88e6xxx: Enable IGMP snooping on user ports only
    
    Do not set the MV88E6XXX_PORT_CTL0_IGMP_MLD_SNOOP bit on CPU or DSA ports.
    
    This allows the host CPU port to be a regular IGMP listener by sending out
    IGMP Membership Reports, which would otherwise not be forwarded by the
    mv88exxx chip, but directly looped back to the CPU port itself.


helps.

	Andrew

