Return-Path: <netdev+bounces-212865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E834FB224CF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465E71A28107
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACAF2EBBBC;
	Tue, 12 Aug 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdEipK2c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3C42D59E8
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995565; cv=none; b=n9xq6eETDl/g4kpn1UotIdLqne65mY3mbNfqTxcExZ/RdHUbYvJM0lcTUgz7FXoNPDQzZEX6+VJ9k/9Q8/HGbT2FDrkljfuxnEJ+dBaNy9UsH+emwzY9gqTxpItM4tLY3eos/pbHRLWdRu87mYrF9HwFu9ACYeKzFWKozjoQdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995565; c=relaxed/simple;
	bh=ybWUfVr4iWvR37axpgnTuvC0bhYgSv6/xm1wtU3e+yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIiSZk+/hKKl3SRSiaDn73YCqN7IzJrTalRb/rc2vQcCpzFKwlCS4xNdAgzleXqiuJscjd3S/qeUDey4rTMIzNqP9RLDbDCgIg7B2B1K5w22+uh0sgB6DpiJeg6rxhs7W2NvMZN1j2Obngc01FkUPeHgMdQ6m2P9JHaziG7IJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdEipK2c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754995563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgFzWvSRS7suBynzL025eWaFy4IfOxjAAMOXhMpwLVU=;
	b=UdEipK2cZ31T2DGfUpNx2RHiWAzt+VVmxTlzoOC3j70vaFMeMr8Ryw0dL9aYwinFzdEfPu
	9xKmx7+h39bfs+4Zfh6im2iVTK+7aIJ6HsHtca+9pIilcWcapb4NygIWhLSBWbmoqggJIj
	LStBb8xJWzInAVbrYBaGVIGqHd53qJg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-XGwRuCwaMX24BBtuZd7fSA-1; Tue, 12 Aug 2025 06:46:02 -0400
X-MC-Unique: XGwRuCwaMX24BBtuZd7fSA-1
X-Mimecast-MFC-AGG-ID: XGwRuCwaMX24BBtuZd7fSA_1754995561
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0ecedfd4eso14449121cf.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 03:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754995561; x=1755600361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgFzWvSRS7suBynzL025eWaFy4IfOxjAAMOXhMpwLVU=;
        b=ZwrQ3gNRhN+Iox2RcCJdsHppLJQDNQ+gG4OFyoTI1E/uu3BlWnvuxXfMRg3KrqOne2
         DG48in5B50lN+gqy0YKdZdLzG1aCwQHYYoZbRUHYM5JCQD/4KH8KLw2PrYl4lm3GdvAK
         20KpZecIBiJvdRpvGzHKpJ4FaxOkIX2cI8QFS5kAw9W4sleMS/Q2eM1CMaIo4A7EC83r
         njcJz1l9AsJcSo1cTV2nZh9rDXzkAETHRNvnAgCwHuWzHhNjg4Xg8lLQgVdNuIMf4qMW
         VHc1+sKJPKRLEWKuKyb3lOcEObwqFMnfY8hUnTkLjKhcns/Zj+o+5h/KkNzRQGPjEHJF
         1OBg==
X-Gm-Message-State: AOJu0YwN99x1d16egm+MxtoRbxR2PjWvsyvJMnjOMohcJXYV+heDI7+f
	HH3IEz3u/BfYhN2B4zNQ61vzXI+50X9E3YFFqnjOLqsY7cIJbtWJkLWv/hwOE30LRdM4Ayn9AC4
	sBtuAtjfGJeSFFkZCW4pF6Cg97phSCxa/BOUNs1k+ohex1xOT/xy7QtZq4w==
X-Gm-Gg: ASbGncvt3QMrRBLP2wNLzS+2MVh8obo/cmfe4HtE3lDSTG7mAjGAj1jOI5AH8gMMnx5
	K/NuLD8p7zi0NkLPp1oN/9k1rbQUntqJbH2TFAgRijAT0vb6vYyLk6CcHwlr8+c3PTxqFVb5ZDV
	opYPZ4Lb10kOVLBAweYKZQZ/oVst9Nw/GKAYXo2HbhBIg5V+JdNoTcn5Ki8ARcMFnn/4zm9BwX6
	yoYg62vDEk4ZumiIHYNKYXa1UD1UOElhAh2tyQX5k//I7buO1VCEMGU8cF+tEygau7Ouoz5DU2z
	dBaH3a41cgygU4Q/1fldg48EHXLhhoQ7ZkWNAhiwnGo=
X-Received: by 2002:a05:622a:287:b0:4af:2139:7721 with SMTP id d75a77b69052e-4b0ecceaa2amr41364651cf.51.1754995561465;
        Tue, 12 Aug 2025 03:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiNLWRjJSo2ktwr8q2NorVM+fSVr7t+Nu6M6YQ5n1Qfc48OrofTZUKATIyipRQi5RHKh0W8A==
X-Received: by 2002:a05:622a:287:b0:4af:2139:7721 with SMTP id d75a77b69052e-4b0ecceaa2amr41364381cf.51.1754995561030;
        Tue, 12 Aug 2025 03:46:01 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b076710ff1sm111138881cf.52.2025.08.12.03.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:46:00 -0700 (PDT)
Message-ID: <b3a83032-8ed4-4d5d-9df9-6dbd02acac1c@redhat.com>
Date: Tue, 12 Aug 2025 12:45:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] tls: handle data disappearing from under the
 TLS ULP
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, sd@queasysnail.net,
 will@willsroot.io, savy@syst3mfailure.io
References: <20250807232907.600366-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250807232907.600366-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/25 1:29 AM, Jakub Kicinski wrote:
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 549d1ea01a72..51c98a007dda 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1384,7 +1384,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>  			return sock_intr_errno(timeo);
>  	}
>  
> -	tls_strp_msg_load(&ctx->strp, released);
> +	if (unlikely(!tls_strp_msg_load(&ctx->strp, released)))
> +		return tls_rx_rec_wait(sk, psock, nonblock, false);

I'm probably missing something relevant, but I don't see anything
preventing the above recursion from going very deep and cause stack
overflow.

Perhaps something alike:

		released = false;
		goto <function start>

would be safer?

/P


