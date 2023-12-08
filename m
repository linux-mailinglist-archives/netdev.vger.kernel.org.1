Return-Path: <netdev+bounces-55265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5F80A05E
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1271F216FE
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A514266;
	Fri,  8 Dec 2023 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq160TpB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743BB5690
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A559C433C7;
	Fri,  8 Dec 2023 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702030408;
	bh=F6GNCTCVohGAtbU7Si/ZkqQJNubkeh58SKBUnOJm5d0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cq160TpBz8HivpIZ/YCJim/juDBCDg1pUsX5jN4BCvy9UG0f5X+x3biZI3d0PAvLB
	 4s8YiPeUSoUyR0jxV5JwQF7sWZGMW7SuhzQ2BRxTy68rCdsyVDNK0mv6k2Z8NVUSU1
	 24Q60HM96rmtKDnG1mTDqmBAKLxt5LCfvqnF+cLFYO22DB3VNpjF8+EZYOKHOegsug
	 iofDzJvCpXoFvC/z9sCgY34gFu7jB/iT/qbhnubt5I14ZDkStVI2EbHZxg6IOFO4ZP
	 D/3U8PttcuavXGy0O6QNdIlyhfRiOX+QKB92t8qxdOjm8TcSgJ3WuQzD+j//aVIxRM
	 al4528TjmvxYg==
Message-ID: <8caf8252-4068-4d17-b919-12adfef074e5@kernel.org>
Date: Fri, 8 Dec 2023 12:13:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
 netdev@vger.kernel.org
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <20231204123531.tpjbt7byzdnrhs7f@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231204123531.tpjbt7byzdnrhs7f@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/12/2023 14:35, Vladimir Oltean wrote:
> On Fri, Dec 01, 2023 at 03:58:00PM +0200, Roger Quadros wrote:
>> Add driver support for viewing / changing the MAC Merge sublayer
>> parameters and seeing the verification state machine's current state
>> via ethtool.
>>
>> As hardware does not support interrupt notification for verification
>> events we resort to polling on link up. On link up we try a couple of
>> times for verification success and if unsuccessful then give up.
>>
>> The Frame Preemption feature is described in the Technical Reference
>> Manual [1] in section:
>> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
>>
>> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
>>
>> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
>> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
> 
> Actually...
> 
> ld.lld: error: undefined symbol: am65_cpsw_iet_common_enable
>>>> referenced by am65-cpsw-ethtool.c:755 (drivers/net/ethernet/ti/am65-cpsw-ethtool.c:755)
>>>>               drivers/net/ethernet/ti/am65-cpsw-ethtool.o:(am65_cpsw_set_mm) in archive vmlinux.a
> 
> ld.lld: error: undefined symbol: am65_cpsw_iet_commit_preemptible_tcs
>>>> referenced by am65-cpsw-ethtool.c:876 (drivers/net/ethernet/ti/am65-cpsw-ethtool.c:876)
>>>>               drivers/net/ethernet/ti/am65-cpsw-ethtool.o:(am65_cpsw_set_mm) in archive vmlinux.a
> 
> cat $KBUILD_OUTPUT/.config | grep AM65
> CONFIG_TI_K3_AM65_CPSW_NUSS=y
> # CONFIG_TI_K3_AM65_CPSW_SWITCHDEV is not set
> # CONFIG_TI_K3_AM65_CPTS is not set
> CONFIG_MMC_SDHCI_AM654=y
> CONFIG_PHY_AM654_SERDES=m
> 
> am65-cpsw-qos.c is built only if CONFIG_TI_AM65_CPSW_TAS is enabled, yet am65-cpsw-ethtool.c,
> built by CONFIG_TI_K3_AM65_CPSW_NUSS, depends on it.

Wondering how to fix this the right way. Should set/get_mm fail if CONFIG_TI_AM65_CPSW_TAS is not enabled?

-- 
cheers,
-roger

