Return-Path: <netdev+bounces-246171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 465EBCE4A5A
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 10:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8822630014DF
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B212877F7;
	Sun, 28 Dec 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6FfrO2L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tPTkC7lQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC81F4615
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766912535; cv=none; b=GW4VT+WuagVgJloSow8w7mOd03IWVqozsYUfOn2Vbj4d/MHFHnRN4ThjljNkqXk9lDwp5NTGU9im158+y4cTeTWbVrSJynJyZUxZhHWLSIZy7Fg+xr3Q6QgLhSBvXbmsMuxWB0UUpMSLKTmhqGjMt5pLeMakIZYEHRk1d7+M/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766912535; c=relaxed/simple;
	bh=Ou7ZaYBTH1zYK+UpXkX/bEMorgWtw0RhmRMfDmefJdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAx2Cx0A/l9Mt7L/rL2Hdqq4kRYFfrtqYI5YnxhXCfTYRoWeUQRluNL+spUcJRljONOY6P6k0/C/GWFUm/ndShg09ENPv7MKigZVhCPMR3f/hPyhKjdjuL32W55fTGTxzgVi+iIbsu8HdQRcbFPPDnIvjtVSnSL+H6JRsDPIOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6FfrO2L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tPTkC7lQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766912531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=duGY2Pgsyw0hQLMvmQn8PE90tLWJkvh3NYOXIsSCEDE=;
	b=N6FfrO2L/LYCMySHnQzasicd3XA/LG2thUOybxo8xW4srKKuN5f8mpFjyU82BiitI846Ww
	nhPdVmlHrKkJoEdBYP7q+41r4yq7vNCfbGlzOSoo6f8Elns0Y/1hnpkmlzdeo4XxAfhsmI
	W+lHAxw14CmvYJ413b8X3taumpZFGcU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-jdcujkqrPqyt8C-JVDegVg-1; Sun, 28 Dec 2025 04:02:10 -0500
X-MC-Unique: jdcujkqrPqyt8C-JVDegVg-1
X-Mimecast-MFC-AGG-ID: jdcujkqrPqyt8C-JVDegVg_1766912529
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso4116006f8f.2
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766912529; x=1767517329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=duGY2Pgsyw0hQLMvmQn8PE90tLWJkvh3NYOXIsSCEDE=;
        b=tPTkC7lQl6YAdBfaHihXVV82IZrnUaOshr7tVjA24GW+LWSloIXPiXwzEQqOC7S8yI
         fAcdA/dwzPvS4JwMEj5UyWoTIy9zvfosEHMlMJnhpaJV8vHKLgxRAMvzGDv/5/UvV/yq
         z3rXqP4ESju3p3Pp2V+YldNDaOcSO1yMu6gGCSvE8ukb4pdJVVxs+GXzv/sfVXi4FLPX
         8ajrHYu4osz8csYVRl96TSxjfwP80if2vcqCLerrs0C4hWBZudnI+nKA0vZg7vFEgy+l
         tAzoOwTBqqZmq/2uvgRpMjNkd+osHyolCfE4iqnsbzfafeZ9v1jUENXwrkv4UWscmbUu
         E67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766912529; x=1767517329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duGY2Pgsyw0hQLMvmQn8PE90tLWJkvh3NYOXIsSCEDE=;
        b=NaqmGRo7WaRZsElZS9wl4igTeEv8nBMwqOmFC4qpKbqZAGfLILa7oEXZGV0hkdOksG
         X2BuDKbRkIhaMpUF8/ZavrBd94ZtKoqeda24dUoz/3q6vyjX6ZY5MdVtcGKz4l9eCOXn
         BG0Gu8LJknDpymedl2p4joP+DyST5kOX4a8KVImKtVDVDhVn+bDK+AZE1C+AHqL2k7Np
         vW+Ws2aNmGBkhKElICFy4KBkuuTFDPjyvDpWkTQTBWtQrGKqfITbLkU+kuHMNiOwTpKc
         YzuqXWzGGZeYIiRMT/LiMUQM5STcb727BTE9Qlng31IfC2m1zI5Hh1Ydk273pUwNF25U
         iRKg==
X-Forwarded-Encrypted: i=1; AJvYcCXybDoN6rYoEf498JYYTtx9m83TtUT6B3c0GFx+1pa0GMESMh2MKhlSHvprzfm6tuWx/dvE/lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlwMS8NScx4YE8A+BqW3LinAUF+6F+RS+gDVf0OzKHJh5QTzTb
	/GeQoGv5OwQcUaNqSPDDqmkY7a8R3enVSxNLKgi8uSOHHqis5Kq5IFqCJcRBuZdVkZY0e7iLJG1
	CbntSplBpQbRtfCiMX/g6WeKDiS4GRE/cuWa9kAvehm983SgbmPEIHkZNgw==
X-Gm-Gg: AY/fxX59zT4/k979gU9q075MlLDX6XOZmz7Oc467cnw57uSycbinFeWDUQDLl2H1pBc
	2XbQ30iEQRQSypWSOJIiw8NP9rqvd2IhwJVxm1o+o650CiQupiRmPGn5vaQtsYUPJ35OD5caYmP
	weBMs/D4ZrfHXnne5e8AhyezKud49smLpuoaBx1JLqR2ERao8CN2yvqogD4Apfg7KAR7dW5Kx55
	W06QFlmIvCLs0CDEOPW8sxpomf+RA07GHe1/wkB+egVU9Ofvayrv1tQye55QGfFKs7Arth9mVZq
	L0glwBiABZM5T0GKRNR23q2qp7FKKHIWAc7Bx+ain5BMPlMis2OzzkYZa+IactmKjUQHXjFVeAu
	nwGzQ+FZ6hEY8aw==
X-Received: by 2002:a05:6000:2dc7:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4324e50b88emr31586029f8f.46.1766912528759;
        Sun, 28 Dec 2025 01:02:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHMspkPwe7S0pZGpEQwfK3oywGl5rinLKECsu6Q7dO5WCye7HQiBnxVQZHRtE7DVSj+K0obA==
X-Received: by 2002:a05:6000:2dc7:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4324e50b88emr31585991f8f.46.1766912528353;
        Sun, 28 Dec 2025 01:02:08 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm56251992f8f.34.2025.12.28.01.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 01:02:07 -0800 (PST)
Message-ID: <c7851c67-dd52-41d4-b191-807aa5e26d9d@redhat.com>
Date: Sun, 28 Dec 2025 10:02:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED
 in nfc_llcp_recv_disc()
To: Qianchang Zhao <pioooooooooip@gmail.com>, netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Zhitong Liu <liuzhitong1993@gmail.com>
References: <20251218025923.22101-1-pioooooooooip@gmail.com>
 <20251218025923.22101-2-pioooooooooip@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251218025923.22101-2-pioooooooooip@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 3:59 AM, Qianchang Zhao wrote:
> nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().
> 
> In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state,
> the code used to perform release_sock() and nfc_llcp_sock_put() in the
> CLOSED branch but then continued execution and later performed the same
> cleanup again on the common exit path. This results in refcount imbalance
> (double put) and unbalanced lock release.
> 
> Remove the redundant CLOSED-branch cleanup so that release_sock() and
> nfc_llcp_sock_put() are performed exactly once via the common exit path, 
> while keeping the existing DM_DISC reply behavior.
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
> ---
>  net/nfc/llcp_core.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index beeb3b4d2..ed37604ed 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
>  
>  	nfc_llcp_socket_purge(llcp_sock);
>  
> -	if (sk->sk_state == LLCP_CLOSED) {
> -		release_sock(sk);
> -		nfc_llcp_sock_put(llcp_sock);

To rephrase Krzysztof concernt, this does not looks like the correct
fix: later on nfc_llcp_recv_disc() will try a send over a closed socket,
which looks wrong. Instead you could just return after
nfc_llcp_sock_put(), or do something alike:

	if (sk->sk_state == LLCP_CLOSED)
		goto cleanup;

	// ...


cleanup:
	release_sock(sk);
	nfc_llcp_sock_put(llcp_sock);
}

/P


