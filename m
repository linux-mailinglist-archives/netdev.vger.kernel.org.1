Return-Path: <netdev+bounces-107949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B0491D226
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 16:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1677DB20E24
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A0F14E2FB;
	Sun, 30 Jun 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCPqEX7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F2130A7D
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719758683; cv=none; b=tuhsBbVudAvdhpoRFsYs41VogPIFU6gbiJ5UopdlHCVexEgv7VZAByamEIFamZWtzIAuj9OY6dvAJIGUaebt/mEMjJrCGr/kKCJT7be1dSElMqCdd6tBzvkREOjOJW5pCHQHFl/ERwr+JnNoE7y8gtvBYIqjAnRtpYDMDQU449Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719758683; c=relaxed/simple;
	bh=Z50m3Dbl4z3lutc6d1QmPHtPW33ZF2+FrBv94EHkxQY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S25yEDyI8/9DoQPSFhNjHdlnBuIr0yZRHkr/GfmHE2xsvpEpxILABrNdB6ULhJNR8yLyKYnlFhO5JsxutM8ySbFHevqvYHKuVMg5kMUuVcL8RdGDru9v+3KKVRJjswfgAtsiek0Aow0Qu/jFjQimfMNyF9yKO4P/gGVPGM7Ep0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCPqEX7r; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b593387daaso25342396d6.1
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719758681; x=1720363481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbAmiodk9P9Xftj5+l3SED8rYLKLAIifrA0rcye4p90=;
        b=gCPqEX7ry3DlEe3rPesCAcrM6S7MH8AOzcJZw4xBDZr70lBjZW11zyt/M+ZZzn3/l2
         FJB8YhhM0Tl/KLXx3I02leR4ZOkEYz8O9IxpIzUW6fjzRj3yz7ZUuiNvrpbMxDirscSF
         5EzcZwremUaD+3ZjUKwjXMuEd2Qjy21A76frTh6tuO35bVd0m1uk+jWEgiPGTjQknezE
         1sJU7CuAIOBuJjkYjEQQ4Ey84UDrNvKlaotSqphjGWDwtp8erF8U7zgAWuwXixzTkwfI
         F+3iLAVb8Kgu10pbCWl2r54mT2dsa9UGsJD3UKGFzNJ4MrITuYiYyii8C83aNIcRV9SB
         m3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719758681; x=1720363481;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MbAmiodk9P9Xftj5+l3SED8rYLKLAIifrA0rcye4p90=;
        b=lNKG5Pg8W5A1hPdLZ40gjLS+10D7FguJMBAS0tHErQ9v2LrxWwvTtMRWBwy0TK6BnW
         PUkJyxSj+D0tIWzX5YpbDvjsg1Q413ywzRdgWkNOANK1VK60A8Mi//GgQIgpSaxqbCR8
         Lfh2Kf+KnqPh2vce/G5Wege5/SJroPDlsy/LzSpIozQnrmb+xYGLVtqcGqHHFh0qPz9r
         WBVrYffhm4f8RvunK/vF8LznjLNxOXP+9xtFbpKxPAyTwwHdTwC/adp5qYvRnZUAOaKV
         5wfBPItnPjROGrw2BSu/mbdn3WmwDyRiXR2eMI9muDAmIvgO/oHKZ+TB5yJUse3/itox
         ooJw==
X-Forwarded-Encrypted: i=1; AJvYcCW4gD29+ZOV1NwRv40x7Wl/nxYN9O+modp8K+zQvbCYygkYlghwDWCOhbG4A3ZBJoaLunjLfn8Ec4zrI+LgpiIRn6nBhtbu
X-Gm-Message-State: AOJu0Yz8LiKbQiL8vvhxInQDp6qdLYubncoKAwOL8bd/AkZSrkWhLaUV
	LaCEEAOAjKXYF2Dlsc7xBKCJ9iC9O2294k17BVg4UD6YP+qcRi6j
X-Google-Smtp-Source: AGHT+IHeAxuuWCZ00IG5PQmxSrwqXJSVeSohCxxD6IGiaKutNIx70y29SR4Tv9fdWDRNIN4kxYK49w==
X-Received: by 2002:a05:6214:e83:b0:6b5:1b0:1006 with SMTP id 6a1803df08f44-6b5a54360damr116064756d6.16.1719758680539;
        Sun, 30 Jun 2024 07:44:40 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5ac0752bfsm18602876d6.124.2024.06.30.07.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 07:44:40 -0700 (PDT)
Date: Sun, 30 Jun 2024 10:44:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <66816f57ea8e9_e2572942@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240626193403.3854451-4-zijianzhang@bytedance.com>
References: <20240626193403.3854451-1-zijianzhang@bytedance.com>
 <20240626193403.3854451-4-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v6 3/4] sock: add MSG_ZEROCOPY notification
 mechanism based on msg_control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
> However, zerocopy is not a free lunch. Apart from the management of user
> pages, the combination of poll + recvmsg to receive notifications incurs
> unignorable overhead in the applications. The overhead of such sometimes
> might be more than the CPU savings from zerocopy. We try to solve this
> problem with a new notification mechanism based on msgcontrol.
> 
> This new mechanism aims to reduce the overhead associated with receiving
> notifications by embedding them directly into user arguments passed with
> each sendmsg control message. By doing so, we can significantly reduce
> the complexity and overhead for managing notifications. In an ideal
> pattern, the user will keep calling sendmsg with SCM_ZC_NOTIFICATION
> msg_control, and the notification will be delivered as soon as possible.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  2 ++
>  arch/mips/include/uapi/asm/socket.h   |  2 ++
>  arch/parisc/include/uapi/asm/socket.h |  2 ++
>  arch/sparc/include/uapi/asm/socket.h  |  2 ++
>  include/linux/socket.h                |  2 +-
>  include/uapi/asm-generic/socket.h     |  2 ++
>  include/uapi/linux/socket.h           | 10 +++++++
>  net/core/sock.c                       | 42 +++++++++++++++++++++++++++
>  8 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index e94f621903fe..7761a4e0ea2c 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -140,6 +140,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>  
> +#define SCM_ZC_NOTIFICATION 78
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> index 60ebaed28a4c..89edc51380f0 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -151,6 +151,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>  
> +#define SCM_ZC_NOTIFICATION 78
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> index be264c2b1a11..2911b43e6a9d 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -132,6 +132,8 @@
>  #define SO_PASSPIDFD		0x404A
>  #define SO_PEERPIDFD		0x404B
>  
> +#define SCM_ZC_NOTIFICATION 0x404C
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> index 682da3714686..dc045e87cc8e 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -133,6 +133,8 @@
>  #define SO_PASSPIDFD             0x0055
>  #define SO_PEERPIDFD             0x0056
>  
> +#define SCM_ZC_NOTIFICATION 0x0057
> +
>  #if !defined(__KERNEL__)
>  
>  
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 35adc30c9db6..f2f013166525 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -170,7 +170,7 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
>  
>  static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
>  {
> -	return 0;
> +	return __cmsg->cmsg_type == SCM_ZC_NOTIFICATION;
>  }
>  
>  static inline size_t msg_data_left(struct msghdr *msg)
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 8ce8a39a1e5f..7474c8a244bc 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>  
> +#define SCM_ZC_NOTIFICATION 78
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
> index d3fcd3b5ec53..26bee6291c6c 100644
> --- a/include/uapi/linux/socket.h
> +++ b/include/uapi/linux/socket.h
> @@ -2,6 +2,8 @@
>  #ifndef _UAPI_LINUX_SOCKET_H
>  #define _UAPI_LINUX_SOCKET_H
>  
> +#include <linux/types.h>
> +
>  /*
>   * Desired design of maximum size and alignment (see RFC2553)
>   */
> @@ -35,4 +37,12 @@ struct __kernel_sockaddr_storage {
>  #define SOCK_TXREHASH_DISABLED	0
>  #define SOCK_TXREHASH_ENABLED	1
>  
> +#define SOCK_ZC_INFO_MAX 16
> +
> +struct zc_info_elem {
> +	__u32 lo;
> +	__u32 hi;
> +	__u8 zerocopy;
> +};
> +
>  #endif /* _UAPI_LINUX_SOCKET_H */
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 4a766a91ff5c..1b2ce72e1338 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2863,6 +2863,48 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:
>  		break;
> +	case SCM_ZC_NOTIFICATION: {
> +		struct zc_info_elem *zc_info_kern = CMSG_DATA(cmsg);
> +		int cmsg_data_len, zc_info_elem_num;
> +		struct sock_exterr_skb *serr;
> +		struct sk_buff_head *q;
> +		unsigned long flags;
> +		struct sk_buff *skb;
> +		int i = 0;
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
> +		q = &sk->sk_error_queue;
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
> +				consume_skb(skb);
> +			}
> +			skb = skb_next;
> +			i++;
> +		}

How will userspace know the number of entries written? Since the
cmsg_len is not updated, is the expectation that the CMSG_DATA is zero
initialized by the user and the list will be zero-element terminated?

> +		spin_unlock_irqrestore(&q->lock, flags);
> +		break;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.20.1
> 



