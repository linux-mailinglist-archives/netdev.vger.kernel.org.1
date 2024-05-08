Return-Path: <netdev+bounces-94613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047278BFFF5
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991631F20EEB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD867BB0F;
	Wed,  8 May 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp3JNL2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575085623
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178506; cv=none; b=iCT/6ihX25TVQ4GKRbN13evicFNM4ELtXGscQwfJBZCnmJ5+H2jcqe81veD3XOoaC2jOboUvsN6WMoXfsPqxhRXPugMnGHQccQaackMWNVd3GcBub6w3ySz2RZmMs001n+FTZITi84vPcWofmgs5iViKSOagdRW3noV9oyO8Xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178506; c=relaxed/simple;
	bh=pwy+5RPfqdQKGwK2C4bKTqZPts5V7+o60GajYmNu7IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur1LCmGdVUmv+Gy+Exx+b8BVURa//JuOMplyAYIB1e+0bWTYlLVc2DB9Tcy+LLgt5lb1qz7cge078JcbB2HZ3Hou1ZFvZv2sPhjSQbyg2pRhG/VkI8CntvaTYLAIXyzDZ+8Kvd47r1kmE0PK7hMykBvO+0NrkNAf/2LqrlXBvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp3JNL2n; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-61c4ebd0c99so2926277a12.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715178504; x=1715783304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1yvFztPfniAN52zQBePbOK+0+9oPI/qB0Y8uL9YqFQ=;
        b=jp3JNL2nckf3Bye5mihLFV41kM3jvt/XFFWAeKvO47AravYjEf1l1/MM0mVeXv3UBu
         wjN++m9Jj+7sD4B2YZeHp9JOa/tmGq4IGmWWZUotWrxfpEG0xUMaasnUKFw1QuELtjek
         LaG5P8drPTTh+JRKIJtzxSmXT6bfrWz1MuGNqI8lWkQ4iZ6RDZfCUc8Cm1tMSInkRt5A
         a1mJJiqQqbH5Q9LRZyQMgHtGqynCrFpsZ/p14AbkI28vb4P1XtWsxtehP4HiE1AziOWT
         SUByxxkVozlm4osBRC8PnN+m7PeXAIRQ04Dwm/SY1j6GgEhiMJtinT5q1GqfSleVrJkP
         iauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178504; x=1715783304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1yvFztPfniAN52zQBePbOK+0+9oPI/qB0Y8uL9YqFQ=;
        b=ca/RIcR0a6scv3B3dg4kWBoWdrT7IaGAPMu5AyKfw4weEsmsQ5gOeYA8DpeiPC49Wy
         2LQt2Q4Gn/pqzI3UY6JnUTZ86bYnXxP7Y+a9MR0YHAjranwy+RRNL3H/H0PPlXU9hBLz
         hPhVe7q3paeCIbTPblXq1MIVzp0IU/QmbAwss+8GIFHBMeoCMnTCA0jxSgtt1nlHgRjZ
         DVgjt+5Os4xZWcM2au5EDnIwMHbgDlhda0u0dtnJjtsybdehtJmasmf3wRKT8asKm43N
         5pLCVeBmJH5a5wOqZ5W5zqtgY9xKrWrjZjCbISqJB/g9bqrVH+WhgpFk5tHHOtA9RX5g
         byGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWysQmPQAlg29nnHke7HzjVYvHowDksUuJZpq5DOGf31NImBKlWLDZsL9RLG+bke2cStgl5ORfpkvt/tUl/aiu0yvMiuHxX
X-Gm-Message-State: AOJu0Yz1bpIvca4BN18SEs8AyjzL74Yf0uYBY4emxiaXUSsQTuFNZ+uy
	G49yMX07wBc/7l2XLqEKR7RlmZdoyF9c/OuDSuPzSazzn3CFfMPj
X-Google-Smtp-Source: AGHT+IEWEsUd9TAN0wImPGKdkM+MTE2cVi+NE5qDYCbHVs3jjON7tro93WdGxjmiRlJsOmNjYokWxw==
X-Received: by 2002:a17:902:b085:b0:1e5:a025:12f9 with SMTP id d9443c01a7336-1eeb03a1fbfmr28983885ad.28.1715178504080;
        Wed, 08 May 2024 07:28:24 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kj6-20020a17090306c600b001ec48815491sm11917278plb.101.2024.05.08.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 07:28:23 -0700 (PDT)
Date: Wed, 8 May 2024 22:28:19 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: kovalev@altlinux.org
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCHv2 net] ipv6: sr: fix invalid unregister error path
Message-ID: <ZjuMA8Aj5TfsPq77@Laptop-X1>
References: <20240508025502.3928296-1-liuhangbin@gmail.com>
 <20240508094053.GA1738122@kernel.org>
 <f6bb076d-bdea-a31f-0086-054f597fcc60@basealt.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6bb076d-bdea-a31f-0086-054f597fcc60@basealt.ru>

On Wed, May 08, 2024 at 03:04:36PM +0300, kovalev@altlinux.org wrote:
> Hi,
> 
> 08.05.2024 12:40, Simon Horman wrote:
> > On Wed, May 08, 2024 at 10:55:02AM +0800, Hangbin Liu wrote:
> 
> > > Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-deref")
> > 
> > I agree that the current manifestation of the first problem
> > was introduced. But didn't a very similar problem exist before then?
> > I suspect the fixes tag should refer to an earlier commit.
> > 
> Indeed, the invalid unregister error path was introduced by commit
> 46738b1317e1 ("ipv6: sr: add option to control lwtunnel support"),
> and the mentioned 5559cea2d5aa commit replaced one function with another in
> this error path.

Thanks for your checking :)

Hangbin

