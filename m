Return-Path: <netdev+bounces-48894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2707EFF60
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 13:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23679B209CF
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA0D379;
	Sat, 18 Nov 2023 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCA0194;
	Sat, 18 Nov 2023 04:02:49 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1r4K1z-0002nv-2p; Sat, 18 Nov 2023 13:02:35 +0100
Date: Sat, 18 Nov 2023 13:02:35 +0100
From: Florian Westphal <fw@strlen.de>
To: Kamil Duljas <kamil.duljas@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genetlink: Prevent memory leak when krealloc fail
Message-ID: <20231118120235.GA30289@breakpoint.cc>
References: <20231118113357.1999-1-kamil.duljas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118113357.1999-1-kamil.duljas@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kamil Duljas <kamil.duljas@gmail.com> wrote:
> genl_allocate_reserve_groups() allocs new memory in while loop
> but if krealloc fail, the memory allocated by kzalloc is not freed.
> It seems allocated memory is unnecessary when the function
> returns -ENOMEM

Why should it be free'd?  mc_groups is not a local variable.

>  				new_groups = krealloc(mc_groups, nlen,
>  						      GFP_KERNEL);
> -				if (!new_groups)
> +				if (!new_groups) {
> +					kfree(mc_groups);
>  					return -ENOMEM;
> +				}

How did you test this?  AFAICS this results in use-after-free for every
access to mc_groups after this error path is taken.

Existing code looks correct, we can't grow mc_groups and return an
error.

