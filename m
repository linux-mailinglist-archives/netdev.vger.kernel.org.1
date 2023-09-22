Return-Path: <netdev+bounces-35815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 383ED7AB21F
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 14:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id BC72C1F22E9E
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFF122F17;
	Fri, 22 Sep 2023 12:28:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1083168AA
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 12:28:43 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA71A5;
	Fri, 22 Sep 2023 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/hHJSVVNBq+Q25kH/Q3wHbSMiRa2RSWRIm+2U1rOzjk=; b=RGnfJOeunzJN6IjLYEZrXxcAL/
	fpuqpfDgH6Qj5AGs24gad1FLT/whsUz9i+WsoI2JuCWqvJREJGjVEjZGDNHJYKJ6ciBPPNTd/I/0+
	Zj7N6VWu/XuVFoJ4TnxeWgPsNcLEZE4uTMKvr56eStvdFil+9r9xQ7pQu1x1FCDurx1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qjfGQ-007CHP-5B; Fri, 22 Sep 2023 14:28:06 +0200
Date: Fri, 22 Sep 2023 14:28:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Raju Rangoju <rajur@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: stmmac: increase TX coalesce timer to
 5ms
Message-ID: <13bc074d-30c2-4bbf-8b4c-82f561c844b0@lunn.ch>
References: <20230922111247.497-1-ansuelsmth@gmail.com>
 <20230922111247.497-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922111247.497-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 01:12:47PM +0200, Christian Marangi wrote:
> Commit 8fce33317023 ("net: stmmac: Rework coalesce timer and fix
> multi-queue races") decreased the TX coalesce timer from 40ms to 1ms.
> 
> This caused some performance regression on some target (regression was
> reported at least on ipq806x) in the order of 600mbps dropping from
> gigabit handling to only 200mbps.
> 
> The problem was identified in the TX timer getting armed too much time.
> While this was fixed and improved in another commit, performance can be
> improved even further by increasing the timer delay a bit moving from
> 1ms to 5ms.
> 
> The value is a good balance between battery saving by prevending too
> much interrupt to be generated and permitting good performance for
> internet oriented devices.

ethtool has a settings you can use for this:

      ethtool -C|--coalesce devname [adaptive-rx on|off] [adaptive-tx on|off]
              [rx-usecs N] [rx-frames N] [rx-usecs-irq N] [rx-frames-irq N]
              [tx-usecs N] [tx-frames N] [tx-usecs-irq N] [tx-frames-irq N]
              [stats-block-usecs N] [pkt-rate-low N] [rx-usecs-low N]
              [rx-frames-low N] [tx-usecs-low N] [tx-frames-low N]
              [pkt-rate-high N] [rx-usecs-high N] [rx-frames-high N]
              [tx-usecs-high N] [tx-frames-high N] [sample-interval N]
              [cqe-mode-rx on|off] [cqe-mode-tx on|off] [tx-aggr-max-bytes N]
              [tx-aggr-max-frames N] [tx-aggr-time-usecs N]

If this is not implemented, i suggest you add support for it.

Changing the default might cause regressions. Say there is a VoIP
application which wants this low latency? It would be safer to allow
user space to configure it as wanted.

     Andrew

