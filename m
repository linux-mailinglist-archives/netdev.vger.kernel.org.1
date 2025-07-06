Return-Path: <netdev+bounces-204432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E92FAFA674
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 18:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DE6189863C
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06C2874FF;
	Sun,  6 Jul 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Y7k8A/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B8214A8B
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818828; cv=none; b=NSq+6JqYttgZadMixqgUeR1ZGpjTl8b3gOHiik1JJGcX5LGM3jvAtXOM9d4TpRw69HRc0cCKY6gp9lpoOmQvtEMxSInkYBnlTwOAe5hRfWARUwmpnW9kdzx4aM99JbVhgvj4p2JK96y0jyyOIsFie9HuBfo6Ivt0ZKGXxm8eM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818828; c=relaxed/simple;
	bh=N9tmCNkXvSGFfE7ObaN9tb68DsnLBu64yblPk0y9ROI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=t9uWXqfTczstx4KlY5g6kTpq1bxoS4K82ev2dmI3GzG7Z1/kaPDKwwlf4pqhjrJ+vy2xfFeRrUsksf+8O+KRbsv1IkWZET+i5UhmIJU/J2pghI077tNsgsxatCjukj9H0vWIpD7SMMoq9PUmwtfEmNl3yXRikpUf9JwVIEe4meY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Y7k8A/; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e740a09eae0so2260697276.1
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751818826; x=1752423626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeJ2IuXTTx7sBuXKVlMzDouSQgA6Pp1xhgnQiIRmhWo=;
        b=f8Y7k8A/2ny4sXu1y/p725lBIYGPe9rNtl7bWpcnB9kOuZQqepmKpn1E/ubgGf7gHu
         VZArBKFMr2n7SzGmXqBsmD5T/I4lHaAgMxAh5SoQdd21pabfwu25VIICPQyix3vZOLv0
         zbzP6rXVCXNEJk1HjnNvTz/7gUuqBf3M2rtYYbGFJlxqBXKoXHOHmWSwFxRw19QrBL9z
         ohwS0EoPfQkz7wNwdxShgesuoO1SAXrI1wjtLp0ci34TLhKHDjsLsF4We0M/8RnvGatS
         rVwuZugB0y4ow1zXo70IR8pweg7+j87w24V6zsTutWyd2fVtUoJjzA980ssFAAPxJEyz
         gdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751818826; x=1752423626;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yeJ2IuXTTx7sBuXKVlMzDouSQgA6Pp1xhgnQiIRmhWo=;
        b=sBK//wQhcmu1Oc2Ob2CnN1erVxLGF2KYmLOZVy0d5jq2Ay8+apqbFtHaHahaxgxoEG
         lJUY+DwvyGWFmU2lDPQ/qWkEajru/7law7hboAfGFi0txSVmyTyY+LOfy+pJLDpF1ST4
         Kt77wdpwCpmTdFuKAQp6V2F7nm1/IlI2r1/sEyHmM5fkOBAGRzMd6kFHtMzma5kzLKYw
         6dTDXGW0GLYSMZfZ+ISDvSaA/2+M5qx3IAYH/7fgyOoNeoB0y1OvAoGM0irC7mNikCPi
         ipLklrXZ7xcAs2wTs/RKP/o3t4ZHwNANVsdbk64PQ3OsIolNVaimxWbUagowE7Oua4iw
         9AsA==
X-Forwarded-Encrypted: i=1; AJvYcCX8aHadILneuHf0bbOz2LSSBkGGUl6d0POnYXHFzxQVG1tO57vcghe00paIYc1XYXHVCNp5v7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3XfIXcGfezn9N+Zs9Mtx+DGi/qD8ni8zYbwl1u+whIMaXQp7
	noT5KTsX6h9Cll2oFZQtq275z7t1RrkicAKK/7z6CFpmelaaE2c66P0V
X-Gm-Gg: ASbGncuxTEpw7rsKqF5w5oIm4W5XYfwlJWE0KYDXch65qkWXtpja5cmGkrv7dQX4ZT2
	GytQmkyiQ6h9DB+NlItrg5dT8zdL9e3eTLYMB6kMNZ6Ef0+hmf3T7F3pJkcmNgglmY6QjpnS8IN
	IAOR2BSaqHtP76usdpcxAJowjJ0NuW+y9p+cgFQzWfHZ/2JNf+DGvMeKrqWLuIUnQSR7KFdUypL
	3B94w0+Ye/fq1FGdfB30ArbZMSCOE0HZyU3b6o6/+hi80AoED/oEKKhfwsYtAo4Y2uoKun2f2ah
	5UIDX3kFT4QAkroc7nEVfl6ygK825irTq55NSoFd8LOrufNeV0DrvMcMgB4ITxSf3AYvQJGS2Gb
	xGKZP3xnvEJdpNydtZ6q6uwZBh0+JVHwLNQMUViOLnh8MIO+eJQ==
X-Google-Smtp-Source: AGHT+IGhMSkOCWQh5jJjJ+cI/Cyl0AMrrrCGnNKZHKekpiARh/HhVDpzl3k9VuzNJOBDnVqTO9NIxw==
X-Received: by 2002:a05:690c:4a05:b0:711:406f:7735 with SMTP id 00721157ae682-7176c9f94c5mr76353527b3.13.1751818825751;
        Sun, 06 Jul 2025 09:20:25 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-716659a1457sm12633477b3.37.2025.07.06.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 09:20:25 -0700 (PDT)
Date: Sun, 06 Jul 2025 12:20:24 -0400
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
Message-ID: <686aa248a1221_3ad0f32949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-7-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-7-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 06/19] net: move sk_validate_xmit_skb() to
 net/core/dev.c
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
> Move definition of sk_validate_xmit_skb() from net/core/sock.c to
> net/core/dev.c.
> 
> This change is in preparation of the next patch, where
> sk_validate_xmit_skb() will need to cast sk to a tcp_timewait_sock *,
> and access member fields. Including linux/tcp.h from linux/sock.h
> creates a circular dependency, and dev.c is the only current call site
> of this function.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

