Return-Path: <netdev+bounces-137817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3569A9F14
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6444C1F234F0
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE92F18E02D;
	Tue, 22 Oct 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcZdpuol"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2669613BC12
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590481; cv=none; b=BGCse8y9hLzUS7UhPerlSj+3q0qYIj+5EeeKXKI17rUSH/Q/byZUVp+UmXeSQtvO4aZdmvYDvdWf3HLWDoCzABWeHM05WdIjzXZAlKpWQhP6rucVxVnbCC2HcS90fO3oaV6/wy9CB5SoYxxqxEjWYAApQCxrXhSpeD+rx1YTy3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590481; c=relaxed/simple;
	bh=zheBBi96R/VryMulYtO56KOIwBcBc7y4K/QnwCQ+6Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GWtdPCK1XfbeGXKLWzHdAE2obaUoFwTp4aJsiu+6iYatXb8M93wN4pSwT/e8UySc6MjtbbMHymViztXAdbp1dTYmmxDFakqO7eRuQ4GWYDUzoff49/hwFU8nZmvbxm9sk5mGzvZ7dSXZZVqgy5Z/p7S1M00dbDMMSX+cKEKuMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcZdpuol; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2Fmqyh0qNeTXOUFp1h8L8NF7mtLUenKN5vYNHeBOROY=;
	b=YcZdpuolo6B4dTey6sO1Hoqo9lkUE2/bZ0/nH9Ru7GvSzPFGJUES4crkTjQETVtK9ByYD8
	AZfZuaNHZLh+OQZDaU6oK6RK95n7xHU65f/dMnyIz+QNHogt/INZKLeI0R8kRYRb+pwA3T
	6rQCrsxxLCYQC1e+LO6o7m7Bojj4cIo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-_VCDR5GuPz2yyqKw4qjC7w-1; Tue, 22 Oct 2024 05:47:57 -0400
X-MC-Unique: _VCDR5GuPz2yyqKw4qjC7w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315a0f25afso40503125e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590475; x=1730195275;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fmqyh0qNeTXOUFp1h8L8NF7mtLUenKN5vYNHeBOROY=;
        b=EOhEyTlKiNYG6Uj5gd/VMvJ2npELtpI3WLtwd/ZjqP0J1Lb0kl9ZW7ByayuJeXpv2F
         y207+n1Dxza0cQ45de7ShQaLsPm3xoq+sEdngO+pFBCaAe9FCaAx3tdVJbfaL/5E70L/
         ZQ6ANl3YMydbuUkHaC5roljWvRvoxEh0JOm3XaRpAxTyiswsbCe0aS4cfVMSi1TM/ce+
         DLMUf10dUN+h2kXrWUjpMefypUt/EcI/a7LV4yw6OYwKlV8toHMvN5MUKnpqdm2iPcph
         ciCrrOmpetKFTzL4xlc83q2rc90HcYryOlKDho5KyRHbd29QjuyfXSKjNiZK6/cr2TWN
         HxYg==
X-Gm-Message-State: AOJu0YyMK0wgjbe/DcEwXk41p7ffwFRec4VMz8hUOJg7WVkTrqEAwBVT
	J0KYm869fn3JpKBIqN8nA51jkmo5zRY/zOMcYftJgWLnf6c/YM8pCxKY2P4BavSVf1n+3t//fWK
	KvEt2aGznJh5GvjwkRcYI7ffvYz0qvM12il0bnR7qfc5kiy6x3cJitQ9zWXYCDQ==
X-Received: by 2002:a05:600c:458e:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-431616472c9mr134301455e9.16.1729590475572;
        Tue, 22 Oct 2024 02:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqVic4KuFHS3pGofLMOPsesEw9lUFnXrWebJCn3NEiC/AkC2r3O30YhFTLMLmswGkFk65c/w==
X-Received: by 2002:a05:600c:458e:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-431616472c9mr134301185e9.16.1729590475070;
        Tue, 22 Oct 2024 02:47:55 -0700 (PDT)
Received: from debian (2a01cb058918ce00b54b8c7a11d7112d.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:b54b:8c7a:11d7:112d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cb918sm82101005e9.41.2024.10.22.02.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:47:54 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:47:52 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/4] ipv4: Prepare core ipv4 files to future
 .flowi4_tos conversion.
Message-ID: <cover.1729530028.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Continue preparing users of ->flowi4_tos (struct flowi4) to the future
conversion of this field (from __u8 to dscp_t). The objective is to
have type annotation to properly separate DSCP bits from ECN ones. This
way we'll ensure that ECN doesn't interfere with DSCP and avoid
regressions where it break routing descisions (fib rules in particular).

This series concentrates on some easy IPv4 conversions where
->flowi4_tos is set directly from an IPv4 header, so we can get the
DSCP value using the ip4h_dscp() helper function.

Guillaume Nault (4):
  ipv4: Prepare fib_compute_spec_dst() to future .flowi4_tos conversion.
  ipv4: Prepare icmp_reply() to future .flowi4_tos conversion.
  ipv4: Prepare ipmr_rt_fib_lookup() to future .flowi4_tos conversion.
  ipv4: Prepare ip_rt_get_source() to future .flowi4_tos conversion.

 net/ipv4/fib_frontend.c | 2 +-
 net/ipv4/icmp.c         | 2 +-
 net/ipv4/ipmr.c         | 2 +-
 net/ipv4/route.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.39.2


