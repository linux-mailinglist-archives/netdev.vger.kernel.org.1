Return-Path: <netdev+bounces-40668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFC7C8427
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31CEDB209A2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407F134D8;
	Fri, 13 Oct 2023 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JKJgQBxF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8DA125A0
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:13:08 +0000 (UTC)
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E81EBD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 04:13:07 -0700 (PDT)
Message-ID: <b6fbabb3-f270-4762-8b31-399d48de1456@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697195585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeDV7uvq+wU99a5k0tITH4O1+68ZHdKMz7Zl4hCUc0I=;
	b=JKJgQBxFdSSQ2zrX99jZyGeEFf3nDa1+Cm+EoBQM6pSIoy7c2BKOLh9ypwDnbwBBFX9XdX
	DwhP+WWg1ZNY9cW74OAn9AJKXFOyrq6jEn+8g/al8lWhss4PXEWkAqEa8gS/7mwZocvdv2
	zNojf9C4CAFsWhX2Teut0kHNbm5ncgk=
Date: Fri, 13 Oct 2023 12:13:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 0/5] dpll: add phase-offset and phase-adjust
Content-Language: en-US
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org
Cc: jiri@resnulli.us, corbet@lwn.net, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/10/2023 11:12, Arkadiusz Kubalewski wrote:
> Improve monitoring and control over dpll devices.
> Allow user to receive measurement of phase difference between signals
> on pin and dpll (phase-offset).
> Allow user to receive and control adjustable value of pin's signal
> phase (phase-adjust).
> 
> v4->v5:
> - rebase series on top of net-next/main, fix conflict - remove redundant
>    attribute type definition in subset definition
> 
> v3->v4:
> - do not increase do version of uAPI header as it is not needed (v3 did
>    not have this change)
> - fix spelling around commit messages, argument descriptions and docs
> - add missing extack errors on failure set callbacks for pin phase
>    adjust and frequency
> - remove ice check if value is already set, now redundant as checked in
>    the dpll subsystem
> 
> v2->v3:
> - do not increase do version of uAPI header as it is not needed
> 
> v1->v2:
> - improve handling for error case of requesting the phase adjust set
> - align handling for error case of frequency set request with the
> approach introduced for phase adjust
> 
> 
> Arkadiusz Kubalewski (5):
>    dpll: docs: add support for pin signal phase offset/adjust
>    dpll: spec: add support for pin-dpll signal phase offset/adjust
>    dpll: netlink/core: add support for pin-dpll signal phase
>      offset/adjust
>    ice: dpll: implement phase related callbacks
>    dpll: netlink/core: change pin frequency set behavior
> 
>   Documentation/driver-api/dpll.rst         |  53 +++++-
>   Documentation/netlink/specs/dpll.yaml     |  30 +++
>   drivers/dpll/dpll_netlink.c               | 188 +++++++++++++++++-
>   drivers/dpll/dpll_nl.c                    |   8 +-
>   drivers/dpll/dpll_nl.h                    |   2 +-
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 220 +++++++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_dpll.h |  10 +-
>   include/linux/dpll.h                      |  18 ++
>   include/uapi/linux/dpll.h                 |   6 +
>   9 files changed, 517 insertions(+), 18 deletions(-)
> 
For the series:
Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Thanks!


