Return-Path: <netdev+bounces-244230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ABCCB2A23
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 11:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EE9304065E
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFEA30AAB3;
	Wed, 10 Dec 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imFsBinl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1BF30AAA6;
	Wed, 10 Dec 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361333; cv=none; b=qRiYr5ZS6UhwiCZazA6IPDNAT2m0/wgEj9jyyzZl+hxk09eybtkfzACEYvd/uGAZ7DiT/J4lQFrkV1bZuDuXg3Vh0CX7lismtFpjtFENZwE1x/5c1a1727VWC0g9uMKeCWmGd0lz6Js0ClUkdE8sWigcDraeTlUsTjUP4AiVu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361333; c=relaxed/simple;
	bh=89IlcdGdzzwXpS4A0/v3Qxrc1x2e4XUX10pWBNc4wN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaCNNil2CFwGj/Z2V4PbaLkuzLRcN5rn4LFO9SDKmZCpbzKd16bVJszUszzuGP7DYPiTDjsQAy57QidOvROeMTzISskfvvsUd0Zhcjm7gBD5aHPou39KjGdyPsazqWDeJOFk4/RCWUFiEPtHLyR1uyIUhgSJQEThpsXN9cEs0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imFsBinl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1934C113D0;
	Wed, 10 Dec 2025 10:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765361333;
	bh=89IlcdGdzzwXpS4A0/v3Qxrc1x2e4XUX10pWBNc4wN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imFsBinl3fGYKIcDgOr9YHOFw+S1maS3kl/25JPKPJMKkOiohoCApbWgyA2H0PZoC
	 2wtyxpb1/68sp4gINHKYfCYQ9gMhsTZ5Ovb372OUJRtiknheRmCH9/Ew0Lmp7i1pec
	 EYmccFjzzLy5Po4/d/BYTnAAV3kSGZ0l+czCvvNpXtVV+Gq0PbOG9j9H21/SXqB+wD
	 dnN0ETHWtLdMTUdPsQ3jbxMPCPv88JOVoqdrXd5cuTnATmWnAZSp9oOeeYW51XmsFe
	 FZ5np051Q6kGpe84gYdw7rg5SP5HWwhUB+DinoviZPo7FvQModGXwVfo2RYC2S38AF
	 Y2uOh+B18JAjg==
Date: Wed, 10 Dec 2025 10:08:48 +0000
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: Chuck Lever <cel@kernel.org>, chuck.lever@oracle.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, brauner@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net] net/handshake: Fix null-ptr-deref in
 handshake_complete()
Message-ID: <aTlGsMozNBaLDpNW@horms.kernel.org>
References: <20251209115852.3827876-1-wangliang74@huawei.com>
 <aThlNuc-kjPqd9kh@horms.kernel.org>
 <5d5a0cf3-e085-4921-b340-b84446526985@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d5a0cf3-e085-4921-b340-b84446526985@huawei.com>

On Wed, Dec 10, 2025 at 10:51:11AM +0800, Wang Liang wrote:

...

> > Hi,
> > 
> > Clang 21.1.7 W=1 builds are rather unhappy about this:
> > 
> >    net/handshake/netlink.c:110:3: error: cannot jump from this goto statement to its label
> >      110 |                 goto out_status;
> >          |                 ^
> >    net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >      114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
> >          |                    ^
> >    net/handshake/netlink.c:104:3: error: cannot jump from this goto statement to its label
> >      104 |                 goto out_status;
> >          |                 ^
> >    net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >      114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
> >          |                    ^
> >    net/handshake/netlink.c:100:3: error: cannot jump from this goto statement to its label
> >      100 |                 goto out_status;
> >          |                 ^
> >    net/handshake/netlink.c:114:13: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >      114 |         FD_PREPARE(fdf, O_CLOEXEC, sock->file);
> >          |                    ^
> > 
> > My undersatnding of the problem is as follows:
> > 
> > FD_PREPARE uses __cleanup to call class_fd_prepare_destructor when
> > resources when fdf goes out of scope.
> > 
> > Prior to this patch this was when the if (req) block was existed.
> > Either via return or a goto due to an error.
> > 
> > Now it is when handshake_nl_accept_doit() itself is exited.
> > Again via a return or a goto due to error.
> > 
> > But, importantly, such a goto can now occur before fdf is initialised.
> > Boom!
> 
> 
> Thanks for your analysis, you are right!
> 
> How about adding a null check before calling handshake_complete()?

I assumed the problem lies around the initialisation of fdf
and class_fd_prepare_destructor being called regardless of that
having occurred. But maybe I miss your point.

In any case, I would advocate an approach that left FD_PREPARE in a scope
where it is always called before the scope is exited.

> 
> Like:
> 
> diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
> index 1d33a4675a48..b989456fc4c5 100644
> --- a/net/handshake/netlink.c
> +++ b/net/handshake/netlink.c
> @@ -126,7 +126,8 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct
> genl_info *info)
>         }
> 
>  out_complete:
> -       handshake_complete(req, -EIO, NULL);
> +       if (req)
> +               handshake_complete(req, -EIO, NULL);
>  out_status:
>         trace_handshake_cmd_accept_err(net, req, NULL, err);
>         return err;
> 
> ------
> Best regards
> Wang Liang
> 

