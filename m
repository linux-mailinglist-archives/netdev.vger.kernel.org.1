Return-Path: <netdev+bounces-43910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE7A7D548E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD82281630
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04B329414;
	Tue, 24 Oct 2023 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEHqTEi7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E7273E1
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB23C433C9;
	Tue, 24 Oct 2023 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159550;
	bh=aa4Ls/pdF9G/SIrSROntnz15DjH0eznKEP+phgpolfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sEHqTEi7/hk1CoVb0pNsePlJvj7io3hZWecDvvgOhY/p3+JrE13VoA8nlZQkKQ1Kc
	 N20lmhhpnsGEXCM1klduXJ2WujtHjmFi5e7MJrQym02vVMvVUFDA19dR3ghXWH41GP
	 Y4gx3lXLVrc0CqAe9tClRLCA3ZciOc55PuR2esd4wYNeidzXtZlc1pbuOklmJZ6Qlr
	 Mh04yMnBSZJVKfU9vHb0zoc9inx07jnJQk/tT5ctQX+FeR+Vkfcjjdom45c6CU0XFT
	 hpURYPrIhUUWZzeT2/eUlSrN++ChljRi8XBmXqzCuzP0qqOPqke9NnVqqdAMiR2CTu
	 MBWiZPeqzbfFA==
Date: Tue, 24 Oct 2023 07:59:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
 pabeni@redhat.com, imagedong@tencent.com
Subject: Re: [PATCH v17 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <20231024075908.68730358@kernel.org>
In-Reply-To: <ZTfNfvtZz7F1up6u@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
	<20231024125445.2632-3-aaptel@nvidia.com>
	<ZTfNfvtZz7F1up6u@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 15:58:22 +0200 Jiri Pirko wrote:
> >+definitions:
> >+  -
> >+    type: enum
> >+    name: cap
> >+    entries:
> >+      - nvme-tcp
> >+      - nvme-tcp-ddgst-rx
> >+
> >+uapi-header: linux/ulp_ddp_nl.h  
> 
> Not needed.
> Hmm, Jakub, why this is not only allowed in genetlink-legacy?

Agreed that it's not needed here.
There's a non-trivial chance of name collisions between new families 
and existing headers under include/uapi/linux. Since this is a C/C++
-only artifact and "modern" languages will simply ignore it allowing it
seemed like the right choice.

> >+      -
> >+        name: pad
> >+        type: pad
> >+      -
> >+        name: rx-nvmeotcp-sk-add
> >+        doc: Sockets successfully configured for NVMeTCP offloading.
> >+        type: u64

Everything you have as u64 should now be uint, and pads can then go
away.


