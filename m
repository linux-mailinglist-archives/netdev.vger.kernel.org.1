Return-Path: <netdev+bounces-143450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A89C2745
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 23:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19031F22359
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932AC1C1F18;
	Fri,  8 Nov 2024 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf2PK3wu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D71A9B51
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731103352; cv=none; b=f7/GPcMksYoXHOB/h5O7z5AX5MY3hB6DrSlHJdQMttNy2WLKhTO5Yfn/yJxl5GCR7BOHunq1EqEljCeUAq37+4swwtJqcYq4sBNwE0gd/hcVu38yj14oxJvZIee5woVBZzn+9+xLRwssNdPhOApxwtIGWrGqZ9cRVH/4pOOtwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731103352; c=relaxed/simple;
	bh=CqZzq6qGMQ62OwbNDDKtIvbl3x1rPLFkba9apWi+DN0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qtQ3tSawrqNkpl0EGBkOrfYglGaLTbGAlus5gbZfdOV/jmdxRj2Hi491zOfB9ZjeGugjEFlbW6ITuGE06i45ob/8zWaiQ1Gb530UBRtlPtxyRpHzwbO4gNM2CTDOtFsaLy7JCkPGlTC7CLlsorkfa+UKQKoNNJiQO69SHciIfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf2PK3wu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99e3b3a411so627227766b.0
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 14:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731103349; x=1731708149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJqbvMrSzSpX7WGFpcgBbgpm76Jh4m+xyczOFSVKpBM=;
        b=Cf2PK3wuUe33cwV4TqbvHQ0ukCJHjxM/uGsbp+cU5WrZQAnRAz4F2o0FgH4+oyY5/7
         8CXQ3fc3uH154CgnGB3l/mQHHZ4LBO1p0EAmTGtEvTA7XzuttvmLtsTs28mFkbFakJTO
         MdMJfqSRNT+FfHl+tYgLuShju4ps1I6HZp7vo/PesmcALasbaqnRR9N10iCE8JU6OL8s
         gQN/LSGJTEH89vEG50WJmk5BpM2R/KX88SUDWjjajNjCSb7r1DLywe8LeOVtoIAUQcec
         CUKQVVBTMNep8eRHCT7PlI6DvJqo+1wfVQ0kKWuF6+skr0T1Boyk84BzUXff4goin24t
         mr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731103349; x=1731708149;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJqbvMrSzSpX7WGFpcgBbgpm76Jh4m+xyczOFSVKpBM=;
        b=lVMK7KFU4dzv0Io3S2kzg+XaNoDgYoCrfMViUbx41cc2NG/rgMZgCLU3p6vHPY9meG
         Uf3F3igJMsoU34j7daYMYtQoBCaGmkvNlHjLP0lKjaH+Bzp460freiHrAAfgQ0nGyhCb
         2xAZdJCpWPpNwybZK6/oLQ9hewHO9XlWrFEs99ImszbBe34S9AbeLAK+tPG++Bhccww3
         i8DzYFA6/a+4eTJuHoZ0msIQO1ikBFHULmBgupYZqhQvwAGbLLPowabM2opDonZjkpIe
         SmgsjqgNofLIsYef84BrHrrUjYtDCYE3s+hV20hPKCltIwL0KF1yfn7xpyLz3c4GEuFB
         s57A==
X-Gm-Message-State: AOJu0YwkiN+KZ4zrb8JRUoGFO4NlF7VOA3n1XJdwlSOKZh2vY6FxYurL
	/9URFi/HG3Xyq5AKN0pI43Ia0BHMdRbzeSFl8WrMU6+kFMf0XpCRWCw86Q==
X-Google-Smtp-Source: AGHT+IE84vaQiVIkBVil8dCUmyFvRA0fApQqnFNkJCTMoHxGoplcgFDHFwhbFZ96b14W0fgs2yd7+A==
X-Received: by 2002:a17:907:1c28:b0:a99:f209:cea3 with SMTP id a640c23a62f3a-a9eefeb2a17mr450008366b.11.1731103348965;
        Fri, 08 Nov 2024 14:02:28 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4c60sm288914066b.102.2024.11.08.14.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 14:02:28 -0800 (PST)
Subject: Re: [PATCH net-next 01/12] net: homa: define user-visible API for
 Homa
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-2-ouster@cs.stanford.edu>
 <174d72f1-6636-538a-72d2-fd20f9c4cbd0@gmail.com>
 <CAGXJAmxdRVm7jY7FZCNsvd8Kvd_p5FPUSHq8gbZvzn0GSK6=2w@mail.gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <6467b078-4ee9-ecb2-6174-825c3a2d5007@gmail.com>
Date: Fri, 8 Nov 2024 22:02:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGXJAmxdRVm7jY7FZCNsvd8Kvd_p5FPUSHq8gbZvzn0GSK6=2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 08/11/2024 17:55, John Ousterhout wrote:
> This leaves open the question of where these
> declarations should go once the userland library is upstreamed. Those
> library methods are low-level wrappers that make it easier to use the
> sendmsg kernel call for Homa; users will probably think of them as if
> they were system calls. It feels awkward to require people to #include
> 2 different header files in order to use Homa kernel calls; is it
> considered bad form to mix declarations for very low-level methods
> like these ("not much more than kernel calls") with those for "real"
> kernel calls?

include/uapi/ does sometimes contain 'static inline' wrappers.  But
 declarations for actual functions that need linkage are avoided AFAICT.
The expectation normally is that userland application code will #include
 a library header, which takes care of #including any necessary kernel
 uAPI headers, ideally packaged separately from the kernel rather than
 just taking the include/uapi/ directory of whatever kernel is currently
 running.  (Back in the day there were some classic Linus rants[1]
 warning against the latter.)
Then both the helper functions and their declarations live in the
 library, where they can be linked into the application, and not mixed
 in with the kernel headers.

> Do you know of other low-level kernel-call wrappers in
> Linux that are analogous to these? If so, how are they handled?

The closest analogy that comes to mind is the bpf system call and libbpf.
libbpf lives in the tools/lib/bpf/ directory of the kernel tree, but is
 often packaged and distributed independently[2] of the kernel package.
If there is a reason to tie the maintenance of your wrappers to the
 kernel project/git repo then this can be suitable.

But I'm not an expert on this, so I hope someone with more experience
 around uAPI stuff will chime in.  Might be worth CCing linux-api[3] on
 the next version of this patch.

HTH,
-ed

[1]: https://yarchive.net/comp/linux/kernel_headers.html#23
[2]: https://github.com/libbpf/libbpf
[3]: https://www.kernel.org/doc/man-pages/linux-api-ml.html

