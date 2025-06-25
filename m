Return-Path: <netdev+bounces-201361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE015AE92E0
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004B57A9BD3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6C1DE3A4;
	Wed, 25 Jun 2025 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbX0fr0N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A362F1FC1
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750894941; cv=none; b=C38VzbHL4TCgKWsFtKStCCBQ0V5VTm1otxb/TDEHqlCGN2wa8blUzRL15wvc/JEjxpwZNMXj9Hrd0fSwLtCGCt9AZ92IfRwl8pGEfv+3oPruLpcqBlE/0kkENJBBFssid9WMmXWzVaOMuJEKlw6EmI5oq7JXRVIkkOER+NXxBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750894941; c=relaxed/simple;
	bh=4MJWEwlVa2XSjR1/iN+J5fggdrOptEEij0S55etnOzw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UjEoAEpP8e/Wjutrq2JW7I1uCEKk5jKsOT/PkHaV4r2jBVxn8Ncs096H+RX7APLzYhXnAgSe8JckKkCWBdrvyfxpLo6Y7EBPZNEM8Xc8ToGx6SudRLI3CbEZJMpADvq25oCKeGwa5eH4wnfYDpFST/wt5e9lcCzk5KhbJC7ofOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbX0fr0N; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-714078015edso4430167b3.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750894938; x=1751499738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QIIxBIzrLJJuUFEqMZKCtT6UF+HcotLDkX3Ye0kx/8=;
        b=MbX0fr0NF6z0MBD4XmVOw82KSAGIW9Q9pXRfHKkmVEpzD4Z8115MmO1eY9gPWjDVmM
         NqwL0+K7vxCq9RpwKTUupySmx128KYfafyHNVPt5JHS4HTt1Pa35lrXMCMgvE5Zvc2lx
         CPJ4uh7dIM1Zlen01UgapQ0pSOOi281aspQ0mED8b5IB0IPK9ZrciLtMpHDwCa+3/KwU
         YjQrXsCx31OLrV8eeFpa3BGsuX4KU3B28brAvjKS9oj6USvdzLtdCkd4caXf2Ezj6wmL
         i4yJfvzZozNAxkmICsCwiuLfIzjdYKbbnqUAHlTt0tRsCvbJW8U+Ws6NlW6bALsED/Ri
         GCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750894938; x=1751499738;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4QIIxBIzrLJJuUFEqMZKCtT6UF+HcotLDkX3Ye0kx/8=;
        b=vtyZW06FBMZWGjB7FifP5V5PY1uz5XhTfZiedKsjz+ZgdDx+LjC1kTLK4VUUA5pCc+
         Jj0ASDPxpJgPt1zvaVXKQ0TyOlj80wQV3m7Pjz83SSdpRCXz0gN4NhoV8L+9JSMYHkp4
         Vcr4FwTO0+3wokpnY0KUe7riDlnOdCO9Pba6pVHEv+RNcioJb8K8sNnA6Qz0s9rOVMek
         MvKLZ0Ol9YEViuK2aWc1tTiC1n0TRPIdKqJ0ZTYPlKvHvQ4oGx5B8mnJAo9KVPr/trJk
         CwYVVcMWRclgczIgzC6zTNK+I3s85DMgMdEymxASMTkVqbchaH3Hcw68nmX6Y6KhWBu+
         2KwA==
X-Forwarded-Encrypted: i=1; AJvYcCUYukEDBv+lCqzXNcCeHzbWkhNQUy2hA1+979qgSyRjspKU1/ZZ4vjU0IG1X8AHJKtNtPf06rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBN1n2xebZFAAAdYBhGgUIHAIJHnCUEjm5hCsiUqgjdsHG4zI
	80N9PSfoQ5nfiFSdxO68B1bcqgpJnjA7EX7uPj/gO1twrtdn5darP7n1
X-Gm-Gg: ASbGncsLr7jp4Dc4HutAwQWbOi/ERdkrbqDuZCPYv60QDi6fwszE/jJpLVwS4reTjgd
	B/ag0N15w6wpUPZCX8gKiPKCSDA+4NeqEUjoKKpNjCcT5L3Lz/wjbcAuAqZA/20pR8iOfmQKmsj
	rjSyNb6C7kajoJc4EmAWP2Wof6btzOChV17Kka607uxVBZ+qY3pRz57m8GenT3gPwj0APtzeqmZ
	co7bqOzPDxVd8bOPyVUKhrpZJxeNiL09NHudc0pajx8JZgJDQ6l8Ba+bZW0qEr18+pHDf6V/XSv
	nBkvrf5yaVHL3CbxXWN2TOnd8G3SAUlGmLtxQ91cJWJvIToOYSAnoZA/yoP+0TeHoJF5nFIRU2X
	CsY3eihj8reuDyQEOm4jRDHbAmTWaLA6oarLbaDDKAOtGH49XSocy
X-Google-Smtp-Source: AGHT+IHMS93zEcgDbO16JhfYMk0EzRzI2W5lavq2Dw3cpU3nrd8yxiGUxo+kL4vtUgszWTtKPVhMPw==
X-Received: by 2002:a05:690c:998e:b0:710:d81a:b345 with SMTP id 00721157ae682-71406ddf009mr69781897b3.29.1750894938511;
        Wed, 25 Jun 2025 16:42:18 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4a21f02sm26465637b3.45.2025.06.25.16.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:42:17 -0700 (PDT)
Date: Wed, 25 Jun 2025 19:42:17 -0400
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
Message-ID: <685c89596e525_2a5da429467@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250625135210.2975231-2-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-2-daniel.zahka@gmail.com>
Subject: Re: [PATCH v2 01/17] psp: add documentation
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
> Add documentation of things which belong in the docs rather
> than commit messages.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

> +Driver notes
> +------------
> +
> +Drivers are expected to start with no PSP enabled (``psp-versions-ena``
> +in ``dev-get`` set to ``0``) whenever possible. The user space should
> +not depend on this behavior, as future extension may necessitate creation
> +of devices with PSP already enabled, nonetheless drivers should not enable
> +PSP by default. Enabling PSP should be the responsibility of the system
> +component which also takes care of key rotation.
> +
> +Note that ``psp-versions-ena`` is expected to be used only for enabling
> +receive processing. The device is not expected to reject transmit requests

This means skb encryption for already established connections only,
right? Establishing tx offload will be rejected for new connections.

> +after ``psp-versions-ena`` has been disabled. User may also disable
> +``psp-versions-ena`` while there are active associations, which will
> +break all PSP Rx processing.
> +
> +Drivers are expected to ensure that device key is usable upon init
> +(working keys can be allocated), and that no duplicate keys may be generated
> +(reuse of SPI without key rotation). Drivers may achieve this by rotating
> +keys twice before registering the PSP device.

Since the device returns a { session_key, spi } pair, risk of reuse
is purely in firmware. I don't follow the need for the extra double
rotation.


