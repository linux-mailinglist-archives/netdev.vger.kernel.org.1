Return-Path: <netdev+bounces-141320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AF29BA784
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB54CB2165E
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 18:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0634D188014;
	Sun,  3 Nov 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YQ0JsQDf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73A187879;
	Sun,  3 Nov 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660077; cv=none; b=DV/rVzl8q57J3yovGSPg+f6aogUHnodNJGWDH9cIvMM3ElhEmvAeJmmdDx55pMBEM/WBqs0VPLTaT48jhtZ5iZZ2igNKR4xk1ReFb0/2EP6mk4bnFLYWwP86zdCKUrAo9rE3myF1REMAppxMKk65CzVkTJ7FmGYuVCKUFdFdwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660077; c=relaxed/simple;
	bh=Iyd8Of8fiETGqofHwy1z8/+og4fuf9C4dTnHGRLKvTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FM6QG9tReIjUGev+S+tBkuN4nnBAYz02SBUnY86sVUaSd+tEcxAfl6zMfO3Y1hRJq9GhCY7YunYnSM8huCjx6tCYED553SQFDByjJzhPJO07bOFq1/tPtzoHIl2IepUU0r9UF6GJwF5g+Tn6ioGyDCNrf3crWLOdH9lHcjJty0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YQ0JsQDf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N1fbm+gCyUE3nlJFxA64iuCPhiDOK9df7YjXpC2W4wU=; b=YQ0JsQDfLhClW0vRGdItj9WbT3
	M/vd0rWboKYaABOmqwofOoQKRi3wzDGOrboRs5/y17WqXklPbzY6+1m5vcNLrSoikUnU+pa6FujQr
	8aB6U+oaFi4i/pJlyXzDdjE0HcyOMa6wzFxB1Z9ry1T6YGHUwvn0rW7FfXXZWVsCmhcU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7fk6-00C250-2I; Sun, 03 Nov 2024 19:54:30 +0100
Date: Sun, 3 Nov 2024 19:54:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: 'Jakub Kicinski' <kuba@kernel.org>,
	"Gongfan (Eric, Chip)" <gongfan1@huawei.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	"Guoxin (D)" <guoxin09@huawei.com>,
	shenchenyang <shenchenyang1@hisilicon.com>,
	"zhoushuai (A)" <zhoushuai28@huawei.com>,
	"Wulike (Collin)" <wulike1@huawei.com>,
	"shijing (A)" <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>
Subject: Re: [RFC net-next v01 1/1] net: hinic3: Add a driver for Huawei 3rd
 gen NIC
Message-ID: <661620c5-acdd-43df-8316-da01b0d2f2b3@lunn.ch>
References: <cover.1730290527.git.gur.stavi@huawei.com>
 <ebb0fefe47c29ffed5af21d6bd39d19c2bcddd9c.1730290527.git.gur.stavi@huawei.com>
 <20241031193523.09f63a7e@kernel.org>
 <000001db2dec$10d92680$328b7380$@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001db2dec$10d92680$328b7380$@huawei.com>

On Sun, Nov 03, 2024 at 02:29:27PM +0200, Gur Stavi wrote:
> > On Wed, 30 Oct 2024 14:25:47 +0200 Gur Stavi wrote:
> > >  50 files changed, 18058 insertions(+)
> > 
> > 4kLoC is the right ballpark to target for the initial submission.
> > Please cut this down and submit a minimal driver, then add the
> > features.
> 
> Ack.
> There is indeed code which is not critical to basic Ethernet functionality
> that can be postponed to later.
> 
> Our HW management infrastructure is rather large and contains 2 separate
> mechanisms (cmdq+mbox). While I hope we can trim the driver to a VF-only
> version with no ethtool support that will fit the 10KLoC ballpark, the 4KLoC
> goal is probably unrealistic for a functional driver.

It is really all about making you code attractive to reviewers. No
reviewer is likely to have time to review a single 10KLoc patch. A
reviewer is more likely to look at the code if it is broken up into 15
smaller patches, each one which can be reviewed in a coffee break
etc. Also, reviewers have interests. I personally have no interest in
mailbox APIs, actually moving frames around, etc. I want to easily
find the ethtool code, have you got pause wrong like nearly everybody
does, are the statistics correctly broken up into the standard groups,
are you abusing debugfs? Having little patches with good subject lines
will draw me towards the patches i want to review.

10KLoC is still on the large size. Can you throw VF out, it is just a
plain borring single function device, like the good old e1000e?

	Andrew

