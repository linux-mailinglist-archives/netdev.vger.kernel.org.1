Return-Path: <netdev+bounces-21488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9848D763B38
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8CF1C212B4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA703253D0;
	Wed, 26 Jul 2023 15:37:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C51DA5F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33DAC433C8;
	Wed, 26 Jul 2023 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690385829;
	bh=Dq3Ew/vR82lY45pv151dWz7lZf5a3r9zNeKkTHvnIOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dAQKLJHUSj7N6nB7nqA7D2wq15UgMU1sLUJhsItCoNbGWx4RxK/3tXHA+BPterl62
	 IYer6rwkc8fXxRR6BkXxWk57IIMvem1Hq8En3KDwJf5aIqOy64ned6rFuerVgujt4V
	 L96DFs3RQSj5w1or8/1IJkMBeIJTb6i9aNPCTMTy7sF483rM5//aNHO/Ap4Op1WFfD
	 wmvdpqeGbRHyKj72DzAknDRiRG7Xuj9kHb2muJvDfq4b9vO0pMKnxpOk+KbW/VZmQm
	 siPALaGza9JQOWmBfhuXwLQBT/XDS50RYBpeFh/Rz4sERMaGo3BpnM89CZ14zsqJvk
	 WOfa35WGIIpGw==
Date: Wed, 26 Jul 2023 08:37:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Md Danish Anwar <a0501179@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap
 <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>, Simon Horman
 <simon.horman@corigine.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew
 Lunn <andrew@lunn.ch>, Richard Cochran <richardcochran@gmail.com>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David
 S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXTERNAL] Re: [PATCH v11 06/10] net: ti: icssg-prueth: Add
 ICSSG ethernet driver
Message-ID: <20230726083707.623da581@kernel.org>
In-Reply-To: <9b11e602-6503-863a-f825-b595effd5e1d@ti.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
	<20230724112934.2637802-7-danishanwar@ti.com>
	<20230725210939.56d77726@kernel.org>
	<9b11e602-6503-863a-f825-b595effd5e1d@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 16:01:23 +0530 Md Danish Anwar wrote:
> I think MAX_SKB_FRAGS is OK. If the available pool = MAX_SKB_FRAGS we should be
> able to wake the queue.

MAX_SKB_FRAGS only counts frags and you also need space to map the head, no?

In general we advise to wait until there's at least 2 * MAX_SKB_FRAGS
to avoid frequent sleep/wake cycles. But IDK how long your queue is,
maybe it's too much. 

> No I don't think any lock is required here. emac_set_port_state() aquires lock
> before updating port status. Also emac_ndo_set_rx_mode_work() is scheduled by a
> singlethreaded workqueue.

if (netif_running()) outside of any locks is usually a red flag, but if
you're confident it's fine it's fine :)

