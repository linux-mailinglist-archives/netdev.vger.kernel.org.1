Return-Path: <netdev+bounces-169807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111EAA45CA9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AFF189329E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658418CC10;
	Wed, 26 Feb 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npY29YdU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B51EDA19
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568099; cv=none; b=ahlkh9CAC9mhB+j1qX5G/0YSX6zrAXX+e5tBUSMozd+SdU+55DKx4VtWmsj9HyFfAvLb3vJSyuKBuZCibibkaZoeayI2GoODb2gQam03ZsjZhmAd8QRHpXFQTuFRhgeBAOtRoHdane3gFMQMiwVj6TBS0RrfDXveAbu3cgi4p0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568099; c=relaxed/simple;
	bh=VD0dMeBC/I9GMD7CKMy6vqdGqyqf7dbxUBWrLMvZWxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSvwggCq0KDrcjHXiT4FDLVq6JuDgX3JLetUcfl5vnmHNIrotjW8/ecVAYEOxn/UhG2QrVaTHaw+F0DfXHCncGqyqtohaaQGZ4MeSgFPNBI+4oYoptMm4a9GNzsISjP3IMvYNyYWqGEnGYeDNDjVwM2D/BP2GAP4exyPAnJ6z1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npY29YdU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso12087180a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740568095; x=1741172895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD0dMeBC/I9GMD7CKMy6vqdGqyqf7dbxUBWrLMvZWxU=;
        b=npY29YdUUSZa3yXDHj2LWylaOnpdNQjNdEz/N/HGvwarVXqfa5B6urbIZzrSgTSwd7
         642BBi8Zhx1CtXWtvT2TNkdpXPs3w8azt9wEawu+YoA+GixccoS3JskuC1LO2oBmbisE
         Ci8OzQh1RsEsGJKh5fjRoXUH/0YHZ4F9ZJ6ZjDj/oa/QcX0eLHOQRoQSbbmS77LYLMS2
         5OYWzonzQbZPu5yzbm1mm76S+2lnUVQMu5m00Hw0Rf8PbWPg3lZc+AwXH51ZMUJWuSxw
         2kQi5fsgvc6ugYCThOXS1Xo2+iKP+nBeAEwRiUWRafwo4y82yEATpe+d2rxSaOwwJygt
         3mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740568095; x=1741172895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD0dMeBC/I9GMD7CKMy6vqdGqyqf7dbxUBWrLMvZWxU=;
        b=n7qvFqnkG+fTvBYVnr9dOT0HJikxmvQsNcsGvGNgesDDjYxZ1+TW4D7osDFNgMw3gi
         803rmKXReo0BPOX3bwDK62r6fE3XecwZO3cKgW4KmgmbQOoffiwrcE38lfjOd1XSdOaf
         HYQKVNeimckzSmONdqpjOt5l1aU5NZuhn2PXfbDFwqttLBswkQG2fLKAHXVV9/NJl4FO
         3XK+NIipwDKvht8SOYFtH1y0EvMWxu7t3pNI7OzkNtZukVXafTuITZZ5LAta52gWIKK8
         Nun3On0/84RzmwaHGEFhrWjfTDFELTV553Z3/Roio/r1ICbp+a4oJSx5dl/Id16lWBOr
         k/ug==
X-Forwarded-Encrypted: i=1; AJvYcCVEMN/Zn4ULpl/EmGwbQApYERMc7KPSZ+awzjaY4sW7O52ZYx1lZN1FmAqFtvcLNWMhV3DtMlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+FpuYya62mYGWWGpPSPAbDPTorqoRJeDKLANvdhRidNByW82
	s7HeLYqAti3AKwa6BuZtUw1GzB4u72YU0RmKWIuY4uJxzcS8iNlnKDgb5V53OcEZrLp/7tOpbcx
	WslPhGy1zuCyRIpIDiTsE3X1rO5IYqK+BW7yV
X-Gm-Gg: ASbGncvNnesVm9+D60rVAixyBD0YFjTFQOe5IijPEH9vUAsIoFusBDid/gFOFCEsI0/
	sJhcBSjr9/mDNDAaCkjVOwGAm1Ae8nBNGqehIxEroM3o3PMxrkIKUMW7bmbbuUKBkcF+Ia4I/Bc
	DJoFz+Q90=
X-Google-Smtp-Source: AGHT+IFPq0T+oR1c3kjq/JIGDTCWmBxF4KwVj0bjFi0Qi5f6kg0dtajK7IpmVH89aVEC3ZlpS1FCxIvxr2+FKboBYus=
X-Received: by 2002:a05:6402:13d2:b0:5e0:8c55:532 with SMTP id
 4fb4d7f45d1cf-5e0b70bbee0mr20276697a12.4.1740568094458; Wed, 26 Feb 2025
 03:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-3-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 12:08:03 +0100
X-Gm-Features: AQ5f1JowQJVu8mo3Tj0fkBu1hsvXGJb5igqFWLzMLrPSJw42zY2UWWJ8Co4rtTs
Message-ID: <CANn89iKEQ2CqSdi4U5_91MU0pCsa+604U7pDFuZXEM7Rjw70zg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 02/12] ipv4: fib: Allocate fib_info_hash[] and
 fib_info_laddrhash[] by kvmalloc_array().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:24=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Both fib_info_hash[] and fib_info_laddrhash[] are hash tables for
> struct fib_info and are allocated by kvzmalloc() separately.
>
> Let's replace the two kvzmalloc() calls with kvmalloc_array() to
> remove the fib_info_laddrhash pointer later.
>
> Note that fib_info_hash_alloc() allocates a new hash table based on
> fib_info_hash_bits because we will remove fib_info_hash_size later.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

