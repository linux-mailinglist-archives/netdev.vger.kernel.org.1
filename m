Return-Path: <netdev+bounces-204986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE64EAFCC5C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144BF4A459A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119E2DCF54;
	Tue,  8 Jul 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihDOmJvd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AF7E107
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982167; cv=none; b=gI0jtfvhUN6ho9d+9m8i7WyenlDAL20SiEv+nxd/CGbar869cffcUNmkSSqypqkDzZZmmsLUfjcc2aP/ELH1LAqkjCI1QuuNwn/fbpjcMkYu1767PKW7gllvtJJt6X6FBTZaHrVRrqw15a48hVHRJi9JEAGXkbIiP7ATw7gjfyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982167; c=relaxed/simple;
	bh=7IMZwdtT4ONplTSo8XHJ6xX4Q4sptOL8v2V3UkoQjlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dV7ZP+pb4HQUfk1mS89qFNdM5j86B/YKr7SNwguUyPyzUgjv3kWQmmQJkAE8V8B4jSdC1vq6CJR2h7wae0ekAlFrb73Fchn7+4vFsauzkxCmkekBLvpAABUTjv2OvZl5E8rMuyFP5cPanYzIKxgsSecCbJFTkoVFhZtFC2rQeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihDOmJvd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751982163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P27oZItgQlQTIEu6BrjTyR+ZcNfbW2DcDgBZkxGIz3s=;
	b=ihDOmJvdrY2E265JJO7y9DLpzLGY0sviPFqgWmQsi70zhelyRwzN5aMfS3YSLk/sXF8s5P
	1UYUWVOVY3CPkzFO+5mosNee7Y0YdCkAx5FCWs0rC/yIWBCuYkR2omM+IPToXY8Z0ssBLx
	Bkt/SeReuvstDMoNBvNJdBk0QWG6MYE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-dIOGweNCNLe47_RGWRtNJw-1; Tue, 08 Jul 2025 09:42:41 -0400
X-MC-Unique: dIOGweNCNLe47_RGWRtNJw-1
X-Mimecast-MFC-AGG-ID: dIOGweNCNLe47_RGWRtNJw_1751982161
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45311704d22so25571975e9.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 06:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982160; x=1752586960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P27oZItgQlQTIEu6BrjTyR+ZcNfbW2DcDgBZkxGIz3s=;
        b=uTgN5k89nhpK+79JENRfooJH0IKUqrwzptdwdHLJ/L9NwJfRPLYTGGX3A1OPK1djqZ
         dVrpcNpG64ZhevEYy9OCPMc89rD5Y2HxJJjCAgt8CgNcuN4syHRNvgIhux6ai91ELnoG
         jHQUwCKWQ+uXebA27/lH3EregkBWGHbQvMhpYvHadWR+MN2WCKNv6y5I1YAN4vwEsnk8
         PzwSta6nwpGvD+iq7ICi1qmT0JI+Jf9HOIgFlBWNQ2tLsJcgK0Vn0qs/ciTWRS50H7c6
         ECv+NmfHCiQ2Cc5fzF+lyeZdkT5O6IMSmDKTpMMwN2O53v9xq5YfotKBMjB/t1QskFfR
         0D3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfO9X42Hrn+DHaHfnjq6Mqioub0+N6FQVx4iZes6iU+Af1WAwiWI14Dn5elvMjAAuYKs1iu7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOos3+NTyjHQOUyxn8M371dDNmVILTiMKpmG6J30mP0XAdJCf2
	AUJbbdEnwQK1t1nx90tzE4qh15zvAS7uxrE5nd9x+I1ZiINURE1R+bIaV2S8lw6F+5I8oRVUfhX
	1S51N4gaDRXRDxfSJ6z0UHwfK5eSjOj+Wwq2tEiuzTSStxzE6aqQ+/0kxIg==
X-Gm-Gg: ASbGncs5VJEIcFNrXzWhkpRt/M+WwvmT1F+gPXtMXJklydqvhIP+BOKg0iVYXSp0UKc
	b1hKnsFtyODTliwXtSt60D05fBkLE1NqtIwYLBYUUwv/6RfC1RqzUfMeeHKovai+jrrYT7B8o/1
	8Q5qLmnE4oOXmTunopEGbMJrrcWs5xhpcst+DHt8Gxj7b9+08LzPDrENoblk9repdF8CcPZViLN
	bcsK87exBk8dfAUhgQ7f4OapETCvACZ4HMEOXOboSHl+EJ8YqIdyUC2l8qACbmF8a9i2jDr0x6R
	q8bfbvSszI40aAl9mR8qZVnhgpSh5SPXmzZY7iyiOjR1lxyj2Gm6cH7Y4HJZ5HfZ9eUf4g==
X-Received: by 2002:a05:600c:154c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-454b4eacc98mr145947515e9.8.1751982160582;
        Tue, 08 Jul 2025 06:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwFsHBVEro5CvXOCFzVmkJDQs/mNrwHrnzu4qHxJ8LIqAIs4YS5XK8sVi8hyjhO6N8NrfG4w==
X-Received: by 2002:a05:600c:154c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-454b4eacc98mr145947095e9.8.1751982159842;
        Tue, 08 Jul 2025 06:42:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0b9bsm13204192f8f.30.2025.07.08.06.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:42:39 -0700 (PDT)
Message-ID: <b610c003-5c8b-4fef-8fea-a2b40f8d1377@redhat.com>
Date: Tue, 8 Jul 2025 15:42:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] selftests: drv-net: add helper/wrapper
 for bpftrace
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
 <20250702-netpoll_test-v4-1-cec227e85639@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702-netpoll_test-v4-1-cec227e85639@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 1:21 PM, Breno Leitao wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> bpftrace is very useful for low level driver testing. perf or trace-cmd
> would also do for collecting data from tracepoints, but they require
> much more post-processing.
> 
> Add a wrapper for running bpftrace and sanitizing its output.
> bpftrace has JSON output, which is great, but it prints loose objects
> and in a slightly inconvenient format. We have to read the objects
> line by line, and while at it return them indexed by the map name.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Does not apply cleanly anymore. Please rebase and repost, thanks!

/P


