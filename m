Return-Path: <netdev+bounces-22835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659967697E8
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAE41C20C06
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD518AE5;
	Mon, 31 Jul 2023 13:45:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914514429
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 13:45:54 +0000 (UTC)
Received: from out-112.mta1.migadu.com (out-112.mta1.migadu.com [95.215.58.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CC21708
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 06:45:52 -0700 (PDT)
Message-ID: <337b535c-e2a3-bd65-d1c5-fd7199432891@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690811149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLKb003HBI5xzLCoz1yU7MsFEkEiCvyVgDi7hTTof4c=;
	b=WXBxmoFogi4S8Yp707opUTnSN81JhKHLHVCKYlQWrFDVCwSVryXdHrXf9AgrAo/OOgr+LM
	2T/NKplQowTlRQGULTwQx9ELezPVE142NdknNXSIvmAU1Xk4ngM3p4FPtSa3toreTlFMiW
	/crMI/HrTHzeOi95+LpZPtdczVZOeYI=
Date: Mon, 31 Jul 2023 14:45:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: lan743x: skip timestamping for non-PTP
 packets
Content-Language: en-US
To: Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com
References: <20230731125418.75140-1-vishvambarpanth.s@microchip.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230731125418.75140-1-vishvambarpanth.s@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 31/07/2023 13:54, Vishvambar Panth S wrote:
> Currently all the RX packets are timestamped and the timestamp is appended
> to the RX packet for processing, this reduces RX throughput. This can be
> optimized by timestamping packets only when the PTP messages are received.
> The RX PTP Configuration register [PTP_RX_TS_CFG] specifies what are the
> PTP message types to be timestamped. The PTP_RX_TS_CFG_MSG_EN_ configures
> Sync, Delay_Req, Pdelay_Req, Pdelay_Resp Message types to be timestamped.
> The RX_CFG_B_TS_ALL_RX_ bit enables storing the timestamp for all RX
> frames, now this is cleared as only PTP packets will be timestamped. The
> RX_CFG_B_TS_DESCR_EN_ enables storing the timestamp in an extension
> descriptor. When PTP messages are received the timestamp will be stored
> in an extension descriptor of the RX packet.

Even though the performance benefit is clear, the PTP subsystem provides
options to select whether PTP filters must be applied or all packets
must be stamped. I think it's better to implement both options as the
hardware supports them, there are use cases where timestamps are needed
for all packets. Linuxptp can be easily configured for both variants,
the hardware/driver documentation can state that there will be
performance degradation for all RX packets timestamps mode.


