Return-Path: <netdev+bounces-207042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DCDB0570D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBFC1898365
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638942D5C6B;
	Tue, 15 Jul 2025 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYdxeWU8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1E238C1B
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573018; cv=none; b=ZqZ5EGFcIMX6ZqQAcAud9ffCZrc+MLwzMTkXPNHbgo2hZzsDYKLdzA6iHSA9GG7wVW9QFFO0cPKPBignXfvagqOffC+axCmXFg8trxiZWDIhnoGRXTbXZIOoIKzQYvKhxnGgUEnR5twY7oRyD/jOr8ocXtDlvavTzjY1Lhr895c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573018; c=relaxed/simple;
	bh=Ki0SgJl307cBiI+Sug5JFb+Pdax20SoV1tLcDKXVkeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P99TrLJGe4QX2pyOhufC7Kwb4tygofLXK/BXLtC+mSp964mKRggvtMcpcygQOuEOaSM0rbKm7ZH/4Kh8YUxylniy0Dt2EC+IvmTEd1XJpCvxUFFLKsqxs16MupsDcv6B/GRd9nfCO4sU3e3f256JbChdlQC9E/KWaIylgjMK2UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYdxeWU8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQEjAlaLqgiRX099uVhM3nPBv3g2I22KqeqxbeRqaJI=;
	b=RYdxeWU8+3oqnA+N0lHHjM+bCtw0xcflPhJ3d1+0jjzavOR+WOErJiwKfvNi+WukDlaPZ9
	Qrh2gWEmo7n7JSKVwbmo+4smSBQ2xo2UOds5jr8MLW63c51+I0BGThJr+tpb3fYLq7Jdur
	csGI0kTCskPEk8S+jG6a1P2jlCbPG7c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Ppo_D_rUNaKFwofYBopmUw-1; Tue, 15 Jul 2025 05:50:13 -0400
X-MC-Unique: Ppo_D_rUNaKFwofYBopmUw-1
X-Mimecast-MFC-AGG-ID: Ppo_D_rUNaKFwofYBopmUw_1752573013
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45624f0be48so4923935e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573012; x=1753177812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQEjAlaLqgiRX099uVhM3nPBv3g2I22KqeqxbeRqaJI=;
        b=rLywSbHb1idKkOHT5D1j6dYl48P4/0gm92zreof4p7ZVx1zjzRp7CtQDA3+CW1/Hsd
         qcB3u60zqYO4uk1MOuTKwTZ0s6wt40MsR4ZUwQMjyreYgtjInyXg5CxV6LSCULviZW0E
         lS7ovqO0lOtvnkJCzGPZM/Dyn+MZcCswcISoz03mP+qpqsvzxSum85SKRFIJPpF66O4t
         p9vXOggfT3JmsN24VGZ8Bc7BF04ivhJiECFQ86tvKwo6GLyf0ZLPDM9ThgsQyRfSHfQG
         9iUHUIYB+uHe1Wf/z0BmuudAcH7hSDEmz6OoU104h3TtFZogu0dk+uEUGdtvixDhNqob
         aXpQ==
X-Gm-Message-State: AOJu0YzKWsWDcTNdEVNtdF333MyOs7XMvGn0snD7SejklO5fdL6kd6eg
	f2hx6esvzJ7CBLl9r66qiTTI5HOArG2M99KQ6+ytLIj3hKilbD0o4HQlF8R6ctHmKaltEBilZSN
	qzODRumV+B8zTDW/SxHhLE7oYSML1UXvcyRT75K7wvkAIJ2CVlnJuue1SsQ==
X-Gm-Gg: ASbGncse98JfdpD8SEor8mLGtv0X8rqiHyq4sIHleEBwxE+qNHlJmX7HULsiv1fodLL
	giegOR7yn1x94mCkxb1qssBehhjtHNwPuQW3gWmq2pFT+xsPR5fhY3sf+d4sIbKKKCUBfpWhlCo
	RS+t3VE+r0NZ5TipSDXO2nqDbzH90iWWcZ+sswyOSyiRmLe9HwbxL9d+kYBDVvO2MC8gDNoI4oK
	mcKE/HBf89zn72eBTjH6ROLOuPubVmFEavNQPSlso242Pj2EzH+DWE1ESf3WZyvCMP3wkXfOc0w
	m+sWX0BxyvRm8cACcAPOkQ2bBKtXfjBON0IHm6PJ3abZmgKK8lH6GlHRHtNoBDksmkZPg3YfgVY
	twt+3938yOYA=
X-Received: by 2002:a05:600c:8505:b0:453:1058:f8c1 with SMTP id 5b1f17b1804b1-4555f895526mr150680125e9.3.1752573012539;
        Tue, 15 Jul 2025 02:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9E+SICra0WsD4nKZHDqyXOhwE+ihUk3ntWqvTNfrBMrLXWeidWJig86sG8z6W3uhU/mZe/w==
X-Received: by 2002:a05:600c:8505:b0:453:1058:f8c1 with SMTP id 5b1f17b1804b1-4555f895526mr150679795e9.3.1752573012118;
        Tue, 15 Jul 2025 02:50:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561b176f87sm54947305e9.35.2025.07.15.02.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:50:11 -0700 (PDT)
Message-ID: <dc01a67a-9946-456b-bfe8-fb20df0dc464@redhat.com>
Date: Tue, 15 Jul 2025 11:50:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/8] net: mctp: Prevent duplicate binds
To: Matt Johnston <matt@codeconstruct.com.au>,
 Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
 <20250710-mctp-bind-v4-2-8ec2f6460c56@codeconstruct.com.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250710-mctp-bind-v4-2-8ec2f6460c56@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 10:55 AM, Matt Johnston wrote:
> @@ -611,15 +610,36 @@ static void mctp_sk_close(struct sock *sk, long timeout)
>  static int mctp_sk_hash(struct sock *sk)
>  {
>  	struct net *net = sock_net(sk);
> +	struct sock *existing;
> +	struct mctp_sock *msk;
> +	int rc;
> +
> +	msk = container_of(sk, struct mctp_sock, sk);
>  
>  	/* Bind lookup runs under RCU, remain live during that. */
>  	sock_set_flag(sk, SOCK_RCU_FREE);
>  
>  	mutex_lock(&net->mctp.bind_lock);
> -	sk_add_node_rcu(sk, &net->mctp.binds);
> -	mutex_unlock(&net->mctp.bind_lock);
>  
> -	return 0;
> +	/* Prevent duplicate binds. */
> +	sk_for_each(existing, &net->mctp.binds) {
> +		struct mctp_sock *mex =
> +			container_of(existing, struct mctp_sock, sk);
> +
> +		if (mex->bind_type == msk->bind_type &&
> +		    mex->bind_addr == msk->bind_addr &&
> +		    mex->bind_net == msk->bind_net) {
> +			rc = -EADDRINUSE;
> +			goto out;
> +		}

It looks like the list size is bounded only implicitly by ulimit -n.
Fuzzers or bad setup could hung the kernel with extreme long list traversal.

Not blocking this patch, but I suggest to either use an hash/tree to
store the binding, or check for "rescheduling needed" in the loop.

/P

> +	}
> +
> +	sk_add_node_rcu(sk, &net->mctp.binds);
> +	rc = 0;
> +
> +out:
> +	mutex_unlock(&net->mctp.bind_lock);
> +	return rc;
>  }
>  
>  static void mctp_sk_unhash(struct sock *sk)
> 


