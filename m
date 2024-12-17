Return-Path: <netdev+bounces-152585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6E99F4AF9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D258B16CF28
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943F41F03F1;
	Tue, 17 Dec 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qul2Xkte"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341712C475
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438758; cv=none; b=GHOtJaEh0bpDQqIMLO2TOUoEg6BVg6uDw4Ajz7z5iuj9TFTD/jQ3XjaoMPn75fTUXdRkJQu6liLmKCuYg5Wm8yUDno8P/ybNda3KARzAxMmX+jydCSf0UroeBCnYlcoWfyMUUildk3BLx5BVDI8xX6OQsSOoT9SFFwZtlJar/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438758; c=relaxed/simple;
	bh=YbfDs8LoY5asKM7zZM/qu8gLr3JGUTt7arQC8J9od4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px0SaBXtkv0JXKR3etqx4aF0aC+JcBvAWT+fSDrzxbvFUuQ6+vzyMsyXB0beZxnTvJSAkr+Q4kdKJTspGrFxj7r/eJHENEfGMaaVBEHp7ip0APOFf8rh1E9hSG4sVwdFjs2YLCdqYMXq17XA6VMzo5meO8TPdjlGO58k0xLzMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qul2Xkte; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so2114271a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 04:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734438755; x=1735043555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vadTVklg9DZ5KZn/j1FjuzNmgd1jDV/1Li8ndKsd3tw=;
        b=Qul2XkteNGKGuQGn2HWKJC0pzrkQhXq4k9nAgHHAhL1CeOEoBx5Wr3FfWpsXjffc4r
         t8MqNdhX3kjOpCrCCyY8MZ8txcn3F4Bry7Ibbb6vQ5osDMq3qOigAaxpPJCn28UxiyQD
         aibyBkIntJZr9HIbTgGVWHm6pcWTGq+usDYHh8kf01Z0GXKCOaa6DFmh4vF2DvQwikbw
         N+42qhZothYnYNppq60Y5ASH8oMBKwsNazRXdyBaRzW8xk4HvtWvGqIQFBM/iOI+IpHa
         tUYkhUIgwcb2faqdMZKBjIZP04rnBQLh1qpiIglkGQReTgfbNmM3IUh2p1mHQit0qYPi
         qflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734438755; x=1735043555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vadTVklg9DZ5KZn/j1FjuzNmgd1jDV/1Li8ndKsd3tw=;
        b=A0nAwFtjRM+34gKVhc0WPd1awBez+JSAdtsB+GBSWveBwJzNvFN1n4avLgQD/Ngs1c
         iVXWoLHbAxl55lpelptHfd89by7pfEG9KtMHK3G5iFhwKi0NjUjlePZ6cGzpJvME2Ufl
         fHObJD77dw5jsb9O9bLzAnjhRceIFw+WctdpwW+SowiGgHOl6r05Emowzzh6wX0QB4ep
         oe5MkOuGcQSN+8yEHw7aSGK9/jIkCvA8o7mwpk67MsM3ojv+C8bcCC+r4HMGrjUhyQvT
         uxXkziRYlLorbdPNsldF0J8GFXhxZ866u1DOafnDMmA7evMFeAUQTDl85G/Z1ByqPdd6
         1Wiw==
X-Forwarded-Encrypted: i=1; AJvYcCWXzsSmGWviBa1vBMBEZPzjWpvXPNFk0z5yrDm0yiSt0kyka0MzzzUV6D1hEixvjppeOpRz1QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAflrVw4KaXbIyHsUZwvGDTcnb1sqhrnoNORChIv6KPnaLGk5Q
	/Qh1gEA7rlDYvURTb4dvzCy5wEvHdj3JFZA1BQGQ6UqgKleFGUHBrB0GkiHDQUs=
X-Gm-Gg: ASbGncs/Hpi2Tt9mpf3VosK7WTeC1n+OeekJCh5FAQanSUJaDpxOhedlvHQTx0n7G5O
	OmzrobAfqM6MQVCTA4h/BZ7kPwfTRo4V0MVeYCjjQofD7rGpV26iha73xiETK163CcwLOGUm1bW
	sXkKvuP+4slR88s/jCcpFVikP3Hy/epQ2noDfA/3QBmLJmtVFyajB1g931e/1eb0rnlik+keLUZ
	miisC5xf2N0c7GoaDILcG5A31UqR0nR8lnLIj1WEjFldgnREFrZB7GInuU6Mg==
X-Google-Smtp-Source: AGHT+IHQ03iEFjc/Teha21bLrHNLnNIrRs6fDpiX/v4CZTbwJmuV1NtVhgiSm8VrPkB6aW1UmvcDog==
X-Received: by 2002:a05:6402:5288:b0:5d3:e8d1:a46 with SMTP id 4fb4d7f45d1cf-5d63c3bf48dmr17438136a12.30.1734438755313;
        Tue, 17 Dec 2024 04:32:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f271a6sm4407073a12.60.2024.12.17.04.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:32:34 -0800 (PST)
Date: Tue, 17 Dec 2024 15:32:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] xfrm: prevent some integer overflows in verify_
 functions
Message-ID: <053456e5-56e7-478b-b73e-96b7c2098d07@stanley.mountain>
References: <92dc4619-7598-439e-8544-4b3b2cf5e597@stanley.mountain>
 <Z2FompbNt6NBEoln@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2FompbNt6NBEoln@gondor.apana.org.au>

On Tue, Dec 17, 2024 at 08:03:38PM +0800, Herbert Xu wrote:
> On Tue, Dec 17, 2024 at 11:42:31AM +0300, Dan Carpenter wrote:
> >
> > +	if (algp->alg_key_len > INT_MAX) {
> 
> Why not check for UINT_MAX - 7? INT_MAX seems a bit arbitrary.
> 

That seems like basic algebra but we have a long history of getting
integer overflow checks wrong so these days I like to just use
INT_MAX where ever I can.  I wanted to use USHRT_MAX. We aren't allowed
to use more than USHRT_MAX bytes, but maybe we're allowed USHRT_MAX
bits, so I didn't do that.

regards,
dan carpenter


