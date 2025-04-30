Return-Path: <netdev+bounces-187051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B54C6AA4B62
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD8F67A7FB9
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91E2475CF;
	Wed, 30 Apr 2025 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5SX3DzP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B61DAC95
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016659; cv=none; b=nvfqUODSH9HF3IKQhezfk5xtHU8hrje+qJhpdcpjnmgYSrz24I5nTyTZY07esDNPGewLuZofPZ2h2KmR38xynY7O7jukw9PaZj4hlBR+2Ms4njLtBJewHK7IJoGvPjzXNlSFZjEUQu4+lJ1y63zs9gA1ZQS+rHqx/86WIU/iPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016659; c=relaxed/simple;
	bh=7mbDgUVt6buDIIYBc53oVionYqotoKFKc8XrcxIhKX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=no68yCrPBNVoT7ck+xg5D9R8eWdBvsySXuaI8gG6tu4KVXjyzjCMV1of454BJsreWz+A9PtJSl/ps8flTVkVhfjniVnCqs45OoPA+faDaYPi+Bn9a7bBw3LghN/7RyOP874xcLEzcT1gCGW+RLCaEiHdCs2ZcN+r8oCUxmOV/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5SX3DzP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so74718095e9.2
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746016656; x=1746621456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X0NfREyUrR4P87gt4yAWN0LUwxArtciymolLjtIWxc=;
        b=l5SX3DzP5diJ6MD8wqShtQetzluP4DrcpHKLPNu2D4yDm3eemVQ0n+pbJaDM33AgFz
         BFMLJptb2Shzpr/RxwZnxA2HW5DY03kw3M0K0tihWEKPMBWP5oX7lrxa0ex+taX9bgMI
         XXZHOrGjqW4brhpkQq8o3KrOVHPaINWoyYxWncfUybm0NvpJXTLOw620Os8h1WWYe+q1
         Fw3F5C2Fqq+p//SBTUPJL+mY/gZq6rQ5mJHCqxiYUFXrOUG4uP4xAli1DEgPovQS5RO8
         bhbcrFYIvMtpIgUmHzkx06M3MTjXyYDb6Lj4Z58fD0KnfiZ1ChkeY5llyLFW4Simd0pt
         yXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746016656; x=1746621456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6X0NfREyUrR4P87gt4yAWN0LUwxArtciymolLjtIWxc=;
        b=FlWGPlKqZgmMQrNYFdEK8RNbuNw9+wetzzDKzfwfQHGS91CcISs5bfQjDrFyYI7LkB
         oUELbeb6JXTwN2Yh/qPu0q8cYHKR0E8PCpfRgta9rKu4NVVPq7YSBj/oTlAwDUNuAgPz
         l3hu/pip1F9nVy/u1x6Flgw2fiR4TnRMaC2NOPDEJSRfEvxhYLFSpIu+6BtReD+PpcZs
         lsLTDcuTtq4AsqkKaqE4F/TMQ6Ux95BupdvXfgSw8ehAYWtNH1jvGvYIv9JLCPvOHMaZ
         ol/aLwoHhK+cldiUXeGKJHLOnhqYEvmeSQ5E6jqqQIXf6pDMgJ5gVWKYYgMmb3qgMozf
         2RNw==
X-Forwarded-Encrypted: i=1; AJvYcCUC1PKpUSjdbNKwu4ESoKE4FHQ/6Z6VQCsBKN+4dV6MhhJSZ2YnGJ9jjiRj3hXPQWhL+6n3erk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/AGnmZaOONN7w71J6uIs61fNSmiMPFdxDKaC2QG0IsE71ISXP
	RqG48m3gFCUp6J+sbt9dsbREmGoEkYjeSNI/M+35fhixvBnDPrWP
X-Gm-Gg: ASbGncu8jJW1ysZoGprSrWHW0zZKtvP1iyK4cN0HLbg1PIdUhX6dE/Qr/4GEeWvIif3
	b+VOdyDLbKvjMh8lHPzWnVyt9Yw5exqll84jueLc4qSmk1gOyzI2bCeZX/T8sPahZ0i0dDlB5Mi
	VdF7BpleDVk5BG4dZ2A2YuSdNT1L/W+T7DnUSqe0B2wRr4oOz2MK+1+TzcKCWGZSj7Ft2Rr5Fqm
	Xq+DJ5bWQvYQ3NT0UcoXMOlt4OBOrCBWZCeto/tMLz74sUWwkk+F9Bu4dpvb/8R2RcHwIGg7Ftx
	70ZYzRYn8oqzMLmg5MqCNn5jM5ZSP79DRQtP52hjlHB3qyCwISAlrSp+rkipW7Zh8Ki+VrPOaHF
	mzk/EEvcTd7RNhQ==
X-Google-Smtp-Source: AGHT+IHd2rXRqWaFlE6QNrUmH34CCisHmFMRgQHf66CkFY6hbKUcbc/dI7W4D1jF8xtk/6CXOYjQvw==
X-Received: by 2002:a05:600c:c3cf:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-441b325a645mr14957895e9.13.1746016655779;
        Wed, 30 Apr 2025 05:37:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28dadsm24303915e9.40.2025.04.30.05.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:37:35 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:37:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Joe Damato
 <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy
 poll
Message-ID: <20250430133734.0e78a746@pumpkin>
In-Reply-To: <5fa8c9b8-527c-4392-9c9f-4e1e93ab5326@uwaterloo.ca>
References: <20250424200222.2602990-1-skhawaja@google.com>
	<52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
	<680fb23bb1953_23f881294d9@willemb.c.googlers.com.notmuch>
	<aA-9aEokobuckLtV@LQ3V64L9R2>
	<680fc1f210fdf_246a60294b2@willemb.c.googlers.com.notmuch>
	<5fa8c9b8-527c-4392-9c9f-4e1e93ab5326@uwaterloo.ca>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 14:05:17 -0400
Martin Karsten <mkarsten@uwaterloo.ca> wrote:

...
> That's not the same. The existing busy-poll mechanism still needs an 
> application thread. This thing will just go off and spin, whether 
> there's an application or not.

I think this (and elsewhere) should be 'busy spin' not 'busy poll'.
That would make it much more obvious that it really is a cpu intensive
spin loop.

Note that on some cpu all the 'cores' run at the same speed.
So that putting one into a 'spin' will cause the frequency of all of
them to increase - thus speeding up a benchmark.

Rather the opposite of tests where a cpu busy thread (doing work)
gets bounced around physical cpu - so keeps being run on ones
running a low clock speed.

	David

