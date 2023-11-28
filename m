Return-Path: <netdev+bounces-51859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A463D7FC78E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 22:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1EF2863E6
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795CF5B5B4;
	Tue, 28 Nov 2023 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGHEzXDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9385ABA5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 21:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3592C433C8;
	Tue, 28 Nov 2023 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205792;
	bh=tXa4IaJmzciNF0iZzlcnBzOtCmHK4OGRBMCKthyJduM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cGHEzXDnSo4mSn/yrWhC89u5s5/77cs50KQuEW2dGR4V2O2Lh4ba382SEEHx+QOK+
	 HcmdrmloTNE7vWFl7nruXiE0dWOp5pqCVZA6Z7+NjCgwNgFLWYXUyAOHtu4apI0EHn
	 9BvL2Sx68TC7HxMUn/8Bytpf5GnSThgabFb4zHKLJFq8qEAjXxapYBiZ4sTbr8cuzi
	 bEq8UmdPoXjYpLb8NCQzeTQwJQ8H1X2r/8GaodSivXmdkampo7C0cn7y/4Pd2vf5H2
	 oCcn9CwBOue8oOGI1YOAeYGKAd3xF+I2MOHP7WuVXIVBuhu0/t+sd4xLQP0+z0ERAZ
	 L5n5cZQrTrvRQ==
Date: Tue, 28 Nov 2023 13:09:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Igor Russkikh <irusskikh@marvell.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Netdev
 <netdev@vger.kernel.org>
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
Message-ID: <20231128130951.577af80b@kernel.org>
In-Reply-To: <9852ab3e-52ce-d55a-8227-c22f6294c61a@marvell.com>
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
	<cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
	<20231127145945.0d8120fb@kernel.org>
	<9852ab3e-52ce-d55a-8227-c22f6294c61a@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 20:18:49 +0100 Igor Russkikh wrote:
> > Another option you can consider is lowering the default ring size.
> > If I'm looking right you default to 4k descriptors for Tx.
> > Is it based on real life experience?  
> 
> Probably reducing default will help - but again not 100%.
> 
> I remember these numbers where chosen mainly to show up good 10Gbps
> line speed in tests, like iperf udp/tcp flood. But these of course
> artificial.
> 
> For sure "normal" user can survive even with lower digits.

For Rx under load larger rings are sometimes useful to avoid drops.
But your Tx rings are larger than Rx, which is a bit odd.

I was going to say that with BQL enabled you're very unlikely to ever
use much of the 4k Tx ring, anyway. But you don't have BQL support :S

My free advice is to recheck you really need these sizes and implement
BQL :)

