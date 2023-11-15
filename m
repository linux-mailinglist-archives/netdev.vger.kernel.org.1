Return-Path: <netdev+bounces-47885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DA27EBBE8
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6956B20AC8
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 03:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2558647;
	Wed, 15 Nov 2023 03:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5164C
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:32:55 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC31C3
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 19:32:53 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1r36e0-0004DB-Jt; Wed, 15 Nov 2023 04:32:48 +0100
Date: Wed, 15 Nov 2023 04:32:48 +0100
From: Florian Westphal <fw@strlen.de>
To: heminhong <heminhong@kylinos.cn>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] iproute2: prevent memory leak
Message-ID: <20231115033248.GC21242@breakpoint.cc>
References: <20231114163617.25a7990f@hermes.local>
 <20231115023703.15417-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115023703.15417-1-heminhong@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

heminhong <heminhong@kylinos.cn> wrote:
> When the return value of rtnl_talk() is less than 0, 'answer' does not
> need to release. When the return value of rtnl_talk() is greater than
> or equal to 0, 'answer' will be allocated, if subsequent processing fails,
> the memory should be free, otherwise it will cause memory leak.

I don't understand this patch.  Care to elaborate where a memory leak is?

rtnl_talk -> __rtnl_talk -> __rtnl_talk_iov

 998 static int __rtnl_talk_iov(struct rtnl_handle *rtnl, struct iovec *iov,
 999                            size_t iovlen, struct nlmsghdr **answer,
1000                            bool show_rtnl_err, nl_ext_ack_fn_t errfn)
[..]
1102                                 if (answer)
1103                                         *answer = (struct nlmsghdr *)buf;
1104                                 else
1105                                         free(buf);
1106                                 return 0;
1107                         }
1108
1109                         if (answer) {
1110                                 *answer = (struct nlmsghdr *)buf;
1111                                 return 0;
1112                         }

I see no other spots where 'answer' is set, i.e. assignment ONLY on
'return 0'.

> Signed-off-by: heminhong <heminhong@kylinos.cn>
> ---
>  ip/link_gre.c    | 2 ++
>  ip/link_gre6.c   | 2 ++
>  ip/link_ip6tnl.c | 2 ++
>  ip/link_iptnl.c  | 2 ++
>  ip/link_vti.c    | 2 ++
>  ip/link_vti6.c   | 2 ++
>  6 files changed, 12 insertions(+)
> 
> diff --git a/ip/link_gre.c b/ip/link_gre.c
> index 74a5b5e9..b86ec22d 100644
> --- a/ip/link_gre.c
> +++ b/ip/link_gre.c
> @@ -111,6 +111,8 @@ static int gre_parse_opt(struct link_util *lu, int argc, char **argv,
>  
>  		if (rtnl_talk(&rth, &req.n, &answer) < 0) {
>  get_failed:
> +			if (answer)
> +				free(answer);

This if() is not needed.  free(NULL) is fine.  But in this case,
'answer' can contain stack-garbage, as this variable isn't initialised
to NULL.

Moreover, the placement would need to be ABOVE the label, not below.

But, see above, I don't see a 'answer' related memleak.

