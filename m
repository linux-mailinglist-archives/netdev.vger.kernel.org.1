Return-Path: <netdev+bounces-40645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6337C81D9
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FCA282D36
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C342110A0B;
	Fri, 13 Oct 2023 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA411C95
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:20:33 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DDE95;
	Fri, 13 Oct 2023 02:20:30 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qrEKy-0006XP-FO; Fri, 13 Oct 2023 11:20:04 +0200
Date: Fri, 13 Oct 2023 11:20:04 +0200
From: Florian Westphal <fw@strlen.de>
To: Ma Ke <make_ruc2021@163.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: Fix uninit-value access in tipc_nl_node_get_link()
Message-ID: <20231013092004.GA4980@breakpoint.cc>
References: <20231013070408.1979343-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013070408.1979343-1-make_ruc2021@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ma Ke <make_ruc2021@163.com> wrote:
> Names must be null-terminated strings. If a name which is not 
> null-terminated is passed through netlink, strstr() and similar 
> functions can cause buffer overrun. This patch fixes this issue 
> by returning -EINVAL if a non-null-terminated name is passed.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/tipc/node.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 3105abe97bb9..a02bcd7e07d3 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -2519,6 +2519,9 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
>  		return -EINVAL;
>  
>  	name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
> +	if (name[strnlen(name,
> +			 nla_len(attrs[TIPC_NLA_LINK_NAME]))] != '\0')
> +		return -EINVAL;

If the existing userspace is passing 0-terminated strings it would be
better to fix the policy (tipc_nl_link_policy) instead (and set NLA_NUL_STRING).

And if not, above change breaks userspace.

