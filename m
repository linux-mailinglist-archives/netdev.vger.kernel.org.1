Return-Path: <netdev+bounces-212798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB4EB2200E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97EA816172F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD562C3265;
	Tue, 12 Aug 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjE+ypXf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0B2DECC6
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985499; cv=none; b=TU3Hh7QMcjSzKtkDNlg/MuFNIhv5XJPZLi5sEUaF7nVbLnhlW4TeBuPNH0Z+0YHH7wM5LzwOuv4EBPsR8AA0XaHcZTIdoXO48bO0m+DbNIBJ7CRrXGIiGHu5bTR4jnwZcCYir0Ijk/gyRWKwH6jQKD9G/O+tF2iAPvdYWd5ZzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985499; c=relaxed/simple;
	bh=/m6G9D4OqODQ3c13RA3kRRXSajiSL1Hn3Oq6jPIDEAM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=upEJYOTxCdx+dycTi7QcIe1MI/qfImcUbummv0c8qvAlvwPmiixP4j/GY7ML+BT8zmR97E2D7mtXLtjB8sVgekgMcnPhmETIq0SKX1D9Pl5mJGeJh3O10KACk4YicqQdUQDi8kl/9p0pEaycGOAG1P86p0yRr6HLy4RP8Z63zRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjE+ypXf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754985497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nVnZS37k4cktu+HvOOSYeayJ3wo84XR8QPcitb+eTw=;
	b=ZjE+ypXfi3fsBt7n6drTyAzm/dF2aD0jYi6SxMyPYeoVyXmuYU6e9kD7Yz0w7Wg5ifEOQL
	lerjlksVzUK2tkKMYJVk8evgHjWYTh2zWx2+jPr/AuC9DkfrE+wFWmdXgc8GsQSKMZAHlg
	4ix8l4s69iIcPTpcAK8Jr0Eex+8aCvo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-1tn8t9ctO7yIiAjVrNsnqg-1; Tue, 12 Aug 2025 03:58:15 -0400
X-MC-Unique: 1tn8t9ctO7yIiAjVrNsnqg-1
X-Mimecast-MFC-AGG-ID: 1tn8t9ctO7yIiAjVrNsnqg_1754985495
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b08d73cc8cso144411471cf.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754985495; x=1755590295;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nVnZS37k4cktu+HvOOSYeayJ3wo84XR8QPcitb+eTw=;
        b=DWputOrYaSw46Q7zP2EE4IR3kmJdljGhtEwzAYiYbkFwa/DdI0UyoEqmHOS0xRToN3
         uxA1lEnJ9H/C+AKyftIQe6u9EWykNwSdrPIT053HMFSnqXmcj2PxCd2S7eLwY4xRKcfC
         iICx75XLJBMh6qIUIh5ZZNUs/N4LXY12wmlCSx5BNEy559sYMaKUIi+jqhc38zbjBsPg
         dDazRL1rrtmEpLJUOnEPgEWH4ANyr8MH3P0HtPnB3vzcstxEQlJ0pLWJ80pDPJppkrqG
         G0nCfYztttxdyueqa+LhNwpmYYP3zBaAWzWz+ONkIGNWvc6PLI3RWqK07CMXDqaowjy0
         Xdpg==
X-Gm-Message-State: AOJu0YxHD8pFXO9OF/dh7xNzXPwuo0pjAr5hNudY620Y8Fz0BKLsvHv2
	1J9PUljS14cUoqqRmD8Uq5aqcNUXQKezMpZePInCZE5grxVFF6NL2zlAK93hkxMGOyaphOS8DpI
	SUIvPxf6p8n94IAjRY3AkzseSOB8aq3VEvxPXEqH9o88QDDJUJC7fybnCeA==
X-Gm-Gg: ASbGncspV/qHXvfrTM5gmMBbmrlwFUNIQ/u72a5KIVfztxQj1Ps6QYWLd18H1L2HLt4
	P2ZAYxbMLbrbfpYF+g7afaz1cinMCgZkdV9oDX9/8DoMWqfo1AkH4O2PQHTx8ZAW07eZ18FqJ6l
	DI0gKrcrweFW0BXJmtJNM6PLugTxydRwQpNmIYXPDDyDPwzCA44tj52Hvgf8UNK7+fnSdSld5Vv
	mbz0ttZwtY5sSBxqfC3lCSn0U8cOClwR6pANFI5tsU0fxFbhVmpExGAEGWIleIw8IMoopAkeCmi
	oa/Xe/fKRCAIdLbyfBOpzf4O7OAb3dLU9jVpW1scgMk=
X-Received: by 2002:a05:622a:311:b0:4ab:9586:bdd6 with SMTP id d75a77b69052e-4b0eccef470mr39094131cf.53.1754985494839;
        Tue, 12 Aug 2025 00:58:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcDnbdEYlxPjyWRUPmnEUsEptOCYnii0fU0tlD6+Q8OpR1Zr5lMiOkDQhE3+YjeJRH46HgFg==
X-Received: by 2002:a05:622a:311:b0:4ab:9586:bdd6 with SMTP id d75a77b69052e-4b0eccef470mr39093911cf.53.1754985494407;
        Tue, 12 Aug 2025 00:58:14 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0860f9df0sm97241301cf.1.2025.08.12.00.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 00:58:14 -0700 (PDT)
Message-ID: <78f95723-0c65-4060-b9d6-7e69d24da2da@redhat.com>
Date: Tue, 12 Aug 2025 09:58:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nft_flowtable.sh selftest failures
From: Paolo Abeni <pabeni@redhat.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 netfilter-devel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <766e4508-aaba-4cdc-92b4-e116e52ae13b@redhat.com>
Content-Language: en-US
In-Reply-To: <766e4508-aaba-4cdc-92b4-e116e52ae13b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 9:50 AM, Paolo Abeni wrote:
> the mentioned self test failed in the last 2 CI iterations, on both
> metal and debug build, with the following output:
> 
> # PASS: flow offload for ns1/ns2 with dnat and pmtu discovery ns1 <- ns2
> # Error: Requested AUTH algorithm not found.
> # Error: Requested AUTH algorithm not found.
> # Error: Requested AUTH algorithm not found.
> # Error: Requested AUTH algorithm not found.
> # FAIL: file mismatch for ns1 -> ns2
> # -rw------- 1 root root 2097152 Aug 11 20:23 /tmp/tmp.x1oVr3mu0P
> # -rw------- 1 root root 0 Aug 11 20:23 /tmp/tmp.77gElv9oit
> # FAIL: file mismatch for ns1 <- ns2
> # -rw------- 1 root root 2097152 Aug 11 20:23 /tmp/tmp.x1oVr3mu0P
> # -rw------- 1 root root 0 Aug 11 20:23 /tmp/tmp.ogDiTh8ZXf
> # FAIL: ipsec tunnel mode for ns1/ns2
> 
> see, i.e.:
> https://netdev-3.bots.linux.dev/vmksft-nf/results/249461/14-nft-flowtable-sh/
> 
> I don't see relevant patches landing in the relevant builds, I suspect
> the relevant kernel config knob (CONFIG_CRYPTO_SHA1 ?) was always
> missing in the ST config, pulled in by NIPA due to some CI setup tweak
> possibly changed recently (Jakub could possibly have a better idea/view
> about the latter). Could you please have a look?
> 
> NIPA generates the kernel config and the kernel build itself with
> something alike:
> 
> rm -f .config
> vng --build  --config tools/testing/selftests/net/forwarding/config

Addendum: others (not nft-related) tests (vrf-xfrm-tests.sh,
xfrm_policy.sh) are failing apparently due to the same root cause
(missing sha1 knob), so I guess it's really a NIPA issue.

/P


