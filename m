Return-Path: <netdev+bounces-17341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACB6751534
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0851C21018
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A61364;
	Thu, 13 Jul 2023 00:24:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134D7C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA29C433C7;
	Thu, 13 Jul 2023 00:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689207855;
	bh=P6arqZIe+RjBmTWAU1pEWM5NzMdhSRGIkio6Ushxf9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZTsDZxm1xC06+cLELu1r95O1R0gorOp2vhROgNJCi/4t4z6jqEF54784P7CjM1EOG
	 j6NSt9dXG3MccsCHCz0FY7NVF7D/GUYqdsqIGJWIKUL3CuB3/3gzLZF6IrG3yH+IcW
	 Yz7UXpmf3/Lh05H859ZLLFREY13WWtQ8WFUn4eW1Y2iZhvSq+3uOdagttP4puyEpYa
	 P0TMuUzW4xgyRQc/9Fy4yiSn19CrdkSigcqfGUCNDuBbzZtp3oQkrUtviNEciVLMXm
	 5haGiFdPprNub+k9EYhiu+BjluHjniXdukvE1vdT/TVShHk/JoNcZJyNf4vVE4sJla
	 hdkj+cnDMgLwg==
Date: Wed, 12 Jul 2023 17:24:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Zekri, Ishay" <Ishay.Zekri@dell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
 <edumazet@google.com>, "Panina, Alexandra" <Alexandra.Panina@dell.com>,
 "Barcinski, Bartosz" <Bartosz.Barcinski@dell.com>
Subject: Re: MCVLAN device do not honor smaller mtu than physical device
Message-ID: <20230712172414.54ef3ca8@kernel.org>
In-Reply-To: <BN0PR19MB5310720D5344A0EBDFC66D9D9F36A@BN0PR19MB5310.namprd19.prod.outlook.com>
References: <BN0PR19MB5310720D5344A0EBDFC66D9D9F36A@BN0PR19MB5310.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 09:06:20 +0000 Zekri, Ishay wrote:
> Hi,
> 
> We experiencing an issue in which MACVLAN MTU does not limit the frame size,
> i.e. the limitation is coming from the physical device MTU.
> Kernel version: 5.3.18
> 
> As described in the case below:
> https://unix.stackexchange.com/questions/708638/macvlan-device-do-not-honor-smaller-mtu-than-physical-device 
> 
> it seems like this issue might have a fix.
> 
> If there was a known kernel issue that was fixed, I really apricate if you can provide to me the commit in which it was fixed.

In the post above you seem to be pinging the local IP address.

129: K9AT9i1G2x@eth6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether ba:c7:36:3f:9a:76 brd ff:ff:ff:ff:ff:ff
    inet 192.168.15.40/21 scope global K9AT9i1G2x
         ^^^^^^^^^^^^^
 # ping -c 3 -M do -s 8972 192.168.15.40
                           ^^^^^^^^^^^^^

Local traffic gets routed thru the loopback interface which has 
the default MTU of 64k. Did you try to ping something outside
of the host?

