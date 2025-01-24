Return-Path: <netdev+bounces-160822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB4A1B9DC
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D423ABE02
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB515C120;
	Fri, 24 Jan 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHPu2we1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F3182D2;
	Fri, 24 Jan 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734532; cv=none; b=FLg0b4+MkG1Usk7SzsYTXFvYnro3Dq21M69hC6X8n3wO46ic5GSPBM2yzbuq84Bj2Vr5rwN8uS50tJ0akq7BDSMFF5xLhBkYl+pqulf8IRqw/nmLGLHj9iLK481U/Pm86MYXeFWS5TsmdpuOwH0Kvxl7esMup4+X0SJ/zfAM1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734532; c=relaxed/simple;
	bh=mc7C+xWF1Inf26mfK2Z5ENKooEXC/JlUijWAy2yAlBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7CF5YNqqh/fMk+WMbxlE1sCH8EvzWQ2+Zu5LFCBJNv6WKoTNNYWVMjQ4jaIG40ep9xtYFpFkhwxyXWX0MexZ/k9D48DTBHqdLax/LFxa+DNb6PQwIpDl20upfau8/pnqT8TEhNWrjQ1DE8jG6ncpKN/t8YRvzJ7UTtgGMHZYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHPu2we1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CBCC4CEDD;
	Fri, 24 Jan 2025 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737734532;
	bh=mc7C+xWF1Inf26mfK2Z5ENKooEXC/JlUijWAy2yAlBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qHPu2we1GYDq4abcoJt1sMXdp89JBCs25XvXrHdH7aa5B2kAYK2CB4KLyMGSEsShC
	 dJaC6Z1nwJXA0NhC0e2AJ/iFevLwB++k5AzbdzRiK+P55iqSWrY/vmuCbgh/v9VIeM
	 71CsuGFP8U6xynMeKGmltiGKhcT1SBz0g7NTq4XJU96nTfDJGApxTxMG4oisClQ7tu
	 s8I6i5kOsxFCCa7wqEBTAlpQ+wnh7nqH1JrHjQRI1xn/yLLwARfzKPPPwNlEsXibcO
	 77fiJvoOFsG4RbPquL1/ANSGfzzbDDYdy4dprS+XFhFqEO1AzmD7jR8/ue+XOgVgc/
	 HFaCcsYaEoEYg==
Date: Fri, 24 Jan 2025 08:02:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas Graf <tgraf@suug.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: netlink: prevent potential integer overflow in
 nlmsg_new()
Message-ID: <20250124080210.23208829@kernel.org>
In-Reply-To: <04dbe1d5-51e8-42d5-a77d-59db4bc13957@stanley.mountain>
References: <58023f9e-555e-48db-9822-283c2c1f6d0e@stanley.mountain>
	<20250122062427.2776d926@kernel.org>
	<04dbe1d5-51e8-42d5-a77d-59db4bc13957@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 17:35:24 +0300 Dan Carpenter wrote:
> On Wed, Jan 22, 2025 at 06:24:27AM -0800, Jakub Kicinski wrote:
> > On Wed, 22 Jan 2025 16:49:17 +0300 Dan Carpenter wrote:  
> > > The "payload" variable is type size_t, however the nlmsg_total_size()
> > > function will a few bytes to it and then truncate the result to type
> > > int.  That means that if "payload" is more than UINT_MAX the alloc_skb()
> > > function might allocate a buffer which is smaller than intended.  
> > 
> > Is there a bug, or is this theoretical?  
> 
> The rule here is that if we pass something very close to UINT_MAX to
> nlmsg_new() the it leads to an integer overflow.  I'm not a networking
> expert.  The caller that concerned me was:
> 
> *** 1 ***
> 
> net/netfilter/ipset/ip_set_core.c
>   1762                  /* Error in restore/batch mode: send back lineno */
>   1763                  struct nlmsghdr *rep, *nlh = nlmsg_hdr(skb);
>   1764                  struct sk_buff *skb2;
>   1765                  struct nlmsgerr *errmsg;
>   1766                  size_t payload = min(SIZE_MAX,
>   1767                                       sizeof(*errmsg) + nlmsg_len(nlh));
> 
> I don't know the limits of limits of nlmsg_len() here.

Practically speaking the limits are fairly small. The nlh comes from
user's request / sendmsg() call. So the user must have prepared 
a message of at least that len, and kernel must had been able to
kvmalloc() a linear buffer large enough to copy that message in.

> The min(SIZE_MAX is what scared me.  That was added to silence a Smatch
> warning.  :P  It should be fixed or removed.

Yeah, that ip_set code looks buggy. Mostly because we use @payload
for the nlmsg_put() call, but then raw nlh->nlmsg_len for memcpy() :S

>   1768                  int min_len = nlmsg_total_size(sizeof(struct nfgenmsg));
>   1769                  struct nlattr *cda[IPSET_ATTR_CMD_MAX + 1];
>   1770                  struct nlattr *cmdattr;
>   1771                  u32 *errline;
>   1772  
>   1773                  skb2 = nlmsg_new(payload, GFP_KERNEL);
>   1774                  if (!skb2)
>   1775                          return -ENOMEM;
> 
> *** 2 ***
> There is similar code in netlink_ack() where the payload comes from
> nlmsg_len(nlh).

This one is correct. Each piece of the message is nlmsg_put()
individually, which does bounds checking. So if the allocation 
of the skb was faulty and the skb is shorter than we expected 
we'll just error out on the put.

> *** 3 ***
> 
> There is a potential issue in queue_userspace_packet() when we call:
> 
> 	len = upcall_msg_size(upcall_info, hlen - cutlen, ...
>                                            ^^^^^^^^^^^^^
> 	user_skb = genlmsg_new(len, GFP_ATOMIC);
> 
> It's possible that hlen is less than cutlen.  (That's a separate bug,
> I'll send a fix for it).

Ack.

In general IMVHO the check in nlmsg_new() won't be too effective.
The callers can overflow their local message size calculation.
Not to mention that the size calculation is often inexact.
So using nla_put() and checking error codes is the best way
to prevent security issues..

