Return-Path: <netdev+bounces-14992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E77744DFE
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723071C2084D
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858A2101;
	Sun,  2 Jul 2023 13:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A43F20FE
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 13:46:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBB3E55
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IK4VDT+SmmuMfZmYpgZ8ApnQVcn+Rr1grO6m4P5rCIM=; b=lNs6NbNYj9JRLAXb5wQay4wpYF
	OOkvjD1VmWii65J55ojjwk9bXkZg6GkTSpjurQGKEHILgW15+JyvzTK6esLokqQQaS8Lyy06USrPn
	wDf8pERIjvJAbip6FQMek3PQjvof0hG888CLN9XTDusg52CBZyvuAQv88N9yFs+0CH0A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qFxPE-000PSc-3y; Sun, 02 Jul 2023 15:46:24 +0200
Date: Sun, 2 Jul 2023 15:46:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Abhiram V <abhi.raa.man.v@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Custom Kernel Module for PRP (https://github.com/ramv33/prp) -
 problem with removal of RCT using skb_trim
Message-ID: <504969a9-94f5-4175-a846-37c39ec0f06c@lunn.ch>
References: <CAHaZnwP-KHYkVnWjsa_8cXq+-EJH1dWGMKwSkvu6GAU5MhgJnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHaZnwP-KHYkVnWjsa_8cXq+-EJH1dWGMKwSkvu6GAU5MhgJnA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> To strip the RCT, I call skb_trim as follows (as given in the HSR module):
> 
>              skb_trim(skb, skb->len - PRP_RCTLEN /* 6 */);
> 
> I have used skb_dump both before and after the call to skb_trim and
> verified that the length is being reduced and that the tailroom is
> increased by 6 bytes. The problem is that when I call skb_trim, the
> packet is not received by the upper layers. Without calling skb_trim,
> the packet is received correctly but the RCT is consumed by the
> applications which should not be the case.

Maybe try using:

https://github.com/nhorman/dropwatch

to find out where the packet is being dropped. From where, you should
be able to figure out why it is being dropped.

You might also want to play with ethool -K. Turn off everything, at
both the Tx and Rx node, and see if it makes a difference. e.g. maybe
IP header checksum is being offloaded, and it calculates the CRC
including the RCT.

	Andrew

