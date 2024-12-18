Return-Path: <netdev+bounces-152901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF899F6421
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24ADB169DE7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E9419D071;
	Wed, 18 Dec 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtPXTwQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C619E998
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519285; cv=none; b=RG2b5YpkbC51jksGv0Bx53S12tOquaqj5VHFkYZ5LAtfeWDS1uBAzGdeK97ifSnUlTafP5gdap9fLfMz/PXjbqzMGTXa2RptHvfI7ZSxn6Rad0M7Hq32AyVQR1j6oulReRWYQdvA87vZhcuMgeY/7bGoCIIA1r63w+X0Gls+ZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519285; c=relaxed/simple;
	bh=31AJvFncyDZ/FXq2NhVl5iGwRm7DlmYnqi4Ssp7vJGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4Kt8D1KJNLwEx1jneAgLxBHz5JXzCz3P1WeTdQseTSIH2xokejVoX9dlHstvd8qXZyApdvmnJMZ0iKx6Kro7UmrZ4/NxDqQVrisHsxGGzsyf7+hA+06SVGZOnmn40pr4nskLkK3QvPWDn1KVQ55bmjZxdjyVNHfqMeejXqYGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtPXTwQO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso11465437a12.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734519282; x=1735124082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhTokHP9skR7jJeKPK9CVtZx11UuslYBY9BBg+qEOjA=;
        b=rtPXTwQOcdOhb9yqKuMmBbwMgp+UI8vYI/v0419zOm2xRkHD7jt1obZ6FaBLF5cive
         ZiFJDWgoogsL5UTN5CkxAZzAsjYc6ItrK5lw3MfM5tFRiipDpjxImNHXKEC0OKkstz8c
         y1C00kv0OZhwGcto8F8nAmRRiF2gbth16ndCJVdCVoEDyBL46x3qG0Q5xbBN2KvRBRBy
         9GAR7k/dBaSjOmLEuTTwQHNP70Qz/8JOGga0AVj0Xhw7E4lM9uS+4HqZAxt1kLzkbkuu
         W+OXX1lwJsdPXCgla9PT0fhZBeA/v2xY7y1qatlOGMBBzCCeE6gcfmeKRejWIbvvZmRI
         YVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734519282; x=1735124082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhTokHP9skR7jJeKPK9CVtZx11UuslYBY9BBg+qEOjA=;
        b=ltKDXDpiBKFa0dpCFQS7lYJIunLAHePJ805TZKihkQpfcaRy1YTtd9Nx8dzOP6Al+y
         MCni5lbDMPG9Hr6yR01+zu5GtFrB25IACwGqwMmejQlQAJUUlMZnaUYJ4yRK6M+S62Vi
         yMfWaI3CZx0+5TR1Gh9hS0Hw9IGh3olKbq/XHGp5ZsZPKAbd1rDKmPYOB52WDtYF2jWB
         95LVNDzhpzO07vYXtqYSY4EdCuUC29zueUUgJHY/qkz8y8qK6feOcCbHYBMCWeViPtD5
         YXUaqZ4cKHRr6HJ5w+M354zBYX/1gZ97duDd/+ycqYd1cSu2FnJnlDzJbfoV0qwIIBli
         LtTA==
X-Forwarded-Encrypted: i=1; AJvYcCUyTFuST5YG9IgZ6MQmsJoWOc7Nj07tZ/h1MyytHoP4hSy1oDUQmCGbRtM53qV9QDU5orzeq9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZ+Vzbsm5CIIF3PRmUrNryqEIGRdiI6YKbXm3fR9bmFXR5cLb
	RsJRmAXRxrSnvTkYMwOi2uZ+ZmXWA0BpmTKepFD6QthVPjstj9nE6TA2ZdvpiRQ=
X-Gm-Gg: ASbGncvm9KBh4Y3raQlNEXGvkMuJbbUqB+T5bNZIIc89gdeiwHC9Qz2WtJlxSjNEh15
	D635z2H8FulqEIc9iLS7UFLp5V7PsGimYs30LYcS5Qrdph9KCjRExGjk84jTvGhFt9Lh/8kcErj
	H/XFeDZILJ21RiQD9uBm+rJjGOrIvizS8hbrimI5vAB5AJwDrXhJBQIc7TlE0gRvpD0Bl0L6tPl
	F8+e2vEEQB2VRziCJrf7WxKPL1yHNgjHwn5wh2jyufTEwzm8RG2Iwfl7+RKhw==
X-Google-Smtp-Source: AGHT+IGd9c9NZz2gvokmKM5Dng3BnFozJjkFoab/PE7l5nl8JOL6hBsbbn1h4w3R6/1qrT9lM4LqKg==
X-Received: by 2002:a17:907:3da4:b0:aa6:8fed:7c25 with SMTP id a640c23a62f3a-aabf474bb0cmr240635866b.16.1734519281678;
        Wed, 18 Dec 2024 02:54:41 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9606b3a0sm540413066b.81.2024.12.18.02.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 02:54:41 -0800 (PST)
Date: Wed, 18 Dec 2024 13:54:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net] xfrm: Rewrite key length conversion to avoid
 overflows
Message-ID: <cedbaec9-d149-48af-8068-182f0af5a89c@stanley.mountain>
References: <92dc4619-7598-439e-8544-4b3b2cf5e597@stanley.mountain>
 <Z2FompbNt6NBEoln@gondor.apana.org.au>
 <053456e5-56e7-478b-b73e-96b7c2098d07@stanley.mountain>
 <Z2KZC71JZ0QnrhfU@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2KZC71JZ0QnrhfU@gondor.apana.org.au>

On Wed, Dec 18, 2024 at 05:42:35PM +0800, Herbert Xu wrote:
> On Tue, Dec 17, 2024 at 03:32:31PM +0300, Dan Carpenter wrote:
> >
> > That seems like basic algebra but we have a long history of getting
> > integer overflow checks wrong so these days I like to just use
> > INT_MAX where ever I can.  I wanted to use USHRT_MAX. We aren't allowed
> > to use more than USHRT_MAX bytes, but maybe we're allowed USHRT_MAX
> > bits, so I didn't do that.
> 
> There is no reason for this to overflow if we rewrite it do do
> the division carefully.  Something like this:
> 

I like it!  So obvious in retrospect.  Kees, Justin, this is probably a
good strategy for dealing with round_up() related integer overflows
generally.

overflows to zero:	(len + 7) / 8
      no overflow:	len / 8 + !!(len & 7)

> Steffen, this raises a new question: Can normal users create socket
> policies of arbtirarily long key lengths? If so we probably should
> look into limiting the key length to a sane value.  Of course, given
> namespaces we probably should do that in any case.

The length is capped in verify_one_alg() type functions:

	if (nla_len(rt) < (int)xfrm_alg_len(algp)) {

nla_len() is a USHRT_MAX so the rounded value can't be higher than that.

The (int) cast is unnecessary and confusing.  The condition should
probably flipped around so the untrusted part is on the left.

	if (xfrm_alg_len(algp) > nla_len(rt))
		return -EINVAL;

regards,
dan carpenter


