Return-Path: <netdev+bounces-227286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E70CBABF12
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CCD3AE466
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD7223DC6;
	Tue, 30 Sep 2025 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+zZsozA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A718DB0D
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219156; cv=none; b=kUbePvW6zCnSCvOIFUx3+w5fHmJS6JzrrkHmRIPUim1MR2KUpG8osAUoWsUVcGkWKa6zoevPfEY14RAIu1LNF0ImltAsGfgzb5TBcMJLENap4v3IEW4HJ84QEj9Sg7DZE6jMFswN3Oc0xhvEueAgxjQx/EBboSDcIYwrWch0j3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219156; c=relaxed/simple;
	bh=TY9C/+ibbJoqXA7YLDRAb0nRxCwsCqhH7rCZzytCUvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxXEJhdb7WFiqMsrx+7g8+AcGs4mwO3C3WF7zb+07rgAsSfCdcaYe0NFMXRSZVnsCvVFYKg9LnxSIpZXkzNs1FDUvU55zGRwMO3GxMbRzJWeOdz+mykIk4kjXC91DnrhqnnOkAwGAvlF2296oRjg9yRvLkEBXtuJTNF9y0FFtqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+zZsozA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759219152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9RsmgnkJQIzAvzapOdDXIG7pejY47m0H8tvxvJgMf2c=;
	b=C+zZsozANalANE16lFZfP17FEEyeVwUnJebioWIiN9L6hCBQXcPj9xdxu1GAbwyIstro8F
	T/dnAOR6YgtObcdvr5wwX2xXDUG76BTQwMMkA55NxyC5VesHwURZo7WssS3HtPSji09D/B
	/fHf1V0nJia9ChRaJ31H8GgTcX5oLUM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-Kfjl0VtRMOGijvhj-i-zPg-1; Tue, 30 Sep 2025 03:59:09 -0400
X-MC-Unique: Kfjl0VtRMOGijvhj-i-zPg-1
X-Mimecast-MFC-AGG-ID: Kfjl0VtRMOGijvhj-i-zPg_1759219148
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-780fdbbdd20so6001411b3a.1
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 00:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759219148; x=1759823948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RsmgnkJQIzAvzapOdDXIG7pejY47m0H8tvxvJgMf2c=;
        b=gujZ1kaMnSO6W8mr7t3M1T1T4DYE3Nu5DHqBySi9Nix5sC308vNRPyhXE8nWhGdy0B
         y2pzYKwmWS4Fa4XyzhyAOz0KWUYCE1sr9cntA6jO28tawRF61EaUd4WQ8/ta7HG6SuAI
         Lq6kdTM2sE3RTAQ/th/aiMAE0nNY+9NLBg/snWx/jq6MXNvbwgZE2+N7jb0lbrnbGl2I
         eHU4Op3jLgcUt4iOqJtqTLpv0YHE/qqvZ2uLnN38YoeT2icLilUYcr7G6qqV7X+pysyv
         Pt7ohZcrhyByvZb57bU/XpL6quDEBrGtzt8v1O9O5/cgnpRkMRLBvt/XAn58E+tjJdIJ
         T+XA==
X-Forwarded-Encrypted: i=1; AJvYcCX9IUXmVOmvckz6vXRpwA//LPhm9Mes2DSjWA5mA3DH7z6FQ2EOuMftmKzTqT/6qRG5cX5fmP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPl2VwOuaTg88LZ7rSyWYvGE3s2wK/oPlWvyEhHpaI8H4i9WII
	ybO/BLXLZ56El0KMJJZAraA2ujcg0DmB7wj4PaSzCXHhXpwhlNapTsM1QiMe+d0seucXMpGP+bQ
	NSpYlfjRhbz+QzvJ7M885lmL9DhWNUyLg1bGZ6PeSqmBRqljqYLYk+TCp
X-Gm-Gg: ASbGncsl4HKVajYv6IMBggY8l+sFvgn5OKEInLPu10S3kDaljaofRTfgoug4wCrJLL5
	BH2sCh4oQENJSXQ8XTBLCNl62zxjCDO+C7X+wxgZjYnegCIqO/JviY0WolUE7CU2zWNTwTzrE+g
	f9lKSi1In1D47o1qD7+WIHbb7OGSY+34cVFBbhhe1baX0LyL4FELMzhjeRyQIOqzpUv03Rrh+UX
	MH0p/CG9cfYMscu1I+ddfEX4hEWESdMtA+L6rh2YiPvxJQzqjtuRIFNH/AiJGM2SEfkdKla9H3k
	5NZl2H1XliwTFh0CL5v2swpykptvSHyFzjBAVidzN9s=
X-Received: by 2002:a05:6a00:3c93:b0:781:1ff0:21c5 with SMTP id d2e1a72fcca58-7811ff0288fmr13434496b3a.3.1759219147839;
        Tue, 30 Sep 2025 00:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPlsTTQskpW4sQWEKsXElTce26alNKfPb2PAuHFwIcV5yqLR0hHgDS/OsDP/7rUKQ9AI9AXw==
X-Received: by 2002:a05:6a00:3c93:b0:781:1ff0:21c5 with SMTP id d2e1a72fcca58-7811ff0288fmr13434465b3a.3.1759219147325;
        Tue, 30 Sep 2025 00:59:07 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78105a81540sm12877773b3a.14.2025.09.30.00.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:59:06 -0700 (PDT)
Date: Tue, 30 Sep 2025 07:58:59 +0000
From: Hangbin Liu <haliu@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org,
	jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
	i.maximets@ovn.org, amorenoz@redhat.com, stephen@networkplumber.org,
	horms@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com
Subject: Re: [PATCH net-next v11 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
Message-ID: <aNuNwyRb5nEsAy-z@fedora>
References: <20250930012857.2270721-1-wilder@us.ibm.com>
 <6be07cb6-7dab-4125-b9e5-0bd4c42235fe@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be07cb6-7dab-4125-b9e5-0bd4c42235fe@redhat.com>

On Tue, Sep 30, 2025 at 09:21:30AM +0200, Paolo Abeni wrote:
> ## Form letter - net-next-closed
> 
> The merge window for v6.18 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations. We are
> currently accepting bug fixes only.
> 
> Please repost when net-next reopens after June 8th.
> 
> RFC patches sent for review only are obviously welcome at any time.
> 

I guess you mean after October 13th[1].

[1] https://patchwork.hopto.org/net-next.html

Thanks
Hangbin


