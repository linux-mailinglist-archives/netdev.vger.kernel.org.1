Return-Path: <netdev+bounces-235453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8D1C30D24
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62ED24E179D
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC88F2EB84F;
	Tue,  4 Nov 2025 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5TyF0Y1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVI9U9ao"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D92E8B97
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257010; cv=none; b=JwiPRfN4O8QT32FIWmHaB+p0Ge/+unim5fp2Fb/q1CfMW6JjORIcPzICofzWHZ5bVHv+lPsZOt002vIumfl0Ob1hv+lYPSDP2ArdPtNZd+awfs/ALoS4k1sN3JsxzNAD5tu+cNXA+Fqf4AKGMFYMGFMNJJTacPipINmuZ3v2XZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257010; c=relaxed/simple;
	bh=cZ5gDjz2QbKshZsqDifQYTuFk5BFj4GdybCog3FXEJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXrpYCeLttNzMDqyRWXLWsT7ZLagHH4uTrBHcKtwS15USsuU1QfmTsGmYwFclZjUEa6oCQo0lOSSZD2dOpWnjneXCzA8TGHygzx3KX1VW+SomDExuhwyHR2WiZONLSsOCqwHcWLKs59bkQItvYnK272ZxR83WdbpReQZv1BZJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5TyF0Y1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVI9U9ao; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762257008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NKqzRwzFTMUyXUXOrE/y+2M+CzQozAf5NhVcAFiTKA=;
	b=H5TyF0Y1OrCtiqvs9FAlMGiYS1O6kxJengm2/BVZe+gM9j4awcPsBibcDufmrU2FMqM/+7
	GTA009f3MDUeIqp3XffCfs8nSYRibd8W9ZL5utPqtfQdYncD5BKtKC1QSZPKNV1gj09M/t
	tF1CR0qmQjpp7MoPPceaenZ8itT4fuE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-R1yPBb1HOxiuALKBAbPyWA-1; Tue, 04 Nov 2025 06:50:07 -0500
X-MC-Unique: R1yPBb1HOxiuALKBAbPyWA-1
X-Mimecast-MFC-AGG-ID: R1yPBb1HOxiuALKBAbPyWA_1762257006
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c7b0ae36so1805672f8f.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762257006; x=1762861806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NKqzRwzFTMUyXUXOrE/y+2M+CzQozAf5NhVcAFiTKA=;
        b=XVI9U9aoFJtnzpQUkawSQ2VwGwsX6m6LNAOV19PSkO+GcMgyZ85ND3Ew/r/9SU921x
         mf5nNoVhCKgXGuJn9ePTzgLtVw6ae4AmKK7S61o1ZMA/AajxklgkwkVNfl13xjNiiu6c
         x2vrUS5sZ1CPrNBE3DtnIEKZTUCBS6URD5bDr6paBLgvnMl9c3Y1rQvvqCE0Jg5POtLC
         n4NKKSJ39h/op2dcSWU0UwGQ7I883aF3dXglqfxaZ/AJvHZRw+yUpCR3Pyf51ygrr5aJ
         toZayd7MemCKELfohS9BqGyhh4HH25ijCuDBKVpVxJDaaG7eJjxHG69feI/XInOL3JOs
         Wm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257006; x=1762861806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NKqzRwzFTMUyXUXOrE/y+2M+CzQozAf5NhVcAFiTKA=;
        b=JOHqQD82rjMDeHSU8aemZvWp/CWPhVgNMTfDftM8lF1WAIej9WZ776E88DZnqTQPEp
         DtBjJp7BSO4A7ZV9lWFm8mxU65EUURhQJabaijHcs6uy33nHGS1fkkBRX0woxdgknofe
         KCuNaz1oHBAqmCJelfsNajT3nL/IZmRfmssGiAUIIdwlmt7Di82+TccMsZMZEpwRw4pI
         scjPJg2LwGCDF7N+49Jni5uDfSuHIlrzUTogC/vhUzehcBtxwY39BghYoJbVLbzJCI49
         6vY3OYrlJHc/2xUJX7NE7QRm38BrKG+O/KhQOXxPTMCO8tJeRvfQ7eUnSs7qK+wSVzKL
         sDLg==
X-Forwarded-Encrypted: i=1; AJvYcCVtJ48oU1l4EZE9hlp+6+aibwNFV8YYvj8Jq8qnX6UuSo2+ZFStTyA7g1i7ICy73J1xxh/LpO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxe7cS38HbnXfNk/ixy4qaM2BogzjwqHyEloqZ/jVlJGUq/NXy
	yvzeA2eM0KwIJa3X6dAq4Xt/ywnPC4FN71K1Y3T64HGwMfNnUMDrdqF+YzekS36zxYGqvBdDr56
	3+xHGl17NizonbNPjFfkpPFeEMvm+ClXBZvOBFhIRtU4umtSDdMI2Y7oevw==
X-Gm-Gg: ASbGnctVyyGRv9kTzGz5dhoX00Wk+/ropmxHaQRSqYvCsP5/C+b+awNWKEyzmwMmFp7
	8NCq2JYOIL1oo4Tym7YcyGiDF2bWpAOtnDvuUWsPV2Hw0YjxvNny48rKIZ8XuhO/h/vRdDR7iGQ
	dK3XmcEyEZ8VrH9p3Tz21j2qqF/lJ6Qf9sfdkiDwjvy7YrzqXUAWIaFrSuKUJf9Lr0F9sQq2oFs
	al5suGZ7V1O2WH7XFgudeg4Rm0SfeseG/zxliBAN4RvPlw6CSKWpqWk7gAsZ8DXMNPJ/4PGppXU
	kZQbzufSV4Fj9Mx39EJ7uhhS+cCqpQ60Qm0ve/WuF2f8NPEJeoMbHplcEcLw9ARmUhYHhUTcq8j
	9/u/1CrPh9KeC
X-Received: by 2002:a05:6000:2889:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-429dbd3c7bfmr2751760f8f.26.1762257003798;
        Tue, 04 Nov 2025 03:50:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFrHCmmk8I9jZU38ly0GkES+iMhlTFtfqgEF6bGR4ojffkjtcXHlyZQ+AKtVRy8Dar+aGGTw==
X-Received: by 2002:a05:6000:2889:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-429dbd3c7bfmr2751707f8f.26.1762257003406;
        Tue, 04 Nov 2025 03:50:03 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc19227csm4291317f8f.11.2025.11.04.03.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:50:02 -0800 (PST)
Message-ID: <914b0331-8fab-4ad6-a6a8-e511a4352cea@redhat.com>
Date: Tue, 4 Nov 2025 12:50:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 08/15] quic: add path management
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Benjamin Coddington <bcodding@redhat.com>, Steve Dickson
 <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
 <0ccfc094d8f69e079cc84c96bd86a31e008e1aaf.1761748557.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0ccfc094d8f69e079cc84c96bd86a31e008e1aaf.1761748557.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 3:35 PM, Xin Long wrote:
> This patch introduces 'quic_path_group' for managing paths, represented
> by 'struct quic_path'. A connection may use two paths simultaneously
> for connection migration.
> 
> Each path is associated with a UDP tunnel socket (sk), and a single
> UDP tunnel socket can be related to multiple paths from different sockets.
> These UDP tunnel sockets are wrapped in 'quic_udp_sock' structures and
> stored in a hash table.
> 
> It includes mechanisms to bind and unbind paths, detect alternative paths
> for migration, and swap paths to support seamless transition between
> networks.
> 
> - quic_path_bind(): Bind a path to a port and associate it with a UDP sk.
> 
> - quic_path_free(): Unbind a path from a port and disassociate it from a
>   UDP sk.

I find the above name slightly misleading, as I expect such function to
free the path argument. Possibly quic_path_unbind?

/{


