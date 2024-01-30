Return-Path: <netdev+bounces-67330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2107842D08
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 20:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D38E286C0D
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C7F7B3E9;
	Tue, 30 Jan 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OV7i9x38"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466077B3C3
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643496; cv=none; b=gQQ6j/T+hVb2SDWFT0wifEyjQ/AIpiVgLqU6D0hTziZt4gK+PbIgGqlhyCzZA58bofABFPoxk52/xzJIN1JcEo+qK/3sHLs5AvidjCE8H1JG1YkfBuQdYQUJcsKFhx3ALP1El+0Zsh67mxZgNMKcpL6hhYQrLhZMUNtwXT/x0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643496; c=relaxed/simple;
	bh=7LYL6l0Z94iO3etF1kV6s2A40BMWc1Uz9hRf/JzOdEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxWMVT0h2BopAkHjCN9oLmMvgSGurlDvPGLZ/NYZhqezQyBps05QOiNvxg8MMI2yi3/msYti8ALvB/Gmm0+f3473bKq3/t2CK+oS5y94roGbPSXZdUe1dPghOuZskChHXK5bwEkpL5Q2lulvLeMY5Zzw+bBsuztj0WcTitxZ24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OV7i9x38; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706643494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=erebicM5EGUj+TO55LHiZrDopa0H+e3Sw6aLGoB/nf8=;
	b=OV7i9x38twJKtpV2rC39GWg/63o0kVW6pYrWxd4auCt5NteNwsV8iKIh0sqZQZFE75Jb7f
	BviPG94MBmy9OSembcdES2lOWxgBgKwMa3M3YJCkBItm2E9GeX/07K1alxQFIv48n+D7rQ
	VaI3xWk4t0/4vM+cg0pkBjdpxWeGD7s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-OPqXUch7M5G34lmjUF-ODQ-1; Tue, 30 Jan 2024 14:38:12 -0500
X-MC-Unique: OPqXUch7M5G34lmjUF-ODQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40ef9f4ef41so12052045e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 11:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643491; x=1707248291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erebicM5EGUj+TO55LHiZrDopa0H+e3Sw6aLGoB/nf8=;
        b=GqRNfhG9AzyloT41jRGX1shRJ7zptPh7F2dCo9IjudvpzL1djSPw9TzkVaEGPDWQ8b
         2yYCw0O+EaK2NrwAQsx9C048AZwwN0p1rVYb9RkONA6ETT3FVdkjafNOigjHY5LeAOb6
         HqhGUJXcUSKToQ9nO3tWp8lae3DFT2xIUyAJwI956Z93i8wQ9l9/LAcvDGZbqn7/tW7J
         PROXwFnDUlWJjP4BvdtZRn/FtD+n3L/bjyP3bi5tEb/rKMCP9nNk4V2HBxuWUtL8dwq8
         xOng0bga5+2mCn5iq5kfns7F+hg+PYzU09ZEVDUxZoq9ALk/q+ZdX/peImJyWhTpsVFn
         Hx0Q==
X-Gm-Message-State: AOJu0YwQbkAI2Opot/RX0ieaT/oift4oFPTOx2LQQ2NJYGT5I37Fb8Ap
	FDeW2PmOVX3/qEVrnlArcX2Q0pCbjmAQLPvu83CBC9cJrG6XzNdZBfXBYTpCj4aD1k7OZYZocD9
	Vr0FS4SwvhL87JpPuEBOiHgnvkl9+26gQckfEARFLzBHNZdeNdak1bmHUt2iDqQ==
X-Received: by 2002:a5d:5f49:0:b0:33a:eec4:c0c6 with SMTP id cm9-20020a5d5f49000000b0033aeec4c0c6mr5906533wrb.12.1706643491358;
        Tue, 30 Jan 2024 11:38:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKqkjGsWLgqXDkjV3UDL3t5SPr6NwD7S1Po3VHtcXwQXYWg8xViryXwt1DgPwb+7G83X9Dmw==
X-Received: by 2002:a5d:5f49:0:b0:33a:eec4:c0c6 with SMTP id cm9-20020a5d5f49000000b0033aeec4c0c6mr5906518wrb.12.1706643491073;
        Tue, 30 Jan 2024 11:38:11 -0800 (PST)
Received: from debian (2a01cb058d23d60036688fbd67b19d62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:3668:8fbd:67b1:9d62])
        by smtp.gmail.com with ESMTPSA id gw6-20020a05600c850600b0040e813f1f31sm14019540wmb.25.2024.01.30.11.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:38:10 -0800 (PST)
Date: Tue, 30 Jan 2024 20:38:08 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Florian Westphal <fw@strlen.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/3] selftests: net: fix available tunnels detection
Message-ID: <ZblQIIiSYNn6kv8f@debian>
References: <cover.1706635101.git.pabeni@redhat.com>
 <cab10e75fda618e6fff8c595b632f47db58b9309.1706635101.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab10e75fda618e6fff8c595b632f47db58b9309.1706635101.git.pabeni@redhat.com>

On Tue, Jan 30, 2024 at 06:47:17PM +0100, Paolo Abeni wrote:
> The pmtu.sh test tries to detect the tunnel protocols available
> in the running kernel and properly skip the unsupported cases.
> 
> In a few more complex setup, such detection is unsuccessful, as
> the script currently ignores some intermediate error code at
> setup time.
> 
> Before:
>   # which: no nettest in (/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)
>   # TEST: vti6: PMTU exceptions (ESP-in-UDP)                            [FAIL]
>   #   PMTU exception wasn't created after creating tunnel exceeding link layer MTU
>   # ./pmtu.sh: line 931: kill: (7543) - No such process
>   # ./pmtu.sh: line 931: kill: (7544) - No such process
> 
> After:
>   #   xfrm4 not supported
>   # TEST: vti4: PMTU exceptions                                         [SKIP]
> 

Reviewed-by: Guillaume Nault <gnault@redhat.com>


