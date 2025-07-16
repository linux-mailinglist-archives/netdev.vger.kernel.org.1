Return-Path: <netdev+bounces-207555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6E3B07C3E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D2A7A95A2
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6C28D841;
	Wed, 16 Jul 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcXdjxVo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4551A23A4
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687881; cv=none; b=MpyE1YVsAJuFhsepZQbCDvbbGytTYzIa4sTHAoG80Jtfu3VVgpXWiLXNNBULr/TNGiCGB8IxQ7KFV/rlaXAGfhzja2y69bI6fsfxQzkApTXE5rn+fhx1q8DHUdxkp0D5XgPlym/P8mURADkZRlzV81KH8n+iXMif4/a+YbvnEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687881; c=relaxed/simple;
	bh=+nZlHVyRlOpLVgfaEwi03iJ7OFeoWVPFCa2+cyphOAw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ix26gROVhdJZrjta+28TFJAtO8Nvj/gIVKQMNI7NPx4CaCWcMAJLN3LeYCwYthR5CMnu9czmXlx1qyImRia3FFpGlmM6oGoLVG8Q3NJJzUstjHHPwG1wTsuOTnbQk71ZTgAUtI3/MvCHwz5ybZBQ228t3nDYId/UDc+vRFz2Ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcXdjxVo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-712be7e034cso720857b3.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752687878; x=1753292678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjmmS59HWAcCB3A10A/ERe70cTXQb5RaP8XsNG2T2OM=;
        b=KcXdjxVof09D1FDUMQQ8bt5770aEyzUx/9F1Lpeg6b9YZRy1JBcGPfBPjLAyLzGlIl
         MRsDQa9t/i/FZg8SEfrYgv4hPs5CY5+zm+ww5qAu8/g+y9N+GGCRcxb6b7zO0tl3kAmt
         vhdW32DUqWHzZSEmH3hFEn6w8bUMgYM8/yIvdbAYTbRwcQFJzG1rfgoUmVMIQb3mz4CR
         8C2WY7nwum401L0Df1/X8HfOskZbIhE2e0geulgRL39Ls3LaN5UZY8nu1+WRa+6/HnW1
         2+xL1O+TJWEo0BR2C0KpGc8FF+2m4d0TcjnyaVWZxGn6iXndpzN6+4HMfFwvjyaQeUkz
         VXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687878; x=1753292678;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wjmmS59HWAcCB3A10A/ERe70cTXQb5RaP8XsNG2T2OM=;
        b=jZEQWIZB7TL4LTugIE/nA7C1Pquyss64M2gseshXd3bQUtQl3uXMGbmZi1pQEK0Hmp
         BJg4WO1N7QaOoqqqnVqf2UB/z2iS6U44lEhsun225KkEdNXxCH6ufON4MNCqYWEm6uPN
         wKUDusybEikICxiDHt79VRNGVSod2z4qrX3iT4GGM7yjMj3UFp1HDVXmqv6EsvqCLfen
         MOm54p4eK8HVHdJQYB6feS0P1Op6yEho91xUc3sMhXa/S8fPWJyj21FKX8YCvPCZr0aj
         6lDwYuF1Q2GLwpDyJV6F6oQkjYGbQmNUNljXLdacH6dBD6TXoLrFq8vmLc3pVF5DnFAo
         PGWg==
X-Forwarded-Encrypted: i=1; AJvYcCVqKFnpB71XVTpcN/Xe7qdCNR5P4sJ54LxapUfFegMpkQBF8y6wcNVPd/jAGwZ4K8c88wEDHYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjH5/vjOBEd6IgB5Eu4Nfi2elQzhNwmWm3QkeGGqTZD9BvK8uM
	DxQTjRwvyfgbFt3qpLAJLa/ThuBWMZImw8LzQMw8+TYnxIxvrT6Uwgzy
X-Gm-Gg: ASbGncvbB+oIy+UKXsf5Ol8+j0DY3+s5Va/TNhfWvwZUONkKGhIfVADKDcof1AUqJLy
	PeVK0AFcrAT+d9etcEBBfZ+y0oLL4OgM8RfKxVk6S/jj6CeI2j+voc0EuOt0CvSHsCxZ7nEtwLt
	gsB3W86s/Y4ksn91BzyVkXKKmrR5UwAe4VYeHI4vugQr0yDgdQhY24WBSHfDru/QDVVw85iu8D/
	3kKmU9MUwiTNZvHileC9vis2X2gPRe+IxPbt8mV2mic7Jmus9b2yO6Kbv3nqzl/U5vMmDSfLWZk
	IPxv/c/UuuaNAMiZIme/t2wCM+tXGVfYuydpnovkw2y789wlj3yzm0fj28yNYX2DYnt+goSPAha
	hMtIK0ssTOkp/TxQsS5M5uziv7aXHbohFpVdrGruqnwMCk2IvNQaUcQ+wm2EIHt1j6zZtaQ==
X-Google-Smtp-Source: AGHT+IFu8r8TbVBvCW3j1B3C881CBhXCrUPzlUR88TjC0q1nHrXCdzbCyAT0ke4qS91jrr/Bc/QN+Q==
X-Received: by 2002:a05:690c:7206:b0:70c:d322:8587 with SMTP id 00721157ae682-71836ca9a62mr47842817b3.6.1752687878389;
        Wed, 16 Jul 2025 10:44:38 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717d55df771sm27338687b3.101.2025.07.16.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:44:37 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:44:37 -0400
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
Message-ID: <6877e5055ff59_796ff2941b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250716144551.3646755-11-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
 <20250716144551.3646755-11-daniel.zahka@gmail.com>
Subject: Re: [PATCH net-next v4 10/19] psp: track generations of device key
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
> From: Jakub Kicinski <kuba@kernel.org>
> 
> There is a (somewhat theoretical in absence of multi-host support)
> possibility that another entity will rotate the key and we won't
> know. This may lead to accepting packets with matching SPI but
> which used different crypto keys than we expected.
> 
> The PSP Architecture specification mentions that an implementation
> should track master key generation when master keys are managed by the
> NIC. Some PSP implementations may opt to include this key generation
> state in decryption metadata each time a master key is used to decrypt
> a packet. If that is the case, that key generation counter can also be
> used when policy checking a decrypted skb against a psp_assoc. This is
> an optional feature that is not explicitly part of the PSP spec, but
> can provide additional security in the case where an attacker may have
> the ability to force key rotations faster than rekeying can occur.

Nit: consistently use device key rather than master key.
 
> Since we're tracking "key generations" more explicitly now,
> maintain different lists for associations from different generations.
> This way we can catch stale associations (the user space should
> listen to rotation notifications and change the keys).
> 
> Drivers can "opt out" of generation tracking by setting
> the generation value to 0.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

