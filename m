Return-Path: <netdev+bounces-12376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC11C73742C
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBA72813F6
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A017AC9;
	Tue, 20 Jun 2023 18:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2917AB9
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 18:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2825CC433C0;
	Tue, 20 Jun 2023 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687285822;
	bh=YzvlpBIJ1S4sFH9+hFPo656i1oKTPdpC6wWZXmsHRWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PHSUD+Pasa8bpAfIKjED6alVB4e3Fk+TexGxStJYHad3fXhv+ZQgliUhTmGpE51TG
	 ZUtm4loVwwbhRi7Hgb6xBQomyKemzogSJiGe22RQXiv5dq8n3Dg8StBa2bbqijZ4F7
	 MYlGWUp88djXdvtWi9GYcZyL+bY9DfJk3hq87jmOmB/x1VidNpaJ6ReeUNNNDvgSv2
	 4iTUEv05ZOy98hqaFOSjXfhg5Hex3xl/MKo3DDzmadUr0RFhPELaf6Ce9iDmq0a9EN
	 bGFtU/rUio5mk8/Yvi/JWIR3SCFKXsUrU3gzIhQBOMX8BrHSJtzcbEFWJfWSNkL3Fs
	 N/hBgi5bPnXJg==
Date: Tue, 20 Jun 2023 11:30:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v3] net: micrel: Change to receive timestamp in
 the frame for lan8841
Message-ID: <20230620113021.01d90f90@kernel.org>
In-Reply-To: <20230615094740.627051-1-horatiu.vultur@microchip.com>
References: <20230615094740.627051-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jun 2023 11:47:40 +0200 Horatiu Vultur wrote:
> Currently for each timestamp frame, the SW needs to go and read the
> received timestamp over the MDIO bus. But the HW has the capability
> to store the received nanoseconds part and the least significant two
> bits of the seconds in the reserved field of the PTP header. In this
> way we could save few MDIO transactions (actually a little more
> transactions because the access to the PTP registers are indirect)
> for each received frame.
> 
> Instead of reading the rest of seconds part of the timestamp of the
> frame using MDIO transactions schedule PTP worker thread to read the
> seconds part every 500ms and then for each of the received frames use
> this information. Because if for example running with 512 frames per
> second, there is no point to read 512 times the second part.
> 
> Doing all these changes will give a great CPU usage performance.
> Running ptp4l with logSyncInterval of -9 will give a ~60% CPU
> improvement.

Richard, looks good?

I'm not sure if the settime handling is sufficient, some packets may
still sneak thru both getting stamped with new value of time and use
old upper bits and get stamped with old bits and use new upper.
Can we disable timestamping, drain the queue, then change the time
and enable stamping again?

