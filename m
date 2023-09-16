Return-Path: <netdev+bounces-34298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F30E7A30DC
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA70B2822A1
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F213FE2;
	Sat, 16 Sep 2023 14:23:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B576134
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 14:23:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7CF1B1
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fz86dSRzFafV8M8/DhbCwOLeoZx6Wuwz5dH1CKMd0Eo=; b=O2+cwNYiuVqZKBfsKK1R55m3X4
	dkRCCXFap0ucyCaapcLSTbzIISmBwE5cchaapBuiUSSeOXHTXI49kiP+H3aWNtHd6zR7MBwfTbnO3
	HwjwgtgzlMGS5ybn9bdoH/8vRHpefXVC9NA8RvPddwWmaWRApqJe3dyVwd06JCVgMAkE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qhWCs-006dmH-6G; Sat, 16 Sep 2023 16:23:34 +0200
Date: Sat, 16 Sep 2023 16:23:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Mubashir Adnan Qureshi <mubashirq@google.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>
Subject: Re: [PATCH v1 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
Message-ID: <942de224-f18b-474d-b75b-6f08f66541c9@lunn.ch>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916010625.2771731-1-lixiaoyan@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 01:06:20AM +0000, Coco Li wrote:
> Currently, variable-heavy structs in the networking stack is organized
> chronologically, logically and sometimes by cache line access.
> 
> This patch series attempts to reorganize the core networking stack
> variables to minimize cacheline consumption during the phase of data
> transfer. Specifically, we looked at the TCP/IP stack and the fast
> path definition in TCP.
> 
> For documentation purposes, we also added new files for each core data
> structure we considered, although not all ended up being modified due
> to the amount of existing cache line they span in the fast path. In 
> the documentation, we recorded all variables we identified on the
> fast path and the reasons. We also hope that in the future when
> variables are added/modified, the document can be referred to and
> updated accordingly to reflect the latest variable organization.
> 
> Tested:
> Our tests were run with neper tcp_rr using tcp traffic. The tests have $cpu
> number of threads and variable number of flows (see below).
> 
> Tests were run on 6.5-rc1
> 
> Efficiency is computed as cpu seconds / throughput (one tcp_rr round trip).
> The following result shows Efficiency delta before and after the patch
> series is applied.
> 
> On AMD platforms with 100Gb/s NIC and 256Mb L3 cache:

Would it be possible to run the same tests on a small ARM, MIPS or
RISC-V machine?  Something with small L1 and L2 cache, and no L3
cache. You sometimes hear that the Linux network stack has become too
big for small embedded systems, it is thrashing the caches. I suspect
this change will help such machine. But i suppose it could also be bad
for them. We won't know until it is tested.

    Andrew


