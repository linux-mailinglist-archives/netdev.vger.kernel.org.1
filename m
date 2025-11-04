Return-Path: <netdev+bounces-235427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF11AC305E7
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 270EC4EC010
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F848313E04;
	Tue,  4 Nov 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RB4dc6YA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pbc3IeyS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5E3148AB
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250111; cv=none; b=ieul2zEFumv5nkFEgic89PHfx4yTtXNXL9RYHH0iqIkkZXDW4eqW2UhN2eLbDybUg9pHPdU8cK6HLEtVnERh9eU6l0TM/L/Bc2fYWAFawOVd06uuF2wv32QUkSLVEqVZi+NKIZ0BZD82tpzTNR5Y8GxEfPlNJlGFlByTQw3j0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250111; c=relaxed/simple;
	bh=QfSQ5cpqVePGEDeF20Ht8A/SzrjwwOLDakiJXtv47U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYCeePTwSS68vs1pCn6PessrGbItl46i/Uv6MEBf7SQvEYqTYRi8wnxsd4/yiCi/Ap7fklisXB1cCd6Sw8YHhOpYGrtHJYZNMfdp9wn4+/hLfN5AMjHWFkzM41SDqDUYPaGcSc8lyzVKksQTeXQB/4M79dFSRgV/hrLbxHH9k9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RB4dc6YA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pbc3IeyS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762250108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VP7vTJNouoan64MmsnztfHu0gZfK42bIBxJmyPWNcv8=;
	b=RB4dc6YAh0WrkbdrC/KsDr/1K+aJCLEdAyQVJV1vmA2OG5rymgYMKQFKC/CmhtBaohFE02
	vtGNaI547XwFP+n7J2lQ+bRap6kFfLFhFYg625pDZWzubK29Qng2B6s/BvQwZB0uyb/U7c
	BOa3e/Izh50pxhjH2KQtuvcxWo6NQ6s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-C_KCAnMtPPWUHp1DBN8AWw-1; Tue, 04 Nov 2025 04:55:05 -0500
X-MC-Unique: C_KCAnMtPPWUHp1DBN8AWw-1
X-Mimecast-MFC-AGG-ID: C_KCAnMtPPWUHp1DBN8AWw_1762250104
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4770c37331fso38207105e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 01:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762250104; x=1762854904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VP7vTJNouoan64MmsnztfHu0gZfK42bIBxJmyPWNcv8=;
        b=pbc3IeySiscSqzEdQYt5Wpr2mSDzBCnlBaqG3f5dO9S+G3YnSb0Vbfgi8zeeAY8voQ
         9e0eKr96WW69lKxIxCiJwQ9WuBgNQKA/MTGl9Y+VPG4hM6N8gJCkGBQxsmv3c4hxhzZ4
         6VtWxtZuTk+jIGa6hUZiBjLqIR2wgR6WtCDblrdOYSauekxG62tukqEwDcEEtBbbJ486
         rhEuT9bkaGiWfZ8SUqsu59vlXaXtveMl4a/k64SI9AXJkeQ7dcwrGd7Oq6KTBzBJAfpd
         3kNjcuQuGJxrlQ9K6OdR44QtulcVK+Q84HDtNOyhWLi+LnRjneOys4iEbqflwYhcsjp+
         fv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250104; x=1762854904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VP7vTJNouoan64MmsnztfHu0gZfK42bIBxJmyPWNcv8=;
        b=o1jxrz1n2B+VncVbeMNQw5MhmCV1EHNNny3Re0GTyo7WrAZEd9fv3+BnszptoDFdNR
         2sCPvuRV3YJBl0hmVou01mgn7didxVd5d6e7PmzNL8pBozGpHdE7vDTT+Lzk7ysQemS1
         knw+jiVILjVhU9u3jcHhekRNUB7kTeWpbjFjpuSXl+XTk5HGPxq+of8BfCueaw2PILbw
         ujYD99kXj50kLcXyihKwsKbXx+CU+xGtXp/D9OuTm3gJJJFXQS0VLJMPiyahJH6PmNgw
         grx2cF5Hv1rhNJ1yoLF4mJ/3DYU6sfbECaq6NefDuNziw9DKrS1Dorl1YuawtGG/icL+
         ZiWw==
X-Forwarded-Encrypted: i=1; AJvYcCVrZ7gGRqEcvA7SgSMefHf+MQhr45Ernf0b7hgLF2UZFAv4QYR7UuWshRPH+tIu45E6SUwb0Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4laftflu67Hf1/TS3vcN/levEwOwod5Ybwjhv/GVJVpk0lOu
	DHaF6Atdkc+1lsKoJhjGOO2Dr6EHlSOphowh7z6wHic5YV11kqrvcUd8OmoJ1NIrhiNd246+Unr
	fz+GJkr9RcKeqcUZl+1w7e/IxrsZzONj+sYJcb14NWSdRWp6V67pTdoUe7A==
X-Gm-Gg: ASbGncs6YMvcloP31VX/vUeJWj855Pf8QkaAcXBscjxcZShk4evWmkqNWnQ3fY44d7C
	72220UdCyMZ1nEYzU/+9UT0CHhUGVwlOPyO/P9nVgl11T5hVk1cF2/PVHdf5eCIxmPB9ol2pV6u
	93moLhK0p85BPs5/lnt6GZEoW6b1dH8M0G1Ns4Sab40EWnPpfY+NJPnhsUDxzqpvpWC3YWMzwZm
	R+FjG3paCM4r+4yglnIYzPnYIYkpEwAUhuQeJyq4Qm+nS7h+XXBLLz4trelV8oiFp28zotV3h5s
	HVgc1d6j16lBuUI2pwAvS4IVrjUrYsLy2j311Dk5zcA0kwm0M9s7V5bnLizNTQioznJK9XmXkHS
	GoM22NTtxtpjMJa/q+kRogO72aMsPJBFtpG5jspfslzkK
X-Received: by 2002:a05:600d:8394:b0:475:d944:2053 with SMTP id 5b1f17b1804b1-47730ef502bmr102634665e9.2.1762250104376;
        Tue, 04 Nov 2025 01:55:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6j3suXJsdE1W3rADP1TPpeXGC+84lF7jrCGSmoPCopSvWPQsrXeTI2soLtfPTzeuZHI21IQ==
X-Received: by 2002:a05:600d:8394:b0:475:d944:2053 with SMTP id 5b1f17b1804b1-47730ef502bmr102634195e9.2.1762250103915;
        Tue, 04 Nov 2025 01:55:03 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775598c2c9sm28545315e9.8.2025.11.04.01.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 01:55:03 -0800 (PST)
Message-ID: <1fcf4639-4c3e-4c07-9d01-0537cadcff42@redhat.com>
Date: Tue, 4 Nov 2025 10:55:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 03/15] quic: provide common utilities and data
 structures
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
 <66e48fe865ea67beb2a7f5cf084ea86d93592dff.1761748557.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <66e48fe865ea67beb2a7f5cf084ea86d93592dff.1761748557.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 3:35 PM, Xin Long wrote:
> This patch provides foundational data structures and utilities used
> throughout the QUIC stack.
> 
> It introduces packet header types, connection ID support, and address
> handling. Hash tables are added to manage socket lookup and connection
> ID mapping.
> 
> A flexible binary data type is provided, along with helpers for parsing,
> matching, and memory management. Helpers for encoding and decoding
> transport parameters and frames are also included.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


