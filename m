Return-Path: <netdev+bounces-235929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0B6C373B1
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180711893EDE
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B19338F26;
	Wed,  5 Nov 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtm5i7Ve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF0336EF7
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365576; cv=none; b=KN/7LwOdiuR59MUw4wLHCfVgnlle1DgVplrKpuMwiXrxCljLG+4Mx6KigxdiWr2PjrEi3wWtubng4RkKqr9ttTZu9y+nMr9E6+C6/yoksYYfmSKEosXC+UL0A7mZuoXfQzzCwfvGxZdxdMRiwMGsYGSGu7gnBjdZ89EbsmCyTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365576; c=relaxed/simple;
	bh=Nnp1wDC3H73w3jI8NtJcSVR2N83rdAhx/dtATqrWYag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fv+wUZCB8DMtkjQApJpGVZvNLKKxjMvzqJVnNc1aGtT7bqtX+15DrKUT67ipoXGuGhrnUVmZiwVNJVoCTBTugHdaq3qhqWeg2WoX2B0rIHZH+kB/b/r/1+b2dSBWOu8CIOF/dy8c5WPqxgXX7AFQnXlQtf4uawy4tiMmfxGyrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtm5i7Ve; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-786a822e73aso521877b3.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762365574; x=1762970374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSHtYrMJfyWXNB5+D7qGmo5liVfUAPUmYconSQ05yJA=;
        b=Wtm5i7Vel6og71cIYNi68wga2ylq1eSG/Yhr/KPEnj+sHZCTbCPH/BDgN+LYIacV8L
         skAnPmPwk4Eq8LfFcNj/KAz3bxnQfryS83ZS8mxM/pRUehxODb3wQhjs1uRRVXtKD9e3
         8UNcK6mT7yf7agUTYTdUEWqrnLhOFsqKzwcsp01gtWEWpk5T3qEUz6nxByKQ0DJkpwK2
         d+LL5dDSB8eSgK36DMExPxtwDq2/GiG2e+8hNze0WH3Iats5Xv8ipySifO952J1Uf0Fm
         +EpbAKeOuGqhSpdNO9E7cZf1Pp7ocaGLOZzN4N6pu8letXaCjkrOYHWc/4egXZ00I1NQ
         nabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365574; x=1762970374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSHtYrMJfyWXNB5+D7qGmo5liVfUAPUmYconSQ05yJA=;
        b=lmTdnoNs87dCJZMwGn3h2H/gCChEJodw6ew/3BXy3lugOHlUyazJP8Le2dfeu2OE19
         CKNeeO7QPd2Zhqf0hY3ismaJJK7xarS5S2y1pR3drREplbyRDu6xik3JKk4rAXiqi7L1
         mLDNwuPE5zw0IO30m1hIi9IGQPom+2gl1quY4iBBQq4w+CZfQNdx85f+oW50lhUnStMR
         8QQ7xCTAmmXJwKch3jQdnh70sL2ucU1tZVxmlFc0nVZToaMMzfTK3ZpN5SfJW+TFDd9a
         1wj+5OkMy/gR+qhrJcIDXYzZbDzsbDQeYEx3MHqXy7zEOztiJI9aJtKQKaDfdyPVKOPW
         16PA==
X-Forwarded-Encrypted: i=1; AJvYcCWd1n1EtUU4rS/AzByxPU6I2t6TS7mYJMYVW6BVJIO1ag6GTEpbUC2/ygdNDm+jXQsp4gdgc+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3wKJAfWbQw192b5SqplVXU8heg1JT+mlccb4hAFaeXgTa6Bo
	E4tvuIRWX5P+OMmfM+SR/vIPOj+1I6S1CR0izPATu71UWfg1TMoHkVng
X-Gm-Gg: ASbGnctCZotIKAvuSM7nbwWBTEDGqREtI7BQK2IYXS8CgmPtlU5SLPrj9rx+sZL/M7L
	ilc69gVPqx507Whl4XXH58GzWnyzlM+khKqp3AKgzpmdjw6tSQWmU4FFYnZJK2s1UyKTK9mo38s
	P+sBCIi+tio6bGFCRPyS/oItMQ9A0f4mDtRkqdOrwYCyjH8ycNrrOaE5lMo483S5M5GSNP6NUjt
	J1TlnIQS9PMunEVqG9cOWoUsLxRg5KjEstmMMk5h10ezh9ORwcUX3M9AHIJ/8fnV8iKYVcwTVXq
	rqKXH1fdLK+R4hnDqToQa7flEA1Ds0r94KJmRuFCcsMfW+ZQ8wmf4em+2lV2ZgBrEcLoiV9B2IR
	WRqTK0ynvV90Lhl624vKQlroGb6NhVEtpsZhLfnAsLR0hRBWvE8Sz4ex7WKYIxwHXpoy4pB+K6q
	S9aCRHr7mZCu61n21Wj+H6QxB5NH0Y6WEC5NbF
X-Google-Smtp-Source: AGHT+IHHyTsN8YO880iJh6XJa9T07Q+L4vBMRDgiJVACQ1JdCPPRDqaW0LijeD633oiPcNo5B7xioA==
X-Received: by 2002:a05:690c:fc2:b0:787:1aba:3081 with SMTP id 00721157ae682-7871aba3718mr18241127b3.58.1762365573471;
        Wed, 05 Nov 2025 09:59:33 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13b6954sm735637b3.5.2025.11.05.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:59:32 -0800 (PST)
Date: Wed, 5 Nov 2025 09:59:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQuQg2bNj9NYNW6j@devvm11784.nha0.facebook.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQuKi535hyWMLBX4@mini-arch>

On Wed, Nov 05, 2025 at 09:34:03AM -0800, Stanislav Fomichev wrote:
> On 11/04, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> 
> [..]
> 
> > +Autorelease Control
> > +~~~~~~~~~~~~~~~~~~~
> 
> Have you considered an option to have this flag on the dmabuf binding
> itself? This will let us keep everything in ynl and not add a new socket
> option. I think also semantically, this is a property of the binding
> and not the socket? (not sure what's gonna happen if we have
> autorelease=on and autorelease=off sockets receiving to the same
> dmabuf)

This was our initial instinct too and was the implementation in the
prior version, but we opted for a socket-based property because it
simplifies backwards compatibility with multi-binding steering rules. In
this case, where bindings may have different autorelease settings, the
recv path would need to error out once any binding with different
autorelease value was detected, because the dont_need path doesn't have
any context to know if any specific token is part of the socket's xarray
(autorelease=on) or part of the binding->vec (autorelease=off).

At the socket level we can just prevent the mode switch by counting
outstanding references... to do this at the binding level, I think we
have to revert back to the ethtool approach we experimented with earlier
(trying to resolve steering rules to queues, and then check their
binding->autorelease values and make sure they are consistent).

This should work out off the box for mixed-modes, given then outstanding
ref rule.

Probably should add a test for specifically that...

Best,
Bobby

