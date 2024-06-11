Return-Path: <netdev+bounces-102581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01843903CB6
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A63B21964
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D5517BB3C;
	Tue, 11 Jun 2024 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oMU7D+Px"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99A17B406;
	Tue, 11 Jun 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111216; cv=none; b=r88X3xsjGn+DG7oSCD8qweKyjTirSdOqD1cvU5s2e6VTGwFGKMxO8YK95j95vYzCPsUifyMaRDaeRU0AIX4VHCyTvr3jLF9frgQ5Qa3dvSXslYIss745zKvbMUhT0LIrzOxofoQjRKs918Kd9/YBwTulMza27kB5E6Iw2sId56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111216; c=relaxed/simple;
	bh=qeFyIhjyRVr3qLO9JcdFGRIv32av/Bt1hR6Zi26OP68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWvMvoP1RP4gK6sbgdpIyzqW51D+Rj378YnSdzTqOvx5uMySGPL5Q0wjcRWC2oooVEyNVa0DKBnlmM5RcGo3/cN2ePtrnn2bPXoPcrKR9hNp/qfWYy2skfcV9Bca9qnP/jv1+z/3b801RK6e49I60hEzxplwoHfb8IH4n7T6BKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oMU7D+Px; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=4RzQfhz9JM3uFuWXMZQu3myfhwQMauJsDyAR+I1tfCg=; b=oM
	U7D+PxxIgKdbxS9Lf6Rj5kMt/vXWOCXaEvkwqxopuk2siBu53kzjYuhgw6ImVNHLHJqKkydW2z96s
	CLFnQ19UPSdxPgwJ6v15/zcHHDTrQd/wbqAHFII7CgCHJIq+IeaVLGUhCUDDsFkzqdaw0Xs+WCcNS
	af2/Zg2U+ZGmwQ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sH1D9-00HO90-LP; Tue, 11 Jun 2024 15:06:51 +0200
Date: Tue, 11 Jun 2024 15:06:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v2] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588
 being cleared on link-down
Message-ID: <c49a5e28-e030-4fc1-ab30-9afd997f03bc@lunn.ch>
References: <20240607081855.132741-1-csokas.bence@prolan.hu>
 <46892275-619c-4dfb-9214-3bbb14b78093@lunn.ch>
 <d6d6c080-b001-4911-83bc-4aca7701cdff@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6d6c080-b001-4911-83bc-4aca7701cdff@prolan.hu>

On Tue, Jun 11, 2024 at 10:04:39AM +0200, Csókás Bence wrote:
> Hi!
> 
> On 6/10/24 21:13, Andrew Lunn wrote:
> > On Fri, Jun 07, 2024 at 10:18:55AM +0200, Csókás, Bence wrote:
> > > FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
> > > makes all 1588 functionality shut down on link-down. However, some
> > > functionality needs to be retained (e.g. PPS) even without link.
> > 
> > I don't know much about PPS. Could you point to some documentation,
> > list email etc, which indicated PPS without link is expected to work.
> > 
> > Please also Cc: Richard Cochran for changes like this.
> > 
> > Thanks
> > 	Andrew
> 
> This is what Richard said two years ago on the now-reverted patch:
> 
> Link: https://lore.kernel.org/netdev/YvRdTwRM4JBc5RuV@hoboy.vegasvil.org

Thanks.

So when you have sync, you have a 1Hz clock, synchronised to the grand
master. When the link is down, or communication with the grand master
is lost, you get a free running clock of around 1Hz. I presume that if
the link does up again and communication to the grand master is
restored, there is a phase shift in the 1Hz clock, and a frequency
correction? The hardware has to cope with this.

> Plus, this patch doesn't even re-enable PPS or any other 1588 functions, it
> just prevents the adapter from forgetting it is even 1588-capable. I'll
> resubmit with more clear wording and appropriate "Fixes:" and "Cc:" tags.

Thanks

	Andrew

