Return-Path: <netdev+bounces-186757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D9AAA0F04
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44D11BA0D17
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6AA215F6C;
	Tue, 29 Apr 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etcDz7JQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46BB20E6E4
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937293; cv=none; b=HJEQ6kUrX3kDNH3X29ZQHCf1oM22Rc9oUKKFMdEUE6w1mLk16vdsk4MtfP/16/UrRK7xYH6JDkvfrZ/FtzbSx0NFX+BHXY1KMvDJ/6e1JQxaL33JgeIMIpkuxtqj5NWU6FKPhP9wSEdq5G5t38ZxDS1fDrUhPhertRTiCq86A/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937293; c=relaxed/simple;
	bh=YdB7dBR3mSJ9UcQ4R3swc/maH0yTg2jV4PcEQ24xDQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5twXsa234dVTyW6fIBr/1EvQs+QPp5gyLCWyz2GL1hyEIum3k4DZlgZzrNeBSVdPw2S1qUBHcM+t27I6+KX2R98zIGur6vcXUiFNpkd5PbMu0OetP0QK0z4ehctRO3SVXiYy/moxw4X3Ao8BD3PMgOvfRi9jvNCBU8Btrr+Kt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etcDz7JQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745937289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBCQ7yC4DZE+Brh4t/wNH1fz7LCB0Tusx2dGusJqi60=;
	b=etcDz7JQcxASr818JR3UxlOVWGDJ5Dwa7nCFieb8vSXCEfeM2jRhhPmOns88ybs2BCogHD
	ObFEtS8/9/AFzURh9NUl/xgvItpVOn8jS9FYTT+RSTU16Hq+VlZngSpG4Ik245Y/pHXzjf
	I7vfvParOOWaKZT6Scd+Vm6+4iDW+U8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-0DcK2Oz-MhCSvgYn0rfFNg-1; Tue, 29 Apr 2025 10:34:47 -0400
X-MC-Unique: 0DcK2Oz-MhCSvgYn0rfFNg-1
X-Mimecast-MFC-AGG-ID: 0DcK2Oz-MhCSvgYn0rfFNg_1745937286
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so44460595e9.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 07:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745937286; x=1746542086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBCQ7yC4DZE+Brh4t/wNH1fz7LCB0Tusx2dGusJqi60=;
        b=l/mGM6nsRo0EEIP81g+LrGtzK9Ta50qRVddJ1iyJg0W7euirDHfy7G2CkBJPU1R0Ao
         qWbQi7+IK4tmRdNW2NRv6SlW2D06rVf7IDEdSzALMT53sV95DDl8mAbzaR7W7Q2KvIn9
         aobFsM9fyVbeveRT+fHTYVJZEto7RXe+GDFAOf3s6HXBDUzg7eq+wD8P1YU69UXSWr5v
         RNFeVUEWozjW7BsUt4sXdfW5rEO5+/7XcPbjdE3f30cH+uOtryAk3k3+zkKtKltMKrAN
         P1nhsaHDWOpyxhahPwBj0y2Igzt+D82ks0dSLufbLgbw7+bKsJuAIIlULpjO1Utuj5CH
         izkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVmRL3Z4uyQ2zYwip2s2qhLlCO4C0aU/djPFAQVYvfk57ArS6kz+uNiWDO0qx5MOncUY+byDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6cK3rd30P3SIJTnjAQihhaw54+VCAqAS1635qJRMnxw/Hphs
	AmNT8kpQObeY1cw3PdnH5igaukE7FY0Qn9CiIhl8taj7myuVDj2c2RcO0rGDr+QJqdKSzA6ECVy
	kWIZiBzyNFX3NhcRF2CBXOxLm3U6bHnHvozk+12TsYe2uhhRhK6Kfug==
X-Gm-Gg: ASbGnctQBfmufff5HklXsiVEpdU8b+6ovLb7i39cS2KCJGEyWBcZGd/G7DBu5Et0kN6
	yCyPWGn4ZocY4vnI2krqoXuQbOCi6Bbe+u1HFNSdlx+8HOM2KoLVI1VgV4oGSYWDdOrB8nhL1hA
	SSwz2FVpZN7Rz0bvDUp0qvaIeP4YkOA5JstLmWQDLvl1cYnIApvHI+CkG2inzEE5HRjElgRTxtI
	Ef0cb3faeglNxQhEwaHYka9NEVpeYwasIhLvJgWemLt/rDjY6t5VfBp3Fw0wL+rXmyUyfAMPUYX
	Ol+9R+fDJXABli8Rumk=
X-Received: by 2002:a05:600c:1e0e:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-441ac88acb9mr28922525e9.25.1745937286068;
        Tue, 29 Apr 2025 07:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzFC7JTH1cCKfCoD0KtL/PJnk0rLhxxGRVYh+6Vv8ZU7rmNtMiOe/2tPKSMhGhjoS8cjz9Pw==
X-Received: by 2002:a05:600c:1e0e:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-441ac88acb9mr28922245e9.25.1745937285632;
        Tue, 29 Apr 2025 07:34:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910::f39? ([2a0d:3344:2726:1910::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a0692a22sm177630795e9.2.2025.04.29.07.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:34:45 -0700 (PDT)
Message-ID: <06953a63-7309-40d4-b515-ffc56e751559@redhat.com>
Date: Tue, 29 Apr 2025 16:34:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: call inet_twsk_put() on TIMEWAIT sockets It is
 possible for a pointer of type struct inet_timewait_sock to be returned from
 the functions __inet_lookup_established() and __inet6_lookup_established().
 This can cause a crash when the returned pointer is of type struct
 inet_timewait_sock and sock_put() is called on it. The following is a crash
 call stack that shows sk->sk_wmem_alloc being accessed in sk_free() during
 the call to sock_put() on a struct inet_timewait_sock pointer. To avoid this
 issue, use inet_twsk_put() instead of sock_put() when sk->sk_state is
 TCP_TIME_WAIT.
To: Shiming Cheng <shiming.cheng@mediatek.com>, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, horms@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Jibin Zhang <jibin.zhang@mediatek.com>
References: <20250425073120.28195-1-shiming.cheng@mediatek.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250425073120.28195-1-shiming.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/25 9:31 AM, Shiming Cheng wrote:
> From: Jibin Zhang <jibin.zhang@mediatek.com>
> 
> mrdump.ko        ipanic() + 120
> vmlinux          notifier_call_chain(nr_to_call=-1, nr_calls=0) + 132
> vmlinux          atomic_notifier_call_chain(val=0) + 56
> vmlinux          panic() + 344
> vmlinux          add_taint() + 164
> vmlinux          end_report() + 136
> vmlinux          kasan_report(size=0) + 236
> vmlinux          report_tag_fault() + 16
> vmlinux          do_tag_recovery() + 16
> vmlinux          __do_kernel_fault() + 88
> vmlinux          do_bad_area() + 28
> vmlinux          do_tag_check_fault() + 60
> vmlinux          do_mem_abort() + 80
> vmlinux          el1_abort() + 56
> vmlinux          el1h_64_sync_handler() + 124
> vmlinux        > 0xFFFFFFC080011294()
> vmlinux          __lse_atomic_fetch_add_release(v=0xF2FFFF82A896087C)
> vmlinux          __lse_atomic_fetch_sub_release(v=0xF2FFFF82A896087C)
> vmlinux          arch_atomic_fetch_sub_release(i=1, v=0xF2FFFF82A896087C)
> + 8
> vmlinux          raw_atomic_fetch_sub_release(i=1, v=0xF2FFFF82A896087C)
> + 8
> vmlinux          atomic_fetch_sub_release(i=1, v=0xF2FFFF82A896087C) + 8
> vmlinux          __refcount_sub_and_test(i=1, r=0xF2FFFF82A896087C,
> oldp=0) + 8
> vmlinux          __refcount_dec_and_test(r=0xF2FFFF82A896087C, oldp=0) + 8
> vmlinux          refcount_dec_and_test(r=0xF2FFFF82A896087C) + 8
> vmlinux          sk_free(sk=0xF2FFFF82A8960700) + 28
> vmlinux          sock_put() + 48
> vmlinux          tcp6_check_fraglist_gro() + 236
> vmlinux          tcp6_gro_receive() + 624
> vmlinux          ipv6_gro_receive() + 912
> vmlinux          dev_gro_receive() + 1116
> vmlinux          napi_gro_receive() + 196
> ccmni.ko         ccmni_rx_callback() + 208
> ccmni.ko         ccmni_queue_recv_skb() + 388
> ccci_dpmaif.ko   dpmaif_rxq_push_thread() + 1088
> vmlinux          kthread() + 268
> vmlinux          0xFFFFFFC08001F30C()

Part of the commit message landed inside the patch subject, the stack
trace should be decoded, the patch should target the 'net' tree and
include a suitable fixes tag.

Please have an accurate read at the process documentation under:

Documentation/process/

and especially to Documentation/process/maintainer-netdev.rst before the
next submission.

> 
> Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>
> ---
>  net/ipv4/tcp_offload.c   | 8 ++++++--
>  net/ipv6/tcpv6_offload.c | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 2308665b51c5..95d7cbf6a2b5 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -431,8 +431,12 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
>  				       iph->daddr, ntohs(th->dest),
>  				       iif, sdif);
>  	NAPI_GRO_CB(skb)->is_flist = !sk;
> -	if (sk)
> -		sock_put(sk);
> +	if (sk) {
> +		if (sk->sk_state == TCP_TIME_WAIT)
> +			inet_twsk_put(inet_twsk(sk));
> +		else
> +			sock_put(sk);

You can simply use sock_gen_put() instead

/P


