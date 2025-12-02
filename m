Return-Path: <netdev+bounces-243203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC1FC9B73A
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 13:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 023424E0F37
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F93101B6;
	Tue,  2 Dec 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Us9xtq6y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNRmz4Rv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A638D28AAEE
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677943; cv=none; b=usAxem8FBTM6oHdLC/rFCNpZ+gHW+zE6aVeTZSIWdsxvTcrCYJrEpcDMtGfHMsiiE10RjyDFtSm3fgqaMe9vf1ln+ZOHTfJZ95dqTDhxw4KZ00gnfNVwSSIUvWEwsZExy70MderfMi5R6plSdW6J1pZKfZSlKga9dbVO0dFsql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677943; c=relaxed/simple;
	bh=uuWokMcXh6fFcJfiunPM4C1/AJCMmi1e08ZDZCwXX5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mgs8MW/BeqFaXZfd/EOqS3GuO9HrDfNH3fmp5j/J4Q7f8avtUjuXU90uKXRpCX2E8nGNVTVIFdDlrQQUTsqciDoobmhGh70lLQUJEGD203wtVbKgxQJCYaCdwG2N4pz1qPlFMwon6N+yUhbO4APyKUdASZmsgefQaVtWup/ea3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Us9xtq6y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNRmz4Rv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764677940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73p8rsQanyvMu8svW4KzlWBhWEyw5YGt2CE2QUr3ZdE=;
	b=Us9xtq6yjXpdNna8zMivdF8xANxV5gkD3LAk6brBs3EElfMWHSv9XfqckffV8sVMNUDZrU
	U6ntxZX2AzfE+881VVU83OFxd+AWqm7b9PZdUYfdH4EyCYKK9zye/38luimX9LCvR2sV9X
	8V9Sr320+JeQLo5Ama4GVWzpORcIHmQ=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-7LQtfZJLPvOxE2miUDd_LQ-1; Tue, 02 Dec 2025 07:18:59 -0500
X-MC-Unique: 7LQtfZJLPvOxE2miUDd_LQ-1
X-Mimecast-MFC-AGG-ID: 7LQtfZJLPvOxE2miUDd_LQ_1764677939
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63dcbe3d18dso2109414d50.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 04:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764677939; x=1765282739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73p8rsQanyvMu8svW4KzlWBhWEyw5YGt2CE2QUr3ZdE=;
        b=UNRmz4RvxL2KRiKf2gCpoas1Jo5Kp5RHutXIMMl16tg7OX3Vwiu5s7Ehtr5SVCxy1j
         DQTEDYNrcCUEgqoB9FgOADerIoBRRj4nY2KN2Fer9dIAJJBY7d1lfTrdAVbOplrdOEKY
         SeqHQj1Wr4pEoxzz7Pdc/yHliBM9Ceor8nexoLSqpBKGwKqYv38aUQ9SDzKTLYpVAAJg
         Vhnmw8JQACma/lzE2SVNjJ7TVFbfz/FC8HH1uliHoLAgA9c2eHzlTbHEEHgQsP6PbS8y
         ajf9xMk7FiiaUbFPwp6JBOcji0tCf3QsV7l4lU3k4cBZdeUDp/RIxzjU/wYp+CIsA6iG
         6CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764677939; x=1765282739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73p8rsQanyvMu8svW4KzlWBhWEyw5YGt2CE2QUr3ZdE=;
        b=u6C0lrLgF0P0Y3q1UikSqWBEFpxhI+3zCJd5sBuBYSok87CQ+5wHDcUCeeAzGYNdbf
         G2B45JTn8IYrfmGKSSBkBgKaN2CkFgarE8GsXEl+M/o8x5ln0oOdjxipTLHRDDIIB/0S
         DQnPxSlD2bzIp6yv8by5dB9JQye7pjxBaIb4tKU51Zy9Ah0w43Wz+gvPWuglWx2HtDoh
         6gbSk9sgizgQAAkIKOWvJeO6cifrpiBE1lOLKV84d8vbMM1sLybSCUodor8vzMannAr1
         cky4xptSUzn5InB8emHeQPDufPKvm4Rl23vRH13Ed+jqpcs8OP+xBjYeU4a+8GI0IAIc
         9NoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIy8zr8KWl3hUOp9DmrpZI3yYilrd+R9zmoeB4BE+3K12ep+ZJ2k9ieBBe2Wg5xAcKPNWix7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAXYpVS3KcCdrFgSPF42jDObSWR9zgBzG8lwx2fdAtobzmLIc
	yNlcx/MST8H4rit67K5at5wWo0HyEe00R84Pk6oDT6e5lWJaBAHjHfZbwsZaeKgfy/Em/EX8JeO
	On4PUOa4+QkbLISpZTvpXr+xZUbADx9sTaoTaOZHZOra/TPg+TANptf6r2A==
X-Gm-Gg: ASbGncv1kpTkfkxwA6kdiMHo51HE0ZAnWAsG+Z6Nd5yC7ZB32t3AOZ2MI41w59ycRkZ
	5QF4qKkiW/rODUa0DUBdGvpklYsTB7WZ25OhPBrsPq1ODBK7MrVZ8EZGywQcdndnL3xhhvm9kP4
	QWttn3PXVAZvjiDL66/7eCEtcOW1RjSMf+DU9GOyZwZBbQQUy9Hz8iVsfwAzaYbCiyx5Ap6QdY0
	oub8q7U1DM+bvepu2KhS37KiXxMqdBxFyWmQPAtCY0rbIkGRIP4hPFzS82q/6y+2tz7x+9Vzf8a
	Y+YOdcfyLjeNbTKUPCEq9l5LLuC5jFHr1tBL196ZGan7Fr/9UTqFn60ALLknfRYP9EVZIWP3npv
	bmVuHCy4m92uWGQ==
X-Received: by 2002:a05:690e:1448:b0:641:f5bc:68d1 with SMTP id 956f58d0204a3-643293e8bc3mr22160631d50.78.1764677938828;
        Tue, 02 Dec 2025 04:18:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErrqxB/Bk/lrIn51AHdi5LVYWUNyIQkZhbctA0XAQfasj/h7FDTSP3kU6XXAz5DoGN4e+44A==
X-Received: by 2002:a05:690e:1448:b0:641:f5bc:68d1 with SMTP id 956f58d0204a3-643293e8bc3mr22160607d50.78.1764677938464;
        Tue, 02 Dec 2025 04:18:58 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad10292ebsm61900027b3.42.2025.12.02.04.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 04:18:57 -0800 (PST)
Message-ID: <ff955e6f-234e-4e0c-89bd-36c8518ca4fd@redhat.com>
Date: Tue, 2 Dec 2025 13:18:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] l2tp: fix double dst_release() on
 sk_dst_cache race
To: Mikhail Lobanov <m.lobanov@rosa.ru>, "David S. Miller"
 <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Bauer <mail@david-bauer.net>,
 James Chapman <jchapman@katalix.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251128132214.2876-1-m.lobanov@rosa.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251128132214.2876-1-m.lobanov@rosa.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 2:22 PM, Mikhail Lobanov wrote:
> @@ -1206,15 +1207,55 @@ static int l2tp_build_l2tpv3_header(struct l2tp_session *session, void *buf)
>  static int l2tp_xmit_queue(struct l2tp_tunnel *tunnel, struct sk_buff *skb, struct flowi *fl)
>  {
>  	int err;
> +	struct sock *sk = tunnel->sock;
>  
>  	skb->ignore_df = 1;
>  	skb_dst_drop(skb);
>  #if IS_ENABLED(CONFIG_IPV6)
> -	if (l2tp_sk_is_v6(tunnel->sock))
> -		err = inet6_csk_xmit(tunnel->sock, skb, NULL);
> -	else
> +	if (l2tp_sk_is_v6(sk)) {
> +		struct ipv6_pinfo *np = inet6_sk(sk);
> +		struct inet_sock *inet = inet_sk(sk);
> +		struct flowi6 fl6;
> +		struct dst_entry *dst;
> +		struct in6_addr *final_p, final;
> +		struct ipv6_txoptions *opt;

I'm sorry to nit-pick, but please respect the reverse christmas tree
order above.

> +
> +		memset(&fl6, 0, sizeof(fl6));
> +		fl6.flowi6_proto = sk->sk_protocol;
> +		fl6.daddr        = sk->sk_v6_daddr;
> +		fl6.saddr        = np->saddr;
> +		fl6.flowlabel    = np->flow_label;
> +		IP6_ECN_flow_xmit(sk, fl6.flowlabel);
> +
> +		fl6.flowi6_oif   = READ_ONCE(sk->sk_bound_dev_if);
> +		fl6.flowi6_mark  = READ_ONCE(sk->sk_mark);
> +		fl6.fl6_sport    = inet->inet_sport;
> +		fl6.fl6_dport    = inet->inet_dport;
> +		fl6.flowi6_uid   = sk_uid(sk);
> +
> +		security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
> +
> +		rcu_read_lock();
> +		opt = rcu_dereference(np->opt);
> +		final_p = fl6_update_dst(&fl6, opt, &final);
> +
> +		dst = ip6_sk_dst_lookup_flow(sk, &fl6, final_p, true);
> +		if (IS_ERR(dst)) {
> +			rcu_read_unlock();
> +			kfree_skb(skb);
> +			return NET_XMIT_DROP;
> +		}
> +
> +		skb_dst_set(skb, dst);
> +		fl6.daddr = sk->sk_v6_daddr;
> +
> +		err = ip6_xmit(sk, skb, &fl6, READ_ONCE(sk->sk_mark),
> +			       opt, np->tclass,
> +			       READ_ONCE(sk->sk_priority));
> +		rcu_read_unlock();
> +	} else
>  #endif
> -		err = ip_queue_xmit(tunnel->sock, skb, fl);
> +		err = ip_queue_xmit(sk, skb, fl);

This break the kernel style, as brackets are now needed around the else
statement, too.

If you move the xmit code to a separate helper, the problem will go away.

Also I *think*/wild guess the same issue affects ipv4, too. Why the ipv4
path does not need a similar fix?

Thanks,

Paolo


