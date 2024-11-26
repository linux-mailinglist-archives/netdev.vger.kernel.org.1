Return-Path: <netdev+bounces-147486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027309D9CC6
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 18:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0049167DD4
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B11DBB32;
	Tue, 26 Nov 2024 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tYLPoCpC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6980C02
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642941; cv=none; b=B4ibOOCZZLMBdd/vtMB8X63E4U8SJiaelxjpX5GWuiMqnm942Ro37j5MxoHnRDYkmgmkfqwMqBswrL8YfvG5SHyTO4p8sDD12nd2OkeANAC3may4r0HoguEc0WOlZfZtP34hg2ryb/l+h+yGA37nbT8w1e1bafzPDd+KpiHFo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642941; c=relaxed/simple;
	bh=BcKC7i/ERX6unNweVFB85U8BlMyzsfQzYZrPj8n03Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FErLaSt1zhy1H5Tl69UysmKiatxHcGNPSxKsKtjmtrXzzBR6LGN5rp7g2cuMSfB0K2Y6cJ9P4+lncRNzJRsEKzEixcmkxpI7+B5U/035XoIdylhDtIW9D9wa7BPBGJD00awERNFdSIbhi3wmsETmPQjPFPZECZnfuXOwJ3awvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tYLPoCpC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p9KO4aD1pNaj06JQBoCDJRQ9TSOEHmgHW2kQNpAw0oI=; b=tYLPoCpC+vuMB+EE4pbMtXSwaB
	iokgeZiwTlvi2RXBy0twtv5iNjYpR8Syese640fTdkZSo+krozcDxDddPheThaMskAxbPwrXmiNfP
	+D9L8OxYAAYv3vgHyEeW20TffmVQrXxWtCrcdjH9RAUaQbSPrtXTmtEEge4u9zP9hVD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tFzZn-00EXpD-L7; Tue, 26 Nov 2024 18:42:15 +0100
Date: Tue, 26 Nov 2024 18:42:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix incorrect PHY settings for 100 GB/s
Message-ID: <946b6621-fd35-46b9-84ee-37de14195610@lunn.ch>
References: <20241126102311.344972-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126102311.344972-1-przemyslaw.korba@intel.com>

On Tue, Nov 26, 2024 at 11:23:11AM +0100, Przemyslaw Korba wrote:
> ptp4l application reports too high offset when ran on E823 device
> with a 100GB/s link. Those values cannot go under 100ns, like in a
> PTP working case when using 100 GB/s cable.
> This is due to incorrect frequency settings on the PHY clocks for
> 100 GB/s speed. Changes are introduced to align with the internal
> hardware documentation, and correctly initialize frequency in PHY
> clocks with the frequency values that are in our HW spec.
> To reproduce the issue run ptp4l as a Time Receiver on E823 device,
> and observe the offset, which will never approach values seen
> in the PTP working case.

You forgot to Cc: the PTP maintainer.

If i spent the time to measure the latency and configured ptp4l
correctly to take into account the latency, would i not see this
issue? And will this change then cause a regression because it changes
the latency invalidating my measurements?

    Andrew

