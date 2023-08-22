Return-Path: <netdev+bounces-29645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959CF7843AE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB611C20BB2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576A51CA1D;
	Tue, 22 Aug 2023 14:14:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B37F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818A1C433C8;
	Tue, 22 Aug 2023 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692713656;
	bh=XLMbyZiAi2a8XduRfZNv/BkLXARuwCKpmtxflJY0vvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZU9URRMINVmxB+B/qt8yzrDq+9aDlH8XBofAUON6/ibcZCCULSFNZP7kVhP5iwIk
	 qo45VC9IQjVwehDGDWRd+xbF1lHSd9Ft1IWlTxT+sBk48shOHnp7Hco0tHatQug1Mw
	 gX+DGEssFUKBR4Cqnza67JxMHbiutAdn/cGeX1/6E9L3IhtoVWkPY7/XJ3nmaXCIbt
	 6P2fhJjeLPeq8/L59BrXOY2gwFdsdoMYXTXFv7EHZ4LAMdf5cbeGZOpHKyt6K8bSyB
	 w+VcYYXBo6D9eX8SDgM90Sr44ki4KvZJlSB/CXsaMquHZ2tJGieozD6BoE3QSQEQzZ
	 YGeR3Wouptxmg==
Date: Tue, 22 Aug 2023 17:14:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	richardcochran@gmail.com, kalesh-anakkur.purayil@broadcom.com,
	Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v4] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Message-ID: <20230822141412.GI6029@unreal>
References: <20230821103629.3799884-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821103629.3799884-1-saikrishnag@marvell.com>

On Mon, Aug 21, 2023 at 04:06:29PM +0530, Sai Krishna wrote:
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
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
> v4:
>     - Addressed review comments given by Leon Romanovsky
>         1. Unlocked mutex in error conditions.
> v3:
>     - Addressed review comments given by Jakub Kicinski
>         1. Fixed re-ordering of headers in alphabetical order
>         2. Refactored SoC revision identification logic
>         3. CN10K errata revisions can be different from atomic update
>            supported revision devices.
>         4. Removed ptp device check.
> v2:
>     - Addressed review comments given by Simon Horman, Kalesh Anakkur Purayil
> 	1. Removed inline keyword for function in .c file
>         2. Modified/optimized conditions related boolean
> 
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  12 ++
>  .../net/ethernet/marvell/octeontx2/af/ptp.c   | 155 +++++++++++++--
>  .../net/ethernet/marvell/octeontx2/af/ptp.h   |   3 +-
>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |   2 +-
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  12 ++
>  .../marvell/octeontx2/nic/otx2_common.h       |   1 +
>  .../ethernet/marvell/octeontx2/nic/otx2_ptp.c | 177 ++++++++++++++----
>  7 files changed, 307 insertions(+), 55 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

