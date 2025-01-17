Return-Path: <netdev+bounces-159377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2C3A15536
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8122D3ABD96
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2990B19D897;
	Fri, 17 Jan 2025 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ERAO0Jzy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6019CCFA
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133396; cv=none; b=Gsx3MaGOU7LLkTQgHtsTtbwhIuY3Y4tIe1kz2jrvr6t8Ocxtchz0rd9rMxJhjBLdIHVrGEKqcC7e6hEMmn3Te9vlw1JcvpwhQau3ZsK9iW7PPLA9GBrV3jQumPN7yXXF8xGRAM9ZlCOJBtQQEb8sRdm4xcrpwyk8Gy2WAWHSE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133396; c=relaxed/simple;
	bh=XA1/LyR7u4W8W6O48ZBVWC0Qmv99vriM6azcwXvbo2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsE+scm7NIlZce0jXPJYT9TWHDUeK2j53YrY8YqZWCMzwgYGQxYaFPqAn5zyzaUAaIEc8OmkLgz1fvKuyx1Ry7sxhTxtfQsWuj0CiFPSt1cnhfQPLFm0stVaAwp3z3H3PtSyXMPWKfVJZgiU7hFeBVyvQwmgYlYid4FWzbywa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ERAO0Jzy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216401de828so43900135ad.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 09:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1737133393; x=1737738193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIH9VsizP/8w9NZSwqiQxoCrHEIlhh7ljYKrWePIAV0=;
        b=ERAO0Jzy5v195UmmVwJQpEf1Tmjcntb7ZKgF/XAhMoDPXxGTD2cRD6dKsxXAbgApa+
         wn6qiD1PCyjwOKi3np1FLzddhYqoRPEGALKf3laA6e4vbgPwItE+sgGZHoRFMq4/oCiZ
         YcW6us2up6qr0VC9hOSME/B2eNxl7e6+9gEJAnTcJsjqC3K8Y7eM/9Kk+kmqYt9Vzpn4
         UYNfZFPNeqBWWbX0wDgt9XtOAlAc86UTP7AODDEoFptrMxd396WwKGgRrZJCufep1ulO
         O/bci0PrwNoxbB62ML3ZmSdTzgbKLSZDelGndfunvSu4VDE+dAR5KceYPr+Ydf7oBtia
         3OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133393; x=1737738193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIH9VsizP/8w9NZSwqiQxoCrHEIlhh7ljYKrWePIAV0=;
        b=bQI5aQdMzyilK9jnb3OAFawDHLR+sGPYg87QmzlGrtZ5hY347e+BWbQUi0Xmxv43Dy
         ONekf/I9Lk44WzlN4hlkrNPFa1qmkF04YCa3STan4go0cMpgpURKJ7fHTHzoHGQSinSD
         EVHcvRMSQa8M2aXHi5H6uvrcFcZsF3tVV9rRWQBBGdFH1v02jCjYgV1+WlmXuRgG0eEt
         mvTDJhVxT/gMTm7qIws8Nju7NIFsXaPWTWJjDJoBdvHyHxcvGeiw7SiAepuXYwCnzU3Z
         vY5xF6//ZQlui488fA+pI1juQlgyUEn0Bm/ub71aOUpsExSrMKj/GJ48v34MM/Nf+yN5
         kxNg==
X-Forwarded-Encrypted: i=1; AJvYcCXlm20xhaXF+boHTAPhKldcwYYOfPf/GCzdkHxrtId3lHAPtfH3zKteRpee+22AexN+7JVmvuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XIE4GmEA/478ygzdTRaNNLxRaiHqabSuZnrIvdxDBeAeFmHk
	0yVEbS9R1frq0qnWHc/u4raFpgsNn62db0+j2tb86+dYzJVG4YiFyoOhVF0l89Q=
X-Gm-Gg: ASbGncuf7pQOJPvp5dd2CanHws9BpJBL8vAOuehiRQhw0BWG3XLoYtL2cY7a/glRTKJ
	nBWCq/8UroaM5yCg3m/+prs6evOYYes6RZDIpKP44dvtEyMZsTeBoC7+c96ZwJcQ0C7bnynbjd9
	eOBE3I5mNdIRjBc80tbCjDopafRJa/o7ZIeZ3vZoShSjnIE1MBxYQMDN0vtWr77/ISM6/n8UOPv
	yd+wPuYDWwPAtYzgrOudhDyAKYzWpiTZ29CaZC+nQQrVFsovXkd/nb8GVjtLneNsZTyNgsQqFdy
	VMUzdvf7olA9vmhMNtQ+CO7yX8CjlAPcdQ==
X-Google-Smtp-Source: AGHT+IFEACbR0f8fZJrd7tkhnbRGpeniqbFuAC6O+A43w/jeP6yQpR26+tRixIqrPvffIqZka73jhg==
X-Received: by 2002:a17:902:dacb:b0:215:5ea2:6543 with SMTP id d9443c01a7336-21c35546dcbmr48179695ad.28.1737133393527;
        Fri, 17 Jan 2025 09:03:13 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb767asm18644335ad.84.2025.01.17.09.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:03:13 -0800 (PST)
Date: Fri, 17 Jan 2025 09:03:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, gregkh@linuxfoundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from device
 attributes
Message-ID: <20250117090311.23257dcc@hermes.local>
In-Reply-To: <20250117102612.132644-2-atenart@kernel.org>
References: <20250117102612.132644-1-atenart@kernel.org>
	<20250117102612.132644-2-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 11:26:08 +0100
Antoine Tenart <atenart@kernel.org> wrote:

> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 1f4d4b5570ab..7c3a0f79a669 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -80,6 +80,12 @@ void rtnl_lock(void)
>  }
>  EXPORT_SYMBOL(rtnl_lock);
>  
> +int rtnl_lock_interruptible(void)
> +{
> +	return mutex_lock_interruptible(&rtnl_mutex);
> +}
> +EXPORT_SYMBOL_GPL(rtnl_lock_interruptible);

Is export symbol needed at all? The sysfs stuff isn't in a module.

