Return-Path: <netdev+bounces-99906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BCF8D6F5E
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 12:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798D71F21C82
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 10:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A785914D711;
	Sat,  1 Jun 2024 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfNAJ7+V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F227473
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717238225; cv=none; b=IIR387VMWYAc4/rGq7EaAlfM62FdXCIYQu77iOgOQ3G96R57nTyb36TbfXAiGTgrs6n7OINeiVoxBPwlDcRclWrwoAiROZnwz0jnnd8McJDqCP81ugOi4G6SJcYwgEkX8pa+L2XG5uXznRun9RSvh4fvgqIH5gBCGv1DeULpajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717238225; c=relaxed/simple;
	bh=nMmQUZvfNwbrHJKiwXc49r6mbQM5EdcKTwYZj3x3q/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4WbGkM1PmZ0NgWkBehyPm13FEY6wwCTkU4Rf8DitYqmWgmN7euyFAwqsKXjXFTwlSURJ3xUqN8QHDNsNXzrclDpunMB1WT5G2SB9r1AdTI9klO+MdinU5ualwr/8wr/8qqN4emSJjJfN2sGGnQcUvQCT4isGlgAByxslWPpn58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfNAJ7+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C23C116B1;
	Sat,  1 Jun 2024 10:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717238225;
	bh=nMmQUZvfNwbrHJKiwXc49r6mbQM5EdcKTwYZj3x3q/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfNAJ7+VPPFYIWrJd7NwR2rUvfPf1Ue/1iw0wSC1+vGX6ysXgMZo+WTc6+Tel4Fi7
	 q64fLAMvuZ4l14/az8eLSMt2tlmAM+APiHNgbl56POAlUT8mMHtGvx7poK21ONMaPy
	 afOPHrKIvqwi+ieZ13m3l97M+WDAtKOnZcknztcIAmL/Oyz62/do0UtoQCDaUC9Rtu
	 Y7opx6DFo1qz5uXJ0JJRpMfNLQorFB3q5E5uKNb+0N5ynw2iETPgBJnMV02S4s5FCA
	 tC4ac7ZEBaWge7IrhXuR8Y5rSVvZzKZRNrUU3jtARj47+DpVdlM9b/lmeQDuDlnB2N
	 qTd12LVNwiq0g==
Date: Sat, 1 Jun 2024 11:37:01 +0100
From: Simon Horman <horms@kernel.org>
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, edumazet@google.com,
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com
Subject: Re: [PATCH net-next v4 2/3] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
Message-ID: <20240601103701.GD491852@kernel.org>
References: <20240528212103.350767-1-zijianzhang@bytedance.com>
 <20240528212103.350767-3-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528212103.350767-3-zijianzhang@bytedance.com>

On Tue, May 28, 2024 at 09:21:02PM +0000, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
> However, zerocopy is not a free lunch. Apart from the management of user
> pages, the combination of poll + recvmsg to receive notifications incurs
> unignorable overhead in the applications. The overhead of such sometimes
> might be more than the CPU savings from zerocopy. We try to solve this
> problem with a new notification mechanism based on msgcontrol.
> This new mechanism aims to reduce the overhead associated with receiving
> notifications by embedding them directly into user arguments passed with
> each sendmsg control message. By doing so, we can significantly reduce
> the complexity and overhead for managing notifications. In an ideal
> pattern, the user will keep calling sendmsg with SCM_ZC_NOTIFICATION
> msg_control, and the notification will be delivered as soon as possible.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>

...

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 521e6373d4f7..21239469d75c 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2847,6 +2847,74 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:
>  		break;
> +	case SCM_ZC_NOTIFICATION: {
> +		int ret, i = 0;
> +		int cmsg_data_len, zc_info_elem_num;
> +		void __user	*usr_addr;
> +		struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
> +		unsigned long flags;
> +		struct sk_buff_head *q, local_q;
> +		struct sk_buff *skb, *tmp;
> +		struct sock_exterr_skb *serr;

Hi Zijian Zhang, Xiaochun Lu, all,

When compiling on ARM (32bit) with multi_v7_defconfig using clang-18
I see the following warning:

.../sock.c:2808:5: warning: stack frame size (1664) exceeds limit (1024) in '__sock_cmsg_send' [-Wframe-larger-than]
 2808 | int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,

I expect this is mostly explained by the addition of zc_info_kern above.

> +
> +		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
> +			return -EINVAL;
> +
> +		cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
> +		if (cmsg_data_len % sizeof(struct zc_info_elem))
> +			return -EINVAL;
> +
> +		zc_info_elem_num = cmsg_data_len / sizeof(struct zc_info_elem);
> +		if (!zc_info_elem_num || zc_info_elem_num > SOCK_ZC_INFO_MAX)
> +			return -EINVAL;
> +
> +		if (in_compat_syscall())
> +			usr_addr = compat_ptr(*(compat_uptr_t *)CMSG_DATA(cmsg));
> +		else
> +			usr_addr = (void __user *)*(void **)CMSG_DATA(cmsg);
> +		if (!access_ok(usr_addr, cmsg_data_len))
> +			return -EFAULT;
> +
> +		q = &sk->sk_error_queue;
> +		skb_queue_head_init(&local_q);
> +		spin_lock_irqsave(&q->lock, flags);
> +		skb = skb_peek(q);
> +		while (skb && i < zc_info_elem_num) {
> +			struct sk_buff *skb_next = skb_peek_next(skb, q);
> +
> +			serr = SKB_EXT_ERR(skb);
> +			if (serr->ee.ee_errno == 0 &&
> +			    serr->ee.ee_origin == SO_EE_ORIGIN_ZEROCOPY) {
> +				zc_info_kern[i].hi = serr->ee.ee_data;
> +				zc_info_kern[i].lo = serr->ee.ee_info;
> +				zc_info_kern[i].zerocopy = !(serr->ee.ee_code
> +								& SO_EE_CODE_ZEROCOPY_COPIED);
> +				__skb_unlink(skb, q);
> +				__skb_queue_tail(&local_q, skb);
> +				i++;
> +			}
> +			skb = skb_next;
> +		}
> +		spin_unlock_irqrestore(&q->lock, flags);
> +
> +		ret = copy_to_user(usr_addr,
> +				   zc_info_kern,
> +					i * sizeof(struct zc_info_elem));
> +
> +		if (unlikely(ret)) {
> +			spin_lock_irqsave(&q->lock, flags);
> +			skb_queue_reverse_walk_safe(&local_q, skb, tmp) {
> +				__skb_unlink(skb, &local_q);
> +				__skb_queue_head(q, skb);
> +			}
> +			spin_unlock_irqrestore(&q->lock, flags);
> +			return -EFAULT;
> +		}
> +
> +		while ((skb = __skb_dequeue(&local_q)))
> +			consume_skb(skb);
> +		break;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.20.1
> 
> 

