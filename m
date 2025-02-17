Return-Path: <netdev+bounces-167035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651C3A386EA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B86B1887EF0
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19FC221560;
	Mon, 17 Feb 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mx4kRtrY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899F21CA0E
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803717; cv=none; b=u2+0QLunlbWOruOfolgpxv5vRMOV5BQcU1fy5Nf1eebd3v7wC+Z2fC9oEdeeETqSQAL6XzPHMHM+wdxFPA421jukdQFIN5WEmYyVAOCO7ngiDy9pw5npD08UxraQSfTVRKyYAvp5pPMRQDDFIJXxY9tQOqWCSGfaUVFF7WFTj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803717; c=relaxed/simple;
	bh=8dhjqi6RQt0qUvh026uE2aPh7osHZWJ3X8d5NYVkLm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBQAotwWTfACMg4ocxsiBMThU5b135jXH1m3KBECgX8WKv3qj4RDrw9lgE2qCt/4CxVd+91av+taJjK+joMM2n993fKVe2Sm7+OFl/DTBYyumbMJYRPVZEwAEbsiQ0vofN0CIqdH+5px5CZMgrufOkJpB3ti1/SO/vnILN5WF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mx4kRtrY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739803714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc6qCN4ETICC8azLtjrKdOIt2/nf2AWh/k3ErXHTy00=;
	b=Mx4kRtrYwSqJrvpRZyFiPMQ9XQpXthslg+UYXDRvXKfPfmu7D5p3dUH8q7kkaePfFixSbx
	Hf7CN0zMOhS8AqTiiQkohFaAxpx4XJup4ciPULKovkek3mjsN9iVlH6kGepcOgvB3n8pzT
	6jp7RVGEOMSEbN/bnfb+j0wIDELnFmI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-mrWbPi0hNja-OIALSx04Uw-1; Mon, 17 Feb 2025 09:48:32 -0500
X-MC-Unique: mrWbPi0hNja-OIALSx04Uw-1
X-Mimecast-MFC-AGG-ID: mrWbPi0hNja-OIALSx04Uw_1739803711
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-439385b08d1so40485655e9.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 06:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739803711; x=1740408511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc6qCN4ETICC8azLtjrKdOIt2/nf2AWh/k3ErXHTy00=;
        b=U3+2Rty4mD/lHOb+/VkHwj09bFkHmVDphwx9BZcaGuIZuvOXi4eXtPEIX0VNVrJamu
         MaOPek+82EhKqR2VymUTsRU1YRYf91/cidPQ4yBjk7QWNUm05xmYtuYBM2cWq44Lwu6G
         r9QADhTkQYHYPa8RBIpOUmL1oUHZeaJCqh+/NmTZGhpIzbK7OPP9vpTUpbZVHqe17Xg9
         iL2AhsQemrrkbj11BtuR/19qmB/pBcRWncJi5iZXAEfvCXFYoJ4jYmhly10DQOYhSI/p
         AyKoW0sJresKOuCZWWRnxCX87/Npk/K0B1uwt3Wgur+IDuJp8cdbc7+GaNNP4qOZEggA
         n5kg==
X-Gm-Message-State: AOJu0YwH5z1vRWWUkxiUZ6AU6XWsKwPZrMKd7UNpgG7azxQbloR+vAAM
	z7NUGzU5xPnWXBsEy4w/zLCjoQ0jTqdK5B58bI6cephAxDETRSG5h2UBWx8B/FAbNr7FdLN9hWp
	Ecv1Nz5SPuoHBfVITYp7UpoR99xSio/04wSFcJn8obBicqwk7sXRSUw==
X-Gm-Gg: ASbGnctfzViNm2gg0Lsx9YbXQ91w6EAAddwdYS1fSTqyHtejCOUj0CCPI5AhmyM3vuI
	8diMc8M/JMFx6uHKV5g+CU4Uo9QqCCrQBFYWhQ/FnK3HMjSk2DBhuT+Au5rI5NKQ7Fd5k4qNhaB
	sufimP97n8GHDH04tQDO8fP7mgdXw0cpr6+78//NFznHkMYX67GURs4etnkuM+1U3kiLvgTbq0c
	LMSGYV+fjmmlMtCMFWWdMwAPddIpkjV+7aqaCzKyeIC0fTK3r1lgyscMBEaGJL+HvmkQY2bCCgo
	odZJBUwgKBtYlsn6mIoUwUlMRcTZvafQYto=
X-Received: by 2002:a05:600c:1c24:b0:439:6304:e28a with SMTP id 5b1f17b1804b1-4396e5b56e7mr110357185e9.0.1739803711291;
        Mon, 17 Feb 2025 06:48:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4dxgzvDp9rr1MXvaB9poBGfjXuDnm6JJThZOwkW5h8/2vTvlD/gGcLEba0dFztjL+/zHSAQ==
X-Received: by 2002:a05:600c:1c24:b0:439:6304:e28a with SMTP id 5b1f17b1804b1-4396e5b56e7mr110356975e9.0.1739803710901;
        Mon, 17 Feb 2025 06:48:30 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617da91asm126105915e9.2.2025.02.17.06.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 06:48:30 -0800 (PST)
Message-ID: <41482213-e600-4024-9ca7-a085ac50f2db@redhat.com>
Date: Mon, 17 Feb 2025 15:48:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
 <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 9:47 PM, Eric Dumazet wrote:
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5b2b04835688f65daa25ca208e29775326520e1e..a14ab14c14f1bd6275ab2d1d93bf230b6be14f49
> 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -56,7 +56,11 @@ DECLARE_PER_CPU(u32, tcp_tw_isn);
> 
>  void tcp_time_wait(struct sock *sk, int state, int timeo);
> 
> -#define MAX_TCP_HEADER L1_CACHE_ALIGN(128 + MAX_HEADER)
> +#define MAX_TCP_HEADER L1_CACHE_ALIGN(64 + MAX_HEADER)

I'm sorry for the latency following-up here, I really want to avoid
another fiasco.

If I read correctly, you see the warning on top of my patch because you
have the above chunk in your local tree, am I correct?

If so, would you be ok to split the change in a 'net' patch doing the
minimal fix (basically the initially posted patch) and following-up on
net-next to adjust MAX_TCP_HEADER and SKB_SMALL_HEAD_SIZE as you suggest?

I have a vague fear some encap scenario may suffer from the reduced TCP
headroom, I would refrain from pushing such change on stable, if possible.

Thanks,

Paolo


