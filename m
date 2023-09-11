Return-Path: <netdev+bounces-32962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF22C79AC10
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083931C209BA
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2AE8F5D;
	Mon, 11 Sep 2023 22:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015A8C06
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 22:57:37 +0000 (UTC)
Received: from out-215.mta0.migadu.com (out-215.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D6751B40
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:56:00 -0700 (PDT)
Message-ID: <6c275fdc-4468-7573-a33c-35fc442c61c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694470312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WZ2X8irrYsMGdmTvsQZf0PGkIQMT/5DkX5HnLljfQ8=;
	b=ksuZ7e4VDPtO/M0sq4SoEmPgUxuphDQdLi3vp7XB2pwWn78JCtUG/NIfu6+L/J3nD9pVGW
	GBsCTpeSBNFNq5Ew8ZcuJHRDdlNOfC/RatIsxSOwNln3ftALuKg12iJHT8iz7XTC0ZucRT
	HMGllfDSiSYv7jm8WTUQTP7ptsnWL/0=
Date: Mon, 11 Sep 2023 15:11:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: expose information about supported xdp
 metadata kfunc
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
References: <20230908225807.1780455-1-sdf@google.com>
 <20230908225807.1780455-3-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230908225807.1780455-3-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/23 3:58 PM, Stanislav Fomichev wrote:
> @@ -12,15 +13,24 @@ static int
>   netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
>   		   const struct genl_info *info)
>   {
> +	u64 xdp_rx_meta = 0;
>   	void *hdr;
>   
>   	hdr = genlmsg_iput(rsp, info);
>   	if (!hdr)
>   		return -EMSGSIZE;
>   
> +#define XDP_METADATA_KFUNC(_, flag, __, xmo) \
> +	if (netdev->xdp_metadata_ops->xmo) \

A NULL check is needed for netdev->xdp_metadata_ops.

> +		xdp_rx_meta |= flag;
> +XDP_METADATA_KFUNC_xxx
> +#undef XDP_METADATA_KFUNC
> +


