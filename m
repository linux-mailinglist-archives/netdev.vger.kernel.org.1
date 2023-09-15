Return-Path: <netdev+bounces-34067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8DC7A1F45
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6DD2823D6
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC92107B9;
	Fri, 15 Sep 2023 12:53:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE5FCA70
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:53:50 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF2173A
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1sSQCFa2lZHHHZ6UlFZIQsetb9KVGwQyXEy9w/xFba0=; b=iKuO5Zav4SvI/Kp2kpmN3wTRQk
	gjtOfK3Oe8pt1uJAIRmsQEkjY/Geq57ApfqIU4ZHkiwxMMOGEqflPZmGRXDBVh1usuuCMCehIt7AM
	yWGIGD9IDFpGTxNFLMOPgl35Av3wjaviwidKArHWhSWyg87LOSjDSA4WLXb0xzg4a4VU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qh8KQ-006XeX-6N; Fri, 15 Sep 2023 14:53:46 +0200
Date: Fri, 15 Sep 2023 14:53:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yachen Liu <blankwonder@gmail.com>
Cc: netdev@vger.kernel.org, michael.jamet@intel.com,
	mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Subject: Re: [Bug][USB4NET] Potential Bug with USB4NET and Linux Bridging
Message-ID: <5d2f7260-819f-4197-b3a6-a7146cb71f66@lunn.ch>
References: <CAPsLH6aHJGG7kAaZ7hdyKoSor4Ws2Fwujjjxog6E_bQrY1fA+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPsLH6aHJGG7kAaZ7hdyKoSor4Ws2Fwujjjxog6E_bQrY1fA+w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 10:02:24PM +0800, Yachen Liu wrote:
> Hello,
> 
> I've noticed a potential issue with USB4NET when used in conjunction
> with Linux bridging. I'm uncertain if it's a bug or a configuration
> oversight on my part.
> 
> In essence, when the device at the other end of Thunderbolt sends
> packets using the TSO mechanism (default behavior in macOS), the Linux
> thunderbolt0 interface correctly receives this large packet. However,
> the packet isn't properly forwarded to another device via bridging.

Maybe three is a concept mix up here. TSO is TCP Segmentation Offload.
The network stack gives the NIC a large buffer and a template
Ethernet, IP and TCP header. The NIC is then supposed to send MTU
sized frames on the wire, performing segmentation and appending real
headers to each Frame.

We also have Jumbo packets. These are a single frames which are bigger
than he standard 1500 MTU.

You can also combine these. So the stack could for example pass a 64K
buffer to the NIC for TSO, and the MTU could be 8K. So you would
expect to see 8 frames on the wire.

When running tcpdump, what do you actually see? Is TSO actually
happening? Are the frames the size of the MTU or less?

	   Andrew

