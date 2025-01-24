Return-Path: <netdev+bounces-160746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59986A1B1FA
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 09:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BE418894AC
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A352E1F5404;
	Fri, 24 Jan 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj7ac1UE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97791DB134
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737708943; cv=none; b=pKTWXn431CMWk8YZEm9dGYf4wKP+Y5M//RnFuwazkXB4ocvHddvPdyuQdZqtUzfzQ3zMpauqOoaMB5uYnsfXV8OJRPk+1KUFl0zBJq8009p18EP1Mh8Li7E+qkFI+sOpZr9o78rbsTQR4KRYcOg7kCrNAFHOICRWGhv9bXsxg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737708943; c=relaxed/simple;
	bh=I4zc+GDlkJq0kjn0QGdEfFjOTkfwCf4rjCvQ3LksqbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIL1m10TPWH9wONYbOdbrIHbUtUQU/A40awhahip5uutz/n95ntS2OgPCkLllwPEQj/BNBo1PJ9npggi6f6vu3nee4y71Enj4wcFzKQT4QlutsaQBpGLZjJUkQoMgkBCmD7ILCnYDhqvBwjsGCgxsiN7SBh3NsfOiU2dPe3m7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj7ac1UE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737708940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJ5vnur6ivKypl5OvBylT/kaODd1J6Q0gXEjA6f2g9E=;
	b=Bj7ac1UEtDm4NaQzxJ9Yh9LsAwOgHaHINJCoHOlgOp0YKr+ibz/C3Q0kP47OIktfPhp1Y0
	qoSLxIcgyzcHO4kUy3JU0i4RdhGBVSflsDBbH5qXQLh+0XnNJ5COzzvuKm40ue+in0wWB7
	W063Gdb6NUbWiScwouO3oc0o+Mbyny8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-dn8YTT8MOzeb5cwPQCJ_zg-1; Fri, 24 Jan 2025 03:55:38 -0500
X-MC-Unique: dn8YTT8MOzeb5cwPQCJ_zg-1
X-Mimecast-MFC-AGG-ID: dn8YTT8MOzeb5cwPQCJ_zg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362f893bfaso9907835e9.1
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 00:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737708937; x=1738313737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ5vnur6ivKypl5OvBylT/kaODd1J6Q0gXEjA6f2g9E=;
        b=vqg+CKgfFa1aAMB/e/J90il19e0KMiMLzOkCGnR3zE0WD5RMYKYf10LhH26uxe6ffu
         X31BLjmXaqvxaeBAw9HMfdl58OaZyGtrvLtNseyNLEAcJke7mXYrxZWRlB0d3mn/uquG
         VWFdhdTM79U9uqH9CUhCNmSDnlzYPJaH53IpIQHdSw7mIZxXR216oqd+syAeEGfHJ5dT
         mOyrNwguWvw36yJrbU6Y3ik2OLiFgi5jbrclIv+JtPjrWdNR0LxhiGolZf0Zoo23XHIp
         CtgUDFqDSKK8qPtmyXndhM88YSdoOAEdqqyvJJR6PtrDHq8RKFw6DIMdHz2wAgrvrevG
         Rjdw==
X-Forwarded-Encrypted: i=1; AJvYcCVzF9YPQZeKxkC+xNjF+5qHcWrGgkRqa+NMG8e5+rgHkVoe01y+NWyYWGyfYSYUykgNyP7aFqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3mPpG1L1nhiqXd//ydu5wI8sK/12JZcV4V6ayrRNdWOWa9c0
	LA1nSyhqhD/LkRmQ8aXtaW9T3EnO/3WaVlIf4bHQ8EmEhrSzW4N35GMS7EocgoUeIGnlhD3kqIu
	aail5jBXjTacW2Kzn1nXyu0PimPQ0pynW/s0/K8DjimYDMi8uLIAYiw==
X-Gm-Gg: ASbGncsSd2JUnBYyaF9V2yV46Cxch0/QHzmPuDUacysAAsY7sd1gGodeyUgKzmmg8WO
	K2qdfVxexxACASGO/lQpEYX6E//SecrWo8GEL2K+r2wBt6DZlF3Eq5O4286iuox5/Ae3Jd1ekps
	SLre3QWap/lMiVu8uS0yEDexCqlPrs5Ey4MBQZ88yQnsXl6XZABxusdb41kFVgMXrZrzt3qIQDl
	py437Rlsr+alnQymG3xLI/eVrtm++g5UFVbjnw8r8FQQ/5yhPmp95LWmfptS5oUtSWCXSzF7BCl
	tlkWHlFir0Vk1RsnaGsEdv/N
X-Received: by 2002:a05:600c:5112:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-438913cfa0emr264459695e9.8.1737708937653;
        Fri, 24 Jan 2025 00:55:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfmM6GfCiAFk4pevsjFhOC0ZvAd5ss3nZoYfZj1WBbjYY5sNrz2rPYAP0gbrN+34XDRTj5vA==
X-Received: by 2002:a05:600c:5112:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-438913cfa0emr264459545e9.8.1737708937322;
        Fri, 24 Jan 2025 00:55:37 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-186.dyn.eolo.it. [146.241.89.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd5730a6sm18388535e9.35.2025.01.24.00.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 00:55:36 -0800 (PST)
Message-ID: <637049f6-f490-445b-8493-218b68d438a3@redhat.com>
Date: Fri, 24 Jan 2025 09:55:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/12] Begin upstreaming Homa transport
 protocol
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250115185937.1324-1-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 7:59 PM, John Ousterhout wrote:
> This patch series begins the process of upstreaming the Homa transport
> protocol. Homa is an alternative to TCP for use in datacenter
> environments. It provides 10-100x reductions in tail latency for short
> messages relative to TCP. Its benefits are greatest for mixed workloads
> containing both short and long messages running under high network loads.
> Homa is not API-compatible with TCP: it is connectionless and message-
> oriented (but still reliable and flow-controlled). Homa's new API not
> only contributes to its performance gains, but it also eliminates the
> massive amount of connection state required by TCP for highly connected
> datacenter workloads.
> 
> For more details on Homa, please consult the Homa Wiki:
> https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
> The Wiki has pointers to two papers on Homa (one of which describes
> this implementation) as well as man pages describing the application
> API and other information.
> 
> There is also a GitHub repo for Homa:
> https://github.com/PlatformLab/HomaModule
> The GitHub repo contains a superset of this patch set, including:
> * Additional source code that will eventually be upstreamed
> * Extensive unit tests (which will also be upstreamed eventually)
> * Application-level library functions (which need to go in glibc?)
> * Man pages (which need to be upstreamed as well)
> * Benchmarking and instrumentation code
> 
> For this patch series, Homa has been stripped down to the bare minimum
> functionality capable of actually executing remote procedure calls. (about
> 8000 lines of source code, compared to 15000 in the complete Homa). The
> remaining code will be upstreamed in smaller batches once this patch
> series has been accepted. Note: the code in this patch series is
> functional but its performance is not very interesting (about the same
> as TCP).
> 
> The patch series is arranged to introduce the major functional components
> of Homa. Until the last patch has been applied, the code is inert (it
> will not be compiled).
> 
> Note: this implementation of Homa supports both IPv4 and IPv6.

I haven't completed reviewing the current iteration yet, but with the
amount of code inspected at this point, the series looks quite far from
a mergeable status.

Before the next iteration, I strongly advice to review (and possibly
rethink) completely the locking schema, especially the RCU usage, to
implement rcvbuf and sendbuf accounting (and possibly even memory
accounting), to reorganize the code for better reviewability (the code
in each patch should refer/use only the code current and previous
patches), to use more the existing kernel API and constructs and to test
the code with all the kernel/configs/debug.config knobs enabled.

Unless a patch is new or completely rewritten from scratch, it would be
helpful to add per patch changelog, after the SoB tag and a '---' separator.

Thanks,

Paolo


