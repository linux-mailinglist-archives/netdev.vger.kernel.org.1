Return-Path: <netdev+bounces-215596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA3BB2F65C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0EB5A0949
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141A30C344;
	Thu, 21 Aug 2025 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKPwSyWm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7E277C9F
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775074; cv=none; b=nTJIikXDvzmMA7Y7IcTvrIbd7SAQ6Z8df+E5XfyAN4cXc1FqIL7ScY40ednL7WwVGD3mbqWyeytHmycX1w4saqqK+4vHKjt71iBv5sW+Hwl60DYZxEwaf4mUqzScr2em9QLjEwSvNITFV7+FNAEaxH9CS8o1aGCNILXmyTufqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775074; c=relaxed/simple;
	bh=0eZh22ExobVFn9QdpDSpMbExsBJy4p5TIuWrfygp2ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGmRv8KiFbjwLMeh0wekEj6Qn/4GxQ26nnNvyYgshO34GH1zdFkMenEp09u10PBea8z1habbPTLhCaCHku1F4W+f1uczXHTvmTV5x0vYFJj5gcTOgjKBZGls9kE+rgXHD3MloIQx4nJgX5GaYCQxXV0bawRUbjIUocXMZyH/+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKPwSyWm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755775072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTF7fdaBAf09RlYCJCvUZk3IkcMydLaKtpCtjA+Wsos=;
	b=cKPwSyWm0RVSYuUBxUqPmDYtMtrwwAZG8EAlPWbdtYnAE7SoZRcyygfzuBA15VwfzP7hTv
	B2GcZ5yY/MIOx/waJbakXOiOgbHFUQ93DZ7OL/Au+DaL7wI1E3D2XOjp/APT4mh05m1vQH
	3Hw7cQ+BBCDPJBMSqYb2ze+iEoZG0xw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-7SY3Rl7XNee-_qFQg1xH3g-1; Thu, 21 Aug 2025 07:17:51 -0400
X-MC-Unique: 7SY3Rl7XNee-_qFQg1xH3g-1
X-Mimecast-MFC-AGG-ID: 7SY3Rl7XNee-_qFQg1xH3g_1755775071
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e870324a51so217996885a.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755775071; x=1756379871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTF7fdaBAf09RlYCJCvUZk3IkcMydLaKtpCtjA+Wsos=;
        b=Bbs2OLnuLbFuWSykMTG+qrlQ1l5PhdwCpFcvy4IBEm/iY46bqNICtZnz3YCteQrz/l
         1dAjUPWuOrLMk5kxC8iUPbH1xBwpaLx131dQ9RcE3yuenSlnpu8gbjjmbpoqi8pAAFba
         1T3RfYo0h5XFffFz75YnGNCyTlIet3puhBuZQ6SzeA+V9Kc/ctQPwSJzucMpunxfL1qm
         +NhN1xqzMQLukSTH7vy78K34zwtA35wc9JTXyeY8+BY2KqzOMKMGKUuPvCNJQDodxXgx
         SU2gt3O5/hZhI1fZGuR7MRfMOweu0aq8KGmnY1BJEd91CLar3c+g+VA3aeaivbhEEVFG
         Zatw==
X-Forwarded-Encrypted: i=1; AJvYcCUUqd7Px22l7C+oVlFKvFY8Yss/l/H7Cj1Jlg1U5NnnDi5BzeMuKdbDVEpxqMGzLkfFTq290LA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7o580e1GLtPqW/gLRnIKx51rH7+lmzOkFS5c6aQ0UMMsGGgFV
	sG1QSD9M4g4ZheDjsZDM839ZE08zvpJ/oHoj5da8YOr+FzZAiuBFq1JIbBLLiK7kW0vZFVQ3U/M
	G/lHrF2DA0vABQsk0ekqjkJ/qLjgqb70kNCPbVKmOE8+oi5ktZxJfQxuKaQ==
X-Gm-Gg: ASbGnctF3hnJu+Ab8vUgxyw+jC//vFuGci8f160y9Ev8UC2nN8FAv5kSjzzw5rhOIqx
	qWJSKvFYNBEXEtCljDk8/c56AkbT8PelTKY/loHHAofj4NlHYB74lWHyxlSBHqf5mvaF/eIqOt6
	+M8d/fxhhr758zdr9wHgyyl2KJrVk899arw/nmgkT/M2RKDgW+9ydCIu/iV17tWI8ck5fnM9azT
	V5VhP9HIP99FwpD6NygHKOiVMXlfgRY3r/Bg3pyHXqLKt8q6+pks+0dO/kkuh7owWWmlkBKcEYT
	5p9zYbBnNbfwXlRBPXg7rbPHHbEbsvfUOqL6djHUNnztqbZdRn4gxooAsdBlzjJbQnYsm58+cYN
	djMHBvIVM3fY=
X-Received: by 2002:a05:620a:4153:b0:7e9:f820:2b87 with SMTP id af79cd13be357-7ea08ea6badmr221665385a.72.1755775070661;
        Thu, 21 Aug 2025 04:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKExl4TKOYXLwhVSd7hxOBflNKJUSf9wwh0aonmAI1AB6dLc57LZaBS4sxU5LAnOMYXuVEEQ==
X-Received: by 2002:a05:620a:4153:b0:7e9:f820:2b87 with SMTP id af79cd13be357-7ea08ea6badmr221660085a.72.1755775070157;
        Thu, 21 Aug 2025 04:17:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87f16f9ecsm1080143785a.24.2025.08.21.04.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 04:17:49 -0700 (PDT)
Message-ID: <ec99ef48-c805-4ce8-99d5-dcf254f6e189@redhat.com>
Date: Thu, 21 Aug 2025 13:17:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/15] net: build socket infrastructure for
 QUIC protocol
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, linux-cifs@vger.kernel.org,
 Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1755525878.git.lucien.xin@gmail.com>
 <0456736751c8beb50a089368d8adb71ecccb32b1.1755525878.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0456736751c8beb50a089368d8adb71ecccb32b1.1755525878.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 4:04 PM, Xin Long wrote:
> diff --git a/net/Makefile b/net/Makefile
> index aac960c41db6..7c6de28e9aa5 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_PHONET)		+= phonet/
>  ifneq ($(CONFIG_VLAN_8021Q),)
>  obj-y				+= 8021q/
>  endif
> +obj-$(CONFIG_IP_QUIC)		+= quic/
>  obj-$(CONFIG_IP_SCTP)		+= sctp/
>  obj-$(CONFIG_RDS)		+= rds/
>  obj-$(CONFIG_WIRELESS)		+= wireless/
> diff --git a/net/quic/Kconfig b/net/quic/Kconfig
> new file mode 100644
> index 000000000000..b64fa398750e
> --- /dev/null
> +++ b/net/quic/Kconfig
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# QUIC configuration
> +#
> +
> +menuconfig IP_QUIC
> +	tristate "QUIC: A UDP-Based Multiplexed and Secure Transport (Experimental)"
> +	depends on INET
> +	depends on IPV6

What if IPV6=m ?

> +	select CRYPTO
> +	select CRYPTO_HMAC
> +	select CRYPTO_HKDF
> +	select CRYPTO_AES
> +	select CRYPTO_GCM
> +	select CRYPTO_CCM
> +	select CRYPTO_CHACHA20POLY1305
> +	select NET_UDP_TUNNEL

Possibly:
	default n

?
[...]
> +static int quic_init_sock(struct sock *sk)
> +{
> +	sk->sk_destruct = inet_sock_destruct;
> +	sk->sk_write_space = quic_write_space;
> +	sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
> +
> +	WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(sysctl_quic_wmem[1]));
> +	WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(sysctl_quic_rmem[1]));
> +
> +	local_bh_disable();

Why?

> +	sk_sockets_allocated_inc(sk);
> +	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> +	local_bh_enable();
> +
> +	return 0;
> +}
> +
> +static void quic_destroy_sock(struct sock *sk)
> +{
> +	local_bh_disable();

Same question :)

[...]
> +static int quic_disconnect(struct sock *sk, int flags)
> +{
> +	quic_set_state(sk, QUIC_SS_CLOSED); /* for a listen socket only */
> +	return 0;
> +}

disconnect() primary use-case is creating a lot of syzkaller reports.
Since there should be no legacy/backward compatibility issue, I suggest
considering a simple implementation always failing.

/P


