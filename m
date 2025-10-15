Return-Path: <netdev+bounces-229573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B15DBBDE679
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FF419C29DB
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E614324B3C;
	Wed, 15 Oct 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="14+Nn4BM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72953233ED;
	Wed, 15 Oct 2025 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530165; cv=none; b=NcJDkUkpCjgsaH/ul1w4UCC1eIFici/1nGXIzzz++NJaz6NkjVHbEp0YqvCgrV9mgJT4fa5/QU2YPI1sRkiEcQY0HjwzXZpeOQ3o4FSA+iRi/DO+13j8sInsXgCcUvn/I+25bngjcxEiH10cznPg04C1BdpVBUiLXXMsrnpInlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530165; c=relaxed/simple;
	bh=byDt9cJNaoV9UerzEQZrWBXDSIWGA1UsTPnBa3lcc2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHYRex9HI4PtsaEBb3f6mfRWyzVzhdUatYuuu4noAQ7uVJRNUuAdDDMBbgHHz/bTJ63C+i1/NtxT9Epf2WvyMBeC2k6tSvw6T08RtyhvZU7qM/o65z3C7PzddfG80dQJ6vcGpan6bQiVVb2sxPq0avLObUc0uFAhOT3Q5Q3Fj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=14+Nn4BM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6qLbkEn/jIW40ylFRsyZqZoQ0CK2OjczehoMcmU90RA=; b=14+Nn4BMuFFT7DcJryd1+OKTcx
	f/hvL2nKX7yIJaFKQ725q52wAYCItNbYGSQqG1OMTfmvmKg+0mon5EyLpCPlXvz/aGMNNB1lpqbhR
	MViyAdas/OJMpHrQuONAV2TBGp2sP31eQcFolR0P6INNpBiVqcFG/Cx3eZXG4DW5yeXA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v90Jb-00B1Qw-Lg; Wed, 15 Oct 2025 14:09:11 +0200
Date: Wed, 15 Oct 2025 14:09:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Conor Dooley <conor@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <0d90ce60-a7cd-4fff-9db2-489531e3c944@lunn.ch>
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
 <20251014-flattop-limping-46220a9eda46@spud>
 <20251014-projector-immovably-59a2a48857cc@spud>
 <20251014120213.002308f2@kernel.org>
 <20251014-unclothed-outsource-d0438fbf1b23@spud>
 <20251014204807.GA1075103-robh@kernel.org>
 <20251014181302.44537f00@kernel.org>
 <CAL_Jsq+SSiMCbGvbYcrS1mGUJOakqZF=gZOJ4iC=Y5LbcfTAUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+SSiMCbGvbYcrS1mGUJOakqZF=gZOJ4iC=Y5LbcfTAUQ@mail.gmail.com>

> I also considered looking at who the email is from and restricting it
> to the maintainers. I know the netdev one doesn't do that either
> because I used it a couple of times. :) It does seem like it could be
> abused.

The netdev one does have some restrictions.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#updating-patch-status

says:

  The use of the bot is restricted to authors of the patches (the
  From: header on patch submission and command must match!),
  maintainers of the modified code according to the MAINTAINERS file
  (again, From: must match the MAINTAINERS entry) and a handful of
  senior reviewers.

Here is one example from you:

https://patchwork.kernel.org/project/netdevbpf/patch/20241113225742.1784723-2-robh@kernel.org/

and it was your own patch.

All its actions are logged:

https://netdev.bots.linux.dev/pw-bot.html

so we can keep an eye of out for abuse. Plus, since it is an email to
patchwork, patchwork itself should have any abuse emails.

	Andrew

