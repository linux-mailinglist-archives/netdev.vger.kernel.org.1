Return-Path: <netdev+bounces-235491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D136BC31730
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8CA3B1EE9
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47732C303;
	Tue,  4 Nov 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNIPXkaK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417332BF5D;
	Tue,  4 Nov 2025 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265428; cv=none; b=LjxItrZT+rSa7nm113EUmhhCv9A5WUTjgESgHxz9RU64Kb1XlzgR9HJkmvETc80YW5sAoA6zi0azajlcZPg7pq63eZBRLHz4QCAzb7IZzqHNEb4LU39PySQ11FBYcCp0lrikvHCZrUWXYvAfYysi/q+xa/N+/EyEr7vNnE2a7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265428; c=relaxed/simple;
	bh=lcO5XCNDtt/H8tza8GTcozxkSrtCx94LoT4BSqF7mjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQpzY54iFlUrymaQI0LBq9GiKkwWBjJFBq3C3pE0+IjmQ9ngUCYBfI+vfHY1nEbWoj8gqWqpJrYWcHNu/5P7Ewz8uF42E0ExsAtYWIucWrc0HCC7ULvPkCld4CxCD6KHNBcy4tmb4Wf0HjzPXSBXyygdJ3OFd1WXjV5i6BKSpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNIPXkaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA8EC4CEF7;
	Tue,  4 Nov 2025 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265427;
	bh=lcO5XCNDtt/H8tza8GTcozxkSrtCx94LoT4BSqF7mjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNIPXkaKxKV5gLP9ryrHVhr2vhRBIS+cXDcuND/od28EEEzckOAO/uFAyoA+Rs9An
	 hTZmIi9UiYyfe7LM0JBbGFVjZ6WYb21hzqvepm52OhwV798pt7qs1M9koWcUlZcwZO
	 lX44a8UxPHDkGLymo2o0T4lKop+x+gLqPbr7GjrulrIMlrWoOlU513A5WUcyKC7u8x
	 189hpfaKgmwPar+e+vi05olNLs2cE6DNaAPxYpnj1JUw7XHAI9k1pob+b4CSm+48h1
	 CKPrXUA7O72xisyguHXSbi/wc1p6mnmrPfB8OKI6/MlzRF8v/BP5sRk2ZCT2gchwpf
	 Bmc1jwMvfdB0Q==
Date: Tue, 4 Nov 2025 14:10:22 +0000
From: Simon Horman <horms@kernel.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] net: sched: act_ife: initialize struct tc_ife to
 fix KMSAN kernel-infoleak
Message-ID: <aQoJTvFoS9rZ4-cT@horms.kernel.org>
References: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
 <20251101-infoleak-v2-1-01a501d41c09@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101-infoleak-v2-1-01a501d41c09@gmail.com>

On Sat, Nov 01, 2025 at 06:04:47PM +0530, Ranganath V N wrote:
> Fix a KMSAN kernel-infoleak detected  by the syzbot .
> 
> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> 
> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
> 
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.
> 
> This change silences the KMSAN report and prevents potential information
> leaks from the kernel memory.
> 
> This fix has been tested and validated by syzbot. This patch closes the
> bug reported at the following syzkaller link and ensures no infoleak.
> 
> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
> Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Fixes: ef6980b6becb ("introduce IFE action")
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
>  net/sched/act_ife.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index 107c6d83dc5c..7c6975632fc2 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
>  	unsigned char *b = skb_tail_pointer(skb);
>  	struct tcf_ife_info *ife = to_ife(a);
>  	struct tcf_ife_params *p;
> -	struct tc_ife opt = {
> -		.index = ife->tcf_index,
> -		.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
> -		.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
> -	};
> +	struct tc_ife opt;
>  	struct tcf_t t;
>  
> +	memset(&opt, 0, sizeof(opt));
> +
> +	opt.index = ife->tcf_index,
> +	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
> +	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,

I don't think it makes any difference to the compiled code.
But I think it would be clearer to use ';' rather than ','
at the end of each of the three lines above.

Likewise in patch 2/2.

> +
>  	spin_lock_bh(&ife->tcf_lock);
>  	opt.action = ife->tcf_action;
>  	p = rcu_dereference_protected(ife->params,
> 
> -- 
> 2.43.0
> 

