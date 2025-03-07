Return-Path: <netdev+bounces-173077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F655A57197
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F693B203A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC8E24DFEF;
	Fri,  7 Mar 2025 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Rju62Nju"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E023C8A9
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375479; cv=none; b=nSKQvWMnVfAdtUyxeav55AQ0f0r5ZnQQKukgujRmxqEPzImW+/4d7Aqk0wj30QFB6arSIKjsyrvxfXhUWDjtLHfo8S2KdPLb9u38hc/GvCGi/bSA/oLwLHpYhitbUm45S/OLJ1jQqbJ/qBxxjS0jn5mfZmQdOe5hVPn4aMYTVmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375479; c=relaxed/simple;
	bh=Nh8FuSCsDNCgQv/WzLGLX0QOiW91jiRbxLqdMiQdM4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cQZ2O6mdfb5vOX4PQFvH4h7CDJsN6uOzS1E/AvfXSFcOf/E2UuNKvIWrjrT6i2ii4XwWnc0s88AwzhmovfRVyv2TPkqvLlS3uawROCmMGxitJesjf3bdA6yedaw8IUP9Wsm+SwctY6TTNhCvlO0Sd9LJtg7WFQ7fx0AOXKnAZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Rju62Nju; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so2264287a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1741375476; x=1741980276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elJjC7XhaAoKr1/VXQvxxq2r3oqH0BcFTXEZ/OU6xA4=;
        b=Rju62Nju5vwKN3BSzEFtdFI5l8KrG1RLHfuyYy7e6/Dq3dDVVnmHq7QTQku0xRi4bi
         62VFm96Ev8MG+sGIBlCF0Ak+aXg5q2M7Z7MdJGvn1MEWt5AZUykdtaNyF8d9VsFiU9Ib
         OCicBIapUmLrQYg5X8uatj7Dqn1xRAlpThVpArtWUesIyJBSror1U7I88raABNsYXMLz
         xxjb4BLAT55W2lYGHpZlQplDUXy9o/gHewqH8CtV1jwQCdhe0Lu6A9wMEeIKgqz7GXHm
         9/HpIe9oxRSd0c4iO3QgZE57zQOmeKPLftBToTuZBi8iD477IGdjQKRq5A2xrvyQBLhX
         X77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741375476; x=1741980276;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elJjC7XhaAoKr1/VXQvxxq2r3oqH0BcFTXEZ/OU6xA4=;
        b=ZsP0NYlAob5lF3Botw9AaFFCxT+aRrh7iys477bsO57cVyelOt2HW/UlZvK2m/YG5c
         MLcjqA9Gk8sEB86wuaZ7tQnOscTpbCYBuiI02ktx4Uf0WCXJzp8i6/PuKBP4Nazug4Hz
         jqTOd/8QP0TA5ccH0NN8qdPQzffkzYPuJ2CTv1Fr5N1fc0JAjbx7DAimqXu82fzeZuVw
         0WDHWb2HfcPRPRKmOrJ3ICegGYqNk8vMW7NrD4hWSeQH3zc7RmJkxc6t2A9mmel0k6ls
         SgP3CeIE/9MA0qRSnv0zsQLPBk0kbLJ0o5rugngvnZPXn3kqrrEsPK5IuWOsgVX5mzmt
         iq+g==
X-Gm-Message-State: AOJu0YwQejjZhwIBBUu8FlNxHKZzlKZpQs3rKHzsDB/tqW4N3bwZ/aU/
	jC/bXYG+W3cO+m+p0VTfb9f60JsQ4SktQNYuRWHL8ZUSXLNWZaIKn38bvOqEeCc=
X-Gm-Gg: ASbGncsFs8k9Xs1PpwmX8cQWkcJIX7WLgH07r1hkHluUA8V9ygLREBJXefuMekdSSf6
	HBihlTsK+kSPt2QPYa/nv8NaQmGqHNTCxjH3OdgqiQF2FkmyLqoaBb3HeiTlwgRFqfusPltsEac
	FbuAeFFlzYAu1qRh3YA6y/L2jubkG/7t61bFxZkCf+AkE2y3+sD0lDNaFtMYnng/1klNAg25sO+
	8g3QwhA5Do/1MlpOT5MJIZzYS9bhqbvD9bBZS3DtjuvwzjbdysHSE94pSe8g0N9v8uy4H+hRNFL
	h8tpbmaX76fdpVGKJfdkuEPgoHW2y6o8OKuU
X-Google-Smtp-Source: AGHT+IFRfylYQ/Fx9CF/Iex4/Bn8EnqFc8LDfBBSlSEpbtFvWJz6Jq1FEsmqYlH/Nq92rj5kd34cAA==
X-Received: by 2002:a05:6402:34c7:b0:5e5:bbd5:6766 with SMTP id 4fb4d7f45d1cf-5e5e22a871bmr6157413a12.6.1741375475596;
        Fri, 07 Mar 2025 11:24:35 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506a:2dc::49:1a1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768ef30sm2906814a12.69.2025.03.07.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:24:33 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: arthur@arthurfabre.com
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  hawk@kernel.org,
  yan@cloudflare.com,  jbrandeburg@cloudflare.com,  thoiland@redhat.com,
  lbiancon@redhat.com,  Arthur Fabre <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 01/20] trait: limited KV store for packet
 metadata
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-1-d0ecfb869797@cloudflare.com>
	(arthur@arthurfabre.com's message of "Wed, 05 Mar 2025 15:31:58
	+0100")
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
	<20250305-afabre-traits-010-rfc2-v1-1-d0ecfb869797@cloudflare.com>
Date: Fri, 07 Mar 2025 20:24:31 +0100
Message-ID: <87o6ycr6ds.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 03:31 PM +01, arthur@arthurfabre.com wrote:
> From: Arthur Fabre <afabre@cloudflare.com>
>
> A (very limited) KV store to support storing KVs in the packet headroom,
> with:
> - 64 keys (0-63).
> - 2, 4 or 8 byte values.
> - O(1) lookup
> - O(n) insertion
> - A fixed 16 byte header.
>
> Values are stored ordered by key, immediately following the fixed
> header.
>
> This could be extended in the future, for now it implements the smallest
> possible API. The API intentionally uses u64 keys to not impose
> restrictions on the implementation in the future.
>
> I picked 2=C2=B8 4, and 8 bytes arbitrarily. We could also support 0 sized
> values for use as flags.
> A 16 byte value could be useful to store UUIDs and IPv6 addresses.
> If we want more than 3 sizes, we can add a word to the header (for a
> total of 24 bytes) to support 7 sizes.
>
> We could also allow users to set several consecutive keys in one
> trait_set() call to support storing larger values.
>
> Implemented in the header file so functions are always inlinable.
>
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> ---

[...]

> +/**
> + * trait_get() - Get a trait key.
> + * @traits: Start of trait store area.
> + * @key: The key to get.
> + * @val: Where to put stored value.
> + * @val_len: The length of val.
> + *
> + * Return:
> + * * %>0      - Actual size of value.
> + * * %-EINVAL - Key or length invalid.
> + * * %-ENOENT - Key has not been set with trait_set() previously.
> + * * %-ENOSPC - Val is not big enough to hold stored value.
> + */
> +static __always_inline
> +int trait_get(void *traits, u64 key, void *val, u64 val_len)

Hmm. I think that passing void *val will bite us on big endian.
Seems I can't pass an u64 * if you don't know the value size up front.
For values under 8 bytes I would end up with bytes shifted to the left.
No?

Take u64 *val instead and copy it in at the right offset?

> +{
> +	if (!__trait_valid_key(key))
> +		return -EINVAL;
> +
> +	struct __trait_hdr h =3D *(struct __trait_hdr *)traits;
> +
> +	/* Check key is set */
> +	if (!((h.high & (1ull << key)) || (h.low & (1ull << key))))
> +		return -ENOENT;
> +
> +	/* Offset of value of this key */
> +	int off =3D __trait_offset(h, key);
> +
> +	/* Figure out our length */
> +	int real_len =3D __trait_total_length(__trait_and(h, (1ull << key)));
> +
> +	if (real_len > val_len)
> +		return -ENOSPC;
> +
> +	memcpy(val, traits + off, real_len);
> +	return real_len;
> +}

