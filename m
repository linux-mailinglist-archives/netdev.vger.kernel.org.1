Return-Path: <netdev+bounces-283254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LPmNtHj9Gl1FgIAu9opvQ
	(envelope-from <netdev+bounces-283254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:33:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A63D4AE8B0
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AC433013A77
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D52313E0D;
	Fri,  1 May 2026 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efxVWf89"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AA25F984
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656777; cv=none; b=hwTwyX59hp+d14aqGD6u6XcC2gFaRGcohukC2Uf9jtm34Wp8Iab+Bb5KCQJ3yPv7NMegMtxtK01W2CGPuKZ8Ptk2K0jUxj4tyeWWr2FRnpa2LV2fubmxT2SXQPcDhRKZpNVV5ozkhPQtfMu70fPa+Q/gfw2GDgWyB8i4nXXQ/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656777; c=relaxed/simple;
	bh=NaBbNXwWIH1VnZaIKy4sMwMBtFjUTNWJd1g7S4np/Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwUNr0e8fzVTe4EXTigReQUEkET71KftFDOzFgUtOs43Uj8QW/fViw8rI+rAVhfZbKvboc29+22FaoPVnUjAkKEdVOJKdMIWlLJ3OpzWD8BH737J9stSLG+O4+74tUADx0oyhkIkk72L/7Hr+Tdo0E2g3Lj7lI+cAFxuFJF1f4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efxVWf89; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79ea87af213so51171897b3.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656774; x=1778261574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AryNV0l+jgUF7izPhm+UoZG1NwQ31VUz12XuoxZ/bAc=;
        b=efxVWf89qiF/V/OzGoKXB8Uevv7jlCkk4CbS2SAJ5HU/JhmNsDwmue6U7l9s1KVxVA
         PHYAsbfhDEty5RRsDr8mgCdgJRzYXy6WjxW0pACtsi9aIAcsSk8p6VHsmSNZCWOZxDt/
         uVzPB9Z0/IX+mFx52HIsIUVelkJJc+5YOW+ZTMLoHL37Hta/sz2qXq/Hz9Oog/alu2C7
         3FTnQCaB5DLc19uOmBXs9b9LwUvtmwNUOuMLGW1RG2P/RpwBKUPwQFfpANCmPDCPsEta
         RACS6MiRRb0KMR+6Bs2UmN23KCWS8YLuyHnqQ49qOEbgItkrtac9ceB0xoX11BMlBwUG
         X3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656774; x=1778261574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AryNV0l+jgUF7izPhm+UoZG1NwQ31VUz12XuoxZ/bAc=;
        b=QQpgtdip10cGnOPlunpCsDNHUp6F159sOkW/yWhXelCJsRD8k2XHviaqaDQtsdC4W/
         0ImZmGuvW+aRUzi1ankjFSr9Bcw8D1vlotjCD+TPwA5HKRVdP8s/02/TQ5f4ZA71uGYH
         vkDvVFzqHTT/kxiQ7epNdG8ZmPYcE8AQwAJIBkpIlqvi8p0D/LVdHrIjngmD634db1uO
         qXW9X21qD9/R4tFGX0SMLqyXMgTy7nXwZMWC8EMq9pJGlElKi/tkj8KQ4VVS8NakNnNv
         5xwg7kHf6Gtd7kXsp9RkwkFIjx4E+EYUN5/CHugHQTZActVsyXJBeg8crrkdHoIvS90S
         T9rQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qMTTx9YRMd4OhSaOQ+HXh69kfNUSlKGLrb19+WztJFZNGXy6A/mYxma5XCNFMvn4ZUVVxJ+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xG48kiaRKmagAbQ6TRURMbfz4PCIo8tqAIwS3yVrQWW2gb2O
	HP21Xh2+4F5gcix3n49WZ/zxtOmFaKK40x5/N8x/cXtWmwRVJampKmhE
X-Gm-Gg: AeBDieudnHp2onUrglJqp7xXo0gAxXq94fDoHgirmVzaR22q/pZRBDk5Tss9ALjH9lA
	DqEV3bq5zrMAcnam3OuWqUCYWiHiIXa8YfuH8cl2XMZOq8uOIhX740T0NjP9jD7zDf01SykXUXr
	WaD9MetJhodewYHmt/JPtZ59u35DersId10/grBbU4ZaIgA4yf1VFR9/s4hTi6QHdx8m5IGoY1B
	CfcYQCSo4TS5Z3mzTzzWSydNfaALVtmc1uZ/q+22ueCf8SlSZ/oyTfGTyQq/HziRKn5xP7Y70vF
	m5Y/2189ifXRBwphuD5zEaux9PkW/1WCx2M+YQyOSOoIwIpKDSZ3hdlpfbDUEpN18OFoev5p4a2
	MrTW0JRvySUCs/224/xFGWjQEAcb0947aJwBHdg0PWqd4BdRRSC63hQw6fotztQ1Ij11FY0n/9P
	6gDr6oYDJ7AO00Cygo6u6Nlf3llAOS0KBNK4D4RP3hfxmmCzLvclCXPfw=
X-Received: by 2002:a05:690c:1d:b0:7b4:6f40:654 with SMTP id 00721157ae682-7bd768772a4mr4403587b3.4.1777656774212;
        Fri, 01 May 2026 10:32:54 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665694b8sm13710007b3.21.2026.05.01.10.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:32:53 -0700 (PDT)
Date: Fri, 1 May 2026 10:32:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf.kernel@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/3] vsock: convert to getsockopt_iter
Message-ID: <afTjvM1P4gjPSvW8@devvm29614.prn0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
 <20260501-getsock_one-v1-2-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-getsock_one-v1-2-810ce23ea70e@debian.org>
X-Rspamd-Queue-Id: 9A63D4AE8B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283254-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,devvm29614.prn0.facebook.com:mid]

On Fri, May 01, 2026 at 08:52:52AM -0700, Breno Leitao wrote:
> Convert AF_VSOCK's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t. The single
> vsock_connectible_getsockopt() callback is shared by both
> vsock_stream_ops and vsock_seqpacket_ops, so both proto_ops are
> updated to use .getsockopt_iter.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/vmw_vsock/af_vsock.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 44037b066a5ff..d4a97eeb596e6 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -155,6 +155,7 @@
>  #include <linux/random.h>
>  #include <linux/skbuff.h>
>  #include <linux/smp.h>
> +#include <linux/uio.h>
>  #include <linux/socket.h>
>  #include <linux/stddef.h>
>  #include <linux/sysctl.h>
> @@ -2091,8 +2092,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>  
>  static int vsock_connectible_getsockopt(struct socket *sock,
>  					int level, int optname,
> -					char __user *optval,
> -					int __user *optlen)
> +					sockopt_t *opt)
>  {
>  	struct sock *sk = sock->sk;
>  	struct vsock_sock *vsk = vsock_sk(sk);
> @@ -2110,8 +2110,7 @@ static int vsock_connectible_getsockopt(struct socket *sock,
>  	if (level != AF_VSOCK)
>  		return -ENOPROTOOPT;
>  
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> +	len = opt->optlen;
>  
>  	memset(&v, 0, sizeof(v));
>  
> @@ -2142,11 +2141,10 @@ static int vsock_connectible_getsockopt(struct socket *sock,
>  		return -EINVAL;
>  	if (len > lv)
>  		len = lv;
> -	if (copy_to_user(optval, &v, len))
> +	if (copy_to_iter(&v, len, &opt->iter_out) != len)
>  		return -EFAULT;
>  
> -	if (put_user(len, optlen))
> -		return -EFAULT;
> +	opt->optlen = len;
>  
>  	return 0;
>  }
> @@ -2631,7 +2629,7 @@ static const struct proto_ops vsock_stream_ops = {
>  	.listen = vsock_listen,
>  	.shutdown = vsock_shutdown,
>  	.setsockopt = vsock_connectible_setsockopt,
> -	.getsockopt = vsock_connectible_getsockopt,
> +	.getsockopt_iter = vsock_connectible_getsockopt,
>  	.sendmsg = vsock_connectible_sendmsg,
>  	.recvmsg = vsock_connectible_recvmsg,
>  	.mmap = sock_no_mmap,
> @@ -2653,7 +2651,7 @@ static const struct proto_ops vsock_seqpacket_ops = {
>  	.listen = vsock_listen,
>  	.shutdown = vsock_shutdown,
>  	.setsockopt = vsock_connectible_setsockopt,
> -	.getsockopt = vsock_connectible_getsockopt,
> +	.getsockopt_iter = vsock_connectible_getsockopt,
>  	.sendmsg = vsock_connectible_sendmsg,
>  	.recvmsg = vsock_connectible_recvmsg,
>  	.mmap = sock_no_mmap,
> 
> -- 
> 2.52.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

