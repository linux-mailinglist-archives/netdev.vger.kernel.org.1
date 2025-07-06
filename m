Return-Path: <netdev+bounces-204437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBBAFA6A3
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670903A799A
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E12877F8;
	Sun,  6 Jul 2025 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR1Tdxry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB32CA5A
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751821161; cv=none; b=aVQ89AWaEdeUS1XaPneMv5nhrF2jXLSuiSym9ppMCUDgMMYNH1fFdQexsA9VxCSd+g3G5yulR0GR8Loq443bXhtm5WZCH5kqqvfN3ygCArKLp9Xt4GiZqK4JES+tQ8m6DQLWcjRvvHrrTJkUjFyVIjQV32ixqFrJrGBXB9UyYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751821161; c=relaxed/simple;
	bh=o3OHbTrywpt2wmG619V1Daiwvw3BPA/R0ICXjKqil/c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fUOkvDMkm3NUnCSK+RMEiUmcXqXx1FCpxtVDTibKQTlsT7JvgQ70uGQ6e2Dx0DahSo7CdfTEriJAD1qANaTtwigq4KtOxnYEIRI4QqS1QsQ4AJ4pQl/yZ7mJyoAZ8TXwar6h20yRgAJi5S79GWtJ2kFa1hG57TtrTkcHwWuZLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR1Tdxry; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e812fc35985so1858436276.0
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751821158; x=1752425958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFuAhTHSXEyBAQeB1NqXJ8jA6SW8FReWXvFqUQzzxf8=;
        b=PR1TdxryB6yKg36DBjGX9P9PN9F2fo/noIqoYLVJQlv/RR2VhXzltCitFFYU5H3rWo
         NYEw/uJtbc9zvs6ptmmhBp6qmmHRGv9v7KT+6N786OLB2M2GA0EW6uQkYXKWXaRAZ7JR
         kymgn96yJMDGowPtTAbcEv+rNMntzFKo7TxmUGSAeLIVa/205ad4t318GZ8OZGrMg3pq
         NYKtcDIeZv/l02PKWHn9QBbbp53PKhy+P+2/tvfumDVLnIrIxONs039EtbWx/KiN9RPi
         QfnjLuDytXzGykPhBjVB6A5f2M99wAY57h7p1F12Yw0SGF5jQA7dVunpsxzyTgSwERvv
         ppug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751821158; x=1752425958;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFuAhTHSXEyBAQeB1NqXJ8jA6SW8FReWXvFqUQzzxf8=;
        b=qA9ljl1mjIAaTIGYzOiAFUkBsKcvubN8O6jjzIBOxcDXoDEOXAf4L4S6Lf5ISZYZVZ
         Ssp16MFAmexAFQ/+yHOFcZII7xpFc2Hrwf4cESULpb9yHAFmRNq2Vxor26JBrxe/UQ6V
         aSzxsj1TrALF+onv+SGh7EgoluhwK0FOQH+JvTF0m7MBQoyncQ8M96aWRhaHw3mZ3h2l
         UODbTN5R5Qp41zw+9cI+BYEQIB6h9zmokZSf/Zm9l1Vrqu7XKtu8m+Pcag4N1HDADdf7
         oVtgLG0QXL6zf1x9c57Fw9BZ8hxi14UzaA2oeFHvizjRRAqicCFvA6tEHRsk+6Wuht7j
         oRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr4IjZH2nDf7VQxMf3brWov7rq6Xp5C2FWCckaNV2WT2rihCb6GnDUrcQhdda3EtWVzJ9gG+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeS/NqSRlRC2cjbsgdhfVo3t/f55Xgpe8EdIYD2eYjE7rYv072
	QS7xA9RH+Fqcd1rZuYpVfri3yuIo/8KU6LWgbd8foNACFPtr25aKVpwt
X-Gm-Gg: ASbGncvLnD+Q6g1FBhUKgkYRhXnZusBNPlLCrPqxuT246AMS7BtSpAU6KsBpc/p208w
	7pQbZSeQ059DZaH5Hmwj3fY/v21rEWpmNNkJTIjJHmavwWyb+KamPfshyJaCLr8n12ZoakuWxnz
	dJu671oHPB0j0/wOHiGUbkVY3jyitBPc+g7cr0+c02Uk8Yka9Da+GoRiz0xzqVdt+tH0WidRqqS
	B8mjkxJLDrbUy/S6dqXrRu85Kaf7AFVvouTvEosJw/uJT9cSTcCXUlMy+ChjA7lk4QGbiQ2Kcql
	5krfIGrTdXNvh7YKGVv9hjQhsUNgQY2FDSeKArLCOz2u/B8FYh5oV0OIg/aTcmtrqaKl+aU+0QZ
	4t3A44a8f+VnR7IKi8vJn2Qa544Ga56BGWt5wyig=
X-Google-Smtp-Source: AGHT+IFgUCvidf6kqJCWUbgPSKLONI5jNnPohGdZvWPB5uhR4vamZYCxkYsiAXMNVFsjx/AjAI/Bwg==
X-Received: by 2002:a05:6902:e0f:b0:e7d:a332:2e9b with SMTP id 3f1490d57ef6-e8b3cd94023mr6275693276.43.1751821157791;
        Sun, 06 Jul 2025 09:59:17 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71665b123fbsm12740257b3.88.2025.07.06.09.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 09:59:17 -0700 (PDT)
Date: Sun, 06 Jul 2025 12:59:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686aab64d9574_3ad0f329473@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-14-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-14-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 13/19] psp: provide encapsulation helper for drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Raed Salem <raeds@nvidia.com>
> 
> Create a new function psp_encapsulate(), which takes a TCP packet and
> PSP encapsulates it according to the "Transport Mode Packet Format"
> section of the PSP Architecture Specification.
> 
> psp_encapsulate() does not push a PSP trailer onto the skb. Only IPv6
> is supported. Virtualization cookie is not included.
> 
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for moving these helpers out of the driver.

