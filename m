Return-Path: <netdev+bounces-228539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F61BCD9E2
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553BC19E75DE
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3262F6588;
	Fri, 10 Oct 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DM6Ndb2C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20A2F6582
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108027; cv=none; b=eSFCZBCls9ndRSzHH4xeRXAW9xmEM5QRRPIE99MQ4xtIvasIJDKe7ZDHICJ3T0RRIpbZDx+J7iar6HahHG/YM8MfIYuiVuCNeXI66qc71LXuRSwA+YmdPafXJYkX6fv64LwBqg0qoA7DcxtoMCvR8/vQMHHQyxjoNRP/8j8N/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108027; c=relaxed/simple;
	bh=RE51Q+tai5wxyY7IBNplIrEXUroPvyfLKx/UM06nsPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XE6ac7rlBI5tfKIkAyXsNgwsOw+NPRMMFjssyA8d2zcCD1tNUB3QP6bilLWoxJ4QWpGallKgwxOcbgicdwIjl3VPqgxaXAZf1TudyWBLKunmh/oH4eOFvHlMF2YAFjULp0A1uupWnmUjAXyVNzeMFP2/Slp5zHfc9RKph5T7HhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DM6Ndb2C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760108025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mm1LsfcOuzKZTTBgXzTaGHCG8Gr2uq1l0R9yl5s8auw=;
	b=DM6Ndb2CAazN+ux9pzrdpD8uO1/yhFOW5ogB3B61bpZ6kKiybDUU/O07g95YHBXgvKWwuR
	R2R2cheLwRMSFyK30GArMFN4sGVNQZes7WKnJOXABVLnLQ3GLntwDEloepobo3920xWguu
	ViZoDXah8YIVqqQ+W5lsXXph3H1gUyM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-mYM_7oVCP2uO-MV107efPg-1; Fri, 10 Oct 2025 10:53:42 -0400
X-MC-Unique: mYM_7oVCP2uO-MV107efPg-1
X-Mimecast-MFC-AGG-ID: mYM_7oVCP2uO-MV107efPg_1760108021
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b3d525fb67eso245413266b.0
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108021; x=1760712821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm1LsfcOuzKZTTBgXzTaGHCG8Gr2uq1l0R9yl5s8auw=;
        b=aVkFcjY0dzAqzUz75efbzldEkgXwpeA+KUXHH1O/EmvDOG/TXHBYM+z0W6RjKi5MKO
         /5NsjmDw//Go60XHeU7/pOxiNc72J35/ZI6mZUlQrISMa914sEYXWiP0c47FFW7+x3hg
         aJtCs4fg9sy67QpO4dfG6mwq7CbF6QOyPNwrAS2uzVjcFxsh568/viRjY7Q0PNC8cYQ9
         3iQi2ntb6SaRsyN11pyGc8pNX88CLJ1k5UB86xv2PIA1ipbLqeZmC2dRHFVQVAIC1nXv
         dVungHUA93w1OnTRzMClILJvbtxTRl2oxaDpH2VJPEF6bvvpR81tJoplx81hB4JB+UPb
         DtxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvaxTw/nDriF4uqVIB+UjTR9r/MK6xhhwTSvWipdJIHeyRHqMjU4LVUqHyuZMWv5Y8arQGdlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLCHtvzYyYvk6BN1k6T476bsFz3ia4z31aHIWAs/4JV0ZpyRI
	HTC4Tb6HeGtloOHjrBzbIkzdVT4YGhBYFDqT58fVchxKaw3Ehg7Z/ZeFFgJonLd7Pf5JZbtV927
	LlJU/p3k4TdNxKNjCyNXQUlzMdnWHyY6UgI7u7rcj2EiN9OL3ODiVlZ2XKA==
X-Gm-Gg: ASbGnctBUKY2vagLo4PluMpPYKQdO2XZ42HOFkBidPpPQMuW8MWiPi0faEhAAZktavC
	P2AFKCOI6cORhAVg3sA8un92+fq0e5tUYuDnzC6ntxcUs9D24C77pdR4nXShqgUNWhmjtcw6x7D
	1W+mW2jmeehjtiyWIA1yqy9v1jctkTfPUpTksW4oot6ylRmjTvoX7y9Zhj/lOBHehW31iECpK0j
	hyQ0YV61h+QayMEP98TNP69tKOudIlLhNjZnKO6PQ34cn+nZpOouskjdmNXiKWm2rFOhVJVgRX8
	i1v7z2nluBtbN9lhv711ikmKAbHGxAE7vQAcySPCpQWgPsImNvbH/kZiUR/oYf5/Ejv0RHkOyZP
	qiZ0xA7ZbFhto
X-Received: by 2002:a17:907:3d16:b0:b38:25b2:e71c with SMTP id a640c23a62f3a-b50ac1c0d4amr1269988466b.41.1760108021433;
        Fri, 10 Oct 2025 07:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvs40B7jZcN/+w79lx0XokZpMjaCzgtfhFa84wc/vDHQJD9iDkyGA8sI2ISLmd873BOO53wg==
X-Received: by 2002:a17:907:3d16:b0:b38:25b2:e71c with SMTP id a640c23a62f3a-b50ac1c0d4amr1269983566b.41.1760108021007;
        Fri, 10 Oct 2025 07:53:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm249396166b.38.2025.10.10.07.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:53:40 -0700 (PDT)
Message-ID: <0ec01c17-1c39-4207-96f8-597bc8d6c394@redhat.com>
Date: Fri, 10 Oct 2025 16:53:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 00/13] AccECN protocol case handling series
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 3:17 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plesae find the v4 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/
> 
> Best regards,
> Chia-Yu

## Form letter - net-next-closed

The merge window for v6.18 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after October 12th.

RFC patches sent for review only are obviously welcome at any time.


