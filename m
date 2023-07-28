Return-Path: <netdev+bounces-22206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967C77667F4
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517DE282685
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAB6107AB;
	Fri, 28 Jul 2023 08:58:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62066101D9
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:58:05 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ABA1731;
	Fri, 28 Jul 2023 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XO04uRIxA4guTxkcu7RQ08+aVzvwwBtSGQVQXA0Q9qY=; b=YW8CDX+BSc+DoSsnuaaZktrZz2
	kCfgSWqWG0mc07IWwSkwV/nAj+QpdmxsgqTPkwBQpN9FJJeOKZOXtYLxMm34DK5b+RHS6hbFKjZl5
	b6AhT3lsOPdaQE5iBux5Jvos5RJvBE/gmISN4uj4lfahQnSkPejXnEpXUpgSPUiMtuTw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qPJII-002WG8-IX; Fri, 28 Jul 2023 10:57:54 +0200
Date: Fri, 28 Jul 2023 10:57:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
Message-ID: <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728075840.4022760-6-shaojijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 03:58:39PM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> This patch will fix a wrong print "device link down/up". Consider a case
> that set autoneg to off with same speed and duplex configuration. The link
> is always up while the phy state is set to PHY_UP and set back to
> PHY_RUNNING later. It will print link down when the phy state is not
> PHY_RUNNING. To avoid that, the condition should include PHY_UP.

Does this really happen? If autoneg is on, and there is link, it means
the link peer is auto using auto-neg. If you turn auto-neg off, the
link peer is not going to know what speed to use, and so the link will
go down. The link will only come up again when you reconfigure the
link peer to also not use auto-neg.

I don't see how you can turn auto-neg off and not loose the link.

  Andrew

