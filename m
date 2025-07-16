Return-Path: <netdev+bounces-207442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E0B0747F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302717A73DA
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D8D2F1FF2;
	Wed, 16 Jul 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2523PTZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097F233156;
	Wed, 16 Jul 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664794; cv=none; b=u+/BBbJyTqWAR656hH5sZ8GFrMGoPq6g4wW3cWaW2TrxdbvUESeMrQ3GyMkx4EEdPyMtNKiqNxVyoyemsgC8eDzul30iC5zkAEaOL0WmQ3oeBep41lBApy1JDvY5E8eDMxhsmRR8bpNG++n2gNKa/j4J7EqSUuWzwRApdEH+UPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664794; c=relaxed/simple;
	bh=2/+ag4ICElQ4Q+psba2kn0DCArP86wbi55dAl04YbMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFl+tiIXfgRN/iOSXoVtDmWDrUt6YLlq9hhmpV6iy3yvRhm1nLGqyGI+IYDlD4T3O/59p+NiIw5ln1ozLSS6W3W9mCCR8AWuWZaqjtZouYa7mEEP8/pV0QfDEp0hnmS4Qdg9RGu3r8JQMDAlmiTQK+ySa6ZNLLYoeX1CPm3BhcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2523PTZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a510432236so4553252f8f.0;
        Wed, 16 Jul 2025 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752664791; x=1753269591; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2/+ag4ICElQ4Q+psba2kn0DCArP86wbi55dAl04YbMg=;
        b=W2523PTZRimz6GzegdunPa0raB///onXlDqg63Wa3X8qnIYzGtcDlsPSF6BeO2YTqo
         mhlCd/4spZQWbI9/ERWHR34SRH2VL17zfREhqBiC8xG915f+ACsYG8cZJBQH2CAbGhzN
         x2ZnO2GJhQUbaGNguK3b0j6o2ZTjVQa7+ogB4EO9gLzuCWQa/S+Vfq20kSHMpN9D1zYM
         5EZG+rXOToOlL8YIJgCIChdtAh1+Txq477FC5ECYuWUYBZYH4HiYf55fVO2yBiEgGl8S
         YlOEUArliWbMZY57wOJhoWa9CHoMR9hYntslzUCmps3HKZ1XJT/du2cQe/tDHq3sX7il
         uG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664791; x=1753269591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/+ag4ICElQ4Q+psba2kn0DCArP86wbi55dAl04YbMg=;
        b=V6lNybmULSlfVZIoF06lLNbkY8rxUYDDaDpBmDgWFe5XFDRkWymhazyND1+v2lObFW
         3nGVobTstaj2trGyLvflQf/2SZdhi6ykzd0oSLvaRrXolESjZIvrjZlYYKKw+aBFPOwE
         TiPAk5sifNkvQUNPKCOJEos5si7839d4vW4W9OwE1gphNqpEknGZBY1wF9DunmD8crl2
         BhhHQVhzwZeW1YzFGJ22TEKluLVSS6yeGPe+/NHYeWcDsr3xXfDsjDUqaLEO2evsqnKR
         1KmFu9U86VeG8O7y6+vjT59eQQoYGAGQwF/I05fdB2aoHOedQqxQBmz1MQCIg94yCMO8
         bEtw==
X-Forwarded-Encrypted: i=1; AJvYcCVKE7m9gygTBrN+EhvgFvCWDkzdefCJnAXUdA2s3LsbdSPSQtba1xXjdcPqJ8Hkmd/QPmWm9uKnCdWLgZI=@vger.kernel.org, AJvYcCXQfToSTjUPDqRD/j3G0cz2DtyGXQ269xFvbGDlrhvbwtD2XSLJRHjWZNiH/6IKnLbOlKceDmss@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGl0jWPmvoOWw+ZhmAn+2eyl44SO0+e6NiUKrPlyh5tzbUEOA
	DrStYspZmGOS2pph303pt8lKUs/2OAISPDBFshraVfdJquUqGouBATa8F3jNwV8Z
X-Gm-Gg: ASbGncvNRgOkRIcahvVaKupM5N3PLr1NOqtSBfu3QAic4cFD8GsoNe81Q26JVfK2ePC
	pxjM/NXWpp7xvrz6S5ZKbi+u2LGncQMnem+N0JrCpNvqT9d03kvcEMk7yYTwZw9sLPSpKtCp0Hs
	QbLJoI7m9f6HmBBiirNmuIHFwvb1HlthNDHVqT5JdZirMkbLJiv9cWyHhb1cFVo/o32oNq1T/4z
	MsoujpghxpWemMw81MQINozuezX0W9M2fRvg29nH5q3dxz6/B/mXPZjZ3fElE0Sp76p2oO9dh1n
	6evbwosWRhVIRh7ZTxv7DKaddMMFzzSTQNJuYzX+kiU4FZYclnMY2Lm11dGzVBMrKwS6fuDzeYf
	tdoI7cmYwTZzEjlDlGe4MBVi5Rmc=
X-Google-Smtp-Source: AGHT+IEEr4ccM6coYKotowH9Jy+jQdG6I8S+0YrbO7kBD4j2w1Bq+V1+s8bEv2nneyGcNP2dL1rKJg==
X-Received: by 2002:a05:6000:200e:b0:3a1:fcd6:1e6b with SMTP id ffacd0b85a97d-3b60e541208mr1962478f8f.57.1752664791151;
        Wed, 16 Jul 2025 04:19:51 -0700 (PDT)
Received: from [10.22.59.228] ([131.251.24.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1a2bsm17836414f8f.14.2025.07.16.04.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:19:50 -0700 (PDT)
Message-ID: <9ba42e9ae61e8274bf5d677f8d53c84f6841ccd8.camel@gmail.com>
Subject: Re: [PATCH net v2] et131x: Add missing check after DMA map
From: mark.einon@gmail.com
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 netdev@vger.kernel.org, 	linux-kernel@vger.kernel.org, Simon Horman
 <horms@kernel.org>
Date: Wed, 16 Jul 2025 12:19:50 +0100
In-Reply-To: <20250716094733.28734-2-fourier.thomas@gmail.com>
References: <20250716094733.28734-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 11:47 +0200, Thomas Fourier wrote:
> The DMA map functions can fail and should be tested for errors.
> If the mapping fails, unmap and return an error.
>=20
> Fixes: 38df6492eb51 ("et131x: Add PCIe gigabit ethernet driver et131x
> to drivers/net")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
> v1 -> v2:
> =C2=A0 - Fix subject
> =C2=A0 - Fix double decrement of frag
> =C2=A0 - Make comment more explicit about why there are two loops

Thanks for the updates Thomas, LGTM (also CC'd Simon who provided the
initial comments).

Acked-by: Mark Einon <mark.einon@gmail.com>

