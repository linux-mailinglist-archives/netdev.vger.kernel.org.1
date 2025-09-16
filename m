Return-Path: <netdev+bounces-223378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C056B58EC0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447C3482162
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34C2E3AE5;
	Tue, 16 Sep 2025 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFDUbcXK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90262DFA31
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006348; cv=none; b=O+IgMXE0mxj7oY9cjdUBeAgIRFbnuQE1JbBGgMxpvYvBNNVJQvvaJSQW6JUGLgnsU27GEe0IwWIs4xvXYKqx3HDEYRIoTdEZXEH6OPVlZJOSgK/Q3thfn4h6hBIvax4tYvkjzSjwJG8KmnVFHy0TTVcqafJ9+oBfT5sywKVJIYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006348; c=relaxed/simple;
	bh=TNIQKUvJRB04Q1hRIuEOjVnqF1w3pSVsIj/B45tXYOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BTRTtg2qQizYPxYUDBMVThHaQ/IOL+723eFbaap4Dp25cJaw1mF0MhSVnNrl3Q4CWjCcukdrqpNUtYvp7Ry2SHxvQ8pSTaW8unt90kB/7M3BzmrwxFcc5bpGvgviH2jjJw5LbjheqXu94G+w5vcA63KJUlBENLK15zgKALzUgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFDUbcXK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758006345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhPkfwNpOOrLEzdfCrUe596HJ61Ztd+hGAvFe0bAqJ4=;
	b=VFDUbcXKxe16v5BFQhA/oCS35nIY8K2YbE6XO/D1qGuoJo4MwaxU+l7285tilVL7DdqR4K
	c+oaL4goelxtkmJ0Li1E6oLrGvpDEzkE19+OynIn4GQcV8OLm+WGZranezkFSK9CbXZFhw
	I9wxBpppXMjre9YcXOYpAZfK1q1nCNY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-E6VleULVOt6jMS7lZm0H2A-1; Tue, 16 Sep 2025 03:05:40 -0400
X-MC-Unique: E6VleULVOt6jMS7lZm0H2A-1
X-Mimecast-MFC-AGG-ID: E6VleULVOt6jMS7lZm0H2A_1758006339
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecb2ea566aso194647f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758006339; x=1758611139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhPkfwNpOOrLEzdfCrUe596HJ61Ztd+hGAvFe0bAqJ4=;
        b=Gc3iIEDnPU28+CQL3oKOivtjpJCiz1ElRafpi16XJvGH8KqCJdooPBvTl3scnqKjST
         0oWOowyWNaA9pCfIl6gZSOZ1RhdglRVgfsyGyXMm3ohew3x4dtu8C6zWLHWXi2ZTNrzt
         /ioHwcQOlsxkXo6BoVC2JIkJJAF4bG7wUxKS1Db65byxPZSWCAgPnuhbigS9aQHa286b
         9lqP3IsUvKJReSQANQFkAnskPzftQeOTDQBEU/Yai3xsiAzy7d2Rsw9jvl/X9HrLxIaP
         S6r1EkBbg5AaD/fn72wC3T2LI44K5oSU02mqJOcPlbzCiW9N2zO1hSSO4sEcyGlkaWzN
         gryQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhfQ2eXzb2chGoASyMVFp3NEt+pyqKh8kBp2MGsM672MrxSlk2NZB+ieaytkgzdHiCO8i2sB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYlgc6yiMhiD12jc+wG9lZpUJB03+t4LU6MD+mbdpUSF6DlH2
	i4o7Lswjiuvg9GQUiXV4FTT1Sk0JljLZa9jnXF5c9CDRPjxtlIz4JgInwGdyxvzxM6/30tndRvo
	DBJIjbnA1N2xfiK3L93/grjYlaH3B0QnznicxM5rfaEQQcXIKXVYNqAgqIg==
X-Gm-Gg: ASbGncuufH7LQQdutRQv24PjDRp3S+rBNAlFyeCH/jaWz+JC+PY+0j9hs1bpqnKfVwo
	2/QmE0sPpwIcdxT7hboGwIPPmqI5d2PEIsv6x2EzWgtK8IHaUA3Jdp0rjkqc3wB06YU5Wq8usTn
	ypeJhCOlAM9FUn0yz0dRgBn9Q4kIzNWy/+BkhcDcDSctB9rN6UF+CW6j/wB/By7L+yzv5WfDpGS
	L56PgmRZNK2XJgIiBGYGvfu8Z5n8xi+KcuBAAGpM2OnD0Xfqr3GG+j4t31iRIRK6rJNAyj4G97u
	ZYwlEuMynDJKXO7bmyfXWgQiNU45us+M75V54rqCDjCocgtn0TxAK6yX9BOXmePrBAnyZxnTrW+
	J8erJHbyUhDeG
X-Received: by 2002:a05:6000:3113:b0:3d8:e1de:7e4f with SMTP id ffacd0b85a97d-3e7657ba3b7mr14614221f8f.21.1758006339352;
        Tue, 16 Sep 2025 00:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn11P3XuahtQkjvx7j6cbCjlqBM8n9q7Ge8AeRpF9xn7jo1jWEMb78D9FAVMCz+FeSjsl3Qw==
X-Received: by 2002:a05:6000:3113:b0:3d8:e1de:7e4f with SMTP id ffacd0b85a97d-3e7657ba3b7mr14614189f8f.21.1758006338944;
        Tue, 16 Sep 2025 00:05:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d7595sm205427615e9.24.2025.09.16.00.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 00:05:38 -0700 (PDT)
Message-ID: <a3721ff5-9e64-4a9a-a207-d53af7f8a10a@redhat.com>
Date: Tue, 16 Sep 2025 09:05:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 2/2] selftests: bonding: add vlan over bond testing
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20250910031946.400430-1-liuhangbin@gmail.com>
 <20250910031946.400430-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250910031946.400430-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 5:19 AM, Hangbin Liu wrote:
> Add a vlan over bond testing to make sure arp/ns target works.
> Also change all the configs to mudules.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Does not apply cleanly anymore on top of
71379e1c95af2c57567fcac24184c94cb7de4cd6,

Please rebase and resent, thanks!

Paolo


