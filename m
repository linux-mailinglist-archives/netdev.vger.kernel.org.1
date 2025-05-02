Return-Path: <netdev+bounces-187486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478A7AA76BB
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44ED41C05D8C
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A125DAFA;
	Fri,  2 May 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="piUpZvaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497125D544
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202119; cv=none; b=uNzBJNRDw1mmjRdJmnXw0y0PQ2bHEqtvAGCnx3TW/5UWi4aPnZAFZA58zUixOB3NtGhf8SMAcMtTGo1K1ZSTg3QQTW5lM7PjuEeaDxZhC10PcLWKnkHdFVvXMU1RpVxec08njyInwdKHQ216oMKEDF5Veg3MWdN3q88VgUXUvwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202119; c=relaxed/simple;
	bh=qFW90J9T8RJ+7GYrvlnNFaoJarkTqvcieznVTo0kQ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUNPuFcOfa27twrJBkMGNVcBA2edgSqzopPF33ubh3EfFJ5Kr6FrJgqZdGWUeK+zug4ZL89tO+LORznjJlPGVngf7VZcOMmiacyabXq66kh/dkTVrhu23780KqV8WriilYa/+Ktfq/UvTZzFuXV9EDQSQfV5VSmnwqAp+GdqYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=piUpZvaz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224104a9230so3660485ad.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746202116; x=1746806916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj3NocPP0YximFiD8TQzgbDDNI2dofYflmIdPP6lA+Q=;
        b=piUpZvazM6bIO/u4AQnv+Oir0bi7zRpTo4vbWpksRqYNKyuDw9llfKA1DoWtTtR/wd
         Cp/8+JJpPSMd+L+IJ2ip7fvgjZVJG2s24jHjw+Dgh52kKPyDN6IUdbvD5fxMMyxWDYzK
         XsvInhh2bkDWdAFdGB7HwUSg6bbbmx7RLATPrc20yU79W8rilQ2Dp85C1dMu90nEiKHZ
         uVSh8SS1Kn9Ol9s9s7VzeDVajzvPIuP5GLbamX6cggzi/3koGsnnMICdu5QKxSaPsWIa
         +iky5jafM+m+aYTv8Q78ZqZjwAwzvPpDTI64wLNzrRe/MsbIQRO4a39+QLQzfPQMtlBA
         gbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202116; x=1746806916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj3NocPP0YximFiD8TQzgbDDNI2dofYflmIdPP6lA+Q=;
        b=GLLsHF/rbh9mK4Z3BhnJHz2V8lqFcj7cAz7qG0SvA/U+pROI/aoiz9UWguuH1ynZcH
         FzFclzU1oDssupoy8AlamCH0zuDIdpzO9bJeJeI1OAcgmiiRNSzun+Nl1gy8GwtdGYgs
         FKaJa3CqwzBLe7SM4NFd8khnBMSAkpYOR6Q2PZlNERXPKY9lnHysXd3qX3qIsgXa0JfM
         tbfiaNsaZHRYugP0JmvxqEUNSlcnu6n8g8P8fDHckWh8CuyBf8KIMr885QW5ACUOFkeu
         VVhK2S+JEAMnLopT69rWKaJ/YJrbBHQyp9tkvHyt0ET92ED31cjyb+w3w1YIlOK7oCf1
         wJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqzjrEd4s4DtWR7L8e3RH/FrD8cc114YrmzC/RlxSuwmez7ruaSiY3Vs9fyNYczArW9AMBZt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUiOB7kR2yQv2NlIYJgPsBG2ZOISxa6U8zifSZsTKEdXKC3ri
	DIspNhvZbmAFpdw7PUml1Rp+7iTstOhBllquEki1Y4lZeNQG57PthT98O9obY80=
X-Gm-Gg: ASbGncsPj61M/NRN2Zafitpq1huRjjjS2cSMm4/O4VKlTqFq1u1xJSiNVEmDDtJsHtD
	Qe8FmgpvIgT0dccXz7ucGFrNpno1Nd+G0bbWOopaqQKll4b37ELovkcQzTVBKKIHGXdJaGJ4YcS
	q/QMDKFpK2HkWt9KTCR5Dfzm8Aa/rinjpuAI+UGzEYBImHhYkOSJu8ni5N2KsG1mituO7VFWHRb
	a2CTvCca/5b0I1bLufFkes8XvIgCVUOri8M6AOG2WBeNvAi1aFtlTJphJ9zASvSZL9cFfelSgAQ
	9CAmCbV1smtOVTA2woaaF3kWIKI=
X-Google-Smtp-Source: AGHT+IEx2hIRACQD4vGbjeB7Sd8QKVmVcIAMoL1DlBjtzG/ltHk7Rttj9zTdUNlhvywKnKU5ZyPKYQ==
X-Received: by 2002:a17:903:2343:b0:224:10b0:4ee5 with SMTP id d9443c01a7336-22e10236f31mr21466155ad.0.1746202116504;
        Fri, 02 May 2025 09:08:36 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:7676:294c:90a5:2828])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e98desm9439475ad.55.2025.05.02.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:08:36 -0700 (PDT)
Date: Fri, 2 May 2025 09:08:32 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v6 bpf-next 4/7] bpf: udp: Use bpf_udp_iter_batch_item
 for bpf_udp_iter_state batch items
Message-ID: <a4iluxons4k536rz3ynmlpuaqkjpyi2gt2acm4o7bcns43q64j@f5qmwmg3x5bf>
References: <20250428180036.369192-1-jordan@jrife.io>
 <20250428180036.369192-5-jordan@jrife.io>
 <2ccb3470-0218-4bca-af17-4f9bd1e758a3@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ccb3470-0218-4bca-af17-4f9bd1e758a3@linux.dev>

> A nit. just noticed this.
> 
> Since it needs a respin, rename the pointer from "sock" to "sk". It should
> be more consistent with most other places on the "struct socket *sock" /
> "struct sock *sk" naming.

Sure, will do.

Jordan

