Return-Path: <netdev+bounces-24662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81796770F75
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 13:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388311C209D2
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D617A95B;
	Sat,  5 Aug 2023 11:33:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C75238
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 11:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BAEC433C8;
	Sat,  5 Aug 2023 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691235229;
	bh=BzmzOuQh1iU+dc3h9XOJmPxsH1ETWoPd8fdiuvtrdjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDAfg8gKkeWIOvV2LJQ5QdoOi9YmuwJ0LmWJcG1r3ZSJMPh6U2ZBJKgab1T8T683f
	 I8knNLLFXVpR22H4eAYp269A4BA8ISGygWIue1JwHzx5QV/KmWP8t/RhiqjAvy7feZ
	 IJ3r1gp1y8TTmxd/bP32Gfm2dzHGyQxV/51V6JhZeDv2D2BuJSz1THjXYXfI/cTilz
	 ijIFgW84drX1xNaQUWgpimMCeMJYVTKOFCJX35d+BKCUL7rkrN+HKN9lWH+33z7KVg
	 G4GOiOVeCXxQYtOg5DcmunWdiyW0BmwWkiUWxYKRWyzeapXxNrIEVZmpkdxVmJOILO
	 ma1XUzvcjvK+g==
Date: Sat, 5 Aug 2023 13:33:44 +0200
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	richardcochran@gmail.com,
	Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Message-ID: <ZM4zmG55sEr9b62l@vergenet.net>
References: <20230804093014.2729634-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804093014.2729634-1-saikrishnag@marvell.com>

On Fri, Aug 04, 2023 at 03:00:14PM +0530, Sai Krishna wrote:
> Some of the newer silicon versions in CN10K series supports a feature
> where in the current PTP timestamp in HW can be updated atomically
> without losing any cpu cycles unlike read/modify/write register.
> This patch uses this feature so that PTP accuracy can be improved
> while adjusting the master offset in HW. There is no need for SW
> timecounter when using this feature. So removed references to SW
> timecounter wherever appropriate.
> 
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>

...

>  struct npc_get_field_status_req {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c

...

>  
> -static bool is_ptp_tsfmt_sec_nsec(struct ptp *ptp)
> +static inline bool is_tstmp_atomic_update_supported(struct rvu *rvu)

Hi Sai,

Please avoid using the inline keyword for functions in .c files.
Unless there is a demonstrable advantage to doing so it should
be left up to the compiler to inline or not.

...

-- 
pw-bot: changes-requested

