Return-Path: <netdev+bounces-193416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E3BAC3E08
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567741897271
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A271F4629;
	Mon, 26 May 2025 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/WlVtMT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4209E2DCC07
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748256531; cv=none; b=dNnFAB9pG4zh4AmvCU7EtzBB9CAIyz0PlqCy9AtJ1NNxjqbPLFwCaWz9tV22Frrx6wErEb4ymmTdx1+OcxWGbtk7m8S4Vy8ue9/lSkSqXvtFWgntYIisF7mgIyP4M+6nLjLaYMU3zfp//v8nimOo6qiAvmg1bvgQaQaKIIkb5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748256531; c=relaxed/simple;
	bh=Kst9MAEyZldpaV026jibp7tTB98u4DWNAEscoyLWHUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIPxcpn0WeUoHyEsrMW3PcgE0Z1//xCmu8JA95MQkUjIqYt5FUf3pE6BxY4PmWTuNOSL8m0AYDSm0FNW4QDiu9i7iEa9PR7lL7zIKSf5gnw+SOdvEvhopDa8eRqfLSQB+OUNPOIWCojBrQm8Yo/LUvVvg2TkJXRtps+9FLDeMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/WlVtMT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748256527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBFnGHZomc41cOQHCuqheUgzba5w7SB3h0vc8x00N3s=;
	b=G/WlVtMTHJYfF3lqULXoiYwBfoVU+Y/CMSIliKgChRWDI4hvL9Xefxghsa9Bms3/Ns6ST9
	IG8kkAGQy1YonvsqZIbes4PvIdiBVopThp8JwBVAuk/IhvI6Gd4JUDHG1IZ5gslIBa/ddx
	b7iFEaY3cpeuDHQLXkH7dFEoLGzupSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-QzT-3M2bM4G10UHF73vaDA-1; Mon, 26 May 2025 06:48:44 -0400
X-MC-Unique: QzT-3M2bM4G10UHF73vaDA-1
X-Mimecast-MFC-AGG-ID: QzT-3M2bM4G10UHF73vaDA_1748256523
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-44b1f5b8e9dso7717855e9.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 03:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748256522; x=1748861322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBFnGHZomc41cOQHCuqheUgzba5w7SB3h0vc8x00N3s=;
        b=U8A4cTxtfg+K8fkEMygqKW3FGWj9du6+ZMNTMcpZXd2a8VFvyS7/O4wayOQzHDukNE
         I1SS7SU+HRi6b3L6Jy50/53mFLVKf8CXE4AwS50jSFw9IamEGOpt9RTS38EyGy//+ZRv
         hPGxiF0scJym1KRpk68y+MWSQf6q3vaZP6ZitCFhcO5K+vm0ptzyCfFBhQxihmcDRUa+
         UqENzatTYDFQv8hBzs7sX72lX5oI7ru5jP9IOAE7eScS73dRCbmLSMi8YuYUn/1Rz68q
         Dyi4zcDJ7FahFMVA55VlFGFvYj2SI87+An+7sZH+gxHuhi2Y+/EGAEeffAZ9I7CxICZ1
         d3SA==
X-Forwarded-Encrypted: i=1; AJvYcCXseRBQhOWXlaUBspFrL6fBadUNL0DNYWZsB2NxnrNLT7qNuA0svdoFm2JzEzeR0Y1HH8yKAYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJwp20rL2NUpx+JwX3a0OenaE1Iw5ITYTv9vg2K9Z03WzRO26
	kVnn+ujo8RuZ6kU8s/dHlZ8qLtwovZNePDOP46K/eAjBsl57WCk+FKJsrDQqgJfXd23ZPziEZ/w
	uDtYVUpJbql3HNVZTiy4l2uFD51PR9pfOIvkjX8roReS1zjLc0NIRf5GL1g==
X-Gm-Gg: ASbGncu8SCJhM3sIe4kqyFvet8BTb4FixVuenv5G+XdANvHwG+kKou/XRo1AuDphYTd
	mN6NTn0WkUk9qhJGvMfmY5uHhhtc0WczyNNSDIeMPVxNKLHPZ0iLlqvp85vA37D85u0UXHFrdnY
	jXs2P7nUNfDXpOEEkBktKxZrUX3wEpSalg7FqghP0LIshFkQ9BM5Z2vsKBlE6BIhAVKGLLWLXez
	LnROIg0Zx5cweCj6Wzxjqdbo8s0YYTXuB5bonBfYwrpQBNItRI68sSgUvqGUcsqblXn5JLryA4D
	wbk8RtFcuaG6pwQV/Gg=
X-Received: by 2002:a05:600c:1547:b0:440:54ef:dfdc with SMTP id 5b1f17b1804b1-44c935dca2emr70542195e9.8.1748256522548;
        Mon, 26 May 2025 03:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaHqtt4SIdUKPpxF+y2ywQ+DoleofDlr7xvNRb+xDN4kfs1Upx+FfTRAAPhRLVzIc2DQnSKQ==
X-Received: by 2002:a05:600c:1547:b0:440:54ef:dfdc with SMTP id 5b1f17b1804b1-44c935dca2emr70542025e9.8.1748256522163;
        Mon, 26 May 2025 03:48:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b295fdsm242103435e9.5.2025.05.26.03.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 03:48:41 -0700 (PDT)
Message-ID: <451f45a0-4db4-40a7-ba22-d2a7dd1a1c7d@redhat.com>
Date: Mon, 26 May 2025 12:48:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] "WARNING in corrupted" in Linux Kernel v6.15-rc5
To: John <john.cs.hey@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAP=Rh=MXN2U7ydg2f9k1cywF8Q1qpizXmcBg6mmzwpt86=PaWw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAP=Rh=MXN2U7ydg2f9k1cywF8Q1qpizXmcBg6mmzwpt86=PaWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/25 9:11 AM, John wrote:
> I am writing to report a potential vulnerability I encountered during
> testing of the Linux Kernel version v6.15-rc5.
> 
> Git Commit: 92a09c47464d040866cf2b4cd052bc60555185fb (tag: v6.15-rc5)
> 
> Bug Location: 20628 at net/ipv4/ipmr.c:440 ipmr_free_table
> net/ipv4/ipmr.c:440 [inline]
> 
> Bug report: https://hastebin.com/share/idudaveten.yaml
> 
> Complete log: https://hastebin.com/share/ojonatucos.perl
> 
> Entire kernel config:  https://hastebin.com/share/padecilimo.ini
> 
> Root Cause Analysis:
> A kernel warning is triggered during the execution of
> ipmr_rules_exit() at line 440 of net/ipv4/ipmr.c, when attempting to
> free a multicast routing (mr) table that may have already been
> released or was never correctly initialized.
> This function is called as part of the ipmr_net_exit_batch() logic
> when a network namespace is being torn down (copy_net_ns() →
> create_new_namespaces() → unshare() syscall).
> The crash is accompanied by a FAULT_INJECTION trace involving
> copy_from_user_iter, suggesting this might be a fuzzing-induced fault
> where the data passed via netlink_sendmsg() is malformed.
> However, the primary issue lies in ipmr_free_table() dereferencing a
> potentially invalid pointer—either due to a race condition during
> namespace teardown or improper error handling during netns
> initialization.
> 
> At present, I have not yet obtained a minimal reproducer for this
> issue. However, I am actively working on reproducing it, and I will
> promptly share any additional findings or a working reproducer as soon
> as it becomes available.
> 
> Thank you very much for your time and attention to this matter. I
> truly appreciate the efforts of the Linux kernel community.

Should be fixed by commit c46286fdd6aa, which landed in 6.15

/P


