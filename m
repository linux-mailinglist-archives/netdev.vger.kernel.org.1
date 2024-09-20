Return-Path: <netdev+bounces-129112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A897D8B9
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 18:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F91C20E35
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DAB17E016;
	Fri, 20 Sep 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PgEzo1fx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305B17E005
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851469; cv=none; b=LS93eK5BanBJyAzwXGJXMCTVprvwuBCjnPaFw5fuFs3TSTWL7fXqbvEQwfiC31WeGfGPf4Ya7F7SGX6ajlY+wAaa4ZJbPEsD0A6MhWCUqXTLV2MNg9L8ltxDszPbpR500EVaoTBfDOQOE5i4GqL7oOsCJvy9enVJnB2/2Jzs4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851469; c=relaxed/simple;
	bh=0VndrB7wUbmZML5AQ3UnMNv6I2BM2u35xkfH2xKB9Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCAGkfpX/0tnKX1S2gFm52T7ixATDue6KpcDsIPd/d18iTG0s3q9Xzg0pqZ9MYyZsHe/8MafCJAm5OF2fgVB5wY00KsTaR493MP8GhD9AqgsUOpy+LyOSPuODO70ErA7duMwm5kp1VYTkurwQcft3LgnQb+cbmPGdn6SfA38Fbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PgEzo1fx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e5e758093so19943975e9.1
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726851467; x=1727456267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPGcaGILxwhfTJ1AkidUV1js05svfUGNV2qC8S2ASMs=;
        b=PgEzo1fxKw4erEqJdbvBYawafZOkdTH18IloSozw2Iy9pqg1BPRShq9mFLy9c2F1Z/
         RecKBiQizOtl7ydTCGfUrX7i1gRYmMQX6AqjeSnrzeSUgrYdRzPI4TV+pHQP98EtiFNS
         ywdHeYpvy5mvUT7gspf+cqYFwah/s5hlD41JHZIlldzNFluurbU7TDAdfXpFW8Ac92EU
         UIiJmA/vA9HQDKuz37IWqBd1ogrYCagskMwk+O8/6yZPWR44+/1MCDS+DaE4KslIBK07
         1Q3l9j9PWEps+9V58AvrwoEQkEatjMo18o0q4vH/oNrY3OA3zz0MmJnjjLgI6i6vMoMP
         As0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851467; x=1727456267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPGcaGILxwhfTJ1AkidUV1js05svfUGNV2qC8S2ASMs=;
        b=MF6AxcDGkCSInnp9W6GYJ9d9dYQ6KlB+1FeD110ZzIzHZNZadRNQKSHeQ4oP3P1f8b
         QG/XjxLTdEoD13GHdGz5yvw9xhBIfGxdajybtCwyFdFynjXZ4sAIYHBXlHHDmPg9UbZZ
         IB3MVSuUATGsvoJFe/LQXTs9M45mROxKH1wTnZ/cbO9UHtFXDU0Wu2EBDX2lBWD73oCr
         hIGOYOokry9eTfxxJIAWqrgtqOb0Zrah07Ey9iZWCYAQTinPBFNBW5/Lue/hBPw7xC3l
         Y3tLob+e6Pw1ZDhklf2iAcegU9M9Dc+0geY4fHuL8fO4GSmWlPCjz0Hcd9MchQ8tgBrx
         NBJw==
X-Forwarded-Encrypted: i=1; AJvYcCWZTrbj8843OG6i/pelnbPJOhJSQ3NS5xiRoOnDrC48Vsdew3gnuy+Uk4Vw9mccRrmsG2sQcxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwahTUBK6qj8VE5RGGCC8p5lgxvGEsaqZFHexXnXId5z1ZXZGPZ
	uGOmsWp7lMoTnmNH3CU6frRhxcpNMV70jhVj3q8KYs4hnu7LAYtg29WEuw0kHcU=
X-Google-Smtp-Source: AGHT+IH47FhS6BitJFEObpSEKWNYV6OlALdb/YS1wlurIrhxIx0joR4JwIU0GtIJDWKAkg4lShG/Ig==
X-Received: by 2002:a05:600c:1e25:b0:42c:b6e4:e3ac with SMTP id 5b1f17b1804b1-42e7abe228fmr29196115e9.3.1726851465308;
        Fri, 20 Sep 2024 09:57:45 -0700 (PDT)
Received: from GHGHG14 ([2a09:bac5:50ca:432::6b:72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e464sm54855295e9.4.2024.09.20.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:57:44 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:57:30 +0100
From: Tiago Lam <tiagolam@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 1/3] ipv4: Run a reverse sk_lookup on sendmsg.
Message-ID: <Zu2pev10zUAEnbYm@GHGHG14>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-1-e721ea003d4c@cloudflare.com>
 <66eacb6317540_29b986294b5@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66eacb6317540_29b986294b5@willemb.c.googlers.com.notmuch>

On Wed, Sep 18, 2024 at 08:45:23AM -0400, Willem de Bruijn wrote:
> Tiago Lam wrote:
> > In order to check if egress traffic should be allowed through, we run a
> > reverse socket lookup (i.e. normal socket lookup with the src/dst
> > addresses and ports reversed) to check if the corresponding ingress
> > traffic is allowed in.
> 
> The subject and this description makes it sound that the change always
> runs a reverse sk_lookup on sendmsg.
> 
> It also focuses on the mechanism, rather than the purpose.
> 
> The feature here adds IP_ORIGDSTADDR as a way to respond from a
> user configured address. With the sk_lookup limited to this new
> special case, as a safety to allow it.
> 
> If I read this correctly, I suggest rewording the cover letter and
> commit to make this intent and behavior more explicit.
> 

I think that makes sense, given this is really about two things:
1. Allowing users to use IP_ORIGDSTADDR to set src address and/or port
on sendmsg();
2. When they do, allow for that return traffic to exit without any extra
configuration, thus limiting how users can take advantage of this new
functionality.

I've made a few changes which hopefully makes that clearer in v2, which
I'm sending shortly. Thanks for these suggestions!

Tiago.

