Return-Path: <netdev+bounces-40633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241C77C810A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 10:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550B41C20A68
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0282710946;
	Fri, 13 Oct 2023 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W8cVnmBB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D72107A1
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:56:58 +0000 (UTC)
Received: from out-195.mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605D7CA
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 01:56:55 -0700 (PDT)
Message-ID: <2c7a813d-bbbf-4061-b8ad-efa4e7f03d26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697187413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=buruCN/2QVN4PwlAqjp2tz9lsRhDJNGAaY3eMM7JqzM=;
	b=W8cVnmBBDGjI6CVsC+xWcY1+6N0JsdIdCNY3rRqkPSgEjEv+GxL7OYzlYA0FijIfFDfB3S
	bRi78p5Bxd3HkwOOaHMKbYWwFJIE10E9yrqZUXyp+WV69+IarSKzirMzMdAhnR6akVPtWo
	g85UjIl4PNxxn6zrq/pFm0ZtegCybtE=
Date: Fri, 13 Oct 2023 09:56:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tipc: Fix uninit-value access in tipc_nl_node_get_link()
Content-Language: en-US
To: Ma Ke <make_ruc2021@163.com>, jmaloy@redhat.com, ying.xue@windriver.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20231013070408.1979343-1-make_ruc2021@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231013070408.1979343-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/10/2023 08:04, Ma Ke wrote:
> Names must be null-terminated strings. If a name which is not
> null-terminated is passed through netlink, strstr() and similar
> functions can cause buffer overrun. This patch fixes this issue
> by returning -EINVAL if a non-null-terminated name is passed.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   net/tipc/node.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 3105abe97bb9..a02bcd7e07d3 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -2519,6 +2519,9 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
>   		return -EINVAL;
>   
>   	name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
> +	if (name[strnlen(name,
> +			 nla_len(attrs[TIPC_NLA_LINK_NAME]))] != '\0')
> +		return -EINVAL;

The better choice would be to use strncmp() with limit of
TIPC_MAX_LINK_NAME in tipc_node_find_by_name().
This patch fixes tipc_nl_node_get_link(), but the same pattern is used
in tipc_nl_node_set_link() and tipc_nl_node_reset_link_stats(), these
functions also need improvements. Changes to strncmp() and strnstr()
will fix all spots.

>   
>   	msg.skb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>   	if (!msg.skb)


