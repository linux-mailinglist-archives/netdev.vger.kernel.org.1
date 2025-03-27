Return-Path: <netdev+bounces-177980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB1A736BF
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 17:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692681884D28
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FDE19CC11;
	Thu, 27 Mar 2025 16:23:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9702AF1C;
	Thu, 27 Mar 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092616; cv=none; b=OMC3vl8MhOt6Ch6uuL6J+feRN0ydVEmhXUpbBiGe03MJTvhm2jULcy8Z2t1XoH9e2c3AZzris11KW7Lr81OFiZ4ftQtS4KU5dwpVUArTeWC6w6VWqgdkHkDW7uB3rgP+R8J9qWuiWVfGNvMsDvCmemjySlHWnYHTIpHVNjGqyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092616; c=relaxed/simple;
	bh=1hdOmtZ+/j9nYxf8OsNXDo4/n40Gaky7jMOkBxXrKr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT29Up6Q2/wcTQYe85bayqWQRe7XOjoaUx5bWoZO/F2S4j9Es+ZhyLYBUDEqfP1NwU197Q1oE356mP8aStNgWA+dGKH5ToWlAkk4GzxZoRWCWBgI8+zNGQCwsYRvZTyB0CvRy9V8WC9w+uCRs2+4yXzRnmEbzUXgMUOfwFiu70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1txq0r-00085B-93; Thu, 27 Mar 2025 17:23:25 +0100
Date: Thu, 27 Mar 2025 17:23:25 +0100
From: Florian Westphal <fw@strlen.de>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [RFC PATCH] net: sched: em_text: Replace strncpy() with
 strscpy_pad()
Message-ID: <20250327162325.GA30844@breakpoint.cc>
References: <20250327143733.187438-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327143733.187438-1-richard120310@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

I Hsin Cheng <richard120310@gmail.com> wrote:
> The content within "conf.algo" should be a valid NULL-terminated string,
> however "strncpy()" doesn't guarantee that. Use strscpy_pad() to replace
> it to make sure "conf.algo" is NULL-terminated. ( trailing NULL-padding
> if source buffer is shorter. )
>
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  net/sched/em_text.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index 420c66203b17..c78b82931dc4 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -108,7 +108,7 @@ static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
>  	struct text_match *tm = EM_TEXT_PRIV(m);
>  	struct tcf_em_text conf;
>  
> -	strncpy(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);
> +	strscpy_pad(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);

Please drop the 3rd argument and then resend with a fixes tag:
Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")

As is, the last byte remains uninitialised.

