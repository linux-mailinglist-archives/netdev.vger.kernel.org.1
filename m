Return-Path: <netdev+bounces-46043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B57E7E1004
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53252819C1
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751941A59A;
	Sat,  4 Nov 2023 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MyAGr/qT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581EF9FB
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 15:08:14 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCA3A6
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QFm83Gbsw+6FT25WZTt028S6MoIcNPNaolRbkGilzqM=; b=MyAGr/qTcZLHDdxCydi9t4y2Ty
	soOPrGGJ1kw2R5sYwVl3/Uc02tOM9NmCNfln4ObmQIqwz9Ko+Xsifx3H68sJvQdCrldp/15dyTg62
	vWDByMzeXLNN9SRAbB5BB4uiHb2BJCAfllr2Y6ZqghvEWQ8lh3td8CMcYFD4/bczXGYM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qzIFv-000sV3-JN; Sat, 04 Nov 2023 16:08:11 +0100
Date: Sat, 4 Nov 2023 16:08:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: Bypass qdiscs?
Message-ID: <29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch>
References: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>

On Fri, Nov 03, 2023 at 04:55:35PM -0700, John Ousterhout wrote:
> Is there a way to mark an skb (or its socket) before invoking
> ip_queue_xmit/ip6_xmit so that the packet will bypass the qdiscs and
> be transmitted immediately? Is doing such a thing considered bad
> practice?
> 
> (Homa has its own packet scheduling mechanism so the qdiscs are just
> getting in the way and adding delays)

Hi John

One thing to think about is what happens when hardware starts
supporting Homa. Can the packet scheduling be moved into the hardware?
Ideally you want to make use of the existing mechanisms to offload
scheduling to the hardware, rather than add a Homa specific one.

Did you try adding a Homa specific qdisc implementing the scheduling
algorithm? Did it kill performance? We prefer to try to fix problems,
rather than bypass them.

       Andrew

