Return-Path: <netdev+bounces-34362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B047A36BF
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 19:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAEA1C21108
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586153B2;
	Sun, 17 Sep 2023 17:10:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC312636
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 17:10:18 +0000 (UTC)
Received: from out-217.mta0.migadu.com (out-217.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0E212A
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 10:10:17 -0700 (PDT)
Message-ID: <56d32e37-afdd-342c-947d-dec329a504e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694970615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztGRx8TAjObGCY57dL3v14XYGZDpjuw7KaSc9afpYsc=;
	b=os/WVwg1UGVZSwP61FcUPmfoybgJOI1LcXdl5DxToxIp8KBxlug/0bYVIoZ0LJl0RXPSXn
	lWaO5Nr4xIKgDbkS/Znvyn1T9FRDpOdyzdSdgi3erLghLo5L5uiPVd6/xV60Xb8lP8R1rF
	+WlCg1lktFA1cOAwEGjNVTaTe4jeGnY=
Date: Sun, 17 Sep 2023 18:10:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast
 path variables
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <20230916010625.2771731-4-lixiaoyan@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230916010625.2771731-4-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 16/09/2023 02:06, Coco Li wrote:
> Reorganize fast path variables on tx-txrx-rx order.
> Fastpath cacheline ends after sysctl_tcp_rmem.
> There are only read-only variables here. (write is on the control path
> and not considered in this case)

I believe udp sysctls can be aligned the same way. With HTTP/3 adoption
we should think about UDP traffic too, and looks like we do have some 
space in hot-path cache lines for udp_early_demux and rmem/wmem.

And have you thought about cache-line boundary alignment for these values?


